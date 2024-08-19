require 'bunny'

$conn = Bunny.new(hostname: 'localhost', port: 5672, username: 'myuser', password: 'mypassword')
$conn.start