cask "nub-agent" do
  version "0.1.18"
  sha256 "81cad995d57e781da99a1d0c83463dbb9c9835189d8378873f45481039cedd5f"

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
