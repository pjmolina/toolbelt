require "erb"

def build_zip(name)
  rm_rf "#{component_dir(name)}/.bundle"
  rm_rf Dir["#{basedir}/components/#{name}/pkg/*.zip"]
  component_bundle name, "install --without \"development\""
  component_bundle name, "exec rake zip:clean zip:build"
  Dir["#{basedir}/components/#{name}/pkg/*.zip"].first
end

def extract_zip(filename, destination)
  tempdir do |dir|
    sh %{ unzip "#{filename}" }
    sh %{ mv * "#{destination}" }
  end
end

file pkg("heroku-toolbelt-#{version}.exe") do |t|
  tempdir do |dir|
    mkdir_p "#{dir}/heroku"
    extract_zip build_zip("heroku"), "#{dir}/heroku/"

    mkchdir("installers") do
      ["ruby-mingw32.7z", "git.exe"].each do |i|
        cache = File.join(File.dirname(__FILE__), "..", ".cache", i)
        FileUtils.mkdir_p File.dirname(cache)
        unless File.exists? cache
          system "curl http://heroku-toolbelt.s3.amazonaws.com/#{i} -o \"#{cache}\""
        end
        cp cache, i
      end
    end

    cp resource("exe/heroku.bat"), "heroku/bin/heroku.bat"
    cp resource("exe/heroku"),     "heroku/bin/heroku"

    sevenzip_dir = ENV["7Z_DIR"] || 'C:\\Program Files (x86)\\7-Zip\\'
    system "\"#{sevenzip_dir}\\7z.exe\" x -o\"#{dir}\\heroku\" -bd -y \"#{dir}\\installers\\ruby-mingw32.7z\""
    mv "#{dir}\\heroku\\ruby-1.9.3-p194-i386-mingw32", "#{dir}\\heroku\\ruby-1.9.3"

    File.open("heroku.iss", "w") do |iss|
      iss.write(ERB.new(File.read(resource("exe/heroku.iss"))).result(binding))
    end

    inno_dir = ENV["INNO_DIR"] || 'C:\\Program Files (x86)\\Inno Setup 5\\'
    system "\"#{inno_dir}\\Compil32.exe\" /cc \"heroku.iss\""
  end
end

desc "Clean exe"
task "exe:clean" do
  clean pkg("heroku-toolbelt-#{version}.exe")
  clean File.join(File.dirname(__FILE__), "..", ".cache")
end

desc "Build exe"
task "exe:build" => pkg("heroku-toolbelt-#{version}.exe")

desc "Release exe"
task "exe:release" => "exe:build" do |t|
  store pkg("heroku-toolbelt-#{version}.exe"), "heroku-toolbelt/heroku-toolbelt-#{version}.exe"
  store pkg("heroku-toolbelt-#{version}.exe"), "heroku-toolbelt/heroku-toolbelt-beta.exe" if beta?
  store pkg("heroku-toolbelt-#{version}.exe"), "heroku-toolbelt/heroku-toolbelt.exe" unless beta?
end
