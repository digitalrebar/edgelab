echo "Building for RPi only!"
env GOOS=linux GOARCH=arm64 go build -o rpio
echo "Built ./rpio"
