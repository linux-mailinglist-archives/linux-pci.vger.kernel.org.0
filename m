Return-Path: <linux-pci+bounces-33301-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC8FB18561
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 18:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F08AB18932F5
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 16:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0614F26E158;
	Fri,  1 Aug 2025 16:04:11 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C3026B756
	for <linux-pci@vger.kernel.org>; Fri,  1 Aug 2025 16:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754064250; cv=none; b=PSQ0SXPQv1RWuoErBl8/YHzhSG/wzZ11pjOJM7i0CsGjRD1hLQmcCn8+BdRXKQLl/mjSMPXZMia7kxsk8EemaqZR89dsT1Cyp84Zz1YsLaO9YCU+w/ybACeiF/+qNaqHuP8hyYoIOCh3FtrO4bZTF+h7VhPuBzGjVQcqRInxOnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754064250; c=relaxed/simple;
	bh=5efI+0bFKbqm6yIwJ2+5mDlY1L8oTmSdG5L+ldHJ2VQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=LmrIN3heKMrdcimzfRIDkwCG5iZToBSuUBZJedHKs9A9nJRIHyZYdmDZRr9lOleIqUWWDNytN3gJHa9mZk9iZdeJpAa4b+03BfFdr6i0I5dGu8tB/ZV4XbM+tXSrDGWiSZ1VI0a4TQoxk22/N3UzMuXPfXTKmcDIDLpZV8/a/qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 0EB1192009C; Fri,  1 Aug 2025 18:04:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 09CA292009B;
	Fri,  1 Aug 2025 17:04:05 +0100 (BST)
Date: Fri, 1 Aug 2025 17:04:04 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Matthew W Carlis <mattc@purestorage.com>
cc: ashishk@purestorage.com, Bjorn Helgaas <bhelgaas@google.com>, 
    =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
    linux-pci@vger.kernel.org, msaggi@purestorage.com, sconnor@purestorage.com
Subject: Re: [PATCH v2 0/1] PCI: pcie_failed_link_retrain() return if dev is
 not ASM2824
In-Reply-To: <20250723191334.35277-1-mattc@purestorage.com>
Message-ID: <alpine.DEB.2.21.2508011605580.5060@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2507091730410.56608@angie.orcam.me.uk> <20250723191334.35277-1-mattc@purestorage.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 23 Jul 2025, Matthew W Carlis wrote:

> >  I made a test once and left the system up for half a year or so.  The 
> > LBMS bit was set once, a couple of days after system reset.  I cleared it 
> > by hand and it never retriggered for the rest of the experiment, so this 
> > single occasion must have been a glitch and not a link quality issue.
> 
> I guess you also did not observe unusual number of correctable errors? I wonder
> if AER was under OS control & the relevant errors were unmasked (RxErr, BadTLP,
> BadDLLP, Replay Rollover, Replay Timeout). If the link transitions from L0 to
> Recovery state due to excessive LCRC failures I have seen it return at the same
> speed many times. I won't be able to say what the LBMS behavior is in that case
> for some time unless I get lucky & find one in our internal test pool.

 The system has been up for a while now:

$ uptime
 17:06:25 up 44 days, 15:43,  2 users,  load average: 0.00, 0.00, 0.00
$ 

but how would I gather such error information?  All I can see is:

		DevSta:	CorrErr+ NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-

and:

	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP+ BadDLLP+ Rollover- Timeout- AdvNonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
		AERCap:	First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000

with the upstream device and somewhat different:

		DevSta:	CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr+ TransPend-

and:

	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
		AERCap:	First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000

with the downstream device.  In particular I find the all-zeros header log 
peculiar, especially given that nonzero contents are reported across other 
ports, but it's the only port in the system to report BadTLP+ or BadDLLP+.

 I've cleared the two status bits (and BWMgmt+) by hand and BadDLLP+ has 
retriggered after a couple of seconds (and then again), so your reasoning 
seems to go in the right direction.  I'll try to experiment some more and 
report back, but it'll take a while as I'm away from all equipment but my 
laptop right now.  I'd like to understand which exact pieces of hardware 
cause this problem.  I'll also see if I can chase another make of a PCIe 
switch for the upstream device.

 Also it makes me feel the workaround can indeed be of general use and it 
is just speed unclamping that needs to be robust enough not to interfere 
with good equipment.  In a perfect world we'd only have good hardware, but 
in the world we have instead I feel like doing the best we can rather than 
giving up.

 Thanks for your input!

  Maciej

