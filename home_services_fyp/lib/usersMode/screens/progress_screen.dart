
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:home_services_fyp/FireStore_repo/user_repo.dart';
import 'package:home_services_fyp/Widget/richText.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../FireStore_repo/worker_proposal_repo.dart';
import '../../Widget/custom_button.dart';
import '../../Widget/image_viewer.dart';
import '../../models/worker_proposals_model.dart';
import '../../models/worker_review_model.dart';

class UserSideWorkStatusScreen extends StatefulWidget {
  final String proposalId;

  UserSideWorkStatusScreen({required this.proposalId});

  @override
  State<UserSideWorkStatusScreen> createState() =>
      _UserSideWorkStatusScreenState();
}

class _UserSideWorkStatusScreenState extends State<UserSideWorkStatusScreen> {
  double _professionalismRating = 0;
  double _qualityOfWorkRating = 0;
  double _punctualityRating = 0;

  TextEditingController reviewController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  addWorkerReview(WorkerReviewModel reviewModel) async {
    try {
      CollectionReference workerReviewsCollection =
          FirebaseFirestore.instance.collection('WorkerReviews');
      Map<String, dynamic> reviewData = reviewModel.toJson();
      await workerReviewsCollection.add(reviewData);
      print("Review Submitted Successfully successfully");
    } catch (e) {
      print('Error: $e');
      throw e;
    }
  }

  showReviewDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.0),
          ),
          child: Container(
            height: 400,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
              borderRadius: BorderRadius.circular(14),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Leave a review',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Professionalism',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                      const SizedBox(width: 10),
                      RatingBar.builder(
                        initialRating: 0,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 20,
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          setState(() {
                            _professionalismRating = rating;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Quality of Work',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                      const SizedBox(height: 10),
                      RatingBar.builder(
                        initialRating: 0,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 20,
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          setState(() {
                            _qualityOfWorkRating = rating;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Punctuality',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                      const SizedBox(height: 10),
                      RatingBar.builder(
                        initialRating: 0,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 20,
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          setState(() {
                            _punctualityRating = rating;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Leave a review:',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: reviewController,
                    maxLines: null,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14)),
                      hintText: 'Type your message ',
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                      ),
                      child: const Text('Submit'),
                      onPressed: () async {
                        print(reviewController.text);
                        print(_professionalismRating);
                        print(_punctualityRating);
                        print(_qualityOfWorkRating);
                        WorkerReviewModel reviewModel = WorkerReviewModel(
                          proposerId: proposalData!.proposerId,
                          proposerName: proposalData!.proposerName,
                          proposalId: proposalData!.proposalId,
                          workerID: proposalData!.workerID,
                          workerName: proposalData!.workerName,
                          userReview: reviewController.text.trim(),
                        );
                        double rating = (_professionalismRating + _qualityOfWorkRating + _punctualityRating)/3;
                        await addWorkerReview(reviewModel);
                        await userRepo.updateRatingForWorker(proposalData!.workerID, rating);
                        await updateIsCompletedField(proposalData!.proposalId);
                        setState(() {
                          _punctualityRating = 0;
                          _qualityOfWorkRating = 0;
                          _professionalismRating = 0;
                        });
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Rating submitted successfully!')),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  WorkerProposalModel? proposalData;
  UserRepo userRepo= UserRepo();
  WorkerProposalRepo repo = WorkerProposalRepo();

  Future<void> updateIsCompletedField(String? documentId) async {
    try {
      await FirebaseFirestore.instance
          .collection('WorkerProposals')
          .doc(documentId)
          .update({'isCompleted': true});

      print('Document updated successfully.');
    } catch (error) {
      print('Error: $error');
    }
  }


  Future<void> deleteProposalAndImages() async {
    try {
      await FirebaseFirestore.instance
          .collection('WorkerProposals')
          .doc(widget.proposalId)
          .delete();

      await FirebaseFirestore.instance
          .collection('WorkRequests')
          .doc(proposalData!.workRequestPostId)
          .delete();

      List<String>? imageUrls = proposalData!.imageUrls;
      for (String? imageUrl in imageUrls!) {
        if (imageUrl != null && imageUrl.isNotEmpty) {
          await FirebaseStorage.instance.refFromURL(imageUrl).delete();
        }
      }
      proposalData = null;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Proposal and images deleted.')),
      );
      Navigator.pop(context);
    } catch (e) {
      print('Error deleting proposal: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to delete proposal.')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Work Status',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: LoaderOverlay(
        child: FutureBuilder(
            future: repo.fetchProposalData(widget.proposalId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text('Error fetching data.'),
                );
              } else {
                proposalData = snapshot.data;
                Timestamp proposalTime = proposalData!.timestamp;
                print(proposalData!.isCompleted);

                return proposalData!.isCompleted != true ? SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.95,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.grey.shade200,
                              width: 2.0,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade200,
                                offset: const Offset(0, 6),
                                blurRadius: 10.0,
                              ),
                            ],
                            borderRadius: BorderRadius.circular(14.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  proposalData!.proposalTitle.toString(),
                                  style: const TextStyle(
                                      fontSize: 24, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 16),
                                richText(
                                  'Description : ' , proposalData!.workDescription.toString()
                                ),
                                const SizedBox(height: 16),
                                richText(
                                  'Rate :' ,'${(proposalData!.rate.toString())} Rs'
                                ),
                                const SizedBox(height: 16),
                                richText(
                                  'Estimated Time : ',
                                    '${proposalData!.estimatedTime.toString()} hour(s)'),
                                const SizedBox(height: 16),
                                richText(
                                  'Material : ',proposalData!.material.toString()
                                ),
                                const SizedBox(height: 16),
                                richText(
                                  'Locations : ',proposalData!.location.toString()
                                ),
                                const SizedBox(height: 16),
                                richText(
                                    'Submitted by : ',proposalData!.proposerName.toString()
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  children: proposalData!.imageUrls!.map((imageAddress) {
                                    return Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                        child: GestureDetector(
                                          onTap: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=>FullScreenImagePage(imageUrl: imageAddress,)));
                                          },
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(5),
                                            child: CachedNetworkImage(
                                              imageUrl: imageAddress,
                                              fit: BoxFit.cover,
                                              width: 128,
                                              height: 128,
                                              placeholder: (context, url) =>
                                              new CircularProgressIndicator(),
                                              errorWidget: (context, url, error) =>
                                              new Icon(Icons.error),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        workTimeLine(
                          reachDestinationTime: proposalData!.workReachTime,
                          workInProgressTime: proposalData!.workStartTime,
                          finalizeTaskTime: proposalData!.workEndTime,
                          showReviewDialog: showReviewDialog,
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                            height: 60,
                            child: customButton(
                              title: 'Discontinue',
                              fontSize: 18,
                              onTap: () {
                                context.loaderOverlay.show();
                                deleteProposalAndImages();

                                context.loaderOverlay.hide();
                              },
                            )),
                      ],
                    ),
                  ),
                ): Center(child: Text('Project Completed'),);
              }
            }),
      ),
    );
  }
}

Widget workTimeLine({
  Timestamp? reachDestinationTime,
  Timestamp? workInProgressTime,
  Timestamp? finalizeTaskTime,
  required Function() showReviewDialog,
}) {
  return Center(
    child: ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: <Widget>[
        TimelineTile(
          alignment: TimelineAlign.manual,
          lineXY: 0.1,
          isFirst: true,
          indicatorStyle: const IndicatorStyle(
            width: 20,
            color: Color(0xFF27AA69),
            padding: EdgeInsets.all(6),
          ),
          endChild: _RightChild(
            disabled: true,
            asset: 'assets/images/demo.png',
            title: 'Reach On Destinations',
            message: 'Worker is reached to destination to start work',
            highlighted: reachDestinationTime != null ? true : false,
            dateTime: reachDestinationTime,
            ontap: () {},
          ),
          beforeLineStyle: const LineStyle(
            color: Color(0xFF27AA69),
          ),
        ),
        TimelineTile(
          alignment: TimelineAlign.manual,
          lineXY: 0.1,
          indicatorStyle: const IndicatorStyle(
            width: 20,
            color: Color(0xFF000000),
            padding: EdgeInsets.all(6),
          ),
          endChild: Padding(
            padding: const EdgeInsets.only(bottom: 30.0, top: 30),
            child: _RightChild(
              disabled: true,
              asset: 'assets/images/demo.png',
              title: 'Work in progress',
              message: 'Worker is working on the task',
              highlighted: workInProgressTime != null,
              dateTime: workInProgressTime,
              ontap: () {},
            ),
          ),
          beforeLineStyle: const LineStyle(
            color: Color(0xFF27AA69),
          ),
          afterLineStyle: const LineStyle(
            color: Color(0xFF000000),
          ),
        ),
        TimelineTile(
          alignment: TimelineAlign.manual,
          lineXY: 0.1,
          isLast: true,
          indicatorStyle: const IndicatorStyle(
            width: 20,
            color: Color(0xFFFF004A),
            padding: EdgeInsets.all(6),
          ),
          endChild: _RightChild(
            disabled: true,
            asset: 'assets/images/demo.png',
            title: 'Finalize the task',
            message: 'Your work is completed',
            highlighted: finalizeTaskTime != null,
            dateTime: finalizeTaskTime,
            button: true,
            ontap: showReviewDialog,
          ),
          beforeLineStyle: const LineStyle(
            color: Color(0xFF000000),
          ),
        ),
      ],
    ),
  );
}

class _RightChild extends StatefulWidget {
  const _RightChild({
    Key? key,
    required this.asset,
    required this.title,
    required this.message,
    this.disabled = false,
    this.button = false,
    required this.ontap,
    required this.highlighted,
    required this.dateTime,
  }) : super(key: key);

  final String asset;
  final String title;
  final String message;
  final bool disabled;
  final bool button;
  final void Function() ontap;
  final bool highlighted;
  final Timestamp? dateTime;

  @override
  State<_RightChild> createState() => _RightChildState();
}

class _RightChildState extends State<_RightChild> {
  @override
  Widget build(BuildContext context) {
    print('Highlight value ${(widget.highlighted)}');
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: <Widget>[
          Opacity(
            child: Image.asset(widget.asset, height: 50),
            opacity: widget.highlighted ? 1 : 0.5,
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                widget.title,
                style: TextStyle(
                  color: widget.highlighted
                      ? Colors.black
                      : widget.disabled
                          ? const Color(0xFFBABABA)
                          : Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 6),
              SizedBox(
                width: 210,
                child: Text(
                  widget.message,
                  style: TextStyle(
                    color: widget.highlighted
                        ? Colors.black
                        : const Color(0xFFBABABA),
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              widget.highlighted
                  ? SizedBox(
                      width: 210,
                      child: Text(
                        'At time: ${(widget.dateTime?.toDate())}',
                        style: TextStyle(
                          color: widget.highlighted
                              ? Colors.black
                              : const Color(0xFFBABABA),
                          fontSize: 16,
                        ),
                      ),
                    )
                  : const SizedBox(),
              const SizedBox(height: 6),
              widget.button
                  ? ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: widget.highlighted
                            ? Colors.black
                            : const Color(0xFFBABABA),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                      ),
                      onPressed: widget.highlighted ? widget.ontap : null,
                      child: const Text('Rate Work'))
                  : const SizedBox(),
            ],
          ),
        ],
      ),
    );
  }
}
