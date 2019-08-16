Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42EC590622
	for <lists+linux-pci@lfdr.de>; Fri, 16 Aug 2019 18:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbfHPQvU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Aug 2019 12:51:20 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:51416 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727067AbfHPQvU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 16 Aug 2019 12:51:20 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 3352C412D2;
        Fri, 16 Aug 2019 16:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1565974277; x=1567788678; bh=swwKzQYGh9YSSjQQfhDacDugfFrMT6V0xQl
        ayHGhLMw=; b=tEvbMbHo+vJYvoS97X4u15tA+W0IFZxYzEz5GUvf/BYDZ4wyVJb
        G1DcqLtO8NBU9pkOion1dtKh3GFIUqryJxjf7lMRlwRy9Uv+Av+NzkW98zAUwlZ9
        QR1Nc+rJzDlVRCeqO9UzG75dSwGdvvQ1CZN09RFzr3ILg+Che4mpgiSw=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id N864T8qmIiN1; Fri, 16 Aug 2019 19:51:17 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 8CE8042ED9;
        Fri, 16 Aug 2019 19:51:11 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.60) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Fri, 16
 Aug 2019 19:51:11 +0300
From:   Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>, <linux@yadro.com>,
        Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH v5 13/23] PCI: Make sure bridge windows include their fixed BARs
Date:   Fri, 16 Aug 2019 19:50:51 +0300
Message-ID: <20190816165101.911-14-s.miroshnichenko@yadro.com>
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

When the time comes to select a start address for the bridge window during
the root bus rescan, it should be not just a lowest possible address: this
window must cover all the underlying fixed and immovable BARs. The lowest
address that satisfies this requirement is the .realloc_range field of
struct pci_bus, which is calculated during the preparation to the rescan.

Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
---
 drivers/pci/bus.c       |  2 +-
 drivers/pci/setup-res.c | 28 ++++++++++++++++++++++++++--
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 495059d923f7..7aae830751e9 100644
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
index 732d18f60f1b..7357bcc12a53 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -248,9 +248,20 @@ static int __pci_assign_resource(struct pci_bus *bus, struct pci_dev *dev,
 	struct resource *res = dev->resource + resno;
 	resource_size_t min;
 	int ret;
+	resource_size_t start = (resource_size_t)-1;
+	resource_size_t end = 0;
 
 	min = (res->flags & IORESOURCE_IO) ? PCIBIOS_MIN_IO : PCIBIOS_MIN_MEM;
 
+	if (dev->subordinate && resno >= PCI_BRIDGE_RESOURCES) {
+		struct pci_bus *child_bus = dev->subordinate;
+		int b_resno = resno - PCI_BRIDGE_RESOURCES;
+		struct resource *immovable_range = &child_bus->immovable_range[b_resno];
+
+		if (immovable_range->start < immovable_range->end)
+			min = child_bus->realloc_range[b_resno].start;
+	}
+
 	/*
 	 * First, try exact prefetching match.  Even if a 64-bit
 	 * prefetchable bridge window is below 4GB, we can't put a 32-bit
@@ -262,7 +273,7 @@ static int __pci_assign_resource(struct pci_bus *bus, struct pci_dev *dev,
 				     IORESOURCE_PREFETCH | IORESOURCE_MEM_64,
 				     pcibios_align_resource, dev);
 	if (ret == 0)
-		return 0;
+		goto check_fixed;
 
 	/*
 	 * If the prefetchable window is only 32 bits wide, we can put
@@ -274,7 +285,7 @@ static int __pci_assign_resource(struct pci_bus *bus, struct pci_dev *dev,
 					     IORESOURCE_PREFETCH,
 					     pcibios_align_resource, dev);
 		if (ret == 0)
-			return 0;
+			goto check_fixed;
 	}
 
 	/*
@@ -287,6 +298,19 @@ static int __pci_assign_resource(struct pci_bus *bus, struct pci_dev *dev,
 		ret = pci_bus_alloc_resource(bus, res, size, align, min, 0,
 					     pcibios_align_resource, dev);
 
+check_fixed:
+	if (ret == 0 && start < end) {
+		if (res->start > start || res->end < end) {
+			dev_err(&bus->dev, "fixed area 0x%llx-0x%llx for %s doesn't fit in the allocated %pR (0x%llx-0x%llx)",
+				(unsigned long long)start, (unsigned long long)end,
+				dev_name(&dev->dev),
+				res, (unsigned long long)res->start,
+				(unsigned long long)res->end);
+			release_resource(res);
+			return -1;
+		}
+	}
+
 	return ret;
 }
 
-- 
2.21.0

