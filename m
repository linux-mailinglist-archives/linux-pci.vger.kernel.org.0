Return-Path: <linux-pci+bounces-43432-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A51CD140F
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 18:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6669311CF63
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 17:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBB53446CA;
	Fri, 19 Dec 2025 17:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LtFVLHOa"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4BB3451D7;
	Fri, 19 Dec 2025 17:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766166191; cv=none; b=dM9iZZUjVvQlB0y4sDA2lHmkFYzjDtlp+x0UGnVQpEbMvZVJzOtp1GoyXCrgx6sx7EdBFDaPK0G7aR2+u19JcKrU/BA/LayBK2CBdZZQYhsMwkhmOGYBXm7qItNaF76AijL/idRDVm8+8iU/uK0EvU49NATpTgnwG0mHd+7owDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766166191; c=relaxed/simple;
	bh=H6OQWVV87CBIJeZv7kfhLfUCFDKypjO+2hdHgiOfUDY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LEVC3jSsIm0HmdGdztg+KbKNt8B8q/lMZACWpH+G6KkxaItiOpBIRUEftSKo99dZDovHuyHDriqWugyFkltUM1rq9P0aVnxCothNdFWuP5gbub/prgBEhXQa8ftYyZ9Sa7YhS5r+8nzK1O7a9eQ8eosLbUstZ5Pn8NBZXd0dmvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LtFVLHOa; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766166189; x=1797702189;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=H6OQWVV87CBIJeZv7kfhLfUCFDKypjO+2hdHgiOfUDY=;
  b=LtFVLHOaEmD9DT/FTg0wJAtb0Qj/M1wkS8gr3ysYWk/9n3LBOMjIMDLJ
   4na1WUm4fBkO6G1cCWSXDmQ4pQ/tCPLsd0zngHfaZ3WSjyugWe5EUZvdD
   5OoVTkN/2eMuOyHkt2e8kiPuVBgRQq8aZ0qCLH+/WgCnvEXk3a7L+cAdc
   ps++I253oGEQdGILv3hPXucLEf1zXzZdqTESpuokHIfOc/Lf8oMk4DMX5
   gj0cOmlklg73TELYWeIfDMfDxpZ/BSOpAVYN1IkemSzroOq2ueLVVHfoA
   BhS8QJPDv9FSgMKWbjX9ZKU6/bLO23xGpwSZDINPzih7SPJylc1jLRM23
   g==;
X-CSE-ConnectionGUID: /WCWz3PcRcelF66ZrJMpzw==
X-CSE-MsgGUID: KGE1r/jSRxeZXgsqVqaJeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11647"; a="67880709"
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; 
   d="scan'208";a="67880709"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2025 09:43:07 -0800
X-CSE-ConnectionGUID: eruT82EtR+WEsyWrb6aoMA==
X-CSE-MsgGUID: EYlxlf+wQfCgePlp+0hrCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; 
   d="scan'208";a="198497122"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.61])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2025 09:43:03 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 17/23] PCI: Separate cardbus setup & build it only with CONFIG_CARDBUS
Date: Fri, 19 Dec 2025 19:40:30 +0200
Message-Id: <20251219174036.16738-18-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251219174036.16738-1-ilpo.jarvinen@linux.intel.com>
References: <20251219174036.16738-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

PCI bridge window setup code includes special code to handle CardBus
bridges. CardBus has long since fallen out of favor and modern systems
have no use for it.

Move CardBus setup code into own file and use existing CONFIG_CARDBUS
for deciding whether it should be built or not.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/Makefile          |   1 +
 drivers/pci/pci.h             |  23 ++++-
 drivers/pci/setup-bus.c       | 171 ++--------------------------------
 drivers/pci/setup-cardbus.c   | 167 +++++++++++++++++++++++++++++++++
 drivers/pcmcia/yenta_socket.c |   2 +-
 include/linux/pci.h           |   6 +-
 6 files changed, 202 insertions(+), 168 deletions(-)
 create mode 100644 drivers/pci/setup-cardbus.c

diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index e10cfe5a280b..8922f90afecb 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -39,6 +39,7 @@ obj-$(CONFIG_PCI_TSM)		+= tsm.o
 obj-$(CONFIG_PCI_DYNAMIC_OF_NODES) += of_property.o
 obj-$(CONFIG_PCI_NPEM)		+= npem.o
 obj-$(CONFIG_PCIE_TPH)		+= tph.o
+obj-$(CONFIG_CARDBUS)		+= setup-cardbus.o
 
 # Endpoint library must be initialized before its users
 obj-$(CONFIG_PCI_ENDPOINT)	+= endpoint/
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index c27144af550f..2340e9df05c2 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -379,6 +379,23 @@ extern unsigned long pci_hotplug_bus_size;
 extern unsigned long pci_cardbus_io_size;
 extern unsigned long pci_cardbus_mem_size;
 
+#ifdef CONFIG_CARDBUS
+unsigned long pci_cardbus_resource_alignment(struct resource *res);
+int pci_bus_size_cardbus_bridge(struct pci_bus *bus,
+				struct list_head *realloc_head);
+
+#else
+static inline unsigned long pci_cardbus_resource_alignment(struct resource *res)
+{
+	return 0;
+}
+static inline int pci_bus_size_cardbus_bridge(struct pci_bus *bus,
+					      struct list_head *realloc_head)
+{
+	return -EOPNOTSUPP;
+}
+#endif /* CONFIG_CARDBUS */
+
 /**
  * pci_match_one_device - Tell if a PCI device structure has a matching
  *			  PCI device id structure
@@ -440,6 +457,10 @@ void __pci_size_stdbars(struct pci_dev *dev, int count,
 int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
 		    struct resource *res, unsigned int reg, u32 *sizes);
 void pci_configure_ari(struct pci_dev *dev);
+
+int pci_dev_res_add_to_list(struct list_head *head, struct pci_dev *dev,
+			    struct resource *res, resource_size_t add_size,
+			    resource_size_t min_align);
 void __pci_bus_size_bridges(struct pci_bus *bus,
 			struct list_head *realloc_head);
 void __pci_bus_assign_resources(const struct pci_bus *bus,
@@ -929,8 +950,6 @@ static inline void pci_suspend_ptm(struct pci_dev *dev) { }
 static inline void pci_resume_ptm(struct pci_dev *dev) { }
 #endif
 
-unsigned long pci_cardbus_resource_alignment(struct resource *);
-
 static inline resource_size_t pci_resource_alignment(struct pci_dev *dev,
 						     struct resource *res)
 {
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 3cc26fede31a..e680f75a5b5e 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -67,10 +67,9 @@ static void pci_dev_res_free_list(struct list_head *head)
  * @add_size:	Additional size to be optionally added to the resource
  * @min_align:	Minimum memory window alignment
  */
-static int pci_dev_res_add_to_list(struct list_head *head, struct pci_dev *dev,
-				  struct resource *res,
-				  resource_size_t add_size,
-				  resource_size_t min_align)
+int pci_dev_res_add_to_list(struct list_head *head, struct pci_dev *dev,
+			    struct resource *res, resource_size_t add_size,
+			    resource_size_t min_align)
 {
 	struct pci_dev_resource *tmp;
 
@@ -773,61 +772,6 @@ static void pbus_assign_resources_sorted(const struct pci_bus *bus,
 	__assign_resources_sorted(&head, realloc_head, fail_head);
 }
 
-void pci_setup_cardbus(struct pci_bus *bus)
-{
-	struct pci_dev *bridge = bus->self;
-	struct resource *res;
-	struct pci_bus_region region;
-
-	pci_info(bridge, "CardBus bridge to %pR\n",
-		 &bus->busn_res);
-
-	res = bus->resource[0];
-	pcibios_resource_to_bus(bridge->bus, &region, res);
-	if (resource_assigned(res) && res->flags & IORESOURCE_IO) {
-		/*
-		 * The IO resource is allocated a range twice as large as it
-		 * would normally need.  This allows us to set both IO regs.
-		 */
-		pci_info(bridge, "  bridge window %pR\n", res);
-		pci_write_config_dword(bridge, PCI_CB_IO_BASE_0,
-					region.start);
-		pci_write_config_dword(bridge, PCI_CB_IO_LIMIT_0,
-					region.end);
-	}
-
-	res = bus->resource[1];
-	pcibios_resource_to_bus(bridge->bus, &region, res);
-	if (resource_assigned(res) && res->flags & IORESOURCE_IO) {
-		pci_info(bridge, "  bridge window %pR\n", res);
-		pci_write_config_dword(bridge, PCI_CB_IO_BASE_1,
-					region.start);
-		pci_write_config_dword(bridge, PCI_CB_IO_LIMIT_1,
-					region.end);
-	}
-
-	res = bus->resource[2];
-	pcibios_resource_to_bus(bridge->bus, &region, res);
-	if (resource_assigned(res) && res->flags & IORESOURCE_MEM) {
-		pci_info(bridge, "  bridge window %pR\n", res);
-		pci_write_config_dword(bridge, PCI_CB_MEMORY_BASE_0,
-					region.start);
-		pci_write_config_dword(bridge, PCI_CB_MEMORY_LIMIT_0,
-					region.end);
-	}
-
-	res = bus->resource[3];
-	pcibios_resource_to_bus(bridge->bus, &region, res);
-	if (resource_assigned(res) && res->flags & IORESOURCE_MEM) {
-		pci_info(bridge, "  bridge window %pR\n", res);
-		pci_write_config_dword(bridge, PCI_CB_MEMORY_BASE_1,
-					region.start);
-		pci_write_config_dword(bridge, PCI_CB_MEMORY_LIMIT_1,
-					region.end);
-	}
-}
-EXPORT_SYMBOL(pci_setup_cardbus);
-
 /*
  * Initialize bridges with base/limit values we have collected.  PCI-to-PCI
  * Bridge Architecture Specification rev. 1.1 (1998) requires that if there
@@ -1424,108 +1368,6 @@ static void pbus_size_mem(struct pci_bus *bus, struct resource *b_res,
 	}
 }
 
-unsigned long pci_cardbus_resource_alignment(struct resource *res)
-{
-	if (res->flags & IORESOURCE_IO)
-		return pci_cardbus_io_size;
-	if (res->flags & IORESOURCE_MEM)
-		return pci_cardbus_mem_size;
-	return 0;
-}
-
-static void pci_bus_size_cardbus(struct pci_bus *bus,
-				 struct list_head *realloc_head)
-{
-	struct pci_dev *bridge = bus->self;
-	struct resource *b_res;
-	resource_size_t b_res_3_size = pci_cardbus_mem_size * 2;
-	u16 ctrl;
-
-	b_res = &bridge->resource[PCI_CB_BRIDGE_IO_0_WINDOW];
-	if (resource_assigned(b_res))
-		goto handle_b_res_1;
-	/*
-	 * Reserve some resources for CardBus.  We reserve a fixed amount
-	 * of bus space for CardBus bridges.
-	 */
-	resource_set_range(b_res, pci_cardbus_io_size, pci_cardbus_io_size);
-	b_res->flags |= IORESOURCE_IO | IORESOURCE_STARTALIGN;
-	if (realloc_head) {
-		b_res->end -= pci_cardbus_io_size;
-		pci_dev_res_add_to_list(realloc_head, bridge, b_res,
-					pci_cardbus_io_size,
-					pci_cardbus_io_size);
-	}
-
-handle_b_res_1:
-	b_res = &bridge->resource[PCI_CB_BRIDGE_IO_1_WINDOW];
-	if (resource_assigned(b_res))
-		goto handle_b_res_2;
-	resource_set_range(b_res, pci_cardbus_io_size, pci_cardbus_io_size);
-	b_res->flags |= IORESOURCE_IO | IORESOURCE_STARTALIGN;
-	if (realloc_head) {
-		b_res->end -= pci_cardbus_io_size;
-		pci_dev_res_add_to_list(realloc_head, bridge, b_res,
-					pci_cardbus_io_size,
-					pci_cardbus_io_size);
-	}
-
-handle_b_res_2:
-	/* MEM1 must not be pref MMIO */
-	pci_read_config_word(bridge, PCI_CB_BRIDGE_CONTROL, &ctrl);
-	if (ctrl & PCI_CB_BRIDGE_CTL_PREFETCH_MEM1) {
-		ctrl &= ~PCI_CB_BRIDGE_CTL_PREFETCH_MEM1;
-		pci_write_config_word(bridge, PCI_CB_BRIDGE_CONTROL, ctrl);
-		pci_read_config_word(bridge, PCI_CB_BRIDGE_CONTROL, &ctrl);
-	}
-
-	/* Check whether prefetchable memory is supported by this bridge. */
-	pci_read_config_word(bridge, PCI_CB_BRIDGE_CONTROL, &ctrl);
-	if (!(ctrl & PCI_CB_BRIDGE_CTL_PREFETCH_MEM0)) {
-		ctrl |= PCI_CB_BRIDGE_CTL_PREFETCH_MEM0;
-		pci_write_config_word(bridge, PCI_CB_BRIDGE_CONTROL, ctrl);
-		pci_read_config_word(bridge, PCI_CB_BRIDGE_CONTROL, &ctrl);
-	}
-
-	b_res = &bridge->resource[PCI_CB_BRIDGE_MEM_0_WINDOW];
-	if (resource_assigned(b_res))
-		goto handle_b_res_3;
-	/*
-	 * If we have prefetchable memory support, allocate two regions.
-	 * Otherwise, allocate one region of twice the size.
-	 */
-	if (ctrl & PCI_CB_BRIDGE_CTL_PREFETCH_MEM0) {
-		resource_set_range(b_res, pci_cardbus_mem_size,
-				   pci_cardbus_mem_size);
-		b_res->flags |= IORESOURCE_MEM | IORESOURCE_PREFETCH |
-				    IORESOURCE_STARTALIGN;
-		if (realloc_head) {
-			b_res->end -= pci_cardbus_mem_size;
-			pci_dev_res_add_to_list(realloc_head, bridge, b_res,
-						pci_cardbus_mem_size,
-						pci_cardbus_mem_size);
-		}
-
-		/* Reduce that to half */
-		b_res_3_size = pci_cardbus_mem_size;
-	}
-
-handle_b_res_3:
-	b_res = &bridge->resource[PCI_CB_BRIDGE_MEM_1_WINDOW];
-	if (resource_assigned(b_res))
-		goto handle_done;
-	resource_set_range(b_res, pci_cardbus_mem_size, b_res_3_size);
-	b_res->flags |= IORESOURCE_MEM | IORESOURCE_STARTALIGN;
-	if (realloc_head) {
-		b_res->end -= b_res_3_size;
-		pci_dev_res_add_to_list(realloc_head, bridge, b_res,
-					b_res_3_size, pci_cardbus_mem_size);
-	}
-
-handle_done:
-	;
-}
-
 void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 {
 	struct pci_dev *dev;
@@ -1542,7 +1384,8 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 
 		switch (dev->hdr_type) {
 		case PCI_HEADER_TYPE_CARDBUS:
-			pci_bus_size_cardbus(b, realloc_head);
+			if (pci_bus_size_cardbus_bridge(b, realloc_head))
+				continue;
 			break;
 
 		case PCI_HEADER_TYPE_BRIDGE:
@@ -1666,7 +1509,7 @@ void __pci_bus_assign_resources(const struct pci_bus *bus,
 			break;
 
 		case PCI_HEADER_TYPE_CARDBUS:
-			pci_setup_cardbus(b);
+			pci_setup_cardbus_bridge(b);
 			break;
 
 		default:
@@ -1771,7 +1614,7 @@ static void __pci_bridge_assign_resources(const struct pci_dev *bridge,
 		break;
 
 	case PCI_CLASS_BRIDGE_CARDBUS:
-		pci_setup_cardbus(b);
+		pci_setup_cardbus_bridge(b);
 		break;
 
 	default:
diff --git a/drivers/pci/setup-cardbus.c b/drivers/pci/setup-cardbus.c
new file mode 100644
index 000000000000..b017a2039fe1
--- /dev/null
+++ b/drivers/pci/setup-cardbus.c
@@ -0,0 +1,167 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Cardbus bridge setup routines.
+ */
+
+#include <linux/ioport.h>
+#include <linux/pci.h>
+#include <linux/types.h>
+
+#include "pci.h"
+
+unsigned long pci_cardbus_resource_alignment(struct resource *res)
+{
+	if (res->flags & IORESOURCE_IO)
+		return pci_cardbus_io_size;
+	if (res->flags & IORESOURCE_MEM)
+		return pci_cardbus_mem_size;
+	return 0;
+}
+
+int pci_bus_size_cardbus_bridge(struct pci_bus *bus,
+				struct list_head *realloc_head)
+{
+	struct pci_dev *bridge = bus->self;
+	struct resource *b_res;
+	resource_size_t b_res_3_size = pci_cardbus_mem_size * 2;
+	u16 ctrl;
+
+	b_res = &bridge->resource[PCI_CB_BRIDGE_IO_0_WINDOW];
+	if (resource_assigned(b_res))
+		goto handle_b_res_1;
+	/*
+	 * Reserve some resources for CardBus.  We reserve a fixed amount
+	 * of bus space for CardBus bridges.
+	 */
+	resource_set_range(b_res, pci_cardbus_io_size, pci_cardbus_io_size);
+	b_res->flags |= IORESOURCE_IO | IORESOURCE_STARTALIGN;
+	if (realloc_head) {
+		b_res->end -= pci_cardbus_io_size;
+		pci_dev_res_add_to_list(realloc_head, bridge, b_res,
+					pci_cardbus_io_size,
+					pci_cardbus_io_size);
+	}
+
+handle_b_res_1:
+	b_res = &bridge->resource[PCI_CB_BRIDGE_IO_1_WINDOW];
+	if (resource_assigned(b_res))
+		goto handle_b_res_2;
+	resource_set_range(b_res, pci_cardbus_io_size, pci_cardbus_io_size);
+	b_res->flags |= IORESOURCE_IO | IORESOURCE_STARTALIGN;
+	if (realloc_head) {
+		b_res->end -= pci_cardbus_io_size;
+		pci_dev_res_add_to_list(realloc_head, bridge, b_res,
+					pci_cardbus_io_size,
+					pci_cardbus_io_size);
+	}
+
+handle_b_res_2:
+	/* MEM1 must not be pref MMIO */
+	pci_read_config_word(bridge, PCI_CB_BRIDGE_CONTROL, &ctrl);
+	if (ctrl & PCI_CB_BRIDGE_CTL_PREFETCH_MEM1) {
+		ctrl &= ~PCI_CB_BRIDGE_CTL_PREFETCH_MEM1;
+		pci_write_config_word(bridge, PCI_CB_BRIDGE_CONTROL, ctrl);
+		pci_read_config_word(bridge, PCI_CB_BRIDGE_CONTROL, &ctrl);
+	}
+
+	/* Check whether prefetchable memory is supported by this bridge. */
+	pci_read_config_word(bridge, PCI_CB_BRIDGE_CONTROL, &ctrl);
+	if (!(ctrl & PCI_CB_BRIDGE_CTL_PREFETCH_MEM0)) {
+		ctrl |= PCI_CB_BRIDGE_CTL_PREFETCH_MEM0;
+		pci_write_config_word(bridge, PCI_CB_BRIDGE_CONTROL, ctrl);
+		pci_read_config_word(bridge, PCI_CB_BRIDGE_CONTROL, &ctrl);
+	}
+
+	b_res = &bridge->resource[PCI_CB_BRIDGE_MEM_0_WINDOW];
+	if (resource_assigned(b_res))
+		goto handle_b_res_3;
+	/*
+	 * If we have prefetchable memory support, allocate two regions.
+	 * Otherwise, allocate one region of twice the size.
+	 */
+	if (ctrl & PCI_CB_BRIDGE_CTL_PREFETCH_MEM0) {
+		resource_set_range(b_res, pci_cardbus_mem_size,
+				   pci_cardbus_mem_size);
+		b_res->flags |= IORESOURCE_MEM | IORESOURCE_PREFETCH |
+				    IORESOURCE_STARTALIGN;
+		if (realloc_head) {
+			b_res->end -= pci_cardbus_mem_size;
+			pci_dev_res_add_to_list(realloc_head, bridge, b_res,
+						pci_cardbus_mem_size,
+						pci_cardbus_mem_size);
+		}
+
+		/* Reduce that to half */
+		b_res_3_size = pci_cardbus_mem_size;
+	}
+
+handle_b_res_3:
+	b_res = &bridge->resource[PCI_CB_BRIDGE_MEM_1_WINDOW];
+	if (resource_assigned(b_res))
+		goto handle_done;
+	resource_set_range(b_res, pci_cardbus_mem_size, b_res_3_size);
+	b_res->flags |= IORESOURCE_MEM | IORESOURCE_STARTALIGN;
+	if (realloc_head) {
+		b_res->end -= b_res_3_size;
+		pci_dev_res_add_to_list(realloc_head, bridge, b_res,
+					b_res_3_size, pci_cardbus_mem_size);
+	}
+
+handle_done:
+	return 0;
+}
+
+void pci_setup_cardbus_bridge(struct pci_bus *bus)
+{
+	struct pci_dev *bridge = bus->self;
+	struct resource *res;
+	struct pci_bus_region region;
+
+	pci_info(bridge, "CardBus bridge to %pR\n",
+		 &bus->busn_res);
+
+	res = bus->resource[0];
+	pcibios_resource_to_bus(bridge->bus, &region, res);
+	if (resource_assigned(res) && res->flags & IORESOURCE_IO) {
+		/*
+		 * The IO resource is allocated a range twice as large as it
+		 * would normally need.  This allows us to set both IO regs.
+		 */
+		pci_info(bridge, "  bridge window %pR\n", res);
+		pci_write_config_dword(bridge, PCI_CB_IO_BASE_0,
+					region.start);
+		pci_write_config_dword(bridge, PCI_CB_IO_LIMIT_0,
+					region.end);
+	}
+
+	res = bus->resource[1];
+	pcibios_resource_to_bus(bridge->bus, &region, res);
+	if (resource_assigned(res) && res->flags & IORESOURCE_IO) {
+		pci_info(bridge, "  bridge window %pR\n", res);
+		pci_write_config_dword(bridge, PCI_CB_IO_BASE_1,
+					region.start);
+		pci_write_config_dword(bridge, PCI_CB_IO_LIMIT_1,
+					region.end);
+	}
+
+	res = bus->resource[2];
+	pcibios_resource_to_bus(bridge->bus, &region, res);
+	if (resource_assigned(res) && res->flags & IORESOURCE_MEM) {
+		pci_info(bridge, "  bridge window %pR\n", res);
+		pci_write_config_dword(bridge, PCI_CB_MEMORY_BASE_0,
+					region.start);
+		pci_write_config_dword(bridge, PCI_CB_MEMORY_LIMIT_0,
+					region.end);
+	}
+
+	res = bus->resource[3];
+	pcibios_resource_to_bus(bridge->bus, &region, res);
+	if (resource_assigned(res) && res->flags & IORESOURCE_MEM) {
+		pci_info(bridge, "  bridge window %pR\n", res);
+		pci_write_config_dword(bridge, PCI_CB_MEMORY_BASE_1,
+					region.start);
+		pci_write_config_dword(bridge, PCI_CB_MEMORY_LIMIT_1,
+					region.end);
+	}
+}
+EXPORT_SYMBOL(pci_setup_cardbus_bridge);
diff --git a/drivers/pcmcia/yenta_socket.c b/drivers/pcmcia/yenta_socket.c
index 923ed23570a0..34c4eaee7dfc 100644
--- a/drivers/pcmcia/yenta_socket.c
+++ b/drivers/pcmcia/yenta_socket.c
@@ -779,7 +779,7 @@ static void yenta_allocate_resources(struct yenta_socket *socket)
 			   IORESOURCE_MEM,
 			   PCI_CB_MEMORY_BASE_1, PCI_CB_MEMORY_LIMIT_1);
 	if (program)
-		pci_setup_cardbus(socket->dev->subordinate);
+		pci_setup_cardbus_bridge(socket->dev->subordinate);
 }
 
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 864775651c6f..ddec80c92816 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1243,7 +1243,11 @@ void pci_stop_and_remove_bus_device(struct pci_dev *dev);
 void pci_stop_and_remove_bus_device_locked(struct pci_dev *dev);
 void pci_stop_root_bus(struct pci_bus *bus);
 void pci_remove_root_bus(struct pci_bus *bus);
-void pci_setup_cardbus(struct pci_bus *bus);
+#ifdef CONFIG_CARDBUS
+void pci_setup_cardbus_bridge(struct pci_bus *bus);
+#else
+static inline void pci_setup_cardbus_bridge(struct pci_bus *bus) { }
+#endif
 void pcibios_setup_bridge(struct pci_bus *bus, unsigned long type);
 void pci_sort_breadthfirst(void);
 #define dev_is_pci(d) ((d)->bus == &pci_bus_type)
-- 
2.39.5


