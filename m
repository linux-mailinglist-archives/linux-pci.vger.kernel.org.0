Return-Path: <linux-pci+bounces-35450-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F035B43D3B
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 15:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F35597C46AE
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 13:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C6E14AA9;
	Thu,  4 Sep 2025 13:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fVY78LwQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mvPNh3n4"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026C12C0F69
	for <linux-pci@vger.kernel.org>; Thu,  4 Sep 2025 13:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756992692; cv=none; b=P8z2ist9glFOSuw6z9Ma449Y8+9MSI7+cNonxqWco5WZS2ZCm50NzMvFZ2yc6EDy6mVDJylcWH1P//tHDi3HByco4blWb3TEdgXFz28q8XuZonLMts7dQHN2+jDjm89QCfVtEMIIpB6xSq3j+XDnhYHqfrdvEiG6Ol0ht3xpm0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756992692; c=relaxed/simple;
	bh=LOxGdnYfSJ80WDTSDGRj0MMm1O5ZBtOfDXQMp9dzGb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OMt4Ei+j2jVNAOSLsqHdl3TclxdBoFKPqmz/y/Uv4ZcpUbDRwYh0FQ6aduf4y/7p3MQATN3pEvbg8GG8UDeN7oMXDR7KJfeCWGSV+OOK7LaqBtWzFkrnvIH7+p3KwUgwnXUSgCsaEURqzoD/0tQfazDSSj9zbNcOEDQtAcoaUlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fVY78LwQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mvPNh3n4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 4 Sep 2025 15:31:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756992688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4uk+fCxT4bxgoCr9ZV9bsR9OXbJrtNPzVMgU5U2lzks=;
	b=fVY78LwQr9rnLKBjC5haVQeVOrus+J8awVW21/zQgSUhIWakFcWJ4SaHzgpSEyB4leWgxC
	p5/E8urtIg3BH+nA0NAgHzmC2/qprcye1ihCchvG9VAAiOpEljQwfrGoaa4YJ3xrCi2G5z
	mA7+XqAd9GQcwvKPeH36BBFPseBgZWW5kmcKHVpMuVJd/dxCvWfJa861Rgaps9ECkMTZlx
	tbTPtPWhr+MgiiCWQWkuIjUsWfRScwKFj4YKYGa63pd9FF9haaEQiIcFAY5p0Ozu7gZFj5
	LxvX+zyMlGqjTqqxatze3MFsz6nNafHYQeWGY2zxRU5B/ag4jbM997XT9Oq3RA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756992688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4uk+fCxT4bxgoCr9ZV9bsR9OXbJrtNPzVMgU5U2lzks=;
	b=mvPNh3n4RLVR2Hsz2fJthCEJUlCh4HvvsGL5b4+02TQU1celShFBlchrjHvz+jidtCOQ6w
	ZV65PS4ih8jyBFDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Lukas Wunner <lukas@wunner.de>
Cc: Crystal Wood <crwood@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Attila Fazekas <afazekas@redhat.com>, linux-pci@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] PCI/AER: Use IRQF_NO_THREAD on aer_irq
Message-ID: <20250904133127.Z9XKdHWW@linutronix.de>
References: <20250902224441.368483-1-crwood@redhat.com>
 <20250904073024.YsLeZqK_@linutronix.de>
 <aLmKlVaKSBurRys1@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aLmKlVaKSBurRys1@wunner.de>

On 2025-09-04 14:48:21 [+0200], Lukas Wunner wrote:
> Since v6.16, AER supports rate limiting.  It's unclear which
> kernel version Crystal is using, but if it's older than v6.16,
> it may be worth retrying with a newer release to see if that
> solves the problem.

Where is this rate limiting coming from?

> > Another way would be to let the secondary handler run at a slightly lower
> > priority than the primary handler. In this case making the primary
> > non-threaded should not cause any harm.
> 
> Why isn't the secondary handler always assigned a lower priority
> by default?  I think a lot of drivers are built on the assumption
> that the primary handler is scheduled sooner than the secondary
> handler.

Well, that is the first time I see that someone made that assumption.

> E.g. the native PCIe hotplug driver (drivers/pci/hotplug/pciehp_hpc.c)
> uses the primary handler to pick up Command Completed interrupts
> and will then wake the secondary handler, which is waiting in
> pcie_wait_cmd().  The secondary handler uses a timeout of 1 sec
> to ensure forward progress in case the hardware never signals
> Command Completed (e.g. if the hotplug port itself was hot-removed).

If it is waiting then everything is good. It would be only problematic
if it busy-polls.

> In extreme cases, the primary handler may not run within 1 sec
> to wake the secondary handler.  The secondary handler will then
> run into the timeout and issue an error message (but should
> otherwise react gracefully).
>
> My point is that keeping both at the same priority by default
> provokes such situations more easily, so assigning a higher
> default priority to the primary handler would seem prudent.

Okay but the secondary should be one less than the primary. The primary
is in the middle priority "MAX_RT_PRIO / 2". It should not be preferred
over other forced-threaded handler just because it has also a secondary
handler. The secondary should run after all primary handler are done.
This would also mirror the !RT case.

> > > +++ b/drivers/pci/pcie/aer.c
> > > @@ -1671,7 +1671,8 @@ static int aer_probe(struct pcie_device *dev)
> > >  	set_service_data(dev, rpc);
> > >  
> > >  	status = devm_request_threaded_irq(device, dev->irq, aer_irq, aer_isr,
> > > -					   IRQF_SHARED, "aerdrv", dev);
> > > +					   IRQF_NO_THREAD | IRQF_SHARED,
> > > +					   "aerdrv", dev);
> > 
> > I'm not sure if this works with IRQF_SHARED. Your primary handler is
> > IRQF_SHARED + IRQF_NO_THREAD and another shared handler which is
> > forced-threaded will have IRQF_SHARED + IRQF_ONESHOT. 
> > If the core does not complain, all good. Worst case might be the shared
> > ONESHOT lets your primary handler starve. It would be nice if you could
> > check if you have shared handler here (I have no aer I three boxes I
> > checked).
> 
> Yes, interrupt sharing can happen if the Root Port uses legacy INTx
> interrupts.  In that case other port services such as hotplug,
> bandwidth control, PME or DPC may use the same interrupt.

So this sounds like it is not going to work then, or is it?

> Thanks,
> 
> Lukas

Sebastian

