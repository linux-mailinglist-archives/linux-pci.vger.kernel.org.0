Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6059B622543
	for <lists+linux-pci@lfdr.de>; Wed,  9 Nov 2022 09:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiKII0T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Nov 2022 03:26:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiKII0S (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Nov 2022 03:26:18 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5562F13D16
        for <linux-pci@vger.kernel.org>; Wed,  9 Nov 2022 00:26:17 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2A98QAx5052768;
        Wed, 9 Nov 2022 02:26:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1667982370;
        bh=GHfym5VUelnLfwN2zUltoRzyF5Nvyun+NgNchnLJugs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=P5/+qh27IMS22b/nz/f8LLQuPaxrWTW6O/SW7U/+TGEevSFyHhLE7AM+lJzNE6YEF
         RYvEQ1hJhp/0E8R/I+qqgTlG2VxO1m7SYYP8Xb7Vce1xxB+3t+XXAT4EoHTpMZjXZw
         k1PZqY81NwkXWuYIy1V3TNOwFqzliILDLGV0s7r0=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2A98QAfP015991
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Nov 2022 02:26:10 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Wed, 9 Nov
 2022 02:26:10 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Wed, 9 Nov 2022 02:26:10 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2A98Q78m014421;
        Wed, 9 Nov 2022 02:26:09 -0600
From:   Matt Ranostay <mranostay@ti.com>
To:     <vigneshr@ti.com>, <lpieralisi@kernel.org>, <robh@kernel.org>,
        <kw@linux.com>, <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Matt Ranostay <mranostay@ti.com>
Subject: [PATCH v5 2/4] PCI: j721e: Add PCIe 4x lane selection support
Date:   Wed, 9 Nov 2022 00:25:54 -0800
Message-ID: <20221109082556.29265-3-mranostay@ti.com>
X-Mailer: git-send-email 2.38.GIT
In-Reply-To: <20221109082556.29265-1-mranostay@ti.com>
References: <20221109082556.29265-1-mranostay@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support for setting of two-bit field that allows selection of 4x
lane PCIe which was previously limited to only 2x lanes.

Signed-off-by: Matt Ranostay <mranostay@ti.com>
Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 drivers/pci/controller/cadence/pci-j721e.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index 875224d34958..efd065bc0104 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -43,7 +43,6 @@ enum link_status {
 };
 
 #define J721E_MODE_RC			BIT(7)
-#define LANE_COUNT_MASK			BIT(8)
 #define LANE_COUNT(n)			((n) << 8)
 
 #define GENERATION_SEL_MASK		GENMASK(1, 0)
@@ -53,6 +52,7 @@ struct j721e_pcie {
 	struct clk		*refclk;
 	u32			mode;
 	u32			num_lanes;
+	u32			max_lanes;
 	void __iomem		*user_cfg_base;
 	void __iomem		*intd_cfg_base;
 	u32			linkdown_irq_regfield;
@@ -206,11 +206,15 @@ static int j721e_pcie_set_lane_count(struct j721e_pcie *pcie,
 {
 	struct device *dev = pcie->cdns_pcie->dev;
 	u32 lanes = pcie->num_lanes;
+	u32 mask = GENMASK(8, 8);
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
 
@@ -440,6 +444,8 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 	ret = of_property_read_u32(node, "num-lanes", &num_lanes);
 	if (ret || num_lanes > data->max_lanes)
 		num_lanes = 1;
+
+	pcie->max_lanes = data->max_lanes;
 	pcie->num_lanes = num_lanes;
 
 	if (dma_set_mask_and_coherent(dev, DMA_BIT_MASK(48)))
-- 
2.38.GIT

