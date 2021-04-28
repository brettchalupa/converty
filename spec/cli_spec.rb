RSpec.describe "Converty CLI" do
  it "supports the --help flag" do
    command = "./exe/converty --help"

    expect { system(command) }
      .to_not output
      .to_stderr_from_any_process

    expect { system(command) }
      .to output(a_string_including("Convert an amount between unit types"))
      .to_stdout_from_any_process
  end

  it "supports converting kilometers to miles with rounding" do
    command = "./exe/converty 5 --from km --to mi --round 2"

    expect { system(command) }
      .to_not output
      .to_stderr_from_any_process

    expect { system(command) }
      .to output("3.11\n")
      .to_stdout_from_any_process
  end

  it "supports converting kilometers to miles" do
    command = "./exe/converty 2 --from ft --to in"

    expect { system(command) }
      .to_not output
      .to_stderr_from_any_process

    expect { system(command) }
      .to output("24.0\n")
      .to_stdout_from_any_process
  end

  it "requires an amount to be specified" do
    command = "./exe/converty"

    expect { system(command) }
      .to output(a_string_including("amount parameter required"))
      .to_stderr_from_any_process
  end

  it "requires the from and to args be specified" do
    command = "./exe/converty 10"

    expect { system(command) }
      .to output(a_string_including("--from parameter required, --to parameter required"))
      .to_stderr_from_any_process
  end

  it "requires valid units" do
    command = "./exe/converty 10 --from fx --to km"

    expect { system(command) }
      .to output(a_string_including("fx is an invalid unit"))
      .to_stderr_from_any_process
  end
end
