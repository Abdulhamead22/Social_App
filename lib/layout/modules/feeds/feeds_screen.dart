import 'package:flutter/material.dart';
import 'package:flutter_application_1/style/icon_broken.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            elevation: 5,
            margin: const EdgeInsets.all(8),
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                Image.asset(
                  'assets/image/logo.jpg',
                  fit: BoxFit.cover,
                  height: 220,
                  width: double.infinity,
                ),
                Text(
                  "communicate with friends",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
          ),
          ListView.separated(
            //الاثنين الي تحت عملتهم عشان انا وسط scrolView 
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 10,
            itemBuilder: (context, index) {
              return buildPostIrem(context);
            },
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(
              height: 10,
            ),
          ),
          const SizedBox(height: 10,),
        ],
      ),
    );
  }

  Widget buildPostIrem(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 5,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage(
                    'assets/image/logo2.jpg',
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Text(
                            'Abdulhamead Shokri',
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.check_circle,
                            color: Colors.blue,
                            size: 16,
                          ),
                        ],
                      ),
                      Text(
                        "20/2/2026 at 11:00 pm",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.more_horiz,
                    size: 16,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Container(
                color: Colors.grey[300],
                height: 1,
                width: double.infinity,
              ),
            ),
            Text(
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0, bottom: 10),
              child: SizedBox(
                width: double.infinity,
                child: Wrap(
                  children: [
                    SizedBox(
                      height: 25,
                      child: MaterialButton(
                        height: 25.0,
                        minWidth: 1,
                        padding: EdgeInsets.zero,
                        onPressed: () {},
                        child: const Text(
                          '#software',
                          style: TextStyle(color: Colors.blue, fontSize: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 160,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                image: const DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    'assets/image/logo.jpg',
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Row(
                          children: [
                            const Icon(
                              IconBroken.Heart,
                              color: Colors.red,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Likes",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Icon(
                              IconBroken.Chat,
                              color: Colors.red,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Comments",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.grey[300],
              height: 1,
              width: double.infinity,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 15,
                          backgroundImage: AssetImage(
                            'assets/image/logo2.jpg',
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Text(
                          "write a comments",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Row(
                    children: [
                      const Icon(
                        IconBroken.Heart,
                        color: Colors.red,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Likes",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
