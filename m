Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD1D02DE871
	for <lists+linux-pci@lfdr.de>; Fri, 18 Dec 2020 18:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731531AbgLRRmg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Dec 2020 12:42:36 -0500
Received: from mta-02.yadro.com ([89.207.88.252]:38576 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732931AbgLRRmg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 18 Dec 2020 12:42:36 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 0E862413F1;
        Fri, 18 Dec 2020 17:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1608313274; x=1610127675; bh=T5Fkk6oGORAh4WFOfOZ1YgE9y1Rvi4Uvq20
        28GCRRg0=; b=o5hYLCXFf+ljRJ6t1316LkRkk6823PrjHubbKcn/haTl6GZFPSw
        aeTYXjRVuHgJ9+nWJ5gpDORz3W7YtoddnmUCY11EUGSG3WO0pCF/6EdI+Dsl+az2
        iHVyZwlacObKwDnhtpRIs4d+U83LTOrJBi38B5mCgnPF216FBmEKpp/M=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id chjP6ZLZcpyY; Fri, 18 Dec 2020 20:41:14 +0300 (MSK)
Received: from T-EXCH-03.corp.yadro.com (t-exch-03.corp.yadro.com [172.17.100.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 33290413B8;
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
Subject: [PATCH v9 12/26] PCI: Make sure bridge windows include their fixed BARs
Date:   Fri, 18 Dec 2020 20:39:57 +0300
Message-ID: <20201218174011.340514-13-s.miroshnichenko@yadro.com>
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

With enabled movable BARs, bridge windows are recalculated during each PCI
rescan. There may be fixed BARs below a bridge: these areas are represented
by the .fixed_range field in struct pci_bus.

When choosing a start address for a bridge window, it should be not just a
lowest possible address: this window must cover every underlying fixed BAR.

If a size of the bridge window is equal to its fixed range, it can only be
assigned to the start of this range. But if a bridge window size is larger,
its lowest possible address equals to (fixed_range.end - bus_size + 1).

Signed-off-by: Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
---
 drivers/pci/bus.c       |  2 +-
 drivers/pci/setup-res.c | 30 ++++++++++++++++++++++++++++--
 2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 3cef835b375f..c716210b62c5 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -192,7 +192,7 @@ static int pci_bus_alloc_from_region(struct pci_bus *bus, struct resource *res,
 		 * this is an already-configured bridge window, its start
 		 * overrides "min".
 		 */
-		if (avail.start)
+		if (min_used < avail.start)
 			min_used = avail.start;
 
 		max = avail.end;
diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index 432f3b084f94..ee192e731119 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -247,11 +247,27 @@ static int __pci_assign_resource(struct pci_bus *bus, struct pci_dev *dev,
 		int resno, resource_size_t size, resource_size_t align)
 {
 	struct resource *res = dev->resource + resno;
+	struct resource *fixed_range = NULL;
 	resource_size_t min;
 	int ret;
 
 	min = (res->flags & IORESOURCE_IO) ? PCIBIOS_MIN_IO : PCIBIOS_MIN_MEM;
 
+	if (pci_can_move_bars && dev->subordinate && resno >= PCI_BRIDGE_RESOURCES) {
+		struct pci_bus *child_bus = dev->subordinate;
+		int win_no = resno - PCI_BRIDGE_RESOURCES;
+
+		fixed_range = &child_bus->fixed_range[win_no];
+		if (pci_fixed_range_valid(fixed_range)) {
+			if (size <= resource_size(fixed_range))
+				min = fixed_range->start;
+			else
+				min = fixed_range->end - size + 1;
+		} else {
+			fixed_range = NULL;
+		}
+	}
+
 	/*
 	 * First, try exact prefetching match.  Even if a 64-bit
 	 * prefetchable bridge window is below 4GB, we can't put a 32-bit
@@ -263,7 +279,7 @@ static int __pci_assign_resource(struct pci_bus *bus, struct pci_dev *dev,
 				     IORESOURCE_PREFETCH | IORESOURCE_MEM_64,
 				     pcibios_align_resource, dev);
 	if (ret == 0)
-		return 0;
+		goto check_fixed;
 
 	/*
 	 * If the prefetchable window is only 32 bits wide, we can put
@@ -275,7 +291,7 @@ static int __pci_assign_resource(struct pci_bus *bus, struct pci_dev *dev,
 					     IORESOURCE_PREFETCH,
 					     pcibios_align_resource, dev);
 		if (ret == 0)
-			return 0;
+			goto check_fixed;
 	}
 
 	/*
@@ -288,6 +304,16 @@ static int __pci_assign_resource(struct pci_bus *bus, struct pci_dev *dev,
 		ret = pci_bus_alloc_resource(bus, res, size, align, min, 0,
 					     pcibios_align_resource, dev);
 
+check_fixed:
+	if (ret == 0 && fixed_range &&
+	    (res->start > fixed_range->start ||
+	     res->end < fixed_range->end)) {
+		dev_err(&bus->dev, "fixed area %pR for %s doesn't fit in the allocated %pR",
+			fixed_range, dev_name(&dev->dev), res);
+		release_resource(res);
+		return -1;
+	}
+
 	return ret;
 }
 
-- 
2.24.1

