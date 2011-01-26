{- git-annex command
 -
 - Copyright 2010 Joey Hess <joey@kitenet.net>
 -
 - Licensed under the GNU GPL version 3 or higher.
 -}

module Command.Semitrust where

import Command
import qualified GitRepo as Git
import qualified Remotes
import UUID
import Trust
import Messages

command :: [Command]
command = [Command "semitrust" (paramRepeating paramRemote) seek
	"return repository to default trust level"]

seek :: [CommandSeek]
seek = [withString start]

{- Marks a remote as not trusted. -}
start :: CommandStartString
start name = do
	r <- Remotes.byName name
	showStart "untrust" name
	return $ Just $ perform r

perform :: Git.Repo -> CommandPerform
perform repo = do
	uuid <- getUUID repo
	trustSet uuid SemiTrusted
	return $ Just $ return True
