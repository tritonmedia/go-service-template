{
  "go.lintTool": "golangci-lint",
  "go.lintFlags": [
    "--fast",
  ],
  "go.formatTool": "goimports",
  "go.alternateTools": {
    "golangci-lint": "${workspaceFolder}/scripts/golangci-lint.sh",
    "goimports": "${workspaceFolder}/scripts/goimports.sh"
  },
  "shellcheck.customArgs": [
    "-P",
    "SCRIPTDIR",
    "-x"
  ],
  "editor.formatOnSave": true,
  "shellformat.path": "./scripts/shfmt.sh",
  "[dockerfile]": {
    "editor.defaultFormatter": "ms-azuretools.vscode-docker"
  },
  "[yaml]": {
    "editor.defaultFormatter": "redhat.vscode-yaml"
  }
}
