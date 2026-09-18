docker compose up -d
echo "All nine container layers are up and running, cross chcek the status again"
docker compose ps
docker exec -it ollama ollama pull nomic-embed-text
docker exec -it ollama ollama pull llama3.2

# @REM docker run -it  --name n8n \ -p 5678:5678 \ -e N8N_CORS_ALLOWED_ORIGINS="*" \ n8nio/n8n
