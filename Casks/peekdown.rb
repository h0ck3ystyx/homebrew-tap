cask "peekdown" do
  version "1.0.2"
  sha256 "e7240e1ebc462cca8ccfcc566a9b19c43eac62a475ca474455f4a7464bfc388a"

  url "https://github.com/h0ck3ystyx/peekdown/releases/download/v#{version}/Peekdown-#{version}.zip"
  name "Peekdown"
  desc "Quick Look extension for Markdown files"
  homepage "https://h0ck3ystyx.github.io/peekdown/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :monterey

  app "Peekdown.app"

  postflight do
    system_command "pluginkit",
                   args: ["-a", "#{appdir}/Peekdown.app/Contents/PlugIns/PreviewExtension.appex"],
                   sudo: false,
                   print_stderr: false
    system_command "pluginkit",
                   args: ["-a", "#{appdir}/Peekdown.app/Contents/PlugIns/ThumbnailExtension.appex"],
                   sudo: false,
                   print_stderr: false
    system_command "open",
                   args: ["-g", "-j", "#{appdir}/Peekdown.app"],
                   sudo: false,
                   print_stderr: false
    system "qlmanage", "-r"
    system "qlmanage", "-r", "cache"
  end

  uninstall_postflight do
    system "qlmanage", "-r"
    system "qlmanage", "-r", "cache"
  end

  zap trash: [
    "~/Library/Containers/com.markdownpreview.app",
    "~/Library/Containers/com.markdownpreview.app.preview",
    "~/Library/Containers/com.markdownpreview.app.thumbnail",
  ]

  caveats do
    <<~EOS
      The Quick Look extensions have been registered automatically.
      
      If Markdown previews don't work immediately, enable the extensions under:
      System Settings → General → Login Items & Extensions → Quick Look
    EOS
  end
end
