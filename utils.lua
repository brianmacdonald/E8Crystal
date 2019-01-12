function sortedKeys(query, sortFunction)
  local keys, len = {}, 0
  for k,_ in pairs(query) do
    len = len + 1
    keys[len] = k
  end
  table.sort(keys, sortFunction)
  return keys
end


return {sortedKeys= sortedKeys}