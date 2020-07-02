# frozen_string_literal: true

require 'cocoapods'

def xcframework_create(sandbox, target)
  archive(sandbox, target, 'iOS Simulator')
  archive(sandbox, target, 'iOS')

  args = %w[-create-xcframework]
  args += %W[-framework #{framework_path(archive_path(sandbox, target, 'iOS Simulator'), target)}]
  args += %W[-framework #{framework_path(archive_path(sandbox, target, 'iOS'), target)}]
  args += %W[-output #{xcframework_path(sandbox, target)}]
  Pod::UI.puts "Create #{target}.xcframework to #{xcframework_path(sandbox, target)}"
  Pod::Executable.execute_command 'xcodebuild', args, true
end

def archive(sandbox, target, platform)
  Pod::UI.puts "Archive #{target} on #{platform}"
  # /*/*/Pods/Pods.xcodeproj
  args = %w[archive]
  args += %W[-project #{sandbox.project_path.realdirpath}]
  # AFNetworing
  args += %W[-scheme #{target}]
  # generic/platform=iOS
  args += %W[-destination generic/platform=#{platform}]
  # archivePath
  args += %W[-archivePath #{archive_path(sandbox, target, platform)}]
  args += %w[SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES]

  Pod::Executable.execute_command 'xcodebuild', args, true
end

def archive_path(sandbox, target, platform)
  "#{sandbox.root.realdirpath}/Archive/#{target}_#{platform}"
end

def framework_path(archive_path, target)
  "#{archive_path}.xcarchive/Products/Library/Frameworks/#{target}.framework"
end

def xcframework_path(sandbox, target)
  "#{sandbox.root.realdirpath}/Archive/#{target}.xcframework"
end
