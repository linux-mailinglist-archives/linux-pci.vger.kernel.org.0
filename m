Return-Path: <linux-pci+bounces-35451-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3B2B43D6B
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 15:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1C7B17B649
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 13:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490A42FF66F;
	Thu,  4 Sep 2025 13:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zcLeODwl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MtzUsB2y"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7F32FF15B
	for <linux-pci@vger.kernel.org>; Thu,  4 Sep 2025 13:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756993138; cv=none; b=Uaax6lylQbwdjBglkHdULVDVVM7NZf9pTXgfuFsswNHT+YqoGC8yq00JivZ09mHw+PFzyTNPqWX/sitkIYDeYLYQarAzd6yYNe6qx8asdSrTkgWfEcb5LpK41jr9gsi7lWh3oT+ZE6u98nDuqSS1DVAa/33aorhWbUThYm4+mQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756993138; c=relaxed/simple;
	bh=Fet4eNLC5HoZN9v7S1i9SdAH2WBIcMYVzW2HjnLEuzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eRpQgooATk6h5jwczzcJ133+B6gbnGLmgszXIPtQ8FNSE6K96RJExJbf8icaot6kEtr/DdtLU7D4ncc+R0/QhaurQAw/6ByqIljtOmIch+dSx1lz+iFPJWtBsOaQCSZgPMHqBodK2p3hcWrGV1G4lX4cRtv/P3PaqpSq1K1MCBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zcLeODwl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MtzUsB2y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 4 Sep 2025 15:38:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756993135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=blnBh0GptY9N3EwYYRoYsdxSGDYmIObUzNnDIl/rxc8=;
	b=zcLeODwlC9Lr80XZzCOBqncZzrBvS/2asLBqr6aeca3pa4kgZ+vchScwc0o22DLkJkDnsV
	YXrg/KOo5Di07paxDHZiok8Mcczc0NFpxFKiP3HsnQRPdM553nqeL5Ub69kXk1Hhdgemma
	tsTwX2of4RBnhmMmJ5yAMnXX9q1wIl5H2wEwTuKMhW7CFNNnJ/hCszFyKPDvhYag714R3Y
	1bcsgHTITHQppU3GprNYJpKdpi2Lat3EyF/dtWxeCp3Y3RGrxFDi8daOJG9IVy+AloX7Aq
	S7MpMWTdwjhmF+YvFNz7IHbJZuDvW88vQ9iuZF/OQHoc99NAmx4kTXuVf1Ztmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756993135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=blnBh0GptY9N3EwYYRoYsdxSGDYmIObUzNnDIl/rxc8=;
	b=MtzUsB2yJZ/3Qh+iPa4+jUJHTi6LcaY2YHi3cgwSvB10fxtVLCrS6f3DoHQNZFcZlfd8BS
	vFKXeGOLGc7Qg2Cw==
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
Message-ID: <20250904133853.jk47sHLm@linutronix.de>
References: <20250902224441.368483-1-crwood@redhat.com>
 <20250904073024.YsLeZqK_@linutronix.de>
 <aLmKlVaKSBurRys1@wunner.de>
 <aLmRujcci7hoY57r@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aLmRujcci7hoY57r@wunner.de>

On 2025-09-04 15:18:50 [+0200], Lukas Wunner wrote:
> On Thu, Sep 04, 2025 at 02:48:21PM +0200, Lukas Wunner wrote:
> > On Thu, Sep 04, 2025 at 09:30:24AM +0200, Sebastian Andrzej Siewior wrote:
> > > On 2025-09-02 17:44:41 [-0500], Crystal Wood wrote:
> > > > +++ b/drivers/pci/pcie/aer.c
> > > > @@ -1671,7 +1671,8 @@ static int aer_probe(struct pcie_device *dev)
> > > >  	set_service_data(dev, rpc);
> > > >  
> > > >  	status = devm_request_threaded_irq(device, dev->irq, aer_irq, aer_isr,
> > > > -					   IRQF_SHARED, "aerdrv", dev);
> > > > +					   IRQF_NO_THREAD | IRQF_SHARED,
> > > > +					   "aerdrv", dev);
> > > 
> > > I'm not sure if this works with IRQF_SHARED. Your primary handler is
> > > IRQF_SHARED + IRQF_NO_THREAD and another shared handler which is
> > > forced-threaded will have IRQF_SHARED + IRQF_ONESHOT. 
> > > If the core does not complain, all good. Worst case might be the shared
> > > ONESHOT lets your primary handler starve. It would be nice if you could
> > > check if you have shared handler here (I have no aer I three boxes I
> > > checked).
> > 
> > Yes, interrupt sharing can happen if the Root Port uses legacy INTx
> > interrupts.  In that case other port services such as hotplug,
> > bandwidth control, PME or DPC may use the same interrupt.
> 
> I should add that none of these other port service drivers use
> IRQF_ONESHOT.  They're all IRQF_SHARED only.

Yes. But. If they get forced-threaded then we have a primary handler
irq_default_primary_handler() as the hardirq handler. This one would be
marked IRQF_ONESHOT. The other primary handler would be aer_irq() in
this case. As long as all (or none) are forced-threaded then it is fine.
In this case it could be a miss match, I'm not sure.

> Thanks,
> 
> Lukas

Sebastian

