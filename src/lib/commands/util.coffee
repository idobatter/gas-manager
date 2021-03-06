###

gas-manager
https://github.com/soundTricker/gas-manager

Copyright (c) 2013 Keisuke Oohashi
Licensed under the MIT license.

###

'use strict'

fs = require 'fs'
path = require 'path'
async = require 'async'
Manager = require('../gas-manager').Manager

program = require 'commander'

exports.loadConfig = (program)->
  if !fs.existsSync program.config
    throw new Error "#{program.config} not exist, it's given."

  config = require path.resolve program.config

  if program.setting && fs.existsSync(path.resolve(program.setting))
    setting = require path.resolve program.setting

    for k, v of setting
      config[k] = v

  if !config.client_id
    throw new Error "config file should set client_id"
  if !config.client_secret
    throw new Error "config file should set client_secret"
  if !config.refresh_token
    throw new Error "config file should set refresh_token"

  return config

exports.getUserHome = ()->
  return process.env[if process.platform == 'win32' then 'USERPROFILE' else 'HOME']