Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABEAF67156F
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jan 2023 08:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjARHxf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Jan 2023 02:53:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjARHxR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Jan 2023 02:53:17 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C529654C9;
        Tue, 17 Jan 2023 23:20:50 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 30I7KaxH081712;
        Wed, 18 Jan 2023 01:20:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1674026437;
        bh=KkFY6GKvqhnim7O+cjEqnGKGMnv1G70IhEgs+/7uVNM=;
        h=From:To:CC:Subject:Date;
        b=RaUg1slCIczvkNHhbOBh/Ha6FwfSCY2hU08sTPg4EMz++P79I7ep1et8HftEqr3PF
         wHy7k7XZHPuyD1F05TYCrL9aqO8+SKkbvW/NL41gkIh8GUORRyj5j4a+lPqtcbcg91
         3aGoWOLYliEeGyou3D6p2ri0yR/hTAgBUJj4LJYY=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 30I7Ka0i008292
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 18 Jan 2023 01:20:36 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 18
 Jan 2023 01:20:36 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 18 Jan 2023 01:20:36 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 30I7KZcY116191;
        Wed, 18 Jan 2023 01:20:36 -0600
From:   Achal Verma <a-verma1@ti.com>
To:     Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Wilczy_ski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Achal Verma <a-verma1@ti.com>,
        Milind Parab <mparab@cadence.com>, Jian Wang <jian-wang@ti.com>
Subject: [PATCH] PCI: cadence: Fix next function value in case of ARI
Date:   Wed, 18 Jan 2023 12:50:35 +0530
Message-ID: <20230118072035.3381993-1-a-verma1@ti.com>
X-Mailer: git-send-email 2.25.1
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

From: Jasko-EXT Wojciech <wojciech.jasko-EXT@continental-corporation.com>

Next function field in ARI_CAP_AND_CTR field register for last
function should be zero but thats not the case, so this patch
programs the next function field for last function as zero.

Signed-off-by: Jasko-EXT Wojciech <wojciech.jasko-EXT@continental-corporation.com>
Signed-off-by: Achal Verma <a-verma1@ti.com>
---
 drivers/pci/controller/cadence/pcie-cadence-ep.c | 15 ++++++++++++++-
 drivers/pci/controller/cadence/pcie-cadence.h    |  6 ++++++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
index b8b655d4047e..6b6904cf0123 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
@@ -565,7 +565,8 @@ static int cdns_pcie_ep_start(struct pci_epc *epc)
 	struct cdns_pcie *pcie = &ep->pcie;
 	struct device *dev = pcie->dev;
 	int max_epfs = sizeof(epc->function_num_map) * 8;
-	int ret, value, epf;
+	int ret, epf, last_fn;
+	u32 reg, value;
 
 	/*
 	 * BIT(0) is hardwired to 1, hence function 0 is always enabled
@@ -573,6 +574,18 @@ static int cdns_pcie_ep_start(struct pci_epc *epc)
 	 */
 	cdns_pcie_writel(pcie, CDNS_PCIE_LM_EP_FUNC_CFG, epc->function_num_map);
 
+	/* Setup ARI Next Function Number.
+	 * This field should point to the next physical Function and 0 for
+	 * last Function.
+	 */
+	last_fn = find_last_bit(&epc->function_num_map, BITS_PER_LONG);
+	reg     = CDNS_PCIE_CORE_PF_I_ARI_CAP_AND_CTRL(last_fn);
+
+	// Clear Next Function Number for the last function used.
+	value  = cdns_pcie_readl(pcie, reg);
+	value &= ~CDNS_PCIE_ARI_CAP_NFN_MASK;
+	cdns_pcie_writel(pcie, reg, value);
+
 	if (ep->quirk_disable_flr) {
 		for (epf = 0; epf < max_epfs; epf++) {
 			if (!(epc->function_num_map & BIT(epf)))
diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index 190786e47df9..68c4c7878111 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -130,6 +130,12 @@
 #define CDNS_PCIE_EP_FUNC_DEV_CAP_OFFSET	0xc0
 #define CDNS_PCIE_EP_FUNC_SRIOV_CAP_OFFSET	0x200
 
+/*
+ * Endpoint PF Registers
+ */
+#define CDNS_PCIE_CORE_PF_I_ARI_CAP_AND_CTRL(fn)	(0x144 + (fn) * 0x1000)
+#define CDNS_PCIE_ARI_CAP_NFN_MASK	GENMASK(15, 8)
+
 /*
  * Root Port Registers (PCI configuration space for the root port function)
  */
-- 
2.25.1

