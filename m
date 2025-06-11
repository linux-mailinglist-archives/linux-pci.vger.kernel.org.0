Return-Path: <linux-pci+bounces-29456-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33EB0AD595E
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 16:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7BBF3A57EC
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 14:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2355A2857CF;
	Wed, 11 Jun 2025 14:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fJiSPjmy"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB24B26A1D0;
	Wed, 11 Jun 2025 14:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749653786; cv=none; b=BuYNjuok1RDZaTbHBVc6YW8uKUj/5iaepUtVxiXvDtlEov/AWeFe4PETHVNyJrOl43I15LhyqY7xwKVwZpcS5KZ/lQKy+0P8oozUMNRaP1n9kLcIE/2gN1MWJO7nbpXrLmU6wmGr2aABkNfauGyAs9hvg978uov6fseNG7QXFQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749653786; c=relaxed/simple;
	bh=HbAVgJzxmHytKJ+Ywh2WokGuTgri+HoqWdPmSJduIFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V5wmdSTJlKtnG5jzLmLDqBI33BfLyZB54LRA7t62ElS0bLr+NVCMTda/VjJV5baGbXYI7ro0xS2dOjBekZ8DSWxTzAV7zXTiADBcsgrhsFbF+MyIj4B/kIzFTXNIwj4OcDrSdNxTt+WDrru2SEQT5aF+v73bb2a3bFwyh58Aa9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fJiSPjmy; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CE3B7441C6;
	Wed, 11 Jun 2025 14:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1749653779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v3Z+3u2W7PA87RlVTUWiVQeMe8kPAuxHo6SLi0E3GsA=;
	b=fJiSPjmyGi+Iy5+NQAIWyyC1tNAKCU8Rqyg48JpDWGFg0R2M5dDhXFvyjQeKOWtkpWhgeH
	1LkXXa0wLyVWqXHkf1fUO8EmZViyW5Rx9shiipJ2QKVN5dRpPsCGeTJR1tCXsb/E2kEAaR
	IPCu8cJ3kFza46ffqDj+o1+5LPutUPDJoCpzbzYNke02TukqkebDa+RFyzjo4KFADTB+0T
	00b8OtuLYfR3WZncs/SjcJsVtQumbhhS2CDXzVVZPIOtPdDo2XCPCzzueeqTSkPnyO9Q6j
	TcSWhbZ1bAWxH7+I8i0ckzZ2ALnlScS1w1PnqvVLT6Q1SuQzbJRrgqkBM6UWZw==
Date: Wed, 11 Jun 2025 16:56:17 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Rob Herring
 <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Lizhi Hou <lizhi.hou@amd.com>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-pci@vger.kernel.org, Allan Nielsen <allan.nielsen@microchip.com>,
 Horatiu Vultur <horatiu.vultur@microchip.com>, Steen Hegelund
 <steen.hegelund@microchip.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v8 5/5] PCI: of: Create device-tree PCI host bridge node
Message-ID: <20250611165617.641c7c09@bootlin.com>
In-Reply-To: <594d284e-afce-446a-9fcb-a67b157ef6dc@tuxon.dev>
References: <20250224141356.36325-1-herve.codina@bootlin.com>
	<20250224141356.36325-6-herve.codina@bootlin.com>
	<594d284e-afce-446a-9fcb-a67b157ef6dc@tuxon.dev>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduvdeglecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthekredtredtjeenucfhrhhomhepjfgvrhhvvgcuvehoughinhgruceohhgvrhhvvgdrtghoughinhgrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeejffelhfeiudetgeffieefgefgffdvuedvuedtvdefudduueekffelheehffekteenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehhvghrvhgvrdgtohguihhnrgessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudehpdhrtghpthhtoheptghlrghuughiuhdrsggviihnvggrsehtuhigohhnrdguvghvpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghkrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosghhsehkvghrnhgvl
 hdrohhrghdprhgtphhtthhopehsrghrrghvrghnrghksehgohhoghhlvgdrtghomhdprhgtphhtthhopegshhgvlhhgrggrshesghhoohhglhgvrdgtohhmpdhrtghpthhtoheplhhiiihhihdrhhhouhesrghmugdrtghomh
X-GND-Sasl: herve.codina@bootlin.com

Hi Claudiu,

On Wed, 11 Jun 2025 11:26:37 +0300
Claudiu Beznea <claudiu.beznea@tuxon.dev> wrote:

> Hi, Herve,
> 
> On 24.02.2025 16:13, Herve Codina wrote:
> > PCI devices device-tree nodes can be already created. This was
> > introduced by commit 407d1a51921e ("PCI: Create device tree node for
> > bridge").
> > 
> > In order to have device-tree nodes related to PCI devices attached on
> > their PCI root bus (the PCI bus handled by the PCI host bridge), a PCI
> > root bus device-tree node is needed. This root bus node will be used as
> > the parent node of the first level devices scanned on the bus. On
> > device-tree based systems, this PCI root bus device tree node is set to
> > the node of the related PCI host bridge. The PCI host bridge node is
> > available in the device-tree used to describe the hardware passed at
> > boot.
> > 
> > On non device-tree based system (such as ACPI), a device-tree node for
> > the PCI host bridge or for the root bus does not exist. Indeed, the PCI
> > host bridge is not described in a device-tree used at boot simply
> > because no device-tree are passed at boot.
> > 
> > The device-tree PCI host bridge node creation needs to be done at
> > runtime. This is done in the same way as for the creation of the PCI
> > device nodes. I.e. node and properties are created based on computed
> > information done by the PCI core. Also, as is done on device-tree based
> > systems, this PCI host bridge node is used for the PCI root bus.
> > 
> > With this done, hardware available in a PCI device that doesn't follow
> > the PCI model consisting in one PCI function handled by one driver can
> > be described by a device-tree overlay loaded by the PCI device driver on
> > non device-tree based systems. Those PCI devices provide a single PCI
> > function that includes several functionalities that require different
> > driver. The device-tree overlay describes in that case the internal
> > devices and their relationships. It allows to load drivers needed by
> > those different devices in order to have functionalities handled.
> > 
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> > ---
> >  drivers/pci/of.c          | 104 +++++++++++++++++++++++++++++++++++++-
> >  drivers/pci/of_property.c | 102 +++++++++++++++++++++++++++++++++++++
> >  drivers/pci/pci.h         |   6 +++
> >  drivers/pci/probe.c       |   2 +
> >  drivers/pci/remove.c      |   2 +
> >  5 files changed, 215 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> > index fb5e6da1ead0..c59429e909c0 100644
> > --- a/drivers/pci/of.c
> > +++ b/drivers/pci/of.c
> > @@ -731,7 +731,109 @@ void of_pci_make_dev_node(struct pci_dev *pdev)
> >  out_free_name:
> >  	kfree(name);
> >  }
> > -#endif
> > +
> > +void of_pci_remove_host_bridge_node(struct pci_host_bridge *bridge)
> > +{
> > +	struct device_node *np;
> > +
> > +	np = pci_bus_to_OF_node(bridge->bus);
> > +	if (!np || !of_node_check_flag(np, OF_DYNAMIC))
> > +		return;
> > +
> > +	device_remove_of_node(&bridge->bus->dev);
> > +	device_remove_of_node(&bridge->dev);
> > +	of_changeset_revert(np->data);
> > +	of_changeset_destroy(np->data);
> > +	of_node_put(np);
> > +}
> > +
> > +void of_pci_make_host_bridge_node(struct pci_host_bridge *bridge)
> > +{
> > +	struct device_node *np = NULL;
> > +	struct of_changeset *cset;
> > +	const char *name;
> > +	int ret;
> > +
> > +	/*
> > +	 * If there is already a device-tree node linked to the PCI bus handled
> > +	 * by this bridge (i.e. the PCI root bus), nothing to do.
> > +	 */
> > +	if (pci_bus_to_OF_node(bridge->bus))
> > +		return;
> > +
> > +	/* The root bus has no node. Check that the host bridge has no node too */
> > +	if (bridge->dev.of_node) {
> > +		dev_err(&bridge->dev, "PCI host bridge of_node already set");
> > +		return;
> > +	}
> > +
> > +	/* Check if there is a DT root node to attach the created node */
> > +	if (!of_root) {
> > +		pr_err("of_root node is NULL, cannot create PCI host bridge node\n");
> > +		return;
> > +	}
> > +
> > +	name = kasprintf(GFP_KERNEL, "pci@%x,%x", pci_domain_nr(bridge->bus),
> > +			 bridge->bus->number);  
> 
> After testing series [1] on next-20250528 I noticed the INTx are not
> working anymore. Debugging it, I found it is related to the creation of a
> node with this name.
> 
> On [1], the interrupt-map points to the pcie node itself. If I activate the
> debug messages in of_irq_parse_raw() I'm getting this output:
> 
> [    0.466542] rzg3s-pcie-host 11e40000.pcie: PCIe link status [0x100014e]
> [    0.466571] rzg3s-pcie-host 11e40000.pcie: PCIe x1: link up
> [    0.571095] rzg3s-pcie-host 11e40000.pcie: PCI host bridge to bus 0000:00
> [    0.571161] pci_bus 0000:00: root bus resource [bus 00-ff]
> [    0.571198] pci_bus 0000:00: root bus resource [mem 0x30000000-0x37ffffff]
> [    0.571289] pci 0000:00:00.0: [1912:0033] type 01 class 0x060400 PCIe
> Root Port
> [    0.571355] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
> [    0.571393] pci 0000:00:00.0:   bridge window [mem 0xfff00000-0xffffffff]
> [    0.571433] pci 0000:00:00.0:   bridge window [mem 0x00000000-0x000fffff
> 64bit pref]
> [    0.571533] pci 0000:00:00.0: PME# supported from D0 D3hot
> [    0.574149] pci 0000:01:00.0: [1d79:2263] type 00 class 0x010802 PCIe
> Endpoint
> [    0.574223] pci_bus 0000:01: 2-byte config write to 0000:01:00.0 offset
> 0x4 may corrupt adjacent RW1C bits
> [    0.574775] pci 0000:01:00.0: BAR 0 [mem 0x00000000-0x00003fff 64bit]
> [    0.575722] pci 0000:01:00.0: 4.000 Gb/s available PCIe bandwidth,
> limited by 5.0 GT/s PCIe x1 link at 0000:00:00.0 (capable of 15.752 Gb/s
> with 8.0 GT/s PCIe x2 link)
> [    0.576434] pci 0000:00:00.0: bridge window [mem 0x30000000-0x300fffff]:
> assigned
> [    0.576491] pci 0000:01:00.0: BAR 0 [mem 0x30000000-0x30003fff 64bit]:
> assigned
> [    0.576618] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
> [    0.576654] pci 0000:00:00.0:   bridge window [mem 0x30000000-0x300fffff]
> [    0.576697] pci_bus 0000:00: resource 4 [mem 0x30000000-0x37ffffff]
> [    0.576730] pci_bus 0000:01: resource 1 [mem 0x30000000-0x300fffff]
> [    0.576800] of_irq_parse_raw:  /soc/pcie@11e40000:00000001
> [    0.576864] OF: of_irq_parse_raw: ipar=/soc/pcie@11e40000, size=1
> [    0.576904] OF:  -> addrsize=3
> [    0.576936] OF:  -> match=1 (imaplen=32)
> [    0.576962] OF:  -> intsize=1, addrsize=3
> [    0.576984] OF:  -> imaplen=31
> [    0.577009] OF: /soc/pcie@11e40000 interrupt-map entry to self
> [    0.577044] of_irq_parse_raw:  /soc/pcie@11e40000:00000002
> [    0.577089] OF: of_irq_parse_raw: ipar=/soc/pcie@11e40000, size=1
> [    0.577126] OF:  -> addrsize=3
> [    0.577153] OF:  -> match=0 (imaplen=32)
> [    0.577177] OF:  -> intsize=1, addrsize=3
> [    0.577198] OF:  -> imaplen=31
> [    0.577220] OF:  -> imaplen=27
> [    0.577238] OF:  -> match=1 (imaplen=23)
> [    0.577261] OF:  -> intsize=1, addrsize=3
> [    0.577282] OF:  -> imaplen=22
> [    0.577303] OF: /soc/pcie@11e40000 interrupt-map entry to self
> [    0.577337] of_irq_parse_raw:  /soc/pcie@11e40000:00000003
> [    0.577382] OF: of_irq_parse_raw: ipar=/soc/pcie@11e40000, size=1
> [    0.577419] OF:  -> addrsize=3
> [    0.577445] OF:  -> match=0 (imaplen=32)
> [    0.577469] OF:  -> intsize=1, addrsize=3
> [    0.577490] OF:  -> imaplen=31
> [    0.577511] OF:  -> imaplen=27
> [    0.577530] OF:  -> match=0 (imaplen=23)
> [    0.577553] OF:  -> intsize=1, addrsize=3
> [    0.577573] OF:  -> imaplen=22
> [    0.577595] OF:  -> imaplen=18
> [    0.577613] OF:  -> match=1 (imaplen=14)
> [    0.577637] OF:  -> intsize=1, addrsize=3
> [    0.577657] OF:  -> imaplen=13
> [    0.577678] OF: /soc/pcie@11e40000 interrupt-map entry to self
> [    0.577712] of_irq_parse_raw:  /soc/pcie@11e40000:00000004
> [    0.577758] OF: of_irq_parse_raw: ipar=/soc/pcie@11e40000, size=1
> [    0.577794] OF:  -> addrsize=3
> [    0.577820] OF:  -> match=0 (imaplen=32)
> [    0.577844] OF:  -> intsize=1, addrsize=3
> [    0.577865] OF:  -> imaplen=31
> [    0.577886] OF:  -> imaplen=27
> [    0.577905] OF:  -> match=0 (imaplen=23)
> [    0.577928] OF:  -> intsize=1, addrsize=3
> [    0.577948] OF:  -> imaplen=22
> [    0.577969] OF:  -> imaplen=18
> [    0.577987] OF:  -> match=0 (imaplen=14)
> [    0.578010] OF:  -> intsize=1, addrsize=3
> [    0.578031] OF:  -> imaplen=13
> [    0.578052] OF:  -> imaplen=9
> [    0.578070] OF:  -> match=1 (imaplen=5)
> [    0.578092] OF:  -> intsize=1, addrsize=3
> [    0.578113] OF:  -> imaplen=4
> [    0.578133] OF: /soc/pcie@11e40000 interrupt-map entry to self
> [    0.578609] pci_assign_irq(): pin=0
> [    0.578641] assign IRQ: got 0
> [    0.578677] pcieport 0000:00:00.0: enabling device (0000 -> 0002)
> [    0.579095] pci_assign_irq(): pin=1
> [    0.579124] pci_assign_irq(): swizzle_irq=806c2ad8, map_irq=806daa90
> [    0.579154] pci_common_swizzle(): pin=1
> [    0.579177] pci_assign_irq(): slot=0, pin=1
> [    0.579209] of_irq_parse_raw:  /soc/pcie@11e40000/pci@0,0:00000001
> [    0.579271] OF: of_irq_parse_raw: ipar=/soc/pcie@11e40000/pci@0,0, size=1
> [    0.579314] OF:  -> addrsize=3
> [    0.579339] OF:  -> match=1 (imaplen=32)
> [    0.579365] OF:  -> intsize=1, addrsize=3
> [    0.579386] OF:  -> imaplen=31
> [    0.579409] OF:  -> new parent: /soc/pcie@11e40000
> [    0.579452] OF:  -> match=0 (imaplen=32)
> [    0.579476] OF:  -> intsize=1, addrsize=3
> [    0.579497] OF:  -> imaplen=31
> [    0.579520] OF:  -> imaplen=27
> [    0.579538] OF:  -> match=0 (imaplen=23)
> [    0.579562] OF:  -> intsize=1, addrsize=3
> [    0.579583] OF:  -> imaplen=22
> [    0.579604] OF:  -> imaplen=18
> [    0.579622] OF:  -> match=0 (imaplen=14)
> [    0.579645] OF:  -> intsize=1, addrsize=3
> [    0.579666] OF:  -> imaplen=13
> [    0.579688] OF:  -> imaplen=9
> [    0.579706] OF:  -> match=0 (imaplen=5)
> [    0.579728] OF:  -> intsize=1, addrsize=3
> [    0.579749] OF:  -> imaplen=4
> [    0.579769] OF:  -> imaplen=0
> [    0.580473] nvme 0000:01:00.0: of_irq_parse_pci: failed with rc=-22
> [    0.580952] assign IRQ: got 0
> [    0.581718] nvme nvme0: pci function 0000:01:00.0
> [    0.581811] nvme 0000:01:00.0: enabling device (0000 -> 0002)
> [    0.585447] nvme nvme0: missing or invalid SUBNQN field.
> [    0.592193] nvme nvme0: 1/0/0 default/read/poll queues
> [    0.600035]  nvme0n1: p1
> 
> 
> I currently managed to fix it by applying the following diff on top of [1]:
> 
> diff --git a/arch/arm64/boot/dts/renesas/r9a08g045s33.dtsi
> b/arch/arm64/boot/dts/renesas/r9a08g045s33.dtsi
> index f1d642c70436..aac917f0b143 100644
> --- a/arch/arm64/boot/dts/renesas/r9a08g045s33.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r9a08g045s33.dtsi
> @@ -54,13 +54,6 @@ pcie: pcie@11e40000 {
>                                   "intb", "intc", "intd", "msi",
>                                   "link_bandwidth", "pm_pme", "dma",
>                                   "pcie_evt", "msg", "all";
> -               #interrupt-cells = <1>;
> -               interrupt-controller;
> -               interrupt-map-mask = <0 0 0 7>;
> -               interrupt-map = <0 0 0 1 &pcie 0 0 0 0>, /* INT A */
> -                               <0 0 0 2 &pcie 0 0 0 1>, /* INT B */
> -                               <0 0 0 3 &pcie 0 0 0 2>, /* INT C */
> -                               <0 0 0 4 &pcie 0 0 0 3>; /* INT D */
>                 device_type = "pci";
>                 num-lanes = <1>;
>                 #address-cells = <3>;
> @@ -70,5 +63,20 @@ pcie: pcie@11e40000 {
>                 device-id = <0x0033>;
>                 renesas,sysc = <&sysc>;
>                 status = "disabled";
> +
> +               port0: pci@0,0 {
> +                       device_type = "pci";
> +                       reg = <0x0 0x0 0x0 0x0 0x0>;
> +                       #address-cells = <3>;
> +                       #size-cells = <2>;
> +                       ranges;
> +                       #interrupt-cells = <1>;
> +                       interrupt-controller;
> +                       interrupt-map-mask = <0 0 0 7>;
> +                       interrupt-map = <0 0 0 1 &port0 0 0 0 0>, /* INT A */
> +                                       <0 0 0 2 &port0 0 0 0 1>, /* INT B */
> +                                       <0 0 0 3 &port0 0 0 0 2>, /* INT C */
> +                                       <0 0 0 4 &port0 0 0 0 3>; /* INT D */
> +               };
>         };
>  };
> diff --git a/drivers/pci/controller/pcie-rzg3s-host.c
> b/drivers/pci/controller/pcie-rzg3s-host.c
> index 39140183addf..affbf4f79f23 100644
> --- a/drivers/pci/controller/pcie-rzg3s-host.c
> +++ b/drivers/pci/controller/pcie-rzg3s-host.c
> @@ -431,7 +431,24 @@ static int rzg3s_pcie_root_write(struct pci_bus *bus,
> unsigned int devfn,
>         return PCIBIOS_SUCCESSFUL;
>  }
> 
> +static int rzg3s_pcie_intx_setup(struct rzg3s_pcie_host *host, struct
> device_node *port);
> +
> +static int rzg3s_pcie_root_add_bus(struct pci_bus *bus)
> +{
> +       struct device_node *of_port;
> +
> +       for_each_child_of_node(bus->dev.of_node, of_port) {
> +               int ret = rzg3s_pcie_intx_setup(bus->sysdata, of_port);
> +
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       return 0;
> +}
> +
>  static struct pci_ops rzg3s_pcie_root_ops = {
> +       .add_bus        = rzg3s_pcie_root_add_bus,
>         .read           = pci_generic_config_read,
>         .write          = rzg3s_pcie_root_write,
>         .map_bus        = rzg3s_pcie_root_map_bus,
> @@ -895,7 +912,7 @@ static void rzg3s_pcie_intx_teardown(void *data)
>         irq_domain_remove(host->intx_domain);
>  }
> 
> -static int rzg3s_pcie_intx_setup(struct rzg3s_pcie_host *host)
> +static int rzg3s_pcie_intx_setup(struct rzg3s_pcie_host *host, struct
> device_node *port)
>  {
>         struct device *dev = host->dev;
> 
> @@ -918,7 +935,7 @@ static int rzg3s_pcie_intx_setup(struct rzg3s_pcie_host
> *host)
>                                                  host);
>         }
> 
> -       host->intx_domain = irq_domain_add_linear(dev->of_node, PCI_NUM_INTX,
> +       host->intx_domain = irq_domain_add_linear(port, PCI_NUM_INTX,
>                                                   &rzg3s_pcie_intx_domain_ops,
>                                                   host);
>         if (!host->intx_domain)
> @@ -1542,7 +1559,7 @@ static int rzg3s_pcie_probe(struct platform_device *pdev)
> 
>         raw_spin_lock_init(&host->hw_lock);
> 
> -       ret = rzg3s_pcie_host_setup(host, rzg3s_pcie_intx_setup,
> +       ret = rzg3s_pcie_host_setup(host, NULL,
>                                     rzg3s_pcie_msi_enable, true);
>         if (ret)
>                 return ret;
> 
> 
> With this, of_irq_parse_pci() no longer fails with -22:
> 
> 
> [    0.564106] pci 0000:00:00.0: [1912:0033] type 01 class 0x060400 PCIe
> Root Port
> [    0.564173] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
> [    0.564212] pci 0000:00:00.0:   bridge window [mem 0xfff00000-0xffffffff]
> [    0.564252] pci 0000:00:00.0:   bridge window [mem 0x00000000-0x000fffff
> 64bit pref]
> [    0.564355] pci 0000:00:00.0: PME# supported from D0 D3hot
> [    0.564999] /soc/pcie@11e40000/pci@0,0: Fixed dependency cycle(s) with
> /soc/pcie@11e40000/pci@0,0
> [    0.567407] pci 0000:01:00.0: [1d79:2263] type 00 class 0x010802 PCIe
> Endpoint
> [    0.567483] pci_bus 0000:01: 2-byte config write to 0000:01:00.0 offset
> 0x4 may corrupt adjacent RW1C bits
> [    0.567922] pci 0000:01:00.0: BAR 0 [mem 0x00000000-0x00003fff 64bit]
> [    0.568870] pci 0000:01:00.0: 4.000 Gb/s available PCIe bandwidth,
> limited by 5.0 GT/s PCIe x1 link at 0000:00:00.0 (capable of 15.752 Gb/s
> with 8.0 GT/s PCIe x2 link)
> [    0.569599] pci 0000:00:00.0: bridge window [mem 0x30000000-0x300fffff]:
> assigned
> [    0.569657] pci 0000:01:00.0: BAR 0 [mem 0x30000000-0x30003fff 64bit]:
> assigned
> [    0.569785] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
> [    0.569822] pci 0000:00:00.0:   bridge window [mem 0x30000000-0x300fffff]
> [    0.570056] pci_bus 0000:00: resource 4 [mem 0x30000000-0x37ffffff]
> [    0.570095] pci_bus 0000:01: resource 1 [mem 0x30000000-0x300fffff]
> [    0.570311] pci_assign_irq(): pin=0
> [    0.570338] assign IRQ: got 0
> [    0.570373] pcieport 0000:00:00.0: enabling device (0000 -> 0002)
> [    0.570775] pci_assign_irq(): pin=1
> [    0.570805] pci_assign_irq(): swizzle_irq=806c2b70, map_irq=806dab28
> [    0.570834] pci_common_swizzle(): pin=1
> [    0.570855] pci_assign_irq(): slot=0, pin=1
> [    0.570888] of_irq_parse_raw:  /soc/pcie@11e40000/pci@0,0:00000001
> [    0.570954] OF: of_irq_parse_raw: ipar=/soc/pcie@11e40000/pci@0,0, size=1
> [    0.570997] OF:  -> addrsize=3
> [    0.571028] OF:  -> match=1 (imaplen=32)
> [    0.571053] OF:  -> intsize=1, addrsize=3
> [    0.571075] OF:  -> imaplen=31
> [    0.571095] OF: /soc/pcie@11e40000/pci@0,0 interrupt-map entry to self
> [    0.571270] assign IRQ: got 46
> [    0.571998] nvme nvme0: pci function 0000:01:00.0
> [    0.572082] nvme 0000:01:00.0: enabling device (0000 -> 0002)
> [    0.575619] nvme nvme0: missing or invalid SUBNQN field.
> [    0.584554] nvme nvme0: 1/0/0 default/read/poll queues
> [    0.592958]  nvme0n1: p1
> 
> 
> Could you please let me know if this is how the PCIe controller should now
> be described in DT with your patch?

In my series, no node should be created if a node is already existing.
  https://elixir.bootlin.com/linux/v6.15/source/drivers/pci/of.c#L764
  https://elixir.bootlin.com/linux/v6.15/source/drivers/pci/of.c#L771

The idea is to create the missing node which can be used as PCI device node
parent.

On my side, I have performed tests using an Armada 3720 board and so, I used
this DT:
  https://elixir.bootlin.com/linux/v6.15/source/arch/arm64/boot/dts/marvell/armada-3720-db.dts
and more precisely, this PCIe controller node description:
  https://elixir.bootlin.com/linux/v6.15/source/arch/arm64/boot/dts/marvell/armada-37xx.dtsi#L495

On this system, I didn't observed any issues but of course, the PCIe drivers are
different.
Also, on my system, no node were created by of_pci_make_host_bridge_node().

To be honest, I didn't re-test recently to see if something has been broken.
I can do that on my side with my system.

On your side, maybe you can have look at the Armada PCIe driver and see if
something could explain your behavior. I am not sure that you need to add the
pci@0,0 node in your DT.

Best regards,
Hervé

