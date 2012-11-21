module Kernel
  def suppress_warnings
    original_verbosity = $VERBOSE
    $VERBOSE = nil
    result = yield
    $VERBOSE = original_verbosity
    return result
  end
end

use Rack::Static, :urls => ["/assets"]

suppress_warnings do
  Rack::Directory::DIR_PAGE = File.open("templates/list.html", "rb").read
  Rack::Directory::DIR_FILE = File.open("templates/_item.html", "rb").read
end

run Rack::Directory.new('repo')
