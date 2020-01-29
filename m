Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 155BA14CD60
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2020 16:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbgA2PaC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jan 2020 10:30:02 -0500
Received: from mta-02.yadro.com ([89.207.88.252]:55810 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727069AbgA2PaC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Jan 2020 10:30:02 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 5C86A47603;
        Wed, 29 Jan 2020 15:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1580311799; x=1582126200; bh=bmwN9fucNgOjss6M+KYp9Z9Ghaj3gIyZRpb
        zz/h1cq8=; b=lzAeexn5OMRtBgQdk1JNN+8Cli2iiUVucHTm73Z5HgYKCTWsJ1c
        zVPp95HdfMukTIxiTfFIQsVrZvS1h1gf3HnVmXBbzxVTWGHIkPF2SpmOBkj+/z90
        V3cdxbqmb3WeXparFOrE6++c1hkZtjln7IjgWd5KJOk/mM4vseo3eNZs=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id pdDiEaZEbkfT; Wed, 29 Jan 2020 18:29:59 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 0EAFA4760C;
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
Subject: [PATCH v7 12/26] PCI: Make sure bridge windows include their fixed BARs
Date:   Wed, 29 Jan 2020 18:29:23 +0300
Message-ID: <20200129152937.311162-13-s.miroshnichenko@yadro.com>
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

When choosing a start address for a bridge window, it should be not just a
lowest possible address: this window must cover every underlying immovable
BAR. The lowest address that satisfies this requirement is the
.realloc_range field of struct pci_bus.

After allocating a bridge window, validate that it covers all its immovable
BARs: this range is put to the .immovable_range field of struct pci_bus.

Signed-off-by: Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
---
 drivers/pci/bus.c       |  2 +-
 drivers/pci/setup-res.c | 31 +++++++++++++++++++++++++++++--
 2 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 8e40b3e6da77..a1efa87e31b9 100644
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
index 17c79057f517..3582ae68840b 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -248,9 +248,23 @@ static int __pci_assign_resource(struct pci_bus *bus, struct pci_dev *dev,
 	struct resource *res = dev->resource + resno;
 	resource_size_t min;
 	int ret;
+	resource_size_t start = (resource_size_t)-1;
+	resource_size_t end = 0;
 
 	min = (res->flags & IORESOURCE_IO) ? PCIBIOS_MIN_IO : PCIBIOS_MIN_MEM;
 
+	if (pci_can_move_bars && dev->subordinate && resno >= PCI_BRIDGE_RESOURCES) {
+		struct pci_bus *child_bus = dev->subordinate;
+		int b_resno = resno - PCI_BRIDGE_RESOURCES;
+		struct resource *immovable_range = &child_bus->immovable_range[b_resno];
+
+		if (immovable_range->start < immovable_range->end) {
+			start = immovable_range->start;
+			end = immovable_range->end;
+			min = child_bus->realloc_range[b_resno].start;
+		}
+	}
+
 	/*
 	 * First, try exact prefetching match.  Even if a 64-bit
 	 * prefetchable bridge window is below 4GB, we can't put a 32-bit
@@ -262,7 +276,7 @@ static int __pci_assign_resource(struct pci_bus *bus, struct pci_dev *dev,
 				     IORESOURCE_PREFETCH | IORESOURCE_MEM_64,
 				     pcibios_align_resource, dev);
 	if (ret == 0)
-		return 0;
+		goto check_fixed;
 
 	/*
 	 * If the prefetchable window is only 32 bits wide, we can put
@@ -274,7 +288,7 @@ static int __pci_assign_resource(struct pci_bus *bus, struct pci_dev *dev,
 					     IORESOURCE_PREFETCH,
 					     pcibios_align_resource, dev);
 		if (ret == 0)
-			return 0;
+			goto check_fixed;
 	}
 
 	/*
@@ -287,6 +301,19 @@ static int __pci_assign_resource(struct pci_bus *bus, struct pci_dev *dev,
 		ret = pci_bus_alloc_resource(bus, res, size, align, min, 0,
 					     pcibios_align_resource, dev);
 
+check_fixed:
+	if (pci_can_move_bars && ret == 0 && start < end) {
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
2.24.1

