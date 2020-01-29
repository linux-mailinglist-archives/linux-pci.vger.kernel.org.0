Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 059D014CD5B
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2020 16:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgA2P37 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jan 2020 10:29:59 -0500
Received: from mta-02.yadro.com ([89.207.88.252]:55810 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727069AbgA2P36 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Jan 2020 10:29:58 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id E073F475F3;
        Wed, 29 Jan 2020 15:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1580311795; x=1582126196; bh=DAqmEsLnVAqSAcoFGQUTwvRuQLh427NtVrL
        oUiLmN6E=; b=cqoigw+GJ2dT0rLaXnIFxCgCNjVfituGNfPfD+Ko2rxWSZHF87f
        nXiTu9lVyJhvjnIf32UHP3skwbMrAJbBFo7qW9lwSGvhW4RDkmyhY1oahXF94N/y
        mnMyjRu9TGLOifSLcpBrOJjjpi6YFsvWK4Zmrxe9wbdeiIh+o3edgAnY=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id JHhvAxiRfWc7; Wed, 29 Jan 2020 18:29:55 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 17E7847609;
        Wed, 29 Jan 2020 18:29:52 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.136) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Wed, 29
 Jan 2020 18:29:51 +0300
From:   Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>, Stefan Roese <sr@denx.de>,
        <linux@yadro.com>,
        Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH v7 07/26] PCI: hotplug: Don't allow hot-added devices to steal resources
Date:   Wed, 29 Jan 2020 18:29:18 +0300
Message-ID: <20200129152937.311162-8-s.miroshnichenko@yadro.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200129152937.311162-1-s.miroshnichenko@yadro.com>
References: <20200129152937.311162-1-s.miroshnichenko@yadro.com>
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
working devices and to the newly hotplugged ones, with the same priority.

If a hotplugged device gets its BARs first, this may lead to lack of space
for already working devices, which is unacceptable. If that happens, mark
one of the new devices with the newly introduced flag PCI_DEV_DISABLED_BARS
(if it is not yet marked) and retry the BAR recalculation.

The worst case would be no BARs for hotplugged devices, while all the rest
just continue working.

The algorithm is simple and it doesn't retry different subsets of hot-added
devices in case of a failure, e.g. if there are no space to allocate BARs
for both hotplugged devices A and B, but is enough for just A, the A will
be marked with PCI_DEV_DISABLED_BARS first, then (after the next failure) -
B. As a result, A will not get BARs while it could. This issue is only
relevant when hotplugging two and more devices simultaneously.

Add a new res_mask bitmask to the struct pci_dev for storing the indices of
assigned BARs.

Signed-off-by: Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
---
 drivers/pci/pci.h       |  11 +++++
 drivers/pci/probe.c     | 102 ++++++++++++++++++++++++++++++++++++++--
 drivers/pci/setup-bus.c |  15 ++++++
 drivers/pci/setup-res.c |   3 ++
 include/linux/pci.h     |   1 +
 5 files changed, 129 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index fe995993b481..3b4c982772d3 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -406,6 +406,7 @@ static inline bool pci_dev_is_disconnected(const struct pci_dev *dev)
 
 /* pci_dev priv_flags */
 #define PCI_DEV_ADDED 0
+#define PCI_DEV_DISABLED_BARS 1
 
 static inline void pci_dev_assign_added(struct pci_dev *dev, bool added)
 {
@@ -417,6 +418,16 @@ static inline bool pci_dev_is_added(const struct pci_dev *dev)
 	return test_bit(PCI_DEV_ADDED, &dev->priv_flags);
 }
 
+static inline void pci_dev_disable_bars(struct pci_dev *dev)
+{
+	assign_bit(PCI_DEV_DISABLED_BARS, &dev->priv_flags, true);
+}
+
+static inline bool pci_dev_bars_enabled(const struct pci_dev *dev)
+{
+	return !test_bit(PCI_DEV_DISABLED_BARS, &dev->priv_flags);
+}
+
 #ifdef CONFIG_PCIEAER
 #include <linux/aer.h>
 
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index daaaebdfd4c4..1e8bbf5c99f6 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3152,6 +3152,23 @@ bool pci_dev_bar_movable(struct pci_dev *dev, struct resource *res)
 	return false;
 }
 
+static unsigned int pci_dev_count_res_mask(struct pci_dev *dev)
+{
+	unsigned int res_mask = 0;
+	int i;
+
+	for (i = 0; i < PCI_BRIDGE_RESOURCES; i++) {
+		struct resource *r = &dev->resource[i];
+
+		if (!r->flags || (r->flags & IORESOURCE_UNSET) || !r->parent)
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
@@ -3162,6 +3179,8 @@ static void pci_bus_rescan_prepare(struct pci_bus *bus)
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		struct pci_bus *child = dev->subordinate;
 
+		dev->res_mask = pci_dev_count_res_mask(dev);
+
 		if (child)
 			pci_bus_rescan_prepare(child);
 
@@ -3197,7 +3216,7 @@ static void pci_setup_bridges(struct pci_bus *bus)
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		struct pci_bus *child;
 
-		if (!pci_dev_is_added(dev))
+		if (!pci_dev_is_added(dev) || !pci_dev_bars_enabled(dev))
 			continue;
 
 		child = dev->subordinate;
@@ -3209,6 +3228,83 @@ static void pci_setup_bridges(struct pci_bus *bus)
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
+static bool pci_bus_check_all_bars_reassigned(struct pci_bus *bus)
+{
+	struct pci_dev *dev;
+	bool ret = true;
+
+	if (!bus)
+		return false;
+
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		struct pci_bus *child = dev->subordinate;
+		unsigned int res_mask = pci_dev_count_res_mask(dev);
+
+		if (!pci_dev_bars_enabled(dev))
+			continue;
+
+		if (dev->res_mask & ~res_mask) {
+			pci_err(dev, "Non-re-enabled resources found: 0x%x -> 0x%x\n",
+				dev->res_mask, res_mask);
+			ret = false;
+		}
+
+		if (child && !pci_bus_check_all_bars_reassigned(child))
+			ret = false;
+	}
+
+	return ret;
+}
+
+static void pci_reassign_root_bus_resources(struct pci_bus *root)
+{
+	do {
+		struct pci_dev *next_new_dev;
+
+		pci_assign_unassigned_root_bus_resources(root);
+
+		if (pci_bus_check_all_bars_reassigned(root))
+			break;
+
+		next_new_dev = pci_find_next_new_device(root);
+		if (!next_new_dev) {
+			dev_err(&root->dev, "failed to re-assign resources even after ignoring all the hotplugged devices\n");
+			break;
+		}
+
+		dev_warn(&root->dev, "failed to re-assign resources, disable the next hotplugged device %s and retry\n",
+			 dev_name(&next_new_dev->dev));
+
+		pci_dev_disable_bars(next_new_dev);
+		pci_bus_release_root_bridge_resources(root);
+	} while (true);
+}
+
 /**
  * pci_rescan_bus - Scan a PCI bus for devices
  * @bus: PCI bus to scan
@@ -3228,11 +3324,11 @@ unsigned int pci_rescan_bus(struct pci_bus *bus)
 
 	if (pci_can_move_bars) {
 		pci_bus_rescan_prepare(root);
+		pci_bus_release_root_bridge_resources(root);
 
 		max = pci_scan_child_bus(root);
 
-		pci_bus_release_root_bridge_resources(root);
-		pci_assign_unassigned_root_bus_resources(root);
+		pci_reassign_root_bus_resources(root);
 
 		pci_setup_bridges(root);
 		pci_bus_rescan_done(root);
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 7a9bf979908d..b9521ca8b24c 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -128,6 +128,9 @@ static void pdev_sort_resources(struct pci_dev *dev, struct list_head *head)
 {
 	int i;
 
+	if (!pci_dev_bars_enabled(dev))
+		return;
+
 	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
 		struct resource *r;
 		struct pci_dev_resource *dev_res, *tmp;
@@ -177,6 +180,9 @@ static void __dev_sort_resources(struct pci_dev *dev, struct list_head *head)
 {
 	u16 class = dev->class >> 8;
 
+	if (!pci_dev_bars_enabled(dev))
+		return;
+
 	/* Don't touch classless devices or host bridges or IOAPICs */
 	if (class == PCI_CLASS_NOT_DEFINED || class == PCI_CLASS_BRIDGE_HOST)
 		return;
@@ -278,6 +284,9 @@ static void assign_requested_resources_sorted(struct list_head *head,
 	int idx;
 
 	list_for_each_entry(dev_res, head, list) {
+		if (!pci_dev_bars_enabled(dev_res->dev))
+			continue;
+
 		res = dev_res->res;
 		idx = res - &dev_res->dev->resource[0];
 		if (resource_size(res) &&
@@ -1012,6 +1021,9 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		int i;
 
+		if (!pci_dev_bars_enabled(dev))
+			continue;
+
 		for (i = 0; i < PCI_NUM_RESOURCES; i++) {
 			struct resource *r = &dev->resource[i];
 			resource_size_t r_size;
@@ -1368,6 +1380,9 @@ void __pci_bus_assign_resources(const struct pci_bus *bus,
 	pbus_assign_resources_sorted(bus, realloc_head, fail_head);
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
+		if (!pci_dev_bars_enabled(dev))
+			continue;
+
 		pdev_assign_fixed_resources(dev);
 
 		b = dev->subordinate;
diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index d8ca40a97693..17c79057f517 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -458,6 +458,9 @@ int pci_enable_resources(struct pci_dev *dev, int mask)
 	int i;
 	struct resource *r;
 
+	if (!pci_dev_bars_enabled(dev))
+		return -ENOSPC;
+
 	pci_read_config_word(dev, PCI_COMMAND, &cmd);
 	old_cmd = cmd;
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index a543f647d337..a8f2c26757fe 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -375,6 +375,7 @@ struct pci_dev {
 	 */
 	unsigned int	irq;
 	struct resource resource[DEVICE_COUNT_RESOURCE]; /* I/O and memory regions + expansion ROMs */
+	unsigned int	res_mask;		/* Bitmask of assigned resources */
 
 	bool		match_driver;		/* Skip attaching driver */
 
-- 
2.24.1

