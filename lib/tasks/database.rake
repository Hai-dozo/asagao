namespace :db do
    desc "Rebuild the development database from scrach"
    task :rebuild => :environment do
        sh "rm -f /development.sqlite3"
        Rake::Task["db:migrate"].invoke
        Rake::Task["db:seed"].invoke
    end
end

