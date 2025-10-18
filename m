Return-Path: <linux-pci+bounces-38636-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E6EBEDC4E
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 23:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DA81B4E1E5F
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 21:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C33B2459F7;
	Sat, 18 Oct 2025 21:38:35 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A711EE7B9;
	Sat, 18 Oct 2025 21:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760823515; cv=none; b=j1yJ7ZEgfC7PdjRk+dTKURVPCSMYKHrl6NQBLn8qzxlaFvKXq1xadKCx01YbaXzwmo1hajP82x+UTv4o4IIT5K2yPE2TDC7hIGB8SdUfZQcTTW2Pznv1dqj9mPIyP4n3K/0hgV6DuNvQjxEtKM7EV6V5djnHcxZ/rsQiuEwsWKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760823515; c=relaxed/simple;
	bh=mMSO7OTeeJdmp6XTr2PDyhayshJv0eZcc/JJkB1qmcI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Z420HOmojXWxnK3VMeMSb5OZltLJbxWagOK3fzVpBIpNAEF1ysa4+N8d76Z1QXM4eLt5Akc6BiFh+H/3fPfyVE1zQTFB1EbFBxGwP/HeaVAzk45S+FRzVDrVKBzXoKoZcMef0r4/O0E12u8ohtkQFQHvdiy0NLzSvYp3AaHhr2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 1751B92009C; Sat, 18 Oct 2025 23:38:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 1110D92009B;
	Sat, 18 Oct 2025 22:38:31 +0100 (BST)
Date: Sat, 18 Oct 2025 22:38:30 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
cc: linux-pci@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, 
    Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
    Bjorn Helgaas <bhelgaas@google.com>, linux-mips@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] MIPS: Malta: Use pcibios_align_resource() to
 block io range
In-Reply-To: <20251017110903.1973-1-ilpo.jarvinen@linux.intel.com>
Message-ID: <alpine.DEB.2.21.2510181744400.39634@angie.orcam.me.uk>
References: <20251017110903.1973-1-ilpo.jarvinen@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 17 Oct 2025, Ilpo Järvinen wrote:

> According to Maciej W. Rozycki <macro@orcam.me.uk>, the
> mips_pcibios_init() for malta adjusts root bus IO resource start
> address to prevent interfering with PIIX4 I/O cycle decoding. Adjusting
> lower bound leaves PIIX4 IO resources outside of the root bus resource
> and assign_fixed_resource_on_bus() does not link the resources into the
> resource tree.

 As mentioned in the other reply resource assignments such as:

00000000-00ffffff : MSC PCI I/O
  00000000-0000001f : 0000:00:0a.2
  00000020-00000021 : pic1
  00000030-0000003f : 0000:00:0a.1
  00000040-0000005f : 0000:00:0b.0
  00000060-0000006f : i8042
  00000070-00000077 : rtc0
  000000a0-000000a1 : pic2

otherwise result, which -- unsurprisingly -- break things.

> Prior to commit ae81aad5c2e1 ("MIPS: PCI: Use pci_enable_resources()")
> the arch specific pcibios_enable_resources() did not check if the
> resources were assigned which diverges from what PCI core checks,
> effectively hiding the PIIX4 IO resources were not properly within the
> resource tree. After starting to use pcibios_enable_resources() from
> PCI core, enabling PIIX4 fails:
> 
> ata_piix 0000:00:0a.1: BAR 0 [io  0x01f0-0x01f7]: not claimed; can't enable device
> ata_piix 0000:00:0a.1: probe with driver ata_piix failed with error -22
> 
> MIPS PCI code already has support for enforcing lower bounds using
> PCIBIOS_MIN_IO in pcibios_align_resource() without altering the IO
> window start address itself. Make malta PCI code too to use
> PCIBIOS_MIN_IO.

 So this does bring the ATA interface back to life:

 ata_piix 0000:00:0a.1: assign IRQ: got 0
-ata_piix 0000:00:0a.1: BAR 0 [io  0x01f0-0x01f7]: not claimed; can't enable device
-ata_piix 0000:00:0a.1: probe with driver ata_piix failed with error -22
+scsi host0: ata_piix
+scsi host1: ata_piix
+ata1: PATA max UDMA/33 cmd 0x1f0 ctl 0x3f6 bmdma 0x1800 irq 14 lpm-pol 0
+ata2: PATA max UDMA/33 cmd 0x170 ctl 0x376 bmdma 0x1808 irq 15 lpm-pol 0
[...]
+ata2.00: CFA: ST625211CF, 3.04, max UDMA/33
+ata2.00: 4883760 sectors, multi 0: LBA
[...]
+scsi 1:0:0:0: Direct-Access     ATA      ST625211CF       3.04 PQ: 0 ANSI: 5
+sd 1:0:0:0: [sda] 4883760 512-byte logical blocks: (2.50 GB/2.33 GiB)
+sd 1:0:0:0: [sda] Write Protect is off
+sd 1:0:0:0: [sda] Mode Sense: 00 3a 00 00
+sd 1:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
+sd 1:0:0:0: [sda] Preferred minimum I/O size 512 bytes

and also brings PS/2 interfaces, which weren't there before for whatever 
reason given that they are not PCI devices:

+serio: i8042 KBD port at 0x60,0x64 irq 1
+serio: i8042 AUX port at 0x60,0x64 irq 12

though I guess hardly anyone has ever used these ports with the Malta (it 
does have actual connectors).

 However it also takes some resource reservations away:

-00000000-0000001f : dma1
-00000020-00000021 : pic1
-00000040-0000005f : timer
-00000060-0000006f : keyboard
-00000070-00000077 : rtc0
-00000080-0000008f : dma page reg
-000000a0-000000a1 : pic2
-000000c0-000000df : dma2
-00000170-00000177 : ata_piix
-000001f0-000001f7 : ata_piix
-000002f8-000002ff : serial
-00000376-00000376 : ata_piix
-00000378-0000037a : parport0
-0000037b-0000037f : parport0
-000003f2-000003f2 : floppy
-000003f4-000003f5 : floppy
-000003f6-000003f6 : ata_piix
-000003f7-000003f7 : floppy
-000003f8-000003ff : serial
-00001000-00ffffff : MSC PCI I/O
+00000000-00ffffff : MSC PCI I/O
+  00000020-00000021 : pic1
+  00000060-0000006f : i8042
+  00000070-00000077 : rtc0
+  000000a0-000000a1 : pic2
+  00000170-00000177 : 0000:00:0a.1
+    00000170-00000177 : ata_piix
+  000001f0-000001f7 : 0000:00:0a.1
+    000001f0-000001f7 : ata_piix
+  000002f8-000002ff : serial
+  00000376-00000376 : 0000:00:0a.1
+    00000376-00000376 : ata_piix
+  00000378-0000037a : parport0
+  0000037b-0000037f : parport0
+  000003f2-000003f2 : floppy
+  000003f4-000003f5 : floppy
+  000003f6-000003f6 : 0000:00:0a.1
+    000003f6-000003f6 : ata_piix
+  000003f7-000003f7 : floppy
+  000003f8-000003ff : serial
   00001000-0000103f : 0000:00:0a.3
   00001040-0000105f : 0000:00:0a.2
     00001040-0000105f : uhci_hcd

-- as you can see the PIT timer resource and ISA DMA registers (used by 
the SuperIO devices, such as the FDD) are now gone.  I'm concerned about 
it even though it seems to have no visible impact on system operation.

 All in all this change does fix a serious regression and therefore:

Tested-by: Maciej W. Rozycki <macro@orcam.me.uk>

however I think the missing resource reservations need to be investigated.

> Fixes: aa0980b80908 ("Fixes for system controllers for Atlas/Malta core cards.")

 I don't think it's correct to refer this here; things worked just fine up 
to ae81aad5c2e1 even if via different means and backporting blindly could 
be dangerous.  It might be worth mentioning somewhere in the text though.

  Maciej

