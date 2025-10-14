Return-Path: <linux-pci+bounces-38060-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 929D5BD97B7
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 14:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 766161891FFE
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 12:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF493148B8;
	Tue, 14 Oct 2025 12:58:15 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7340B313E18;
	Tue, 14 Oct 2025 12:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760446695; cv=none; b=gjOknC3aRQntBGnY3FArNgrHW31DrZ1T03/WS/A2JWyVTYCpPx4XD6aN/XuU9pxElSKMVjqFHeiVginj4zfIFoC11E/uC+hSnyDM9xMUYVrJLBi58fuh1bqLoNhQaI8UoAgQk3ODyIA7tGB4L0v4MnDyIBUvQ7gCQPYV/MgDQEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760446695; c=relaxed/simple;
	bh=jioduxtjG2D9UHtigEPZcxJXr8+DU/z9boK0Wb8p2yk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ez+8SuO0vqbO409lzn+iBezglr0cerv6FXA/oKNmP/PP2iLIZ9QzwRJj4NIVGVFqCLWYFMzE01GAN6GKfbeXpk+bnjkUdvXTTwVu6Jws86F5FY7PtHFjUUqlTFKKya/GdQ/1dw0Swyg2X+RRR8WxBHRYikHLm9NPGzZL4smQNfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 9084F92009C; Tue, 14 Oct 2025 14:58:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 8A89692009B;
	Tue, 14 Oct 2025 13:58:10 +0100 (BST)
Date: Tue, 14 Oct 2025 13:58:10 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
    Guenter Roeck <linux@roeck-us.net>, Bjorn Helgaas <bhelgaas@google.com>, 
    linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 03/24] MIPS: PCI: Use pci_enable_resources()
In-Reply-To: <9f80ba5e-726b-ad68-b71f-ab23470bfa36@linux.intel.com>
Message-ID: <alpine.DEB.2.21.2510141349560.39634@angie.orcam.me.uk>
References: <20250829131113.36754-1-ilpo.jarvinen@linux.intel.com> <20250829131113.36754-4-ilpo.jarvinen@linux.intel.com> <9085ab12-1559-4462-9b18-f03dcb9a4088@roeck-us.net> <aO1sWdliSd03a2WC@alpha.franken.de> <alpine.DEB.2.21.2510132229120.39634@angie.orcam.me.uk>
 <74ed2ce0-744a-264f-6042-df4bbec0f58e@linux.intel.com> <alpine.DEB.2.21.2510141232400.39634@angie.orcam.me.uk> <9f80ba5e-726b-ad68-b71f-ab23470bfa36@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 14 Oct 2025, Ilpo Järvinen wrote:

> >  Well, PCIBIOS_MIN_IO is never set for Malta and therefore stays at 0.
> 
> I meant whether pci-malta.c has to play with the ->start address at all 
> if it would use PCIBIOS_MIN_IO.

 Yes, we need either, not both.

> >  I'd have to go through the relevant datasheets to see whether it can 
> > actually happen in reality.  Perhaps we can just hardwire PCIBIOS_MIN_IO 
> > to 0x1000 instead, similarly to what other MIPS platforms do.
> 
> My patch did hardcode set it to 0x1000, I just noted before the patch that 
> I'm not sure if the code should actually try to align the resulting "real 
> start address" to 0x1000 if hose->io_resource->start != 0.
> 
> Or are you saying also the the if () check should be removed as well?

 That's what I meant, sorry to be unclear.

> >  NB there are commit c5de50dada14 ("MIPS: Malta: Change start address to 
> > avoid conflicts.") and commit 27547abf36af ("MIPS: malta: Incorporate 
> > PIIX4 ACPI I/O region in PCI controller resources") that fiddled with this 
> > code piece.  Especially the latter one refers additional commits that may 
> > give further insights.  And the former one removed a "FIXME" annotation, 
> > which suggests I didn't consider the solution perfect back 20 years ago, 
> > but given how long it stayed there it was surely good enough for its time.
> 
> It was "good enough" only because the arch specific 
> pcibios_enable_resources() was lacking the check for whether the resource 
> truly got assigned or not. The PIIX4 driver must worked just fine without 
> those IO resources which is what most drivers do despite using 
> pci(m)_enable_device() and not pci_enable_device_mem() (the latter 
> doesn't even seem to come with m variant).

 As /proc/ioport contents indicate the resources did get assigned or there 
would be no claiming driver reported.  I'm sure I did double-check it back 
in the day too.

  Maciej

