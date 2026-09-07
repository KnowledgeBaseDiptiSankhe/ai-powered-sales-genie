###
-- command to download the official pre-built images from Docker Hub and 
-- spin up all nine container layers in detached background mode
docker compose up -d
echo "All nine container layers are up and running, cross chcek the status again"
docker compose ps

-- The Ollama container installs completely blank. 
-- Will explicitly download the models you want to use for generation and vector creation.
# Pull the text embedding model (used in our n8n workflow)
docker exec -it ollama ollama pull nomic-embed-text

# Pull a lightweight LLM for generation/chat tasks
docker exec -it ollama ollama pull llama3.2

#Open your browser and navigate to pgAdmin at http://localhost:5050
#Open your browser and navigate to pgAdmin at http://localhost:5050.Log in using admin@local.host and adminpassword.Right-click Servers > Register > Server...Under General, name it Local App DB.Under Connection, enter the following details and save:Host name/address: postgres-app (This is the internal Docker DNS name)Port: 5432Maintenance database: app_databaseUsername: app_userPassword: app_passwordOnce connected, expand your server, click on app_database, click Tools in the top menu, and select Query Tool.Execute the vector initialization script:sqlCREATE EXTENSION IF NOT EXISTS vector;
#Use code with caution.Step 7: Access and Use Your StackYour local AI sandbox is completely up and running. You can now visit any panel in your browser:n8n Automation: http://localhost:5678 (Import your JSON workflow here)Langflow Visual Agent Builder: http://localhost:7860Langfuse Observability Panel: http://localhost:3000Mongo Express Dashboard: http://localhost:8081 