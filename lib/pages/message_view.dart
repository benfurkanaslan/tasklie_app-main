import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasklie_new/core/encryption.dart';
import 'package:tasklie_new/main.dart';
import 'package:tasklie_new/models/message_model.dart';

class MessageView extends StatefulWidget {
  final String messageViewConversationId;
  const MessageView({required this.messageViewConversationId, super.key});

  @override
  State<MessageView> createState() => _MessageViewState();
}

bool? _thereIsMessage;
TextEditingController _firstMessageController = TextEditingController();
TextEditingController _textController = TextEditingController();
List<MessageModel> _messages = [];
bool _canSendMessage = true;

class _MessageViewState extends State<MessageView> {
  @override
  void initState() {
    super.initState();
    _streamSubscription();
  }

  void _streamSubscription() {
    messagesRef.doc(widget.messageViewConversationId).collection('messages').orderBy('time', descending: true).snapshots().listen((QuerySnapshot<Map<String, dynamic>> snapshot) {
      if (snapshot.docs.isEmpty) {
        setState(() {
          _thereIsMessage = false;
        });
      } else {
        _messages.clear();
        for (QueryDocumentSnapshot<Map<String, dynamic>> document in snapshot.docs) {
          _messages.add(MessageModel(
            text: document.data()['text'],
            time: document.data()['time'],
            senderEmail: document.data()['senderEmail'],
            senderName: document.data()['senderName'],
          ));
        }
        setState(() {
          _thereIsMessage = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (_thereIsMessage) {
      case true:
        return Messages(messageViewConversationId: widget.messageViewConversationId);
      case false:
        return EmptyMessageView(messageViewConversationId: widget.messageViewConversationId);
      default:
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator.adaptive(),
          ),
        );
    }
  }
}

class Messages extends StatefulWidget {
  final String messageViewConversationId;
  const Messages({required this.messageViewConversationId, super.key});

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  Future<void> _sendMessage() async {
    setState(() {
      _canSendMessage = false;
    });
    if (_textController.text.isNotEmpty) {
      String encrypted = EncryptData.encryptAES(_textController.text);
      await messagesRef.doc(widget.messageViewConversationId).collection('messages').add({
        'text': encrypted,
        'time': DateTime.now(),
        'senderEmail': currentUser!.email,
        'senderName': currentUser!.name,
      });
      if (!mounted) return;
      setState(() {
        _textController.clear();
        _canSendMessage = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              reverse: true,
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                reverse: true,
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return _buildMessageCard(_messages[index]);
                },
              ),
            ),
          ),
          const Divider(height: 1.0),
          Container(
            margin: const EdgeInsets.only(bottom: 40.0, left: 20.0, right: 20.0, top: 5.0),
            decoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: const InputDecoration(
                      hintText: 'Enter a message',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                    ),
                  ),
                ),
                (() {
                  if (_canSendMessage) {
                    return IconButton(
                      icon: const Icon(CupertinoIcons.arrowtriangle_right_fill),
                      onPressed: () async {
                        await _sendMessage();
                      },
                    );
                  } else {
                    return Container();
                  }
                }()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageCard(MessageModel message) {
    final String decrypted = EncryptData.decryptAES(message.text);
    return Row(
      mainAxisAlignment: message.senderEmail == currentUser?.email ? MainAxisAlignment.end : MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        SizedBox(
          width: MediaQuery.of(context).size.width / 1.5,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(color: Colors.grey[300]!, width: 3),
            ),
            elevation: 0.0,
            color: message.senderEmail == currentUser?.email ? Colors.blue[100] : Colors.grey[200],
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: message.senderEmail == currentUser?.email ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                      children: <Widget>[
                        (() {
                          if (message.senderEmail == currentUser?.email) {
                            return Container();
                          } else {
                            return Text(
                              message.senderName,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            );
                          }
                        }()),
                        const SizedBox(height: 4.0),
                        Text(
                          decrypted,
                          textAlign: message.senderEmail == currentUser?.email ? TextAlign.end : TextAlign.start,
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          '${message.time.toDate().hour.toString().padLeft(2, '0')} : ${message.time.toDate().minute.toString().padLeft(2, '0')}',
                          style: TextStyle(color: Colors.grey[600], fontSize: 12.0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class EmptyMessageView extends StatefulWidget {
  final String messageViewConversationId;
  const EmptyMessageView({
    super.key,
    required this.messageViewConversationId,
  });

  @override
  State<EmptyMessageView> createState() => _EmptyMessageViewState();
}

class _EmptyMessageViewState extends State<EmptyMessageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('İlk mesajı at', style: TextStyle(fontSize: 20.0)),
            const SizedBox(height: 20.0),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.5,
              child: TextField(
                controller: _firstMessageController,
                decoration: const InputDecoration(
                  hintText: 'Bir mesaj yaz',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            OutlinedButton(
              onPressed: () {
                if (_firstMessageController.text.isNotEmpty) {
                  String encrypted = EncryptData.encryptAES(_firstMessageController.text);
                  messagesRef.doc(widget.messageViewConversationId).collection('messages').add({
                    'text': encrypted,
                    'time': DateTime.now(),
                    'senderEmail': currentUser!.email,
                    'senderName': currentUser!.name,
                  });
                  if (!mounted) return;
                  setState(() {
                    _firstMessageController.clear();
                  });
                }
              },
              child: const Text('Gönder'),
            ),
          ],
        ),
      ),
    );
  }
}
