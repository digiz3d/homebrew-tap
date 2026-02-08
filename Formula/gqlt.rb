class Gqlt < Formula
  desc "Simple GraphQL toolkit ! ❤"
  homepage "https://github.com/digiz3d/graphql-toolkit"
  version "1.1.0"  # gqlt:version

  on_linux do
    on_arm do
      url "https://github.com/digiz3d/graphql-toolkit/releases/download/v1.1.0/aarch64-linux-gqlt"  # gqlt:url-aarch64-linux
      sha256 "dcbb11deef1c1d5dbe8abc62651cedd217913653034e2b57339edbc737210388"  # gqlt:sha-aarch64-linux
    end
    on_intel do
      url "https://github.com/digiz3d/graphql-toolkit/releases/download/v1.1.0/x86_64-linux-gqlt"  # gqlt:url-x86_64-linux
      sha256 "87a572c2b3a6b8a251a86bbd6d9a03b5ba99fcab357cfe9f96eda19ce228c922"  # gqlt:sha-x86_64-linux
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/digiz3d/graphql-toolkit/releases/download/v1.1.0/aarch64-macos-gqlt"  # gqlt:url-aarch64-macos
      sha256 "762cc918d9d055d8b0bf2aa6d55523a7bff9d0e435400d446b8cdef57e7a73d7"  # gqlt:sha-aarch64-macos
    end
    on_intel do
      url "https://github.com/digiz3d/graphql-toolkit/releases/download/v1.1.0/x86_64-macos-gqlt"  # gqlt:url-x86_64-macos
      sha256 "a6b6076df40599aa9bc0c35b244a625053eb4510611e22c12d43038beaeb0beb"  # gqlt:sha-x86_64-macos
    end
  end

  def install
    binary_name = nil
    on_linux do
      on_arm { binary_name = "aarch64-linux-gqlt" }
      on_intel { binary_name = "x86_64-linux-gqlt" }
    end
    on_macos do
      on_arm { binary_name = "aarch64-macos-gqlt" }
      on_intel { binary_name = "x86_64-macos-gqlt" }
    end
    odie "Unsupported platform: no gqlt binary for #{OS.kernel_name}-#{Hardware::CPU.arch}" if binary_name.nil?
    bin.install binary_name => "gqlt"
  end

  def caveats; <<~EOS
    ❤ Thanks for installing gqlt ! ❤
  EOS
  end
end
