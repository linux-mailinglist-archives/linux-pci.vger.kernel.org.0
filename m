Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7F514CD5C
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2020 16:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbgA2PaA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jan 2020 10:30:00 -0500
Received: from mta-02.yadro.com ([89.207.88.252]:55788 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726913AbgA2PaA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Jan 2020 10:30:00 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 3BCF34762A;
        Wed, 29 Jan 2020 15:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1580311798; x=1582126199; bh=hfrGP7ZuV7gZotJUWNFmK1pWrC8q21FdDJn
        WkhmZCp4=; b=SooZxLkirNPJsmv/J/eaBXlKuMPIRKkxD1/DGAxyKFdBoWYHlNr
        w4fxUkeiOMmHHNn2ax/vm/LRj8/WdTh8/KObqhQLnOJANdeGc1N15xjFvsQSPZ/D
        uTbSgSG6JJv5mNtJxFJ0AgLUDbGbcePqOqSBJPh/k/wCSqQAEuPMzBdM=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xfoJSsSlqrZr; Wed, 29 Jan 2020 18:29:58 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id D037447603;
        Wed, 29 Jan 2020 18:29:52 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.136) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Wed, 29
 Jan 2020 18:29:52 +0300
From:   Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>, Stefan Roese <sr@denx.de>,
        <linux@yadro.com>,
        Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH v7 11/26] PCI: hotplug: movable BARs: Compute limits for relocated bridge windows
Date:   Wed, 29 Jan 2020 18:29:22 +0300
Message-ID: <20200129152937.311162-12-s.miroshnichenko@yadro.com>
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

With enabled movable BARs, bridge windows are recalculated during each PCI
rescan. Some of the BARs below a bridge may be immovable: these areas are
represented by the .immovable_range field in struct pci_bus.

If a bridge window size is equal to its immovable range, it can only be
assigned to the start of this range. But if a bridge window size is larger,
and this difference in size is denoted as "delta", the window can start
from (immovable_range.start - delta) to (immovable_range.start), and it can
end from (immovable_range.end) to (immovable_range.end + delta). This range
(the new .realloc_range field in struct pci_bus) must then be compared with
immovable ranges of neighbouring bridges to guarantee absence of
intersections.

This patch only calculates valid ranges for reallocated bridges during pci
rescan, and the next one will make use of these values during allocation.

Signed-off-by: Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
---
 drivers/pci/pci.h       |  1 +
 drivers/pci/setup-bus.c | 86 +++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h     |  6 +++
 3 files changed, 93 insertions(+)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 5f2051c8531c..ddd6fd33f9c3 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -291,6 +291,7 @@ struct pci_bus *pci_bus_get(struct pci_bus *bus);
 void pci_bus_put(struct pci_bus *bus);
 
 bool pci_dev_bar_movable(struct pci_dev *dev, struct resource *res);
+void pci_bus_update_realloc_range(struct pci_bus *bus);
 
 /* PCIe link information */
 #define PCIE_SPEED2STR(speed) \
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 5874c352b41e..71babb968830 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1837,6 +1837,91 @@ static enum enable_type pci_realloc_detect(struct pci_bus *bus,
 }
 #endif
 
+/*
+ * Calculate the address margins where the bridge windows may be allocated to fit all
+ * the fixed and immovable BARs beneath.
+ */
+void pci_bus_update_realloc_range(struct pci_bus *bus)
+{
+	struct pci_dev *dev;
+	struct pci_bus *parent = bus->parent;
+	int idx;
+
+	list_for_each_entry(dev, &bus->devices, bus_list)
+		if (dev->subordinate)
+			pci_bus_update_realloc_range(dev->subordinate);
+
+	if (!parent || !bus->self)
+		return;
+
+	for (idx = 0; idx < PCI_BRIDGE_RESOURCE_NUM; ++idx) {
+		struct resource *immovable_range = &bus->immovable_range[idx];
+		resource_size_t window_size = resource_size(bus->resource[idx]);
+		resource_size_t realloc_start, realloc_end;
+
+		bus->realloc_range[idx].start = 0;
+		bus->realloc_range[idx].end = 0;
+
+		/* Check if there any immovable BARs under the bridge */
+		if (immovable_range->start >= immovable_range->end)
+			continue;
+
+		/* The lowest possible address where the bridge window can start */
+		realloc_start = immovable_range->end - window_size + 1;
+		/* The highest possible address where the bridge window can end */
+		realloc_end = immovable_range->start + window_size - 1;
+
+		if (realloc_start > immovable_range->start)
+			realloc_start = immovable_range->start;
+
+		if (realloc_end < immovable_range->end)
+			realloc_end = immovable_range->end;
+
+		/*
+		 * Check that realloc range doesn't intersect with hard fixed ranges
+		 * of neighboring bridges
+		 */
+		list_for_each_entry(dev, &parent->devices, bus_list) {
+			struct pci_bus *neighbor = dev->subordinate;
+			struct resource *n_imm_range;
+
+			if (!neighbor) {
+				int i;
+
+				for (i = 0; i < PCI_BRIDGE_RESOURCE_NUM; ++i) {
+					struct resource *nr = &dev->resource[i];
+
+					if (!nr->flags ||
+					    !nr->start ||
+					    pci_dev_bar_movable(dev, nr))
+						continue;
+
+					if (nr->end < immovable_range->start &&
+					    nr->end > realloc_start)
+						realloc_start = nr->end;
+				}
+
+				continue;
+			}
+
+			if (neighbor == bus)
+				continue;
+
+			n_imm_range = &neighbor->immovable_range[idx];
+
+			if (n_imm_range->start >= n_imm_range->end)
+				continue;
+
+			if (n_imm_range->end < immovable_range->start &&
+			    n_imm_range->end > realloc_start)
+				realloc_start = n_imm_range->end;
+		}
+
+		bus->realloc_range[idx].start = realloc_start;
+		bus->realloc_range[idx].end = realloc_end;
+	}
+}
+
 /*
  * First try will not touch PCI bridge res.
  * Second and later try will clear small leaf bridge res.
@@ -1856,6 +1941,7 @@ void pci_assign_unassigned_root_bus_resources(struct pci_bus *bus)
 
 	if (pci_can_move_bars) {
 		__pci_bus_size_bridges(bus, NULL);
+		pci_bus_update_realloc_range(bus);
 		__pci_bus_assign_resources(bus, NULL, NULL);
 
 		goto dump;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index d6eb498f7997..8830a254405f 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -588,6 +588,12 @@ struct pci_bus {
 	 */
 	struct resource immovable_range[PCI_BRIDGE_RESOURCE_NUM];
 
+	/*
+	 * Acceptable address range, where the bridge window may reside, considering its
+	 * size, so it will cover all the fixed and immovable BARs below.
+	 */
+	struct resource realloc_range[PCI_BRIDGE_RESOURCE_NUM];
+
 	struct pci_ops	*ops;		/* Configuration access functions */
 	struct msi_controller *msi;	/* MSI controller */
 	void		*sysdata;	/* Hook for sys-specific extension */
-- 
2.24.1

