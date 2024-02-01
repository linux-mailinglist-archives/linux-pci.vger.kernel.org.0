Return-Path: <linux-pci+bounces-2957-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0E3846062
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 19:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA68BB2FFE2
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 18:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2199A84FB0;
	Thu,  1 Feb 2024 18:49:41 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1527D84FAC;
	Thu,  1 Feb 2024 18:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706813381; cv=none; b=TV79EGZBau37ZLfn7J9w6s2V8khQumd5RjRIEvSQgE9ituzo8tJO6uITkfqeTekhM/w/OlZQSMP5RxaZZtffgSI6gs5eWg3C3xEMJDHKZR0Usv4ajZWrWHfSwJ7MclQWY393HqLKNjdg3yS/wgaIr/8p2cXwI9tpvs9nHAuYivQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706813381; c=relaxed/simple;
	bh=4kQszUoBJ5ep+V9GiUUQxx2RZAcg0NaaLqCv4hDSd8o=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gRH0IXVip70vOLKpI8dDNWBfZ5yJLgWu6iIlg5zR2ervxbLHs9K+V3dNwNHo0R3dCd5sGrk4KTvOhYNvYcAmcNv7iUjGno2tu+UvZqu3I4ibPxCAq9jdiWZh8Pc3QhHVXAKHIkXq29KJAZKCRpTunGtZ7BZhaQaSK3c/u+ukYWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 6761992009C; Thu,  1 Feb 2024 19:49:30 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 603D692009B;
	Thu,  1 Feb 2024 18:49:30 +0000 (GMT)
Date: Thu, 1 Feb 2024 18:49:30 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 1/2] PCI: Clear LBMS on resume to avoid Target Speed
 quirk
In-Reply-To: <d5f14b8f-f935-5d5e-e098-f2e78a2766c6@linux.intel.com>
Message-ID: <alpine.DEB.2.21.2402011800320.15781@angie.orcam.me.uk>
References: <20240129184354.GA470131@bhelgaas> <aa2d1c4e-9961-d54a-00c7-ddf8e858a9b0@linux.intel.com> <alpine.DEB.2.21.2401301537070.15781@angie.orcam.me.uk> <a7ff7695-77c5-cf5a-812a-e24b716c3842@linux.intel.com>
 <d5f14b8f-f935-5d5e-e098-f2e78a2766c6@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 1 Feb 2024, Ilpo Järvinen wrote:

> > >  I think there is a corner case here indeed.  If Link Active reporting is 
> > > supported and neither DLLLA nor LBMS are set at entry, then the function 
> > > indeed returns success even though the link is down and no attempt to 
> > > retrain will have been made.  So this does indeed look a case for a return 
> > > with the FALSE result.
> > > 
> > >  I think most easily this can be sorted by delegating the return result to 
> > > a temporary variable, preset to FALSE and then only updated from results 
> > > of the calls to `pcie_retrain_link'.  I can offer a patch as the author of 
> > > the code and one who has means to verify it right away if that helped.
> > 
> > I already wrote a patch which addresses this together with the caller 
> > site changes.

 Can you post it here for review then, as surely it's a standalone change?

> > >  This can be problematic AFAICT however.  While I am not able to verify 
> > > suspend/resume operation with my devices, I expect the behaviour to be 
> > > exactly the same after resume as after a bus reset: the link will fail to 
> > > negotiate and the LBMS and DLLLA bits will be respectively set and clear.  
> > > Consequently if you clear LBMS at resume, then the workaround won't 
> > > trigger and the link will remain inoperational in its limbo state.
> > 
> > How do you get the LBMS set in the first place? Isn't that because the 
> > link tries to come up so shouldn't it reassert that bit again before the 
> > code ends up into the target speed quirk? That is, I assumed you actually 
> > wanted to detect LBMS getting set during pcie_wait_for_link_status() call 
> > preceeding pcie_failed_link_retrain() call?

 It is a good question what the sequence of events exactly is that sets 
the LBMS bit.  I don't know the answer offhand.

> > There's always an option to store it into pci_dev for later use when the 
> > quirk is found to be working for the first time if other solutions don't 
> > work.

 Indeed there is.

> > In any case and unrelated to this patch, the way this quirk monopolizes 
> > LBMS bit is going to have to be changed because it won't be reliable with 
> > the PCIe BW controller that sets up and irq for LBMS (and clears the bit).
> > In bwctrl v5 (yet to be posted) I'll add LBMS counter into bwctrl to allow 
> > this quirk to keep working (which will need to be confirmed).

 If there's an interrupt handler for LBMS events, then it may be the best 
approach if the quirk is triggered by the handler instead, possibly as a 
softirq.

> > >  What kind of scenario does the LBMS bit get set in that you have a 
> > > trouble with?  You write that in your case the downstream device has been 
> > > disconnected while the bug hierarchy was suspended and it is not present 
> > > anymore at resume, is that correct?
> > >
> > >  But in that case no link negotiation could have been possible and 
> > > consequently the LBMS bit mustn't have been set by hardware (according to 
> > > my understanding of PCIe), because (for compliant, non-broken devices 
> > > anyway) it is only specified to be set for ports that can communicate with 
> > > the other link end (the spec explicitly says there mustn't have been a 
> > > transition through the DL_Down status for the port).
> > >
> > >  Am I missing something?
> > 
> > Yes, when resuming the device is already gone but the bridge still has 
> > LBMS set. My understanding is that it was set because it was there
> > from pre-suspend time but I've not really taken a deep look into it 
> > because the problem and fix seemed obvious.

 I've always been confused with the suspend/resume terminology: I'd have 
assumed this would have gone through a power cycle, in which case the LBMS 
bit would have necessarily been cleared in the transition, because its 
required state at power-up/reset is 0, so the value of 1 observed would be 
a result of what has happened solely through the resume stage.  Otherwise 
it may make sense to clear the bit in the course of the suspend stage, 
though it wouldn't be race-free I'm afraid.

> > I read that "without the Port transitioning through DL_Down status" 
> > differently than you, I only interpret that it relates to the two 
> > bullets following it. ...So if retrain bit is set, and link then goes 
> > down, the bullet no longer applies and LBMS should not be set because 
> > there was transition through DL_Down. But I could well be wrong...

 What I refer to is that if you suspend your system, remove the device 
that originally caused the quirk to trigger and then resume your system 
with the device absent, then LBMS couldn't have been set in the course of 
resume, because the port couldn't have come out of the DL_Down status in 
the absence of the downstream device.  Do you interpret it differently?

 Of course once set the bit isn't self-clearing except at power-up/reset.

> So I would be really curious now to know how you get the LBMS on the 
> device that needs the Target Speed quirk? Is this true (from the commit 
> a89c82249c37 ("PCI: Work around PCIe link training failures")):
> 
> "Instead the link continues oscillating between the two speeds, at the 
> rate of 34-35 times per second, with link training reported repeatedly 
> active ~84% of the time."
> 
> ?

 That is what I have observed.  It was so long ago I don't remember how I 
calculated the figures anymore, it may have been with a U-Boot debug patch 
made to collect samples (because with U-Boot you can just poll the LT bit 
while busy-looping).  I'd have to try and dig out the old stuff.

> Because if it is constantly picking another speed, it would mean you get 
> LBMS set over and over again, no? If that happens 34-35 times per second, 
> it should be set already again when we get into that quirk because there 
> was some wait before it gets called.

 I'll see if I can experiment with the hardware over the next couple of 
days and come back with my findings.

  Maciej

