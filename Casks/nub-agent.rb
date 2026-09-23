cask "nub-agent" do
  version "0.1.20"
  sha256 "84a790f38c08711c7a4ef4841313fb791a5e7878daab184a6e41b5c60984e930"

  url "https://download.maiavm.com/archive/Nub-Agent-#{version}-mac-arm64.dmg"
  name "Nub Agent"
  desc "Chat with your Maia VM agent"
  homepage "https://www.maiavm.com/"

  livecheck do
    url "https://download.maiavm.com/latest.json"
    strategy :json do |json|
      json["version"]
    end
  end

  # The app ships its own Ed25519-signed updater, so brew should not nag on
  # every release.
  auto_updates true
  # Only an arm64 build ships; fail early on Intel rather than install a
  # bundle that cannot launch.
  depends_on arch: :arm64
  depends_on :macos

  app "Nub Agent.app"

  zap trash: [
    "~/Library/Application Support/Nub Agent",
    "~/Library/Caches/com.maiavm.desktop",
    "~/Library/Preferences/com.maiavm.desktop.plist",
    "~/Library/Saved Application State/com.maiavm.desktop.savedState",
  ]
end
