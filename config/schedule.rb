# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
set :environment, :development # 设置执行环境为开发环境

every 2.hours do  # 每隔2分钟执行一次 若是1分钟则是 1.minute （单数）
  rake "down_log"  # 执行
end

every 24.hours do  # 每隔2分钟执行一次 若是1分钟则是 1.minute （单数）
  rake "syn_data"  # 执行
end
