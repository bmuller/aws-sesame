AWS = require 'aws-sdk'

class Sesame
  constructor: (@config) ->
    @aws = new AWS.EC2(config)

  getGroups: (ids, cb) ->
    @aws.describeSecurityGroups GroupIds: ids, (err, data) ->
      if err or data.SecurityGroups.length == 0 then console.log(err, err.stack) else cb(data.SecurityGroups[0])

  hasAccess: (groupid, protocol, ip, startport, endport, cb) ->
    @getGroups [groupid], (result) =>
      for perm in result.IpPermissions
        ips = (r.CidrIp for r in perm.IpRanges)
        if perm.IpProtocol == protocol and @portOverlap(perm.FromPort, perm.ToPort, startport, endport) and @ipOverlap(ips, ip)
          cb true
          return
      cb false

  # Returns true if access was granted
  grantAccess: (groupid, protocol, ip, startport, endport, cb) ->
    @hasAccess groupid, protocol, ip, startport, endport, (result) =>
      if result
        cb(true)
        return
      params =
        GroupId: groupid
        FromPort: startport
        ToPort: endport
        CidrIp: "#{ip}/32"
        IpProtocol: protocol
      @aws.authorizeSecurityGroupIngress params, (err, data) ->
        if err
          console.log err, err.stack
          cb false
        else cb data?

  revokeAccess: (groupid, protocol, ip, startport, endport, cb) ->
    @hasAccess groupid, protocol, ip, startport, endport, (result) =>
      if not result
        cb(true)
        return
      params =
        GroupId: groupid
        FromPort: startport
        ToPort: endport
        CidrIp: "#{ip}/32"
        IpProtocol: protocol
      @aws.revokeSecurityGroupIngress params, (err, data) ->
        if err
          console.log err, err.stack
          cb false
        else cb data?

  ipOverlap: (haystackips, ip) ->
    for haystackip in haystackips
      return true if haystackip == "#{ip}/32"
    false

  portOverlap: (haystacklower, haystackupper, needlelower, needleupper) ->
    haystacklower <= needlelower and haystackupper >= needleupper

module.exports = Sesame