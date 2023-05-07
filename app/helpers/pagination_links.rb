module PaginationLinks
  def pagination_links(scope, request)
    return {} if scope.total_pages.zero?

    links = {
      first: pagination_link(request, page: 1),
      last: pagination_link(request, page: scope.total_pages)
    }

    links[:next] = pagination_link(request, page: scope.next_page) if scope.next_page.present?
    links[:prev] = pagination_link(request, page: scope.prev_page) if scope.prev_page.present?

    links
  end

  private

  def pagination_link(request, page:)
    url_for(request.params.merge(only_path: true, page: page))
  end
end
