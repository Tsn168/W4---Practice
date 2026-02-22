import 'package:flutter/material.dart';
import 'download_controler.dart';

class DownloadTile extends StatefulWidget {
  final DownloadController controller;

  const DownloadTile({super.key, required this.controller});

  @override
  State<DownloadTile> createState() => _DownloadTileState();
}

class _DownloadTileState extends State<DownloadTile> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onControllerChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onControllerChanged);
    super.dispose();
  }

  void _onControllerChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /// LEFT SIDE
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.controller.ressource.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  if (widget.controller.status == DownloadStatus.downloading ||
                      widget.controller.status == DownloadStatus.downloaded)
                    Text(
                      "${(widget.controller.progress * 100).toStringAsFixed(1)}% "
                      "completed - "
                      "${(widget.controller.progress * widget.controller.ressource.size).toStringAsFixed(1)} "
                      "of ${widget.controller.ressource.size} MB",
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                ],
              ),
            ),

            widget.controller.status == DownloadStatus.notDownloaded
                ? IconButton(
                    icon: const Icon(Icons.download),
                    onPressed: () => widget.controller.startDownload(),
                  )
                : widget.controller.status == DownloadStatus.downloading
                ? const Icon(Icons.downloading)
                : const Icon(Icons.check_circle, color: Colors.green),
          ],
        ),
      ),
    );
  }
}
