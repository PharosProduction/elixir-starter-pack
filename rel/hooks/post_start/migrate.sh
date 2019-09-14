#!/bin/sh

release_ctl eval --mfa "Users.ReleaseTasks.migrate/1" --argv -- "$@"