module Socky
  module Server
    module Logger    
      class << self
      
        def enabled?
          @enabled ||= false
        end
    
        def enabled=(val)
          @enabled = val
        end
    
        def log(*args)
          if Socky::Server::Logger.enabled?
            msg = ['Socky'] + args
            puts msg.join(' : ')
          end
        end
      
      end
    end
  end
end
