winClass = window.get_active_class()
exceptions = ["st-256color.st-256color"]

if winClass not in exceptions:
    keyboard.send_keys("<shift>+<end>")
    keyboard.send_key("<delete>")
else:
    keyboard.send_keys("<ctrl>+k")
    
    
    
# sefs esesef se    