Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52583559813
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jun 2022 12:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbiFXKo3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jun 2022 06:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiFXKo2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Jun 2022 06:44:28 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B775DF10;
        Fri, 24 Jun 2022 03:44:26 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id ay16so3859896ejb.6;
        Fri, 24 Jun 2022 03:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o+08p55Hcb4PbWiy8FfdgVvYmr5hGtrIdsFoygVcu0Y=;
        b=Cpjc34CXVe/HxbyMDui+YUOck7Gb74z9POBL1DDtT9Ne/ZqL5BIo9bwX9Sx4/1Udbo
         4f2RGDuJNW6Ct1+MYvaggCJJOTK8oop/8pZ5WPkt7jqNCtkqtIoiwCu8qLsUCg3LRHwc
         Sf0tqIfY/lvl2HpOsOQkA80fTqRPfQZklmaqpQS5rToMnmE5NBfUHo3cF1hkOV5vYK4l
         cDXE3IcIuqH2SPqWTU7gDZ5+jPTn6H+7HBeZtcE+WtCsqDexL2VJWT/cyiiJsng4AaNI
         9DBuiN8zNS5SczXYmTjxxsLj/wUE6R16ZuYuMplmskrDrA44FhcWgnZpOuhwGYyIiyk8
         jfWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o+08p55Hcb4PbWiy8FfdgVvYmr5hGtrIdsFoygVcu0Y=;
        b=MUB2PbgtW3UNhZNzrbBy59QjDet4ohPMGyJYI/WrETscjXDMeAtXMgciiE7hlvGyYl
         Q9Ee0u5HU1M8/6a7NmREiajopG6u2Y4wXLJy+KP8usTxvnDzNLCyJDMe2c6MmNPipwi0
         CMURQtmzufzNb8gGxapx1C8mMWqru2Tsz7GnnmYSVXkFR6Gw3t8Cc94gwwSJXxMqUR4F
         InaHqgnrDZEqMpYsLGea9dh85wTPRxAlfmrlWdpUQmRRtoRPLj903wNFZr5pjyT17rCi
         As65ocFvi1tr0goHxQwNIYs+f+0/INQfFndHK0akqeXwBckmOWwvrv2ZtmP/BPX+R21L
         YQXw==
X-Gm-Message-State: AJIora+DXcRWB9dXlI8BpfcbRsLedO2vgUygSeaBGDBaA4glPy9lcqBx
        r0c+shtkGN+HP/u74R4ItI0=
X-Google-Smtp-Source: AGRyM1tO+1fswNOU8/8iQI+qdCsCg7pLFmAIqRBoXJ37vw+5DmhffgAxNqL/5NlcYg+WFRrxsrXYTQ==
X-Received: by 2002:a17:906:2bd7:b0:726:2c38:d053 with SMTP id n23-20020a1709062bd700b007262c38d053mr4117903ejg.35.1656067465234;
        Fri, 24 Jun 2022 03:44:25 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-98-60.xnet.hr. [88.207.98.60])
        by smtp.googlemail.com with ESMTPSA id v2-20020aa7d802000000b0042ab2127051sm1663301edq.64.2022.06.24.03.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 03:44:24 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     svarbanov@mm-sol.com, agross@kernel.org,
        bjorn.andersson@linaro.org, lpieralisi@kernel.org, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com, p.zabel@pengutronix.de,
        jingoohan1@gmail.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        johan+linaro@kernel.org, dmitry.baryshkov@linaro.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v4 2/2] PCI: qcom: Move all DBI register accesses after phy_power_on()
Date:   Fri, 24 Jun 2022 12:44:20 +0200
Message-Id: <20220624104420.257368-2-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220624104420.257368-1-robimarko@gmail.com>
References: <20220624104420.257368-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

IPQ8074 requires the PHY to be powered on before accessing DBI registers.
It's not clear whether other variants have the same dependency, but there
seems to be no reason for them to be different, so move all the DBI
accesses from .init() to .post_init() so they are all after phy_power_on().

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
Changes in v4:
* Move 2.7.0 accesses as well
* Correct title and description (Bjorn)
---
 drivers/pci/controller/dwc/pcie-qcom.c | 215 ++++++++++++++-----------
 1 file changed, 119 insertions(+), 96 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 24708d5d817d..f1a156052fe7 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -348,8 +348,6 @@ static int qcom_pcie_init_2_1_0(struct qcom_pcie *pcie)
 	struct qcom_pcie_resources_2_1_0 *res = &pcie->res.v2_1_0;
 	struct dw_pcie *pci = pcie->pci;
 	struct device *dev = pci->dev;
-	struct device_node *node = dev->of_node;
-	u32 val;
 	int ret;
 
 	/* reset the PCIe interface as uboot can leave it undefined state */
@@ -360,8 +358,6 @@ static int qcom_pcie_init_2_1_0(struct qcom_pcie *pcie)
 	reset_control_assert(res->ext_reset);
 	reset_control_assert(res->phy_reset);
 
-	writel(1, pcie->parf + PCIE20_PARF_PHY_CTRL);
-
 	ret = regulator_bulk_enable(ARRAY_SIZE(res->supplies), res->supplies);
 	if (ret < 0) {
 		dev_err(dev, "cannot enable regulators\n");
@@ -408,6 +404,35 @@ static int qcom_pcie_init_2_1_0(struct qcom_pcie *pcie)
 	if (ret)
 		goto err_clks;
 
+	return 0;
+
+err_clks:
+	reset_control_assert(res->axi_reset);
+err_deassert_axi:
+	reset_control_assert(res->por_reset);
+err_deassert_por:
+	reset_control_assert(res->pci_reset);
+err_deassert_pci:
+	reset_control_assert(res->phy_reset);
+err_deassert_phy:
+	reset_control_assert(res->ext_reset);
+err_deassert_ext:
+	reset_control_assert(res->ahb_reset);
+err_deassert_ahb:
+	regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
+
+	return ret;
+}
+
+static int qcom_pcie_post_init_2_1_0(struct qcom_pcie *pcie)
+{
+	struct dw_pcie *pci = pcie->pci;
+	struct device *dev = pci->dev;
+	struct device_node *node = dev->of_node;
+	u32 val;
+
+	writel(1, pcie->parf + PCIE20_PARF_PHY_CTRL);
+
 	/* enable PCIe clocks and resets */
 	val = readl(pcie->parf + PCIE20_PARF_PHY_CTRL);
 	val &= ~BIT(0);
@@ -451,23 +476,6 @@ static int qcom_pcie_init_2_1_0(struct qcom_pcie *pcie)
 	       pci->dbi_base + PCIE20_AXI_MSTR_RESP_COMP_CTRL1);
 
 	return 0;
-
-err_clks:
-	reset_control_assert(res->axi_reset);
-err_deassert_axi:
-	reset_control_assert(res->por_reset);
-err_deassert_por:
-	reset_control_assert(res->pci_reset);
-err_deassert_pci:
-	reset_control_assert(res->phy_reset);
-err_deassert_phy:
-	reset_control_assert(res->ext_reset);
-err_deassert_ext:
-	reset_control_assert(res->ahb_reset);
-err_deassert_ahb:
-	regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
-
-	return ret;
 }
 
 static int qcom_pcie_get_resources_1_0_0(struct qcom_pcie *pcie)
@@ -555,16 +563,6 @@ static int qcom_pcie_init_1_0_0(struct qcom_pcie *pcie)
 		goto err_slave;
 	}
 
-	/* change DBI base address */
-	writel(0, pcie->parf + PCIE20_PARF_DBI_BASE_ADDR);
-
-	if (IS_ENABLED(CONFIG_PCI_MSI)) {
-		u32 val = readl(pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT);
-
-		val |= BIT(31);
-		writel(val, pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT);
-	}
-
 	return 0;
 err_slave:
 	clk_disable_unprepare(res->slave_bus);
@@ -580,6 +578,22 @@ static int qcom_pcie_init_1_0_0(struct qcom_pcie *pcie)
 	return ret;
 }
 
+static int qcom_pcie_post_init_1_0_0(struct qcom_pcie *pcie)
+{
+
+	/* change DBI base address */
+	writel(0, pcie->parf + PCIE20_PARF_DBI_BASE_ADDR);
+
+	if (IS_ENABLED(CONFIG_PCI_MSI)) {
+		u32 val = readl(pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT);
+
+		val |= BIT(31);
+		writel(val, pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT);
+	}
+
+	return 0;
+}
+
 static void qcom_pcie_2_3_2_ltssm_enable(struct qcom_pcie *pcie)
 {
 	u32 val;
@@ -648,7 +662,6 @@ static int qcom_pcie_init_2_3_2(struct qcom_pcie *pcie)
 	struct qcom_pcie_resources_2_3_2 *res = &pcie->res.v2_3_2;
 	struct dw_pcie *pci = pcie->pci;
 	struct device *dev = pci->dev;
-	u32 val;
 	int ret;
 
 	ret = regulator_bulk_enable(ARRAY_SIZE(res->supplies), res->supplies);
@@ -681,27 +694,6 @@ static int qcom_pcie_init_2_3_2(struct qcom_pcie *pcie)
 		goto err_slave_clk;
 	}
 
-	/* enable PCIe clocks and resets */
-	val = readl(pcie->parf + PCIE20_PARF_PHY_CTRL);
-	val &= ~BIT(0);
-	writel(val, pcie->parf + PCIE20_PARF_PHY_CTRL);
-
-	/* change DBI base address */
-	writel(0, pcie->parf + PCIE20_PARF_DBI_BASE_ADDR);
-
-	/* MAC PHY_POWERDOWN MUX DISABLE  */
-	val = readl(pcie->parf + PCIE20_PARF_SYS_CTRL);
-	val &= ~BIT(29);
-	writel(val, pcie->parf + PCIE20_PARF_SYS_CTRL);
-
-	val = readl(pcie->parf + PCIE20_PARF_MHI_CLOCK_RESET_CTRL);
-	val |= BIT(4);
-	writel(val, pcie->parf + PCIE20_PARF_MHI_CLOCK_RESET_CTRL);
-
-	val = readl(pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT_V2);
-	val |= BIT(31);
-	writel(val, pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT_V2);
-
 	return 0;
 
 err_slave_clk:
@@ -722,8 +714,30 @@ static int qcom_pcie_post_init_2_3_2(struct qcom_pcie *pcie)
 	struct qcom_pcie_resources_2_3_2 *res = &pcie->res.v2_3_2;
 	struct dw_pcie *pci = pcie->pci;
 	struct device *dev = pci->dev;
+	u32 val;
 	int ret;
 
+	/* enable PCIe clocks and resets */
+	val = readl(pcie->parf + PCIE20_PARF_PHY_CTRL);
+	val &= ~BIT(0);
+	writel(val, pcie->parf + PCIE20_PARF_PHY_CTRL);
+
+	/* change DBI base address */
+	writel(0, pcie->parf + PCIE20_PARF_DBI_BASE_ADDR);
+
+	/* MAC PHY_POWERDOWN MUX DISABLE  */
+	val = readl(pcie->parf + PCIE20_PARF_SYS_CTRL);
+	val &= ~BIT(29);
+	writel(val, pcie->parf + PCIE20_PARF_SYS_CTRL);
+
+	val = readl(pcie->parf + PCIE20_PARF_MHI_CLOCK_RESET_CTRL);
+	val |= BIT(4);
+	writel(val, pcie->parf + PCIE20_PARF_MHI_CLOCK_RESET_CTRL);
+
+	val = readl(pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT_V2);
+	val |= BIT(31);
+	writel(val, pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT_V2);
+
 	ret = clk_prepare_enable(res->pipe_clk);
 	if (ret) {
 		dev_err(dev, "cannot prepare/enable pipe clock\n");
@@ -837,7 +851,6 @@ static int qcom_pcie_init_2_4_0(struct qcom_pcie *pcie)
 	struct qcom_pcie_resources_2_4_0 *res = &pcie->res.v2_4_0;
 	struct dw_pcie *pci = pcie->pci;
 	struct device *dev = pci->dev;
-	u32 val;
 	int ret;
 
 	ret = reset_control_assert(res->axi_m_reset);
@@ -962,6 +975,33 @@ static int qcom_pcie_init_2_4_0(struct qcom_pcie *pcie)
 	if (ret)
 		goto err_clks;
 
+	return 0;
+
+err_clks:
+	reset_control_assert(res->ahb_reset);
+err_rst_ahb:
+	reset_control_assert(res->pwr_reset);
+err_rst_pwr:
+	reset_control_assert(res->axi_s_reset);
+err_rst_axi_s:
+	reset_control_assert(res->axi_m_sticky_reset);
+err_rst_axi_m_sticky:
+	reset_control_assert(res->axi_m_reset);
+err_rst_axi_m:
+	reset_control_assert(res->pipe_sticky_reset);
+err_rst_pipe_sticky:
+	reset_control_assert(res->pipe_reset);
+err_rst_pipe:
+	reset_control_assert(res->phy_reset);
+err_rst_phy:
+	reset_control_assert(res->phy_ahb_reset);
+	return ret;
+}
+
+static int qcom_pcie_post_init_2_4_0(struct qcom_pcie *pcie)
+{
+	u32 val;
+
 	/* enable PCIe clocks and resets */
 	val = readl(pcie->parf + PCIE20_PARF_PHY_CTRL);
 	val &= ~BIT(0);
@@ -984,26 +1024,6 @@ static int qcom_pcie_init_2_4_0(struct qcom_pcie *pcie)
 	writel(val, pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT_V2);
 
 	return 0;
-
-err_clks:
-	reset_control_assert(res->ahb_reset);
-err_rst_ahb:
-	reset_control_assert(res->pwr_reset);
-err_rst_pwr:
-	reset_control_assert(res->axi_s_reset);
-err_rst_axi_s:
-	reset_control_assert(res->axi_m_sticky_reset);
-err_rst_axi_m_sticky:
-	reset_control_assert(res->axi_m_reset);
-err_rst_axi_m:
-	reset_control_assert(res->pipe_sticky_reset);
-err_rst_pipe_sticky:
-	reset_control_assert(res->pipe_reset);
-err_rst_pipe:
-	reset_control_assert(res->phy_reset);
-err_rst_phy:
-	reset_control_assert(res->phy_ahb_reset);
-	return ret;
 }
 
 static int qcom_pcie_get_resources_2_3_3(struct qcom_pcie *pcie)
@@ -1237,7 +1257,6 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
 	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
 	struct dw_pcie *pci = pcie->pci;
 	struct device *dev = pci->dev;
-	u32 val;
 	int ret;
 
 	ret = regulator_bulk_enable(ARRAY_SIZE(res->supplies), res->supplies);
@@ -1271,6 +1290,28 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
 	/* Wait for reset to complete, required on SM8450 */
 	usleep_range(1000, 1500);
 
+	return 0;
+err_disable_clocks:
+	clk_bulk_disable_unprepare(res->num_clks, res->clks);
+err_disable_regulators:
+	regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
+
+	return ret;
+}
+
+static void qcom_pcie_deinit_2_7_0(struct qcom_pcie *pcie)
+{
+	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
+
+	clk_bulk_disable_unprepare(res->num_clks, res->clks);
+	regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
+}
+
+static int qcom_pcie_post_init_2_7_0(struct qcom_pcie *pcie)
+{
+	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
+	u32 val;
+
 	/* configure PCIe to RC mode */
 	writel(DEVICE_TYPE_RC, pcie->parf + PCIE20_PARF_DEVICE_TYPE);
 
@@ -1297,27 +1338,6 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
 		writel(val, pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT);
 	}
 
-	return 0;
-err_disable_clocks:
-	clk_bulk_disable_unprepare(res->num_clks, res->clks);
-err_disable_regulators:
-	regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
-
-	return ret;
-}
-
-static void qcom_pcie_deinit_2_7_0(struct qcom_pcie *pcie)
-{
-	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
-
-	clk_bulk_disable_unprepare(res->num_clks, res->clks);
-	regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
-}
-
-static int qcom_pcie_post_init_2_7_0(struct qcom_pcie *pcie)
-{
-	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
-
 	/* Set pipe clock as clock source for pcie_pipe_clk_src */
 	if (pcie->cfg->pipe_clk_need_muxing)
 		clk_set_parent(res->pipe_clk_src, res->phy_pipe_clk);
@@ -1569,6 +1589,7 @@ static const struct dw_pcie_host_ops qcom_pcie_dw_ops = {
 static const struct qcom_pcie_ops ops_2_1_0 = {
 	.get_resources = qcom_pcie_get_resources_2_1_0,
 	.init = qcom_pcie_init_2_1_0,
+	.post_init = qcom_pcie_post_init_2_1_0,
 	.deinit = qcom_pcie_deinit_2_1_0,
 	.ltssm_enable = qcom_pcie_2_1_0_ltssm_enable,
 };
@@ -1577,6 +1598,7 @@ static const struct qcom_pcie_ops ops_2_1_0 = {
 static const struct qcom_pcie_ops ops_1_0_0 = {
 	.get_resources = qcom_pcie_get_resources_1_0_0,
 	.init = qcom_pcie_init_1_0_0,
+	.post_init = qcom_pcie_post_init_1_0_0,
 	.deinit = qcom_pcie_deinit_1_0_0,
 	.ltssm_enable = qcom_pcie_2_1_0_ltssm_enable,
 };
@@ -1595,6 +1617,7 @@ static const struct qcom_pcie_ops ops_2_3_2 = {
 static const struct qcom_pcie_ops ops_2_4_0 = {
 	.get_resources = qcom_pcie_get_resources_2_4_0,
 	.init = qcom_pcie_init_2_4_0,
+	.post_init = qcom_pcie_post_init_2_4_0,
 	.deinit = qcom_pcie_deinit_2_4_0,
 	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
 };
-- 
2.36.1

