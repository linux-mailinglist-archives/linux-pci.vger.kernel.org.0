Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 695D714CD52
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2020 16:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbgA2P3z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jan 2020 10:29:55 -0500
Received: from mta-02.yadro.com ([89.207.88.252]:55764 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726913AbgA2P3z (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Jan 2020 10:29:55 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 5849947616;
        Wed, 29 Jan 2020 15:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1580311793; x=1582126194; bh=UV+sluQbKW5VDEjIsRiyd0/sF1OCV3U61py
        PBRhBXus=; b=O7tFY6EaOxSd0Je8jvpeZbfzGL0y/dVdBwKRArDJbyqSeD4FnYe
        z4ykBfFKV0w4yiKurbY3n7TXGiXG02F5XST3ivTimS/6B+Ad/2RbblbsFI/MyuFU
        dr3bXAn8iT4EnrGJ2MLoPS8dPZvfvBHlNTnnrKfcH5i7d1gA06MX9tsY=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ocaUymSUS9Xf; Wed, 29 Jan 2020 18:29:53 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 0BEE547606;
        Wed, 29 Jan 2020 18:29:52 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.136) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Wed, 29
 Jan 2020 18:29:50 +0300
From:   Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>, Stefan Roese <sr@denx.de>,
        <linux@yadro.com>,
        Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH v7 04/26] PCI: Add version of release_child_resources() aware of immovable BARs
Date:   Wed, 29 Jan 2020 18:29:15 +0300
Message-ID: <20200129152937.311162-5-s.miroshnichenko@yadro.com>
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

When using the release_child_resources() to release a bridge window, it
drops the .start field of child's BARs to zero, but with the STARTALIGN
flag remaining set, which makes this resource invalid for re-assignment.

Immovable BARs must preserve their offset and size: those marked with the
PCI_FIXED or which are bound by drivers without support of the movable BARs
feature.

Add the pci_release_child_resources() to replace release_child_resources()
in handling the described PCI-specific cases.

Signed-off-by: Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
---
 drivers/pci/setup-bus.c | 54 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index f279826204eb..4c464430478f 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1500,6 +1500,54 @@ static void __pci_bridge_assign_resources(const struct pci_dev *bridge,
 	(IORESOURCE_IO | IORESOURCE_MEM | IORESOURCE_PREFETCH |\
 	 IORESOURCE_MEM_64)
 
+/*
+ * Similar to generic release_child_resources(), but aware of immovable BARs and
+ * PCI_FIXED and STARTALIGN flags
+ */
+static void pci_release_child_resources(struct pci_bus *bus, struct resource *r)
+{
+	struct pci_dev *dev;
+
+	if (!bus || !r)
+		return;
+
+	if (r->flags & IORESOURCE_PCI_FIXED)
+		return;
+
+	r->child = NULL;
+
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		int i;
+
+		for (i = 0; i < PCI_NUM_RESOURCES; i++) {
+			struct resource *tmp = &dev->resource[i];
+			resource_size_t size = resource_size(tmp);
+
+			if (!tmp->flags || tmp->parent != r)
+				continue;
+
+			tmp->parent = NULL;
+			tmp->sibling = NULL;
+
+			pci_release_child_resources(dev->subordinate, tmp);
+
+			tmp->flags &= ~IORESOURCE_STARTALIGN;
+			tmp->flags |= IORESOURCE_SIZEALIGN;
+
+			if (!pci_dev_bar_movable(dev, tmp)) {
+				pci_dbg(dev, "release immovable BAR %d %pR (%s), keep its flags, base and size\n",
+					i, tmp, tmp->name);
+				continue;
+			}
+
+			pci_dbg(dev, "release BAR %d %pR (%s)\n", i, tmp, tmp->name);
+
+			tmp->start = 0;
+			tmp->end = size - 1;
+		}
+	}
+}
+
 static void pci_bridge_release_resources(struct pci_bus *bus,
 					 unsigned long type)
 {
@@ -1540,7 +1588,11 @@ static void pci_bridge_release_resources(struct pci_bus *bus,
 		return;
 
 	/* If there are children, release them all */
-	release_child_resources(r);
+	if (pci_can_move_bars)
+		pci_release_child_resources(bus, r);
+	else
+		release_child_resources(r);
+
 	if (!release_resource(r)) {
 		type = old_flags = r->flags & PCI_RES_TYPE_MASK;
 		pci_info(dev, "resource %d %pR released\n",
-- 
2.24.1

