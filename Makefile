define helm
docker run -ti --rm -v $(shell pwd):/apps -w /apps \
    -v ~/.kube:/root/.kube -v ~/.helm:/root/.helm -v ~/.config/helm:/root/.config/helm \
    -v ~/.cache/helm:/root/.cache/helm \
    alpine/helm
endef

new-version:
	$(helm) dep update
	$(helm) lint .
	$(helm) package . --version $(VERSION)
	$(helm) repo index .
	git add .
	git commit -m "Version release $(VERSION) - $(MESSAGE)"
	git tag -a $(VERSION) -m "Version release $(VERSION) - $(MESSAGE)"; git push origin main --tags
