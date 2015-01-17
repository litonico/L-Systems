class Lsystem(object):
    """
    Lsystem(axiom, rules)

    An 'axiom' is a string representing the starting state of the system.

    A 'rule' is an expression of rewriting (like "A->AB"), represented
    as an entry in a dictionary {"OLD": "NEW"}

    All character in
    """
    def __init__(self, axiom, rules):
        self.rules = rules
        self.system = axiom

    def apply(self):
        output = ""
        for char in list(self.system):
            output += self.rules[char]
        self.system = output

if __name__ == "__main__":
    # Demo: Lindenmayer's Algae
    l= Lsystem("A", {"A": "AB", "B": "A"})
    l.apply()
    l.apply()
    l.apply()
    l.apply()
    l.apply()
    l.apply()
    print(l.system)
