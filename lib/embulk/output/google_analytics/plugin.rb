module Embulk
  module Output
    module GoogleAnalytics
      class Plugin < OutputPlugin
        ::Embulk::Plugin.register_output("google_analytics", self)

        def self.transaction(config, schema, count, &control)
          # configuration code:
          task = {
            "token_credential_uri" => "https://accounts.google.com/o/oauth2/token",
            "audience" => "https://accounts.google.com/o/oauth2/token",
            "client_id" => config.param("client_id", :string),
            "client_secret" => config.param("client_secret", :string),
            "refresh_token" => config.param("refresh_token", :string),
            "scope" => "https://www.googleapis.com/auth/analytics.edit",

            "action" => config.param("action", :string, default: 'dataimport'),
            "account_id" => config.param("account_id", :string),
            "webproperty_id" => config.param("webproperty_id", :string),
            "datasource_id" => config.param("datasource_id", :string, default: nil),
            "filename" => config.param("filename", :string, default: nil),
          }
          task_check(task)

          # resumable output:
          # resume(task, schema, count, &control)

          # non-resumable output:
          task_reports = yield(task)
          next_config_diff = {}
          return next_config_diff
        end

        def self.task_check(task)
          if task['action'] == 'dataimport'
            if task['datasource_id'].nil?
              Embulk.logger.error 'datasource_id is required'
              raise 'datasource_id is required'
            elsif task['filename'].nil?
              Embulk.logger.error 'filename is required'
              raise 'filenam is required'
            end
          elsif task['action'] == 'measurement_protocol'
            Embulk.logger.error 'Sorry, Measurement Protocol feature is not implemented'
            raise 'Measurement Protocol feature is not implemented'
          else
            Embulk.logger.error 'ACTION_ERROR'
            raise 'ACTION_ERROR'
          end
        end

        def init
          @client = Client.new(@task)
        end

        def close
        end

        def add(page)
          if task['action'] == 'dataimport'
            rows = page.collect{|record| Hash[schema.names.zip(record)] }
            @client.upload(rows)
          end
        end

        def finish
        end

        def abort
        end

        def commit
          task_report = {}
          return task_report
        end
      end
    end
  end
end
