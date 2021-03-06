module Api
  module Helper
    shared_context "shared context" do
      let(:valid_email) { "user@seed.com" }
      let(:valid_password) { "userseed" }

      before(:all) do
        DatabaseCleaner.strategy = :truncation
      end

      def login(email = valid_email, password = valid_password)
        post "/auth/login",
             email: email,
             password: password
      end

      def token(email = valid_email, password = valid_password)
        login(email, password)
        json[:token]
      end

      def current_user
        new_token = token
        User.find_by(token: new_token)
      end

      after(:all) do
        DatabaseCleaner.clean
      end
    end
  end
end
