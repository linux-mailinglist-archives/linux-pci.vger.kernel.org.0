Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D69D36B352F
	for <lists+linux-pci@lfdr.de>; Fri, 10 Mar 2023 05:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjCJEIr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Mar 2023 23:08:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbjCJEIl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Mar 2023 23:08:41 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5001D86155
        for <linux-pci@vger.kernel.org>; Thu,  9 Mar 2023 20:08:36 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id a7so2851155pfx.10
        for <linux-pci@vger.kernel.org>; Thu, 09 Mar 2023 20:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678421316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LgcUg9KBFxgyL7R+Ko0NRVJoBGhkBXsnNvmn89JO8A8=;
        b=c3qGIoLrGp1PdUOM+WA3hZ8dx6qyhOgNnZQ72Tc6ea161qzbjzXiN9QhbjdjhuYJCx
         MFfFiP+7JYyLJZczXFRpzMvKWgdtb8izRkg2AxKOK06w6XUntcwwSuYIs8ZHSKn43LNp
         CRp6kCXQf/4LLWAkZsRNROgyHHkipfUSDMN1LkS4Q6WAuBccC3Wwd7+k5aVk3LHETYgZ
         uogLSKPWxZjjegDwdO3X2FWabIe96r+aerQc0jmZgx3FjeWUk3jHuOI/ujkEKBV0tiV5
         FSfUc3TgZPyu6oc0LyVdYbBYJlY2cguWMc45qsdasxopUBKwlFB+XvCRkmuKMXOd2KUD
         r1Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678421316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LgcUg9KBFxgyL7R+Ko0NRVJoBGhkBXsnNvmn89JO8A8=;
        b=VshenYOAXK3jWqMPd3Qgd7BL25lWoN8XiPfF0qTuafNBO36VhY+C5zvQqybwG5fmo5
         zNkjM9IXd2f0INaQAuVZTrrAR21fPa1n5J0+G9d3+pAsMO1v25GCdzHEVVdE3nyylxg3
         XGLZkzt6fFps9Xj4YOMmvr5Crpi1qCI5zv8nECxwhEtWmORY/2U91iVYGbBAcICAeMKY
         4uNWI5skBId1w+Z7sfk/Xd1H9JAKaVa1OzW6q6t+QL/LoNmGcKvPhlra74sKjLQbU6BW
         eiVc6hM4fcPy3k6L+wAJSxjMrkHy7FItcjHHq5kpmLlaYl+3GSYgYGTE/NNXnDtxhVRY
         JrUg==
X-Gm-Message-State: AO0yUKXjGB39cJfPSd1sOriq8azvQuq5XZSEcKFxIUHKROLzmUVJ6+SX
        4FKXRdqbi2KjUzPGtoS8zKVT
X-Google-Smtp-Source: AK7set8Uz/2jjCvub4u23RqnxvUxHFxMMHv0Q8QeOVKQhnP0eK0r7Ptz1JmJ8PzCqagcyl3VinRYYA==
X-Received: by 2002:a62:5258:0:b0:5a9:bd0c:4704 with SMTP id g85-20020a625258000000b005a9bd0c4704mr22251248pfb.14.1678421315671;
        Thu, 09 Mar 2023 20:08:35 -0800 (PST)
Received: from localhost.localdomain ([27.111.75.67])
        by smtp.gmail.com with ESMTPSA id y26-20020aa7855a000000b0058d92d6e4ddsm361846pfn.5.2023.03.09.20.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 20:08:34 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, lpieralisi@kernel.org, kw@linux.com,
        krzysztof.kozlowski+dt@linaro.org, robh@kernel.org
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 01/19] PCI: qcom: Remove PCIE20_ prefix from register definitions
Date:   Fri, 10 Mar 2023 09:37:58 +0530
Message-Id: <20230310040816.22094-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230310040816.22094-1-manivannan.sadhasivam@linaro.org>
References: <20230310040816.22094-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The PCIE part is redundant and 20 doesn't represent anything across the
SoCs supported now. So let's get rid of the prefix.

This involves adding the IP version suffix to one definition of
PARF_SLV_ADDR_SPACE_SIZE that defines offset specific to that version.
The other definition is generic for the rest of the versions.

Also, the register PCIE20_LNK_CONTROL2_LINK_STATUS2 is not used anywhere,
hence removed.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 184 ++++++++++++-------------
 1 file changed, 91 insertions(+), 93 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index a232b04af048..6930bc9ceeb5 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -33,7 +33,7 @@
 #include "../../pci.h"
 #include "pcie-designware.h"
 
-#define PCIE20_PARF_SYS_CTRL			0x00
+#define PARF_SYS_CTRL				0x00
 #define MST_WAKEUP_EN				BIT(13)
 #define SLV_WAKEUP_EN				BIT(12)
 #define MSTR_ACLK_CGC_DIS			BIT(10)
@@ -43,39 +43,39 @@
 #define L23_CLK_RMV_DIS				BIT(2)
 #define L1_CLK_RMV_DIS				BIT(1)
 
-#define PCIE20_PARF_PM_CTRL			0x20
+#define PARF_PM_CTRL				0x20
 #define REQ_NOT_ENTR_L1				BIT(5)
 
-#define PCIE20_PARF_PHY_CTRL			0x40
+#define PARF_PHY_CTRL				0x40
 #define PHY_CTRL_PHY_TX0_TERM_OFFSET_MASK	GENMASK(20, 16)
 #define PHY_CTRL_PHY_TX0_TERM_OFFSET(x)		((x) << 16)
 
-#define PCIE20_PARF_PHY_REFCLK			0x4C
+#define PARF_PHY_REFCLK				0x4C
 #define PHY_REFCLK_SSP_EN			BIT(16)
 #define PHY_REFCLK_USE_PAD			BIT(12)
 
-#define PCIE20_PARF_DBI_BASE_ADDR		0x168
-#define PCIE20_PARF_SLV_ADDR_SPACE_SIZE		0x16C
-#define PCIE20_PARF_MHI_CLOCK_RESET_CTRL	0x174
+#define PARF_DBI_BASE_ADDR			0x168
+#define PARF_SLV_ADDR_SPACE_SIZE_2_3_3		0x16C /* Register offset specific to IP rev 2.3.3 */
+#define PARF_MHI_CLOCK_RESET_CTRL		0x174
 #define AHB_CLK_EN				BIT(0)
 #define MSTR_AXI_CLK_EN				BIT(1)
 #define BYPASS					BIT(4)
 
-#define PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT	0x178
-#define PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT_V2	0x1A8
-#define PCIE20_PARF_LTSSM			0x1B0
-#define PCIE20_PARF_SID_OFFSET			0x234
-#define PCIE20_PARF_BDF_TRANSLATE_CFG		0x24C
-#define PCIE20_PARF_DEVICE_TYPE			0x1000
-#define PCIE20_PARF_BDF_TO_SID_TABLE_N		0x2000
+#define PARF_AXI_MSTR_WR_ADDR_HALT		0x178
+#define PARF_AXI_MSTR_WR_ADDR_HALT_V2		0x1A8
+#define PARF_LTSSM				0x1B0
+#define PARF_SID_OFFSET				0x234
+#define PARF_BDF_TRANSLATE_CFG			0x24C
+#define PARF_DEVICE_TYPE			0x1000
+#define PARF_BDF_TO_SID_TABLE_N			0x2000
 
-#define PCIE20_ELBI_SYS_CTRL			0x04
-#define PCIE20_ELBI_SYS_CTRL_LT_ENABLE		BIT(0)
+#define ELBI_SYS_CTRL				0x04
+#define ELBI_SYS_CTRL_LT_ENABLE			BIT(0)
 
-#define PCIE20_AXI_MSTR_RESP_COMP_CTRL0		0x818
+#define AXI_MSTR_RESP_COMP_CTRL0		0x818
 #define CFG_REMOTE_RD_REQ_BRIDGE_SIZE_2K	0x4
 #define CFG_REMOTE_RD_REQ_BRIDGE_SIZE_4K	0x5
-#define PCIE20_AXI_MSTR_RESP_COMP_CTRL1		0x81c
+#define AXI_MSTR_RESP_COMP_CTRL1		0x81c
 #define CFG_BRIDGE_SB_INIT			BIT(0)
 
 #define PCIE_CAP_SLOT_POWER_LIMIT_VAL		FIELD_PREP(PCI_EXP_SLTCAP_SPLV, \
@@ -93,30 +93,28 @@
 						PCIE_CAP_SLOT_POWER_LIMIT_VAL | \
 						PCIE_CAP_SLOT_POWER_LIMIT_SCALE)
 
-#define PCIE20_PARF_Q2A_FLUSH			0x1AC
+#define PARF_Q2A_FLUSH				0x1AC
 
-#define PCIE20_MISC_CONTROL_1_REG		0x8BC
+#define MISC_CONTROL_1_REG			0x8BC
 #define DBI_RO_WR_EN				1
 
 #define PERST_DELAY_US				1000
 /* PARF registers */
-#define PCIE20_PARF_PCS_DEEMPH			0x34
+#define PARF_PCS_DEEMPH				0x34
 #define PCS_DEEMPH_TX_DEEMPH_GEN1(x)		((x) << 16)
 #define PCS_DEEMPH_TX_DEEMPH_GEN2_3_5DB(x)	((x) << 8)
 #define PCS_DEEMPH_TX_DEEMPH_GEN2_6DB(x)	((x) << 0)
 
-#define PCIE20_PARF_PCS_SWING			0x38
+#define PARF_PCS_SWING				0x38
 #define PCS_SWING_TX_SWING_FULL(x)		((x) << 8)
 #define PCS_SWING_TX_SWING_LOW(x)		((x) << 0)
 
-#define PCIE20_PARF_CONFIG_BITS		0x50
+#define PARF_CONFIG_BITS			0x50
 #define PHY_RX0_EQ(x)				((x) << 24)
 
-#define PCIE20_v3_PARF_SLV_ADDR_SPACE_SIZE	0x358
+#define PARF_SLV_ADDR_SPACE_SIZE		0x358
 #define SLV_ADDR_SPACE_SZ			0x10000000
 
-#define PCIE20_LNK_CONTROL2_LINK_STATUS2	0xa0
-
 #define DEVICE_TYPE_RC				0x4
 
 #define QCOM_PCIE_2_1_0_MAX_SUPPLY	3
@@ -261,9 +259,9 @@ static void qcom_pcie_2_1_0_ltssm_enable(struct qcom_pcie *pcie)
 	u32 val;
 
 	/* enable link training */
-	val = readl(pcie->elbi + PCIE20_ELBI_SYS_CTRL);
-	val |= PCIE20_ELBI_SYS_CTRL_LT_ENABLE;
-	writel(val, pcie->elbi + PCIE20_ELBI_SYS_CTRL);
+	val = readl(pcie->elbi + ELBI_SYS_CTRL);
+	val |= ELBI_SYS_CTRL_LT_ENABLE;
+	writel(val, pcie->elbi + ELBI_SYS_CTRL);
 }
 
 static int qcom_pcie_get_resources_2_1_0(struct qcom_pcie *pcie)
@@ -333,7 +331,7 @@ static void qcom_pcie_deinit_2_1_0(struct qcom_pcie *pcie)
 	reset_control_assert(res->ext_reset);
 	reset_control_assert(res->phy_reset);
 
-	writel(1, pcie->parf + PCIE20_PARF_PHY_CTRL);
+	writel(1, pcie->parf + PARF_PHY_CTRL);
 
 	regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
 }
@@ -423,9 +421,9 @@ static int qcom_pcie_post_init_2_1_0(struct qcom_pcie *pcie)
 	int ret;
 
 	/* enable PCIe clocks and resets */
-	val = readl(pcie->parf + PCIE20_PARF_PHY_CTRL);
+	val = readl(pcie->parf + PARF_PHY_CTRL);
 	val &= ~BIT(0);
-	writel(val, pcie->parf + PCIE20_PARF_PHY_CTRL);
+	writel(val, pcie->parf + PARF_PHY_CTRL);
 
 	ret = clk_bulk_prepare_enable(ARRAY_SIZE(res->clks), res->clks);
 	if (ret)
@@ -436,37 +434,37 @@ static int qcom_pcie_post_init_2_1_0(struct qcom_pcie *pcie)
 		writel(PCS_DEEMPH_TX_DEEMPH_GEN1(24) |
 			       PCS_DEEMPH_TX_DEEMPH_GEN2_3_5DB(24) |
 			       PCS_DEEMPH_TX_DEEMPH_GEN2_6DB(34),
-		       pcie->parf + PCIE20_PARF_PCS_DEEMPH);
+		       pcie->parf + PARF_PCS_DEEMPH);
 		writel(PCS_SWING_TX_SWING_FULL(120) |
 			       PCS_SWING_TX_SWING_LOW(120),
-		       pcie->parf + PCIE20_PARF_PCS_SWING);
-		writel(PHY_RX0_EQ(4), pcie->parf + PCIE20_PARF_CONFIG_BITS);
+		       pcie->parf + PARF_PCS_SWING);
+		writel(PHY_RX0_EQ(4), pcie->parf + PARF_CONFIG_BITS);
 	}
 
 	if (of_device_is_compatible(node, "qcom,pcie-ipq8064")) {
 		/* set TX termination offset */
-		val = readl(pcie->parf + PCIE20_PARF_PHY_CTRL);
+		val = readl(pcie->parf + PARF_PHY_CTRL);
 		val &= ~PHY_CTRL_PHY_TX0_TERM_OFFSET_MASK;
 		val |= PHY_CTRL_PHY_TX0_TERM_OFFSET(7);
-		writel(val, pcie->parf + PCIE20_PARF_PHY_CTRL);
+		writel(val, pcie->parf + PARF_PHY_CTRL);
 	}
 
 	/* enable external reference clock */
-	val = readl(pcie->parf + PCIE20_PARF_PHY_REFCLK);
+	val = readl(pcie->parf + PARF_PHY_REFCLK);
 	/* USE_PAD is required only for ipq806x */
 	if (!of_device_is_compatible(node, "qcom,pcie-apq8064"))
 		val &= ~PHY_REFCLK_USE_PAD;
 	val |= PHY_REFCLK_SSP_EN;
-	writel(val, pcie->parf + PCIE20_PARF_PHY_REFCLK);
+	writel(val, pcie->parf + PARF_PHY_REFCLK);
 
 	/* wait for clock acquisition */
 	usleep_range(1000, 1500);
 
 	/* Set the Max TLP size to 2K, instead of using default of 4K */
 	writel(CFG_REMOTE_RD_REQ_BRIDGE_SIZE_2K,
-	       pci->dbi_base + PCIE20_AXI_MSTR_RESP_COMP_CTRL0);
+	       pci->dbi_base + AXI_MSTR_RESP_COMP_CTRL0);
 	writel(CFG_BRIDGE_SB_INIT,
-	       pci->dbi_base + PCIE20_AXI_MSTR_RESP_COMP_CTRL1);
+	       pci->dbi_base + AXI_MSTR_RESP_COMP_CTRL1);
 
 	return 0;
 }
@@ -574,13 +572,13 @@ static int qcom_pcie_init_1_0_0(struct qcom_pcie *pcie)
 static int qcom_pcie_post_init_1_0_0(struct qcom_pcie *pcie)
 {
 	/* change DBI base address */
-	writel(0, pcie->parf + PCIE20_PARF_DBI_BASE_ADDR);
+	writel(0, pcie->parf + PARF_DBI_BASE_ADDR);
 
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
-		u32 val = readl(pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT);
+		u32 val = readl(pcie->parf + PARF_AXI_MSTR_WR_ADDR_HALT);
 
 		val |= BIT(31);
-		writel(val, pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT);
+		writel(val, pcie->parf + PARF_AXI_MSTR_WR_ADDR_HALT);
 	}
 
 	return 0;
@@ -591,9 +589,9 @@ static void qcom_pcie_2_3_2_ltssm_enable(struct qcom_pcie *pcie)
 	u32 val;
 
 	/* enable link training */
-	val = readl(pcie->parf + PCIE20_PARF_LTSSM);
+	val = readl(pcie->parf + PARF_LTSSM);
 	val |= BIT(8);
-	writel(val, pcie->parf + PCIE20_PARF_LTSSM);
+	writel(val, pcie->parf + PARF_LTSSM);
 }
 
 static int qcom_pcie_get_resources_2_3_2(struct qcom_pcie *pcie)
@@ -698,25 +696,25 @@ static int qcom_pcie_post_init_2_3_2(struct qcom_pcie *pcie)
 	u32 val;
 
 	/* enable PCIe clocks and resets */
-	val = readl(pcie->parf + PCIE20_PARF_PHY_CTRL);
+	val = readl(pcie->parf + PARF_PHY_CTRL);
 	val &= ~BIT(0);
-	writel(val, pcie->parf + PCIE20_PARF_PHY_CTRL);
+	writel(val, pcie->parf + PARF_PHY_CTRL);
 
 	/* change DBI base address */
-	writel(0, pcie->parf + PCIE20_PARF_DBI_BASE_ADDR);
+	writel(0, pcie->parf + PARF_DBI_BASE_ADDR);
 
 	/* MAC PHY_POWERDOWN MUX DISABLE  */
-	val = readl(pcie->parf + PCIE20_PARF_SYS_CTRL);
+	val = readl(pcie->parf + PARF_SYS_CTRL);
 	val &= ~BIT(29);
-	writel(val, pcie->parf + PCIE20_PARF_SYS_CTRL);
+	writel(val, pcie->parf + PARF_SYS_CTRL);
 
-	val = readl(pcie->parf + PCIE20_PARF_MHI_CLOCK_RESET_CTRL);
+	val = readl(pcie->parf + PARF_MHI_CLOCK_RESET_CTRL);
 	val |= BIT(4);
-	writel(val, pcie->parf + PCIE20_PARF_MHI_CLOCK_RESET_CTRL);
+	writel(val, pcie->parf + PARF_MHI_CLOCK_RESET_CTRL);
 
-	val = readl(pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT_V2);
+	val = readl(pcie->parf + PARF_AXI_MSTR_WR_ADDR_HALT_V2);
 	val |= BIT(31);
-	writel(val, pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT_V2);
+	writel(val, pcie->parf + PARF_AXI_MSTR_WR_ADDR_HALT_V2);
 
 	return 0;
 }
@@ -977,25 +975,25 @@ static int qcom_pcie_post_init_2_4_0(struct qcom_pcie *pcie)
 	u32 val;
 
 	/* enable PCIe clocks and resets */
-	val = readl(pcie->parf + PCIE20_PARF_PHY_CTRL);
+	val = readl(pcie->parf + PARF_PHY_CTRL);
 	val &= ~BIT(0);
-	writel(val, pcie->parf + PCIE20_PARF_PHY_CTRL);
+	writel(val, pcie->parf + PARF_PHY_CTRL);
 
 	/* change DBI base address */
-	writel(0, pcie->parf + PCIE20_PARF_DBI_BASE_ADDR);
+	writel(0, pcie->parf + PARF_DBI_BASE_ADDR);
 
 	/* MAC PHY_POWERDOWN MUX DISABLE  */
-	val = readl(pcie->parf + PCIE20_PARF_SYS_CTRL);
+	val = readl(pcie->parf + PARF_SYS_CTRL);
 	val &= ~BIT(29);
-	writel(val, pcie->parf + PCIE20_PARF_SYS_CTRL);
+	writel(val, pcie->parf + PARF_SYS_CTRL);
 
-	val = readl(pcie->parf + PCIE20_PARF_MHI_CLOCK_RESET_CTRL);
+	val = readl(pcie->parf + PARF_MHI_CLOCK_RESET_CTRL);
 	val |= BIT(4);
-	writel(val, pcie->parf + PCIE20_PARF_MHI_CLOCK_RESET_CTRL);
+	writel(val, pcie->parf + PARF_MHI_CLOCK_RESET_CTRL);
 
-	val = readl(pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT_V2);
+	val = readl(pcie->parf + PARF_AXI_MSTR_WR_ADDR_HALT_V2);
 	val |= BIT(31);
-	writel(val, pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT_V2);
+	writel(val, pcie->parf + PARF_AXI_MSTR_WR_ADDR_HALT_V2);
 
 	return 0;
 }
@@ -1140,22 +1138,22 @@ static int qcom_pcie_post_init_2_3_3(struct qcom_pcie *pcie)
 	u32 val;
 
 	writel(SLV_ADDR_SPACE_SZ,
-		pcie->parf + PCIE20_v3_PARF_SLV_ADDR_SPACE_SIZE);
+		pcie->parf + PARF_SLV_ADDR_SPACE_SIZE_2_3_3);
 
-	val = readl(pcie->parf + PCIE20_PARF_PHY_CTRL);
+	val = readl(pcie->parf + PARF_PHY_CTRL);
 	val &= ~BIT(0);
-	writel(val, pcie->parf + PCIE20_PARF_PHY_CTRL);
+	writel(val, pcie->parf + PARF_PHY_CTRL);
 
-	writel(0, pcie->parf + PCIE20_PARF_DBI_BASE_ADDR);
+	writel(0, pcie->parf + PARF_DBI_BASE_ADDR);
 
 	writel(MST_WAKEUP_EN | SLV_WAKEUP_EN | MSTR_ACLK_CGC_DIS
 		| SLV_ACLK_CGC_DIS | CORE_CLK_CGC_DIS |
 		AUX_PWR_DET | L23_CLK_RMV_DIS | L1_CLK_RMV_DIS,
-		pcie->parf + PCIE20_PARF_SYS_CTRL);
-	writel(0, pcie->parf + PCIE20_PARF_Q2A_FLUSH);
+		pcie->parf + PARF_SYS_CTRL);
+	writel(0, pcie->parf + PARF_Q2A_FLUSH);
 
 	writel(PCI_COMMAND_MASTER, pci->dbi_base + PCI_COMMAND);
-	writel(DBI_RO_WR_EN, pci->dbi_base + PCIE20_MISC_CONTROL_1_REG);
+	writel(DBI_RO_WR_EN, pci->dbi_base + MISC_CONTROL_1_REG);
 	writel(PCIE_CAP_SLOT_VAL, pci->dbi_base + offset + PCI_EXP_SLTCAP);
 
 	val = readl(pci->dbi_base + offset + PCI_EXP_LNKCAP);
@@ -1255,34 +1253,34 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
 	usleep_range(1000, 1500);
 
 	/* configure PCIe to RC mode */
-	writel(DEVICE_TYPE_RC, pcie->parf + PCIE20_PARF_DEVICE_TYPE);
+	writel(DEVICE_TYPE_RC, pcie->parf + PARF_DEVICE_TYPE);
 
 	/* enable PCIe clocks and resets */
-	val = readl(pcie->parf + PCIE20_PARF_PHY_CTRL);
+	val = readl(pcie->parf + PARF_PHY_CTRL);
 	val &= ~BIT(0);
-	writel(val, pcie->parf + PCIE20_PARF_PHY_CTRL);
+	writel(val, pcie->parf + PARF_PHY_CTRL);
 
 	/* change DBI base address */
-	writel(0, pcie->parf + PCIE20_PARF_DBI_BASE_ADDR);
+	writel(0, pcie->parf + PARF_DBI_BASE_ADDR);
 
 	/* MAC PHY_POWERDOWN MUX DISABLE  */
-	val = readl(pcie->parf + PCIE20_PARF_SYS_CTRL);
+	val = readl(pcie->parf + PARF_SYS_CTRL);
 	val &= ~BIT(29);
-	writel(val, pcie->parf + PCIE20_PARF_SYS_CTRL);
+	writel(val, pcie->parf + PARF_SYS_CTRL);
 
-	val = readl(pcie->parf + PCIE20_PARF_MHI_CLOCK_RESET_CTRL);
+	val = readl(pcie->parf + PARF_MHI_CLOCK_RESET_CTRL);
 	val |= BIT(4);
-	writel(val, pcie->parf + PCIE20_PARF_MHI_CLOCK_RESET_CTRL);
+	writel(val, pcie->parf + PARF_MHI_CLOCK_RESET_CTRL);
 
 	/* Enable L1 and L1SS */
-	val = readl(pcie->parf + PCIE20_PARF_PM_CTRL);
+	val = readl(pcie->parf + PARF_PM_CTRL);
 	val &= ~REQ_NOT_ENTR_L1;
-	writel(val, pcie->parf + PCIE20_PARF_PM_CTRL);
+	writel(val, pcie->parf + PARF_PM_CTRL);
 
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
-		val = readl(pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT);
+		val = readl(pcie->parf + PARF_AXI_MSTR_WR_ADDR_HALT);
 		val |= BIT(31);
-		writel(val, pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT);
+		writel(val, pcie->parf + PARF_AXI_MSTR_WR_ADDR_HALT);
 	}
 
 	return 0;
@@ -1371,17 +1369,17 @@ static int qcom_pcie_post_init_2_9_0(struct qcom_pcie *pcie)
 	int i;
 
 	writel(SLV_ADDR_SPACE_SZ,
-		pcie->parf + PCIE20_v3_PARF_SLV_ADDR_SPACE_SIZE);
+		pcie->parf + PARF_SLV_ADDR_SPACE_SIZE);
 
-	val = readl(pcie->parf + PCIE20_PARF_PHY_CTRL);
+	val = readl(pcie->parf + PARF_PHY_CTRL);
 	val &= ~BIT(0);
-	writel(val, pcie->parf + PCIE20_PARF_PHY_CTRL);
+	writel(val, pcie->parf + PARF_PHY_CTRL);
 
-	writel(0, pcie->parf + PCIE20_PARF_DBI_BASE_ADDR);
+	writel(0, pcie->parf + PARF_DBI_BASE_ADDR);
 
-	writel(DEVICE_TYPE_RC, pcie->parf + PCIE20_PARF_DEVICE_TYPE);
+	writel(DEVICE_TYPE_RC, pcie->parf + PARF_DEVICE_TYPE);
 	writel(BYPASS | MSTR_AXI_CLK_EN | AHB_CLK_EN,
-		pcie->parf + PCIE20_PARF_MHI_CLOCK_RESET_CTRL);
+		pcie->parf + PARF_MHI_CLOCK_RESET_CTRL);
 	writel(GEN3_RELATED_OFF_RXEQ_RGRDLESS_RXTS |
 		GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL,
 		pci->dbi_base + GEN3_RELATED_OFF);
@@ -1389,9 +1387,9 @@ static int qcom_pcie_post_init_2_9_0(struct qcom_pcie *pcie)
 	writel(MST_WAKEUP_EN | SLV_WAKEUP_EN | MSTR_ACLK_CGC_DIS |
 		SLV_ACLK_CGC_DIS | CORE_CLK_CGC_DIS |
 		AUX_PWR_DET | L23_CLK_RMV_DIS | L1_CLK_RMV_DIS,
-		pcie->parf + PCIE20_PARF_SYS_CTRL);
+		pcie->parf + PARF_SYS_CTRL);
 
-	writel(0, pcie->parf + PCIE20_PARF_Q2A_FLUSH);
+	writel(0, pcie->parf + PARF_Q2A_FLUSH);
 
 	dw_pcie_dbi_ro_wr_en(pci);
 	writel(PCIE_CAP_SLOT_VAL, pci->dbi_base + offset + PCI_EXP_SLTCAP);
@@ -1404,7 +1402,7 @@ static int qcom_pcie_post_init_2_9_0(struct qcom_pcie *pcie)
 			PCI_EXP_DEVCTL2);
 
 	for (i = 0; i < 256; i++)
-		writel(0, pcie->parf + PCIE20_PARF_BDF_TO_SID_TABLE_N + (4 * i));
+		writel(0, pcie->parf + PARF_BDF_TO_SID_TABLE_N + (4 * i));
 
 	return 0;
 }
@@ -1426,7 +1424,7 @@ static int qcom_pcie_config_sid_sm8250(struct qcom_pcie *pcie)
 		u32 smmu_sid;
 		u32 smmu_sid_len;
 	} *map;
-	void __iomem *bdf_to_sid_base = pcie->parf + PCIE20_PARF_BDF_TO_SID_TABLE_N;
+	void __iomem *bdf_to_sid_base = pcie->parf + PARF_BDF_TO_SID_TABLE_N;
 	struct device *dev = pcie->pci->dev;
 	u8 qcom_pcie_crc8_table[CRC8_TABLE_SIZE];
 	int i, nr_map, size = 0;
-- 
2.25.1

