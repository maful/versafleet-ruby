module Versafleet
  class Collection
    attr_reader :data, :page, :per_page, :total

    def self.from_response(response, key:, type:)
      body = response.body
      new(
        data: body[key].map { |attrs| type.new(attrs) },
        page: body.dig("meta", "page"),
        per_page: body.dig("meta", "per_page"),
        total: body.dig("meta", "total")
      )
    end

    def initialize(data:, page:, per_page:, total:)
      @data = data
      @page = page
      @per_page = per_page
      @total = total
    end
  end
end
