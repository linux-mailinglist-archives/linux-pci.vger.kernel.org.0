Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF35318597D
	for <lists+linux-pci@lfdr.de>; Sun, 15 Mar 2020 03:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgCOC7n (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 14 Mar 2020 22:59:43 -0400
Received: from mail.rc.ru ([151.236.222.147]:48106 "EHLO mail.rc.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726553AbgCOC7m (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 14 Mar 2020 22:59:42 -0400
Received: from mail.rc.ru ([2a01:7e00:e000:1bf::1]:37132)
        by mail.rc.ru with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ink@jurassic.park.msu.ru>)
        id 1jDChR-0003HI-1U; Sat, 14 Mar 2020 19:43:57 +0000
Date:   Sat, 14 Mar 2020 19:43:55 +0000
From:   Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Matt Turner <mattst88@gmail.com>, Yinghai Lu <yinghai@kernel.org>,
        linux-pci@vger.kernel.org,
        linux-alpha <linux-alpha@vger.kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Jay Estabrook <jay.estabrook@gmail.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] PCI: add support for root bus sizing
Message-ID: <20200314194355.GA12510@mail.rc.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In certain cases we should be able to enumerate IO and MEM ranges
of all PCI devices installed in the system, and then set respective
host bridge apertures basing on calculated size and alignment.
Particularly when firmware is broken and fails to assign bridge
windows properly, like on Alpha UP1500 platform.

Actually, almost everything is already in place, and required
changes are minimal:

- add "size_windows" flag to struct pci_host_bridge: when set, it
  instructs __pci_bus_size_bridges() to continue with the root bus;
- in the __pci_bus_size_bridges() path: add checks for bus->self,
  as it can legitimately be null for the root bus.

Signed-off-by: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
---
 drivers/pci/setup-bus.c | 34 ++++++++++++++++++++++------------
 include/linux/pci.h     |  1 +
 2 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index f2461bf9243d..bbcef1a053ab 100644
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
+		hdr_type = -1;	/* Intentionally invalid - not a PCI device. */
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
