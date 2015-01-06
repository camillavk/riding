class AdminMailer < ActionMailer::Base

  require 'mandrill'

  def mandrill_client
    @mandrill_client ||= Mandrill::API.new MANDRILL_API_KEY
  end

  def new_attending(creator, user)
    # @creator = creator
    # @user = user
    template_name = "new-attending"
    template_content = []
    message = {
      to: [{email: creator.email, name: creator.name}],
      subject: "Someone wants to go riding with you!",
      merge_vars: [
        {rcpt: creator.email,
        vars: [
          {name: "CREATOR_NAME", content: creator.name},
          {name: "USER_NAME", content: user.name},
          {name: "USER_NUMBER", content: user.number}
          ]}
      ]
    }
    mandrill_client.messages.send_template template_name, template_content, message
  end

end
