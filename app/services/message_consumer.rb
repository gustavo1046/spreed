# app/services/rabbitmq_consumer_service.rb
class RabbitMQConsumerService
    def initialize(queue_name)
      @queue_name = queue_name
      @connection = Bunny.new
      @connection.start
      @channel = @connection.create_channel
    end
  
    def consume
      queue = @channel.queue(@queue_name, durable: true)
  
      puts " [*] Waiting for messages in #{@queue_name}. To exit press CTRL+C"
  
      queue.subscribe(manual_ack: true, block: true) do |delivery_info, _properties, body|
        process_message(body)
        @channel.ack(delivery_info.delivery_tag)
      end
    rescue Interrupt => _
      @channel.close
      @connection.close
    end
  
    private
  
    def process_message(message)
      puts " [x] Received #{message}"
      # Aqui você pode implementar a lógica de processamento da mensagem.
      # Exemplo: JSON.parse(message) para transformar a mensagem em um objeto Ruby
    end
  end
  