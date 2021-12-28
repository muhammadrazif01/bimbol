import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pbpbimbol/forum/models.dart';
import 'package:http/http.dart' as http;

class Util {
  static var data, dataForum, dataReply;

  static Future<List<Forum>> fetchData() async {
    const url = '$domain/forum/json';
    try {
      print("masuk");
      final response = await http.get(Uri.parse(url));
      Map<String, dynamic> extractedData = jsonDecode(response.body);
      dataForum = extractedData['data_forum'];
      dataReply = extractedData['data_reply'];
      for (var forum in dataForum) {
        print(forum);
      }
      // for (var reply in dataReply) {
      //   print(reply);
      // }
      List<Forum> forums = [];
      for (var forum in dataForum) {
        forums.add(Forum.fromJson(forum));
      }
      return forums;
    } catch (error) {
      throw Exception('Failed to load Forum');
    }
  }

  static Future<List<Reply>> forum(int id) async {
    final url = '$domain/forum/post/${id}/json';
    try {
      print("masuk");
      final response = await http.get(Uri.parse(url));
      List<dynamic> extractedData = jsonDecode(response.body);
      List<Reply> replies = [];
      for (var reply in extractedData) {
        replies.add(Reply.fromJson(reply));
        print(reply);
      }
      return replies;
    } catch (error) {
      throw Exception('Failed to load Forum');
    }
  }

  static Future<List<Reply>> reply(int id) async {
    final url = '$domain/forum/reply/${id}/json';
    try {
      print("masuk");
      final response = await http.get(Uri.parse(url));
      List<dynamic> extractedData = jsonDecode(response.body);
      List<Reply> replies = [];
      for (var reply in extractedData) {
        replies.add(Reply.fromJson(reply));
        print(reply);
      }
      return replies;
    } catch (error) {
      throw Exception('Failed to load Forum');
    }
  }

  static Future<int> postForum(String judul, String desc) async {
    String url = '$domain/forum/create';
    try {
      final response =
          await http.post(Uri.parse(url), body: {"title": judul, "desc": desc});
      print(response.body);
      return response.statusCode;
    } catch (err) {
      throw Exception("gagal");
    }
  }
}
