import os
import sys
import traceback
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / "backend"))

os.environ.pop("FIREBASE_CREDENTIALS_PATH", None)
os.environ.pop("GOOGLE_APPLICATION_CREDENTIALS", None)

from app import firebase_gateway  # noqa: E402
from app.config import get_settings  # noqa: E402


def main() -> int:
    get_settings.cache_clear()
    settings = get_settings()
    print("SETTINGS firebase_credentials_path=%r google_application_credentials=%r"
          % (settings.firebase_credentials_path, settings.google_application_credentials))
    print("ENV FIREBASE_CREDENTIALS_PATH=%r GOOGLE_APPLICATION_CREDENTIALS=%r"
          % (os.getenv("FIREBASE_CREDENTIALS_PATH"), os.getenv("GOOGLE_APPLICATION_CREDENTIALS")))
    print("--- firestore_credentials_configured() ---")
    print("result:", firebase_gateway.firestore_credentials_configured())
    print("--- firestore_client() ---")
    try:
        client = firebase_gateway.firestore_client()
        print("client:", type(client).__name__)
    except Exception as error:
        print("EXC TYPE:", type(error).__name__)
        print("EXC MSG:", str(error))
        print("TRACEBACK:")
        traceback.print_exc()
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
