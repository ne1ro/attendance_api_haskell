{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE OverloadedStrings #-}

module Lib
    ( server
    ) where

import qualified Application
import           Control.Applicative
import           Control.Monad
import           Control.Monad.IO.Class
import           Data.Monoid            (mconcat)
import           Data.Time.Calendar
import           Data.Time.Clock
import           Database.SQLite.Simple
import           Network.HTTP.Types.Status
import           Web.Scotty

server :: IO ()
server = do
  putStrLn "Starting server ..."
  conn <- open "attendance.db"

  scotty 3000 $ do
    get "/attendants" $ do
      attendants <- liftIO $ Application.listAttendants conn
      json attendants

    post "/attendants" $ do
      body <- jsonData
      case liftIO $ Application.createAttendant conn body of
        Left err -> json "validation error"
        Right attendant -> json attendant

    defaultHandler $ \str -> do
      status status500
      json str

    -- get "/attendancies/:day" $ do
    --   day <- param "word" :: String
      -- today <- fmap utctDay getCurrentTime
    --   json $ Application.listAttendancies day

    -- get "/:word" $ do
      -- beam <- param "word"
      -- html $ mconcat ["<h1>Scotty, ", beam, " me up!</h1>"]

  close conn
