Return-Path: <linux-pci+bounces-35678-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24704B494C9
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 18:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3DD3166EDD
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 16:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB75235BE8;
	Mon,  8 Sep 2025 16:08:42 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD401306B34;
	Mon,  8 Sep 2025 16:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757347722; cv=none; b=eJkdPjOoxpwOP51AiRZqdjolZZytgDABIHvvBf/1xZINw7RAIN8kK0Ftjqy56vFy3vXrgxuuwSQQCtZ2eEhEeYGvWvpaPlNwnWdQ0W+0c1lA3e5B8wC1rKMTc6smv3/GRHmKx3hzETkCtNExbke0P2Z8+WCkVkoI8020e7wZQWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757347722; c=relaxed/simple;
	bh=L0oLhH7XTO62+cYljj+HqUg2QW/9wnUQVJlr7OlxZR0=;
	h=Message-Id:From:Date:Subject:To:Cc; b=cgaN6BkgFO0j1XTiJP9XW1s8qm0tLUDysa13tgi+CB5yb86tUSoQ00K4zq60MyDyop61/uyB+fKxwWxRxfmtvFKch1iRyIQDnkZQDbc6kOQM6Xi7gtnwwXlcHNq7/oGvkF5AeGYNrdpMDWd9nIW+w5LPq+U8qAqVwE/+wxxYbss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 4CCB020091A0;
	Mon,  8 Sep 2025 18:08:30 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 45B715307EE; Mon,  8 Sep 2025 18:08:30 +0200 (CEST)
Message-Id: <83f58870043e2ae64f19b3a2169b5c3cf3f95130.1757346718.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Mon, 8 Sep 2025 18:08:31 +0200
Subject: [PATCH] genirq/manage: Reduce priority of forced secondary IRQ
 handler
To: Thomas Gleixner <tglx@linutronix.de>, "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>, Crystal Wood <crwood@redhat.com>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org, Attila Fazekas <afazekas@redhat.com>, linux-pci@vger.kernel.org, linux-rt-devel@lists.linux.dev, Bjorn Helgaas <helgaas@kernel.org>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Oliver OHalloran <oohall@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Crystal reports the PCIe Advanced Error Reporting driver getting stuck
in an infinite loop on PREEMPT_RT:  Both the primary IRQ handler
aer_irq() as well as the secondary handler aer_isr() are forced into
threads with identical priority.

Crystal writes that on the ARM system in question, the primary IRQ
handler has to clear an error in the Root Error Status register...

   "before the next error happens, or else the hardware will set the
    Multiple ERR_COR Received bit.  If that bit is set, then aer_isr()
    can't rely on the Error Source Identification register, so it scans
    through all devices looking for errors -- and for some reason, on
    this system, accessing the AER registers (or any Config Space above
    0x400, even though there are capabilities located there) generates
    an Unsupported Request Error (but returns valid data).  Since this
    happens more than once, without aer_irq() preempting, it causes
    another multi error and we get stuck in a loop."

The issue does not show on non-PREEMPT_RT since the primary IRQ handler
runs in hardirq context and thus clears the Root Error Status register
before waking the secondary IRQ handler's thread.

Simulate the same behavior on PREEMPT_RT by assigning a lower default
priority to forced secondary IRQ handlers.

Reported-by: Crystal Wood <crwood@redhat.com>
Tested-by: Crystal Wood <crwood@redhat.com>
Closes: https://lore.kernel.org/r/20250902224441.368483-1-crwood@redhat.com/
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
Crystal provided a Tested-by off-list.  I've used Crystal's suggestion
for the code comment, but if anyone prefers Sebastian's or some other
wording, I don't mind either respinning myself or a maintainer amending
this or any other aspect of the patch when applying.  Thanks!

 include/linux/sched.h   |  1 +
 kernel/irq/manage.c     |  5 ++++-
 kernel/sched/syscalls.c | 11 +++++++++++
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 2b27238..ceed23d 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1894,6 +1894,7 @@ static inline int task_nice(const struct task_struct *p)
 extern int sched_setscheduler(struct task_struct *, int, const struct sched_param *);
 extern int sched_setscheduler_nocheck(struct task_struct *, int, const struct sched_param *);
 extern void sched_set_fifo(struct task_struct *p);
+extern void sched_set_fifo_minus_one(struct task_struct *p);
 extern void sched_set_fifo_low(struct task_struct *p);
 extern void sched_set_normal(struct task_struct *p, int nice);
 extern int sched_setattr(struct task_struct *, const struct sched_attr *);
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index c948373..b09c18a 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1239,7 +1239,10 @@ static int irq_thread(void *data)
 
 	irq_thread_set_ready(desc, action);
 
-	sched_set_fifo(current);
+	if (action->handler == irq_forced_secondary_handler)
+		sched_set_fifo_minus_one(current);
+	else
+		sched_set_fifo(current);
 
 	if (force_irqthreads() && test_bit(IRQTF_FORCED_THREAD,
 					   &action->thread_flags))
diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index 77ae87f..4be85aa 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -847,6 +847,17 @@ void sched_set_fifo(struct task_struct *p)
 EXPORT_SYMBOL_GPL(sched_set_fifo);
 
 /*
+ * For tasks that must be preemptible by a sched_set_fifo() task, such as
+ * to simulate the behavior of a non-PREEMPT_RT system where the
+ * sched_set_fifo() task is a hard interrupt.
+ */
+void sched_set_fifo_minus_one(struct task_struct *p)
+{
+	struct sched_param sp = { .sched_priority = MAX_RT_PRIO / 2 - 1 };
+	WARN_ON_ONCE(sched_setscheduler_nocheck(p, SCHED_FIFO, &sp) != 0);
+}
+
+/*
  * For when you don't much care about FIFO, but want to be above SCHED_NORMAL.
  */
 void sched_set_fifo_low(struct task_struct *p)
-- 
2.50.1


