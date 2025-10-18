Return-Path: <linux-pci+bounces-38635-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E6031BEDC42
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 23:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ACDEB4E1152
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 21:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FEBA25C6F1;
	Sat, 18 Oct 2025 21:33:00 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092E423B0;
	Sat, 18 Oct 2025 21:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760823180; cv=none; b=pcc3APSbJlaAuyP683mNjI8AsLhcOgVfF70hVmZEs2CQGhmi3aExC1mwchg+W8bjAAioWY3kIEoPI8xlAZXA6WwxWOYouUDDI+uqbpohT683ZVHPelP9NxgzRUru8XCE67MO5e3Q9/P9bxL4SbNcTCdFNrjWGLoxHfiyYxxmVss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760823180; c=relaxed/simple;
	bh=ONxbqzhxhsnanjoNPDhprLC2BD84hL7dK3VhhyvFXbI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=NKNUsmouX1Dy0ms8RmPhTJSiRpQz1jQ/T0cGl8rPCVRdYHjz0ipOshFvzHwDlK4uVk/jdfSg3z+gTD7CF1nz5jCsvd8u2A0l24qPv0ditqZ2q8r/kGJwwn6UZ0hTseGZmIXii7JBBn5pH5b9itfVzQklOJU6LVnyZupZJ3ouU4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id E5F9492009C; Sat, 18 Oct 2025 23:32:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id D958B92009B;
	Sat, 18 Oct 2025 22:32:47 +0100 (BST)
Date: Sat, 18 Oct 2025 22:32:47 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
    Guenter Roeck <linux@roeck-us.net>, Bjorn Helgaas <bhelgaas@google.com>, 
    linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 03/24] MIPS: PCI: Use pci_enable_resources()
In-Reply-To: <alpine.DEB.2.21.2510141232400.39634@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2510181605570.39634@angie.orcam.me.uk>
References: <20250829131113.36754-1-ilpo.jarvinen@linux.intel.com> <20250829131113.36754-4-ilpo.jarvinen@linux.intel.com> <9085ab12-1559-4462-9b18-f03dcb9a4088@roeck-us.net> <aO1sWdliSd03a2WC@alpha.franken.de> <alpine.DEB.2.21.2510132229120.39634@angie.orcam.me.uk>
 <74ed2ce0-744a-264f-6042-df4bbec0f58e@linux.intel.com> <alpine.DEB.2.21.2510141232400.39634@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 14 Oct 2025, Maciej W. Rozycki wrote:

> > > As you can see there are holes in the map below 0x100, so e.g. if the bus 
> > > master IDE I/O space registers (claimed last in the list by `ata_piix') 
> > > were assigned to 00000030-0000003f, then all hell would break loose.  It 
> > > is exactly the mapping that happened in the absence of the code piece in 
> > > question IIRC.
> > 
> > Are you sure pci-malta.c has to do anything like this as 
> > pcibios_align_resource() does lower bound IO resource start addresses if 
> > PCIBIOS_MIN_IO is set?
> 
>  Well, PCIBIOS_MIN_IO is never set for Malta and therefore stays at 0.  I 
> could boot 2.6.11 with the hunk reverted and see what happens, not a big 
> deal (I should have old GCC somewhere as a kernel such old would surely be 
> a pain to build with modern GCC).  This stuff was badly broken before 
> commit ae81aad5c2e1 (and there was support there too for the Atlas board, 
> a weird one with a Philips SAA9730 southbridge and supporting a subset of 
> the same CPU core cards as the Malta board does).

 Well, it is a big deal after all, since I've lost my old CoreLV CPU card
and the replacement Core74K one is too new for 2.6.x both in terms of the 
CPU and the system controller.  No doubt with some patching it should be 
able to get it booted, but it's not worth the effort.

 So instead I've just removed the hunk with my most recent compilation and 
what I've got is:

ata1: PATA max UDMA/33 cmd 0x1f0 ctl 0x3f6 bmdma 0x30 irq 14 lpm-pol 0
ata2: PATA max UDMA/33 cmd 0x170 ctl 0x376 bmdma 0x38 irq 15 lpm-pol 0

(notice the 0x30/0x38 bmdma allocations, which just confirms my memory) 
and then a temporary hang, a couple of more lines printed and the system 
silently rebooted back into YAMON.

 Having configured with ATA and PCNET32 disabled I get this:

00000000-00ffffff : MSC PCI I/O
  00000000-0000001f : 0000:00:0a.2
  00000020-00000021 : pic1
  00000030-0000003f : 0000:00:0a.1
  00000040-0000005f : 0000:00:0b.0
  00000060-0000006f : i8042
  00000070-00000077 : rtc0
  000000a0-000000a1 : pic2
  00000170-00000177 : 0000:00:0a.1
  000001f0-000001f7 : 0000:00:0a.1
  000002f8-000002ff : serial
  00000376-00000376 : 0000:00:0a.1
  00000378-0000037a : parport0
  0000037b-0000037f : parport0
  000003f6-000003f6 : 0000:00:0a.1
  000003f8-000003ff : serial
  00000400-000004ff : 0000:00:13.0
  00000800-0000087f : 0000:00:12.0
    00000800-0000087f : defxx
  00001000-0000103f : 0000:00:0a.3
  00001100-0000110f : 0000:00:0a.3

which does look nasty (although technically correctly shows southbridge 
resources within the system controller's PCI I/O window).  At least the 
defxx driver still works with the FDDI network interface at its port I/O 
assignment so the system boots multiuser NFS-rooted.

  Maciej

