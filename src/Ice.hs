{-# LANGUAGE OverloadedStrings #-}

module Ice
    ( proxyApp
    ) where

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
