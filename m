Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9715E6BC864
	for <lists+linux-pci@lfdr.de>; Thu, 16 Mar 2023 09:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbjCPIL4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Mar 2023 04:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbjCPILp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Mar 2023 04:11:45 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43100B0B81
        for <linux-pci@vger.kernel.org>; Thu, 16 Mar 2023 01:11:41 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id nn12so871315pjb.5
        for <linux-pci@vger.kernel.org>; Thu, 16 Mar 2023 01:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678954301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u5gR5JSTu04jyfBUnDvJJf1oPHGfwn0VqcMWzygQqRg=;
        b=ZD6EwXVCf3QEvGCzY9GOgxx/Tnq2wmTA7+gQI1KlFgkNBDi8h59dcF6+CTPaoR+Uob
         P6DEIrOdaIfqjldqmc0jzceGyFVY31+RS4IeQCR4m5RaPn/zSXn3dEOzTDQYjifsx1dv
         PtNy9LG+T763UWpzdPrOjA5UNPpHz7yifN+ZwHE4NyBE8iM/p0P5k+HTLwWTBpXvWyYW
         AvPbGjUAkjV3A5ifna/9EJmVTh90PIynTFcueyU/LNsU9/k/FxPd2T0y33r9CqK/1tDw
         p8UEtfM6zgf31ZsRqHmJ0NZjrTmzELXcwCds86i8SHwfZJKVTemxpllCcUN1aB9nfjVQ
         VgVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678954301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u5gR5JSTu04jyfBUnDvJJf1oPHGfwn0VqcMWzygQqRg=;
        b=C+TNj+oBpdU/cTVZmpCA+cI1kEhx/xtnNbr3EuHXDOs7JRKaAPvE0DFHc5qkggLEHd
         BnQCEcbYxkygj4mC+mqPAQmvLaKkG2Yn/ceLJTFKQpaL+ZVrFKgmS7+tqs4yxXLdfLKX
         O9I/fPhD6Jrzwt+b3fYBNYuibAc5dCmnga6zp/8f4lrHAmMKZPsEz+Iayeg99L8JdU6i
         HpGS5m0NAXCe4+a+Yl2/xY/7fxl/AwClmFky3LwK5x0IClGfEslwEJZq70yL3JF233A9
         hmMY+hBLcF9Jflh0POtcJ6Vjzz5Zylx7G1qwIFDqUEW/3LyE/2boWXyF11RusObXOELr
         95cg==
X-Gm-Message-State: AO0yUKUqBSfqd7JdL3lOEoHZjtAYAfhBitakWhLGKsIsmuOqC4RanE9z
        mi00eBLKIGUfNxR3kI9Ic1Tr
X-Google-Smtp-Source: AK7set87PAQsc3ZlCH2m5qe2PgQGRi4jQT90UX3iz7I+VZey1H1+oHqSLujZpHlSaycdXEZ/gyiufQ==
X-Received: by 2002:a05:6a20:7f9a:b0:d0:36d5:cf1f with SMTP id d26-20020a056a207f9a00b000d036d5cf1fmr2615608pzj.5.1678954300676;
        Thu, 16 Mar 2023 01:11:40 -0700 (PDT)
Received: from localhost.localdomain ([117.207.30.24])
        by smtp.gmail.com with ESMTPSA id 13-20020aa7910d000000b005d9984a947bsm4804422pfh.139.2023.03.16.01.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 01:11:40 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, lpieralisi@kernel.org, kw@linux.com,
        krzysztof.kozlowski+dt@linaro.org, robh@kernel.org
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v5 02/19] PCI: qcom: Remove PCIE20_ prefix from register definitions
Date:   Thu, 16 Mar 2023 13:41:00 +0530
Message-Id: <20230316081117.14288-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230316081117.14288-1-manivannan.sadhasivam@linaro.org>
References: <20230316081117.14288-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index 89d748cc4b8a..5855ad8e9c1c 100644
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
@@ -1255,33 +1253,33 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
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
 
-	val = readl(pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT_V2);
+	val = readl(pcie->parf + PARF_AXI_MSTR_WR_ADDR_HALT_V2);
 	val |= BIT(31);
-	writel(val, pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT_V2);
+	writel(val, pcie->parf + PARF_AXI_MSTR_WR_ADDR_HALT_V2);
 
 	return 0;
 err_disable_clocks:
@@ -1369,17 +1367,17 @@ static int qcom_pcie_post_init_2_9_0(struct qcom_pcie *pcie)
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
@@ -1387,9 +1385,9 @@ static int qcom_pcie_post_init_2_9_0(struct qcom_pcie *pcie)
 	writel(MST_WAKEUP_EN | SLV_WAKEUP_EN | MSTR_ACLK_CGC_DIS |
 		SLV_ACLK_CGC_DIS | CORE_CLK_CGC_DIS |
 		AUX_PWR_DET | L23_CLK_RMV_DIS | L1_CLK_RMV_DIS,
-		pcie->parf + PCIE20_PARF_SYS_CTRL);
+		pcie->parf + PARF_SYS_CTRL);
 
-	writel(0, pcie->parf + PCIE20_PARF_Q2A_FLUSH);
+	writel(0, pcie->parf + PARF_Q2A_FLUSH);
 
 	dw_pcie_dbi_ro_wr_en(pci);
 	writel(PCIE_CAP_SLOT_VAL, pci->dbi_base + offset + PCI_EXP_SLTCAP);
@@ -1402,7 +1400,7 @@ static int qcom_pcie_post_init_2_9_0(struct qcom_pcie *pcie)
 			PCI_EXP_DEVCTL2);
 
 	for (i = 0; i < 256; i++)
-		writel(0, pcie->parf + PCIE20_PARF_BDF_TO_SID_TABLE_N + (4 * i));
+		writel(0, pcie->parf + PARF_BDF_TO_SID_TABLE_N + (4 * i));
 
 	return 0;
 }
@@ -1424,7 +1422,7 @@ static int qcom_pcie_config_sid_sm8250(struct qcom_pcie *pcie)
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

