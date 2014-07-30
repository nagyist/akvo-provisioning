#!/bin/bash

SSH_COMMAND='ssh -i <%= @approot %>/.ssh/rsrleech'
SOURCE_DIR='<%= @mediaroot %>/db'
DEST_DIR='<%= @mediaroot %>/db'
HOST='<%= @data_source_host %>'

rsync --verbose --archive --rsh "${SSH_COMMAND}" rsrleech@${HOST}:${SOURCE_DIR} ${DEST_DIR}/
