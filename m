Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2799C14CD64
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2020 16:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbgA2PaD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jan 2020 10:30:03 -0500
Received: from mta-02.yadro.com ([89.207.88.252]:55828 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727089AbgA2PaC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Jan 2020 10:30:02 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 8F2B54760E;
        Wed, 29 Jan 2020 15:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1580311800; x=1582126201; bh=2yTzKg+TDE6N0Xk7XBl/HHmcLf+ovCl90d3
        fnsUpweM=; b=pVRfNt4ytmK4hw21P9wgws4GrHMaJpGc7mkPLOu/PXx51/StZtW
        Eq2PVRzIGFaHVOU7VRZfzE7O1n1Edfgcq9RYYidtUF0qFAgWi46AmebZPO3Ig4TL
        y8H+ryUmWTgPLpEY4tA2xUDiwB5i6UvlVAYRbr1IYuk5wbmbbxuePtsU=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1v0Et-47D0TQ; Wed, 29 Jan 2020 18:30:00 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 6F96447611;
        Wed, 29 Jan 2020 18:29:53 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.136) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Wed, 29
 Jan 2020 18:29:52 +0300
From:   Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>, Stefan Roese <sr@denx.de>,
        <linux@yadro.com>,
        Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH v7 14/26] PCI: hotplug: Sort immovable BARs before assignment
Date:   Wed, 29 Jan 2020 18:29:25 +0300
Message-ID: <20200129152937.311162-15-s.miroshnichenko@yadro.com>
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

Immovable BARs and bridge windows containing immovable BARs must be
assigned before the "usual" ones.

When assigning an immovable BAR/bridge window, its start address is chosen
to be the lowest possible. To prevent conflicts, sort such resources based
on the start address of their immovable areas.

Add support of immovable BARs and bridge windows to pdev_sort_resources().

Signed-off-by: Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
---
 drivers/pci/setup-bus.c | 66 +++++++++++++++++++++++++++++++++++------
 1 file changed, 57 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index cdbf4afe1334..573d5c67c136 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -122,9 +122,9 @@ static resource_size_t get_res_add_align(struct list_head *head,
 	return dev_res ? dev_res->min_align : 0;
 }
 
-
 /* Sort resources by alignment */
-static void pdev_sort_resources(struct pci_dev *dev, struct list_head *head)
+static void pdev_sort_resources(struct pci_dev *dev, struct list_head *head,
+				struct list_head *head_immovables)
 {
 	int i;
 
@@ -136,17 +136,31 @@ static void pdev_sort_resources(struct pci_dev *dev, struct list_head *head)
 		struct pci_dev_resource *dev_res, *tmp;
 		resource_size_t r_align;
 		struct list_head *n;
+		struct resource *fixed_res = NULL;
 
 		r = &dev->resource[i];
 
-		if (r->flags & IORESOURCE_PCI_FIXED)
+		if (!(r->flags) || r->parent)
 			continue;
 
-		if (!(r->flags) || r->parent)
+		if (pci_can_move_bars) {
+			if (i >= PCI_BRIDGE_RESOURCES &&
+			    dev->subordinate) {
+				int idx = i - PCI_BRIDGE_RESOURCES;
+
+				fixed_res = &dev->subordinate->immovable_range[idx];
+			} else if (!pci_dev_bar_movable(dev, r)) {
+				fixed_res = r;
+			}
+
+			if (fixed_res && fixed_res->start >= fixed_res->end)
+				fixed_res = NULL;
+		} else if (r->flags & IORESOURCE_PCI_FIXED) {
 			continue;
+		}
 
 		r_align = pci_resource_alignment(dev, r);
-		if (!r_align) {
+		if (!r_align && !fixed_res) {
 			pci_warn(dev, "BAR %d: %pR has bogus alignment\n",
 				 i, r);
 			continue;
@@ -158,6 +172,30 @@ static void pdev_sort_resources(struct pci_dev *dev, struct list_head *head)
 		tmp->res = r;
 		tmp->dev = dev;
 
+		if (fixed_res) {
+			n = head_immovables;
+			list_for_each_entry(dev_res, head_immovables, list) {
+				struct resource *c_fixed_res = NULL;
+				int c_resno = dev_res->res - dev_res->dev->resource;
+				int br_idx = c_resno - PCI_BRIDGE_RESOURCES;
+				struct pci_bus *cbus = dev_res->dev->subordinate;
+
+				if (br_idx >= 0)
+					c_fixed_res = &cbus->immovable_range[br_idx];
+				else
+					c_fixed_res = dev_res->res;
+
+				if (fixed_res->start < c_fixed_res->start) {
+					n = &dev_res->list;
+					break;
+				}
+			}
+			/* Insert it just before n */
+			list_add_tail(&tmp->list, n);
+
+			continue;
+		}
+
 		/* Fallback is smallest one or list is empty */
 		n = head;
 		list_for_each_entry(dev_res, head, list) {
@@ -176,7 +214,8 @@ static void pdev_sort_resources(struct pci_dev *dev, struct list_head *head)
 	}
 }
 
-static void __dev_sort_resources(struct pci_dev *dev, struct list_head *head)
+static void __dev_sort_resources(struct pci_dev *dev, struct list_head *head,
+				 struct list_head *head_immovables)
 {
 	u16 class = dev->class >> 8;
 
@@ -195,7 +234,7 @@ static void __dev_sort_resources(struct pci_dev *dev, struct list_head *head)
 			return;
 	}
 
-	pdev_sort_resources(dev, head);
+	pdev_sort_resources(dev, head, head_immovables);
 }
 
 static inline void reset_resource(struct resource *res)
@@ -493,8 +532,13 @@ static void pdev_assign_resources_sorted(struct pci_dev *dev,
 					 struct list_head *fail_head)
 {
 	LIST_HEAD(head);
+	LIST_HEAD(head_immovables);
+
+	__dev_sort_resources(dev, &head, &head_immovables);
+
+	if (!list_empty(&head_immovables))
+		__assign_resources_sorted(&head_immovables, NULL, NULL);
 
-	__dev_sort_resources(dev, &head);
 	__assign_resources_sorted(&head, add_head, fail_head);
 
 }
@@ -505,9 +549,13 @@ static void pbus_assign_resources_sorted(const struct pci_bus *bus,
 {
 	struct pci_dev *dev;
 	LIST_HEAD(head);
+	LIST_HEAD(head_immovables);
 
 	list_for_each_entry(dev, &bus->devices, bus_list)
-		__dev_sort_resources(dev, &head);
+		__dev_sort_resources(dev, &head, &head_immovables);
+
+	if (!list_empty(&head_immovables))
+		__assign_resources_sorted(&head_immovables, NULL, NULL);
 
 	__assign_resources_sorted(&head, realloc_head, fail_head);
 }
-- 
2.24.1

