Return-Path: <linux-pci+bounces-39425-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C607C0DDA4
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 14:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CF003A3FDE
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 13:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4C3259CBF;
	Mon, 27 Oct 2025 12:59:43 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4237E253351;
	Mon, 27 Oct 2025 12:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761569983; cv=none; b=HL+gYe9pY98SUAD9SIkc0UzSG+9/Ngm8TC6Snw+a4uvm8UakLX6mn+Q7TawCnKWh7E1kAeLAdlrKMxBxN8JBu2XEkvy0rIvDWAykcngmAAkeshm2NPba2plWndop3MdQSAs9pztuxDe6JxRVd60k17i4bXCz2kOpCsa2J6amB9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761569983; c=relaxed/simple;
	bh=J8qgNCynV5meCt/pHV8As+NH0RQDFbG0j8LEmL9hv1s=;
	h=Message-Id:From:Date:Subject:To:Cc; b=ecRY15lRusEV7clk6jsYzQ01K8KI8eBz3q6OseGyo0H9e8kkbFwgEC3BQi7f9nHpaYAiUzN7EILJRz/S0wMJb++lzIRxbRZBxBGjS6NLkYJC7eFUwzr5A0S8YEIODgx5V09G2t7dbwF3h7b4vgG+8Whkzl3LrU0V/STqA44kfOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 1142A2C06442;
	Mon, 27 Oct 2025 13:59:32 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id E07792A88; Mon, 27 Oct 2025 13:59:31 +0100 (CET)
Message-Id: <f6dcdb41be2694886b8dbf4fe7b3ab89e9d5114c.1761569303.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Mon, 27 Oct 2025 13:59:31 +0100
Subject: [PATCH v2] genirq/manage: Reduce priority of forced secondary
 interrupt handler
To: Thomas Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Crystal Wood <crwood@redhat.com>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org, Attila Fazekas <afazekas@redhat.com>, linux-pci@vger.kernel.org, linux-rt-devel@lists.linux.dev, Bjorn Helgaas <helgaas@kernel.org>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Oliver OHalloran <oohall@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Crystal reports that the PCIe Advanced Error Reporting driver gets stuck
in an infinite loop on PREEMPT_RT:

Both the primary interrupt handler aer_irq() as well as the secondary
handler aer_isr() are forced into threads with identical priority.
Crystal writes that on the ARM system in question, the primary handler
has to clear an error in the Root Error Status register...

   "before the next error happens, or else the hardware will set the
    Multiple ERR_COR Received bit.  If that bit is set, then aer_isr()
    can't rely on the Error Source Identification register, so it scans
    through all devices looking for errors -- and for some reason, on
    this system, accessing the AER registers (or any Config Space above
    0x400, even though there are capabilities located there) generates
    an Unsupported Request Error (but returns valid data).  Since this
    happens more than once, without aer_irq() preempting, it causes
    another multi error and we get stuck in a loop."

The issue does not show on non-PREEMPT_RT because the primary handler
runs in hardirq context and thus can preempt the threaded secondary
handler, clear the Root Error Status register and prevent the secondary
handler from getting stuck.

Emulate the same behavior on PREEMPT_RT by assigning a lower default
priority to the secondary handler if the primary handler is forced into
a thread.

Reported-by: Crystal Wood <crwood@redhat.com>
Tested-by: Crystal Wood <crwood@redhat.com>
Closes: https://lore.kernel.org/r/20250902224441.368483-1-crwood@redhat.com/
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
Changes v1 -> v2:
 * Rename to sched_set_fifo_secondary() (Thomas)
 * Rephrase commit message and code comment (Thomas)

Link to v1:
 https://lore.kernel.org/r/83f58870043e2ae64f19b3a2169b5c3cf3f95130.1757346718.git.lukas@wunner.de/

 include/linux/sched.h   |  1 +
 kernel/irq/manage.c     |  5 ++++-
 kernel/sched/syscalls.c | 13 +++++++++++++
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index cbb7340..cd6be74 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1901,6 +1901,7 @@ static inline int task_nice(const struct task_struct *p)
 extern int sched_setscheduler_nocheck(struct task_struct *, int, const struct sched_param *);
 extern void sched_set_fifo(struct task_struct *p);
 extern void sched_set_fifo_low(struct task_struct *p);
+extern void sched_set_fifo_secondary(struct task_struct *p);
 extern void sched_set_normal(struct task_struct *p, int nice);
 extern int sched_setattr(struct task_struct *, const struct sched_attr *);
 extern int sched_setattr_nocheck(struct task_struct *, const struct sched_attr *);
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index c948373..268d751 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1239,7 +1239,10 @@ static int irq_thread(void *data)
 
 	irq_thread_set_ready(desc, action);
 
-	sched_set_fifo(current);
+	if (action->handler == irq_forced_secondary_handler)
+		sched_set_fifo_secondary(current);
+	else
+		sched_set_fifo(current);
 
 	if (force_irqthreads() && test_bit(IRQTF_FORCED_THREAD,
 					   &action->thread_flags))
diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index 77ae87f..0f00ac7 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -856,6 +856,19 @@ void sched_set_fifo_low(struct task_struct *p)
 }
 EXPORT_SYMBOL_GPL(sched_set_fifo_low);
 
+/*
+ * For when the primary interrupt handler is forced into a thread, in addition
+ * to the (always threaded) secondary handler.  The secondary handler gets a
+ * slightly lower priority so that the primary handler can preempt it, thereby
+ * emulating the behavior of a non-PREEMPT_RT system where the primary handler
+ * runs in hardirq context.
+ */
+void sched_set_fifo_secondary(struct task_struct *p)
+{
+	struct sched_param sp = { .sched_priority = MAX_RT_PRIO / 2 - 1 };
+	WARN_ON_ONCE(sched_setscheduler_nocheck(p, SCHED_FIFO, &sp) != 0);
+}
+
 void sched_set_normal(struct task_struct *p, int nice)
 {
 	struct sched_attr attr = {
-- 
2.51.0


