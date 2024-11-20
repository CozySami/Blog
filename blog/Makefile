# Makefile

sync:
	@echo "Syncing files to S3..."
	aws s3 sync static/ s3://cdn-cozycatblog --endpoint-url https://c19a7484ed1c5d63b609a84495242a96.r2.cloudflarestorage.com --delete
	@echo "Sync complete."