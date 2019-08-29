import paho.mqtt.client as mqtt
import time
import socket
from picamera import PiCamera
from time import sleep

deviceName = socket.gethostname()

camera = PiCamera()
camera.rotation = 180
camera.start_preview()
# camera warm up time
sleep(2) 

mqttServer = "192.168.57.2"
mqttPath = "lunaflow"

# callback for CONNACK (connection acknowledgement)response
def on_connect(client, userdata, flags, rc):
	print('Connected to device.')
	client.subscribe(mqttPath)


# callback for publish message received from server
def on_message(client, userdata, msg):
	print(msg.topic+" "+str(msg.payload))
	
	if msg.payload == 'test':
		publish.single(mqttPath, "test successful", hostname=mqttServer)

	if msg.payload[0:8] == 'snapshot':
		camera.capture('lunaflow_temp/frame.jpg')
		print('Image acquired.')

	if msg.payload[0:5] == 'video':

		print('Acquiring video...')

		try:
			index_ts = msg.payload.find('-t')+3
            index_tf = index_ts + msg.payload[index_ts:].find(' ')
			recording_time = float(msg.payload[index_ts:index_tf])
		except:
			recording_time = 5.0
        
		try:
			index_fs = msg.payload.find('-f')+3
            index_ff = index_fs + msg.payload[index_fs:].find(' ')
			recording_time = float(msg.payload[index_fs:index_ff])
		except:
			selected_format = 'h264'

        
		print('Recording for ' + str(recording_time) + 's...')
		camera.start_recording('lunaflow_temp/video', format=selected_format)
		camera.wait_recording(recording_time)
		camera.stop_recording()
		print('Video acquired.')

	if msg.payload == 'break':
		print('Breaking out of subscriber.')
		quit()

	

client = mqtt.Client()
client.on_connect = on_connect
client.on_message = on_message

client.connect(mqttServer, 1883, 60)

client.loop_forever()


