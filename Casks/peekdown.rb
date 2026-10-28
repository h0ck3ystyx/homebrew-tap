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

  zap trash: [
    "~/Library/Containers/com.markdownpreview.app",
    "~/Library/Containers/com.markdownpreview.app.preview",
    "~/Library/Containers/com.markdownpreview.app.thumbnail",
  ]

  caveats do
    <<~EOS
      To activate the Quick Look extensions:

      1. Launch Peekdown.app once to register the extensions with macOS
      2. Enable the extensions under:
         System Settings → General → Login Items & Extensions → Quick Look
      3. Optionally, restart Quick Look with:
         qlmanage -r
         qlmanage -r cache

      After activation, you can preview Markdown files by selecting them in
      Finder and pressing the Space bar.
    EOS
  end
end
