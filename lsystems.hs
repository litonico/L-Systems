{-
lsystem :: Maybe String -> [(Char, String)] -> Maybe String
lsystem axiom rules = concat $ sequence $ fmap (`lookup` rules) axiom
-}

lsystem :: Maybe String -> [(Char, String)] -> Maybe String
lsystem axiom rules = fmap concat $ fmap sequence $ fmap (map (`lookup` rules)) axiom

-- simulate axiom rules = simulate (lsystem axiom rules) rules

main = do
    print $ lsystem (Just "AB") [('A', "AB"),('B', "A")]
