var express = require('express');
var app = express();
var bodyParser = require('body-parser');

const { DefaultAzureCredential } = require("@azure/identity");
const { SecretClient } = require("@azure/keyvault-secrets");
const credential = new DefaultAzureCredential();

let options = {
    serviceVersion: "7.4",
    disableChallengeResourceVerification: true, // ONLY ON CI, NEVER USE ON PROD!
};

const client = new SecretClient(process.env.KEYVAULT_URI, credential, options);

const port = process.env.PORT || 2104;

app.use(bodyParser.urlencoded({extended: false}));
app.use(bodyParser.json());

app.get('/health', function(req, res) {
    res.type('text/plain');
    res.send('Hell , its about time!!');
});

app.post('/secret', async function(req, res) {
    if(!req.body.hasOwnProperty('name')) {
      res.statusCode = 400;
      return res.send({code:400000, message:"name is required"});
    }
    if(!req.body.hasOwnProperty('value')) {
        res.statusCode = 400;
        return res.send({code:400000, message:"value is required"});
    }
  
    const secretOptions = {
      contentType: 'application/json',
      tags: req.body.tags
    };  
    console.log("secretOptions", secretOptions)
  
    const result = await client.setSecret(req.body.name, req.body.value, secretOptions);
    console.log("result: ", result);

    res.json(result);
});

app.get('/secret', async function(req, res) {

    const maxResults = 5;
    let pageCount = 1;
    let itemCount=1;
    var result = []
    
    // loop through all secrets
    for await (const page of client.listPropertiesOfSecrets().byPage({ maxPageSize: maxResults })) {
    
      let itemOnPageCount = 1;
    
      // loop through each secret on page
      for (const secretProperties of page) {
        
        result.push({itemOnPageCount, secretProperties })
        console.log(`Page:${pageCount++}, item:${itemOnPageCount++}:${secretProperties.name}`);
        itemCount++;
      }
    }

  res.json(result);
});

app.get('/secret/:name', async function(req, res) {
    if(!req.params.hasOwnProperty('name')) {
        res.statusCode = 400;
        return res.send({code:400000, message:"name is required"});
      }
   var response = await client.getSecret(req.params.name);
   res.json(response);
});

async function start() {
  console.log("Setting initial secrets");

  for(var envKey in process.env){
    if(!envKey.startsWith("INITIAL_SECRET")) continue;
    const args = require('yargs-parser')(process.env[envKey].split(/\s+/))
    var tags = {};
    for(var key in args){
      if(key.startsWith("tag:") && args[key]){
        var tagKey = key.replace("tag:","");
        tags[tagKey] = ""+args[key]
      }
    }
  
    const secretOptions = {
      contentType: 'application/json',
      tags: tags
    };  
  
    console.log("Initial secret : "+envKey);
    console.log("secretOptions", secretOptions)
  
    var result = await client.setSecret(args.name, args.value, secretOptions);
    console.log("result", result)
  }
  
  app.listen(port);
  console.log(`azure key vault api start at ${port}`)
}

start();