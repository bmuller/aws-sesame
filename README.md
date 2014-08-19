Open/close access to servers on AWS by IP like a boss.

## Installation

```bash
$ npm install aws-sesame
```

## Examples
As simple as it gets.

```js
var Sesame = require('aws-sesame');

// config options are any listed here:
// http://docs.aws.amazon.com/AWSJavaScriptSDK/latest/AWS/EC2.html#constructor-property
var s = new Sesame({region: 'us-east-1', accessKeyId: 'keyid', secretAccessKey: 'key'});

// revoke access
// params: security group, protocol type, source ip, port start, port end, callback
// returns: true if successful, false otherwise
s.revokeAccess('sg-1123123', 'tcp', "1.2.3.4", 22, 22, function(r) {
		 console.log(r);
	       });

// grant access
// params: security group, protocol type, source ip, port start, port end, callback
// returns: true if successful, false otherwise
s.grantAccess('sg-11231223', 'tcp', "1.2.3.4", 22, 22, function(r) {
		 console.log(r);
	      });


// test access
// params: security group, protocol type, source ip, port start, port end, callback
// returns: true if access exists, false otherwise
s.hasAccess('sg-11231223', 'tcp', "1.2.3.4", 22, 22, function(r) {
		 console.log(r);
	    });
```
