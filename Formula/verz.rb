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
  version "0.1.2"

  on_linux do
    if Hardware::CPU.intel?
      sha256 "58658bb2f4f267cc5ee57e8c75a9c4f47419fa80c57d12ac0a4e2b57d886a112"
      url "https://github.com/rotty3000/verz/releases/download/v0.1.2/verz-linux-amd64"
    elsif Hardware::CPU.arm?
      sha256 "cbccf9f07b1052ffdc1f14268e1343b24e5a6628fa860d869648a3cb9ddc9fc6"
      url "https://github.com/rotty3000/verz/releases/download/v0.1.2/verz-linux-arm64"
    end
  end

  on_macos do
    depends_on "rust" => :build
    sha256 "7e40dc0810d4f59657eea933f1e56f73522397367e6091115aadb4a9a19b5499"
    url "https://github.com/rotty3000/verz/archive/refs/tags/v0.1.2.tar.gz"
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
