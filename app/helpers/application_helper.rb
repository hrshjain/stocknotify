module ApplicationHelper
  def has_internet?
    require "resolv"
    dns_resolver = Resolv::DNS.new()
    begin
      dns_resolver.getaddress("symbolics.com")#the first domain name ever. Will probably not be removed ever.
      return true
    rescue Resolv::ResolvError => e
      return false
    end
  end


  def say
    "hello"
  end

  def get_iex_stock_price(sym)
    IEX::Resources::Price.get(sym)
  end

end
