Return-Path: <linux-pci+bounces-32268-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20100B07686
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 15:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80DF11C22894
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 13:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3948485626;
	Wed, 16 Jul 2025 13:01:20 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55216290D95
	for <linux-pci@vger.kernel.org>; Wed, 16 Jul 2025 13:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752670880; cv=none; b=tqvKvqXEUU+rbUp7EoY8UAvaxkX4Noh3Hv+I2/6mptp6MyTktnRJlV4N+FL/Rlfz8YowfCVWtdkNUA0Rfh9OQawTRVL8bQ8ULbHOjc5qg7xSG79w3fhgqwHbGCq3kHeAHiyNy5XyIEP95pJmDbM+03cxPZvOU4vNA1GnGVGHXNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752670880; c=relaxed/simple;
	bh=70lnk/Tdz3JNGzon8jPBh/IVS89WGfbp18uGwsP1m64=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Gz5bMw00/swT7FXqs9CNF+C/m8PCg4bLXN7NP128+CTddVKiQtQbcLE+0/3K4gSOvrYpA9uImAmCC78/4b9NJ2t1E8LYf46ujWrM3fA61kp29cvaciIS4gfjtmlJwaiuN191cPuPIM9ODNDCjGO/o+cARYlEG71a+O/J1eZ6gMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 4AB3F92009C; Wed, 16 Jul 2025 15:01:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 44B5492009B;
	Wed, 16 Jul 2025 14:01:07 +0100 (BST)
Date: Wed, 16 Jul 2025 14:01:07 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
cc: Matthew W Carlis <mattc@purestorage.com>, ashishk@purestorage.com, 
    Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    msaggi@purestorage.com, sconnor@purestorage.com
Subject: Re: [PATCH v2 0/1] PCI: pcie_failed_link_retrain() return if dev is
 not ASM2824
In-Reply-To: <2b72378d-a8c1-56b1-3dbb-142eb4c7f302@linux.intel.com>
Message-ID: <alpine.DEB.2.21.2507091730410.56608@angie.orcam.me.uk>
References: <62c702a7-ce9b-21b8-c30e-a556771b987f@linux.intel.com> <20250708224917.7386-1-mattc@purestorage.com> <2b72378d-a8c1-56b1-3dbb-142eb4c7f302@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 9 Jul 2025, Ilpo Järvinen wrote:

> > I wonder if it shouldn't have to see some kind of actual link activity 
> > as a prereq to entering the quirk.
> 
> How would you observe that "link activity"? Doesn't LBMS itself imply 
> "link activity" occurred?

 It does, although in this case it shouldn't have been set in the first 
place, because after reset the link never comes up (i.e. goes into the 
Link Active state) and only keeps flipping between training and not 
training, as indicated by the LT bit.  FAOD with the affected link the 
LBMS bit doesn't ever retrigger once cleared while the link is in its 
broken state.

 Once the speed has been clamped and link retrained it goes up right away
(i.e. into the Link Active state) and remains steady up, also once the 
speed has been unclamped.

 I made a test once and left the system up for half a year or so.  The 
LBMS bit was set once, a couple of days after system reset.  I cleared it 
by hand and it never retriggered for the rest of the experiment, so this 
single occasion must have been a glitch and not a link quality issue.

 During that half a year the system and the link in question were both 
used heavily in remote GNU toolchain verification over a network interface 
placed downstream the problematic link.  Traffic included NFS and SSH.  
No issues ever triggered, so I must conclude the link training issue is 
specific to speed negotiation, likely at the protocol level, rather than 
at the physical layer.

 Last year I tried to make an alternative setup using a PCIe switch option 
card using the same ASMedia device.  The card has turned out not to work 
at all (the switch reporting in the configurations space, but all the 
downstream switch permanently down) owing to the host leaving the Vaux 
line disconnected in the slot, which is a conforming configuration.  I was 
told by the option card manufacturer this is an erratum in the ASMedia 
switch device and the workaround is to drive Vaux.  I think this just 
tells what the quality of these devices is.  Sigh.

 Anyway, I chose to rework the card and tracked down a suitable miniature 
SMD switch to mount onto the PCB so as to let me select whether to drive 
ASMedia device's Vaux input from the Vaux or a regular 3.3V slot position, 
but owing to other commitments I've never got to completing this effort, 
as it requires a couple of hours of precise manual work at the workshop.  
I'll get back to it sometime and report the results.

> Any good suggestions how to realize that check more precisely to 
> differentiate if there was some link activity or not?

 The LT bit is an obvious candidate and also how I wrote a corresponding 
quirk in U-boot.  A problem however is while in U-boot it's fine to poll 
the LT bit busy-looping for a second or so, it's absolutely not in Linux 
where we have the rest of the OS running.  Sampling at random intervals 
isn't going to help as we could well miss the active state.

 FWIW it's all documented with the description of the quirk.

> > One thing that honestly doesn't make any sense to me is the ID list in the
> > quirk. If the link comes up after forcing to Gen1 then it would only restore
> > TLS if the device is the ASMedia switch, but also ignoring what device is
> > detected downstream. If we allow ASMedia to restore the speed for any downstream
> > device when we only saw the initial issue with the Pericom switch then why
> > do we exclude Intel Root Ports or AMD Root Ports or any other bridge from the
> > list which did not have any issues reported.
> 
> I think it's because the restore has been tested on that device 
> (whitelist).

 Correct, the idea has been to err on the side of caution.  The ASMedia 
device seems to cope well with this unclamping, so it's been listed, and 
so should any other device that has been confirmed to work.

 Matching the downstream and the upstream device both at a time instead, 
once this quirk has triggered and succeeded, seems to make no sense: if 
the device downstream turns out affected, then it matches the behaviour 
observed, so it should be enough to have the upstream device checked.  I 
did want to run it at full speed anyway.

 OTOH matching the downstream device likely makes sense if the quirk has 
been bypassed, such as when the link speed had been already clamped by the 
firmware.  In this case we do not really know if the clamping has been 
triggered by this erratum or something else, so such a check would be 
justified.  I don't think it's going to matter for the problems discussed 
though.

 Apologies for the irregular replies, lots on my head right now and I had 
to write this all down properly.

  Maciej

