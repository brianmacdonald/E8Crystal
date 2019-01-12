
function find_in_array(array, search)
    for i, item in array do
        if item == search then
            return i
        end
    end
    return -1
end

function sortedKeys(query, sortFunction)
  local keys, len = {}, 0
  for k,_ in pairs(query) do
    len = len + 1
    keys[len] = k
  end
  table.sort(keys, sortFunction)
  return keys
end


return {
  sortedKeys = sortedKeys,
  find_in_array = find_in_array,
}