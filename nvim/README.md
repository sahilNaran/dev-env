 To use TSGO instead of TSSERVER 

# Install Go 1.24 or higher
brew install go

# Install Node.js and npm if you don't have them
brew install node

# Clone the TypeScript-Go repository with submodules
git clone --recurse-submodules https://github.com/microsoft/typescript-go.git
cd typescript-go

# Install npm dependencies
npm ci

# Build the project using the included hereby tool
npx hereby build

# Verify the build worked
./built/local/tsgo --help

# update path 
`echo $(pwd)/built/local/`
add the result of the above command to the PATH variable in your shell profile file (e.g. ~/.bash_profile, ~/.bashrc, ~/.zshrc, etc.)

