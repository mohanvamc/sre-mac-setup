#!/bin/zsh

TOOLS_INSTALLED=0
TOOLS_SKIPPED=0
SKIPPED_TOOLS=""

tool_list_file="sre-tools.txt"

while IFS= read -r line; do
    if [[ -n "$line" ]]; then
        if [[ $line == "--cask"* ]]; then
            command="brew install --cask ${line/--cask /}"
        else
            command="brew install ${line}"
        fi

        if eval $command; then
            ((TOOLS_INSTALLED++))
        else
            echo "Error installing ${line}"
            ((TOOLS_SKIPPED++))
            SKIPPED_TOOLS+="- ${line}\n"
        fi
    fi
done < "$tool_list_file"

TOTAL_TOOLS=$((TOOLS_INSTALLED + TOOLS_SKIPPED))

echo "Total tools: $TOTAL_TOOLS"
echo "Tools installed: $TOOLS_INSTALLED"
echo -e "Tools skipped: $TOOLS_SKIPPED\n$SKIPPED_TOOLS"

brew cleanup || true