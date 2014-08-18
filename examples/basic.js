var Sesame = require('aws-sesame');

// config options are any listed here:
// http://docs.aws.amazon.com/AWSJavaScriptSDK/latest/AWS/EC2.html#constructor-property
var s = new Sesame({sslEnabled: true, region: 'us-east-1', accessKeyId: 'a key id', secretAccessKey: 'a key'});

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
s.grantAccess('sg-11231223', 'tcp', "1.2.3.4", 22, 22, function(r) {
		 console.log(r);
	       });
