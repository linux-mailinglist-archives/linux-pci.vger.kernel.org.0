Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 875666BE22B
	for <lists+linux-pci@lfdr.de>; Fri, 17 Mar 2023 08:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjCQHvm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Mar 2023 03:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbjCQHvj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Mar 2023 03:51:39 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E541895BC0;
        Fri, 17 Mar 2023 00:51:36 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32H7pPV2070599;
        Fri, 17 Mar 2023 02:51:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1679039485;
        bh=6txK6JhGNmC1mVhE7nu+ujxZBb0FV1uO3fUqV2jp4bY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=yIhRUIOQcHjPy39oy19pBQGPlewS3A0K5b2ERpEF3fKYfl8YpfPE0f3K16sCliQrj
         +9y9bqJfLzqQL8w+o5yLhDdMYwc7ac5Vnx7VvyrNZjl7rpll2D5imZBg6gfsIPAG+H
         i5ZOvT9HU0Ryh5l7ofCTQE7C5iGQyUuAIwNKVNaA=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32H7pPPc119557
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 17 Mar 2023 02:51:25 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Fri, 17
 Mar 2023 02:51:24 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Fri, 17 Mar 2023 02:51:24 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32H7pOdq058405;
        Fri, 17 Mar 2023 02:51:24 -0500
From:   Achal Verma <a-verma1@ti.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Wilczy_ski <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Dhananjay Vilasrao Kangude <dkangude@cadence.com>,
        Anindita Das <dasa@cadence.com>,
        Yuan Zhao <yuanzhao@cadence.com>,
        Milind Parab <mparab@cadence.com>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Achal Verma <a-verma1@ti.com>
Subject: [PATCH v11 2/5] PCI: j721e: Add per platform maximum lane settings
Date:   Fri, 17 Mar 2023 13:21:17 +0530
Message-ID: <20230317075120.506267-3-a-verma1@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230317075120.506267-1-a-verma1@ti.com>
References: <20230317075120.506267-1-a-verma1@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Matt Ranostay <mranostay@ti.com>

Various platforms have different maximum amount of lanes that can be
selected. Add max_lanes to struct j721e_pcie to allow for detection of this
which is needed to calculate the needed bitmask size for the possible lane
count.

Signed-off-by: Matt Ranostay <mranostay@ti.com>
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Achal Verma <a-verma1@ti.com>
---
 drivers/pci/controller/cadence/pci-j721e.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index cc83a8925ce0..f4dc2c5abedb 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -47,8 +47,6 @@ enum link_status {
 
 #define GENERATION_SEL_MASK		GENMASK(1, 0)
 
-#define MAX_LANES			2
-
 struct j721e_pcie {
 	struct cdns_pcie	*cdns_pcie;
 	struct clk		*refclk;
@@ -71,6 +69,7 @@ struct j721e_pcie_data {
 	unsigned int		quirk_disable_flr:1;
 	u32			linkdown_irq_regfield;
 	unsigned int		byte_access_allowed:1;
+	unsigned int		max_lanes;
 };
 
 static inline u32 j721e_pcie_user_readl(struct j721e_pcie *pcie, u32 offset)
@@ -290,11 +289,13 @@ static const struct j721e_pcie_data j721e_pcie_rc_data = {
 	.quirk_retrain_flag = true,
 	.byte_access_allowed = false,
 	.linkdown_irq_regfield = LINK_DOWN,
+	.max_lanes = 2,
 };
 
 static const struct j721e_pcie_data j721e_pcie_ep_data = {
 	.mode = PCI_MODE_EP,
 	.linkdown_irq_regfield = LINK_DOWN,
+	.max_lanes = 2,
 };
 
 static const struct j721e_pcie_data j7200_pcie_rc_data = {
@@ -302,23 +303,27 @@ static const struct j721e_pcie_data j7200_pcie_rc_data = {
 	.quirk_detect_quiet_flag = true,
 	.linkdown_irq_regfield = J7200_LINK_DOWN,
 	.byte_access_allowed = true,
+	.max_lanes = 2,
 };
 
 static const struct j721e_pcie_data j7200_pcie_ep_data = {
 	.mode = PCI_MODE_EP,
 	.quirk_detect_quiet_flag = true,
 	.quirk_disable_flr = true,
+	.max_lanes = 2,
 };
 
 static const struct j721e_pcie_data am64_pcie_rc_data = {
 	.mode = PCI_MODE_RC,
 	.linkdown_irq_regfield = J7200_LINK_DOWN,
 	.byte_access_allowed = true,
+	.max_lanes = 1,
 };
 
 static const struct j721e_pcie_data am64_pcie_ep_data = {
 	.mode = PCI_MODE_EP,
 	.linkdown_irq_regfield = J7200_LINK_DOWN,
+	.max_lanes = 1,
 };
 
 static const struct of_device_id of_j721e_pcie_match[] = {
@@ -432,8 +437,10 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 	pcie->user_cfg_base = base;
 
 	ret = of_property_read_u32(node, "num-lanes", &num_lanes);
-	if (ret || num_lanes > MAX_LANES)
+	if (ret || num_lanes > data->max_lanes) {
+		dev_warn(dev, "num-lanes property not provided or invalid, setting num-lanes to 1\n");
 		num_lanes = 1;
+	}
 	pcie->num_lanes = num_lanes;
 
 	if (dma_set_mask_and_coherent(dev, DMA_BIT_MASK(48)))
-- 
2.25.1

