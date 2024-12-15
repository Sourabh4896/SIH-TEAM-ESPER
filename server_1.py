from flask import Flask, request, jsonify
import sqlite3
import os

app = Flask(__name__)
DATABASE = 'data.db'

# Function to initialize the SQLite database
def init_db():
    if not os.path.exists(DATABASE):
        with sqlite3.connect(DATABASE) as conn:
            cursor = conn.cursor()
            cursor.execute('''
                CREATE TABLE IF NOT EXISTS DeviceData (
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    public_key TEXT NOT NULL,
                    device_id TEXT NOT NULL,
                    signed_data TEXT NOT NULL
                )
            ''')
            conn.commit()

@app.route('/save_data', methods=['POST'])
def save_data():
    data = request.get_json()  # Get JSON data
    public_key = data.get('public_key')
    device_id = data.get('device_id')
    signed_data = data.get('signed_data')

    # Validate input data
    if not public_key or not device_id or not signed_data:
        return jsonify({'error': 'All fields (public_key, device_id, signed_data) are required.'}), 400

    try:
        with sqlite3.connect(DATABASE) as conn:
            cursor = conn.cursor()
            cursor.execute('''
                INSERT INTO DeviceData (public_key, device_id, signed_data)
                VALUES (?, ?, ?)
            ''', (public_key, device_id, signed_data))
            conn.commit()
    except Exception as e:
        return jsonify({'error': str(e)}), 500

    return jsonify({'message': 'Data saved successfully'}), 200

# Route to retrieve all data from the database (for testing/debugging)
@app.route('/get_data', methods=['GET'])
def get_data():
    try:
        with sqlite3.connect(DATABASE) as conn:
            cursor = conn.cursor()
            cursor.execute('SELECT * FROM DeviceData')
            rows = cursor.fetchall()
            data = [{'public_key': row[0], 'device_id': row[1], 'signed_data': row[2]} for row in rows]
    except Exception as e:
        return jsonify({'error': str(e)}), 500

    return jsonify(data), 200

if __name__ == '__main__':
    # Initialize the database before starting the server
    init_db()
    app.run(host='0.0.0.0', debug=True, port=5000)
