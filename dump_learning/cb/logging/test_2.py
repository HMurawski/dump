import pytest
def multiply(a,b):
    return a*b

def divide(a,b):
    if b == 0:
        raise ValueError("Cannot divine by zero!")
    return a/b

def test_multiply():
    assert multiply(5,10) == 50
    assert multiply(123, 2) == 246

def test_divide():
    assert divide(10,2) == 5
    
    with pytest.raises(ValueError):
        assert divide(10,0)
        