import Foundation

func formatTimezone(seconds: TimeInterval) -> String {
    let formatter = DateComponentsFormatter()
    formatter.unitsStyle = .full
    formatter.allowedUnits = [.hour, .minute]
    return formatter.string(from: seconds) ?? ""
}
