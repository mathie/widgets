namespace :docker do
  task :build => ['docker:build:web', 'docker:build:app', 'assets:clobber']

  namespace :build do
    task :app => ['assets:precompile', 'assets:clean'] do
      sh 'docker build -t "mathie/widgets:latest" -f Dockerfile.app .'
    end

    task :web => ['assets:precompile', 'assets:clean'] do
      sh 'docker build -t "mathie/widgets-web:latest" -f Dockerfile.web .'
    end
  end

  task :run => ['docker:run:db', 'docker:run:app', 'docker:run:web']

  namespace :run do
    task :db do
      sh <<-SHELL
        docker run -d \
          --name postgres \
          postgres
      SHELL
    end

    task :app do
      sh <<-SHELL
        docker run -d \
          --name widgets \
          --link "postgres:postgres" \
          mathie/widgets:latest
      SHELL
    end

    task :web do
      sh <<-SHELL
        docker run -d \
          --name widgets_web \
          -p 80:80 \
          --link "widgets:widgets" \
          mathie/widgets-web:latest
      SHELL
    end
  end

  task :terminate do
    [:stop, :rm].each do |command|
      [:widgets_web, :widgets, :postgres].each do |container|
        sh "docker #{command} #{container} || true"
      end
    end
  end
end