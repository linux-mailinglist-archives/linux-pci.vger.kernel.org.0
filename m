Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 700BA671DDA
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jan 2023 14:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjARNd0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Jan 2023 08:33:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbjARNc7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Jan 2023 08:32:59 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593FD58972;
        Wed, 18 Jan 2023 04:59:58 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 30ICxgYp018304;
        Wed, 18 Jan 2023 06:59:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1674046783;
        bh=TISRczCqqClgTnuh9Jgbp4YdFIC7Href1UTZ0gVUQ5I=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=HtmLhoiO7Kmq5E6oAlRzpG22Wi/dDRUW/IkIM5rR0Tc4g4CzTpq6vSCR69GICWEvh
         GEDkyMqCY/EpAQ+YFf4O+KIdBeEHvjZ+uTvDjg6v3qat3PnvdPVrfF+0KlMArS+gUv
         YSXtTqqXJJijq85Avd1RPztwfI/g1OZVxV3XAd/M=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 30ICxgBH033224
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 18 Jan 2023 06:59:42 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 18
 Jan 2023 06:59:42 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 18 Jan 2023 06:59:42 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 30ICxfBG003256;
        Wed, 18 Jan 2023 06:59:42 -0600
From:   Achal Verma <a-verma1@ti.com>
To:     <mranostay@ti.com>, <rogerq@kernel.org>, <lpieralisi@kernel.org>,
        <robh@kernel.org>, <kw@linux.com>, <bhelgaas@google.com>,
        <krzysztof.kozlowski@linaro.org>, <vigneshr@ti.com>,
        <tjoseph@cadence.com>, <sergio.paracuellos@gmail.com>,
        <pthombar@cadence.com>, <linux-pci@vger.kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v8 3/5] PCI: j721e: Add PCIe 4x lane selection support
Date:   Wed, 18 Jan 2023 18:29:34 +0530
Message-ID: <20230118125936.3456716-4-a-verma1@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230118125936.3456716-1-a-verma1@ti.com>
References: <20230118125936.3456716-1-a-verma1@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Matt Ranostay <mranostay@ti.com>

Add support for setting of two-bit field that allows selection of 4x lane
PCIe which was previously limited to only 2x lanes.

Signed-off-by: Matt Ranostay <mranostay@ti.com>
Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>
Reviewed-by: Roger Quadros <rogerq@kernel.org>
Signed-off-by: Achal Verma <a-verma1@ti.com>
---
 drivers/pci/controller/cadence/pci-j721e.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index f4dc2c5abedb..58dcac9021e4 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -42,7 +42,6 @@ enum link_status {
 };
 
 #define J721E_MODE_RC			BIT(7)
-#define LANE_COUNT_MASK			BIT(8)
 #define LANE_COUNT(n)			((n) << 8)
 
 #define GENERATION_SEL_MASK		GENMASK(1, 0)
@@ -52,6 +51,7 @@ struct j721e_pcie {
 	struct clk		*refclk;
 	u32			mode;
 	u32			num_lanes;
+	u32			max_lanes;
 	void __iomem		*user_cfg_base;
 	void __iomem		*intd_cfg_base;
 	u32			linkdown_irq_regfield;
@@ -205,11 +205,15 @@ static int j721e_pcie_set_lane_count(struct j721e_pcie *pcie,
 {
 	struct device *dev = pcie->cdns_pcie->dev;
 	u32 lanes = pcie->num_lanes;
+	u32 mask = BIT(8);
 	u32 val = 0;
 	int ret;
 
+	if (pcie->max_lanes == 4)
+		mask = GENMASK(9, 8);
+
 	val = LANE_COUNT(lanes - 1);
-	ret = regmap_update_bits(syscon, offset, LANE_COUNT_MASK, val);
+	ret = regmap_update_bits(syscon, offset, mask, val);
 	if (ret)
 		dev_err(dev, "failed to set link count\n");
 
@@ -441,7 +445,9 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 		dev_warn(dev, "num-lanes property not provided or invalid, setting num-lanes to 1\n");
 		num_lanes = 1;
 	}
+
 	pcie->num_lanes = num_lanes;
+	pcie->max_lanes = data->max_lanes;
 
 	if (dma_set_mask_and_coherent(dev, DMA_BIT_MASK(48)))
 		return -EINVAL;
-- 
2.25.1

