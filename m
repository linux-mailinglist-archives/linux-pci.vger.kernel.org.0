Return-Path: <linux-pci+bounces-42794-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A7073CAE134
	for <lists+linux-pci@lfdr.de>; Mon, 08 Dec 2025 20:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1110130358C2
	for <lists+linux-pci@lfdr.de>; Mon,  8 Dec 2025 19:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653BD2DECD3;
	Mon,  8 Dec 2025 19:24:54 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9FE2D8797;
	Mon,  8 Dec 2025 19:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765221894; cv=none; b=pwux8w7EvYs7dYB6AQEBZHV6etVtfHN+jD3fdeepi6hCHUGKCN/bMP6/l50EF2N86F8NKV72b1Hpm+K81Sb+zBzieUAXG7M9ZkBKSaD+0PlO8MyUCzBcH4y7m7s5iq1my65eRpGHAQWIvnrZP6KYvCyRFszCtYusgSVjAYWn9dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765221894; c=relaxed/simple;
	bh=DppZBwf3p9NmgJff+SNt+waXIKyTI5Eoz026gq7weQI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=MFYz4R61Ps8S3NKkBjLDGGwMpQHjLnuH7T+D8O/O8vvuHvx+/XaNg8H4fW9BYeB0QztJoy9Z+HThUGPY6OAUc5motRnjGPibmXdgI93uVllfiB80K4g64HfEkAf2fgsNjW1BxImODm0mndEO4kYl/4FjW9fk8HSirTeUdgD0fVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 6CA2092009C; Mon,  8 Dec 2025 20:24:51 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 6974292009B;
	Mon,  8 Dec 2025 19:24:51 +0000 (GMT)
Date: Mon, 8 Dec 2025 19:24:51 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
cc: Bjorn Helgaas <bhelgaas@google.com>, 
    Matthew W Carlis <mattc@purestorage.com>, 
    ALOK TIWARI <alok.a.tiwari@oracle.com>, ashishk@purestorage.com, 
    msaggi@purestorage.com, sconnor@purestorage.com, 
    Lukas Wunner <lukas@wunner.de>, Jiwei <jiwei.sun.bj@qq.com>, 
    guojinhui.liam@bytedance.com, ahuang12@lenovo.com, sunjw10@lenovo.com, 
    linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: Always lift 2.5GT/s restriction in PCIe failed link
 retraining
In-Reply-To: <alpine.DEB.2.21.2512011319590.49654@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2512080241060.49654@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2511290245460.36486@angie.orcam.me.uk> <440e7c29-bee1-29f3-afa8-7b5905fd6cf2@linux.intel.com> <alpine.DEB.2.21.2512011319590.49654@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 1 Dec 2025, Maciej W. Rozycki wrote:

> > > +	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
> > > +	if ((lnkctl2 & PCI_EXP_LNKCTL2_TLS) == PCI_EXP_LNKCTL2_TLS_2_5GT &&
> > > +	    (lnkcap & PCI_EXP_LNKCAP_SLS) != PCI_EXP_LNKCAP_SLS_2_5GB) {
> > 
> > I'm trying to recall, if there was some particular reason why 
> > ->supported_speeds couldn't be used in this function. It would avoid the 
> > need to read LinkCap at all.
> 
>  Thanks for the hint.  There's probably none and it's just me missing some 
> of the zillion bits and pieces.  I'll wait a couple of days for any other 
> people to chime in and respin with this update included if everyone is 
> otherwise happy to proceed with this update.

 I take it no further feedback will be gathered, so I've sent v2 now, but 
I've figured out backporting v1 as it is will result in less intrusion to 
the trunk commit, so I have only made a change to use `->supported_speeds' 
a follow-up patch in a series.  Please let me know if this works for you.

  Maciej

