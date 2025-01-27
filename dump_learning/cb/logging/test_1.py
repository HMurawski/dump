def add(a,b):
    return a + b

def test_add():
    assert add(2,3) == 5
    assert add(100,500) == 600
    
def test_big_num():
    assert add(50000, 10000) == 60000

