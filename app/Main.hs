{-# LANGUAGE OverloadedStrings #-}

module Main where

import Ice (proxyApp)

import qualified Network.HTTP.Client.Conduit as HConduit
import qualified Network.HTTP.Proxy as Proxy
import qualified Network.Wai.Handler.Warp as Warp

main :: IO ()
main = do
    --Proxy.runProxy 2319
    manager <- HConduit.newManager
    let
        port = 2319
        app = proxyApp Nothing port manager
    Warp.runSettings (warpSettings port) app
    
warpSettings :: Int -> Warp.Settings
warpSettings port = Warp.setPort port
                  . Warp.setHost "*"
                  $ Warp.setNoParsePath True Warp.defaultSettings
