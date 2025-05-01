using System;
using System.IO.Ports;
using Microsoft.AspNetCore.Mvc;

[Route("api/[controller]")]
[ApiController]
public class LightSensorController : ControllerBase
{
    private static SerialPort _serialPort;

    public LightSensorController()
    {
        if (_serialPort == null)
        {
            _serialPort = new SerialPort("COM3", 9600); // Change COM3 to match your port
            _serialPort.Open();
        }
    }

    [HttpGet("read")]
    public IActionResult ReadSensor()
    {
        if (!_serialPort.IsOpen)
        {
            return StatusCode(500, "Serial port is closed.");
        }

        try
        {
            string data = _serialPort.ReadLine();
            return Ok(data);
        }
        catch (Exception ex)
        {
            return StatusCode(500, $"Error reading from serial port: {ex.Message}");
        }
    }

    ~LightSensorController()
    {
        if (_serialPort != null && _serialPort.IsOpen)
        {
            _serialPort.Close();
        }
    }
}
