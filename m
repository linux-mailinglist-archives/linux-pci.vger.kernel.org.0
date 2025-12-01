Return-Path: <linux-pci+bounces-42370-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA49C97BCA
	for <lists+linux-pci@lfdr.de>; Mon, 01 Dec 2025 14:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0B553A1FCB
	for <lists+linux-pci@lfdr.de>; Mon,  1 Dec 2025 13:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3B22F6918;
	Mon,  1 Dec 2025 13:55:34 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670F52EE608;
	Mon,  1 Dec 2025 13:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764597334; cv=none; b=Q8z/Uv5GHJrEiQkBD2qh6RR+cevad4rjf9sxzP2J7D1QuG543G+VI++1ug1vro7IqaSPJpRT5t5Z2QX6Gk07H5j+hX1GjFp1+e3nIbplieB//t9pg7OXIzAq+EKlvuo10+B+7w3RolNGSe3efvdqwGgIxTXOvyu9QnQSF79MuIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764597334; c=relaxed/simple;
	bh=Zc6de4I7EFyBKpWEuBZLIq/0pk6ssLENEwS36Arf/a0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=M3QsBSWxe+4HtuGUIjeLrfI5lZqXvNc77ImEreqKH+wwRLALT7dXcKA1L2NBMmYwYBZDjSKXjjUqA1ovnXHZTtSwsuUBg0/mK8k/x2riqCXvIrP6tGEiMu8UD3h0Dyh8vlOPDDQjTQcacaQLXJUlLHmN/YMcRIWwhrP3rI/0Dkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id BFCA892009D; Mon,  1 Dec 2025 14:55:29 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id BCEE492009C;
	Mon,  1 Dec 2025 13:55:29 +0000 (GMT)
Date: Mon, 1 Dec 2025 13:55:29 +0000 (GMT)
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
In-Reply-To: <440e7c29-bee1-29f3-afa8-7b5905fd6cf2@linux.intel.com>
Message-ID: <alpine.DEB.2.21.2512011319590.49654@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2511290245460.36486@angie.orcam.me.uk> <440e7c29-bee1-29f3-afa8-7b5905fd6cf2@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 1 Dec 2025, Ilpo Järvinen wrote:

> > +	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
> > +	if ((lnkctl2 & PCI_EXP_LNKCTL2_TLS) == PCI_EXP_LNKCTL2_TLS_2_5GT &&
> > +	    (lnkcap & PCI_EXP_LNKCAP_SLS) != PCI_EXP_LNKCAP_SLS_2_5GB) {
> 
> I'm trying to recall, if there was some particular reason why 
> ->supported_speeds couldn't be used in this function. It would avoid the 
> need to read LinkCap at all.

 Thanks for the hint.  There's probably none and it's just me missing some 
of the zillion bits and pieces.  I'll wait a couple of days for any other 
people to chime in and respin with this update included if everyone is 
otherwise happy to proceed with this update.

> > +		if (ret)
> > +			goto err;
> >  	}
> >  
> >  	return ret;
> 
> return 0;

 It can still return -ENOTTY if neither of the two latter conditionals 
matched, meaning the quirk was not applicable after all.  ISTR you had 
issues with the structure of this code before; I am not sure if it can 
be made any better in a reasonable way.  It is not a failure per se, so 
the newly-added common error path does not apply.  This is the case for: 
"Return an error if retraining was not needed[...]" from the introductory 
comment.

 Shall I add a comment above the return statement referring to this?

  Maciej

