Return-Path: <linux-pci+bounces-35634-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A16B4843E
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 08:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 731C07AA237
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 06:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7700C220687;
	Mon,  8 Sep 2025 06:36:44 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C66205AB6
	for <linux-pci@vger.kernel.org>; Mon,  8 Sep 2025 06:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757313404; cv=none; b=UMklevQHxgHuujhCJ14idUosu6N5MbNz3WQmBmGDJ07NZibB2r/VDcXhkpYqGs2n2+TEFGO+cJh1lK3PP9LD+i2rFyfXnl292yeZ+VekOHVVsIomTXEtdIrAakIsA1ww/Eh2UPftjqEymSt34ehu3Du+AYLpae73yZwrtww6dBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757313404; c=relaxed/simple;
	bh=2PDfCWBZPPt+1YFCe8QS7op+j1aB4L4kVsxiB0k+AOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HELyWEwe4hKZf75ePy4JLWvaEp1YHMJ4vsrhd6CFAHT+R2K/LYHsX3SOUQosynD13mphtfWcUNjsfmGgt1LWYiPJZdPmnQ8nWXDyEwoKlPVgJe08Bhit7puF7Lwp/f/Daa9pJCJXwROL6M7wd7EYszmGert1qD5YYfLtGv9Tn1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id E9AB32C0666C;
	Mon,  8 Sep 2025 08:36:32 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id D3670527B45; Mon,  8 Sep 2025 08:36:32 +0200 (CEST)
Date: Mon, 8 Sep 2025 08:36:32 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Crystal Wood <crwood@redhat.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Attila Fazekas <afazekas@redhat.com>, linux-pci@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] PCI/AER: Use IRQF_NO_THREAD on aer_irq
Message-ID: <aL55cDBjsNk2xK10@wunner.de>
References: <20250902224441.368483-1-crwood@redhat.com>
 <20250904073024.YsLeZqK_@linutronix.de>
 <aLmKlVaKSBurRys1@wunner.de>
 <bb2b9df1b13fccb7829c5d73a0bddbd0083d105a.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb2b9df1b13fccb7829c5d73a0bddbd0083d105a.camel@redhat.com>

On Thu, Sep 04, 2025 at 03:27:40PM -0500, Crystal Wood wrote:
> On Thu, 2025-09-04 at 14:48 +0200, Lukas Wunner wrote:
> > On Thu, Sep 04, 2025 at 09:30:24AM +0200, Sebastian Andrzej Siewior wrote:
> > > Another way would be to let the secondary handler run at a slightly lower
> > > priority than the primary handler. In this case making the primary
> > > non-threaded should not cause any harm.
> > 
> > Why isn't the secondary handler always assigned a lower priority
> > by default?  I think a lot of drivers are built on the assumption
> > that the primary handler is scheduled sooner than the secondary
> > handler.
> 
> That also works, and I agree it's more intuitive.

Could you test whether the patch below fixes the issue for you?

-- >8 --

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
index 77ae87f..8234223 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -847,6 +847,15 @@ void sched_set_fifo(struct task_struct *p)
 EXPORT_SYMBOL_GPL(sched_set_fifo);
 
 /*
+ * Secondary IRQ handler has slightly lower priority than primary IRQ handler.
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

