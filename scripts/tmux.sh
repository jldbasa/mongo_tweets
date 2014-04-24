#!/bin/sh

tmux new-session -d -s mongo_tweets

tmux new-window -t mongo_tweets:2 -n 'vim'
tmux new-window -t mongo_tweets:3 -n 'server'
tmux new-window -t mongo_tweets:4 -n 'mongodb' 'mongo --port 17017'

tmux select-window -t mongo_tweets:1
tmux -2 attach-session -t mongo_tweets
