Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9526490625
	for <lists+linux-pci@lfdr.de>; Fri, 16 Aug 2019 18:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfHPQvV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Aug 2019 12:51:21 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:51338 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727034AbfHPQvV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 16 Aug 2019 12:51:21 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 44ED142EE0;
        Fri, 16 Aug 2019 16:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1565974278; x=1567788679; bh=mzzHmMxypSmyMD7JSc2YFxKV7OgmlBqwPAt
        HK9+W88E=; b=sUgG7HdnFlRNZMyAKd5GqmHabzzDIZW/fJxy9iDvjVyFSPNGOvI
        ke/5A4RSabLs60SZzDRp+NUGOr1w6y8jV24jx+p6CHteKLOGp4kylDexaTZHJ+nR
        wiuAyd+jKWMVgB9/PYQGySfvkt1i5z9f15W5ysnVrBDRMK/jL8tbRNJo=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 70wtIAOWB8CI; Fri, 16 Aug 2019 19:51:18 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 18B7042EDF;
        Fri, 16 Aug 2019 19:51:12 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.60) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Fri, 16
 Aug 2019 19:51:11 +0300
From:   Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>, <linux@yadro.com>,
        Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH v5 15/23] PCI: hotplug: movable BARs: Assign fixed and immovable BARs before others
Date:   Fri, 16 Aug 2019 19:50:53 +0300
Message-ID: <20190816165101.911-16-s.miroshnichenko@yadro.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190816165101.911-1-s.miroshnichenko@yadro.com>
References: <20190816165101.911-1-s.miroshnichenko@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.17.15.60]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Reassign resources during rescan in two steps: first the fixed/immovable
BARs and bridge windows that have fixed areas, so the movable ones will not
steal these reserved areas; then the rest - so the movable BARs will divide
the rest of the space.

With this change, pci_assign_resource() is now able to assign all types of
BARs, so the pdev_assign_fixed_resources() became unused and thus removed.

Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
---
 drivers/pci/pci.h       |  2 ++
 drivers/pci/setup-bus.c | 79 ++++++++++++++++++++++++-----------------
 drivers/pci/setup-res.c |  8 +++--
 3 files changed, 55 insertions(+), 34 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 12add575faf1..e1fcc46f9c40 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -260,6 +260,8 @@ void pci_disable_bridge_window(struct pci_dev *dev);
 
 bool pci_dev_movable_bars_supported(struct pci_dev *dev);
 
+int assign_fixed_resource_on_bus(struct pci_bus *b, struct resource *r);
+
 /* PCIe link information */
 #define PCIE_SPEED2STR(speed) \
 	((speed) == PCIE_SPEED_16_0GT ? "16 GT/s" : \
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 6f12411357f3..c7b7e30c6284 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -38,6 +38,15 @@ struct pci_dev_resource {
 	unsigned long flags;
 };
 
+enum assign_step {
+	assign_fixed_resources,
+	assign_float_resources,
+};
+
+static void _assign_requested_resources_sorted(struct list_head *head,
+					       struct list_head *fail_head,
+					       enum assign_step step);
+
 static void free_list(struct list_head *head)
 {
 	struct pci_dev_resource *dev_res, *tmp;
@@ -278,19 +287,48 @@ static void reassign_resources_sorted(struct list_head *realloc_head,
  */
 static void assign_requested_resources_sorted(struct list_head *head,
 				 struct list_head *fail_head)
+{
+	_assign_requested_resources_sorted(head, fail_head, assign_fixed_resources);
+	_assign_requested_resources_sorted(head, fail_head, assign_float_resources);
+}
+
+static void _assign_requested_resources_sorted(struct list_head *head,
+					       struct list_head *fail_head,
+					       enum assign_step step)
 {
 	struct resource *res;
 	struct pci_dev_resource *dev_res;
 	int idx;
 
 	list_for_each_entry(dev_res, head, list) {
+		bool is_fixed = false;
+
 		if (!pci_dev_bars_enabled(dev_res->dev))
 			continue;
 
 		res = dev_res->res;
+		if (!resource_size(res))
+			continue;
+
 		idx = res - &dev_res->dev->resource[0];
-		if (resource_size(res) &&
-		    pci_assign_resource(dev_res->dev, idx)) {
+
+		if (idx < PCI_BRIDGE_RESOURCES) {
+			is_fixed = (res->flags & IORESOURCE_PCI_FIXED) ||
+				!pci_dev_movable_bars_supported(dev_res->dev);
+		} else {
+			int b_res_idx = pci_get_bridge_resource_idx(res);
+			struct resource *fixed_res =
+				&dev_res->dev->subordinate->immovable_range[b_res_idx];
+
+			is_fixed = (fixed_res->start < fixed_res->end);
+		}
+
+		if (assign_fixed_resources == step && !is_fixed)
+			continue;
+		else if (assign_float_resources == step && is_fixed)
+			continue;
+
+		if (pci_assign_resource(dev_res->dev, idx)) {
 			if (fail_head) {
 				/*
 				 * If the failed resource is a ROM BAR and
@@ -1336,7 +1374,7 @@ void pci_bus_size_bridges(struct pci_bus *bus)
 }
 EXPORT_SYMBOL(pci_bus_size_bridges);
 
-static void assign_fixed_resource_on_bus(struct pci_bus *b, struct resource *r)
+int assign_fixed_resource_on_bus(struct pci_bus *b, struct resource *r)
 {
 	int i;
 	struct resource *parent_r;
@@ -1353,35 +1391,14 @@ static void assign_fixed_resource_on_bus(struct pci_bus *b, struct resource *r)
 		    !(r->flags & IORESOURCE_PREFETCH))
 			continue;
 
-		if (resource_contains(parent_r, r))
-			request_resource(parent_r, r);
-	}
-}
-
-/*
- * Try to assign any resources marked as IORESOURCE_PCI_FIXED, as they are
- * skipped by pbus_assign_resources_sorted().
- */
-static void pdev_assign_fixed_resources(struct pci_dev *dev)
-{
-	int i;
-
-	for (i = 0; i <  PCI_NUM_RESOURCES; i++) {
-		struct pci_bus *b;
-		struct resource *r = &dev->resource[i];
-
-		if (r->parent || !(r->flags & IORESOURCE_PCI_FIXED) ||
-		    !(r->flags & (IORESOURCE_IO | IORESOURCE_MEM)))
-			continue;
-
-		b = dev->bus;
-		while (b && !r->parent) {
-			assign_fixed_resource_on_bus(b, r);
-			b = b->parent;
-			if (!r->parent && pci_movable_bars_enabled())
-				break;
+		if (resource_contains(parent_r, r)) {
+			if (!request_resource(parent_r, r))
+				return 0;
 		}
 	}
+
+	dev_err(&b->dev, "failed to assign immovable %pR\n", r);
+	return -EBUSY;
 }
 
 void __pci_bus_assign_resources(const struct pci_bus *bus,
@@ -1397,8 +1414,6 @@ void __pci_bus_assign_resources(const struct pci_bus *bus,
 		if (!pci_dev_bars_enabled(dev))
 			continue;
 
-		pdev_assign_fixed_resources(dev);
-
 		b = dev->subordinate;
 		if (!b)
 			continue;
diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index 7357bcc12a53..02620cfac0c7 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -348,8 +348,12 @@ int pci_assign_resource(struct pci_dev *dev, int resno)
 	resource_size_t align, size;
 	int ret;
 
-	if (res->flags & IORESOURCE_PCI_FIXED)
-		return 0;
+	if ((res->flags & IORESOURCE_PCI_FIXED) ||
+	    (resno < PCI_BRIDGE_RESOURCES &&
+	     !pci_dev_movable_bars_supported(dev) &&
+	     res->start)) {
+		return assign_fixed_resource_on_bus(dev->bus, res);
+	}
 
 	res->flags |= IORESOURCE_UNSET;
 	align = pci_resource_alignment(dev, res);
-- 
2.21.0

