class SendmailJob < ApplicationJob
  queue_as :default

  def perform(*args)
    
    PostMailer.with(post: @post).poster.deliver_now


  end
end
