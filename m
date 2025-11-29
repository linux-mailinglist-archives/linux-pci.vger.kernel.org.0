Return-Path: <linux-pci+bounces-42281-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 517D9C9389B
	for <lists+linux-pci@lfdr.de>; Sat, 29 Nov 2025 07:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CB7843483C3
	for <lists+linux-pci@lfdr.de>; Sat, 29 Nov 2025 06:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D3623815D;
	Sat, 29 Nov 2025 06:04:36 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35564199D8;
	Sat, 29 Nov 2025 06:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764396276; cv=none; b=LszNJXzbO1wf8YBoRJkqMFv0F2r/CzT3hpRnDUTSCj9xIoRvfz2yoXcO3oUbiFw+Wou7F1zsYtKLhBNDr3Ln33uHS8lQg1JUU5cKpUn1u5X1WxB75GiRizmGNS0NeIFGv17kkYK8EVV+6xmeSufwSdMhwE4bdYj6eh+X/2HIQBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764396276; c=relaxed/simple;
	bh=7Y7L9/9AR+JgSfgYWMgALMG4KGAvDl2SPJwmGicCKp8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=d6Yj4IigGsyc4dIDufzV8y3eZn8WC9KWK0YvhKWMUz1IXcYiAEQMlX5MHc2WZ0ZTOU6gFAlemUVEjea/jYXNEMC3JkeaynDj9AFgfkRUGeo61R03ahE2GtzGMOTUE6Wwm2d8qQcyCEslJd1HGYPt0ziytu/dNLicsoGcSDS+Sog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 15F1C92009C; Sat, 29 Nov 2025 07:04:25 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 0E9A792009B;
	Sat, 29 Nov 2025 06:04:25 +0000 (GMT)
Date: Sat, 29 Nov 2025 06:04:24 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
cc: Manivannan Sadhasivam <mani@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, 
    Lorenzo Pieralisi <lpieralisi@kernel.org>, 
    =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
    Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
    Krzysztof Kozlowski <krzk@kernel.org>, 
    Alim Akhtar <alim.akhtar@samsung.com>, 
    Jonathan Chocron <jonnyc@amazon.com>, linux-pci@vger.kernel.org, 
    linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
    linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v9 4/4] PCI: dwc: Support ECAM mechanism by enabling iATU
 'CFG Shift Feature'
In-Reply-To: <a4c6d47f-28b5-40d3-bc82-10aeb14f8e78@oss.qualcomm.com>
Message-ID: <alpine.DEB.2.21.2511290428340.36486@angie.orcam.me.uk>
References: <20250909-controller-dwc-ecam-v9-0-7d5b651840dd@kernel.org> <20250909-controller-dwc-ecam-v9-4-7d5b651840dd@kernel.org> <alpine.DEB.2.21.2511280256260.36486@angie.orcam.me.uk> <c7aea2b3-6984-40f5-8234-14d265dabefc@oss.qualcomm.com>
 <alpine.DEB.2.21.2511280755440.36486@angie.orcam.me.uk> <cabf4c20-095b-4579-adc1-146a566b19b9@oss.qualcomm.com> <alpine.DEB.2.21.2511281714030.36486@angie.orcam.me.uk> <a4c6d47f-28b5-40d3-bc82-10aeb14f8e78@oss.qualcomm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="-2058476832-100400859-1764393915=:36486"
Content-ID: <alpine.DEB.2.21.2511290540240.36486@angie.orcam.me.uk>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---2058476832-100400859-1764393915=:36486
Content-Type: text/plain; CHARSET=US-ASCII
Content-ID: <alpine.DEB.2.21.2511290540241.36486@angie.orcam.me.uk>

On Sat, 29 Nov 2025, Krishna Chaitanya Chundru wrote:

> > > Hi Maciej, Can you try attached patch and let me know if that is helping
> > > you
> > > or not. - Krishna Chaitanya.
> >   No change, it's still broken, sorry.
> HI Maciej,
> For the previous patch can you apply this diff and share me dmesg o/p

 Your patch came though garbled, likely due to:

Content-Type: text/plain; charset=UTF-8; format=flowed

Please refer Documentation/process/email-clients.rst and reconfigure your 
e-mail client if possible.

 Regardless, I've fixed it up by hand and the only difference in the log, 
except for usual noise which I removed, is this:

--- dmesg-bad.log	2025-11-28 03:47:29.582049781 +0100
+++ dmesg-debug.log	2025-11-29 05:41:23.384645926 +0100
@@ -164,6 +164,8 @@
 fu740-pcie e00000000.pcie: ECAM at [mem 0xdf0000000-0xdffffffff] for [bus 00-ff]
 fu740-pcie e00000000.pcie: Using 256 MSI vectors
 fu740-pcie e00000000.pcie: iATU: unroll T, 8 ob, 8 ib, align 4K, limit 4096G
+fu740-pcie e00000000.pcie: Current iATU OB index 2
+fu740-pcie e00000000.pcie: Current iATU OB index 4
 fu740-pcie e00000000.pcie: cap_exp at 70
 fu740-pcie e00000000.pcie: PCIe Gen.1 x8 link up
 fu740-pcie e00000000.pcie: changing speed back to original

I've attached a full copy of the debug log too.  I hope this helps you 
narrow the issue down or otherwise let me know what to try next.

 NB I note that code you've been poking at only refers resources of the 
IORESOURCE_MEM type.  What about IORESOURCE_IO, which seems more relevant 
here?

 Also as a quick check I've now reconfigured the defxx driver for PCI port 
I/O (which is a one-liner; the mapping used to be selectable by hand, but 
distributions got it wrong for systems w/o PCI port I/O, so I switched the 
driver to an automatic choice a few years ago, but the logic remains):

# cat /proc/ioports
00000000-0000ffff : pcie@e00000000
  00001000-00002fff : PCI Bus 0000:01
    00001000-00002fff : PCI Bus 0000:02
      00001000-00002fff : PCI Bus 0000:05
        00001000-00002fff : PCI Bus 0000:06
          00001000-00001fff : PCI Bus 0000:07
          00001000-00001007 : 0000:07:00.0
          00001000-00001002 : parport0
          00001003-00001007 : parport0
          00001008-0000100b : 0000:07:00.0
          00001008-0000100a : parport0
          00002000-00002fff : PCI Bus 0000:08
          00002000-00002fff : PCI Bus 0000:09
          00002000-000020ff : 0000:09:01.0
          00002100-0000217f : 0000:09:02.0
          00002100-0000217f : defxx
# 

and:

defxx 0000:09:02.0: assign IRQ: got 40
defxx: v1.12 2021/03/10  Lawrence V. Stefani and others
defxx 0000:09:02.0: enabling device (0000 -> 0003)
defxx 0000:09:02.0: enabling bus mastering
0000:09:02.0: DEFPA at I/O addr = 0x2100, IRQ = 40, Hardware addr = 00-60-6d-xx-xx-xx
0000:09:02.0: registered as fddi0

(as at commit 4660e50cf818) and likewise it has stopped working here from 
commit 0da48c5b2fa7 onwards:

defxx 0000:09:02.0: assign IRQ: got 40
defxx: v1.12 2021/03/10  Lawrence V. Stefani and others
defxx 0000:09:02.0: enabling device (0000 -> 0003)
defxx 0000:09:02.0: enabling bus mastering
0000:09:02.0: Could not read adapter factory MAC address!

So it's definitely nothing specific to the parport driver, but rather a 
general issue with PCI/e port I/O not working anymore.  I do hope these 
observations will let you address the issue now.  You might be able to 
reproduce it with hardware you have available even.

  Maciej
---2058476832-100400859-1764393915=:36486
Content-Type: application/x-xz; NAME=dmesg-debug.log.xz
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.DEB.2.21.2511290525150.36486@angie.orcam.me.uk>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME=dmesg-debug.log.xz

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
1UK9iAMA1N2GiLHEZ/sCAAAAAARZWg==

---2058476832-100400859-1764393915=:36486--

