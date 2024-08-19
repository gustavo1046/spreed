class MessageConsumer
  def self.consume(queue_name)
    @channel = $conn.create_channel
    queue = @channel.queue(queue_name, durable: true)

    # Define o bloco de callback para processar as mensagens recebidas
    queue.subscribe(block: true) do |delivery_info, _properties, body|
      puts "Recebido: #{body}"
      process_message(body)
    end
  end

  private

  def self.process_message(message)
    # Lógica para processar a mensagem
    # Exemplo: salva a mensagem em um modelo ou executa uma ação
    puts "Processando mensagem: #{message}"
  end
end
