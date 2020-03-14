Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A48418597F
	for <lists+linux-pci@lfdr.de>; Sun, 15 Mar 2020 03:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgCOC7o (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 14 Mar 2020 22:59:44 -0400
Received: from mail.rc.ru ([151.236.222.147]:48106 "EHLO mail.rc.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726553AbgCOC7o (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 14 Mar 2020 22:59:44 -0400
Received: from mail.rc.ru ([2a01:7e00:e000:1bf::1]:37146)
        by mail.rc.ru with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ink@jurassic.park.msu.ru>)
        id 1jDCl8-0003IR-VP; Sat, 14 Mar 2020 19:47:46 +0000
Date:   Sat, 14 Mar 2020 19:47:45 +0000
From:   Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To:     Matt Turner <mattst88@gmail.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Yinghai Lu <yinghai@kernel.org>, linux-pci@vger.kernel.org,
        linux-alpha <linux-alpha@vger.kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Jay Estabrook <jay.estabrook@gmail.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] alpha: fix nautilus PCI setup
Message-ID: <20200314194745.GB12510@mail.rc.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Example (hopefully reasonable) of the new "size_windows" flag usage.

Fixes accidental breakage caused by commit f75b99d5a77d (PCI: Enforce
bus address limits in resource allocation),

Signed-off-by: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
---
 arch/alpha/kernel/sys_nautilus.c | 51 ++++++++++++++++------------------------
 1 file changed, 20 insertions(+), 31 deletions(-)

diff --git a/arch/alpha/kernel/sys_nautilus.c b/arch/alpha/kernel/sys_nautilus.c
index cd9a112d67ff..1a1e49f58e66 100644
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
@@ -211,14 +207,17 @@ nautilus_init_pci(void)
 	struct pci_dev *irongate;
 	unsigned long bus_align, bus_size, pci_mem;
 	unsigned long memtop = max_low_pfn << PAGE_SHIFT;
-	int ret;
 
 	bridge = pci_alloc_host_bridge(0);
 	if (!bridge)
 		return;
 
+	/* Use default IO. */
 	pci_add_resource(&bridge->windows, &ioport_resource);
-	pci_add_resource(&bridge->windows, &iomem_resource);
+	/* Irongate PCI memory aperture, calculate requred size before
+	   setting it up. */
+	pci_add_resource(&bridge->windows, &irongate_mem);
+
 	pci_add_resource(&bridge->windows, &busn_resource);
 	bridge->dev.parent = NULL;
 	bridge->sysdata = hose;
@@ -226,59 +225,49 @@ nautilus_init_pci(void)
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
+	/* Now we've got the size and alignment of PCI memory resources
+	   stored in irongate_mem. Set up the PCI memory range: limit is
+	   hardwired to 0xffffffff, base must be aligned to 16Mb. */
+	bus_align = irongate_mem.start;
+	bus_size = irongate_mem.end + 1 - bus_align;
 	if (bus_align < 0x1000000UL)
 		bus_align = 0x1000000UL;
 
 	pci_mem = (0x100000000UL - bus_size) & -bus_align;
+	irongate_mem.start = pci_mem;
+	irongate_mem.end = 0xffffffffUL;
 
-	bus->resource[1]->start = pci_mem;
-	bus->resource[1]->end = 0xffffffffUL;
-	if (request_resource(&iomem_resource, bus->resource[1]) < 0)
+	/* Register our newly calculated PCI memory window in the resource
+	   tree. */
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
 
