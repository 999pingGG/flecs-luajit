local ffi = require 'ffi'

ffi.cdef 'typedef struct st { int arr[10]; } st;'

local st = ffi.typeof 'st'

ffi.metatype(st, {

})

local s = st()
for i = 0, 9 do
  s.arr[i] = i * 3
end

for i in s do
  print(i)
end
