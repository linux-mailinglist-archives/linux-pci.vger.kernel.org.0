Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BADCF557EEE
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jun 2022 17:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbiFWPuL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Jun 2022 11:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiFWPuL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jun 2022 11:50:11 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE18041626;
        Thu, 23 Jun 2022 08:50:09 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id eq6so21809835edb.6;
        Thu, 23 Jun 2022 08:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4Y+yLSMrdCGUHobF51SbVj+8O8ISeGFP4kiqicTle64=;
        b=bHuccVRWEDzvSbs4CzTQxclGJ3E1xsCwrTPj8YoTs9sFghGzjIkaI/ahK+9YSN0S4Q
         D7Q/qGGevY+rq4Dd6+rwjJ0KjFULS5791x2jvSXIY6/eI+AwQ/B7fahW9C96EwM3fmqn
         JTCOugzltfclHYVwQeYTQTM0yKJ+/WESQFfCC4XCiqmugv708yeq+CcVKb2XCZOdz0qr
         M24UBgzWeUVbOuBifPv/ljoeD/boWIxkK+r5ioqtuEIusVVJvEH4X4fq+bkUmTG9qoVr
         hMa+Y0dCdj705hqziwJkgVlPF9wmM7R65GwA7M41zlMVZwndyk35EIedAXXhYKfvdZl4
         ddOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4Y+yLSMrdCGUHobF51SbVj+8O8ISeGFP4kiqicTle64=;
        b=R7zEg22eDT/rHhzmwstkrdKAzpvPGoZIviLBcQqCfP2qyamhYQGxIaz8rp6rl8VSTA
         +pKCIdAUhlw2/E1moy0y1fdmRThyFAtPQTVt1/l0bYWJhv9W32YS/8JGMQHaBLOovHvn
         O+GY38Lah5s7BuAVueLx3dkNo2V4CxvebtYkJU3LtO/DRoertc6yGHaPBzhtOq4HVlF4
         NnlSIdvtGMjO2NEU4nYbJVjK883k2jW6WVNz2Sf55WvdKbVFjp8ZSb5Y38MrHJlE7bZV
         TlvRvzx+3eOZnix/o0ibf/LIXK2Zz/JPVBh+c8siqQ5JqfLcQG4gNQky11Raor62DuWD
         gqAA==
X-Gm-Message-State: AJIora/TLePC1jjFt65qTKpba4/5CNNKZj3k3a3e5vQafmRZU87AT1co
        FeaF7oeT4uCwbrYkcHEHiLU=
X-Google-Smtp-Source: AGRyM1tm2ORuUsCmuCKLBmlltaHM69A3v7m6o3c5Sz3Andn34zfJuaIE+5MSjENKw6iDTFBIuBvzBg==
X-Received: by 2002:a05:6402:2077:b0:435:a428:76e4 with SMTP id bd23-20020a056402207700b00435a42876e4mr11581115edb.367.1655999408331;
        Thu, 23 Jun 2022 08:50:08 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-98-60.xnet.hr. [88.207.98.60])
        by smtp.googlemail.com with ESMTPSA id g13-20020a170906538d00b00722e1635531sm4846182ejo.193.2022.06.23.08.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 08:50:08 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     svarbanov@mm-sol.com, agross@kernel.org,
        bjorn.andersson@linaro.org, lpieralisi@kernel.org, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com, p.zabel@pengutronix.de,
        jingoohan1@gmail.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        johan+linaro@kernel.org, dmitry.baryshkov@linaro.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v3 2/2] PCI: qcom: move register accesses to .post_init
Date:   Thu, 23 Jun 2022 17:50:04 +0200
Message-Id: <20220623155004.688090-2-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220623155004.688090-1-robimarko@gmail.com>
References: <20220623155004.688090-1-robimarko@gmail.com>
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

Move register accesses from .init to .post_init callbacks to maintain
consinstency for all IP since IPQ8074 specifically requires PHY-s to be
powered on before register access and its accesses have been moved to
.post_init.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 171 ++++++++++++++-----------
 1 file changed, 97 insertions(+), 74 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 24708d5d817d..1aa11f12c069 100644
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

