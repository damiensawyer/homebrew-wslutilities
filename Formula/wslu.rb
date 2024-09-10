class Wslu < Formula
  desc "A collection of utilities for WSL"
  homepage "https://github.com/wslutilities/wslu"
  url "https://github.com/wslutilities/wslu/archive/v3.1.0.tar.gz"
  sha256 "d5bfa71d3799d5fda50d5e13be87d77df71b5e1b61462f63d85d5ba54efc4f85"
  version "3.1.0"

  def install
    # Ensure the configure.sh script is executable
    chmod "+x", "configure.sh"

    # Run configure.sh with the correct prefix
    system "./configure.sh", "--prefix=#{prefix}"

    # Run make with the PREFIX set for the installation
    system "make", "PREFIX=#{prefix}"

    # Install the binaries
    system "make", "install", "PREFIX=#{prefix}"

    # Optionally, install the man pages and resources
    system "make", "doc_install", "res_install", "PREFIX=#{prefix}"
  end
end
