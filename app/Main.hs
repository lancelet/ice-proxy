{-# LANGUAGE OverloadedStrings #-}

module Main where

import Ice (proxyApp, testLogger)

import qualified Network.HTTP.Client.Conduit as HConduit
import qualified Network.HTTP.Proxy as Proxy
import qualified Network.Wai.Handler.Warp as Warp

main :: IO ()
main = do
    manager <- HConduit.newManager
    let
        port = 2319
        plainApp = proxyApp Nothing port manager
        middleLog = testLogger
        app = testLogger plainApp
    Warp.runSettings (warpSettings port) app
    
warpSettings :: Int -> Warp.Settings
warpSettings port = Warp.setPort port
                  . Warp.setHost "*"
                  $ Warp.setNoParsePath True Warp.defaultSettings
