require 'rqrcode'

# Create a new QR code
qrcode = RQRCode::QRCode.new("https://en.wikipedia.org/wiki/QR_code")

# Convert QR code to PNG
png = qrcode.as_png(
  size: 500,             # Set size of the QR code
  border_modules: 4,     # Border size
  color_mode: ChunkyPNG::COLOR_GRAYSCALE,
  color: 'black'
)

# Write the PNG to a file
File.open("sometext.png", "wb") do |file|
  file.write(png.to_s)
end

puts "QR code generated and saved as sometext.png"

cur = "0"

while cur != "4" do
  puts "Type 1 to create a qr code for a url, 2 to create a qr code to join a wifi network, 3 to create a qr code to send a text message, or type anything else to exit"
  cur = gets.chomp

  content = ""

  if cur == "1"
    puts "Please enter your link here:"
    content = gets.chomp
  
  elsif cur == "2"
    puts "Please enter your network name here:"
    network = gets.chomp

    puts "Please enter your network password here:"
    password = gets.chomp

    content = "WIFI:T:WPA;S:#{network};P:#{password};;"
  
  elsif cur == "3"
    puts "Please enter the number you would like to message here:"
    number = gets.chomp

    puts "Please enter your message here:"
    message = gets.chomp

    content = "SMSTO:#{number}:#{message}"
  
  else
    break
  end

  qrcode = RQRCode::QRCode.new(content)

  png = qrcode.as_png(
    size: 500,
    border_modules: 4,
    color_mode: ChunkyPNG::COLOR_GRAYSCALE,
    color: 'black'
  )

  puts "What would you like your qr code to be called"

  title = gets.chomp

  File.open("#{title}.png", "wb") do |file|
    file.write(png.to_s)
  end

  puts "QR code generated and saved as #{title}.png"

end
