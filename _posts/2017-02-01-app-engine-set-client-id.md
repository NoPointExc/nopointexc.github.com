---
layout: post
title: "app engine, set client id. "
description: ""
category: 
tags: []
---
{% include JB/setup %}

### to enable client side.  

1) get cliend id. under console/API Manager/Credential/Credential [https://console.cloud.google.com/apis/credentials?project=java-helloworld-157322]   
2) set web client id in Server side(Java/Python code).  
3) set client-id in frond-end(app.js or other JavaScript code).  
4) allow JavaScript origin in Console, under console/API Manager/Credential/Credential/Domain verification.   

