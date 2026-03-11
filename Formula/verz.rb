# Copyright 2026 Raymond Auge <rayauge@doublebite.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

class Verz < Formula
  desc "A semver management tool similar to npm version, implemented in Rust"
  homepage "https://github.com/rotty3000/verz"
  license "Apache-2.0"
  version "0.1.6"

  on_linux do
    if Hardware::CPU.intel?
      sha256 "e8ed07df0c33c0d5004a7624f5c465be4f6358a9ff8c166909d3e419dd72477d"
      url "https://github.com/rotty3000/verz/releases/download/v0.1.6/verz-linux-amd64"
    elsif Hardware::CPU.arm?
      sha256 "4defe69ed6969ab318c982e89898c30983726afadbf9e6bc176c1352a4d2137f"
      url "https://github.com/rotty3000/verz/releases/download/v0.1.6/verz-linux-arm64"
    end
  end

  on_macos do
    depends_on "rust" => :build
    sha256 "6a1038c5e9a7707ad7b18e6dfff2b89db6c8cd489f5c104f20155e5b34854336"
    url "https://github.com/rotty3000/verz/archive/refs/tags/v0.1.6.tar.gz"
  end

  def install
    if OS.linux?
      if Hardware::CPU.intel?
        bin.install "verz-linux-amd64" => "verz"
      elsif Hardware::CPU.arm?
        bin.install "verz-linux-arm64" => "verz"
      end
    else
      system "cargo", "install", *std_cargo_args
    end
  end

  test do
    assert_match "v0.1.0", shell_output("#{bin}/verz --version")
  end
end
