#!/bin/bash
set -e

# This is an example test script
# The devcontainer CLI can execute this during testing

# Source any test helpers if available
source dev-container-features-test-lib

# Feature-specific tests
check "hello-world command exists" which claude
check "hello-world runs successfully" claude

# Report results
reportResults
