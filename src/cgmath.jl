Vec3 = Array{Float32, 3}

function perspective(fovy::Real, aspect::Float32, near::Float32, far::Float32)
  y, a, n, f =aspect, fovy, near, far
  [1/(a*tan(0.5y)) 0 0 0;
   0 1/tan(0.5y)     0 0;
   0 0 (f+n)//(n-f)    0;
   0 0 -1 (2f*n)//(n-f)]
end

function lookat(eye::Vec3, center::Vec3, up::Vec3)
  
end
