Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC012DE873
	for <lists+linux-pci@lfdr.de>; Fri, 18 Dec 2020 18:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728319AbgLRRmh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Dec 2020 12:42:37 -0500
Received: from mta-02.yadro.com ([89.207.88.252]:38580 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732985AbgLRRmh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 18 Dec 2020 12:42:37 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 06245413F6;
        Fri, 18 Dec 2020 17:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1608313275; x=1610127676; bh=fyaAplP259bXMQg284z40tJLExuGU1ZfPpZ
        M2BWBDGw=; b=pVeDUE///2lfgHAFE31d2AK5U55CkLtziYACr4BVUx9t8UcLMF+
        qwyjQnu+TxXMB5LH++XT52GKhkNzElUHVuXTL6Z1MozEY+uHt0lwatyMOpLrahDU
        Pje7HKWRW1XRNDNvgUMPn8dr8QfET8B8+Aw405jZFUXOPlUEVzENIuFo=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zt-7b6M5sz3i; Fri, 18 Dec 2020 20:41:15 +0300 (MSK)
Received: from T-EXCH-03.corp.yadro.com (t-exch-03.corp.yadro.com [172.17.100.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 6773441385;
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
Subject: [PATCH v9 13/26] PCI: hotplug: Add support of fixed BARs to pci_assign_resource()
Date:   Fri, 18 Dec 2020 20:39:58 +0300
Message-ID: <20201218174011.340514-14-s.miroshnichenko@yadro.com>
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

Fixed BARs must be assigned within a bridge window first, before movable
BARs and neighboring bridge windows. Currently they are assigned last by
pdev_assign_fixed_resources().

Let the fixed BARs be handled by pci_assign_resource() in the same way as
it does for movable ones, assigning them in correct order, unifying the
code.

Allow matching IORESOURCE_PCI_FIXED prefetchable BARs to non-prefetchable
windows, so they follow the same rules as non-flagged fixed BARs.

Signed-off-by: Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
---
 drivers/pci/setup-bus.c | 43 -----------------------------------------
 drivers/pci/setup-res.c | 41 +++++++++++++++++++++++++++++++++++++--
 2 files changed, 39 insertions(+), 45 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 3dadadea10d6..6055f15e3ac3 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1358,47 +1358,6 @@ void pci_bus_size_bridges(struct pci_bus *bus)
 }
 EXPORT_SYMBOL(pci_bus_size_bridges);
 
-static void assign_fixed_resource_on_bus(struct pci_bus *b, struct resource *r)
-{
-	int i;
-	struct resource *parent_r;
-	unsigned long mask = IORESOURCE_IO | IORESOURCE_MEM |
-			     IORESOURCE_PREFETCH;
-
-	pci_bus_for_each_resource(b, parent_r, i) {
-		if (!parent_r)
-			continue;
-
-		if ((r->flags & mask) == (parent_r->flags & mask) &&
-		    resource_contains(parent_r, r))
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
-		}
-	}
-}
-
 void __pci_bus_assign_resources(const struct pci_bus *bus,
 				struct list_head *realloc_head,
 				struct list_head *fail_head)
@@ -1409,8 +1368,6 @@ void __pci_bus_assign_resources(const struct pci_bus *bus,
 	pbus_assign_resources_sorted(bus, realloc_head, fail_head);
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
-		pdev_assign_fixed_resources(dev);
-
 		b = dev->subordinate;
 		if (!b)
 			continue;
diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index ee192e731119..6ffda8b94c52 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -333,14 +333,51 @@ static int _pci_assign_resource(struct pci_dev *dev, int resno,
 	return ret;
 }
 
+static int assign_fixed_resource_on_bus(struct pci_dev *dev, int resno)
+{
+	int i;
+	struct resource *parent_r;
+	unsigned long mask = IORESOURCE_TYPE_BITS;
+	struct resource *r = dev->resource + resno;
+
+	/*
+	 * If we have a shadow copy in RAM, the PCI device doesn't respond
+	 * to the shadow range
+	 */
+	if (r->flags & IORESOURCE_ROM_SHADOW)
+		return 0;
+
+	pci_bus_for_each_resource(dev->bus, parent_r, i) {
+		if (!parent_r)
+			continue;
+
+		if ((r->flags & mask) != (parent_r->flags & mask))
+			continue;
+
+		if (parent_r->flags & IORESOURCE_PREFETCH &&
+		    !(r->flags & IORESOURCE_PREFETCH))
+			continue;
+
+		if (resource_contains(parent_r, r)) {
+			if (!request_resource(parent_r, r)) {
+				pci_info(dev, "BAR %d: assigned fixed %pR\n", resno, r);
+				return 0;
+			}
+		}
+	}
+
+	pci_err(dev, "BAR %d: failed to assign fixed %pR\n", resno, r);
+	return -ENOSPC;
+}
+
 int pci_assign_resource(struct pci_dev *dev, int resno)
 {
 	struct resource *res = dev->resource + resno;
 	resource_size_t align, size;
 	int ret;
 
-	if (res->flags & IORESOURCE_PCI_FIXED)
-		return 0;
+	if (res->flags && pci_dev_bar_fixed(dev, res))
+		return assign_fixed_resource_on_bus(dev, resno);
 
 	res->flags |= IORESOURCE_UNSET;
 	align = pci_resource_alignment(dev, res);
-- 
2.24.1

