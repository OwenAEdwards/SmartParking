namespace SmartParking.Models;

public class ErrorResponseModel
{
    public string? RequestId { get; set; }

    public bool ShowRequestId => !string.IsNullOrEmpty(RequestId);
}