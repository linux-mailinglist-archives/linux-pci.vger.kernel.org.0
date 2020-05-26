Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACE921BAC73
	for <lists+linux-pci@lfdr.de>; Mon, 27 Apr 2020 20:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgD0SYW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Apr 2020 14:24:22 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:53026 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726333AbgD0SYW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Apr 2020 14:24:22 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 7A5684C858;
        Mon, 27 Apr 2020 18:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1588011855; x=1589826256; bh=e8+l1MvQUEJLu312asRTfpPgIBMQxwK5dUl
        /IC0tTAw=; b=J+mpFJU6SPzEjAndkF1iPypkorTHJuZog6E+KjHMV2UnmzF2UYk
        zWNT3CvtklETxOdvsjHmIOnFTDak+1/2DvwZfFtHRUjL9DCkA/c/Ft5/kB0T2uIb
        vdwr7z8hahufGqtrfue9BEvSlokfqfh04pGq024qRMu0fJFP56+MnkEY=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id snfvhifay7gW; Mon, 27 Apr 2020 21:24:15 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id B03DE4C83F;
        Mon, 27 Apr 2020 21:24:11 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.136) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Mon, 27
 Apr 2020 21:24:11 +0300
From:   Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Stefan Roese <sr@denx.de>, Andy Lavr <andy.lavr@gmail.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        David Laight <David.Laight@ACULAB.COM>,
        Rajat Jain <rajatja@google.com>, <linux@yadro.com>,
        Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH v8 07/24] PCI: hotplug: Don't allow hot-added devices to steal resources
Date:   Mon, 27 Apr 2020 21:23:41 +0300
Message-ID: <20200427182358.2067702-8-s.miroshnichenko@yadro.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200427182358.2067702-1-s.miroshnichenko@yadro.com>
References: <20200427182358.2067702-1-s.miroshnichenko@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.17.15.136]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When movable BARs are enabled, the PCI subsystem at first releases all the
bridge windows and then attempts to assign resources both to previously
working devices and to the newly hot-added ones, with the same priority.

If a hot-added device gets its BARs first, this may lead to lack of space
for already working devices, which is unacceptable. If that happens, mark
one of the new devices with the newly introduced flag PCI_DEV_DISABLED_BARS
(if it is not yet marked) and retry the BAR recalculation.

The worst case would be no BARs for hot-added devices, while all the rest
just continue working.

The algorithm is simple and it doesn't retry different subsets of hot-added
devices in case of a failure, e.g. if there are no space to allocate BARs
for both hot-added devices A and B, but is enough for just A, the A will be
marked with PCI_DEV_DISABLED_BARS first, then (after the next failure) - B.
As a result, A will not get BARs while it could. This issue is only
relevant when hot-adding two and more devices simultaneously.

Add a new res_mask bitmask to the struct pci_dev for storing the indices of
assigned BARs.

When preparing to the next rescan, all PCI_DEV_DISABLED_BARS marks are
unset, so the kernel can retry to assign them.

Before a rescan, some working devices may have assigned only part of their
BARs - for example, if BIOS didn't allocate them. With this patch, the
kernel assigns BARs in three steps:
  - first try every BAR, even those that weren't assigned before;
  - if that fails, retry without those failed BARs;
  - if that fails, retry without one of hotplugged devices.

Signed-off-by: Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
---
 drivers/pci/pci.h       |   3 +
 drivers/pci/probe.c     | 177 +++++++++++++++++++++++++++++++++++++++-
 drivers/pci/setup-bus.c |   6 +-
 drivers/pci/setup-res.c |   2 +
 include/linux/pci.h     |   1 +
 5 files changed, 186 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index c7d3c022bf35..7483a5716317 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -294,6 +294,8 @@ struct pci_bus *pci_bus_get(struct pci_bus *bus);
 void pci_bus_put(struct pci_bus *bus);
 
 bool pci_dev_bar_fixed(struct pci_dev *dev, struct resource *res);
+bool pci_dev_bar_enabled(const struct pci_dev *dev, int idx);
+bool pci_bus_check_bars_assigned(struct pci_bus *bus, bool complete_set);
 
 /* PCIe link information from Link Capabilities 2 */
 #define PCIE_LNKCAP2_SLS2SPEED(lnkcap2) \
@@ -412,6 +414,7 @@ static inline bool pci_dev_is_disconnected(const struct pci_dev *dev)
 
 /* pci_dev priv_flags */
 #define PCI_DEV_ADDED 0
+#define PCI_DEV_DISABLED_BARS 1
 
 static inline void pci_dev_assign_added(struct pci_dev *dev, bool added)
 {
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 5baad5325b16..5ca6e5887326 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -35,6 +35,13 @@ static struct resource busn_resource = {
 LIST_HEAD(pci_root_buses);
 EXPORT_SYMBOL(pci_root_buses);
 
+/*
+ * This flag is used during pci_rescan_bus(), protected by pci_rescan_remove_lock:
+ * it indicates which BARs should be reassigned: every one, or only those which
+ * were assigned before the rescan.
+ */
+static bool pci_try_failed_bars = true;
+
 static LIST_HEAD(pci_domain_busn_res_list);
 
 struct pci_domain_busn_res {
@@ -43,6 +50,41 @@ struct pci_domain_busn_res {
 	int domain_nr;
 };
 
+static void pci_dev_disable_bars(struct pci_dev *dev)
+{
+	assign_bit(PCI_DEV_DISABLED_BARS, &dev->priv_flags, true);
+}
+
+static void pci_dev_enable_bars(struct pci_dev *dev)
+{
+	assign_bit(PCI_DEV_DISABLED_BARS, &dev->priv_flags, false);
+}
+
+static bool pci_dev_bars_enabled(const struct pci_dev *dev)
+{
+	if (pci_try_failed_bars)
+		return true;
+
+	return !(test_bit(PCI_DEV_DISABLED_BARS, &dev->priv_flags));
+}
+
+bool pci_dev_bar_enabled(const struct pci_dev *dev, int idx)
+{
+	if (idx >= PCI_BRIDGE_RESOURCES)
+		return true;
+
+	if (pci_try_failed_bars)
+		return true;
+
+	if (test_bit(PCI_DEV_DISABLED_BARS, &dev->priv_flags))
+		return false;
+
+	if (!pci_dev_is_added(dev))
+		return true;
+
+	return dev->res_mask & (1 << idx);
+}
+
 static struct resource *get_pci_domain_busn_res(int domain_nr)
 {
 	struct pci_domain_busn_res *r;
@@ -3204,6 +3246,24 @@ bool pci_dev_bar_fixed(struct pci_dev *dev, struct resource *res)
 	return true;
 }
 
+static unsigned int pci_dev_count_res_mask(struct pci_dev *dev)
+{
+	unsigned int res_mask = 0;
+	int i;
+
+	for (i = 0; i < PCI_BRIDGE_RESOURCES; i++) {
+		struct resource *r = &dev->resource[i];
+
+		if (!r->flags || !r->parent ||
+		    (r->flags & IORESOURCE_UNSET))
+			continue;
+
+		res_mask |= (1 << i);
+	}
+
+	return res_mask;
+}
+
 static void pci_bus_rescan_prepare(struct pci_bus *bus)
 {
 	struct pci_dev *dev;
@@ -3216,6 +3276,9 @@ static void pci_bus_rescan_prepare(struct pci_bus *bus)
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		struct pci_bus *child = dev->subordinate;
 
+		dev->res_mask = pci_dev_count_res_mask(dev);
+		pci_dev_enable_bars(dev);
+
 		if (child)
 			pci_bus_rescan_prepare(child);
 
@@ -3269,6 +3332,118 @@ static void pci_setup_bridges(struct pci_bus *bus)
 		pci_setup_bridge(bus);
 }
 
+static struct pci_dev *pci_find_next_new_device(struct pci_bus *bus)
+{
+	struct pci_dev *dev;
+
+	if (!bus)
+		return NULL;
+
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		struct pci_bus *child_bus = dev->subordinate;
+
+		if (child_bus) {
+			struct pci_dev *next_new_dev;
+
+			next_new_dev = pci_find_next_new_device(child_bus);
+			if (next_new_dev)
+				return next_new_dev;
+		}
+
+		if (!pci_dev_is_added(dev) && pci_dev_bars_enabled(dev))
+			return dev;
+	}
+
+	return NULL;
+}
+
+/**
+ * pci_bus_check_bars_assigned - check BARs under the bridge
+ * @bus: Parent PCI bus
+ * @complete_set: check every BAR, otherwise only those assigned before
+ *
+ * Returns true if every BAR is assigned.
+ */
+bool pci_bus_check_bars_assigned(struct pci_bus *bus, bool complete_set)
+{
+	struct pci_dev *dev;
+	bool good = true;
+
+	if (!bus)
+		return false;
+
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		struct pci_bus *child = dev->subordinate;
+
+		if (complete_set) {
+			int i;
+
+			for (i = 0; i < PCI_BRIDGE_RESOURCES; ++i) {
+				struct resource *r = &dev->resource[i];
+
+				if (!(r->flags & IORESOURCE_UNSET))
+					continue;
+
+				pci_warn(dev, "BAR %d: requested but not assigned: %pR\n",
+					 i, r);
+				good = false;
+			}
+		} else {
+			unsigned int res_mask;
+
+			if (!pci_dev_bars_enabled(dev))
+				continue;
+
+			res_mask = pci_dev_count_res_mask(dev);
+
+			if (dev->res_mask & ~res_mask) {
+				pci_err(dev, "Non-re-enabled resources found: 0x%x -> 0x%x\n",
+					dev->res_mask, res_mask);
+				good = false;
+			}
+		}
+
+		if (child && !pci_bus_check_bars_assigned(child, complete_set))
+			good = false;
+	}
+
+	return good;
+}
+
+static void pci_reassign_root_bus_resources(struct pci_bus *root)
+{
+	do {
+		struct pci_dev *next_new_dev;
+
+		pci_assign_unassigned_root_bus_resources(root);
+
+		if (pci_bus_check_bars_assigned(root, pci_try_failed_bars))
+			break;
+
+		if (pci_try_failed_bars) {
+			dev_warn(&root->dev, "failed to assign all BARs, retry without those failed before\n");
+
+			pci_bus_release_root_bridge_resources(root);
+			pci_try_failed_bars = false;
+			continue;
+		}
+
+		next_new_dev = pci_find_next_new_device(root);
+		if (!next_new_dev) {
+			dev_err(&root->dev, "failed to reassign BARs even after ignoring all the hot-added devices, reload the kernel with pci=no_movable_bars\n");
+			break;
+		}
+
+		dev_warn(&root->dev, "failed to reassign BARs, disable the next hot-added device %s and retry\n",
+			 dev_name(&next_new_dev->dev));
+
+		pci_dev_disable_bars(next_new_dev);
+		pci_bus_release_root_bridge_resources(root);
+	} while (true);
+
+	pci_try_failed_bars = true;
+}
+
 /**
  * pci_rescan_bus - Scan a PCI bus for devices
  * @bus: PCI bus to scan
@@ -3292,7 +3467,7 @@ unsigned int pci_rescan_bus(struct pci_bus *bus)
 		max = pci_scan_child_bus(root);
 
 		pci_bus_release_root_bridge_resources(root);
-		pci_assign_unassigned_root_bus_resources(root);
+		pci_reassign_root_bus_resources(root);
 
 		pci_setup_bridges(root);
 		pci_bus_rescan_done(root);
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 00bdbc0ea817..3bde8fdb9aa0 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -139,7 +139,7 @@ static void pdev_sort_resources(struct pci_dev *dev, struct list_head *head)
 		if (r->flags & IORESOURCE_PCI_FIXED)
 			continue;
 
-		if (!(r->flags) || r->parent)
+		if (!(r->flags) || r->parent || !pci_dev_bar_enabled(dev, i))
 			continue;
 
 		r_align = pci_resource_alignment(dev, r);
@@ -897,7 +897,8 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
 			struct resource *r = &dev->resource[i];
 			unsigned long r_size;
 
-			if (r->parent || !(r->flags & IORESOURCE_IO))
+			if (r->parent || !(r->flags & IORESOURCE_IO) ||
+			    !pci_dev_bar_enabled(dev, i))
 				continue;
 			r_size = resource_size(r);
 
@@ -1017,6 +1018,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 			resource_size_t r_size;
 
 			if (r->parent || (r->flags & IORESOURCE_PCI_FIXED) ||
+			    !pci_dev_bar_enabled(dev, i) ||
 			    ((r->flags & mask) != type &&
 			     (r->flags & mask) != type2 &&
 			     (r->flags & mask) != type3))
diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index d8ca40a97693..51bc69d60791 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -472,6 +472,8 @@ int pci_enable_resources(struct pci_dev *dev, int mask)
 		if ((i == PCI_ROM_RESOURCE) &&
 				(!(r->flags & IORESOURCE_ROM_ENABLE)))
 			continue;
+		if (!pci_dev_bar_enabled(dev, i))
+			continue;
 
 		if (r->flags & IORESOURCE_UNSET) {
 			pci_err(dev, "can't enable device: BAR %d %pR not assigned\n",
diff --git a/include/linux/pci.h b/include/linux/pci.h
index adfc8dfdc87b..6a0a919a3cdb 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -382,6 +382,7 @@ struct pci_dev {
 	 */
 	unsigned int	irq;
 	struct resource resource[DEVICE_COUNT_RESOURCE]; /* I/O and memory regions + expansion ROMs */
+	unsigned int	res_mask;		/* Bitmask of assigned resources */
 
 	bool		match_driver;		/* Skip attaching driver */
 
-- 
2.24.1

