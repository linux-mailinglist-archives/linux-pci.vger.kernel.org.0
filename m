Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D91B14CD5D
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2020 16:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgA2PaB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jan 2020 10:30:01 -0500
Received: from mta-02.yadro.com ([89.207.88.252]:55828 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727077AbgA2PaA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Jan 2020 10:30:00 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 1779C4760F;
        Wed, 29 Jan 2020 15:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1580311796; x=1582126197; bh=FxfooPUZdX4osd6o3fhcnc5BoEyMI6zqcFl
        ZXQHVZwc=; b=rpI444NS4Dk/che48Z50MnWdrk4y/+xrwx2Uiym8EX7gOEDUrFD
        sKSMMsKElthCVsyEl/L36ve7v9HfZ9iF94QKSL/DoVEAuQwLZCku0TnnJBSzXTRa
        Ql+ubY0ysph1a/KCRGDO1ptmADHEdtQzCSz4G1TH00dhMPZuY/ESOrCU=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id b6h_P5owj5dW; Wed, 29 Jan 2020 18:29:56 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 6ED5C4760D;
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
Subject: [PATCH v7 09/26] PCI: hotplug: Calculate immovable parts of bridge windows
Date:   Wed, 29 Jan 2020 18:29:20 +0300
Message-ID: <20200129152937.311162-10-s.miroshnichenko@yadro.com>
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

When movable BARs are enabled, and if a bridge contains a device with fixed
(IORESOURCE_PCI_FIXED) or immovable BARs, the corresponding windows can't
be moved too far away from their original positions - they must still
contain all the fixed/immovable BARs, like that:

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

An immovable area of a bridge window is a range that covers all the fixed
and immovable BARs of direct children, and all the fixed area of children
bridges:

   | <--                    root bridge window                        --> |
   |                                                                      |
   |  | <--                  bridge window level 1                --> |   |
   |  | ******************** immovable area *******************       |   |
   |  |                                                               |   |
   |  | **fixed BAR** | <--      bridge window level 2     --> | BARs |   |
   |  |               | *********** immovable area *********** |      |   |
   |  |               |                                        |      |   |
   |  |               | **fixed BAR** |  BARs  | **fixed BAR** |      |   |
                                         ^^^^

To store these areas, the .immovable_range field has been added to struct
pci_bus for every bridge window type: IO, MEM and PREFETCH. It is filled
recursively from leaves to the root before a rescan.

Signed-off-by: Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
---
 drivers/pci/pci.h   | 14 ++++++++
 drivers/pci/probe.c | 88 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h |  6 ++++
 3 files changed, 108 insertions(+)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 3b4c982772d3..5f2051c8531c 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -404,6 +404,20 @@ static inline bool pci_dev_is_disconnected(const struct pci_dev *dev)
 	return dev->error_state == pci_channel_io_perm_failure;
 }
 
+static inline int pci_get_bridge_resource_idx(struct resource *r)
+{
+	int idx = 1;
+
+	if (r->flags & IORESOURCE_IO)
+		idx = 0;
+	else if (!(r->flags & IORESOURCE_PREFETCH))
+		idx = 1;
+	else if (r->flags & IORESOURCE_MEM_64)
+		idx = 2;
+
+	return idx;
+}
+
 /* pci_dev priv_flags */
 #define PCI_DEV_ADDED 0
 #define PCI_DEV_DISABLED_BARS 1
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 1e8bbf5c99f6..bb584038d5b4 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -546,6 +546,7 @@ void pci_read_bridge_bases(struct pci_bus *child)
 static struct pci_bus *pci_alloc_bus(struct pci_bus *parent)
 {
 	struct pci_bus *b;
+	int idx;
 
 	b = kzalloc(sizeof(*b), GFP_KERNEL);
 	if (!b)
@@ -562,6 +563,11 @@ static struct pci_bus *pci_alloc_bus(struct pci_bus *parent)
 	if (parent)
 		b->domain_nr = parent->domain_nr;
 #endif
+	for (idx = 0; idx < PCI_BRIDGE_RESOURCE_NUM; ++idx) {
+		b->immovable_range[idx].start = 0;
+		b->immovable_range[idx].end = 0;
+	}
+
 	return b;
 }
 
@@ -3228,6 +3234,87 @@ static void pci_setup_bridges(struct pci_bus *bus)
 		pci_setup_bridge(bus);
 }
 
+static void pci_bus_update_immovable_range(struct pci_bus *bus)
+{
+	struct pci_dev *dev;
+	int idx;
+	resource_size_t start, end;
+
+	for (idx = 0; idx < PCI_BRIDGE_RESOURCE_NUM; ++idx) {
+		bus->immovable_range[idx].start = 0;
+		bus->immovable_range[idx].end = 0;
+	}
+
+	list_for_each_entry(dev, &bus->devices, bus_list)
+		if (dev->subordinate)
+			pci_bus_update_immovable_range(dev->subordinate);
+
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		int i;
+		struct pci_bus *child = dev->subordinate;
+
+		for (i = 0; i < PCI_BRIDGE_RESOURCES; ++i) {
+			struct resource *r = &dev->resource[i];
+
+			if (!r->flags || (r->flags & IORESOURCE_UNSET) || !r->parent)
+				continue;
+
+			if (!pci_dev_bar_movable(dev, r)) {
+				idx = pci_get_bridge_resource_idx(r);
+				start = bus->immovable_range[idx].start;
+				end = bus->immovable_range[idx].end;
+
+				if (!start || start > r->start)
+					start = r->start;
+				if (end < r->end)
+					end = r->end;
+
+				if (bus->immovable_range[idx].start != start ||
+				    bus->immovable_range[idx].end != end) {
+					dev_dbg(&bus->dev, "Found fixed BAR%d 0x%llx-0x%llx in %s, expand the fixed bridge window %d to 0x%llx-0x%llx\n",
+						i,
+						(unsigned long long)r->start,
+						(unsigned long long)r->end,
+						dev_name(&dev->dev), idx,
+						(unsigned long long)start,
+						(unsigned long long)end);
+					bus->immovable_range[idx].start = start;
+					bus->immovable_range[idx].end = end;
+				}
+			}
+		}
+
+		if (child) {
+			for (idx = 0; idx < PCI_BRIDGE_RESOURCE_NUM; ++idx) {
+				struct resource *child_immovable_range =
+					&child->immovable_range[idx];
+
+				if (child_immovable_range->start >=
+				    child_immovable_range->end)
+					continue;
+
+				start = bus->immovable_range[idx].start;
+				end = bus->immovable_range[idx].end;
+
+				if (!start || start > child_immovable_range->start)
+					start = child_immovable_range->start;
+				if (end < child_immovable_range->end)
+					end = child_immovable_range->end;
+
+				if (start < bus->immovable_range[idx].start ||
+				    end > bus->immovable_range[idx].end) {
+					dev_dbg(&bus->dev, "Expand the fixed bridge window %d from %s to 0x%llx-0x%llx\n",
+						idx, dev_name(&child->dev),
+						(unsigned long long)start,
+						(unsigned long long)end);
+					bus->immovable_range[idx].start = start;
+					bus->immovable_range[idx].end = end;
+				}
+			}
+		}
+	}
+}
+
 static struct pci_dev *pci_find_next_new_device(struct pci_bus *bus)
 {
 	struct pci_dev *dev;
@@ -3324,6 +3411,7 @@ unsigned int pci_rescan_bus(struct pci_bus *bus)
 
 	if (pci_can_move_bars) {
 		pci_bus_rescan_prepare(root);
+		pci_bus_update_immovable_range(root);
 		pci_bus_release_root_bridge_resources(root);
 
 		max = pci_scan_child_bus(root);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index a8f2c26757fe..d6eb498f7997 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -582,6 +582,12 @@ struct pci_bus {
 	struct list_head resources;	/* Address space routed to this bus */
 	struct resource busn_res;	/* Bus numbers routed to this bus */
 
+	/*
+	 * If there are fixed or immovable resources in the bridge window, this range
+	 * contains the lowest start address and highest end address of them.
+	 */
+	struct resource immovable_range[PCI_BRIDGE_RESOURCE_NUM];
+
 	struct pci_ops	*ops;		/* Configuration access functions */
 	struct msi_controller *msi;	/* MSI controller */
 	void		*sysdata;	/* Hook for sys-specific extension */
-- 
2.24.1

