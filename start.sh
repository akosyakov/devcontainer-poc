#!/bin/sh
set -e
cd "$(dirname $0)"

workspace_folder=/workspace/vscode-remote-try-java

# Save off effective config for use in the container
devcontainer read-configuration --include-merged-configuration --log-format json --workspace-folder $workspace_folder 2>/dev/null > server/configuration.json

devcontainer up --remove-existing-container --mount "type=bind,source=$(pwd)/server,target=/server" --workspace-folder $workspace_folder

devcontainer exec --workspace-folder $workspace_folder /server/init-openvscode-server.sh



# need gitpod user - don't run supervisor
#devcontainer exec --workspace-folder ../vscode-remote-try-java /.supervisor/supervisor run --rungp

# need supervisor - don't run VS Code with supervisor
#devcontainer exec --workspace-folder ../vscode-remote-try-java /ide/codehelper --port 23000 --host 0.0.0.0 --without-connection-token --server-data-dir /workspace/.vscode-remote

# need supervisor-frontend - so let's use openvscode server instead
# devcontainer exec --workspace-folder ../vscode-remote-try-java /ide/bin/gitpod-code --port 26000 --host 0.0.0.0 --without-connection-token --server-data-dir /workspace/.vscode-remote --start-server --do-not-sync


