Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A936F1E2CF2
	for <lists+linux-pci@lfdr.de>; Tue, 26 May 2020 21:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404295AbgEZTNb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 May 2020 15:13:31 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:45882 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404276AbgEZTNb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 May 2020 15:13:31 -0400
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.242.48])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id DA41E30D7C1;
        Tue, 26 May 2020 12:13:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com DA41E30D7C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1590520409;
        bh=I2huJ0KFkONce8j/+e+QRSy6cB3XNR9TsoPznvkU2Jw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fg2aAQz45xb5DAruU7sGQr1UidMxZfi/xtgoMr+VjKNVmXXSRQIFaytKVw8S/QZDd
         xZ2NlVPcT8LPV99VRTPmy7Xs4ce+tiGExlPw6two4bZZ5i5s5f62+e7qUx0zmaOr0f
         W/aHSXckNYniX3hxc9D2Qg1LfeTY+MgS3gQRVbqU=
Received: from stbsrv-and-01.and.broadcom.net (stbsrv-and-01.and.broadcom.net [10.28.16.211])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id A9E33140069;
        Tue, 26 May 2020 12:13:28 -0700 (PDT)
From:   Jim Quinlan <james.quinlan@broadcom.com>
To:     linux-pci@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 08/14] of: Include a dev param in of_dma_get_range()
Date:   Tue, 26 May 2020 15:12:47 -0400
Message-Id: <20200526191303.1492-9-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200526191303.1492-1-james.quinlan@broadcom.com>
References: <20200526191303.1492-1-james.quinlan@broadcom.com>
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
 3 files changed, 8 insertions(+), 6 deletions(-)

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
-- 
2.17.1

