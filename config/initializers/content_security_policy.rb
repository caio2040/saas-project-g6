# Be sure to restart your server when you modify this file.

# Define an application-wide content security policy.
# We allow 'unsafe-eval' because the app compiles JSX at runtime using Babel
# and evaluates the compiled code. If you remove runtime Babel, you can
# tighten this policy by removing :unsafe_eval.
Rails.application.configure do
  config.content_security_policy do |policy|
    policy.default_src :self, :https
    policy.font_src    :self, :https, :data
    policy.img_src     :self, :https, :data
    policy.object_src  :none
    policy.script_src  :self, :https, :unsafe_eval
    policy.style_src   :self, :https
    # policy.report_uri "/csp-violation-report-endpoint"
  end

  # Generate nonces for importmap and inline scripts if needed
  config.content_security_policy_nonce_generator = ->(_request) { SecureRandom.base64(16) }
  config.content_security_policy_nonce_directives = %w(script-src)
  # config.content_security_policy_report_only = true
end
