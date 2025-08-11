module SessionTestHelper
    def sign_in_as(user)
      Current.session = user.sessions.create!
  
      ActionDispatch::TestRequest.create.cookie_jar.tap do |cookie_jar|
        cookie_jar.signed[:session_id] = Current.session.id
        if respond_to?(:cookies)
          cookies[:session_id] = cookie_jar[:session_id]
        else
          visit root_url
          page.driver.browser.manage.add_cookie(name: :session_id, value: cookie_jar[:session_id])
        end
      end
    end
  
    def sign_out
      Current.session&.destroy!
      cookies.delete(:session_id)
    end
end