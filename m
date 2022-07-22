Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D09B57E3F1
	for <lists+linux-pci@lfdr.de>; Fri, 22 Jul 2022 17:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235229AbiGVPtj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Jul 2022 11:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235478AbiGVPtf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Jul 2022 11:49:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9CAC3B94C;
        Fri, 22 Jul 2022 08:49:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2F41CB82916;
        Fri, 22 Jul 2022 15:49:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79F2DC341C6;
        Fri, 22 Jul 2022 15:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658504968;
        bh=nX16+awWZS6ia17Fvu7daGAS+SSgvULs9xsWrxnls+c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ko2dwALHEglyOmE082e8bKAnnb5v6Rqt5Y6wADNnL8OO8m/NTzNIBQTewXgQd1emK
         Itl9pS68cQwkJMEC5Ju0JnCPErRY+KUrZz5/qgbm2spSyIuA1IQfhzIHHm3vzbUm72
         EzrFndXJ2373HXx0kkC4fL86gNXHBa04xX1L52GjLFb0FGAGhkT1skF6mCnFm4EAjY
         BDobFzNYZf2t+bt1C03Lm87U0Z1uF7xgQUZlCkHT7eqq416Ol9CegTV12wyIMzuQUn
         y7WVzJZ5G7ODLVgI6Z8YklS2Z8hXJZoz0A4AZct1/mpclmWPHmwOqfy79sdP71hVqy
         7o8g/9jc0ZSag==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Selvam Sathappan Periakaruppan <quic_speriaka@quicinc.com>,
        Baruch Siach <baruch.siach@siklu.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Robert Marko <robimarko@gmail.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 2/2] PCI: qcom: Sort variants by Qcom IP rev
Date:   Fri, 22 Jul 2022 10:49:19 -0500
Message-Id: <20220722154919.1826027-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220722154919.1826027-1-helgaas@kernel.org>
References: <20220722154919.1826027-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Previously the variant resource structs, ops, etc., were in no obvious
order (mostly but not consistently in *Synopsys* IP rev order, which is not
reflected in the naming).

Reorder them in order of the struct and function names.  No functional
change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 732 ++++++++++++-------------
 1 file changed, 366 insertions(+), 366 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index c27e3494179f..d0237d821323 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -118,17 +118,6 @@
 
 #define QCOM_PCIE_CRC8_POLYNOMIAL (BIT(2) | BIT(1) | BIT(0))
 
-struct qcom_pcie_resources_2_1_0 {
-	struct clk_bulk_data clks[QCOM_PCIE_2_1_0_MAX_CLOCKS];
-	struct reset_control *pci_reset;
-	struct reset_control *axi_reset;
-	struct reset_control *ahb_reset;
-	struct reset_control *por_reset;
-	struct reset_control *phy_reset;
-	struct reset_control *ext_reset;
-	struct regulator_bulk_data supplies[QCOM_PCIE_2_1_0_MAX_SUPPLY];
-};
-
 struct qcom_pcie_resources_1_0_0 {
 	struct clk *iface;
 	struct clk *aux;
@@ -138,6 +127,17 @@ struct qcom_pcie_resources_1_0_0 {
 	struct regulator *vdda;
 };
 
+struct qcom_pcie_resources_2_1_0 {
+	struct clk_bulk_data clks[QCOM_PCIE_2_1_0_MAX_CLOCKS];
+	struct reset_control *pci_reset;
+	struct reset_control *axi_reset;
+	struct reset_control *ahb_reset;
+	struct reset_control *por_reset;
+	struct reset_control *phy_reset;
+	struct reset_control *ext_reset;
+	struct regulator_bulk_data supplies[QCOM_PCIE_2_1_0_MAX_SUPPLY];
+};
+
 #define QCOM_PCIE_2_3_2_MAX_SUPPLY	2
 struct qcom_pcie_resources_2_3_2 {
 	struct clk *aux_clk;
@@ -147,6 +147,15 @@ struct qcom_pcie_resources_2_3_2 {
 	struct regulator_bulk_data supplies[QCOM_PCIE_2_3_2_MAX_SUPPLY];
 };
 
+struct qcom_pcie_resources_2_3_3 {
+	struct clk *iface;
+	struct clk *axi_m_clk;
+	struct clk *axi_s_clk;
+	struct clk *ahb_clk;
+	struct clk *aux_clk;
+	struct reset_control *rst[7];
+};
+
 #define QCOM_PCIE_2_4_0_MAX_CLOCKS	4
 struct qcom_pcie_resources_2_4_0 {
 	struct clk_bulk_data clks[QCOM_PCIE_2_4_0_MAX_CLOCKS];
@@ -165,15 +174,6 @@ struct qcom_pcie_resources_2_4_0 {
 	struct reset_control *phy_ahb_reset;
 };
 
-struct qcom_pcie_resources_2_3_3 {
-	struct clk *iface;
-	struct clk *axi_m_clk;
-	struct clk *axi_s_clk;
-	struct clk *ahb_clk;
-	struct clk *aux_clk;
-	struct reset_control *rst[7];
-};
-
 /* 6 clocks typically, 7 for sm8250 */
 struct qcom_pcie_resources_2_7_0 {
 	struct clk_bulk_data clks[9];
@@ -254,6 +254,121 @@ static int qcom_pcie_start_link(struct dw_pcie *pci)
 	return 0;
 }
 
+static int qcom_pcie_get_resources_1_0_0(struct qcom_pcie *pcie)
+{
+	struct qcom_pcie_resources_1_0_0 *res = &pcie->res.v1_0_0;
+	struct dw_pcie *pci = pcie->pci;
+	struct device *dev = pci->dev;
+
+	res->vdda = devm_regulator_get(dev, "vdda");
+	if (IS_ERR(res->vdda))
+		return PTR_ERR(res->vdda);
+
+	res->iface = devm_clk_get(dev, "iface");
+	if (IS_ERR(res->iface))
+		return PTR_ERR(res->iface);
+
+	res->aux = devm_clk_get(dev, "aux");
+	if (IS_ERR(res->aux))
+		return PTR_ERR(res->aux);
+
+	res->master_bus = devm_clk_get(dev, "master_bus");
+	if (IS_ERR(res->master_bus))
+		return PTR_ERR(res->master_bus);
+
+	res->slave_bus = devm_clk_get(dev, "slave_bus");
+	if (IS_ERR(res->slave_bus))
+		return PTR_ERR(res->slave_bus);
+
+	res->core = devm_reset_control_get_exclusive(dev, "core");
+	return PTR_ERR_OR_ZERO(res->core);
+}
+
+static void qcom_pcie_deinit_1_0_0(struct qcom_pcie *pcie)
+{
+	struct qcom_pcie_resources_1_0_0 *res = &pcie->res.v1_0_0;
+
+	reset_control_assert(res->core);
+	clk_disable_unprepare(res->slave_bus);
+	clk_disable_unprepare(res->master_bus);
+	clk_disable_unprepare(res->iface);
+	clk_disable_unprepare(res->aux);
+	regulator_disable(res->vdda);
+}
+
+static int qcom_pcie_init_1_0_0(struct qcom_pcie *pcie)
+{
+	struct qcom_pcie_resources_1_0_0 *res = &pcie->res.v1_0_0;
+	struct dw_pcie *pci = pcie->pci;
+	struct device *dev = pci->dev;
+	int ret;
+
+	ret = reset_control_deassert(res->core);
+	if (ret) {
+		dev_err(dev, "cannot deassert core reset\n");
+		return ret;
+	}
+
+	ret = clk_prepare_enable(res->aux);
+	if (ret) {
+		dev_err(dev, "cannot prepare/enable aux clock\n");
+		goto err_res;
+	}
+
+	ret = clk_prepare_enable(res->iface);
+	if (ret) {
+		dev_err(dev, "cannot prepare/enable iface clock\n");
+		goto err_aux;
+	}
+
+	ret = clk_prepare_enable(res->master_bus);
+	if (ret) {
+		dev_err(dev, "cannot prepare/enable master_bus clock\n");
+		goto err_iface;
+	}
+
+	ret = clk_prepare_enable(res->slave_bus);
+	if (ret) {
+		dev_err(dev, "cannot prepare/enable slave_bus clock\n");
+		goto err_master;
+	}
+
+	ret = regulator_enable(res->vdda);
+	if (ret) {
+		dev_err(dev, "cannot enable vdda regulator\n");
+		goto err_slave;
+	}
+
+	return 0;
+err_slave:
+	clk_disable_unprepare(res->slave_bus);
+err_master:
+	clk_disable_unprepare(res->master_bus);
+err_iface:
+	clk_disable_unprepare(res->iface);
+err_aux:
+	clk_disable_unprepare(res->aux);
+err_res:
+	reset_control_assert(res->core);
+
+	return ret;
+}
+
+static int qcom_pcie_post_init_1_0_0(struct qcom_pcie *pcie)
+{
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
 static void qcom_pcie_2_1_0_ltssm_enable(struct qcom_pcie *pcie)
 {
 	u32 val;
@@ -469,121 +584,6 @@ static int qcom_pcie_post_init_2_1_0(struct qcom_pcie *pcie)
 	return 0;
 }
 
-static int qcom_pcie_get_resources_1_0_0(struct qcom_pcie *pcie)
-{
-	struct qcom_pcie_resources_1_0_0 *res = &pcie->res.v1_0_0;
-	struct dw_pcie *pci = pcie->pci;
-	struct device *dev = pci->dev;
-
-	res->vdda = devm_regulator_get(dev, "vdda");
-	if (IS_ERR(res->vdda))
-		return PTR_ERR(res->vdda);
-
-	res->iface = devm_clk_get(dev, "iface");
-	if (IS_ERR(res->iface))
-		return PTR_ERR(res->iface);
-
-	res->aux = devm_clk_get(dev, "aux");
-	if (IS_ERR(res->aux))
-		return PTR_ERR(res->aux);
-
-	res->master_bus = devm_clk_get(dev, "master_bus");
-	if (IS_ERR(res->master_bus))
-		return PTR_ERR(res->master_bus);
-
-	res->slave_bus = devm_clk_get(dev, "slave_bus");
-	if (IS_ERR(res->slave_bus))
-		return PTR_ERR(res->slave_bus);
-
-	res->core = devm_reset_control_get_exclusive(dev, "core");
-	return PTR_ERR_OR_ZERO(res->core);
-}
-
-static void qcom_pcie_deinit_1_0_0(struct qcom_pcie *pcie)
-{
-	struct qcom_pcie_resources_1_0_0 *res = &pcie->res.v1_0_0;
-
-	reset_control_assert(res->core);
-	clk_disable_unprepare(res->slave_bus);
-	clk_disable_unprepare(res->master_bus);
-	clk_disable_unprepare(res->iface);
-	clk_disable_unprepare(res->aux);
-	regulator_disable(res->vdda);
-}
-
-static int qcom_pcie_init_1_0_0(struct qcom_pcie *pcie)
-{
-	struct qcom_pcie_resources_1_0_0 *res = &pcie->res.v1_0_0;
-	struct dw_pcie *pci = pcie->pci;
-	struct device *dev = pci->dev;
-	int ret;
-
-	ret = reset_control_deassert(res->core);
-	if (ret) {
-		dev_err(dev, "cannot deassert core reset\n");
-		return ret;
-	}
-
-	ret = clk_prepare_enable(res->aux);
-	if (ret) {
-		dev_err(dev, "cannot prepare/enable aux clock\n");
-		goto err_res;
-	}
-
-	ret = clk_prepare_enable(res->iface);
-	if (ret) {
-		dev_err(dev, "cannot prepare/enable iface clock\n");
-		goto err_aux;
-	}
-
-	ret = clk_prepare_enable(res->master_bus);
-	if (ret) {
-		dev_err(dev, "cannot prepare/enable master_bus clock\n");
-		goto err_iface;
-	}
-
-	ret = clk_prepare_enable(res->slave_bus);
-	if (ret) {
-		dev_err(dev, "cannot prepare/enable slave_bus clock\n");
-		goto err_master;
-	}
-
-	ret = regulator_enable(res->vdda);
-	if (ret) {
-		dev_err(dev, "cannot enable vdda regulator\n");
-		goto err_slave;
-	}
-
-	return 0;
-err_slave:
-	clk_disable_unprepare(res->slave_bus);
-err_master:
-	clk_disable_unprepare(res->master_bus);
-err_iface:
-	clk_disable_unprepare(res->iface);
-err_aux:
-	clk_disable_unprepare(res->aux);
-err_res:
-	reset_control_assert(res->core);
-
-	return ret;
-}
-
-static int qcom_pcie_post_init_1_0_0(struct qcom_pcie *pcie)
-{
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
-	return 0;
-}
-
 static void qcom_pcie_2_3_2_ltssm_enable(struct qcom_pcie *pcie)
 {
 	u32 val;
@@ -719,6 +719,174 @@ static int qcom_pcie_post_init_2_3_2(struct qcom_pcie *pcie)
 	return 0;
 }
 
+static int qcom_pcie_get_resources_2_3_3(struct qcom_pcie *pcie)
+{
+	struct qcom_pcie_resources_2_3_3 *res = &pcie->res.v2_3_3;
+	struct dw_pcie *pci = pcie->pci;
+	struct device *dev = pci->dev;
+	int i;
+	const char *rst_names[] = { "axi_m", "axi_s", "pipe",
+				    "axi_m_sticky", "sticky",
+				    "ahb", "sleep", };
+
+	res->iface = devm_clk_get(dev, "iface");
+	if (IS_ERR(res->iface))
+		return PTR_ERR(res->iface);
+
+	res->axi_m_clk = devm_clk_get(dev, "axi_m");
+	if (IS_ERR(res->axi_m_clk))
+		return PTR_ERR(res->axi_m_clk);
+
+	res->axi_s_clk = devm_clk_get(dev, "axi_s");
+	if (IS_ERR(res->axi_s_clk))
+		return PTR_ERR(res->axi_s_clk);
+
+	res->ahb_clk = devm_clk_get(dev, "ahb");
+	if (IS_ERR(res->ahb_clk))
+		return PTR_ERR(res->ahb_clk);
+
+	res->aux_clk = devm_clk_get(dev, "aux");
+	if (IS_ERR(res->aux_clk))
+		return PTR_ERR(res->aux_clk);
+
+	for (i = 0; i < ARRAY_SIZE(rst_names); i++) {
+		res->rst[i] = devm_reset_control_get(dev, rst_names[i]);
+		if (IS_ERR(res->rst[i]))
+			return PTR_ERR(res->rst[i]);
+	}
+
+	return 0;
+}
+
+static void qcom_pcie_deinit_2_3_3(struct qcom_pcie *pcie)
+{
+	struct qcom_pcie_resources_2_3_3 *res = &pcie->res.v2_3_3;
+
+	clk_disable_unprepare(res->iface);
+	clk_disable_unprepare(res->axi_m_clk);
+	clk_disable_unprepare(res->axi_s_clk);
+	clk_disable_unprepare(res->ahb_clk);
+	clk_disable_unprepare(res->aux_clk);
+}
+
+static int qcom_pcie_init_2_3_3(struct qcom_pcie *pcie)
+{
+	struct qcom_pcie_resources_2_3_3 *res = &pcie->res.v2_3_3;
+	struct dw_pcie *pci = pcie->pci;
+	struct device *dev = pci->dev;
+	int i, ret;
+
+	for (i = 0; i < ARRAY_SIZE(res->rst); i++) {
+		ret = reset_control_assert(res->rst[i]);
+		if (ret) {
+			dev_err(dev, "reset #%d assert failed (%d)\n", i, ret);
+			return ret;
+		}
+	}
+
+	usleep_range(2000, 2500);
+
+	for (i = 0; i < ARRAY_SIZE(res->rst); i++) {
+		ret = reset_control_deassert(res->rst[i]);
+		if (ret) {
+			dev_err(dev, "reset #%d deassert failed (%d)\n", i,
+				ret);
+			return ret;
+		}
+	}
+
+	/*
+	 * Don't have a way to see if the reset has completed.
+	 * Wait for some time.
+	 */
+	usleep_range(2000, 2500);
+
+	ret = clk_prepare_enable(res->iface);
+	if (ret) {
+		dev_err(dev, "cannot prepare/enable core clock\n");
+		goto err_clk_iface;
+	}
+
+	ret = clk_prepare_enable(res->axi_m_clk);
+	if (ret) {
+		dev_err(dev, "cannot prepare/enable core clock\n");
+		goto err_clk_axi_m;
+	}
+
+	ret = clk_prepare_enable(res->axi_s_clk);
+	if (ret) {
+		dev_err(dev, "cannot prepare/enable axi slave clock\n");
+		goto err_clk_axi_s;
+	}
+
+	ret = clk_prepare_enable(res->ahb_clk);
+	if (ret) {
+		dev_err(dev, "cannot prepare/enable ahb clock\n");
+		goto err_clk_ahb;
+	}
+
+	ret = clk_prepare_enable(res->aux_clk);
+	if (ret) {
+		dev_err(dev, "cannot prepare/enable aux clock\n");
+		goto err_clk_aux;
+	}
+
+	return 0;
+
+err_clk_aux:
+	clk_disable_unprepare(res->ahb_clk);
+err_clk_ahb:
+	clk_disable_unprepare(res->axi_s_clk);
+err_clk_axi_s:
+	clk_disable_unprepare(res->axi_m_clk);
+err_clk_axi_m:
+	clk_disable_unprepare(res->iface);
+err_clk_iface:
+	/*
+	 * Not checking for failure, will anyway return
+	 * the original failure in 'ret'.
+	 */
+	for (i = 0; i < ARRAY_SIZE(res->rst); i++)
+		reset_control_assert(res->rst[i]);
+
+	return ret;
+}
+
+static int qcom_pcie_post_init_2_3_3(struct qcom_pcie *pcie)
+{
+	struct dw_pcie *pci = pcie->pci;
+	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	u32 val;
+
+	writel(SLV_ADDR_SPACE_SZ,
+		pcie->parf + PCIE20_v3_PARF_SLV_ADDR_SPACE_SIZE);
+
+	val = readl(pcie->parf + PCIE20_PARF_PHY_CTRL);
+	val &= ~BIT(0);
+	writel(val, pcie->parf + PCIE20_PARF_PHY_CTRL);
+
+	writel(0, pcie->parf + PCIE20_PARF_DBI_BASE_ADDR);
+
+	writel(MST_WAKEUP_EN | SLV_WAKEUP_EN | MSTR_ACLK_CGC_DIS
+		| SLV_ACLK_CGC_DIS | CORE_CLK_CGC_DIS |
+		AUX_PWR_DET | L23_CLK_RMV_DIS | L1_CLK_RMV_DIS,
+		pcie->parf + PCIE20_PARF_SYS_CTRL);
+	writel(0, pcie->parf + PCIE20_PARF_Q2A_FLUSH);
+
+	writel(PCI_COMMAND_MASTER, pci->dbi_base + PCI_COMMAND);
+	writel(DBI_RO_WR_EN, pci->dbi_base + PCIE20_MISC_CONTROL_1_REG);
+	writel(PCIE_CAP_SLOT_VAL, pci->dbi_base + offset + PCI_EXP_SLTCAP);
+
+	val = readl(pci->dbi_base + offset + PCI_EXP_LNKCAP);
+	val &= ~PCI_EXP_LNKCAP_ASPMS;
+	writel(val, pci->dbi_base + offset + PCI_EXP_LNKCAP);
+
+	writel(PCI_EXP_DEVCTL2_COMP_TMOUT_DIS, pci->dbi_base + offset +
+		PCI_EXP_DEVCTL2);
+
+	return 0;
+}
+
 static int qcom_pcie_get_resources_2_4_0(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_resources_2_4_0 *res = &pcie->res.v2_4_0;
@@ -998,174 +1166,6 @@ static int qcom_pcie_post_init_2_4_0(struct qcom_pcie *pcie)
 	return 0;
 }
 
-static int qcom_pcie_get_resources_2_3_3(struct qcom_pcie *pcie)
-{
-	struct qcom_pcie_resources_2_3_3 *res = &pcie->res.v2_3_3;
-	struct dw_pcie *pci = pcie->pci;
-	struct device *dev = pci->dev;
-	int i;
-	const char *rst_names[] = { "axi_m", "axi_s", "pipe",
-				    "axi_m_sticky", "sticky",
-				    "ahb", "sleep", };
-
-	res->iface = devm_clk_get(dev, "iface");
-	if (IS_ERR(res->iface))
-		return PTR_ERR(res->iface);
-
-	res->axi_m_clk = devm_clk_get(dev, "axi_m");
-	if (IS_ERR(res->axi_m_clk))
-		return PTR_ERR(res->axi_m_clk);
-
-	res->axi_s_clk = devm_clk_get(dev, "axi_s");
-	if (IS_ERR(res->axi_s_clk))
-		return PTR_ERR(res->axi_s_clk);
-
-	res->ahb_clk = devm_clk_get(dev, "ahb");
-	if (IS_ERR(res->ahb_clk))
-		return PTR_ERR(res->ahb_clk);
-
-	res->aux_clk = devm_clk_get(dev, "aux");
-	if (IS_ERR(res->aux_clk))
-		return PTR_ERR(res->aux_clk);
-
-	for (i = 0; i < ARRAY_SIZE(rst_names); i++) {
-		res->rst[i] = devm_reset_control_get(dev, rst_names[i]);
-		if (IS_ERR(res->rst[i]))
-			return PTR_ERR(res->rst[i]);
-	}
-
-	return 0;
-}
-
-static void qcom_pcie_deinit_2_3_3(struct qcom_pcie *pcie)
-{
-	struct qcom_pcie_resources_2_3_3 *res = &pcie->res.v2_3_3;
-
-	clk_disable_unprepare(res->iface);
-	clk_disable_unprepare(res->axi_m_clk);
-	clk_disable_unprepare(res->axi_s_clk);
-	clk_disable_unprepare(res->ahb_clk);
-	clk_disable_unprepare(res->aux_clk);
-}
-
-static int qcom_pcie_init_2_3_3(struct qcom_pcie *pcie)
-{
-	struct qcom_pcie_resources_2_3_3 *res = &pcie->res.v2_3_3;
-	struct dw_pcie *pci = pcie->pci;
-	struct device *dev = pci->dev;
-	int i, ret;
-
-	for (i = 0; i < ARRAY_SIZE(res->rst); i++) {
-		ret = reset_control_assert(res->rst[i]);
-		if (ret) {
-			dev_err(dev, "reset #%d assert failed (%d)\n", i, ret);
-			return ret;
-		}
-	}
-
-	usleep_range(2000, 2500);
-
-	for (i = 0; i < ARRAY_SIZE(res->rst); i++) {
-		ret = reset_control_deassert(res->rst[i]);
-		if (ret) {
-			dev_err(dev, "reset #%d deassert failed (%d)\n", i,
-				ret);
-			return ret;
-		}
-	}
-
-	/*
-	 * Don't have a way to see if the reset has completed.
-	 * Wait for some time.
-	 */
-	usleep_range(2000, 2500);
-
-	ret = clk_prepare_enable(res->iface);
-	if (ret) {
-		dev_err(dev, "cannot prepare/enable core clock\n");
-		goto err_clk_iface;
-	}
-
-	ret = clk_prepare_enable(res->axi_m_clk);
-	if (ret) {
-		dev_err(dev, "cannot prepare/enable core clock\n");
-		goto err_clk_axi_m;
-	}
-
-	ret = clk_prepare_enable(res->axi_s_clk);
-	if (ret) {
-		dev_err(dev, "cannot prepare/enable axi slave clock\n");
-		goto err_clk_axi_s;
-	}
-
-	ret = clk_prepare_enable(res->ahb_clk);
-	if (ret) {
-		dev_err(dev, "cannot prepare/enable ahb clock\n");
-		goto err_clk_ahb;
-	}
-
-	ret = clk_prepare_enable(res->aux_clk);
-	if (ret) {
-		dev_err(dev, "cannot prepare/enable aux clock\n");
-		goto err_clk_aux;
-	}
-
-	return 0;
-
-err_clk_aux:
-	clk_disable_unprepare(res->ahb_clk);
-err_clk_ahb:
-	clk_disable_unprepare(res->axi_s_clk);
-err_clk_axi_s:
-	clk_disable_unprepare(res->axi_m_clk);
-err_clk_axi_m:
-	clk_disable_unprepare(res->iface);
-err_clk_iface:
-	/*
-	 * Not checking for failure, will anyway return
-	 * the original failure in 'ret'.
-	 */
-	for (i = 0; i < ARRAY_SIZE(res->rst); i++)
-		reset_control_assert(res->rst[i]);
-
-	return ret;
-}
-
-static int qcom_pcie_post_init_2_3_3(struct qcom_pcie *pcie)
-{
-	struct dw_pcie *pci = pcie->pci;
-	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
-	u32 val;
-
-	writel(SLV_ADDR_SPACE_SZ,
-		pcie->parf + PCIE20_v3_PARF_SLV_ADDR_SPACE_SIZE);
-
-	val = readl(pcie->parf + PCIE20_PARF_PHY_CTRL);
-	val &= ~BIT(0);
-	writel(val, pcie->parf + PCIE20_PARF_PHY_CTRL);
-
-	writel(0, pcie->parf + PCIE20_PARF_DBI_BASE_ADDR);
-
-	writel(MST_WAKEUP_EN | SLV_WAKEUP_EN | MSTR_ACLK_CGC_DIS
-		| SLV_ACLK_CGC_DIS | CORE_CLK_CGC_DIS |
-		AUX_PWR_DET | L23_CLK_RMV_DIS | L1_CLK_RMV_DIS,
-		pcie->parf + PCIE20_PARF_SYS_CTRL);
-	writel(0, pcie->parf + PCIE20_PARF_Q2A_FLUSH);
-
-	writel(PCI_COMMAND_MASTER, pci->dbi_base + PCI_COMMAND);
-	writel(DBI_RO_WR_EN, pci->dbi_base + PCIE20_MISC_CONTROL_1_REG);
-	writel(PCIE_CAP_SLOT_VAL, pci->dbi_base + offset + PCI_EXP_SLTCAP);
-
-	val = readl(pci->dbi_base + offset + PCI_EXP_LNKCAP);
-	val &= ~PCI_EXP_LNKCAP_ASPMS;
-	writel(val, pci->dbi_base + offset + PCI_EXP_LNKCAP);
-
-	writel(PCI_EXP_DEVCTL2_COMP_TMOUT_DIS, pci->dbi_base + offset +
-		PCI_EXP_DEVCTL2);
-
-	return 0;
-}
-
 static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
@@ -1530,15 +1530,6 @@ static const struct dw_pcie_host_ops qcom_pcie_dw_ops = {
 	.host_init = qcom_pcie_host_init,
 };
 
-/* Qcom IP rev.: 2.1.0	Synopsys IP rev.: 4.01a */
-static const struct qcom_pcie_ops ops_2_1_0 = {
-	.get_resources = qcom_pcie_get_resources_2_1_0,
-	.init = qcom_pcie_init_2_1_0,
-	.post_init = qcom_pcie_post_init_2_1_0,
-	.deinit = qcom_pcie_deinit_2_1_0,
-	.ltssm_enable = qcom_pcie_2_1_0_ltssm_enable,
-};
-
 /* Qcom IP rev.: 1.0.0	Synopsys IP rev.: 4.11a */
 static const struct qcom_pcie_ops ops_1_0_0 = {
 	.get_resources = qcom_pcie_get_resources_1_0_0,
@@ -1548,6 +1539,24 @@ static const struct qcom_pcie_ops ops_1_0_0 = {
 	.ltssm_enable = qcom_pcie_2_1_0_ltssm_enable,
 };
 
+/* Qcom IP rev.: 1.9.0 */
+static const struct qcom_pcie_ops ops_1_9_0 = {
+	.get_resources = qcom_pcie_get_resources_2_7_0,
+	.init = qcom_pcie_init_2_7_0,
+	.deinit = qcom_pcie_deinit_2_7_0,
+	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
+	.config_sid = qcom_pcie_config_sid_sm8250,
+};
+
+/* Qcom IP rev.: 2.1.0	Synopsys IP rev.: 4.01a */
+static const struct qcom_pcie_ops ops_2_1_0 = {
+	.get_resources = qcom_pcie_get_resources_2_1_0,
+	.init = qcom_pcie_init_2_1_0,
+	.post_init = qcom_pcie_post_init_2_1_0,
+	.deinit = qcom_pcie_deinit_2_1_0,
+	.ltssm_enable = qcom_pcie_2_1_0_ltssm_enable,
+};
+
 /* Qcom IP rev.: 2.3.2	Synopsys IP rev.: 4.21a */
 static const struct qcom_pcie_ops ops_2_3_2 = {
 	.get_resources = qcom_pcie_get_resources_2_3_2,
@@ -1557,15 +1566,6 @@ static const struct qcom_pcie_ops ops_2_3_2 = {
 	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
 };
 
-/* Qcom IP rev.: 2.4.0	Synopsys IP rev.: 4.20a */
-static const struct qcom_pcie_ops ops_2_4_0 = {
-	.get_resources = qcom_pcie_get_resources_2_4_0,
-	.init = qcom_pcie_init_2_4_0,
-	.post_init = qcom_pcie_post_init_2_4_0,
-	.deinit = qcom_pcie_deinit_2_4_0,
-	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
-};
-
 /* Qcom IP rev.: 2.3.3	Synopsys IP rev.: 4.30a */
 static const struct qcom_pcie_ops ops_2_3_3 = {
 	.get_resources = qcom_pcie_get_resources_2_3_3,
@@ -1575,6 +1575,15 @@ static const struct qcom_pcie_ops ops_2_3_3 = {
 	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
 };
 
+/* Qcom IP rev.: 2.4.0	Synopsys IP rev.: 4.20a */
+static const struct qcom_pcie_ops ops_2_4_0 = {
+	.get_resources = qcom_pcie_get_resources_2_4_0,
+	.init = qcom_pcie_init_2_4_0,
+	.post_init = qcom_pcie_post_init_2_4_0,
+	.deinit = qcom_pcie_deinit_2_4_0,
+	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
+};
+
 /* Qcom IP rev.: 2.7.0	Synopsys IP rev.: 4.30a */
 static const struct qcom_pcie_ops ops_2_7_0 = {
 	.get_resources = qcom_pcie_get_resources_2_7_0,
@@ -1583,15 +1592,6 @@ static const struct qcom_pcie_ops ops_2_7_0 = {
 	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
 };
 
-/* Qcom IP rev.: 1.9.0 */
-static const struct qcom_pcie_ops ops_1_9_0 = {
-	.get_resources = qcom_pcie_get_resources_2_7_0,
-	.init = qcom_pcie_init_2_7_0,
-	.deinit = qcom_pcie_deinit_2_7_0,
-	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
-	.config_sid = qcom_pcie_config_sid_sm8250,
-};
-
 /* Qcom IP rev.: 2.9.0  Synopsys IP rev.: 5.00a */
 static const struct qcom_pcie_ops ops_2_9_0 = {
 	.get_resources = qcom_pcie_get_resources_2_9_0,
@@ -1605,6 +1605,42 @@ static const struct qcom_pcie_cfg apq8084_cfg = {
 	.ops = &ops_1_0_0,
 };
 
+static const struct qcom_pcie_cfg sm8150_cfg = {
+	/* sm8150 has qcom IP rev 1.5.0. However 1.5.0 ops are same as
+	 * 1.9.0, so reuse the same.
+	 */
+	.ops = &ops_1_9_0,
+};
+
+static const struct qcom_pcie_cfg sm8250_cfg = {
+	.ops = &ops_1_9_0,
+	.has_tbu_clk = true,
+	.has_ddrss_sf_tbu_clk = true,
+};
+
+static const struct qcom_pcie_cfg sm8450_pcie0_cfg = {
+	.ops = &ops_1_9_0,
+	.has_ddrss_sf_tbu_clk = true,
+	.has_aggre0_clk = true,
+	.has_aggre1_clk = true,
+};
+
+static const struct qcom_pcie_cfg sm8450_pcie1_cfg = {
+	.ops = &ops_1_9_0,
+	.has_ddrss_sf_tbu_clk = true,
+	.has_aggre1_clk = true,
+};
+
+static const struct qcom_pcie_cfg sc7280_cfg = {
+	.ops = &ops_1_9_0,
+	.has_tbu_clk = true,
+};
+
+static const struct qcom_pcie_cfg sc8180x_cfg = {
+	.ops = &ops_1_9_0,
+	.has_tbu_clk = true,
+};
+
 static const struct qcom_pcie_cfg ipq8064_cfg = {
 	.ops = &ops_2_1_0,
 };
@@ -1626,42 +1662,6 @@ static const struct qcom_pcie_cfg sdm845_cfg = {
 	.has_tbu_clk = true,
 };
 
-static const struct qcom_pcie_cfg sm8150_cfg = {
-	/* sm8150 has qcom IP rev 1.5.0. However 1.5.0 ops are same as
-	 * 1.9.0, so reuse the same.
-	 */
-	.ops = &ops_1_9_0,
-};
-
-static const struct qcom_pcie_cfg sm8250_cfg = {
-	.ops = &ops_1_9_0,
-	.has_tbu_clk = true,
-	.has_ddrss_sf_tbu_clk = true,
-};
-
-static const struct qcom_pcie_cfg sm8450_pcie0_cfg = {
-	.ops = &ops_1_9_0,
-	.has_ddrss_sf_tbu_clk = true,
-	.has_aggre0_clk = true,
-	.has_aggre1_clk = true,
-};
-
-static const struct qcom_pcie_cfg sm8450_pcie1_cfg = {
-	.ops = &ops_1_9_0,
-	.has_ddrss_sf_tbu_clk = true,
-	.has_aggre1_clk = true,
-};
-
-static const struct qcom_pcie_cfg sc7280_cfg = {
-	.ops = &ops_1_9_0,
-	.has_tbu_clk = true,
-};
-
-static const struct qcom_pcie_cfg sc8180x_cfg = {
-	.ops = &ops_1_9_0,
-	.has_tbu_clk = true,
-};
-
 static const struct qcom_pcie_cfg ipq6018_cfg = {
 	.ops = &ops_2_9_0,
 };
-- 
2.25.1

