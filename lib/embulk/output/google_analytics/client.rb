require 'google/apis/analytics_v3'
require 'stringio'
module Embulk
  module Output
    module GoogleAnalytics
      class Client
        def initialize(task)
          @task = task
        end

        def upload(rows)
          self.service.upload_data(@task['account_id'], @task['webproperty_id'], @task['datasource_id'], {
            upload_source: make_upload_content(rows),
            content_type: 'application/octet-stream',
            options: {
              header: {
                'x-goog-upload-file-name' => @task['filename'],
              }
            }
          })
        end

        def service
          analytics_service = ::Google::Apis::AnalyticsV3::AnalyticsService.new
          analytics_service.authorization = Signet::OAuth2::Client.new({
            :token_credential_uri => @task["token_credential_uri"],
            :audience => @task["audience"],
            :client_id => @task["client_id"],
            :client_secret => @task["client_secret"],
            :refresh_token => @task["refresh_token"],
            :scope => @task["scope"],
          })
          analytics_service.authorization.fetch_access_token!
          analytics_service
        end

        private
          def make_upload_content(rows)
            io = StringIO.new
            io.puts(rows.first.collect{|k,v| k }.join(","))
            rows.each do |row|
              io.puts(row.collect{|k, v| v}.join(","))
            end
            io
          end
      end
    end
  end
end
