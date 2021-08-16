Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3A63ED78F
	for <lists+linux-pci@lfdr.de>; Mon, 16 Aug 2021 15:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbhHPNh3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Aug 2021 09:37:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:57306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239623AbhHPNhA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 16 Aug 2021 09:37:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1E00761501;
        Mon, 16 Aug 2021 13:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629120988;
        bh=a5shUjI/BmY0Nsth8vN2YcfkWmIig3D/NmaGTSu/CYs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VsNvR9UCOxlIjPEY9KiC9g8zCTRutLNJ6bRQ6m2CoTTebV7LKGP1I1seko21bgkBX
         bhIQmsQyPLemVLSk0Ktn9BWPbIIxKlcQ/RArNS2f5TloajKQltySUQjbpdHTeslfnZ
         Sd4iFEyMc95tJU2w3frDK9fiqEbn95OhmPRTuxP95lV8gMnxL1hsu/2X7J5bsZzQPx
         f4FialulehLYnjcfkZHVtqgTDNQ6MuSz199S86kFa3nBNIbo8+62CcPUhhakcOoxMV
         AlkWVMeqar/QFJQZ6pXzYrPJpVfvk4uKwWEQjuf7ojOlcx57pofURLvofgixJmhKzT
         WT2whKdf3stfg==
Date:   Mon, 16 Aug 2021 15:36:24 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     PCI <linux-pci@vger.kernel.org>, Marc Zyngier <maz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH] PCI: of: Fix MSI domain lookup with child bus nodes
Message-ID: <20210816153624.74910775@coco.lan>
In-Reply-To: <20210816104252.045a7b75@coco.lan>
References: <20210813160257.3570515-1-robh@kernel.org>
        <20210813191938.6a8a4ee4@coco.lan>
        <CAL_JsqL+aPRh9CJ0iKbzGCyE3wDR6QMEKAEC8p=1ZVRDSb6JDA@mail.gmail.com>
        <20210816104252.045a7b75@coco.lan>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Em Mon, 16 Aug 2021 10:42:52 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:

> Em Sat, 14 Aug 2021 12:32:56 -0500
> Rob Herring <robh@kernel.org> escreveu:
> 
> > On Fri, Aug 13, 2021 at 12:19 PM Mauro Carvalho Chehab
> > <mchehab+huawei@kernel.org> wrote:  
> > >
> > > Em Fri, 13 Aug 2021 11:02:57 -0500
> > > Rob Herring <robh@kernel.org> escreveu:
> > >    
> > > > When a DT contains PCI child bus nodes, lookup of the MSI domain on PCI
> > > > buses fails resulting in the following warnings:
> > > >
> > > > WARNING: CPU: 4 PID: 7 at include/linux/msi.h:256 __pci_enable_msi_range+0x398/0x59c
> > > >
> > > > The issue is that pci_host_bridge_of_msi_domain() will check the DT node of
> > > > the passed in bus even if it's not the host bridge's bus. Based on the
> > > > name of the function, that's clearly not what we want. Fix this by
> > > > walking the bus parents to the root bus.
> > > >
> > > > Reported-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > > > Cc: Marc Zyngier <maz@kernel.org>
> > > > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > > ---
> > > > Compile tested only. Mauro, Can you see if this fixes your issue.
> > > >
> > > >  drivers/pci/of.c | 4 ++++
> > > >  1 file changed, 4 insertions(+)
> > > >
> > > > diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> > > > index a143b02b2dcd..ea70aede054c 100644
> > > > --- a/drivers/pci/of.c
> > > > +++ b/drivers/pci/of.c
> > > > @@ -84,6 +84,10 @@ struct irq_domain *pci_host_bridge_of_msi_domain(struct pci_bus *bus)
> > > >       if (!bus->dev.of_node)
> > > >               return NULL;
> > > >
> > > > +     /* Find the host bridge bus */
> > > > +     while (!pci_is_root_bus(bus))
> > > > +             bus = bus->parent;
> > > > +
> > > >       /* Start looking for a phandle to an MSI controller. */
> > > >       d = of_msi_get_domain(&bus->dev, bus->dev.of_node, DOMAIN_BUS_PCI_MSI);
> > > >       if (d)    
> > >
> > > Nope, it didn't solve the issue.    
> > 
> > Can you try adding some prints of the domain, pci dev, and DT node to
> > pci_set_bus_msi_domain(). Comparing those when having child nodes or
> > not would be helpful.  
> 
> Debug patch enclosed.
> 
> This is what happens when msi-parent is at /soc/pcie@f4000000/pcie@0,0:
> 
> [    4.305247] pci_bus 0000:01: pci_set_bus_msi_domain: of_node /soc/pcie@f4000000/pcie@0,0: IRQ domain: ffff000104a2f6c0
> [    4.442212] pci_bus 0000:02: pci_set_bus_msi_domain: of_node /soc/pcie@f4000000/pcie@0,0/pcie@0,0: IRQ domain: ffff000104a2f6c0
> [    4.688145] pci_bus 0000:03: pci_set_bus_msi_domain: of_node /soc/pcie@f4000000/pcie@0,0/pcie@0,0/pcie@1,0: IRQ domain: ffff000104a2f6c0
> [    4.800613] pci_bus 0000:04: pci_set_bus_msi_domain: of_node (null): IRQ domain: ffff000104a2f6c0
> [    4.856254] pci_bus 0000:05: pci_set_bus_msi_domain: of_node /soc/pcie@f4000000/pcie@0,0/pcie@0,0/pcie@5,0: IRQ domain: ffff000104a2f6c0
> [    4.922117] pci_bus 0000:06: pci_set_bus_msi_domain: of_node /soc/pcie@f4000000/pcie@0,0/pcie@0,0/pcie@7,0: IRQ domain: ffff000104a2f6c0
> [    5.032708] pci_bus 0000:07: pci_set_bus_msi_domain: of_node (null): IRQ domain: ffff000104a2f6c0
> 
> And this is what happens when msi-parent is at /soc/pcie@f4000000
> (either with or without your patch applied):
> 
> [    4.120328] pci_bus 0000:01: pci_set_bus_msi_domain: of_node /soc/pcie@f4000000/pcie@0,0: IRQ domain: 0000000000000000
> [    4.214541] pci_bus 0000:02: pci_set_bus_msi_domain: of_node /soc/pcie@f4000000/pcie@0,0/pcie@0,0: IRQ domain: 0000000000000000
> [    4.226054] pci_bus 0000:01: pci_set_bus_msi_domain: of_node /soc/pcie@f4000000/pcie@0,0: IRQ domain: 0000000000000000
> [    4.478858] pci_bus 0000:03: pci_set_bus_msi_domain: of_node /soc/pcie@f4000000/pcie@0,0/pcie@0,0/pcie@1,0: IRQ domain: 0000000000000000
> [    4.491218] pci_bus 0000:02: pci_set_bus_msi_domain: of_node /soc/pcie@f4000000/pcie@0,0/pcie@0,0: IRQ domain: 0000000000000000
> [    4.502793] pci_bus 0000:01: pci_set_bus_msi_domain: of_node /soc/pcie@f4000000/pcie@0,0: IRQ domain: 0000000000000000
> [    4.588196] pci_bus 0000:04: pci_set_bus_msi_domain: of_node (null): IRQ domain: 0000000000000000
> [    4.597161] pci_bus 0000:02: pci_set_bus_msi_domain: of_node /soc/pcie@f4000000/pcie@0,0/pcie@0,0: IRQ domain: 0000000000000000
> [    4.608747] pci_bus 0000:01: pci_set_bus_msi_domain: of_node /soc/pcie@f4000000/pcie@0,0: IRQ domain: 0000000000000000
> [    4.658892] pci_bus 0000:05: pci_set_bus_msi_domain: of_node /soc/pcie@f4000000/pcie@0,0/pcie@0,0/pcie@5,0: IRQ domain: 0000000000000000
> [    4.671241] pci_bus 0000:02: pci_set_bus_msi_domain: of_node /soc/pcie@f4000000/pcie@0,0/pcie@0,0: IRQ domain: 0000000000000000
> [    4.682869] pci_bus 0000:01: pci_set_bus_msi_domain: of_node /soc/pcie@f4000000/pcie@0,0: IRQ domain: 0000000000000000
> [    4.732938] pci_bus 0000:06: pci_set_bus_msi_domain: of_node /soc/pcie@f4000000/pcie@0,0/pcie@0,0/pcie@7,0: IRQ domain: 0000000000000000
> [    4.745305] pci_bus 0000:02: pci_set_bus_msi_domain: of_node /soc/pcie@f4000000/pcie@0,0/pcie@0,0: IRQ domain: 0000000000000000
> [    4.756880] pci_bus 0000:01: pci_set_bus_msi_domain: of_node /soc/pcie@f4000000/pcie@0,0: IRQ domain: 0000000000000000
> [    4.850363] pci_bus 0000:07: pci_set_bus_msi_domain: of_node (null): IRQ domain: 0000000000000000
> [    4.859322] pci_bus 0000:02: pci_set_bus_msi_domain: of_node /soc/pcie@f4000000/pcie@0,0/pcie@0,0: IRQ domain: 0000000000000000
> [    4.870895] pci_bus 0000:01: pci_set_bus_msi_domain: of_node /soc/pcie@f4000000/pcie@0,0: IRQ domain: 0000000000000000
> 
> Btw, despite lspci works on both cases, the Ethernet adapter stops
> working when msi-parent is at /soc/pcie@f4000000. I didn't notice it
> before, as (up to last week) I was using WiFi to connect to this board.
> 
> Thanks,
> Mauro
> 
> [PATCH] PCI: probe: Add a debug printk at pci_set_bus_msi_domain
> 
> That helps to discover problems when trying to get the MSI IRQ
> domain.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index c5dfc1afb1d3..f73bd81922b3 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -866,6 +866,8 @@ static void pci_set_bus_msi_domain(struct pci_bus *bus)
>         for (b = bus, d = NULL; !d && !pci_is_root_bus(b); b = b->parent) {
>                 if (b->self)
>                         d = dev_get_msi_domain(&b->self->dev);
> +               dev_dbg(&b->dev, "%s: of_node %pOF: IRQ domain: %px\n",
> +                       __func__, b->dev.of_node, d);
>         }
>  
>         if (!d)
> 

I added a lot of other debug stuff (see attached).

When msi-parent is at:

	pcie@f4000000 {
		msi-parent = <&its_pcie>;
	};

It produces:

	 (null): pci_set_bus_of_node: of_node: /soc/pcie@f4000000
	 (null): pci_host_bridge_of_msi_domain: of_node /soc/pcie@f4000000
	irq: irq_find_matching_fwspec: of_node: /soc/interrupt-controller@f5100000: 0000000000000000
	 (null): of_msi_get_domain: (1) of_node /soc/pcie@f4000000 domain: 0000000000000000
	 (null): pci_host_bridge_of_msi_domain: of_msi_get_domain(): of_node /soc/pcie@f4000000 domain: 0000000000000000
	irq: irq_find_matching_fwspec: of_node: /soc/pcie@f4000000: 0000000000000000
	 (null): pci_host_bridge_of_msi_domain: irq_find_matching_host(): of_node /soc/pcie@f4000000 domain: 0000000000000000
	irq: irq_find_matching_fwspec: of_node: /soc/pcie@f4000000: 0000000000000000
	irq: irq_find_matching_fwspec: of_node: /soc/pcie@f4000000: 0000000000000000

When msi-parent is at:

	pcie@f4000000 {
		pcie@0,0 {
			msi-parent = <&its_pcie>;
		};
	};

It produces:
	 (null): pci_set_bus_of_node: of_node: /soc/pcie@f4000000
	 (null): pci_host_bridge_of_msi_domain: of_node /soc/pcie@f4000000
	 (null): pci_host_bridge_of_msi_domain: of_msi_get_domain(): of_node /soc/pcie@f4000000 domain: 0000000000000000
	irq: irq_find_matching_fwspec: of_node: /soc/pcie@f4000000: ffff000107e57600
	 (null): pci_host_bridge_of_msi_domain: irq_find_matching_host(): of_node /soc/pcie@f4000000 domain: ffff000107e57600

I'm starting to suspect that the problem is somewhere inside the 
OF-specific code which handles MSI IRQs (drivers/of/irq.c?), but I didn't
find yet the root cause.

Thanks,
Mauro

---

Debug patch:

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 352e14b007e7..1b710513ecb3 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -623,10 +623,16 @@ u32 of_msi_map_id(struct device *dev, struct device_node *msi_np, u32 id_in)
 struct irq_domain *of_msi_map_get_device_domain(struct device *dev, u32 id,
 						u32 bus_token)
 {
+	struct irq_domain *d;
 	struct device_node *np = NULL;
 
 	__of_msi_map_id(dev, &np, id);
-	return irq_find_matching_host(np, bus_token);
+	d = irq_find_matching_host(np, bus_token);
+
+	dev_info(dev, "%s: of_node %pOF domain: %px\n",
+		__func__, np, d);
+
+	return d;
 }
 
 /**
@@ -649,8 +655,13 @@ struct irq_domain *of_msi_get_domain(struct device *dev,
 
 	/* Check for a single msi-parent property */
 	msi_np = of_parse_phandle(np, "msi-parent", 0);
+	dev_info(dev, "%s: msi parent: %pOF, token %i\n",
+		__func__, msi_np, token);
 	if (msi_np && !of_property_read_bool(msi_np, "#msi-cells")) {
 		d = irq_find_matching_host(msi_np, token);
+		dev_info(dev, "%s: (1) of_node %pOF domain: %px\n",
+			__func__, np, d);
+
 		if (!d)
 			of_node_put(msi_np);
 		return d;
@@ -665,6 +676,8 @@ struct irq_domain *of_msi_get_domain(struct device *dev,
 						   "#msi-cells",
 						   index, &args)) {
 			d = irq_find_matching_host(args.np, token);
+			dev_info(dev, "%s: (2) of_node %pOF domain: %px\n",
+				__func__, np, d);
 			if (d)
 				return d;
 
diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 9232255c8515..19fbe50a6f82 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1552,6 +1552,8 @@ struct irq_domain *pci_msi_get_device_domain(struct pci_dev *pdev)
 	if (!dom)
 		dom = iort_get_device_domain(&pdev->dev, rid,
 					     DOMAIN_BUS_PCI_MSI);
+	dev_dbg(&pdev->dev, "%s: of_node %pOF domain: %px\n",
+		__func__, pdev->dev.of_node, dom);
 	return dom;
 }
 
diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index f5fc9e29a725..33b9b06ebb5d 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -20,7 +20,7 @@ void pci_set_of_node(struct pci_dev *dev)
 {
 	if (!dev->bus->dev.of_node) {
 		dev_dbg(&dev->dev, "%s: BUS of_node is null\n",
-			__func__, dev->bus->dev.of_node);
+			__func__);
 		return;
 	}
 	dev->dev.of_node = of_pci_find_child_device(dev->bus->dev.of_node,
@@ -88,11 +88,22 @@ struct irq_domain *pci_host_bridge_of_msi_domain(struct pci_bus *bus)
 #ifdef CONFIG_IRQ_DOMAIN
 	struct irq_domain *d;
 
+dev_dbg(&bus->dev, "%s: of_node %pOF\n", __func__, bus->dev.of_node);
 	if (!bus->dev.of_node)
 		return NULL;
 
+	/* Find the host bridge bus */
+//	while (bus->bridge->parent) {
+	while (!pci_is_root_bus(bus)) {
+		dev_dbg(&bus->dev, "%s: of_node %pOF is not the root bus\n",
+			__func__, bus->dev.of_node);
+		bus = bus->parent;
+	}
+
 	/* Start looking for a phandle to an MSI controller. */
 	d = of_msi_get_domain(&bus->dev, bus->dev.of_node, DOMAIN_BUS_PCI_MSI);
+	dev_dbg(&bus->dev, "%s: of_msi_get_domain(): of_node %pOF domain: %px\n",
+		__func__, bus->dev.of_node, d);
 	if (d)
 		return d;
 
@@ -101,6 +112,8 @@ struct irq_domain *pci_host_bridge_of_msi_domain(struct pci_bus *bus)
 	 * directly attached to the host bridge.
 	 */
 	d = irq_find_matching_host(bus->dev.of_node, DOMAIN_BUS_PCI_MSI);
+	dev_dbg(&bus->dev, "%s: irq_find_matching_host(): of_node %pOF domain: %px\n",
+		__func__, bus->dev.of_node, d);
 	if (d)
 		return d;
 
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index c5dfc1afb1d3..3488ed6c9624 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -866,6 +866,8 @@ static void pci_set_bus_msi_domain(struct pci_bus *bus)
 	for (b = bus, d = NULL; !d && !pci_is_root_bus(b); b = b->parent) {
 		if (b->self)
 			d = dev_get_msi_domain(&b->self->dev);
+		dev_dbg(&b->dev, "%s: of_node %pOF: IRQ domain: %px\n",
+			__func__, b->dev.of_node, d);
 	}
 
 	if (!d)
@@ -2447,17 +2449,18 @@ static struct irq_domain *pci_dev_msi_domain(struct pci_dev *dev)
 	 */
 	d = dev_get_msi_domain(&dev->dev);
 	if (d)
-		return d;
+		goto ret;
 
 	/*
 	 * Let's see if we have a firmware interface able to provide
 	 * the domain.
 	 */
 	d = pci_msi_get_device_domain(dev);
-	if (d)
-		return d;
+ret:
+	dev_dbg(&dev->dev, "%s: of_node %pOF domain: %px\n",
+		__func__, dev->dev.of_node, d);
 
-	return NULL;
+	return d;
 }
 
 static void pci_set_msi_domain(struct pci_dev *dev)

