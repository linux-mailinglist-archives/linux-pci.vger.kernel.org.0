Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA90BFC51
	for <lists+linux-pci@lfdr.de>; Fri, 27 Sep 2019 02:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbfI0AZ3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Sep 2019 20:25:29 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40639 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727502AbfI0AZL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Sep 2019 20:25:11 -0400
Received: by mail-ot1-f65.google.com with SMTP id y39so772543ota.7;
        Thu, 26 Sep 2019 17:25:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+t0HPsSboHAO+BoQ/6wZRtvX50rdRybsdCc4k/BGGOU=;
        b=Y2hs8wibHQWRr9khsCPMVE7x/hYmz8VyFMKZ7nsDW7EIqQ7FLtWyycylbMydY2OFwx
         Pdys6HOTJedGiOWVIt1qrvcRZniQPMhkminsdr3hZF0IOJ09Tc42bo7be1VJn0Co5eUX
         pWRbgyP/b4IUJWS92vjTzh0ubYwn/c4EN87ALJWhSeAFKTYV1rPEEBhDZkFCigjCAKLq
         BxApUizG0eaTvxc8xGbRKee0L5Xb0b7rZbcag6mWLMIY9O7fSZBw4m00kNdJ9pgOAIOD
         PvtYZE3xsca4YaRzP5yQh2XBW74ebhCI9kq5c55PPAfg5fo0kc4QaqjrMBqikEZsk0Te
         BT7A==
X-Gm-Message-State: APjAAAWMH2ouL60j8rvfksR3DOLTw5q4EsclXPIgapS167oZhIn2X4um
        pm6eqnyUsRrgBl1uV3nvNv22SCY=
X-Google-Smtp-Source: APXvYqwlqui2UKuMtp8r6la4AcjByFeStlouN8pLtfIFhhyhtZVP8xij2Q0PurThyDu0Z4XEh1j7IQ==
X-Received: by 2002:a05:6830:4a5:: with SMTP id l5mr991746otd.150.1569543910071;
        Thu, 26 Sep 2019 17:25:10 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id j11sm339866otk.80.2019.09.26.17.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 17:25:09 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Stefan Wahren <wahrenst@gmx.net>,
        Frank Rowand <frowand.list@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Marek Vasut <marek.vasut@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Oza Pawandeep <oza.oza@broadcom.com>
Subject: [PATCH 09/11] of: Make of_dma_get_range() work on bus nodes
Date:   Thu, 26 Sep 2019 19:24:53 -0500
Message-Id: <20190927002455.13169-10-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190927002455.13169-1-robh@kernel.org>
References: <20190927002455.13169-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Robin Murphy <robin.murphy@arm.com>

Since the "dma-ranges" property is only valid for a node representing a
bus, of_dma_get_range() currently assumes the node passed in is a leaf
representing a device, and starts the walk from its parent. In cases
like PCI host controllers on typical FDT systems, however, where the PCI
endpoints are probed dynamically the initial leaf node represents the
'bus' itself, and this logic means we fail to consider any "dma-ranges"
describing the host bridge itself. Rework the logic such that
of_dma_get_range() works correctly starting from a bus node containing
"dma-ranges".

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
[robh: Allow for the bus child node to still be passed in]
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/of/address.c | 24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 887c0413f648..e918001c7798 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -922,18 +922,9 @@ int of_dma_get_range(struct device_node *np, u64 *dma_addr, u64 *paddr, u64 *siz
 	if (!node)
 		return -EINVAL;
 
-	while (1) {
-		struct device_node *parent;
-
-		naddr = of_n_addr_cells(node);
-		nsize = of_n_size_cells(node);
-
-		parent = __of_get_dma_parent(node);
-		of_node_put(node);
-
-		node = parent;
-		if (!node)
-			break;
+	while (node) {
+		naddr = of_bus_n_addr_cells(node);
+		nsize = of_bus_n_size_cells(node);
 
 		ranges = of_get_property(node, "dma-ranges", &len);
 
@@ -941,12 +932,7 @@ int of_dma_get_range(struct device_node *np, u64 *dma_addr, u64 *paddr, u64 *siz
 		if (ranges && len > 0)
 			break;
 
-		/*
-		 * At least empty ranges has to be defined for parent node if
-		 * DMA is supported
-		 */
-		if (!ranges)
-			break;
+		node = of_get_next_dma_parent(node);
 	}
 
 	if (!ranges) {
@@ -965,7 +951,7 @@ int of_dma_get_range(struct device_node *np, u64 *dma_addr, u64 *paddr, u64 *siz
 	 * size		: nsize cells
 	 */
 	dmaaddr = of_read_number(ranges, naddr);
-	*paddr = of_translate_dma_address(np, ranges);
+	*paddr = of_translate_dma_address(node, ranges + naddr);
 	if (*paddr == OF_BAD_ADDR) {
 		pr_err("translation of DMA address(%llx) to CPU address failed node(%pOF)\n",
 		       dmaaddr, np);
-- 
2.20.1

