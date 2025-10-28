# Deployment Guide for Coolify

This guide will help you deploy the Journal App to Coolify.

## Prerequisites

1. A Coolify instance set up and running
2. A PostgreSQL database (can be created through Coolify)
3. Your GitHub repository with the code

## Step 1: Set up Database in Coolify

1. In Coolify, create a new PostgreSQL database service
2. Note down the connection details (DATABASE_URL, or individual host, port, username, password, database)

## Step 2: Create New Application in Coolify

1. Go to your Coolify dashboard
2. Click "New Resource" → "Application"
3. Choose your source (GitHub repository)
4. Select your repository: `journal_app`
5. Select the branch: `main` (or your default branch)

## Step 3: Configure Build Settings

Coolify should auto-detect the Dockerfile. Ensure:
- **Build Pack**: Dockerfile
- **Dockerfile Path**: `./Dockerfile` (default)
- **Build Command**: (leave empty, Dockerfile handles this)

## Step 4: Configure Environment Variables

In Coolify, add these environment variables:

### Required Variables:

```
RAILS_ENV=production
RAILS_MASTER_KEY=<your_master_key_here>
DATABASE_URL=<your_postgres_connection_string>
# OR use individual database variables:
# DATABASE_HOST=<database_host>
# DATABASE_PORT=5432
# DATABASE_USERNAME=<database_user>
# DATABASE_PASSWORD=<database_password>
# DATABASE_NAME=<database_name>
```

### Optional Variables:

```
RAILS_LOG_TO_STDOUT=true
RAILS_SERVE_STATIC_FILES=true
RAILS_MAX_THREADS=5
```

### Getting RAILS_MASTER_KEY:

1. **If you have the key locally:**
   ```bash
   # On your local machine
   cat config/master.key
   ```

2. **If you need to create a new one:**
   ```bash
   # Generate a new key
   rails secret
   # Then update it in Coolify
   ```

## Step 5: Configure Ports

- **Exposed Port**: 80 (as defined in Dockerfile)
- **Internal Port**: 80

## Step 6: Configure Health Check

- **Health Check Path**: `/up`
- **Health Check Port**: 80

## Step 7: Deploy

1. Click "Deploy" in Coolify
2. Monitor the build logs
3. Once deployed, your app will be available at the URL provided by Coolify

## Step 8: Run Database Migrations

After the first deployment, run migrations:

1. In Coolify, go to your application
2. Open the "Console" or "Execute Command" section
3. Run:
   ```bash
   rails db:migrate
   ```

Alternatively, migrations will run automatically on startup (handled by docker-entrypoint).

## Troubleshooting

### Database Connection Issues

- Verify DATABASE_URL or individual database variables are correct
- Ensure the database service is running in Coolify
- Check database allows connections from your app container

### Master Key Issues

- Ensure RAILS_MASTER_KEY is set correctly
- If you get encryption errors, you may need to regenerate credentials:
  ```bash
  EDITOR=nano rails credentials:edit
  ```

### Build Failures

- Check build logs in Coolify
- Ensure Dockerfile is valid
- Verify all required files are in the repository

### App Won't Start

- Check application logs in Coolify
- Verify all environment variables are set
- Ensure database is accessible from the app container

## Post-Deployment

1. **Create an admin user** (if needed):
   - Access the application URL
   - Use the sign-up page to create your first user

2. **Set up a custom domain** (optional):
   - In Coolify, configure your domain
   - Update DNS records as instructed

3. **Enable HTTPS** (recommended):
   - Coolify can automatically provision SSL certificates
   - Enable it in the application settings

## Notes

- The app uses Devise for authentication
- Static files are served by the app (via Propshaft)
- The app uses Solid Cache, Solid Queue, and Solid Cable for Rails 8 features
- Bootstrap is loaded via CDN in the views

