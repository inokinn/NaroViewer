# 環境構築
.PHONY: bootstrap
bootstrap:
	brew update
	brew install mint
	mint bootstrap --overwrite y

.PHONY: update-tools
update-tools:
	brew update
	brew install mint
	mint bootstrap --overwrite y

# XcodeGen を実行する
.PHONY: project
project:
	mint run yonaskolb/XcodeGen xcodegen generate

