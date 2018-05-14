def integers():
    """Infinite sequence of integers."""
    i = 1
    while i < 10:
        yield i
        i = i + 1

def squares():
    global x 
    x = integers()
    for i in x:
        yield i * i