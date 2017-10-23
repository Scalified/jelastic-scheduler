#!/bin/sh                                                                                                                   
                                                                                                                            
JELASTIC_BIN=~/jelastic/environment/control
JELASTIC_AUTHENTICATION=~/jelastic/users/authentication                                                                                 
COMMAND_EXECUTION_TIMEOUT=45                                                                                                
                                                                                                                            
login() {
  echo "[INFO][$(date -u)]: Starting Logging to the cloud ..."
  timeout ${COMMAND_EXECUTION_TIMEOUT} bash ${JELASTIC_AUTHENTICATION}/signin --login ${JELASTIC_LOGIN} --password ${JELASTIC_PASSWORD} --platformUrl app.mircloud.host --silent true

  if [ $? == 0 ]; then
     echo "[INFO][$(date -u)]: Successfully logged-in to the cloud."
    else
     echo "[INFO][$(date -u)]: Failed to log-in to the cloud."
    fi
}                                                                           
                                                                                                                            
start() {                                                                                                                   
  login

  for jelastic_environment in ${ENVIRONMENTS}                                                                               
  do                                                                                                                        
    echo "[INFO][$(date -u)]: Starting ${jelastic_environment} environment..."
    timeout ${COMMAND_EXECUTION_TIMEOUT} ${JELASTIC_BIN}/startenv --envName ${jelastic_environment} --silent true           
                                                                                                                            
    if [ $? == 0 ]; then                                                                                                    
     echo "[INFO][$(date -u)]: Environment ${jelastic_environment} has been successfully started."
    else                                                                                                                    
     echo "[INFO][$(date -u)]: Failed to start ${jelastic_environment} environment in ${COMMAND_EXECUTION_TIMEOUT} seconds."
    fi                                                                                                                      
                                                                                                                            
  done
                                                                                                                        
}                                                                                                                           
                                                                                                                            
stop() {                                                                                                                    
  login
                                                                                                                            
  for jelastic_environment in ${ENVIRONMENTS}                                                                               
  do                                                                                                                        
    echo "[INFO][$(date -u)]: Stopping ${jelastic_environment} environment..."
    timeout ${COMMAND_EXECUTION_TIMEOUT} ${JELASTIC_BIN}/stopenv --envName ${jelastic_environment} --silent true                                                     
    
    if [ $? == 0 ]; then                                                                                                    
     echo "[INFO][$(date -u)]: Environment ${jelastic_environment} has been successfully stopped."
    else                                                                                                                    
     echo "[INFO][$(date -u)]: Failed to stop ${jelastic_environment} environment in ${COMMAND_EXECUTION_TIMEOUT} seconds."
    fi                                     
  done                                                                                                                      
}                                                                                                                           
                                                                                                                            
$@