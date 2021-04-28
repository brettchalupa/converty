RSpec.describe "CLI" do
  it "outputs help docs" do
    expect { system("./exe/converty --help") }
      .to output(a_string_including("Convert between different units"))
      .to_stdout_from_any_process
  end

  it "does not output to stderr with required flags" do
    expect { system("./exe/converty 5 --from km --to mi") }
      .to_not output
      .to_stderr_from_any_process
  end

  it "converts between kilometers and miles" do
    expect { system("./exe/converty 5 --from km --to mi") }
      .to output("3.1068560606060607\n")
      .to_stdout_from_any_process
  end

  it "supports the round argument" do
    expect { system("./exe/converty 5 --from km --to mi --round 1") }
      .to output("3.1\n")
      .to_stdout_from_any_process
  end

  it "converts between inches and ft" do
    expect { system("./exe/converty 24 --from in --to ft") }
      .to output("2.0\n")
      .to_stdout_from_any_process
  end

  it "outputs errors for invalid unit types" do
    expect { system("./exe/converty 5 --from bx --to mi") }
      .to output(a_string_including("bx is an invalid unit"))
      .to_stderr_from_any_process
  end

  it "outputs errors for missing required args" do
    expect { system("./exe/converty 5") }
      .to output(a_string_including("--to arg is required, --from arg is required"))
      .to_stderr_from_any_process
  end

  it "outputs errors for missing amount arg" do
    expect { system("./exe/converty") }
      .to output(a_string_including("amount arg is required, --to arg is required, --from arg is required"))
      .to_stderr_from_any_process
  end
end
