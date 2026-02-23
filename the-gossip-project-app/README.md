# The Gossip Project App

A Ruby on Rails application that implements a small social "gossip" platform — users can create gossips, tag them, like content, leave comments and send private messages. The repository includes production-ready Docker configuration and simple PWA support.

## Key features
- **Authentication & user profiles** — User registration, login/logout with password hashing, and "remember me" functionality for persistent sessions
- **Gossips** — Create, view, edit, and delete gossips with color-coded tags (many-to-many via join table)
- **Social interactions** — Like gossips and comments (polymorphic likes), leave comments with reply functionality
- **Private messages** — Send messages between users
- **User management** — User profiles, city associations, team member administration with LinkedIn/GitHub links
- **UI/UX** — Responsive navbar with authentication status display, jumbotron with logo, improved image handling in comments
- **Testing & analysis** — Unit and integration tests (Minitest), system tests, RuboCop linting, and Brakeman security scanning
- **Production-ready** — Dockerfile for containerized builds and `bin/dev` for local development

## Tech stack
- Ruby 3.4.2 (`.ruby-version`)
- Rails ~> 8.0.4 (`Gemfile`)
- SQLite (development/test)
- Importmap / Turbo / Stimulus for frontend interactions

## Requirements
- Ruby 3.4.2
- Bundler
- SQLite3 (for local development)
- Docker (optional, for container builds)

## Quick start (development)
1. Install Ruby 3.4.2 and Bundler
2. Install gems:

   bundle install

3. Prepare the database and seed data:

   rails db:setup

4. Start the app (local dev server):

   ./bin/dev

5. Open http://localhost:3000

## Running the test suite
- Unit and integration tests:

  rails test

- System tests (require a browser driver like Chrome + chromedriver):

  rails test:system

## Linting & security scans
- Run RuboCop (project includes rubocop config):

  bundle exec rubocop

- Run Brakeman for security analysis:

  bundle exec brakeman

## Docker (production build)
Build and run the production image (set `RAILS_MASTER_KEY` if required):

  docker build -t the_gossip_project_app .
  docker run -d -p 80:80 -e RAILS_MASTER_KEY=<your-master-key> --name gossip-app the_gossip_project_app

The `Dockerfile` is production-oriented (see comments in the file). For local containerized development, consider using a devcontainer or Kamal.

## Configuration & secrets
- Local dev credentials are present at `config/master.key` for convenience. For CI/production, use the `RAILS_MASTER_KEY` environment variable.
- Database config: `config/database.yml`

## Useful files
- `Dockerfile` — production container build
- `bin/dev` — development server
- `db/seeds.rb` — seed data
- `config/master.key` — local credentials (do NOT commit a real production key)
- `app/views/pwa/manifest.json.erb` — PWA manifest (optional)

## Contributing
- Fork the repository, create a topic branch, add tests for new behavior and open a pull request. Ensure `rails test` passes before submitting.

## Project Status
✅ **COMPLETE** — Core features are fully implemented. This project serves as a foundation for a small social "gossip" platform with all essential functionality (authentication, gossips, comments, likes, messaging, team management) working end-to-end. The app is production-ready with Docker support and can be extended for additional features as needed.

## Deployment notes
- The repo contains a production-ready Dockerfile. Ensure `RAILS_MASTER_KEY` and any production DB credentials are set in the deployment environment.

## License
No license file is included in this repository. Add a `LICENSE` file to declare terms for reuse.

## Support
Open an issue in this repository with reproducible steps and test output for any bugs or feature requests.
