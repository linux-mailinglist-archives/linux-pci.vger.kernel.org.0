Return-Path: <linux-pci+bounces-35446-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 508F2B43C06
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 14:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11A483BA888
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 12:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8B52FD7CC;
	Thu,  4 Sep 2025 12:48:32 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D662F39A7
	for <linux-pci@vger.kernel.org>; Thu,  4 Sep 2025 12:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756990112; cv=none; b=nICBiAQIiGuJ3TNBKZh0FgQsZk0ckDyuf9RrZN3HURyJzz0OIEEiPr/BQAwHm0af49hXczwjP7aGd0f7kjRqWC7oYq1Skcc+qjT+AtXuR5b4oKrtCmqc+O+1F0xAG9eW0t78zlhH8YqrblRtFC8o1xl1XTd7omHHGNd4uktaAus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756990112; c=relaxed/simple;
	bh=mS8P5KHBT3GEzN/26DJGZ33+0imeDZJzK0mDJKAh6TM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S4HFCgAlM47ODUu05TRhu0E9mPVHEsa6AwUSXWP326o8E0yhaydswaqnNtFHy5Czb5NF2d4KmM3eHFPicz+EkEp7MAEVvbzMUjEVTtyr7R1VhcAC/kHbJillEzm1iLws7gSMx0wBHCq7Kn2v4nfKe8BluLtiUvoN2K9bIwXORzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id B95312C000BF;
	Thu,  4 Sep 2025 14:48:21 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 946DC48BAE3; Thu,  4 Sep 2025 14:48:21 +0200 (CEST)
Date: Thu, 4 Sep 2025 14:48:21 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Crystal Wood <crwood@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Attila Fazekas <afazekas@redhat.com>, linux-pci@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] PCI/AER: Use IRQF_NO_THREAD on aer_irq
Message-ID: <aLmKlVaKSBurRys1@wunner.de>
References: <20250902224441.368483-1-crwood@redhat.com>
 <20250904073024.YsLeZqK_@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904073024.YsLeZqK_@linutronix.de>

On Thu, Sep 04, 2025 at 09:30:24AM +0200, Sebastian Andrzej Siewior wrote:
> On 2025-09-02 17:44:41 [-0500], Crystal Wood wrote:
> > On PREEMPT_RT, currently both aer_irq and aer_isr run in separate threads,
> > at the same FIFO priority.  This can lead to the aer_isr thread starving
> > the aer_irq thread, particularly if multi_error_valid causes a scan of
> > all devices, and multiple errors are raised during the scan.
> > 
> > On !PREEMPT_RT, or if aer_irq runs at a higher priority than aer_isr, these
> > errors can be queued as single-error events as they happen.  But if aer_irq
> > can't run until aer_isr finishes, by that time the multi event bit will be
> > set again, causing a new scan and an infinite loop.
> 
> So if aer_irq is too slow we get new "work" pilled up? Is it because
> there is a timing constrains how long until the error needs to be
> acknowledged?

Since v6.16, AER supports rate limiting.  It's unclear which
kernel version Crystal is using, but if it's older than v6.16,
it may be worth retrying with a newer release to see if that
solves the problem.

> Another way would be to let the secondary handler run at a slightly lower
> priority than the primary handler. In this case making the primary
> non-threaded should not cause any harm.

Why isn't the secondary handler always assigned a lower priority
by default?  I think a lot of drivers are built on the assumption
that the primary handler is scheduled sooner than the secondary
handler.

E.g. the native PCIe hotplug driver (drivers/pci/hotplug/pciehp_hpc.c)
uses the primary handler to pick up Command Completed interrupts
and will then wake the secondary handler, which is waiting in
pcie_wait_cmd().  The secondary handler uses a timeout of 1 sec
to ensure forward progress in case the hardware never signals
Command Completed (e.g. if the hotplug port itself was hot-removed).

In extreme cases, the primary handler may not run within 1 sec
to wake the secondary handler.  The secondary handler will then
run into the timeout and issue an error message (but should
otherwise react gracefully).

My point is that keeping both at the same priority by default
provokes such situations more easily, so assigning a higher
default priority to the primary handler would seem prudent.

> > +++ b/drivers/pci/pcie/aer.c
> > @@ -1671,7 +1671,8 @@ static int aer_probe(struct pcie_device *dev)
> >  	set_service_data(dev, rpc);
> >  
> >  	status = devm_request_threaded_irq(device, dev->irq, aer_irq, aer_isr,
> > -					   IRQF_SHARED, "aerdrv", dev);
> > +					   IRQF_NO_THREAD | IRQF_SHARED,
> > +					   "aerdrv", dev);
> 
> I'm not sure if this works with IRQF_SHARED. Your primary handler is
> IRQF_SHARED + IRQF_NO_THREAD and another shared handler which is
> forced-threaded will have IRQF_SHARED + IRQF_ONESHOT. 
> If the core does not complain, all good. Worst case might be the shared
> ONESHOT lets your primary handler starve. It would be nice if you could
> check if you have shared handler here (I have no aer I three boxes I
> checked).

Yes, interrupt sharing can happen if the Root Port uses legacy INTx
interrupts.  In that case other port services such as hotplug,
bandwidth control, PME or DPC may use the same interrupt.

Thanks,

Lukas

