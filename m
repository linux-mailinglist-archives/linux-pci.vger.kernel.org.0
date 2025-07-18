Return-Path: <linux-pci+bounces-32536-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85CDCB0A5FF
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 16:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1616B1C80944
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 14:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820932376EC;
	Fri, 18 Jul 2025 14:16:56 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A002AE7F
	for <linux-pci@vger.kernel.org>; Fri, 18 Jul 2025 14:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752848216; cv=none; b=Atit7wLTXbMFkKW4NcC1cByqWVtAXN/hgyxup8rVHxbdgyH5+hFMMtorQGnWTOvtxAdkxsXO/ZYtyOin7kF/BTE5PpiDAOtK+OwELYSgyXe5wLmE9z02fRgZL4SuGM2P/SPIQdsTJDxtnEtG3f4GN3Dm/Qfc6uMvn366JLRQqz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752848216; c=relaxed/simple;
	bh=cFXx6qBo5YcLcntcWOh7sdRKV8DY+7inTRmuB65d/9k=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=oMSdU19fdjyeAv2Np9xM7RlOYWVPXBmDls/dKuS5godfd9K602wSNRj7A4YrtdQNdKfBSuQhHudYtZ+wa8GGbj4H5yC11YiXxEo6TnymTfjRP4YNjNzZfOn6Jky/nTDF4x9ffzOHML0/VjfP2q7IAvCMPc5CsZKqNwq5fTitQhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 2DCD492009C; Fri, 18 Jul 2025 16:16:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 26A5E92009B;
	Fri, 18 Jul 2025 15:16:46 +0100 (BST)
Date: Fri, 18 Jul 2025 15:16:46 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Matthew W Carlis <mattc@purestorage.com>, 
    Bjorn Helgaas <helgaas@kernel.org>
cc: ashishk@purestorage.com, bamstadt@purestorage.com, 
    Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    msaggi@purestorage.com, sconnor@purestorage.com
Subject: Re: [PATCH 0/1] PCI: Add CONFIG_PCI_NOSPEED_QUIRK to remove
 pcie_failed_link_retrain
In-Reply-To: <20250717183802.22810-1-mattc@purestorage.com>
Message-ID: <alpine.DEB.2.21.2507181435110.21783@angie.orcam.me.uk>
References: <20250716193411.GA2551185@bhelgaas> <20250717183802.22810-1-mattc@purestorage.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 17 Jul 2025, Matthew W Carlis wrote:

> > Maybe we should just accept that broken hardware exists and add quirks
> > to limit link speed or tell the user to buy a working device.

 Bjorn, unfortunately sometimes you have to live with what you've got, in 
particular there's (I believe still) no good choice available to replace 
the HiFive Unmatched board and the PCIe splitter adapter chosen was the 
only one I could chase that is fully mechanically compatible with *ATX 
case slot space (i.e. you can actually properly mount it there next to the 
mainboard and no connector will clash with another part of the system).

 Matthew, please correct me if I'm wrong, but from discussion so far here 
and previously I infer the problematic part is not the essential part of 
the quirk, that is retraining at 2.5GT/s.  It is leaving the speed clamp 
behind that is.

 I pondered over this issue and came to a conclusion: how about we just 
drop the vendor/device ID qualification for unclamping where the quirk has 
triggered, that is remove the clamp unconditionally?  It obviously won't 
affect my devices and might perhaps have been overly cautious in the first 
place.

 Than for the case where the link had already been clamped by the firmware 
stricter matching can be done before unclamping, just as I suggested in my 
previous message, but by definition it shouldn't affect hotplug scenarios.

 If we agree on this way to move forward, then I'll make suitable changes, 
but today is my last day before heading for a holiday next week, so I'll 
only come back with some code the week of Jul 28th.  Does it sound like a 
plan to you?

> I was actually wondering if we should define a new kind of
> DECLARE_PCI_FIXUP_<LINKUP> which allows vendors/users to implement an
> appropriate link recovery for their circumstances. In one of our storage
> appliance product-lines we actually have a kind of quirk of our own which is
> implemented to work-around some older Gen3 PCIe switches that had some official
> erratum. Honestly we would like to not have to carry these patches, but there
> wasn't an obvious way to upstream them. We could probably re-work them to fit
> into a kind of new fixup.
> 
> My belief is that we try to not bend the generic handling in the kernel around
> specific device issues because once implemented we are essentially enabling
> devices in the future to have such bugs/interactions.

 No opinion about it right away, but I'll give it a thought once I'm back.

> In the case of this ASMedia/Pericom switch combination I'm told from others
> internally that its possibly that changing the link presets or other settings
> may resolve the ltssm looping issue, but it would probably require
> ASMedia/Pericom to look into.

 Thank you for looking into it.  Sadly both parties declined to comment 
when I contacted them back in 2021.

 They only seem to care about direct customers, which would be SiFive for 
ASMedia and Delock (or whoever the OEM was; the same device used to be 
retailed by StarTech for example) for Diodes/Pericom.  There was no answer 
from ASMedia at all and I got an initial response from Diodes, but then I 
was told that if this was about a PCIe switch, then they were the wrong 
part of the company and could not help themselves or direct me to the 
right part.

 Then SiFive told me they'd love to help, but were too small a customer 
for ASMedia (the first batch of HiFive Unmatched was a couple hundred 
pieces), and Delock told me I was the first one to ever report any issue 
and therefore it was my problem and not theirs.

 So I did whatever I was able to myself.  I'm glad I had the skills in the 
first place; most people could only give up.

  Maciej

