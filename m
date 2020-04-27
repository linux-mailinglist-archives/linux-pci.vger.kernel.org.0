Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5957D1BAC7A
	for <lists+linux-pci@lfdr.de>; Mon, 27 Apr 2020 20:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbgD0SY0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Apr 2020 14:24:26 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:53000 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726229AbgD0SYZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Apr 2020 14:24:25 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 9070C4C864;
        Mon, 27 Apr 2020 18:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1588011861; x=1589826262; bh=8eyQL6vDDUn17/3HbKk626u2vpkCtL89siu
        lJ0s9imk=; b=F99n/rz+8+0au76bETkiHjNOyN1Jwkm+ohwx3LxqjSXqDakMZBd
        rKqwTfXh0AspyPRFIYjBjSN52lX0xbbZwCxg058nBdXeDegffnG1+3B3lML9DB3B
        lTPf/zsSWnuJZQkMJpKl/bxhdZTSpP+bb44E9WnUh7H2VVxyCjjG8XfY=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Llkzu59nEboG; Mon, 27 Apr 2020 21:24:21 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 014FB4C847;
        Mon, 27 Apr 2020 21:24:12 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.136) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Mon, 27
 Apr 2020 21:24:13 +0300
From:   Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Stefan Roese <sr@denx.de>, Andy Lavr <andy.lavr@gmail.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        David Laight <David.Laight@ACULAB.COM>,
        Rajat Jain <rajatja@google.com>, <linux@yadro.com>,
        Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH v8 15/24] PCI: hotplug: Sort fixed BARs before assignment
Date:   Mon, 27 Apr 2020 21:23:49 +0300
Message-ID: <20200427182358.2067702-16-s.miroshnichenko@yadro.com>
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
index 1f76a4dffb7d..4cadfa1f9519 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -124,7 +124,8 @@ static resource_size_t get_res_add_align(struct list_head *head,
 
 
 /* Sort resources by alignment */
-static void pdev_sort_resources(struct pci_dev *dev, struct list_head *head)
+static void pdev_sort_resources(struct pci_dev *dev, struct list_head *head,
+				struct list_head *head_fixed)
 {
 	int i;
 
@@ -133,17 +134,27 @@ static void pdev_sort_resources(struct pci_dev *dev, struct list_head *head)
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
@@ -155,6 +166,30 @@ static void pdev_sort_resources(struct pci_dev *dev, struct list_head *head)
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
@@ -173,7 +208,8 @@ static void pdev_sort_resources(struct pci_dev *dev, struct list_head *head)
 	}
 }
 
-static void __dev_sort_resources(struct pci_dev *dev, struct list_head *head)
+static void __dev_sort_resources(struct pci_dev *dev, struct list_head *head,
+				 struct list_head *head_fixed)
 {
 	u16 class = dev->class >> 8;
 
@@ -189,7 +225,7 @@ static void __dev_sort_resources(struct pci_dev *dev, struct list_head *head)
 			return;
 	}
 
-	pdev_sort_resources(dev, head);
+	pdev_sort_resources(dev, head, head_fixed);
 }
 
 static inline void reset_resource(struct resource *res)
@@ -484,8 +520,13 @@ static void pdev_assign_resources_sorted(struct pci_dev *dev,
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
@@ -496,9 +537,13 @@ static void pbus_assign_resources_sorted(const struct pci_bus *bus,
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

