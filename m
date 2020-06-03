Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD5041ED6AE
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jun 2020 21:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgFCTVc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Jun 2020 15:21:32 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:43188 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726365AbgFCTVa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Jun 2020 15:21:30 -0400
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.242.48])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id 6EFEB30DED1;
        Wed,  3 Jun 2020 12:21:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com 6EFEB30DED1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1591212088;
        bh=SQNKzCK4mr62bKG2SrKfDfRn2h9ZIykztTMQ5vnyIw8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RPD7B4cGXC+aKMwmZCs4ZGQx0EzCjQr5l9Kx3NHB2hGVvQcOvqND0S+35gnyHMLTR
         Yix4RPo5PH7r/XG9Sb35nyRNRB4ZOZJc5nE+UqwjkxOidESznufxsgfh/YNARBGpSt
         ubJNEQjC2Kw2Lix2moqZK5b/+1rc5vbwEDJZI7Ao=
Received: from stbsrv-and-01.and.broadcom.net (stbsrv-and-01.and.broadcom.net [10.28.16.211])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id 2BEFA140069;
        Wed,  3 Jun 2020 12:21:27 -0700 (PDT)
From:   Jim Quinlan <james.quinlan@broadcom.com>
To:     linux-pci@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 08/13] of: Include a dev param in of_dma_get_range()
Date:   Wed,  3 Jun 2020 15:20:40 -0400
Message-Id: <20200603192058.35296-9-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200603192058.35296-1-james.quinlan@broadcom.com>
References: <20200603192058.35296-1-james.quinlan@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently there is only one caller of of_dma_get_range().  A struct device
*dev param is needed For implementing multiple dma offsets.  This function
will still work if dev == NULL.

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
---
 drivers/of/address.c    | 4 +++-
 drivers/of/device.c     | 2 +-
 drivers/of/of_private.h | 8 ++++----
 drivers/of/unittest.c   | 2 +-
 4 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 8eea3f6e29a4..96d8cfb14a60 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -920,6 +920,7 @@ EXPORT_SYMBOL(of_io_request_and_map);
 
 /**
  * of_dma_get_range - Get DMA range info
+ * @dev:	device pointer; only needed for a corner case.
  * @np:		device node to get DMA range info
  * @dma_addr:	pointer to store initial DMA address of DMA range
  * @paddr:	pointer to store initial CPU address of DMA range
@@ -935,7 +936,8 @@ EXPORT_SYMBOL(of_io_request_and_map);
  * It returns -ENODEV if "dma-ranges" property was not found
  * for this device in DT.
  */
-int of_dma_get_range(struct device_node *np, u64 *dma_addr, u64 *paddr, u64 *size)
+int of_dma_get_range(struct device *dev, struct device_node *np, u64 *dma_addr,
+		     u64 *paddr, u64 *size)
 {
 	struct device_node *node = of_node_get(np);
 	const __be32 *ranges = NULL;
diff --git a/drivers/of/device.c b/drivers/of/device.c
index 27203bfd0b22..ef6a741f9f0b 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -95,7 +95,7 @@ int of_dma_configure(struct device *dev, struct device_node *np, bool force_dma)
 	const struct iommu_ops *iommu;
 	u64 mask, end;
 
-	ret = of_dma_get_range(np, &dma_addr, &paddr, &size);
+	ret = of_dma_get_range(dev, np, &dma_addr, &paddr, &size);
 	if (ret < 0) {
 		/*
 		 * For legacy reasons, we have to assume some devices need
diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index edc682249c00..7a83d3a81ab6 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -158,11 +158,11 @@ extern int of_bus_n_addr_cells(struct device_node *np);
 extern int of_bus_n_size_cells(struct device_node *np);
 
 #ifdef CONFIG_OF_ADDRESS
-extern int of_dma_get_range(struct device_node *np, u64 *dma_addr,
-			    u64 *paddr, u64 *size);
+extern int of_dma_get_range(struct device *dev, struct device_node *np,
+			    u64 *dma_addr, u64 *paddr, u64 *size);
 #else
-static inline int of_dma_get_range(struct device_node *np, u64 *dma_addr,
-				   u64 *paddr, u64 *size)
+static inline int of_dma_get_range(struct device *dev, struct device_node *np,
+				   u64 *dma_addr, u64 *paddr, u64 *size)
 {
 	return -ENODEV;
 }
diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 398de04fd19c..57a22517c428 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -881,7 +881,7 @@ static void __init of_unittest_dma_ranges_one(const char *path,
 		return;
 	}
 
-	rc = of_dma_get_range(np, &dma_addr, &paddr, &size);
+	rc = of_dma_get_range(NULL, np, &dma_addr, &paddr, &size);
 
 	unittest(!rc, "of_dma_get_range failed on node %pOF rc=%i\n", np, rc);
 	if (!rc) {
-- 
2.17.1

