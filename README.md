#REMINDER FOR START : Please insert your appropriate API key for LLM the request at start can be of default for testing, First insert your API in .env file
# FinBase AI Customer Support Assistant 🏦🤖

A full-stack Retrieval-Augmented Generation (RAG) powered Customer Support Assistant built for FinBase Technologies. This application helps users query complex financial policies (Credit Cards, Loans, Mutual Funds, Savings Accounts) and provides accurate, grounded answers with source citations.

## 🌟 Key Features
- **Grounded Answers:** Answers are generated strictly from the provided knowledge base.
- **Source Citations:** Every answer includes exact references (document name, chunk relevance).
- **Hallucination Mitigation:** Explicitly states when information is not available in the context.
- **Streaming UI:** Real-time typewriter effect via Server-Sent Events (SSE).
- **Responsive Design:** Beautiful, dark-themed FinTech UI built with React & Tailwind CSS.

---

## 🏗️ System Architecture

**RAG Pipeline Flow:**
`User Query → Local Embedding Generation → Vector Similarity Search (ChromaDB) → Extractive Answer from Retrieved Text → Streamed Response`

### Tech Stack Details:
| Component | Technology | Justification |
|-----------|-----------|---------------|
| **Backend API** | FastAPI (Python) | High performance, async support (great for streaming), auto-generated Swagger docs. |
| **Document pipeline** | LangChain | Loads, chunks, and retrieves the local knowledge base. |
| **Vector Database** | ChromaDB | Persistent local vector store; fast, open-source, no external DB required. |
| **Embeddings** | `sentence-transformers/all-MiniLM-L6-v2` | Lightweight, runs locally, excellent for semantic search, no API costs. |
| **Answer generation** | Local extractive sentence ranking | Uses sentences from retrieved knowledge base documents; no API key or token quota required. |
| **Chunking** | RecursiveCharacterTextSplitter | Preserves semantic paragraph structure better than fixed-size token chunking. |
| **Frontend UI** | React + Vite + Tailwind CSS | Modern component-based UI, lightning-fast HMR, highly responsive utility styling. |

---

## 🚀 Setup Instructions

### Prerequisites
- Python 3.11+
- Node.js 18+ (for frontend)
- Docker (optional, for containerized deployment)

### 1. Backend Setup
```bash
cd backend

# Create a virtual environment
python -m venv venv
# Activate it (Windows)
venv\Scripts\activate
# Activate it (Mac/Linux)
# source venv/bin/activate

# Install dependencies
pip install -r requirements.txt

# Create .env file from template (optional; defaults work locally)
cp ../.env.example .env
```

**Run the Backend Server:**
```bash
uvicorn app.main:app --reload --port 8000
```
*The backend will automatically load the documents from `backend/data/knowledge_base`, chunk them, and index them in ChromaDB on first startup.*

### 2. Frontend Setup
```bash
cd frontend

# Install dependencies
npm install

# Run development server
npm run dev
```
*The app will be available at `http://localhost:5173`. It automatically proxies API requests to the backend.*

---

## 🐳 Docker Deployment (Alternative)
You can run the entire stack using Docker Compose:
```bash
# Run the local document assistant:
docker-compose up --build -d
```
- Frontend: `http://localhost:3000`
- Backend API: `http://localhost:8000`

---

## 📚 Environment Variable Documentation
Located in `backend/.env`:

- `LLM_PROVIDER` (Default: `local`): Answers are generated from retrieved local document text.
- `CHROMA_PERSIST_DIR` (Default: `./chroma_db`): Where the vector database saves its files.
- `EMBEDDING_MODEL` (Default: `all-MiniLM-L6-v2`): The HuggingFace sentence-transformer model.
- `CHUNK_SIZE` (Default: `1000`): Number of characters per document chunk.
- `CHUNK_OVERLAP` (Default: `200`): Character overlap between chunks to preserve context.
- `TOP_K_RESULTS` (Default: `5`): Number of chunks retrieved per query.

---

## 📖 API Documentation
Once the backend is running, visit **`http://localhost:8000/docs`** for interactive Swagger UI documentation.

**Key Endpoints:**
- `POST /api/query`: Standard synchronous query. Returns JSON with answer, sources, and confidence.
- `POST /api/query/stream`: Streaming endpoint (SSE) for real-time text generation.
- `GET /api/stats`: Returns vector database indexing statistics.
- `GET /api/sources`: Lists all available documents in the knowledge base.
- `GET /api/health`: Application health check.
- `POST /api/evaluate`: Runs the evaluation test suite against the RAG pipeline.

---

## 🧪 Evaluation Metrics
The system includes built-in RAG evaluation (`backend/app/evaluation/`):
- **Retrieval Relevance:** Checks cosine similarity between the query and retrieved chunks.
- **Answer Groundedness:** Measures if the generated answer is strictly bounded by the retrieved context.
- **Citation Accuracy:** Validates if the sources cited by the LLM match the actual retrieved contexts.
