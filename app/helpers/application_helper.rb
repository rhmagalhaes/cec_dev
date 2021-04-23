module ApplicationHelper
    # source => https://www.youtube.com/watch?v=cWYiAVMSHD4
    # RailsCasts - #228 Sortable Table Columns

    def sortable(column, title = nil)
        title ||= column.titleize
        css_class = (column == sort_column) ? "current #{sort_direction}" : nil
        direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"
        link_to title, {:sort => column, :direction => direction}, {:class => css_class}
    end

end
