Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DBE91BAC74
	for <lists+linux-pci@lfdr.de>; Mon, 27 Apr 2020 20:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgD0SYW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Apr 2020 14:24:22 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:53000 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726474AbgD0SYW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Apr 2020 14:24:22 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 4F9814C85C;
        Mon, 27 Apr 2020 18:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1588011857; x=1589826258; bh=XxuSOya3RSZlI+OIzdvMtCnGmdaL/4ctOZz
        HWyksP74=; b=p2FQuhHBiguKBwLHqmZjligO77DnRjW+Zr79R2y1bLGNl6N9K5e
        7lVmmEQyALuO+ye6HJWIN6hK9ewcyjnqXsNITSc6DVtovhJu86s0+Ev5fijwvxit
        4w3o9zuJncdTgT//CIK7IE77R2zxmvVfniihpawDY0Zi+QABBMzEceSk=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2W5-9qa9-A36; Mon, 27 Apr 2020 21:24:17 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id C48984C842;
        Mon, 27 Apr 2020 21:24:11 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.136) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Mon, 27
 Apr 2020 21:24:12 +0300
From:   Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Stefan Roese <sr@denx.de>, Andy Lavr <andy.lavr@gmail.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        David Laight <David.Laight@ACULAB.COM>,
        Rajat Jain <rajatja@google.com>, <linux@yadro.com>,
        Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH v8 10/24] PCI: hotplug: Calculate fixed parts of bridge windows
Date:   Mon, 27 Apr 2020 21:23:44 +0300
Message-ID: <20200427182358.2067702-11-s.miroshnichenko@yadro.com>
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

When movable BARs are enabled, and if a bridge contains a device with fixed
BARs, the corresponding windows can't be moved too far away from their
original positions - they must still contain all the fixed BARs, like that:

1) Window position before a bus rescan:

   | <--                    root bridge window                        --> |
   |                                                                      |
   | | <--     bridge window    --> |                                     |
   | | movable BARs | **fixed BAR** |                                     |
       ^^^^^^^^^^^^

2) Possible valid outcome after rescan and move:

   | <--                    root bridge window                        --> |
   |                                                                      |
   |                | <--     bridge window    --> |                      |
   |                | **fixed BAR** | Movable BARs |                      |
                                      ^^^^^^^^^^^^

A fixed area of a bridge window is a range that covers all the fixed BARs
of direct children, and all the fixed area of children bridges:

   | <--                    root bridge window                        --> |
   |                                                                      |
   |  | <--                  bridge window level 1                --> |   |
   |  | ********************** fixed area *********************       |   |
   |  |                                                               |   |
   |  | **fixed BAR** | <--      bridge window level 2     --> | BARs |   |
   |  |               | ************* fixed area ************* |      |   |
   |  |               |                                        |      |   |
   |  |               | **fixed BAR** |  BARs  | **fixed BAR** |      |   |
                                         ^^^^

To store these areas, the .fixed_range field has been added to the struct
pci_bus for every bridge window type: IO, MEM and PREFETCH. It is filled
recursively from leaves to the root before a rescan.

Signed-off-by: Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
---
 drivers/pci/pci.h   | 23 ++++++++++++
 drivers/pci/probe.c | 89 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h |  6 +++
 3 files changed, 118 insertions(+)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 2ef72741e8e5..869398a62e5f 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -297,6 +297,17 @@ bool pci_dev_bar_fixed(struct pci_dev *dev, struct resource *res);
 bool pci_dev_bar_enabled(const struct pci_dev *dev, int idx);
 bool pci_bus_check_bars_assigned(struct pci_bus *bus, bool complete_set);
 
+static inline void pci_set_fixed_range(struct resource *res)
+{
+	res->start = (resource_size_t)-1;
+	res->end = 0;
+}
+
+static inline bool pci_fixed_range_valid(struct resource *res)
+{
+	return res->start <= res->end;
+}
+
 extern bool pci_init_done;
 
 /* PCIe link information from Link Capabilities 2 */
@@ -414,6 +425,18 @@ static inline bool pci_dev_is_disconnected(const struct pci_dev *dev)
 	return dev->error_state == pci_channel_io_perm_failure;
 }
 
+static inline int pci_get_bridge_resource_idx(struct resource *r)
+{
+	if (r->flags & IORESOURCE_IO)
+		return 0;
+	else if (!(r->flags & IORESOURCE_PREFETCH))
+		return 1;
+	else if (r->flags & IORESOURCE_MEM_64)
+		return 2;
+
+	return 1;
+}
+
 /* pci_dev priv_flags */
 #define PCI_DEV_ADDED 0
 #define PCI_DEV_DISABLED_BARS 1
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 0c681bb767cc..2ec3f80f2711 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -589,6 +589,7 @@ void pci_read_bridge_bases(struct pci_bus *child)
 static struct pci_bus *pci_alloc_bus(struct pci_bus *parent)
 {
 	struct pci_bus *b;
+	int idx;
 
 	b = kzalloc(sizeof(*b), GFP_KERNEL);
 	if (!b)
@@ -605,6 +606,13 @@ static struct pci_bus *pci_alloc_bus(struct pci_bus *parent)
 	if (parent)
 		b->domain_nr = parent->domain_nr;
 #endif
+	for (idx = 0; idx < PCI_BRIDGE_RESOURCE_NUM; ++idx)
+		pci_set_fixed_range(&b->fixed_range[idx]);
+
+	b->fixed_range[0].flags = IORESOURCE_IO;
+	b->fixed_range[1].flags = IORESOURCE_MEM;
+	b->fixed_range[2].flags = IORESOURCE_MEM | IORESOURCE_PREFETCH;
+
 	return b;
 }
 
@@ -3338,6 +3346,86 @@ static void pci_setup_bridges(struct pci_bus *bus)
 		pci_setup_bridge(bus);
 }
 
+static void pci_bus_update_fixed_range(struct pci_bus *bus)
+{
+	struct pci_dev *dev;
+	int idx;
+	resource_size_t start, end;
+
+	for (idx = 0; idx < PCI_BRIDGE_RESOURCE_NUM; ++idx)
+		pci_set_fixed_range(&bus->fixed_range[idx]);
+
+	list_for_each_entry(dev, &bus->devices, bus_list)
+		if (dev->subordinate)
+			pci_bus_update_fixed_range(dev->subordinate);
+
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		int i;
+		struct pci_bus *child = dev->subordinate;
+
+		for (i = 0; i < PCI_BRIDGE_RESOURCES; ++i) {
+			struct resource *r = &dev->resource[i];
+			struct resource *fixed_range;
+
+			if (!r->flags || (r->flags & IORESOURCE_UNSET) ||
+			    !r->parent || !pci_dev_bar_fixed(dev, r))
+				continue;
+
+			idx = pci_get_bridge_resource_idx(r);
+			fixed_range = &bus->fixed_range[idx];
+			start = fixed_range->start;
+			end = fixed_range->end;
+
+			if (!pci_fixed_range_valid(fixed_range) ||
+			    start > r->start)
+				start = r->start;
+
+			if (end < r->end)
+				end = r->end;
+
+			if (fixed_range->start != start ||
+			    fixed_range->end != end) {
+				fixed_range->start = start;
+				fixed_range->end = end;
+				dev_dbg(&bus->dev, "Found fixed BAR %d %pR in %s, expand the fixed bridge window %d to %pR\n",
+					i, r, dev_name(&dev->dev), idx,
+					fixed_range);
+			}
+		}
+
+		if (child) {
+			for (idx = 0; idx < PCI_BRIDGE_RESOURCE_NUM; ++idx) {
+				struct resource *fixed_range = &bus->fixed_range[idx];
+				struct resource *child_fixed_range =
+					&child->fixed_range[idx];
+
+				if (!pci_fixed_range_valid(child_fixed_range))
+					continue;
+
+				start = fixed_range->start;
+				end = fixed_range->end;
+
+				if (!pci_fixed_range_valid(fixed_range) ||
+				    start > child_fixed_range->start)
+					start = child_fixed_range->start;
+
+				if (end < child_fixed_range->end)
+					end = child_fixed_range->end;
+
+				if (start < fixed_range->start ||
+				    end > fixed_range->end) {
+					dev_dbg(&bus->dev, "Expand the fixed bridge window %d from %s to 0x%llx-0x%llx\n",
+						idx, dev_name(&child->dev),
+						(unsigned long long)start,
+						(unsigned long long)end);
+					fixed_range->start = start;
+					fixed_range->end = end;
+				}
+			}
+		}
+	}
+}
+
 static struct pci_dev *pci_find_next_new_device(struct pci_bus *bus)
 {
 	struct pci_dev *dev;
@@ -3469,6 +3557,7 @@ unsigned int pci_rescan_bus(struct pci_bus *bus)
 
 	if (pci_can_move_bars) {
 		pci_bus_rescan_prepare(root);
+		pci_bus_update_fixed_range(root);
 
 		max = pci_scan_child_bus(root);
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 6a0a919a3cdb..b2d766ed425c 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -596,6 +596,12 @@ struct pci_bus {
 	struct list_head resources;	/* Address space routed to this bus */
 	struct resource busn_res;	/* Bus numbers routed to this bus */
 
+	/*
+	 * If there are fixed resources in the bridge window, this range contains
+	 * the lowest start address and the highest end address of them.
+	 */
+	struct resource fixed_range[PCI_BRIDGE_RESOURCE_NUM];
+
 	struct pci_ops	*ops;		/* Configuration access functions */
 	struct msi_controller *msi;	/* MSI controller */
 	void		*sysdata;	/* Hook for sys-specific extension */
-- 
2.24.1

