Return-Path: <linux-pci+bounces-29915-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 051E7ADC32E
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 09:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 128F717497C
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 07:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA12C136358;
	Tue, 17 Jun 2025 07:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MFmHI/y+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D5B28D85F;
	Tue, 17 Jun 2025 07:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750144995; cv=none; b=RcRUtfMKTHdsMr3OemgLI0lcYTV4h1EHVD43TjQ+B4CN2qwGlegyEdP9AFCJSTt98GsZ7f8H7S6Pd4M/Xh7S8hPXutrttaR9fQJdCn387LLKbPd4PIEkXrUXcsPb+k259vYxN5GNpXC+2vPuJYspW3RCgeHzd2dbPimNqEwbMy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750144995; c=relaxed/simple;
	bh=f11hWl4NtA1ewNVG2EX9gYBJpVleqyEr0TOtEB8ZeF8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cum7rpjodru2YRUYpMaMeEGIgbAb7hSEhafXjL33ONEk12P94ZIO+9j1DLK4g9nKzLqHgPDQqn9WlLLnkmgPLgcO0BH1Y756tBHoPCnTO0At1xvnKdiWm+fNk7Z8GePLyx9rUsIL3uPN93OqKOPu7wCVHCG8eZJ3sMZEZzC8buI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MFmHI/y+; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 924EF58267E;
	Tue, 17 Jun 2025 07:00:39 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id DF5FC44459;
	Tue, 17 Jun 2025 07:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1750143631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c54X4q8yozguoRQqbVkcnFg4rictDWQ/ozHe3OqAcDo=;
	b=MFmHI/y+p5sJ80eQ4s84rkWG8dTBnsg53y+lIdVMySqFH3kXrdFd96UoQAMwYWdyYhc4mN
	sIkTqVsjSholwOLcgSFfDnEx/Vcbv7ypWPZJ/zewYOLBXN0gZRoBiGLwb5Bio64J0oJNQH
	AeTDy7iFaOY7sJTWE7+MNTSny1Zhi0PZESIbbF2Nj/udROiyTPy1M8zAAZ0c/yFM3M0dCP
	6J4A2sbuaokCGhdOfA9hG2SUyZ4bzwf72NNoCgi6N8XA30zPeLfglUyrI4JLVye3aYhnH+
	vTjIUiEidjQRcb0QxA7mIgcV2E0foqZxbu4cPQ/ehKmBhAW2Q67QXYF4dKXTcg==
Date: Tue, 17 Jun 2025 09:00:29 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: "robh+dt@kernel.org" <robh+dt@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, Saravana Kannan <saravanak@google.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Lizhi Hou <lizhi.hou@amd.com>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-pci@vger.kernel.org, Allan Nielsen <allan.nielsen@microchip.com>,
 Horatiu Vultur <horatiu.vultur@microchip.com>, Steen Hegelund
 <steen.hegelund@microchip.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v8 5/5] PCI: of: Create device-tree PCI host bridge node
Message-ID: <20250617090029.03283ea6@bootlin.com>
In-Reply-To: <3258d453-f262-4f1c-822b-5310a8346a2d@tuxon.dev>
References: <20250224141356.36325-1-herve.codina@bootlin.com>
	<20250224141356.36325-6-herve.codina@bootlin.com>
	<594d284e-afce-446a-9fcb-a67b157ef6dc@tuxon.dev>
	<20250611165617.641c7c09@bootlin.com>
	<3258d453-f262-4f1c-822b-5310a8346a2d@tuxon.dev>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddvkeejkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthekredtredtjeenucfhrhhomhepjfgvrhhvvgcuvehoughinhgruceohhgvrhhvvgdrtghoughinhgrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeetheejgeetudehiedvuedvteehhfegudevvdeftdduhfejleegheevteetvdeihfenucffohhmrghinhepsghoohhtlhhinhdrtghomhdpkhgvrhhnvghlrdhorhhgnecukfhppedvrgdtudemvgdtrgemvdekheemsgelkedtmegvgedttgemiegtgeefmegshegssgemrgegvdeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedvkeehmegsleektdemvgegtdgtmeeitgegfeemsgehsggsmegrgedvkedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhephhgvrhhvvgdrtghoughinhgrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduhedprhgtphhtthhopegtlhgruhguihhurdgsvgiinhgvrgesthhugihonhdruggvvhdprhgtphhtthhopehrohgshhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehgrhgvghhkhhesl
 hhinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrkhhrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrghrrghvrghnrghksehgohhoghhlvgdrtghomhdprhgtphhtthhopegshhgvlhhgrggrshesghhoohhglhgvrdgtohhmpdhrtghpthhtoheplhhiiihhihdrhhhouhesrghmugdrtghomh
X-GND-Sasl: herve.codina@bootlin.com

Hi Claudiu,

On Fri, 13 Jun 2025 16:36:16 +0300
Claudiu Beznea <claudiu.beznea@tuxon.dev> wrote:

...

> I pointed to the wrong function. It's not of_pci_make_host_bridge_node()
> [1] but of_pci_make_dev_node() which creates a node with a similar naming
> and makes things not working on my side.
> 
> [1] https://elixir.bootlin.com/linux/v6.15/source/drivers/pci/of.c#L694

Ok, so your issue is not related patches applied from the "PCI: of: Create
device-tree PCI host bridge node" series.
  https://lore.kernel.org/all/20250224141356.36325-6-herve.codina@bootlin.com/

Indeed, this series add the node creation for the host bridge with
of_pci_make_host_bridge_node() but you pointed now of_pci_make_dev_node()
which is the creation for PCI device node and this function was not modify by the
series.

of_pci_make_host_bridge_node() should not create anything. Can you confirm on your
side that it doesn't create any nodes.

If so, maybe the problem comes from of_irq_parse_raw() or similar.

...

> 
> > 
> > On this system, I didn't observed any issues but of course, the PCIe drivers are
> > different.
> > Also, on my system, no node were created by of_pci_make_host_bridge_node().  
> 
> Sorry for the confusion, it is of_pci_make_dev_node() on my side which
> creates the node.
> 
> > 
> > To be honest, I didn't re-test recently to see if something has been broken.
> > I can do that on my side with my system.

I have re-tested and I confirm that I have no issue on my system.

> > 
> > On your side, maybe you can have look at the Armada PCIe driver and see if
> > something could explain your behavior. I am not sure that you need to add the
> > pci@0,0 node in your DT.  
> 
> I can't find a driver that uses the approach I'm trying in my patches. This
> approach was suggested in the review process [2] by Rob who mentioned that
> now we should be able drop legacy interrupt controller nodes. There are
> some Apple device trees that points the interrupt-map to the port node (the
> way I tried in my workaround) [3], but I can't find more than that.
> 
> The topology in my case is:
> 
> root@smarc-rzg3s:~# lspci -t
> -[0000:00]---00.0-[01]----00.0
> 
> root@smarc-rzg3s:~# lspci
> 00:00.0 PCI bridge: Renesas Technology Corp. Device 0033
> 01:00.0 Non-Volatile memory controller: Micron Technology Inc 2550 NVMe SSD
> (DRAM-less) (rev 01)
> 
> When not working pci@0,0 is exported as follows in rootfs:
> 
> root@smarc-rzg3s:~# ls /sys/firmware/devicetree/base/soc/pcie@11e40000 -l
> -r--r--r--    1 root     root             4 Jan 12 10:28 #address-cells
> -r--r--r--    1 root     root             4 Jan 12 10:28 #interrupt-cells
> -r--r--r--    1 root     root             4 Jan 12 10:28 #size-cells
> -r--r--r--    1 root     root             8 Jan 12 10:28 bus-range
> -r--r--r--    1 root     root            13 Jan 12 10:28 clock-names
> -r--r--r--    1 root     root            24 Jan 12 10:28 clocks
> -r--r--r--    1 root     root            26 Jan 12 10:28 compatible
> -r--r--r--    1 root     root             4 Jan 12 10:28 device-id
> -r--r--r--    1 root     root             4 Jan 12 10:28 device_type
> -r--r--r--    1 root     root            28 Jan 12 10:28 dma-ranges
> -r--r--r--    1 root     root             0 Jan 12 10:28 interrupt-controller
> -r--r--r--    1 root     root           144 Jan 12 10:28 interrupt-map
> -r--r--r--    1 root     root            16 Jan 12 10:28 interrupt-map-mask
> -r--r--r--    1 root     root           164 Jan 12 10:28 interrupt-names
> -r--r--r--    1 root     root             4 Jan 12 10:28 interrupt-parrent

Why parrent instead of parent in interrupt-parrent ?

> -r--r--r--    1 root     root           192 Jan 12 10:28 interrupts
> -r--r--r--    1 root     root             5 Jan 12 10:28 name
> -r--r--r--    1 root     root             4 Jan 12 10:28 num-lanes
> drwxr-xr-x    2 root     root             0 Jan 12 10:17 pci@0,0
> -r--r--r--    1 root     root             4 Jan 12 10:28 phandle
> -r--r--r--    1 root     root             4 Jan 12 10:28 pinctrl-0
> -r--r--r--    1 root     root             8 Jan 12 10:28 pinctrl-names
> -r--r--r--    1 root     root             4 Jan 12 10:28 power-domains
> -r--r--r--    1 root     root            28 Jan 12 10:28 ranges
> -r--r--r--    1 root     root            16 Jan 12 10:28 reg
> -r--r--r--    1 root     root             4 Jan 12 10:28 renesas,sysc
> -r--r--r--    1 root     root            63 Jan 12 10:28 reset-names
> -r--r--r--    1 root     root            56 Jan 12 10:28 resets
> -r--r--r--    1 root     root             5 Jan 12 10:28 status
> -r--r--r--    1 root     root             4 Jan 12 10:28 vendor-id
> root@smarc-rzg3s:~#
> root@smarc-rzg3s:~# ls
> /sys/firmware/devicetree/base/soc/pcie@11e40000/pci@0,0 -l
> -r--r--r--    1 root     root             4 Jan 12 10:17 #address-cells
> -r--r--r--    1 root     root             4 Jan 12 10:17 #interrupt-cells
> -r--r--r--    1 root     root             4 Jan 12 10:17 #size-cells
> -r--r--r--    1 root     root             8 Jan 12 10:17 bus-range
> -r--r--r--    1 root     root            41 Jan 12 10:17 compatible
> -r--r--r--    1 root     root             4 Jan 12 10:17 device_type
> -r--r--r--    1 root     root           144 Jan 12 10:17 interrupt-map
> -r--r--r--    1 root     root            16 Jan 12 10:17 interrupt-map-mask
> -r--r--r--    1 root     root            32 Jan 12 10:17 ranges
> -r--r--r--    1 root     root            20 Jan 12 10:17 reg
> root@smarc-rzg3s:~#
> root@smarc-rzg3s:~#
> root@smarc-rzg3s:~#
> root@smarc-rzg3s:~#
> root@smarc-rzg3s:~# cat
> /sys/firmware/devicetree/base/soc/pcie@11e40000/pci@0,0/compatible
> pci1912,33pciclass,060400pciclass,0604root@smarc-rzg3s:~#
> root@smarc-rzg3s:~#
> root@smarc-rzg3s:~#
> 
> In case I describe a port in device tree, it works because the pci@0,0 is
> not created anymore when device is enumerated and thus the interrupt
> parsing is working.
> 
> Herve: do you have some hints?

First interrupt-parrent in your /sys/firmware/devicetree/base/soc/pcie@11e40000
files.

If it is just a typo in this email, maybe the interrupt parsing itself.

Can you provide an extract for the DT with nodes created at runtime.
I mean can you run 'dtc -I dtb -O dts /proc/device-tree' and provide the output
related to PCI nodes including the PCIe controller ?

> 
> Rob: do you know some device trees where the interrupt-map points to the
> node itself as suggested in [2] so that I can check is something is missing
> on my side?
> 
> Thank you,
> Claudiu
> 
> [2] https://lore.kernel.org/all/20250509210800.GB4080349-robh@kernel.org/
> [3]
> https://elixir.bootlin.com/linux/v6.15/source/arch/arm64/boot/dts/apple/t8112.dtsi#L951
> 

Best regards,
Hervé

-- 
Hervé Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

