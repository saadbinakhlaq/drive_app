require 'json'

module Application
  class InteractiveInputHandler
    def self.read(path)
      file = File.read path
      JSON.parse(file)
    end
  end
end