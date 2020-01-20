# Copyright (c) 2019 SiFive Inc.
# SPDX-License-Identifier: Apache-2.0

all: test

venv/bin/activate:
	python3 -m venv venv
	. $@ && pip install --upgrade pip
	. $@ && pip install -r requirements.txt

.PHONY: virtualenv
virtualenv: venv/bin/activate

.PHONY: test-lint
test-lint: venv/bin/activate *.py
	. $< && pylint *.py
test: test-lint

UNIT_TESTS = tests/test-rtl.py

.PHONY: test-unit
test-unit: venv/bin/activate $(UNIT_TESTS)
	. $< && python -m unittest $(UNIT_TESTS)
test: test-unit

.PHONY: test
test:

.PHONY: clean
clean:
	-rm -rf venv .mypy_cache __pycache__
