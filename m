Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2BC860D901
	for <lists+linux-pci@lfdr.de>; Wed, 26 Oct 2022 03:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbiJZB7a (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Oct 2022 21:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbiJZB7Z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Oct 2022 21:59:25 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514FEB8E
        for <linux-pci@vger.kernel.org>; Tue, 25 Oct 2022 18:59:24 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29Q1xDsF062017;
        Tue, 25 Oct 2022 20:59:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666749553;
        bh=+DX3Io643NNp6wNGOrlHO1ZLqEwP3sqUj46EJgm6hlY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=yjdryqFdHL6ANrxsRPq97Qi6H48IPI2piTANAAP5HMc9timbj4934HK4dUz633Qax
         uU+HKof2SK5qOyrWlp5UYy85ZPnq2EOVBpWhwRUbnyyRr/DCUGP5aiQLTKpAYX2zmJ
         Ojh+GXjFXHddE8a2+LZ3DdBLuy2hV7x39p8axvws=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29Q1xDAB009917
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Oct 2022 20:59:13 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 25
 Oct 2022 20:59:12 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 25 Oct 2022 20:59:13 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29Q1x9GW040060;
        Tue, 25 Oct 2022 20:59:11 -0500
From:   Matt Ranostay <mranostay@ti.com>
To:     <vigneshr@ti.com>, <lpieralisi@kernel.org>, <robh@kernel.org>,
        <kw@linux.com>, <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Matt Ranostay <mranostay@ti.com>
Subject: [PATCH v4 2/3] PCI: j721e: Add PCIe 4x lane selection support
Date:   Tue, 25 Oct 2022 18:58:49 -0700
Message-ID: <20221026015850.591044-3-mranostay@ti.com>
X-Mailer: git-send-email 2.38.GIT
In-Reply-To: <20221026015850.591044-1-mranostay@ti.com>
References: <20221026015850.591044-1-mranostay@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support for setting of two-bit field that allows selection of 4x
lane PCIe which was previously limited to only 2x lanes.

Signed-off-by: Matt Ranostay <mranostay@ti.com>
---
 drivers/pci/controller/cadence/pci-j721e.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index 07151eb3518a..397e456af439 100644
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

