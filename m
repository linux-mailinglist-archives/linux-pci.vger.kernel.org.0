Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E47B77A2B1
	for <lists+linux-pci@lfdr.de>; Sat, 12 Aug 2023 22:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjHLUpM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 12 Aug 2023 16:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjHLUpL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 12 Aug 2023 16:45:11 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786FA10F2;
        Sat, 12 Aug 2023 13:45:14 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37CKj0el089686;
        Sat, 12 Aug 2023 15:45:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691873100;
        bh=qs98ZG5d9WEE5HuZu48lVDNnMP0B6h7oimiTl2Sa3j8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=G6VXDDfa48ICViV9UhbFOpqnUCubfDhvg56vIBLbeGNZllPAT48PyhuWnRwLERk7Q
         FCnAQwil+lz9CVFmXBHCWeW+pXowqUDB80QERCvXYQe/seVhfitpKtbbWY6Rqy0Y5V
         E6RkkFIpYjbQvxD/UosVYflb+6LvtkvUA8c0XdeQ=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37CKj0CC076204
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 12 Aug 2023 15:45:00 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 12
 Aug 2023 15:44:59 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 12 Aug 2023 15:44:59 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37CKixqD067906;
        Sat, 12 Aug 2023 15:44:59 -0500
From:   Achal Verma <a-verma1@ti.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Wilczy_ski <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Achal Verma <a-verma1@ti.com>
Subject: [PATCH 2/2] PCI: cadence: Clear the ARI Capability Next Function Number of the last function
Date:   Sun, 13 Aug 2023 02:14:55 +0530
Message-ID: <20230812204455.479510-3-a-verma1@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230812204455.479510-1-a-verma1@ti.com>
References: <20230812204455.479510-1-a-verma1@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Jasko-EXT Wojciech <wojciech.jasko-EXT@continental-corporation.com>

Next Function Number field in ARI Capability Register for last function
must be zero by default as per the PCIe specification, indicating there
is no next higher number function but that's not happening in our case,
so this patch clears the Next Function Number field for last function used.

Signed-off-by: Jasko-EXT Wojciech <wojciech.jasko-EXT@continental-corporation.com>
Signed-off-by: Achal Verma <a-verma1@ti.com>
Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 drivers/pci/controller/cadence/pcie-cadence-ep.c | 14 +++++++++++++-
 drivers/pci/controller/cadence/pcie-cadence.h    |  6 ++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
index b8b655d4047e..8742b2f594fd 100644
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
@@ -573,6 +574,17 @@ static int cdns_pcie_ep_start(struct pci_epc *epc)
 	 */
 	cdns_pcie_writel(pcie, CDNS_PCIE_LM_EP_FUNC_CFG, epc->function_num_map);
 
+	/*
+	 * Next function field in ARI_CAP_AND_CTR register for last function
+	 * should be 0.
+	 * Clearing Next Function Number field for the last function used.
+	 */
+	last_fn = find_last_bit(&epc->function_num_map, BITS_PER_LONG);
+	reg     = CDNS_PCIE_CORE_PF_I_ARI_CAP_AND_CTRL(last_fn);
+	value  = cdns_pcie_readl(pcie, reg);
+	value &= ~CDNS_PCIE_ARI_CAP_NFN_MASK;
+	cdns_pcie_writel(pcie, reg, value);
+
 	if (ep->quirk_disable_flr) {
 		for (epf = 0; epf < max_epfs; epf++) {
 			if (!(epc->function_num_map & BIT(epf)))
diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index 7a5d05f3febc..adcab11e62cd 100644
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

