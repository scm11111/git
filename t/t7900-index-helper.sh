#!/bin/sh
#
# Copyright (c) 2016, Twitter, Inc
#

test_description='git-index-helper

Testing git index-helper
'

. ./test-lib.sh

test_expect_success 'index-helper smoke test' '
	git index-helper --exit-after 1 &&
	test_path_is_missing .git/index-helper.pipe
'

test_expect_success 'index-helper creates usable pipe file and can be killed' '
	test_when_finished "git index-helper --kill" &&
	test_path_is_missing .git/index-helper.pipe &&
	git index-helper --detach &&
	test -p .git/index-helper.pipe &&
	git index-helper --kill &&
	test_path_is_missing .git/index-helper.pipe
'

test_done
