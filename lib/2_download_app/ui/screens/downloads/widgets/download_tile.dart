// import 'package:flutter/material.dart';

// import 'download_controler.dart';

// class DownloadTile extends StatelessWidget {
//   const DownloadTile({super.key, required this.controller});

//   final DownloadController controller;

//  // TODO

//   @override
//   Widget build(BuildContext context) {
//     return Placeholder();

//     // TODO
//   }
// }
import 'package:flutter/material.dart';

import 'download_controler.dart';

class DownloadTile extends StatefulWidget {
  const DownloadTile({super.key, required this.controller});

  final DownloadController controller;

  @override
  State<DownloadTile> createState() => _DownloadTileState();
}

class _DownloadTileState extends State<DownloadTile> {
  @override
  void initState() {
    super.initState();
    // Listen to controller changes
    widget.controller.addListener(_onControllerChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onControllerChanged);
    super.dispose();
  }

  void _onControllerChanged() {
    setState(() {}); // Rebuild when controller changes
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              widget.controller.ressource.name,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            // Size info
            Text(
              "${widget.controller.ressource.size} MB",
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 16),

            // Status-based UI
            if (widget.controller.status == DownloadStatus.notDownloaded)
              ElevatedButton(
                onPressed: () => widget.controller.startDownload(),
                child: const Text("Download"),
              )
            else if (widget.controller.status == DownloadStatus.downloading)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LinearProgressIndicator(
                    value: widget.controller.progress,
                    minHeight: 8,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "${(widget.controller.progress * 100).toStringAsFixed(0)}% (${(widget.controller.progress * widget.controller.ressource.size).toStringAsFixed(2)} MB / ${widget.controller.ressource.size} MB)",
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              )
            else if (widget.controller.status == DownloadStatus.downloaded)
              Row(
                children: [
                  const Icon(Icons.check_circle, color: Colors.green),
                  const SizedBox(width: 8),
                  const Text("Downloaded"),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
