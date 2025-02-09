import 'dart:io';

import 'package:creative_movers/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddImageWidget extends StatefulWidget {
  const AddImageWidget(
      {Key? key,
      this.ImageBgradius = 70,
      this.Imageradius = 65,
      this.IconBgradius = 25,
      this.Iconradius = 22,
      this.iconSize = 24,
      this.iconBgCOlor = AppColors.primaryColor,
      this.imagePath,
      this.onUpload})
      : super(key: key);
  final double ImageBgradius;
  final double Imageradius;
  final double IconBgradius;
  final double Iconradius;
  final double iconSize;
  final Color iconBgCOlor;
  final String? imagePath;
  final VoidCallback? onUpload;

  @override
  _AddImageWidgetState createState() => _AddImageWidgetState();
}

class _AddImageWidgetState extends State<AddImageWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            radius: widget.ImageBgradius,
            backgroundColor: AppColors.lightBlue,
            child: CircleAvatar(
              child: Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(200),
                  child: Image.file(
                    File(widget.imagePath!),
                    fit: BoxFit.cover,
                    width: 200,
                  ),
                ),
              ),
              radius: widget.Imageradius,
            ),
          ),
          Positioned(
            right: -5,
            bottom: 7,
            child: InkWell(
              onTap: widget.onUpload,
              child: CircleAvatar(
                radius: widget.IconBgradius,
                backgroundColor: AppColors.lightBlue,
                child: CircleAvatar(
                  radius: widget.Iconradius,
                  backgroundColor: widget.iconBgCOlor,
                  child: Icon(
                    Icons.photo_camera_rounded,
                    size: widget.iconSize,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
