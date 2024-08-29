cask 'momiage-mono' do
  version :latest
  sha256 :no_check

  url do
    require 'open-uri'
    require 'json'

    api_url = 'https://api.github.com/repos/kb10uy/MomiageMono/releases/latest'
    release_info = JSON.parse(URI.open(api_url).read)
    asset = release_info['assets'].find { |a| a['name'].match(/\.zip$/) }
    asset ? asset['browser_download_url'] : nil
  end

  name 'Momiage Mono'
  homepage 'https://github.com/kb10uy/MomiageMono'

  # フォントファイルのインストール
  postflight do
    # Caskroom内のフォントファイルをインストール
    Dir.glob("#{staged_path}/*.ttf") do |ttf_file|
      system_command '/bin/cp', args: [ttf_file, "#{ENV['HOME']}/Library/Fonts"]
      puts "Installed #{File.basename(ttf_file)} to ~/Library/Fonts"
    end
  end

  livecheck do
    url :url
    strategy :github_latest
  end
end
