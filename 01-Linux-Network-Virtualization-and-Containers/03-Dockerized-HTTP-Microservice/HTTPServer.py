from flask import Flask, jsonify, request

app = Flask(__name__)

# Initial status
status = "OK"

@app.route('/api/v1/status', methods=['GET', 'POST'])
def handle_status():
    global status

    if request.method == 'GET':
        return jsonify({"status": status}), 200
    elif request.method == 'POST':
        status = request.get_json().get('status')
        return jsonify({"status": status}), 201

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8000)