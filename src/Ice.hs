{-# LANGUAGE OverloadedStrings #-}

module Ice
    ( proxyApp
    , testLogger
    ) where

import           Data.Monoid ((<>))
import qualified Network.HTTP.Client.Conduit as HConduit
import qualified Network.HTTP.Proxy as Proxy
import qualified Network.Wai as Wai

proxyApp :: Maybe Proxy.UpstreamProxy
         -> Int
         -> HConduit.Manager
         -> Wai.Application
proxyApp maybeUpstream port manager = Proxy.httpProxyApp settings manager
  where
    settings = Proxy.defaultProxySettings
               { Proxy.proxyPort = port
               , Proxy.proxyUpstream = maybeUpstream }

testLogger :: Wai.Middleware
testLogger app req sendResponse = app req $ \res -> do
    putStrLn $ "Request: " <> (show $ Wai.requestHeaderHost req)
    sendResponse res
