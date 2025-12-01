Return-Path: <linux-pci+bounces-42379-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 83CB5C98590
	for <lists+linux-pci@lfdr.de>; Mon, 01 Dec 2025 17:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1AB714E3E19
	for <lists+linux-pci@lfdr.de>; Mon,  1 Dec 2025 16:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FAEA33557D;
	Mon,  1 Dec 2025 16:42:47 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83439334C32;
	Mon,  1 Dec 2025 16:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764607367; cv=none; b=EyHKdESWotDPnzy8sQGQf9PVAe+c1ApZQUFkXcDRvJ1tqlj4ajRd4JjuZJrFvPda73KEnbQmHavB+z2hZhG1kDbpRzz94HydzOGms4ukclbFwCX1M6nogXU6kqiDLs2rYBAoNsU68Sjo9DjvC00r2f7ix06VlUfiWRf4MxM32lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764607367; c=relaxed/simple;
	bh=3y20a/7HqrRAO0GSDVb5dlt84oR3CLrMRD5wIyWGpo0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Ppxinz9mlvJd+naS9KJRHBU5mGs24pAm8weyF9XVG2+2B1IT0L88A3f7cDf4jF23jr2OEzVPm6YEZh0hYmdxmVp5PsGcGatKzqvU39EmAlFVcOveIzuRpCRvjQRQ9siZ1KidsWYYEIj2VG0ADH5itEVPrMZJMxbYk4bKAFtfMmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 2D8EC92009C; Mon,  1 Dec 2025 17:42:42 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 266B992009B;
	Mon,  1 Dec 2025 16:42:42 +0000 (GMT)
Date: Mon, 1 Dec 2025 16:42:42 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Manivannan Sadhasivam <mani@kernel.org>
cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
    Jingoo Han <jingoohan1@gmail.com>, 
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
In-Reply-To: <syg7vpbt3w53s24hgl7b6w64odmif5bq557lwlvzlbvgkukwcn@66jtzzc3vtiu>
Message-ID: <alpine.DEB.2.21.2512011617250.49654@angie.orcam.me.uk>
References: <20250909-controller-dwc-ecam-v9-0-7d5b651840dd@kernel.org> <20250909-controller-dwc-ecam-v9-4-7d5b651840dd@kernel.org> <alpine.DEB.2.21.2511280256260.36486@angie.orcam.me.uk> <c7aea2b3-6984-40f5-8234-14d265dabefc@oss.qualcomm.com>
 <alpine.DEB.2.21.2511280755440.36486@angie.orcam.me.uk> <cabf4c20-095b-4579-adc1-146a566b19b9@oss.qualcomm.com> <alpine.DEB.2.21.2511281714030.36486@angie.orcam.me.uk> <a4c6d47f-28b5-40d3-bc82-10aeb14f8e78@oss.qualcomm.com> <alpine.DEB.2.21.2511290428340.36486@angie.orcam.me.uk>
 <h7pgm3lqolm53sb4wrcpcurk4ghz4tulqnr7vgd7rzxy4hscue@jcn5tepevlwl> <syg7vpbt3w53s24hgl7b6w64odmif5bq557lwlvzlbvgkukwcn@66jtzzc3vtiu>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 1 Dec 2025, Manivannan Sadhasivam wrote:

> > > So it's definitely nothing specific to the parport driver, but rather a 
> > > general issue with PCI/e port I/O not working anymore.  I do hope these 
> > > observations will let you address the issue now.  You might be able to 
> > > reproduce it with hardware you have available even.
> > > 
> > 
> > Yes, looks like the I/O port access is not working with the CFG Shift feature.
> > The spec says that both I/O and MEM TLPs should be handled by this feature, so
> > we are currently unsure why MEM works, but not I/O.

 As I say, last time I checked (for another reason) documentation was not 
available to the general public, so I can't help with that.

> > The issue you reported with parport_pc driver is that the driver gets probed,
> > but it fails to detect the parallel ports on the device. More precisely, it
> > fails due to the parport_SPP_supported() check in drivers/parport/parport_pc.c.
> > This function performs some read/write checks to make sure that the port exists,
> > but most likely the read value doesn't match the written one. And since there is
> > no log printed in this function, it just failed silently.

 Whatever the exact transaction conditions are port I/O TLPs seem not to 
make it through to the requested target device anymore.

 FWIW the defxx driver issues a command to the device's command register 
and wants to see a successful completion status in the status register 
before retrieving the MAC address via the data register.  So it's not a 
simple case of poking at a register and reading it back, but the end 
result is the same: the device cannot be talked to.

> > We will check why I/O access fails with ECAM mode and revert back asap. Since
> > the merge window is now open, it becomes difficult to revert the CFG shift
> > feature cleanly. The timing of the report also made it difficult to fix the
> > issue in v6.18. Hopefully, we can backport the fix once we identify the culprit.

 No worries, I've been around for long enough (short of 30 years) to know 
the process.

 FWIW the original change would've best been reverted for 6.18 as a fatal 
regression, however port I/O is uncommon enough nowadays we can defer any 
final decision to 6.19 I suppose.  I'm glad I've tripped over this in the 
first place as I'm not eager to upgrade all my lab devices all the time, 
and it was owing to another issue only that I chose this moment to move 
forward, not so long after the original commit.

> Can you try the attached patch? It is a reworked version of Krishna's patch. I
> just moved things around to check potential override issue.

 No change in behaviour, sorry.  I suppose it's this range of host address 
decoding:

fu740-pcie e00000000.pcie:       IO 0x0060080000..0x006008ffff -> 0x0060080000

aka:

pci_bus 0000:00: root bus resource [io  0x0000-0xffff] (bus address [0x60080000-0x6008ffff])

that you're after.  Are you sure your code discovers it correctly?  As I 
say I can only see IORESOURCE_MEM references and no IORESOURCE_IO ones as 
would be appropriate for the root bus resource quoted.

  Maciej

