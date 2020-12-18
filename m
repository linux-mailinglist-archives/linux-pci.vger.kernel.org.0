Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13BFB2DE874
	for <lists+linux-pci@lfdr.de>; Fri, 18 Dec 2020 18:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732329AbgLRRmj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Dec 2020 12:42:39 -0500
Received: from mta-02.yadro.com ([89.207.88.252]:38582 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732968AbgLRRmj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 18 Dec 2020 12:42:39 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 567F7413FA;
        Fri, 18 Dec 2020 17:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1608313277; x=1610127678; bh=i1x3aD9KmgbJd+mdjxpBFj6MqGk6AnCXHtJ
        fYymmAU0=; b=Tt1uO8stbZOvI3Ac6OKYuXUgL0T+BffkP7nEvYUnGRrFI1ilK1R
        IijaQzLerFbRWJT7FRrII10+Pa82wiRM1ZFX69QCfZ9CaebWsy9Ospf6QfPjdNwU
        +2eFhLXFA64BOTBwNmQtpvinA2UXhqTwaEAu0P50Nfjrsv3ZXOsvccBI=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id OozqNllCgm_T; Fri, 18 Dec 2020 20:41:17 +0300 (MSK)
Received: from T-EXCH-03.corp.yadro.com (t-exch-03.corp.yadro.com [172.17.100.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id A1458413BD;
        Fri, 18 Dec 2020 20:41:08 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.136) by T-EXCH-03.corp.yadro.com
 (172.17.100.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Fri, 18
 Dec 2020 20:41:08 +0300
From:   Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Stefan Roese <sr@denx.de>, Andy Lavr <andy.lavr@gmail.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Rajat Jain <rajatja@google.com>, <linux@yadro.com>,
        Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH v9 14/26] PCI: hotplug: Sort fixed BARs before assignment
Date:   Fri, 18 Dec 2020 20:39:59 +0300
Message-ID: <20201218174011.340514-15-s.miroshnichenko@yadro.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201218174011.340514-1-s.miroshnichenko@yadro.com>
References: <20201218174011.340514-1-s.miroshnichenko@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.17.15.136]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-03.corp.yadro.com (172.17.100.103)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fixed BARs and bridge windows containing fixed BARs must be assigned before
the movable ones.

When assigning a fixed BAR/bridge window, its start address is chosen to be
the lowest possible. To prevent conflicts, sort such resources based on the
start address of their fixed areas.

Add support of fixed BARs and bridge windows to pdev_sort_resources().

Signed-off-by: Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
---
 drivers/pci/setup-bus.c | 63 +++++++++++++++++++++++++++++++++++------
 1 file changed, 54 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 6055f15e3ac3..ab58b999ac6d 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -126,7 +126,8 @@ static resource_size_t get_res_add_align(struct list_head *head,
 
 
 /* Sort resources by alignment */
-static void pdev_sort_resources(struct pci_dev *dev, struct list_head *head)
+static void pdev_sort_resources(struct pci_dev *dev, struct list_head *head,
+				struct list_head *head_fixed)
 {
 	int i;
 
@@ -135,17 +136,27 @@ static void pdev_sort_resources(struct pci_dev *dev, struct list_head *head)
 		struct pci_dev_resource *dev_res, *tmp;
 		resource_size_t r_align;
 		struct list_head *n;
+		struct resource *fixed_res = NULL;
 
 		r = &dev->resource[i];
 
-		if (r->flags & IORESOURCE_PCI_FIXED)
-			continue;
-
 		if (!(r->flags) || r->parent || !pci_dev_bar_enabled(dev, i))
 			continue;
 
+		if (i >= PCI_BRIDGE_RESOURCES &&
+		    dev->subordinate) {
+			int idx = i - PCI_BRIDGE_RESOURCES;
+
+			fixed_res = &dev->subordinate->fixed_range[idx];
+		} else if (pci_dev_bar_fixed(dev, r)) {
+			fixed_res = r;
+		}
+
+		if (fixed_res && !pci_fixed_range_valid(fixed_res))
+			fixed_res = NULL;
+
 		r_align = pci_resource_alignment(dev, r);
-		if (!r_align) {
+		if (!r_align && !fixed_res) {
 			pci_warn(dev, "BAR %d: %pR has bogus alignment\n",
 				 i, r);
 			continue;
@@ -157,6 +168,30 @@ static void pdev_sort_resources(struct pci_dev *dev, struct list_head *head)
 		tmp->res = r;
 		tmp->dev = dev;
 
+		if (fixed_res) {
+			n = head_fixed;
+			list_for_each_entry(dev_res, head_fixed, list) {
+				struct resource *c_fixed_res = NULL;
+				int c_resno = dev_res->res - dev_res->dev->resource;
+				int br_idx = c_resno - PCI_BRIDGE_RESOURCES;
+				struct pci_bus *cbus = dev_res->dev->subordinate;
+
+				if (br_idx >= 0)
+					c_fixed_res = &cbus->fixed_range[br_idx];
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
@@ -175,7 +210,8 @@ static void pdev_sort_resources(struct pci_dev *dev, struct list_head *head)
 	}
 }
 
-static void __dev_sort_resources(struct pci_dev *dev, struct list_head *head)
+static void __dev_sort_resources(struct pci_dev *dev, struct list_head *head,
+				 struct list_head *head_fixed)
 {
 	u16 class = dev->class >> 8;
 
@@ -191,7 +227,7 @@ static void __dev_sort_resources(struct pci_dev *dev, struct list_head *head)
 			return;
 	}
 
-	pdev_sort_resources(dev, head);
+	pdev_sort_resources(dev, head, head_fixed);
 }
 
 static inline void reset_resource(struct resource *res)
@@ -486,8 +522,13 @@ static void pdev_assign_resources_sorted(struct pci_dev *dev,
 					 struct list_head *fail_head)
 {
 	LIST_HEAD(head);
+	LIST_HEAD(head_fixed);
+
+	__dev_sort_resources(dev, &head, &head_fixed);
+
+	if (!list_empty(&head_fixed))
+		__assign_resources_sorted(&head_fixed, NULL, NULL);
 
-	__dev_sort_resources(dev, &head);
 	__assign_resources_sorted(&head, add_head, fail_head);
 
 }
@@ -498,9 +539,13 @@ static void pbus_assign_resources_sorted(const struct pci_bus *bus,
 {
 	struct pci_dev *dev;
 	LIST_HEAD(head);
+	LIST_HEAD(head_fixed);
 
 	list_for_each_entry(dev, &bus->devices, bus_list)
-		__dev_sort_resources(dev, &head);
+		__dev_sort_resources(dev, &head, &head_fixed);
+
+	if (!list_empty(&head_fixed))
+		__assign_resources_sorted(&head_fixed, NULL, NULL);
 
 	__assign_resources_sorted(&head, realloc_head, fail_head);
 }
-- 
2.24.1

