Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1A25184DE4
	for <lists+linux-pci@lfdr.de>; Fri, 13 Mar 2020 18:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbgCMRre (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Mar 2020 13:47:34 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47760 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727224AbgCMRrd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Mar 2020 13:47:33 -0400
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jCoP0-00017r-0C; Fri, 13 Mar 2020 18:47:18 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: [PATCH 3/9] pci/switchtec: Don't abuse completion wait queue for poll
Date:   Fri, 13 Mar 2020 18:46:55 +0100
Message-Id: <20200313174701.148376-4-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200313174701.148376-1-bigeasy@linutronix.de>
References: <20200313174701.148376-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The poll callback is abusing the completion wait queue and sticks it into
poll_wait() to wake up pollers after a command has completed.

First of all it's a layering violation as it imposes restrictions on the
inner workings of completions. Just because C allows to do so does not
justify that in any way. The proper way to do such things is to post
patches which extend the core infrastructure and not by silently abusing
it.

Aside of that the implementation is seriously broken:

 1) It cannot work with EPOLLEXCLUSIVE

 2) It's racy:

  poll()	      	  	 write()
   switchtec_dev_poll()		   switchtec_dev_write()
    poll_wait(&s->comp.wait);        mrpc_queue_cmd()
    				       init_completion(&s->comp)
					 init_waitqueue_head(&s->comp.wait)

Replace it with a regular wait queue which removes the completion abuse and
cures #1 and #2 above.

Cc: Kurt Schwemmer <kurt.schwemmer@microsemi.com>
Cc: Logan Gunthorpe <logang@deltatee.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/pci/switch/switchtec.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index a823b4b8ef8a9..e69cac84b605f 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -52,10 +52,11 @@ struct switchtec_user {
=20
 	enum mrpc_state state;
=20
-	struct completion comp;
+	wait_queue_head_t cmd_comp;
 	struct kref kref;
 	struct list_head list;
=20
+	bool cmd_done;
 	u32 cmd;
 	u32 status;
 	u32 return_code;
@@ -77,7 +78,7 @@ static struct switchtec_user *stuser_create(struct switch=
tec_dev *stdev)
 	stuser->stdev =3D stdev;
 	kref_init(&stuser->kref);
 	INIT_LIST_HEAD(&stuser->list);
-	init_completion(&stuser->comp);
+	init_waitqueue_head(&stuser->cmd_comp);
 	stuser->event_cnt =3D atomic_read(&stdev->event_cnt);
=20
 	dev_dbg(&stdev->dev, "%s: %p\n", __func__, stuser);
@@ -175,7 +176,7 @@ static int mrpc_queue_cmd(struct switchtec_user *stuser)
 	kref_get(&stuser->kref);
 	stuser->read_len =3D sizeof(stuser->data);
 	stuser_set_state(stuser, MRPC_QUEUED);
-	init_completion(&stuser->comp);
+	stuser->cmd_done =3D false;
 	list_add_tail(&stuser->list, &stdev->mrpc_queue);
=20
 	mrpc_cmd_submit(stdev);
@@ -222,7 +223,8 @@ static void mrpc_complete_cmd(struct switchtec_dev *std=
ev)
 		memcpy_fromio(stuser->data, &stdev->mmio_mrpc->output_data,
 			      stuser->read_len);
 out:
-	complete_all(&stuser->comp);
+	stuser->cmd_done =3D true;
+	wake_up_interruptible(&stuser->cmd_comp);
 	list_del_init(&stuser->list);
 	stuser_put(stuser);
 	stdev->mrpc_busy =3D 0;
@@ -529,10 +531,11 @@ static ssize_t switchtec_dev_read(struct file *filp, =
char __user *data,
 	mutex_unlock(&stdev->mrpc_mutex);
=20
 	if (filp->f_flags & O_NONBLOCK) {
-		if (!try_wait_for_completion(&stuser->comp))
+		if (!stuser->cmd_done)
 			return -EAGAIN;
 	} else {
-		rc =3D wait_for_completion_interruptible(&stuser->comp);
+		rc =3D wait_event_interruptible(stuser->cmd_comp,
+					      stuser->cmd_done);
 		if (rc < 0)
 			return rc;
 	}
@@ -580,7 +583,7 @@ static __poll_t switchtec_dev_poll(struct file *filp, p=
oll_table *wait)
 	struct switchtec_dev *stdev =3D stuser->stdev;
 	__poll_t ret =3D 0;
=20
-	poll_wait(filp, &stuser->comp.wait, wait);
+	poll_wait(filp, &stuser->cmd_comp, wait);
 	poll_wait(filp, &stdev->event_wq, wait);
=20
 	if (lock_mutex_and_test_alive(stdev))
@@ -588,7 +591,7 @@ static __poll_t switchtec_dev_poll(struct file *filp, p=
oll_table *wait)
=20
 	mutex_unlock(&stdev->mrpc_mutex);
=20
-	if (try_wait_for_completion(&stuser->comp))
+	if (stuser->cmd_done)
 		ret |=3D EPOLLIN | EPOLLRDNORM;
=20
 	if (stuser->event_cnt !=3D atomic_read(&stdev->event_cnt))
@@ -1272,7 +1275,8 @@ static void stdev_kill(struct switchtec_dev *stdev)
=20
 	/* Wake up and kill any users waiting on an MRPC request */
 	list_for_each_entry_safe(stuser, tmpuser, &stdev->mrpc_queue, list) {
-		complete_all(&stuser->comp);
+		stuser->cmd_done =3D true;
+		wake_up_interruptible(&stuser->cmd_comp);
 		list_del_init(&stuser->list);
 		stuser_put(stuser);
 	}
--=20
2.25.1

