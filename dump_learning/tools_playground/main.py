from fastapi import FastAPI
from enum import Enum

app = FastAPI()

@app.get("/")
def hello():
    return 'Hello'

@app.get("/world")
def hello():
    return 'Hello World'

@app.get("/hello/{name}")
def hello(name):
    return f'Hello {name.capitalize()}'

class AvailableCuisines(str, Enum):
    indian = 'indian'
    polish = 'polish'
    italian = 'italian'
    
food_items = {
    "indian" : ['samosa'],
    "italian" : ['pizza'],
    'polish' : ['bigos']
}
@app.get("/get_items/{cuisine}")
def get_items(cuisine: AvailableCuisines):
    return food_items.get(cuisine)

coupon_code = {
    1: '10%',
    2: "20%",
    3: "30%"
}

@app.get("/get_coupon/{code}")
async def get_items(code: int):
    return {"discount_amount" : coupon_code.get(code)}