local M = {}

-- Jump to definition, filtering out import statements in the current file
function M.goto_definition()
	local client = vim.lsp.get_clients({ bufnr = 0 })[1]
	local offset_encoding = client and client.offset_encoding or "utf-16"
	local params = vim.lsp.util.make_position_params(0, offset_encoding)
	vim.lsp.buf_request(0, "textDocument/definition", params, function(err, result, ctx, config)
		if err or not result or vim.tbl_isempty(result) then
			return
		end

		-- Normalize result to list
		if not vim.islist(result) then
			result = { result }
		end

		-- If single result, jump directly
		if #result == 1 then
			vim.lsp.util.show_document(result[1], "utf-8")
			return
		end

		-- Check if any results are in external files
		local current_buf = vim.api.nvim_get_current_buf()
		local current_uri = vim.uri_from_bufnr(current_buf)
		local external_results = vim.tbl_filter(function(location)
			local target_uri = location.uri or location.targetUri
			return target_uri ~= current_uri
		end, result)

		-- Prefer external definitions (actual definitions) over same-file results (likely imports)
		-- But if all definitions are in the current file, use them
		local final_results = #external_results > 0 and external_results or result

		-- Jump to first result
		vim.lsp.util.show_document(final_results[1], "utf-8")
	end)
end

return M
