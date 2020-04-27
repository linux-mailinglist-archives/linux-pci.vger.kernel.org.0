Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB9B31BAC75
	for <lists+linux-pci@lfdr.de>; Mon, 27 Apr 2020 20:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbgD0SYZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Apr 2020 14:24:25 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:53048 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726362AbgD0SYX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Apr 2020 14:24:23 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id C7B104C85E;
        Mon, 27 Apr 2020 18:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1588011859; x=1589826260; bh=jHOV7hgs/0oNYlmrAWuBpeUz1CrdmuaKPZG
        e77BwIMk=; b=FhA/tTk7210oWzmF+H9t1DkHZCHEoyXbJtg+QgGxuW4jOUSFNZH
        mhlpZOeAr3grkGtFZPHC6TkhMPW6t6obpppgzfhWTSDv4sYUxUWdsxoe+iaX3zRu
        SJhRSHVQw+ahp+l5sqvQnKEmbpcFbPrTKawH2o9Kq3JRV4N6OawUFxFc=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id IkQN6vekPOsu; Mon, 27 Apr 2020 21:24:19 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id D7F0A4C844;
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
Subject: [PATCH v8 12/24] PCI: hotplug: movable BARs: Compute limits for relocated bridge windows
Date:   Mon, 27 Apr 2020 21:23:46 +0300
Message-ID: <20200427182358.2067702-13-s.miroshnichenko@yadro.com>
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

With enabled movable BARs, bridge windows are recalculated during each PCI
rescan. Some of the BARs below a bridge may be fixed: these areas are
represented by the .fixed_range field in struct pci_bus.

If a bridge window size is equal to its fixed range, it can only be
assigned to the start of this range. But if a bridge window size is larger,
and this difference in size is denoted as "delta", the window can start
from (fixed_range.start - delta) to (fixed_range.start), and it can end
from (fixed_range.end) to (fixed_range.end + delta). This range (the new
.realloc_range field in struct pci_bus) must then be compared with fixed
ranges of neighbouring bridges to guarantee absence of intersections.

This patch only calculates valid ranges for reallocated bridges during pci
rescan, and the next one will make use of these values during allocation.

Signed-off-by: Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
---
 drivers/pci/probe.c     |  4 ++
 drivers/pci/setup-bus.c | 85 +++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h     |  6 +++
 3 files changed, 95 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 2ec3f80f2711..765b2883755a 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -613,6 +613,10 @@ static struct pci_bus *pci_alloc_bus(struct pci_bus *parent)
 	b->fixed_range[1].flags = IORESOURCE_MEM;
 	b->fixed_range[2].flags = IORESOURCE_MEM | IORESOURCE_PREFETCH;
 
+	b->realloc_range[0].flags = IORESOURCE_IO;
+	b->realloc_range[1].flags = IORESOURCE_MEM;
+	b->realloc_range[2].flags = IORESOURCE_MEM | IORESOURCE_PREFETCH;
+
 	return b;
 }
 
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 1e52dd71f02a..a6d8bb5ed43d 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1814,6 +1814,90 @@ static enum enable_type pci_realloc_detect(struct pci_bus *bus,
 }
 #endif
 
+/*
+ * Calculate the address margins where the bridge windows may be allocated to fit all
+ * the fixed BARs beneath.
+ */
+static void pci_bus_update_realloc_range(struct pci_bus *bus)
+{
+	struct pci_dev *dev;
+	struct pci_bus *parent = bus->parent;
+	int idx;
+
+	if (!pci_can_move_bars)
+		return;
+
+	list_for_each_entry(dev, &bus->devices, bus_list)
+		if (dev->subordinate)
+			pci_bus_update_realloc_range(dev->subordinate);
+
+	if (!parent || !bus->self)
+		return;
+
+	for (idx = 0; idx < PCI_BRIDGE_RESOURCE_NUM; ++idx) {
+		struct resource *fixed_range = &bus->fixed_range[idx];
+		struct resource *realloc_range = &bus->realloc_range[idx];
+		resource_size_t window_size = resource_size(bus->resource[idx]);
+		resource_size_t realloc_start, realloc_end;
+
+		pci_set_fixed_range(realloc_range);
+
+		/* Check if there any fixed BARs under the bridge */
+		if (!pci_fixed_range_valid(fixed_range))
+			continue;
+
+		/* The lowest possible address where the bridge window can start */
+		realloc_start = fixed_range->end - window_size + 1;
+		if (realloc_start > fixed_range->start)
+			realloc_start = fixed_range->start;
+
+		/* The highest possible address where the bridge window can end */
+		realloc_end = fixed_range->start + window_size - 1;
+		if (realloc_end < fixed_range->end)
+			realloc_end = fixed_range->end;
+
+		/*
+		 * Check that realloc range doesn't intersect with hard fixed ranges
+		 * of neighboring bridges
+		 */
+		list_for_each_entry(dev, &parent->devices, bus_list) {
+			struct pci_bus *neighbor = dev->subordinate;
+			struct resource *n_imm_range;
+			int i;
+
+			if (neighbor == bus)
+				continue;
+
+			for (i = 0; i < PCI_BRIDGE_RESOURCE_NUM; ++i) {
+				struct resource *nr = &dev->resource[i];
+
+				if (!nr->flags ||
+				    !pci_dev_bar_fixed(dev, nr))
+					continue;
+
+				if (nr->end < fixed_range->start &&
+				    nr->end > realloc_start)
+					realloc_start = nr->end;
+			}
+
+			if (!neighbor)
+				continue;
+
+			n_imm_range = &neighbor->fixed_range[idx];
+
+			if (!pci_fixed_range_valid(n_imm_range))
+				continue;
+
+			if (n_imm_range->end < fixed_range->start &&
+			    n_imm_range->end > realloc_start)
+				realloc_start = n_imm_range->end;
+		}
+
+		realloc_range->start = realloc_start;
+		realloc_range->end = realloc_end;
+	}
+}
+
 /*
  * First try will not touch PCI bridge res.
  * Second and later try will clear small leaf bridge res.
@@ -1833,6 +1917,7 @@ void pci_assign_unassigned_root_bus_resources(struct pci_bus *bus)
 
 	if (pci_can_move_bars) {
 		__pci_bus_size_bridges(bus, NULL);
+		pci_bus_update_realloc_range(bus);
 		__pci_bus_assign_resources(bus, NULL, NULL);
 
 		goto dump;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index b2d766ed425c..9f34b932dac6 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -602,6 +602,12 @@ struct pci_bus {
 	 */
 	struct resource fixed_range[PCI_BRIDGE_RESOURCE_NUM];
 
+	/*
+	 * Acceptable address range, where the bridge window may reside, considering its
+	 * size, so it will cover all the fixed BARs below.
+	 */
+	struct resource realloc_range[PCI_BRIDGE_RESOURCE_NUM];
+
 	struct pci_ops	*ops;		/* Configuration access functions */
 	struct msi_controller *msi;	/* MSI controller */
 	void		*sysdata;	/* Hook for sys-specific extension */
-- 
2.24.1

