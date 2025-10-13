Return-Path: <linux-pci+bounces-37995-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21DA9BD6AE4
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 01:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 757F71889508
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 23:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A582B21CC55;
	Mon, 13 Oct 2025 23:00:38 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5786B2940B;
	Mon, 13 Oct 2025 23:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760396438; cv=none; b=JUhOgYgUp4v9vp05+tZSTdiJFBXAq/uH2rDRj6z608jg4UoFdTWsT6YQqJJJXSZcMlOQ1S7bzr+h4JaU+Tb0f981ET7c9GvoPNBR6odKn8Ss0MytV5EFofDNe9eau+HQfTfa8Nn6xKCgD99z9WqUkP6/l9NHEeTybkqOSf8gsgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760396438; c=relaxed/simple;
	bh=EPKuwdJexlHb1O0c9HGWbRR5IYHP7Xw+ry5A6PSboGw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=bRy0W9hwVwTgMllhAMLDRymO5iLWbsn4vJVHTRAEINcPwo3l3Hve9UqmcYehmoD34CabtP7I8Npdngn0h6oZxV+enQRrXqK3hiYH1bfvdZRfQTuonMhxZAqhPjwz5sFxNVnHQO5LQYAT8Uq7Y9k1AhHcN+CWqy18JH81XuuVQ2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 7DDCA92009C; Tue, 14 Oct 2025 01:00:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 76F2E92009B;
	Tue, 14 Oct 2025 00:00:27 +0100 (BST)
Date: Tue, 14 Oct 2025 00:00:27 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
cc: Guenter Roeck <linux@roeck-us.net>, 
    =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
    Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/24] MIPS: PCI: Use pci_enable_resources()
In-Reply-To: <aO1sWdliSd03a2WC@alpha.franken.de>
Message-ID: <alpine.DEB.2.21.2510132229120.39634@angie.orcam.me.uk>
References: <20250829131113.36754-1-ilpo.jarvinen@linux.intel.com> <20250829131113.36754-4-ilpo.jarvinen@linux.intel.com> <9085ab12-1559-4462-9b18-f03dcb9a4088@roeck-us.net> <aO1sWdliSd03a2WC@alpha.franken.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 13 Oct 2025, Thomas Bogendoerfer wrote:

> > This patch causes boot failures when trying to boot mips images from
> > ide drive in qemu. As far as I can see the interface no longer instantiates.
> > 
> > Reverting this patch fixes the problem. Bisect log attached for reference.
> 
> Patch below fixes my qemu malta setup. Now I'm wondering, why this is
> needed. It was added with commit
> 
> aa0980b80908 ("Fixes for system controllers for Atlas/Malta core cards.")
> 
> Maciej, do you remember why this is needed ?

 I do.  The reason is preventing PCI port I/O mappings below 0x100, which 
interferes badly with how the PIIX4 decodes port I/O cycles.  That did 
happen in the field, wreaking havoc and prompting my change.

 By the look of the code it would definitely trigger for the Bonito64 
system controller, which has a fixed port I/O target address range and, 
depending on the settings left by the firmware, it might also trigger for 
the Galileo GT64120A and SOC-it 101 system controllers, which have 
variable port I/O target address ranges.

 Here's an example map of Malta port I/O resources (SOC-it 101 variant):

00000000-0000001f : dma1
00000020-00000021 : pic1
00000040-0000005f : timer
00000060-0000006f : keyboard
00000070-00000077 : rtc0
00000080-0000008f : dma page reg
000000a0-000000a1 : pic2
000000c0-000000df : dma2
00000170-00000177 : ata_piix
000001f0-000001f7 : ata_piix
000002f8-000002ff : serial
00000376-00000376 : ata_piix
00000378-0000037a : parport0
0000037b-0000037f : parport0
000003f6-000003f6 : ata_piix
000003f8-000003ff : serial
00001000-00ffffff : MSC PCI I/O
  00001000-0000103f : 0000:00:0a.3
  00001040-0000105f : 0000:00:0a.2
    00001040-0000105f : uhci_hcd
  00001060-0000107f : 0000:00:0b.0
    00001060-0000107f : pcnet32_probe_pci
  00001080-000010ff : 0000:00:12.0
    00001080-000010ff : defxx
  00001100-0000110f : 0000:00:0a.3
  00001400-000014ff : 0000:00:13.0
  00001800-0000180f : 0000:00:0a.1
    00001800-0000180f : ata_piix

As you can see there are holes in the map below 0x100, so e.g. if the bus 
master IDE I/O space registers (claimed last in the list by `ata_piix') 
were assigned to 00000030-0000003f, then all hell would break loose.  It 
is exactly the mapping that happened in the absence of the code piece in 
question IIRC.

 The choice of 0x1000 as the lower boundary IIRC has something to do with 
alignment; I think the decoding base has to be a multiple of 0x1000 and 
given that the ACPI resource is decoded by a non-standard BAR at 0x40 in 
the configuration space (set up by `malta_piix_func3_base_fixup' BTW) we 
just need to match its setting.

 Can you please check what the port I/O map looks like with your setup 
with and without your patch applied?

 NB there is still something fishy with the setup of SOC-it 101's PCI 
decoding windows, which is why I have forced `defxx' with a patch to use 
port I/O, as reported above.  The driver uses MMIO unconditionally on PCI 
systems nowadays, but using MMIO prevents it from working with the SOC-it 
101 system controller and I yet need to debug it.  Conversely MMIO used to 
work just fine with the Galileo GT64120A system controller while I still 
had one operational.

 HTH,

  Maciej

