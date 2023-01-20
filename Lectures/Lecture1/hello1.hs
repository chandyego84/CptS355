mul x y  = x * y

-- if you need multiple I/O actions in one expression, use a do block
main = do putStrLn "What is 4 * 6?"
          x <- readLn
          if x == mul 4 6
             then putStrLn "You're right!"
             else putStrLn "You're wrong!"