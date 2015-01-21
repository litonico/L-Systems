lsystem :: String -> [(Char, String)] -> Maybe String
lsystem axiom rules = fmap concat $ sequence $ map (`lookup` rules) axiom

-- (flip lookup rules) :: Char -> Maybe String
-- concatMap :: (a -> Maybe [b]) -> [a] -> [b]

-- concatMap :: (a -> Maybe [b]) ->

-- simulate axiom rules = simulate (lsystem axiom rules) rules

-- main :: IO ()
main = do
    print $ lsystem "AB" [('A', "AB"),('B', "A")]
