package main

import (
	"flag"
	"fmt"
	"io/ioutil"
	"os"

	"gopkg.in/yaml.v2"
)

// Config struct for webapp config
type Config struct {
	GoEnv string `yaml:"go_env"`
	Debug bool   `yaml:"debug"`
}

// LoadConfig ...
func LoadConfig(configPath string) (*Config, error) {
	config := &Config{}

	tmpl, err := ioutil.ReadFile(configPath)
	if err != nil {
		return nil, err
	}
	tmpl = []byte(os.ExpandEnv(string(tmpl)))

	err = yaml.Unmarshal(tmpl, config)
	if err != nil {
		return nil, err
	}

	return config, nil
}

// ValidateConfigPath ...
func ValidateConfigPath(path string) error {
	s, err := os.Stat(path)
	if err != nil {
		return err
	}
	if s.IsDir() {
		return fmt.Errorf("'%s' is a directory, not a normal file", path)
	}
	return nil
}

// ParseFlags ...
func ParseFlags() (string, error) {
	var configPath string

	flag.StringVar(&configPath, "config", "./config.yml", "path to config file")

	flag.Parse()

	if err := ValidateConfigPath(configPath); err != nil {
		return "", err
	}

	return configPath, nil
}
