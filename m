Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9867814CD62
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2020 16:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbgA2PaD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jan 2020 10:30:03 -0500
Received: from mta-02.yadro.com ([89.207.88.252]:55796 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727077AbgA2PaC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Jan 2020 10:30:02 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 1E5B54762B;
        Wed, 29 Jan 2020 15:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1580311799; x=1582126200; bh=C47aqFnigDF5PDyzO6/Lpy6uwW+MgjBh1/M
        SfttIRBc=; b=g7WOw6jJIZtp+aSUnL011b4sCehSvbBah5AppzuJ5CnKmID6VuB
        tWzWaq1PVe8XN9ay/N/XDaO9+//l3S5vk4q1iDFbXoqWvBfAypOsI5lTg2/dUWkC
        YccmwyUxXDco4Rwr/D7nCtHHurMmeB/VlbWTX1e2dTDN4WGF2ZNUbx6o=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id gtXl5HZZe5JH; Wed, 29 Jan 2020 18:29:59 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 3A39A47604;
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
Subject: [PATCH v7 13/26] PCI: hotplug: Add support of immovable BARs to pci_assign_resource()
Date:   Wed, 29 Jan 2020 18:29:24 +0300
Message-ID: <20200129152937.311162-14-s.miroshnichenko@yadro.com>
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

The PCI_FIXED and other immovable BARs must be assigned after the bridge
windows of parent bridge and before "usual" BARs, but currently they are
assigned the last by the pdev_assign_fixed_resources().

Let the immovable BARs be handled by pci_assign_resource() in the same way
as it does for movable ones, assigning them in correct order, unifying the
code.

Allow matching IORESOURCE_PCI_FIXED prefetchable BARs to non-prefetchable
windows, so they follow the same rules as immovable BARs.

Signed-off-by: Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
---
 drivers/pci/pci.h       |  2 ++
 drivers/pci/setup-bus.c | 25 ++++++++++++++++++-------
 drivers/pci/setup-res.c |  5 ++++-
 3 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index ddd6fd33f9c3..3ffbee2c3243 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -293,6 +293,8 @@ void pci_bus_put(struct pci_bus *bus);
 bool pci_dev_bar_movable(struct pci_dev *dev, struct resource *res);
 void pci_bus_update_realloc_range(struct pci_bus *bus);
 
+int assign_fixed_resource_on_bus(struct pci_bus *b, struct resource *r);
+
 /* PCIe link information */
 #define PCIE_SPEED2STR(speed) \
 	((speed) == PCIE_SPEED_16_0GT ? "16 GT/s" : \
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 71babb968830..cdbf4afe1334 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1356,21 +1356,31 @@ void pci_bus_size_bridges(struct pci_bus *bus)
 }
 EXPORT_SYMBOL(pci_bus_size_bridges);
 
-static void assign_fixed_resource_on_bus(struct pci_bus *b, struct resource *r)
+int assign_fixed_resource_on_bus(struct pci_bus *b, struct resource *r)
 {
 	int i;
 	struct resource *parent_r;
-	unsigned long mask = IORESOURCE_IO | IORESOURCE_MEM |
-			     IORESOURCE_PREFETCH;
+	unsigned long mask = IORESOURCE_TYPE_BITS;
 
 	pci_bus_for_each_resource(b, parent_r, i) {
 		if (!parent_r)
 			continue;
 
-		if ((r->flags & mask) == (parent_r->flags & mask) &&
-		    resource_contains(parent_r, r))
-			request_resource(parent_r, r);
+		if ((r->flags & mask) != (parent_r->flags & mask))
+			continue;
+
+		if (parent_r->flags & IORESOURCE_PREFETCH &&
+		    !(r->flags & IORESOURCE_PREFETCH))
+			continue;
+
+		if (resource_contains(parent_r, r)) {
+			if (!request_resource(parent_r, r))
+				return 0;
+		}
 	}
+
+	dev_err(&b->dev, "failed to assign immovable %pR\n", r);
+	return -EBUSY;
 }
 
 /*
@@ -1410,7 +1420,8 @@ void __pci_bus_assign_resources(const struct pci_bus *bus,
 		if (!pci_dev_bars_enabled(dev))
 			continue;
 
-		pdev_assign_fixed_resources(dev);
+		if (!pci_can_move_bars)
+			pdev_assign_fixed_resources(dev);
 
 		b = dev->subordinate;
 		if (!b)
diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index 3582ae68840b..a7d81816d1ea 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -339,7 +339,10 @@ int pci_assign_resource(struct pci_dev *dev, int resno)
 	resource_size_t align, size;
 	int ret;
 
-	if (res->flags & IORESOURCE_PCI_FIXED)
+	if (pci_can_move_bars && !pci_dev_bar_movable(dev, res) &&
+	    resno < PCI_ROM_RESOURCE && res->start)
+		return assign_fixed_resource_on_bus(dev->bus, res);
+	else if (!pci_can_move_bars && res->flags & IORESOURCE_PCI_FIXED)
 		return 0;
 
 	res->flags |= IORESOURCE_UNSET;
-- 
2.24.1

