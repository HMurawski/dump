import pytest
from src.bank import BankAccount

def test_create_account():
    account = BankAccount("Olek Kwasniewski", 1000)
    
    assert account.owner == "Olek Kwasniewski"
    assert account.balance == 1000
    
def test_deposit():
    account = BankAccount("HM", 5000)
    account.deposit(1000)
    account.deposit(777)
    assert account.balance == 6777
    
def test_withdraw():
    account = BankAccount('JD', 997)
    account.withdraw(97)
    account.withdraw(500)
    account.deposit(1000)
    assert account.balance == 1400