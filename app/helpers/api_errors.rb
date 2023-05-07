module ApiErrors
  def handle_exception(e)
    case e
    when ActiveRecord::RecordNotFound
      error_response('record not found', 404)
    when ActiveRecord::RecordNotUnique
      error_response('record not unique', 422)
    when KeyError
      error_response('key error', 422)
    else
      raise
    end
  end

  def error_response(error_messages, status)
    errors = case error_messages
             when ActiveRecord::Base
               ErrorSerializer.from_model(error_messages)
             else
               ErrorSerializer.from_messages(error_messages)
             end

    content_type :json
    status status
    body errors.to_json
  end
end
