var express = require('express');
var request = require('request-promise-native');
var bodyParser = require('body-parser');
var extend = require('extend');
var CAMClient = require('./cam.js');
var util   = require('./util.js');
var tasks = require('./tasks.js');
var cam_refresh_interval = 300000;



var app = express();

app.use(bodyParser.json());


var icp_host = "10.199.103.140:8443";
var cam_host = "10.199.103.139:30000";
var cam_user = "admin";
var cam_password = "Dqm60@vnc";
//var cam_refresh_interval = process.env.CAM_REFRESH_CACHE_INTERVAL || 300000
// e3032294-9f6f-4855-b8a2-a79b61006846 all 00001
// let tenantId = process.env.CAM_TENANT_ID;
// let namespaceUid = process.env.CAM_NAMESPACE_UID;
//
var tenantId="59003768-38ac-41c8-ad03-614e018ebe0d"
app.post('/icp-scale/api/v1/uc1/scale', async function(req, res, next){
    console.log(req.body.title.includes);
     if (req.body.title.includes('Alerting'))
    {

    let jsonparsemsg = JSON.parse(req.body.message);
    //console.log(req.body.message);
    let namespaceUid = jsonparsemsg.cam_namespace;
    let templateName = jsonparsemsg.template_name;
    let cloud_connection = jsonparsemsg.cloud_connection;


    let camClient = new CAMClient(icp_host,cam_host,cam_user, cam_password,request);

    console.log("scale-up", "Capturando token de autenticacao do token!");
    let token = await camClient.getAuthToken();
    let templateDetails = null;
    let cloudConnectionDetails = null;
    //console.log(tenantId +"\n\n"+ namespaceUid +"\n\n"+ templateName +"\n\n"+ token);

    try {
        console.log("scale-up", "Capturando template pelo nome...");
        templateDetails = await camClient.getTemplateByName(tenantId, "all", namespaceUid , templateName, token);
        console.log("scale-up", "Template ID=" + templateDetails.id);
        console.log("scale-up", "Capturando Cloud Connection pelo nome...");
        cloudConnectionDetails = await camClient.getCloudConnectionByName(tenantId,"all",cloud_connection, token);
        console.log("scale-up", "Cloud Connection ID=" + cloudConnectionDetails.id);
    }
    catch(e) {
        res.status(500).json({details: e})
        return;
    }

    let templateId = templateDetails.id;
    let cloudConnectionId = cloudConnectionDetails.id;

//    let input_parameters = templateDetails.manifest.template.templateVariables.template_input_params
    let input_parameters = jsonparsemsg.template_input_params;

    console.log("Get next name available");


    try {
        let allStacks = await camClient.getAllStacks(tenantId, "all", namespaceUid, token);
        stacksize = parseInt(allStacks.length);

            //let stack_id = stackObj.id;
            allStacks.sort();
            let stackObj = allStacks[stacksize-1];
            let name = stackObj.name;
            let splittedNames = name.split("w");

            if ( parseInt(splittedNames[1]) > 9) {
                concat = "w0";

                } else {
                concat = "w00";

                }

            lastname = splittedNames[0] + concat + (parseInt(splittedNames[1])+1);
            console.log(lastname);
    }
     catch(e) {
        res.status(500).json({details: e})
        return;
    }
    jsonparsemsg.template_input_params[1].default = jsonparsemsg.template_input_params[1].default.replace(/servername/g, lastname);

       try {
            if (parseInt(stacksize) < 40)
          {
          let response = await camClient.createStack(tenantId,"all",namespaceUid,token,cloudConnectionId, templateId, lastname,jsonparsemsg.template_input_params);
            console.log(JSON.stringify(response))
          }
            util.appendLog("scale-up", `Stack created... ID: ${response.id} Status: ${response.applied_status}`);
        } catch(e) {
            res.status(500).json({details : e})
        }

}
})

app.post('/icp-scale/api/v1/uc2/changenamespace', async function(req, res, next){
    if (req.body.title.includes('Alerting'))
    {
      //console.log(req.body.message);
      data = req.body.message.split("\n"); // split lines
      bootnode_icp = data[0].replace("Bootnode : ","");
      namespace = data[1].replace("Namespace : ","");
      //console.log(bootnode_icp + "\n" + namespace);    // set the total number of lines to 2

      let uc2namespace = await tasks.renameNamespace(bootnode_icp, "root", "T1h18rid@", namespace);
    }


})



app.post('/icp-scale/api/v1/uc2/deletaservidor', async function(req, res, next){
    if (req.body.title.includes('Alerting'))
    {
      //console.log(req.body.message);
      data = req.body.message.split("\n"); // split lines
      bootnode_icp = data[0].replace("Bootnode : ","");
      namespace = data[1].replace("Namespace : ","");
      //console.log(bootnode_icp + "\n" + namespace);    // set the total number of lines to 2

      let uc2namespace = await tasks.renameNamespace(bootnode_icp, "root", "T1h18rid@", namespace);
    }


})



/**
 *  * Express Server
 *   */

var server = app.listen(7050, function () {
        var host = server.address().address
        var port = server.address().port

        console.log("Micro-servico ICP scale inicializado em http://%s:%s", host, port);
        console.log("Variaveis: ");
        console.log("ICP_HOST        => %s", icp_host);
        console.log("CAM_HOST        => %s", cam_host);
        console.log("CAM_USER        => %s", cam_user);
        console.log("CAM_TENANT_ID   => %s", tenantId);
 })
