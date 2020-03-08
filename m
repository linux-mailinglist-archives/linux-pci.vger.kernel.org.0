Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0712717D470
	for <lists+linux-pci@lfdr.de>; Sun,  8 Mar 2020 16:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbgCHPaN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 8 Mar 2020 11:30:13 -0400
Received: from mail.rc.ru ([151.236.222.147]:43446 "EHLO mail.rc.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726259AbgCHPaN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 8 Mar 2020 11:30:13 -0400
Received: from mail.rc.ru ([2a01:7e00:e000:1bf::1]:60842)
        by mail.rc.ru with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ink@jurassic.park.msu.ru>)
        id 1jAxsT-0004l5-Sm; Sun, 08 Mar 2020 15:30:05 +0000
Date:   Sun, 8 Mar 2020 15:30:04 +0000
From:   Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Matt Turner <mattst88@gmail.com>, Yinghai Lu <yinghai@kernel.org>,
        linux-pci@vger.kernel.org,
        linux-alpha <linux-alpha@vger.kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Jay Estabrook <jay.estabrook@gmail.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Some Alphas broken by f75b99d5a77d (PCI: Enforce bus address
 limits in resource allocation)
Message-ID: <20200308153004.GA17675@mail.rc.ru>
References: <CAEdQ38EzZfUJA-8zg-DgczYTwkxqFL-AThxu0_fC2V-GkXGi2Q@mail.gmail.com>
 <20200302224732.GA175863@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200302224732.GA175863@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 02, 2020 at 04:47:32PM -0600, Bjorn Helgaas wrote:
> [+cc Nicholas, Ben, beginning of thread:
> https://lore.kernel.org/r/CAEdQ38GUhL0R4c7ZjEZv89TmqQ0cwhnvBawxuXonSb9On=+B6A@mail.gmail.com]
> 
> On Fri, Feb 28, 2020 at 03:51:01PM -0800, Matt Turner wrote:
> > On Sat, Feb 22, 2020 at 8:55 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > >
> > > On Mon, Apr 16, 2018 at 07:33:57AM -0700, Matt Turner wrote:
> > > > Commit f75b99d5a77d63f20e07bd276d5a427808ac8ef6 (PCI: Enforce bus
> > > > address limits in resource allocation) broke Alpha systems using
> > > > CONFIG_ALPHA_NAUTILUS. Alpha is 64-bit, but Nautilus systems use a
> > > > 32-bit AMD 751/761 chipset. arch/alpha/kernel/sys_nautilus.c maps PCI
> > > > into the upper addresses just below 4GB.
> > > >
> > > > I can get a working kernel by ifdef'ing out the code in
> > > > drivers/pci/bus.c:pci_bus_alloc_resource. We can't tie
> > > > PCI_BUS_ADDR_T_64BIT to ALPHA_NAUTILUS without breaking generic
> > > > kernels.
> > > >
> > > > How can we get Nautilus working again?
> > >
> > > I don't see a resolution in this thread, so I assume this is still
> > > broken?  Anybody have any more ideas?
> > 
> > Indeed, still broken.
> > 
> > I can add Kconfig logic to unselect ARCH_DMA_ADDR_T_64BIT if
> > ALPHA_NAUTILUS, but then generic kernels won't work on Nautilus. It
> > doesn't look like we have any way of opting out of
> > ARCH_DMA_ADDR_T_64BIT at runtime, and doing enough plumbing to make
> > that work is not worth it for such niche hardware. Maybe removing
> > Nautilus from the generic kernel build is what I should do until such
> > a time that we really fix this?
> > 
> > Or maybe I could put a hack in pci.c that more or less undoes
> > d56dbf5bab8c on Nautilus. #if defined CONFIG_ARCH_DMA_ADDR_T_64BIT &&
> > !defined SYS_NAUTILUS.
> > 
> > Or maybe I just need to take a weekend and try to understand the PCI
> > code, instead of applying patches I don't understand and praying :)
> 
> I don't have any *useful* ideas, but I think we did screw up the PCI
> resource discovery when we started assuming that we know the host
> bridge apertures up front.
> 
> That's generally true for many ACPI and DT systems, but in principle,
> we *should* be able to enumerate the devices and learn their resource
> requirements before computing the required host bridge apertures and
> assigning the BARs.

Wholeheartedly agree. In fact, changes to generic PCI code required
for proper root bus sizing are quite minimal now since we have
struct pci_host_bridge. It's mostly additional checks for bus->self
being NULL (as it normally is on the root bus) in the
__pci_bus_size_bridges() path, plus new bridge->size_windows flag.
See patch below (tested on UP1500). Note that on irongate we're
only interested in calculation of non-prefetchable PCI memory aperture,
but one can do the same for io and prefetchable memory as well.

Ivan.

diff --git a/arch/alpha/kernel/sys_nautilus.c b/arch/alpha/kernel/sys_nautilus.c
index cd9a112d67ff..84eaf7f54982 100644
--- a/arch/alpha/kernel/sys_nautilus.c
+++ b/arch/alpha/kernel/sys_nautilus.c
@@ -187,10 +187,6 @@ nautilus_machine_check(unsigned long vector, unsigned long la_ptr)
 
 extern void pcibios_claim_one_bus(struct pci_bus *);
 
-static struct resource irongate_io = {
-	.name	= "Irongate PCI IO",
-	.flags	= IORESOURCE_IO,
-};
 static struct resource irongate_mem = {
 	.name	= "Irongate PCI MEM",
 	.flags	= IORESOURCE_MEM,
@@ -211,14 +207,13 @@ nautilus_init_pci(void)
 	struct pci_dev *irongate;
 	unsigned long bus_align, bus_size, pci_mem;
 	unsigned long memtop = max_low_pfn << PAGE_SHIFT;
-	int ret;
 
 	bridge = pci_alloc_host_bridge(0);
 	if (!bridge)
 		return;
 
 	pci_add_resource(&bridge->windows, &ioport_resource);
-	pci_add_resource(&bridge->windows, &iomem_resource);
+	pci_add_resource(&bridge->windows, &irongate_mem);
 	pci_add_resource(&bridge->windows, &busn_resource);
 	bridge->dev.parent = NULL;
 	bridge->sysdata = hose;
@@ -226,59 +221,47 @@ nautilus_init_pci(void)
 	bridge->ops = alpha_mv.pci_ops;
 	bridge->swizzle_irq = alpha_mv.pci_swizzle;
 	bridge->map_irq = alpha_mv.pci_map_irq;
+	bridge->size_windows = 1;
 
 	/* Scan our single hose.  */
-	ret = pci_scan_root_bus_bridge(bridge);
-	if (ret) {
+	if (pci_scan_root_bus_bridge(bridge)) {
 		pci_free_host_bridge(bridge);
 		return;
 	}
-
 	bus = hose->bus = bridge->bus;
 	pcibios_claim_one_bus(bus);
 
-	irongate = pci_get_domain_bus_and_slot(pci_domain_nr(bus), 0, 0);
-	bus->self = irongate;
-	bus->resource[0] = &irongate_io;
-	bus->resource[1] = &irongate_mem;
-
 	pci_bus_size_bridges(bus);
 
-	/* IO port range. */
-	bus->resource[0]->start = 0;
-	bus->resource[0]->end = 0xffff;
-
-	/* Set up PCI memory range - limit is hardwired to 0xffffffff,
-	   base must be at aligned to 16Mb. */
-	bus_align = bus->resource[1]->start;
-	bus_size = bus->resource[1]->end + 1 - bus_align;
+	/* Now we have PCI memory resources size and alignment stored
+	   in irongate_mem. Set up PCI memory range - limit is hardwired
+	   to 0xffffffff, base must be aligned to 16Mb. */
+	bus_align = irongate_mem.start;
+	bus_size = irongate_mem.end + 1 - bus_align;
 	if (bus_align < 0x1000000UL)
 		bus_align = 0x1000000UL;
 
 	pci_mem = (0x100000000UL - bus_size) & -bus_align;
 
-	bus->resource[1]->start = pci_mem;
-	bus->resource[1]->end = 0xffffffffUL;
-	if (request_resource(&iomem_resource, bus->resource[1]) < 0)
+	irongate_mem.start = pci_mem;
+	irongate_mem.end = 0xffffffffUL;
+	if (request_resource(&iomem_resource, &irongate_mem) < 0)
 		printk(KERN_ERR "Failed to request MEM on hose 0\n");
 
+	printk(KERN_INFO "Irongate pci_mem %pR\n", &irongate_mem);
+
 	if (pci_mem < memtop)
 		memtop = pci_mem;
 	if (memtop > alpha_mv.min_mem_address) {
 		free_reserved_area(__va(alpha_mv.min_mem_address),
 				   __va(memtop), -1, NULL);
-		printk("nautilus_init_pci: %ldk freed\n",
+		printk(KERN_INFO "nautilus_init_pci: %ldk freed\n",
 			(memtop - alpha_mv.min_mem_address) >> 10);
 	}
-
 	if ((IRONGATE0->dev_vendor >> 16) > 0x7006)	/* Albacore? */
 		IRONGATE0->pci_mem = pci_mem;
 
 	pci_bus_assign_resources(bus);
-
-	/* pci_common_swizzle() relies on bus->self being NULL
-	   for the root bus, so just clear it. */
-	bus->self = NULL;
 	pci_bus_add_devices(bus);
 }
 
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index f2461bf9243d..aecc81338a1f 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -846,7 +846,7 @@ static resource_size_t window_alignment(struct pci_bus *bus, unsigned long type)
 		 * Per spec, I/O windows are 4K-aligned, but some bridges have
 		 * an extension to support 1K alignment.
 		 */
-		if (bus->self->io_window_1k)
+		if (bus->self && bus->self->io_window_1k)
 			align = PCI_P2P_DEFAULT_IO_ALIGN_1K;
 		else
 			align = PCI_P2P_DEFAULT_IO_ALIGN;
@@ -920,7 +920,7 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
 		calculate_iosize(size, min_size, size1, add_size, children_add_size,
 			resource_size(b_res), min_align);
 	if (!size0 && !size1) {
-		if (b_res->start || b_res->end)
+		if (bus->self && (b_res->start || b_res->end))
 			pci_info(bus->self, "disabling bridge window %pR to %pR (unused)\n",
 				 b_res, &bus->busn_res);
 		b_res->flags = 0;
@@ -930,7 +930,7 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
 	b_res->start = min_align;
 	b_res->end = b_res->start + size0 - 1;
 	b_res->flags |= IORESOURCE_STARTALIGN;
-	if (size1 > size0 && realloc_head) {
+	if (bus->self && size1 > size0 && realloc_head) {
 		add_to_list(realloc_head, bus->self, b_res, size1-size0,
 			    min_align);
 		pci_info(bus->self, "bridge window %pR to %pR add_size %llx\n",
@@ -1073,7 +1073,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 		calculate_memsize(size, min_size, add_size, children_add_size,
 				resource_size(b_res), add_align);
 	if (!size0 && !size1) {
-		if (b_res->start || b_res->end)
+		if (bus->self && (b_res->start || b_res->end))
 			pci_info(bus->self, "disabling bridge window %pR to %pR (unused)\n",
 				 b_res, &bus->busn_res);
 		b_res->flags = 0;
@@ -1082,7 +1082,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 	b_res->start = min_align;
 	b_res->end = size0 + min_align - 1;
 	b_res->flags |= IORESOURCE_STARTALIGN;
-	if (size1 > size0 && realloc_head) {
+	if (bus->self && size1 > size0 && realloc_head) {
 		add_to_list(realloc_head, bus->self, b_res, size1-size0, add_align);
 		pci_info(bus->self, "bridge window %pR to %pR add_size %llx add_align %llx\n",
 			   b_res, &bus->busn_res,
@@ -1196,8 +1196,9 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 	unsigned long mask, prefmask, type2 = 0, type3 = 0;
 	resource_size_t additional_io_size = 0, additional_mmio_size = 0,
 			additional_mmio_pref_size = 0;
-	struct resource *b_res;
-	int ret;
+	struct resource *pref;
+	struct pci_host_bridge *host;
+	int hdr_type, i, ret;
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		struct pci_bus *b = dev->subordinate;
@@ -1217,10 +1218,20 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 	}
 
 	/* The root bus? */
-	if (pci_is_root_bus(bus))
-		return;
+	if (pci_is_root_bus(bus)) {
+		host = to_pci_host_bridge(bus->bridge);
+		if (!host->size_windows)
+			return;
+		pci_bus_for_each_resource(bus, pref, i)
+			if (pref && (pref->flags & IORESOURCE_PREFETCH))
+				break;
+		hdr_type = -1;
+	} else {
+		pref = &bus->self->resource[PCI_BRIDGE_RESOURCES + 2];
+		hdr_type = bus->self->hdr_type;
+	}
 
-	switch (bus->self->hdr_type) {
+	switch (hdr_type) {
 	case PCI_HEADER_TYPE_CARDBUS:
 		/* Don't size CardBuses yet */
 		break;
@@ -1242,10 +1253,9 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 		 * the size required to put all 64-bit prefetchable
 		 * resources in it.
 		 */
-		b_res = &bus->self->resource[PCI_BRIDGE_RESOURCES];
 		mask = IORESOURCE_MEM;
 		prefmask = IORESOURCE_MEM | IORESOURCE_PREFETCH;
-		if (b_res[2].flags & IORESOURCE_MEM_64) {
+		if (pref && (pref->flags & IORESOURCE_MEM_64)) {
 			prefmask |= IORESOURCE_MEM_64;
 			ret = pbus_size_mem(bus, prefmask, prefmask,
 				prefmask, prefmask,
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 3840a541a9de..681c79b4dc85 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -511,6 +511,7 @@ struct pci_host_bridge {
 	unsigned int	native_pme:1;		/* OS may use PCIe PME */
 	unsigned int	native_ltr:1;		/* OS may use PCIe LTR */
 	unsigned int	preserve_config:1;	/* Preserve FW resource setup */
+	unsigned int	size_windows:1;		/* Enable root bus sizing */
 
 	/* Resource alignment requirements */
 	resource_size_t (*align_resource)(struct pci_dev *dev,
