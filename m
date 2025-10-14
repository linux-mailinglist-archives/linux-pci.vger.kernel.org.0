Return-Path: <linux-pci+bounces-38053-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64177BD9500
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 14:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 083FF4281B3
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 12:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75414313536;
	Tue, 14 Oct 2025 12:22:30 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A2724C66F;
	Tue, 14 Oct 2025 12:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760444550; cv=none; b=d0A8BxRpwuaTN79sJ0KW5hLd4ECBO9evz5obJOyLDgFX5KhGtTyRAtpf+pTXvXNOyHtC+Q+EPwjmCms6B4RnKEHYsABp+wNz4wNQxOp7oIPZYTV07fQRqxCd/UtFVObQSHnSxZq/Kmrz5SzRZctXVJgr0qWVa6FrOnzdyib0r74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760444550; c=relaxed/simple;
	bh=YJiDVmUDQKfmDqPvMDX+pwcm/6GniAX12BH2bAKqae0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=tKkjUpYzoD/rKnOvPVOma94Xn7TzKrDv5MOZdGz6xJmSeBmpyGmkVTl9+3AqTldxlOOcCJLOCcl4Y4e+5LcJaa7VQ7XE1Ba3oDFg3+392Kb2/ov+snQaS8DyfXxZg2CIAduFhODdy27Q2e64rSpC/QokDhHWg0X1uz4f9yRisnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 62EDE92009C; Tue, 14 Oct 2025 14:22:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 601E492009B;
	Tue, 14 Oct 2025 13:22:25 +0100 (BST)
Date: Tue, 14 Oct 2025 13:22:25 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
    Guenter Roeck <linux@roeck-us.net>, Bjorn Helgaas <bhelgaas@google.com>, 
    linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 03/24] MIPS: PCI: Use pci_enable_resources()
In-Reply-To: <74ed2ce0-744a-264f-6042-df4bbec0f58e@linux.intel.com>
Message-ID: <alpine.DEB.2.21.2510141232400.39634@angie.orcam.me.uk>
References: <20250829131113.36754-1-ilpo.jarvinen@linux.intel.com> <20250829131113.36754-4-ilpo.jarvinen@linux.intel.com> <9085ab12-1559-4462-9b18-f03dcb9a4088@roeck-us.net> <aO1sWdliSd03a2WC@alpha.franken.de> <alpine.DEB.2.21.2510132229120.39634@angie.orcam.me.uk>
 <74ed2ce0-744a-264f-6042-df4bbec0f58e@linux.intel.com>
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

> > As you can see there are holes in the map below 0x100, so e.g. if the bus 
> > master IDE I/O space registers (claimed last in the list by `ata_piix') 
> > were assigned to 00000030-0000003f, then all hell would break loose.  It 
> > is exactly the mapping that happened in the absence of the code piece in 
> > question IIRC.
> 
> Are you sure pci-malta.c has to do anything like this as 
> pcibios_align_resource() does lower bound IO resource start addresses if 
> PCIBIOS_MIN_IO is set?

 Well, PCIBIOS_MIN_IO is never set for Malta and therefore stays at 0.  I 
could boot 2.6.11 with the hunk reverted and see what happens, not a big 
deal (I should have old GCC somewhere as a kernel such old would surely be 
a pain to build with modern GCC).  This stuff was badly broken before 
commit ae81aad5c2e1 (and there was support there too for the Atlas board, 
a weird one with a Philips SAA9730 southbridge and supporting a subset of 
the same CPU core cards as the Malta board does).

> How about this patch below?
> 
> (I'm not sure if it should actually be
> 	PCIBIOS_MIN_IO = 0x1000 - hose->io_resource->start;
> to allow resources starting from 0x1000 if ->start is not at 0.)

 I'd have to go through the relevant datasheets to see whether it can 
actually happen in reality.  Perhaps we can just hardwire PCIBIOS_MIN_IO 
to 0x1000 instead, similarly to what other MIPS platforms do.  After all 
Malta's southbridge is on the mainboard and therefore always the same, 
regardless of the northbridge (system controller in MIPS-speak) which 
comes with the pluggable CPU core card.

 NB there are commit c5de50dada14 ("MIPS: Malta: Change start address to 
avoid conflicts.") and commit 27547abf36af ("MIPS: malta: Incorporate 
PIIX4 ACPI I/O region in PCI controller resources") that fiddled with this 
code piece.  Especially the latter one refers additional commits that may 
give further insights.  And the former one removed a "FIXME" annotation, 
which suggests I didn't consider the solution perfect back 20 years ago, 
but given how long it stayed there it was surely good enough for its time.

  Maciej

