new-version:
	helm dep update
	helm lint .
	helm package . --version $(VERSION)
	helm repo index .
	git add .
	git commit -m "Version release $(VERSION)"
	git tag -a $(VERSION) -m "Version release $(VERSION)"; git push origin main --tags