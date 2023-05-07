all:
	@if command -v dot >/dev/null 2>&1 && command -v ruby >/dev/null 2>&1; then \
		gem install gematria sqlite3 ruby-graphviz; \
		cp cli.rb /usr/bin/g; \
		chmod +x /usr/bin/g; \
		echo "Installed!"; \
		exit 0; \
	else \
		echo "Please install 'ruby' and 'graphviz' manually, then run this again"; \
		exit 1; \
	fi
