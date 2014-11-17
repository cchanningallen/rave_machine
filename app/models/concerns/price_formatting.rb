module PriceFormatting
  extend ActiveSupport::Concern

  def format_price_range(prices)
    prices.length > 1 ? "$#{prices.min}-$#{prices.max}" : "$#{prices[0]}"
  end
end
