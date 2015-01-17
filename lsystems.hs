lsystem :: String -> [(Char, String)] -> String
lsystem axiom rules = concatMap (fmap (flip lookup rules)) axiom

-- (flip lookup rules) :: Char -> Maybe String
concatMap :: (a -> Maybe [b]) -> [a] -> [b]

concatMap :: (a -> Maybe [b]) ->

-- simulate axiom rules = simulate (lsystem axiom rules) rules

main :: IO ()
main = do
--print $ lsystem "AB" [('A', "AB"),('B', "A")]
