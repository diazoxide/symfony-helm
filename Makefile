new-version:
	helm dep update
	helm package . --version $(VERSION)
	helm repo index .