#!/bin/bash
echo "Running Snyk Pre-Commit Scan..."
snyk test --all-projects
snyk code test

