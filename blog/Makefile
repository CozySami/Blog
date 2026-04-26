# Makefile

clean:
	@echo "Cleaning Hugo build artifacts..."
	rm -rf public/
	rm -rf resources/
	rm -f .hugo_build.lock
	@echo "Clean complete."

check:
	@bash scripts/check-slug.sh

.PHONY: clean check