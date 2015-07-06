package org.linphone.openfire;

import org.jivesoftware.smack.*;
import org.jivesoftware.smack.filter.MessageTypeFilter;
import org.jivesoftware.smack.filter.PacketFilter;
import org.jivesoftware.smack.packet.Message;
import org.jivesoftware.smack.packet.Packet;
import org.jivesoftware.smack.packet.Presence;
import org.jivesoftware.smack.util.StringUtils;
import org.linphone.R;
import org.linphone.mediastream.Log;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.view.View;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.Toast;


public class openfireMain extends Activity{
	public EditText username, password;
	private ImageView apply;
	private static XMPPConnection connection;
	
    @Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		
		setContentView(R.layout.openfire_login);
		
		username = (EditText) findViewById(R.id.setup_username);
		password = (EditText) findViewById(R.id.setup_password);
		
		apply = (ImageView) findViewById(R.id.openfire_login);
		
		apply.setOnClickListener(new ImageView.OnClickListener(){ 

            @Override

            public void onClick(View v) {

                // TODO Auto-generated method stub

            	int id = v.getId();
        		Log.i("william","start here");
        		if (id == R.id.openfire_login) {
        			if (username.getText() == null || username.length() == 0 || password.getText() == null || password.length() == 0 ) {
        				//Toast.makeText(getActivity(), getString(R.string.first_launch_no_login_password), Toast.LENGTH_LONG).show();
        				Log.i("william","error here");
        				return;
        			}
        			
        			//SetupActivity.instance().genericLogIn(login.getText().toString(), password.getText().toString(), domain.getText().toString());
        			
        			openfireConnectThread thread = new openfireConnectThread();
        			thread.start();
        			
        		}

            }         

        });     
		
		//openfire_login
		
		
	}
    
    private class openfireConnectThread extends Thread {
		@Override
		public void run() {
			super.run();
				final ConnectionConfiguration config = new ConnectionConfiguration("192.168.0.112",Integer.parseInt("5222"));
		        //允許自動連接
		        config.setReconnectionAllowed(true);
		        config.setSendPresence(true);
		        AccountManager accountManager;
		        connection = new XMPPConnection(config);
		        try {
					connection.connect();
				} catch (XMPPException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
	            
		        
		        accountManager = connection.getAccountManager();

		        
		        try {
			         connection.login(username.getText().toString(), password.getText().toString());
			         Log.i("william", "Logged in as " + connection.getUser());
			
			         // Set the status to available
			         Presence presence = new Presence(Presence.Type.available);
			         connection.sendPacket(presence);
			        // xmppClient.setConnection(connection);
			         setConnection(connection);

			     } catch (XMPPException ex) {
			         Log.e("william", "[SettingsDialog] Failed to log in as " + username);
			         Log.e("william", ex.toString());
			             //xmppClient.setConnection(null);
			         setConnection(null);
			     }
		        
		        

		}
	}
    
    
    public void XMPPSendText(String to,String istr)
    {
		//Server name , can't be removed here.
		String Reci = to+"@@server/Smack";
        String text = istr;

        Log.i("william", "Sending text [" + text + "] to [" + Reci + "]");
        Message msg = new Message(Reci, Message.Type.chat);
        msg.setBody(text);
        connection.sendPacket(msg);

    }
    
    public void setConnection(XMPPConnection connection) {
		if (connection != null) {
		    // Add a packet listener to get messages sent to us
		    PacketFilter filter = new MessageTypeFilter(Message.Type.chat);
		    connection.addPacketListener(new PacketListener() {
				@Override
				public void processPacket(Packet packet) {
					// TODO Auto-generated method stub
		            Message message = (Message) packet;
		            if (message.getBody() != null) {
		                String fromName = StringUtils.parseBareAddress(message.getFrom());
		                Log.i("william", " Enter xmpp receive thread from name " +  fromName);
		                
		               
		                
		                //We receive message here.
		                
		            }
				}
		    }, filter);
		}
    }
    
    
   
	
	
}
