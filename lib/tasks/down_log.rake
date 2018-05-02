desc "down logs from remote server"
task :down_log do
  io = File.open("/home/mc/rubycode/logs_domestictrade/down.log","ab+")
  io.puts("===========#{Time.now}==========")
  io.puts("连接服务器...")
  Net::SSH.start("23.106.139.14", "root",:password => "#506@Mancao" ,:port => 28904) do |ssh|
    path = '/var/www/domestictrade/'
    files = ssh.exec!("ls #{path} | grep .zip$").split("\n")
    puts files
    io.puts("发现#{files.size}个日志文件")
    if files.size > 0
      files.each do |f|
        io.puts("正在下载#{f}")
        ssh.scp.download!("#{path}#{f}","/home/mc/rubycode/logs_domestictrade/#{f}")
        io.puts("#{f}下载完毕")
      end
      io.puts("删除远程的日志文件...")
      ssh.exec!("rm #{path}*.zip")
      io.puts("删除远程的日志文件完毕")
      io.puts("移动本地日志文件")
    end
    io.puts("完成")
    io.close
  end
end
