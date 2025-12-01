Return-Path: <linux-pci+bounces-42335-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E70CCC95AE0
	for <lists+linux-pci@lfdr.de>; Mon, 01 Dec 2025 04:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F31D3A1BAF
	for <lists+linux-pci@lfdr.de>; Mon,  1 Dec 2025 03:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5339F78F5D;
	Mon,  1 Dec 2025 03:54:20 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF267081F
	for <linux-pci@vger.kernel.org>; Mon,  1 Dec 2025 03:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764561260; cv=none; b=dbwEyAd0ULHWR27hmsM9a5fazKwWumpeQ1zon/p2Bd+LBELIoEzeFPmXTDp7zIh1EkeUJDnOtEDpbfnwpMqXgrYwTQzP7SZ3hP1wI9NpY0XzITcpJpVXxTCETVB0RiVEzsX4BoZ+I23oKJZonisLlFZMJWaL4TLYym+jR7Dt7Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764561260; c=relaxed/simple;
	bh=3HX+2jvlfJpf8TvnN4nBBpygasXwfiY90DLzoBJ5VzE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gmXmtwi9uaRb+8dj/VMyTk14aEn7IiQPigx8nLHuPusrgOaby3SFTVeKkZeizNP5D5msmtiWZkzuazxxUN8eyfd8JYPiiWXN8ECU8FdvJ8SMCkrS2WyU/N4o2SxB3jHC1QaeXtTvTrFlAr01c8BF8h4m7pcQqdlhvx9B1Nej8qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 74ACA92009E; Mon,  1 Dec 2025 04:54:17 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 6EAEE92009B;
	Mon,  1 Dec 2025 03:54:17 +0000 (GMT)
Date: Mon, 1 Dec 2025 03:54:17 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Matthew W Carlis <mattc@purestorage.com>
cc: ashishk@purestorage.com, bamstadt@purestorage.com, 
    Bjorn Helgaas <bhelgaas@google.com>, Bjorn Helgaas <helgaas@kernel.org>, 
    linux-pci@vger.kernel.org, msaggi@purestorage.com, sconnor@purestorage.com
Subject: Re: [PATCH 0/1] PCI: Add CONFIG_PCI_NOSPEED_QUIRK to remove
 pcie_failed_link_retrain
In-Reply-To: <20250723191837.35503-1-mattc@purestorage.com>
Message-ID: <alpine.DEB.2.21.2511290044560.36486@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2507181435110.21783@angie.orcam.me.uk> <20250723191837.35503-1-mattc@purestorage.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 23 Jul 2025, Matthew W Carlis wrote:

> >  Bjorn, unfortunately sometimes you have to live with what you've got, in 
> > particular there's (I believe still) no good choice available to replace 
> > the HiFive Unmatched board and the PCIe splitter adapter chosen was the 
> > only one I could chase that is fully mechanically compatible with *ATX 
> > case slot space (i.e. you can actually properly mount it there next to the 
> > mainboard and no connector will clash with another part of the system).
> >
> >  Matthew, please correct me if I'm wrong, but from discussion so far here 
> > and previously I infer the problematic part is not the essential part of 
> > the quirk, that is retraining at 2.5GT/s.  It is leaving the speed clamp 
> > behind that is.
> 
> I'm just not sure what the benefit of the quirk is generally. It seems like
> there are several problems with it in "well behaved" systems. I think for
> people who build & sell servers they would go out and qualify a list of
> devices which they will tell their customers "have been seen to work" &
> therefore would be unlikely to see your specific issue. Another problem in my
> mind with the quirk is that you're left trying to figure out if it should
> have invoked the quirk before looking at the device interaction & so I think it
> makes things a bit harder to debug.
> 
> In a way we're basically enabling future bad hardware by allowing the quirk to
> run broadly on PCIe devices... Once its been around for a while will anyone ever
> be able to confidently say its not necessary? In addition it sounds like both Ilpo
> and I have observed LBMS to behave differently on different devices.

 I think the situation is more analogous to what used to be the case with 
parallel SCSI devices where certain combinations of otherwise good devices 
from reputable vendors failed to communicate to each other for reasons not 
clearly known, possibly slight impedance mismatches or other issues with a 
particular setup rather than the devices themselves.

 Likewise the downstream ports affected in my system seem to work just 
fine with other devices up to their nominal speed of 8GT/s and the piece 
of hardware the onboard upstream port of which fails initial training has 
had no failure reports received according to the manufacturer.

 So any workarounds such as this one are in my view more to the benefit of 
the users rather than device manufacturers, which I'd rather expect to do 
more rigorous verification than just "works in an OS, signed off."

 I have now implemented the approach I've outlined further down my 
message.  Please give it a try and see if it removes the issues you've 
observed:

<https://lore.kernel.org/r/alpine.DEB.2.21.2511290245460.36486@angie.orcam.me.uk/>

  Maciej

