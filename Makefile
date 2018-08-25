.PHONY: docs

init:
	pip install --upgrade pipenv
	pipenv install --dev --skip-lock

dev:
	pipenv run python setup

lint:
	pipenv run pycodestyle setup

test:
	pipenv run pytest tests

coverage:
	pipenv run pytest --cov=setup tests

docs:
	pipenv run pydoc -w setup/

repl:
	pipenv run ipython
