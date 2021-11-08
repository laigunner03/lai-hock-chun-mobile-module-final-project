import 'package:flutter/material.dart';
import 'package:lai_hock_chun_mobile_module_final_project/post.dart';
import 'package:web_socket_channel/io.dart';
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'dart:io';

final channel = IOWebSocketChannel.connect('ws://besquare-demo.herokuapp.com');
Stream streamchannel = channel.stream.asBroadcastStream();
late String username;
