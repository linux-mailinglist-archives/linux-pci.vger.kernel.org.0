Return-Path: <linux-pci+bounces-43438-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D94BCD1499
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 19:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F2CBF30133F2
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 18:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C1434D923;
	Fri, 19 Dec 2025 17:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cp587MHt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22EA34D902;
	Fri, 19 Dec 2025 17:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766166235; cv=none; b=eTF00UZcal8OzVS7qJx3lr/TvIUIwq5CaRDdO6XUoi7qPK0Rp2L7SW3viaxKoSM5XmaQHAN4wFyb5tNjiZOd1pOL3YaQjLu0d+bItG08kspMYe9ihBL0QUQXhxK1pLRZF5Y1a4/siPfIOZYUoOWljOZyxuVFpjcs1BWI5mk3Xrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766166235; c=relaxed/simple;
	bh=KYG4GDajgVVuI+uxlotc+TQZSUuGeQu22he7gV/rcB0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EH8haode5++BoNzJZWY/SbwJgV6+ga5JxHC5svu40N4fFmDuFyCHxgghAiwSRLCwRwq+FDFTbtcsE4HbDQ7OSe7p8/PNkjK+560I1Hddm1S8zRSvCTBVUG0Jfnu9wEE+M52lNC3BC9Me3DLXkrLVttyIPDMo8vzQLRQrV8J6JC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cp587MHt; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766166234; x=1797702234;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KYG4GDajgVVuI+uxlotc+TQZSUuGeQu22he7gV/rcB0=;
  b=cp587MHtX6wGvbLXa2UTWvuw/rw2vcuJ0QefqksR89i3LHn0Z5yuFScL
   B17UDKvbjk/c0O/qp0/meZTArhjYcbje0k/VSGtAxrIJ8VOC3y9v35t98
   xwZWrlbx1G5bZ85+FD9kqkLbeQmjXSz3z2WEHM5MC65Imk8TX9ZDdsVRZ
   LWkDAogQnzu4qJ6HKiiWNnX39Bc7jzuxM7C3izcANuAd0LEar+26fxjv6
   drfctqMj0gAx8nSVBzkJi2DZ6EvwF0noGa9WLJ1lxipHp/zvJX29YYQUi
   HyehnpgSluEnVqTO3tFqb1ZnCOCZVxa/ds/lS35NKo+vRTwYV0avPLm5L
   A==;
X-CSE-ConnectionGUID: GG6AFbHhSaCwOBTwl8XX+A==
X-CSE-MsgGUID: M+ux0yixQHqOT/RHb5n9QQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11647"; a="68174116"
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; 
   d="scan'208";a="68174116"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2025 09:43:54 -0800
X-CSE-ConnectionGUID: /bVBM2hHSBmND0G1aUHsIA==
X-CSE-MsgGUID: kAgnohgiSxqmWcqyiqMduQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; 
   d="scan'208";a="203072240"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.61])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2025 09:43:51 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 23/23] PCI: Move scanbus bridge scanning to setup-cardbus.c
Date: Fri, 19 Dec 2025 19:40:36 +0200
Message-Id: <20251219174036.16738-24-ilpo.jarvinen@linux.intel.com>
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

PCI core's pci_scan_bridge_extend() contains convoluted logic specific
to setting up bus numbers for legacy CardBus bridges. Extract the
CardBus specific part out into setup-cardbus.c to make the core code
cleaner and allow leaving CardBus bridge support out from modern
systems.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---

I'm somewhat skeptical that EA capability is relevant for CardBus
bridge but I've left it in place as I'm not 100% sure about it. ECN for
EA Capability is from 2014 which is quite late considering CardBus
timeline (PCMCIA ceased to exist in 2009). If it's not relevant,
dropping its support from CardBus side would allow small
simplifications to pci_cardbus_scan_bridge_extend().
---
 drivers/pci/pci.h           |  16 +++++
 drivers/pci/probe.c         |  73 +++++-----------------
 drivers/pci/setup-cardbus.c | 118 ++++++++++++++++++++++++++++++++++++
 3 files changed, 149 insertions(+), 58 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index b20ff7ef20ff..c586bf8a9da9 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -242,6 +242,7 @@ void pci_config_pm_runtime_put(struct pci_dev *dev);
 void pci_pm_power_up_and_verify_state(struct pci_dev *pci_dev);
 void pci_pm_init(struct pci_dev *dev);
 void pci_ea_init(struct pci_dev *dev);
+bool pci_ea_fixed_busnrs(struct pci_dev *dev, u8 *sec, u8 *sub);
 void pci_msi_init(struct pci_dev *dev);
 void pci_msix_init(struct pci_dev *dev);
 bool pci_bridge_d3_possible(struct pci_dev *dev);
@@ -377,10 +378,17 @@ extern unsigned long pci_hotplug_mmio_size;
 extern unsigned long pci_hotplug_mmio_pref_size;
 extern unsigned long pci_hotplug_bus_size;
 
+static inline bool pci_is_cardbus_bridge(struct pci_dev *dev)
+{
+	return dev->hdr_type == PCI_HEADER_TYPE_CARDBUS;
+}
 #ifdef CONFIG_CARDBUS
 unsigned long pci_cardbus_resource_alignment(struct resource *res);
 int pci_bus_size_cardbus_bridge(struct pci_bus *bus,
 				struct list_head *realloc_head);
+int pci_cardbus_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
+				   u32 buses, int max,
+				   unsigned int available_buses, int pass);
 int pci_setup_cardbus(char *str);
 
 #else
@@ -393,6 +401,14 @@ static inline int pci_bus_size_cardbus_bridge(struct pci_bus *bus,
 {
 	return -EOPNOTSUPP;
 }
+static inline int pci_cardbus_scan_bridge_extend(struct pci_bus *bus,
+						 struct pci_dev *dev,
+						 u32 buses, int max,
+						 unsigned int available_buses,
+						 int pass)
+{
+	return max;
+}
 static inline int pci_setup_cardbus(char *str) { return -ENOENT; }
 #endif /* CONFIG_CARDBUS */
 
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 49468644e730..89f0717efd48 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -25,9 +25,6 @@
 #include <linux/bitfield.h>
 #include "pci.h"
 
-#define CARDBUS_LATENCY_TIMER	176	/* secondary latency timer */
-#define CARDBUS_RESERVE_BUSNR	3
-
 static struct resource busn_resource = {
 	.name	= "PCI busn",
 	.start	= 0,
@@ -1345,7 +1342,7 @@ void pbus_validate_busn(struct pci_bus *bus)
  * and subordinate bus numbers, return true with the bus numbers in @sec
  * and @sub.  Otherwise return false.
  */
-static bool pci_ea_fixed_busnrs(struct pci_dev *dev, u8 *sec, u8 *sub)
+bool pci_ea_fixed_busnrs(struct pci_dev *dev, u8 *sec, u8 *sub)
 {
 	int ea, offset;
 	u32 dw;
@@ -1399,8 +1396,7 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 				  int pass)
 {
 	struct pci_bus *child;
-	int is_cardbus = (dev->hdr_type == PCI_HEADER_TYPE_CARDBUS);
-	u32 buses, i, j = 0;
+	u32 buses;
 	u16 bctl;
 	u8 primary, secondary, subordinate;
 	int broken = 0;
@@ -1444,8 +1440,15 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 	pci_write_config_word(dev, PCI_BRIDGE_CONTROL,
 			      bctl & ~PCI_BRIDGE_CTL_MASTER_ABORT);
 
-	if ((secondary || subordinate) && !pcibios_assign_all_busses() &&
-	    !is_cardbus && !broken) {
+	if (pci_is_cardbus_bridge(dev)) {
+		max = pci_cardbus_scan_bridge_extend(bus, dev, buses, max,
+						     available_buses,
+						     pass);
+		goto out;
+	}
+
+	if ((secondary || subordinate) &&
+	    !pcibios_assign_all_busses() && !broken) {
 		unsigned int cmax, buses;
 
 		/*
@@ -1487,7 +1490,7 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 		 * do in the second pass.
 		 */
 		if (!pass) {
-			if (pcibios_assign_all_busses() || broken || is_cardbus)
+			if (pcibios_assign_all_busses() || broken)
 
 				/*
 				 * Temporarily disable forwarding of the
@@ -1534,55 +1537,11 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 			FIELD_PREP(PCI_SECONDARY_BUS_MASK, child->busn_res.start) |
 			FIELD_PREP(PCI_SUBORDINATE_BUS_MASK, child->busn_res.end);
 
-		/*
-		 * yenta.c forces a secondary latency timer of 176.
-		 * Copy that behaviour here.
-		 */
-		if (is_cardbus) {
-			buses &= ~PCI_SEC_LATENCY_TIMER_MASK;
-			buses |= FIELD_PREP(PCI_SEC_LATENCY_TIMER_MASK,
-					    CARDBUS_LATENCY_TIMER);
-		}
-
 		/* We need to blast all three values with a single write */
 		pci_write_config_dword(dev, PCI_PRIMARY_BUS, buses);
 
-		if (!is_cardbus) {
-			child->bridge_ctl = bctl;
-			max = pci_scan_child_bus_extend(child, available_buses);
-		} else {
-
-			/*
-			 * For CardBus bridges, we leave 4 bus numbers as
-			 * cards with a PCI-to-PCI bridge can be inserted
-			 * later.
-			 */
-			for (i = 0; i < CARDBUS_RESERVE_BUSNR; i++) {
-				struct pci_bus *parent = bus;
-				if (pci_find_bus(pci_domain_nr(bus),
-							max+i+1))
-					break;
-				while (parent->parent) {
-					if ((!pcibios_assign_all_busses()) &&
-					    (parent->busn_res.end > max) &&
-					    (parent->busn_res.end <= max+i)) {
-						j = 1;
-					}
-					parent = parent->parent;
-				}
-				if (j) {
-
-					/*
-					 * Often, there are two CardBus
-					 * bridges -- try to leave one
-					 * valid bus number for each one.
-					 */
-					i /= 2;
-					break;
-				}
-			}
-			max += i;
-		}
+		child->bridge_ctl = bctl;
+		max = pci_scan_child_bus_extend(child, available_buses);
 
 		/*
 		 * Set subordinate bus number to its real value.
@@ -1594,9 +1553,7 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 		pci_bus_update_busn_res_end(child, max);
 		pci_write_config_byte(dev, PCI_SUBORDINATE_BUS, max);
 	}
-
-	scnprintf(child->name, sizeof(child->name),
-		  (is_cardbus ? "PCI CardBus %04x:%02x" : "PCI Bus %04x:%02x"),
+	scnprintf(child->name, sizeof(child->name), "PCI Bus %04x:%02x",
 		  pci_domain_nr(bus), child->number);
 
 	pbus_validate_busn(child);
diff --git a/drivers/pci/setup-cardbus.c b/drivers/pci/setup-cardbus.c
index 93a2b43c637b..1ebd13a1f730 100644
--- a/drivers/pci/setup-cardbus.c
+++ b/drivers/pci/setup-cardbus.c
@@ -3,14 +3,19 @@
  * Cardbus bridge setup routines.
  */
 
+#include <linux/bitfield.h>
 #include <linux/errno.h>
 #include <linux/ioport.h>
 #include <linux/pci.h>
 #include <linux/sizes.h>
+#include <linux/sprintf.h>
 #include <linux/types.h>
 
 #include "pci.h"
 
+#define CARDBUS_LATENCY_TIMER		176	/* secondary latency timer */
+#define CARDBUS_RESERVE_BUSNR		3
+
 #define DEFAULT_CARDBUS_IO_SIZE		SZ_256
 #define DEFAULT_CARDBUS_MEM_SIZE	SZ_64M
 /* pci=cbmemsize=nnM,cbiosize=nn can override this */
@@ -186,3 +191,116 @@ int pci_setup_cardbus(char *str)
 
 	return -ENOENT;
 }
+
+int pci_cardbus_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
+				   u32 buses, int max,
+				   unsigned int available_buses, int pass)
+{
+	struct pci_bus *child;
+	bool fixed_buses;
+	u8 fixed_sec, fixed_sub;
+	int next_busnr;
+	u32 i, j = 0;
+
+	/*
+	 * We need to assign a number to this bus which we always do in the
+	 * second pass.
+	 */
+	if (!pass) {
+		/*
+		 * Temporarily disable forwarding of the configuration
+		 * cycles on all bridges in this bus segment to avoid
+		 * possible conflicts in the second pass between two bridges
+		 * programmed with overlapping bus ranges.
+		 */
+		pci_write_config_dword(dev, PCI_PRIMARY_BUS,
+				       buses & PCI_SEC_LATENCY_TIMER_MASK);
+		return max;
+	}
+
+	/* Clear errors */
+	pci_write_config_word(dev, PCI_STATUS, 0xffff);
+
+	/* Read bus numbers from EA Capability (if present) */
+	fixed_buses = pci_ea_fixed_busnrs(dev, &fixed_sec, &fixed_sub);
+	if (fixed_buses)
+		next_busnr = fixed_sec;
+	else
+		next_busnr = max + 1;
+
+	/*
+	 * Prevent assigning a bus number that already exists. This can
+	 * happen when a bridge is hot-plugged, so in this case we only
+	 * re-scan this bus.
+	 */
+	child = pci_find_bus(pci_domain_nr(bus), next_busnr);
+	if (!child) {
+		child = pci_add_new_bus(bus, dev, next_busnr);
+		if (!child)
+			return max;
+		pci_bus_insert_busn_res(child, next_busnr, bus->busn_res.end);
+	}
+	max++;
+	if (available_buses)
+		available_buses--;
+
+	buses = (buses & PCI_SEC_LATENCY_TIMER_MASK) |
+		FIELD_PREP(PCI_PRIMARY_BUS_MASK, child->primary) |
+		FIELD_PREP(PCI_SECONDARY_BUS_MASK, child->busn_res.start) |
+		FIELD_PREP(PCI_SUBORDINATE_BUS_MASK, child->busn_res.end);
+
+	/*
+	 * yenta.c forces a secondary latency timer of 176.
+	 * Copy that behaviour here.
+	 */
+	buses &= ~PCI_SEC_LATENCY_TIMER_MASK;
+	buses |= FIELD_PREP(PCI_SEC_LATENCY_TIMER_MASK, CARDBUS_LATENCY_TIMER);
+
+	/* We need to blast all three values with a single write */
+	pci_write_config_dword(dev, PCI_PRIMARY_BUS, buses);
+
+	/*
+	 * For CardBus bridges, we leave 4 bus numbers as cards with a
+	 * PCI-to-PCI bridge can be inserted later.
+	 */
+	for (i = 0; i < CARDBUS_RESERVE_BUSNR; i++) {
+		struct pci_bus *parent = bus;
+
+		if (pci_find_bus(pci_domain_nr(bus), max + i + 1))
+			break;
+
+		while (parent->parent) {
+			if (!pcibios_assign_all_busses() &&
+			    (parent->busn_res.end > max) &&
+			    (parent->busn_res.end <= max + i)) {
+				j = 1;
+			}
+			parent = parent->parent;
+		}
+		if (j) {
+			/*
+			 * Often, there are two CardBus bridges -- try to
+			 * leave one valid bus number for each one.
+			 */
+			i /= 2;
+			break;
+		}
+	}
+	max += i;
+
+	/*
+	 * Set subordinate bus number to its real value. If fixed
+	 * subordinate bus number exists from EA capability then use it.
+	 */
+	if (fixed_buses)
+		max = fixed_sub;
+	pci_bus_update_busn_res_end(child, max);
+	pci_write_config_byte(dev, PCI_SUBORDINATE_BUS, max);
+
+	scnprintf(child->name, sizeof(child->name), "PCI CardBus %04x:%02x",
+		  pci_domain_nr(bus), child->number);
+
+	pbus_validate_busn(child);
+
+	return max;
+}
-- 
2.39.5


