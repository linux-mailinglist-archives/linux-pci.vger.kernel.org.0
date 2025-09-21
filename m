Return-Path: <linux-pci+bounces-36603-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E852B8DB9A
	for <lists+linux-pci@lfdr.de>; Sun, 21 Sep 2025 15:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 656D6189A579
	for <lists+linux-pci@lfdr.de>; Sun, 21 Sep 2025 13:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA912D5408;
	Sun, 21 Sep 2025 13:12:37 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52C9257858;
	Sun, 21 Sep 2025 13:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758460357; cv=none; b=Hlna1k4kXU5O4a3oZQp8/TGgtQoe+5dcD2Fyn2SR1YQveCwLejNKtdQkv/M73xTlQvL7fdROBb7GWP2q9RiphGhD8lABGKT3A6vHhyh6kn/aE6wOZWIGs7ZTfEiLOILdgmsYIIpkeZhe+zBJgHuipLF02tbUwZ27vzx+n7BXhUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758460357; c=relaxed/simple;
	bh=A+t8Qo2X7e6ZL5vrxNtcYmymUXK2tAHjCMdMDGCZs+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F9l4vxh/DoyeMwZMMDkY6rFTXOEeqLb+RgoIieUykBuyOsbzBYq37UWIfYOJElLjmuSTXYIvyGyy0jOUhlZAt+aAfKLi49Qh+JuGWrm+g8mXIUiwR2fEx2vdA6GjUm24L9AKvbIS89bUjbNyjv4YUOloV9xPugw9jRs3pC503NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id E02292C000B7;
	Sun, 21 Sep 2025 15:12:25 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id B59C450BDD8; Sun, 21 Sep 2025 15:12:25 +0200 (CEST)
Date: Sun, 21 Sep 2025 15:12:25 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Crystal Wood <crwood@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org, Attila Fazekas <afazekas@redhat.com>,
	linux-pci@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Bjorn Helgaas <helgaas@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver OHalloran <oohall@gmail.com>
Subject: Re: [PATCH] genirq/manage: Reduce priority of forced secondary IRQ
 handler
Message-ID: <aM_5uXlknW286cfg@wunner.de>
References: <83f58870043e2ae64f19b3a2169b5c3cf3f95130.1757346718.git.lukas@wunner.de>
 <87348g95yd.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87348g95yd.ffs@tglx>

On Sat, Sep 20, 2025 at 11:20:26PM +0200, Thomas Gleixner wrote:
> I obviously understand that the proposed change squashs the whole class
> of similar (not yet detected) issues, but that made me look at that
> particular instance nevertheless.
> 
> All aer_irq() does is reading two PCI config words, writing one and then
> sticking 64bytes into a KFIFO. All of that is hard interrupt safe. So
> arguably this AER problem can be nicely solved by the below one-liner,
> no?

The one-liner (which sets IRQF_NO_THREAD) was what Crystal originally
proposed:

https://lore.kernel.org/r/20250902224441.368483-1-crwood@redhat.com/

I guess your point is that handling the few operations in aer_irq()
in hard interrupt context is cheaper than waking a thread and
deferring them to that thread?

Intuitively I would assume that most threaded interrupt handlers
are architected in this way:  They only do minimal work in hard
interrupt context and defer the actual work to the (secondary)
thread.  E.g. pciehp_isr() + pciehp_ist() is likewise designed
to follow this principle.

Your research that at first glance, at least 21 of 40 instances of
request_threaded_irq() could just use IRQF_NO_THREAD, seems to
support the notion that the majority of interrupt handlers only
do minimal work in hard interrupt context.

But if that is the case, and if you believe that deferring that
small amount of work to a thread is nonsensical, then why is the
primary handler forced into a thread by default in the first place,
requiring drivers to explicitly opt out by setting IRQF_NO_THREAD?

Shouldn't it rather be the other way round, i.e. by default the
primary handler is *not* forced into a thread, but only if the
driver explicitly opts in?  (In cases where the primary handler
does a sufficient amount of work that is justified to be deferred
to a thread.)

Thanks,

Lukas

