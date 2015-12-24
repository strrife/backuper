<?php
/**
 * Created by PhpStorm.
 * User: strrife
 * Date: 12/25/15
 * Time: 12:54 AM
 */

define("DIR", dirname(__FILE__) . '/');
error_reporting(E_ALL);
ini_set('display_errors', 1);

abstract class UploadService {

    public function __construct()
    {
        $this->maybeInit();
    }

    protected function maybeInit(){
        $this->maybeInstallDependencies();
        $this->checkAuthFile();
        require_once $this->getAutoloadPath();
    }

    /**
     * Installs composer package if needed
     */
    protected function maybeInstallDependencies()
    {
        if (!file_exists($this->getAutoloadPath())) {
            mkdir(DIR . $this->getName());
            shell_exec(
                "cd " . DIR . $this->getName() . " ; " .
                "curl -sS https://getcomposer.org/installer | php ; " .
                "php composer.phar require {$this->getLib()}"
            );
        }
    }

    /**
     * @return string
     */
    public function getAutoloadPath()
    {
        return DIR . $this->getName() . '/vendor/autoload.php';
    }

    protected function checkAuthFile()
    {
        $authFilePath = $this->getAuthFilePath();
        if (!file_exists($authFilePath)) {
            throw new Exception(
                "No auth file! " . PHP_EOL .
                "You need to create {$this->getName()}.json file and specify the server auth key there." .
                "Check out the readme for more details"
            );
        }
    }

    public abstract function upload($file);

    /**
     * @return string
     */
    protected function getAuthFilePath()
    {
        return DIR . $this->getName() . '.json';
    }

    protected abstract function getName();
    protected abstract function getLib();
}

class DropboxUploadService extends UploadService {

    public function upload($file)
    {
        $authStuff = json_decode(file_get_contents($this->getAuthFilePath()));
        $dbxClient = new \Dropbox\Client($authStuff->token, "PHP-Example/1.0");
        $f = fopen($file, "rb");
        $dbxClient->uploadFile('/' . basename($file), \Dropbox\WriteMode::add(), $f);
    }

    protected function getName()
    {
        return 'dropbox';
    }

    protected function getLib()
    {
        return 'dropbox/dropbox-sdk';
    }
}

$service = ucfirst($argv[1]) . "UploadService";
$file = $argv[2];
if(class_exists($service) && file_exists($file)){
    /** @var UploadService $instance */
    $instance = new $service;
    $instance->upload($file);
}