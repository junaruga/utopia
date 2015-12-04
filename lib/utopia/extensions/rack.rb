# Copyright, 2012, by Samuel G. D. Williams. <http://www.codeotaku.com>
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

require 'rack'

module Rack
	EXPIRES = 'Expires'.freeze unless defined? EXPIRES
	HTTP_HOST = 'HTTP_HOST'.freeze unless defined? HTTP_HOST
	
	class Response
		# Specifies that the content shouldn't be cached. Overrides `cache!` if already called.
		def do_not_cache!
			headers[CACHE_CONTROL] = "no-cache, must-revalidate"
			headers[EXPIRES] = Time.now.httpdate
		end

		# Specify that the content should be cached.
		def cache!(duration = 3600)
			unless headers[CACHE_CONTROL] =~ /no-cache/
				headers[CACHE_CONTROL] = "public, max-age=#{duration}"
				headers[EXPIRES] = (Time.now + duration).httpdate
			end
		end

		# Specify the content type of the response data.
		def content_type!(value)
			headers[CONTENT_TYPE] = value.to_s
		end
	end
end
