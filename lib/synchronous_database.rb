require "net/ssh"
require "net/scp"
  io = File.open("./sync.log",'ab+')
  # 备份数据库
  io.puts("正在连接远程服务器...")
  puts("正在连接远程服务器...")

  Net::SSH.start('23.106.139.14', 'root', :password => "#506@Mancao",:port => 28904) do |ssh|
    io.puts("连接成功")
    puts("连接成功")
    io.puts("备份数据库...")
    puts("备份数据库...")
    ssh.exec!("pg_dump -U root  DomesticTrade_development > /tmp/test.sql")
    io.puts("数据库备份完毕")
    puts("数据库备份完毕")
    io.puts("压缩备份文件...")
    puts("压缩备份文件...")
    ssh.exec!('cd /tmp && zip test.sql.zip test.sql')
    io.puts("压缩备份文件成功")
    puts("压缩备份文件成功")
    io.puts("删除源文件...")
    puts("删除源文件...")
    ssh.exec!("rm /tmp/test.sql")
    io.puts("删除源文件成功")
    puts("删除源文件成功")
  end
  io.puts("下载压缩后的备份文件...")
  puts("下载压缩后的备份文件...")

  # 将数据下载到本地
  Net::SCP.download!("23.106.139.14", "root",
                     "/tmp/test.sql.zip", "/tmp/",
                     :ssh => { :password => "#506@Mancao" ,:port => 28904})
  io.puts("下载完毕")
  puts("下载完毕")

  io.puts("删除远程备份文件")
  puts("删除远程备份文件")

  # 删除备份
  Net::SSH.start('23.106.139.14', 'root', :password => "#506@Mancao",:port => 28904) do |ssh|
    ssh.exec!("rm /tmp/test.sql.zip")
  end
  io.puts("解压缩备份文件")
  puts("解压缩备份文件")

  `unzip /tmp/test.sql.zip`
  io.puts("格式化本地数据库")
  puts("格式化本地数据库")

  `cd ~/rubycode/dometixtrade && rake db:drop && rake db:create`
  io.puts("导入数据...")
  puts("导入数据...")

  `psql -d DomesticTrade_development -U mc -f /tmp/tmp/test.sql`
  io.puts("完成\n\n\n\n")
  puts("完成")

  io.close

