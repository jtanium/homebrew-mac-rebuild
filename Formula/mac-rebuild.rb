class MacRebuild < Formula
  desc "Intelligent Mac development environment backup and restore tool with modular plugin system"
  homepage "https://github.com/jtanium/mac-rebuild"
  url "https://github.com/jtanium/mac-rebuild/archive/v2.2.1.tar.gz"
  version "2.2.1"
  sha256 "2942d8f4870fb07debcd6a576a41ad8b20baf3a3e2ca8d0f1b6e73f6aca8feba"
  license "MIT"

  depends_on "git"

  def install
    bin.install "mac-rebuild"

    # Install library files in libexec structure (proper Homebrew way)
    (libexec/"lib/mac-rebuild").install Dir["lib/mac-rebuild/*"]

    # Install man page
    man1.install "man/mac-rebuild.1" if File.exist?("man/mac-rebuild.1")
  end

  def caveats
    <<~EOS
      Mac Rebuild has been installed!

      ⚠️  IMPORTANT: Create a Time Machine backup before using this tool!

      Getting started:
        1. mac-rebuild --help          # View all available commands
        2. mac-rebuild backup          # Create backup with storage options
        3. mac-rebuild restore <path>  # Restore from backup

      Examples:
        # Create backup (interactive storage selection)
        mac-rebuild backup

        # Restore from iCloud Drive
        mac-rebuild restore ~/Library/Mobile\\ Documents/com~apple~CloudDocs/mac-backup

        # Restore from other cloud storage
        mac-rebuild restore ~/Dropbox/mac-backup
        mac-rebuild restore /Volumes/USB/mac-backup

        # List available plugins
        mac-rebuild plugins

        # Clear all backup files
        mac-rebuild purge

      Fresh install workflow:
        1. Install Homebrew + mac-rebuild
        2. mac-rebuild restore <your-backup-path>
        3. All apps, SSH keys, and settings restored!

      New in v2.2.1:
        • Minor bug fixes and performance improvements
    EOS
  end

  test do
    system "#{bin}/mac-rebuild", "--version"
  end
end
