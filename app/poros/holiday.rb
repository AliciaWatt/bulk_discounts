class Holiday
  attr_reader :name, :date

  def initialize(data)
    @name = data[:name]
    @date = data[:date]
    @date = DateTime.strptime(data[:date], "%Y-%m-%d")
  end

  def format_date
    @date.strftime("%B %d, %Y")
  end
end
