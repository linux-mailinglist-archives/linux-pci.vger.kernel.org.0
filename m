Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80680365776
	for <lists+linux-pci@lfdr.de>; Tue, 20 Apr 2021 13:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbhDTLWU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Apr 2021 07:22:20 -0400
Received: from guitar.tcltek.co.il ([192.115.133.116]:43001 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231642AbhDTLWT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Apr 2021 07:22:19 -0400
Received: from tarshish.tkos.co.il (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id AD3AA440E2F;
        Tue, 20 Apr 2021 14:21:43 +0300 (IDT)
From:   Baruch Siach <baruch@tkos.co.il>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>,
        Baruch Siach <baruch@tkos.co.il>,
        Kathiravan T <kathirav@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/5] PCI: qcom: add support for IPQ60xx PCIe controller
Date:   Tue, 20 Apr 2021 14:21:36 +0300
Message-Id: <c6ff03d1377ea9b5ff40ab283c884aeff6254dd9.1618916235.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1618916235.git.baruch@tkos.co.il>
References: <cover.1618916235.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>

IPQ60xx series of SoCs have one port of PCIe gen 3. Add support for that
platform.

The code is based on downstream Codeaurora kernel v5.4. Split out the
registers access part from .init into .post_init. Registers are only
accessible after phy_power_on().

Signed-off-by: Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 279 +++++++++++++++++++++++++
 1 file changed, 279 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 8a7a300163e5..3e27de744738 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -41,6 +41,31 @@
 #define L23_CLK_RMV_DIS				BIT(2)
 #define L1_CLK_RMV_DIS				BIT(1)
 
+#define PCIE_ATU_CR1_OUTBOUND_6_GEN3		0xC00
+#define PCIE_ATU_CR2_OUTBOUND_6_GEN3		0xC04
+#define PCIE_ATU_LOWER_BASE_OUTBOUND_6_GEN3	0xC08
+#define PCIE_ATU_UPPER_BASE_OUTBOUND_6_GEN3	0xC0C
+#define PCIE_ATU_LIMIT_OUTBOUND_6_GEN3		0xC10
+#define PCIE_ATU_LOWER_TARGET_OUTBOUND_6_GEN3	0xC14
+#define PCIE_ATU_UPPER_TARGET_OUTBOUND_6_GEN3	0xC18
+
+#define PCIE_ATU_CR1_OUTBOUND_7_GEN3		0xE00
+#define PCIE_ATU_CR2_OUTBOUND_7_GEN3		0xE04
+#define PCIE_ATU_LOWER_BASE_OUTBOUND_7_GEN3	0xE08
+#define PCIE_ATU_UPPER_BASE_OUTBOUND_7_GEN3	0xE0C
+#define PCIE_ATU_LIMIT_OUTBOUND_7_GEN3		0xE10
+#define PCIE_ATU_LOWER_TARGET_OUTBOUND_7_GEN3	0xE14
+#define PCIE_ATU_UPPER_TARGET_OUTBOUND_7_GEN3 	0xE18
+
+#define PCIE20_COMMAND_STATUS			0x04
+#define BUS_MASTER_EN				0x7
+#define PCIE20_DEVICE_CONTROL2_STATUS2		0x98
+#define PCIE_CAP_CPL_TIMEOUT_DISABLE		0x10
+#define PCIE30_GEN3_RELATED_OFF			0x890
+
+#define RXEQ_RGRDLESS_RXTS			BIT(13)
+#define GEN3_ZRXDC_NONCOMPL			BIT(0)
+
 #define PCIE20_PARF_PHY_CTRL			0x40
 #define PHY_CTRL_PHY_TX0_TERM_OFFSET_MASK	GENMASK(20, 16)
 #define PHY_CTRL_PHY_TX0_TERM_OFFSET(x)		((x) << 16)
@@ -52,6 +77,10 @@
 #define PCIE20_PARF_DBI_BASE_ADDR		0x168
 #define PCIE20_PARF_SLV_ADDR_SPACE_SIZE		0x16C
 #define PCIE20_PARF_MHI_CLOCK_RESET_CTRL	0x174
+#define AHB_CLK_EN				BIT(0)
+#define MSTR_AXI_CLK_EN				BIT(1)
+#define BYPASS					BIT(4)
+
 #define PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT	0x178
 #define PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT_V2	0x1A8
 #define PCIE20_PARF_LTSSM			0x1B0
@@ -94,6 +123,12 @@
 #define SLV_ADDR_SPACE_SZ			0x10000000
 
 #define PCIE20_LNK_CONTROL2_LINK_STATUS2	0xa0
+#define PCIE_CAP_CURR_DEEMPHASIS		BIT(16)
+#define SPEED_GEN1				0x1
+#define SPEED_GEN2				0x2
+#define SPEED_GEN3				0x3
+#define AXI_CLK_RATE				200000000
+#define RCHNG_CLK_RATE				100000000
 
 #define DEVICE_TYPE_RC				0x4
 
@@ -168,6 +203,15 @@ struct qcom_pcie_resources_2_7_0 {
 	struct clk *pipe_clk;
 };
 
+struct qcom_pcie_resources_2_9_0 {
+	struct clk *iface;
+	struct clk *axi_m_clk;
+	struct clk *axi_s_clk;
+	struct clk *axi_bridge_clk;
+	struct clk *rchng_clk;
+	struct reset_control *rst[8];
+};
+
 union qcom_pcie_resources {
 	struct qcom_pcie_resources_1_0_0 v1_0_0;
 	struct qcom_pcie_resources_2_1_0 v2_1_0;
@@ -175,6 +219,7 @@ union qcom_pcie_resources {
 	struct qcom_pcie_resources_2_3_3 v2_3_3;
 	struct qcom_pcie_resources_2_4_0 v2_4_0;
 	struct qcom_pcie_resources_2_7_0 v2_7_0;
+	struct qcom_pcie_resources_2_9_0 v2_9_0;
 };
 
 struct qcom_pcie;
@@ -1266,6 +1311,225 @@ static void qcom_pcie_post_deinit_2_7_0(struct qcom_pcie *pcie)
 	clk_disable_unprepare(res->pipe_clk);
 }
 
+static int qcom_pcie_get_resources_2_9_0(struct qcom_pcie *pcie)
+{
+	struct qcom_pcie_resources_2_9_0 *res = &pcie->res.v2_9_0;
+	struct dw_pcie *pci = pcie->pci;
+	struct device *dev = pci->dev;
+	int i;
+	const char *rst_names[] = { "pipe", "sleep", "sticky",
+				    "axi_m", "axi_s", "ahb",
+				    "axi_m_sticky", "axi_s_sticky", };
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
+	res->axi_bridge_clk = devm_clk_get(dev, "axi_bridge");
+	if (IS_ERR(res->axi_bridge_clk))
+		return PTR_ERR(res->axi_bridge_clk);
+
+	res->rchng_clk = devm_clk_get(dev, "rchng");
+	if (IS_ERR(res->rchng_clk))
+		return PTR_ERR(res->rchng_clk);
+
+	for (i = 0; i < ARRAY_SIZE(rst_names); i++) {
+		res->rst[i] = devm_reset_control_get(dev, rst_names[i]);
+		if (IS_ERR(res->rst[i])) {
+			return PTR_ERR(res->rst[i]);
+		}
+	}
+
+	return 0;
+}
+
+static void qcom_pcie_deinit_2_9_0(struct qcom_pcie *pcie)
+{
+	struct qcom_pcie_resources_2_9_0 *res = &pcie->res.v2_9_0;
+
+	clk_disable_unprepare(res->axi_m_clk);
+	clk_disable_unprepare(res->axi_s_clk);
+	clk_disable_unprepare(res->axi_bridge_clk);
+	clk_disable_unprepare(res->rchng_clk);
+	clk_disable_unprepare(res->iface);
+}
+
+static int qcom_pcie_init_2_9_0(struct qcom_pcie *pcie)
+{
+	struct qcom_pcie_resources_2_9_0 *res = &pcie->res.v2_9_0;
+	struct device *dev = pcie->pci->dev;
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
+	ret = clk_set_rate(res->axi_m_clk, AXI_CLK_RATE);
+	if (ret) {
+		dev_err(dev, "MClk rate set failed (%d)\n", ret);
+		goto err_clk_axi_m;
+	}
+
+	ret = clk_prepare_enable(res->axi_s_clk);
+	if (ret) {
+		dev_err(dev, "cannot prepare/enable axi slave clock\n");
+		goto err_clk_axi_s;
+	}
+
+	ret = clk_set_rate(res->axi_s_clk, AXI_CLK_RATE);
+	if (ret) {
+		dev_err(dev, "SClk rate set failed (%d)\n", ret);
+		goto err_clk_axi_s;
+	}
+
+	ret = clk_prepare_enable(res->axi_bridge_clk);
+	if (ret) {
+		dev_err(dev, "cannot prepare/enable axi bridge clock\n");
+		goto err_clk_axi_bridge;
+	}
+
+	ret = clk_prepare_enable(res->rchng_clk);
+	if (ret) {
+		dev_err(dev, "cannot prepare/enable rchng clock\n");
+		goto err_clk_rchng;
+	}
+
+	ret = clk_set_rate(res->rchng_clk, RCHNG_CLK_RATE);
+	if (ret) {
+		dev_err(dev, "rchng_clk rate set failed (%d)\n", ret);
+		goto err_clk_rchng;
+	}
+
+	return 0;
+
+err_clk_rchng:
+	clk_disable_unprepare(res->rchng_clk);
+err_clk_axi_bridge:
+	clk_disable_unprepare(res->axi_bridge_clk);
+err_clk_axi_s:
+	clk_disable_unprepare(res->axi_s_clk);
+err_clk_axi_m:
+	clk_disable_unprepare(res->axi_m_clk);
+err_clk_iface:
+	clk_disable_unprepare(res->iface);
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
+static int qcom_pcie_post_init_2_9_0(struct qcom_pcie *pcie)
+{
+	struct dw_pcie *pci = pcie->pci;
+	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	u32 val;
+	int i;
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
+	writel(DEVICE_TYPE_RC, pcie->parf + PCIE20_PARF_DEVICE_TYPE);
+	writel(BYPASS | MSTR_AXI_CLK_EN | AHB_CLK_EN,
+		pcie->parf + PCIE20_PARF_MHI_CLOCK_RESET_CTRL);
+	writel(RXEQ_RGRDLESS_RXTS | GEN3_ZRXDC_NONCOMPL,
+		pci->dbi_base + PCIE30_GEN3_RELATED_OFF);
+
+	writel(MST_WAKEUP_EN | SLV_WAKEUP_EN | MSTR_ACLK_CGC_DIS
+		| SLV_ACLK_CGC_DIS | CORE_CLK_CGC_DIS |
+		AUX_PWR_DET | L23_CLK_RMV_DIS | L1_CLK_RMV_DIS,
+		pcie->parf + PCIE20_PARF_SYS_CTRL);
+
+	writel(0, pcie->parf + PCIE20_PARF_Q2A_FLUSH);
+
+	writel(BUS_MASTER_EN, pci->dbi_base + PCIE20_COMMAND_STATUS);
+
+	writel(DBI_RO_WR_EN, pci->dbi_base + PCIE20_MISC_CONTROL_1_REG);
+	writel(PCIE_CAP_LINK1_VAL, pci->dbi_base + offset + PCI_EXP_SLTCAP);
+
+	/* Configure PCIe link capabilities for ASPM */
+	val = readl(pci->dbi_base + offset + PCI_EXP_LNKCAP);
+	val &= ~PCI_EXP_LNKCAP_ASPMS;
+	writel(val, pci->dbi_base + offset + PCI_EXP_LNKCAP);
+
+	writel(PCIE_CAP_CPL_TIMEOUT_DISABLE, pci->dbi_base +
+		PCIE20_DEVICE_CONTROL2_STATUS2);
+
+	writel(PCIE_CAP_CURR_DEEMPHASIS | SPEED_GEN3,
+			pci->dbi_base + offset + PCI_EXP_DEVCTL2);
+
+	for (i = 0;i < 256;i++)
+		writel(0x0, pcie->parf + PCIE20_PARF_BDF_TO_SID_TABLE_N
+				+ (4 * i));
+
+	writel(0x4, pci->atu_base + PCIE_ATU_CR1_OUTBOUND_6_GEN3);
+	writel(0x90000000, pci->atu_base + PCIE_ATU_CR2_OUTBOUND_6_GEN3);
+	writel(0x0, pci->atu_base + PCIE_ATU_LOWER_BASE_OUTBOUND_6_GEN3);
+	writel(0x0, pci->atu_base + PCIE_ATU_UPPER_BASE_OUTBOUND_6_GEN3);
+	writel(0x00107FFFF, pci->atu_base + PCIE_ATU_LIMIT_OUTBOUND_6_GEN3);
+	writel(0x0, pci->atu_base + PCIE_ATU_LOWER_TARGET_OUTBOUND_6_GEN3);
+	writel(0x0, pci->atu_base + PCIE_ATU_UPPER_TARGET_OUTBOUND_6_GEN3);
+	writel(0x5, pci->atu_base + PCIE_ATU_CR1_OUTBOUND_7_GEN3);
+	writel(0x90000000, pci->atu_base + PCIE_ATU_CR2_OUTBOUND_7_GEN3);
+	writel(0x200000, pci->atu_base + PCIE_ATU_LOWER_BASE_OUTBOUND_7_GEN3);
+	writel(0x0, pci->atu_base + PCIE_ATU_UPPER_BASE_OUTBOUND_7_GEN3);
+	writel(0x7FFFFF, pci->atu_base + PCIE_ATU_LIMIT_OUTBOUND_7_GEN3);
+	writel(0x0, pci->atu_base + PCIE_ATU_LOWER_TARGET_OUTBOUND_7_GEN3);
+	writel(0x0, pci->atu_base + PCIE_ATU_UPPER_TARGET_OUTBOUND_7_GEN3);
+
+	return 0;
+}
+
 static int qcom_pcie_link_up(struct dw_pcie *pci)
 {
 	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
@@ -1456,6 +1720,15 @@ static const struct qcom_pcie_ops ops_1_9_0 = {
 	.config_sid = qcom_pcie_config_sid_sm8250,
 };
 
+/* Qcom IP rev.: 2.9.0  Synopsys IP rev.: 5.00a */
+static const struct qcom_pcie_ops ops_2_9_0 = {
+	.get_resources = qcom_pcie_get_resources_2_9_0,
+	.init = qcom_pcie_init_2_9_0,
+	.post_init = qcom_pcie_post_init_2_9_0,
+	.deinit = qcom_pcie_deinit_2_9_0,
+	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
+};
+
 static const struct dw_pcie_ops dw_pcie_ops = {
 	.link_up = qcom_pcie_link_up,
 	.start_link = qcom_pcie_start_link,
@@ -1508,6 +1781,11 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 		goto err_pm_runtime_put;
 	}
 
+	/* We need ATU for .post_init */
+	pci->atu_base = devm_platform_ioremap_resource_byname(pdev, "atu");
+	if (IS_ERR(pci->atu_base))
+		pci->atu_base = NULL;
+
 	pcie->phy = devm_phy_optional_get(dev, "pciephy");
 	if (IS_ERR(pcie->phy)) {
 		ret = PTR_ERR(pcie->phy);
@@ -1555,6 +1833,7 @@ static const struct of_device_id qcom_pcie_match[] = {
 	{ .compatible = "qcom,pcie-qcs404", .data = &ops_2_4_0 },
 	{ .compatible = "qcom,pcie-sdm845", .data = &ops_2_7_0 },
 	{ .compatible = "qcom,pcie-sm8250", .data = &ops_1_9_0 },
+	{ .compatible = "qcom,pcie-ipq6018", .data = &ops_2_9_0 },
 	{ }
 };
 
-- 
2.30.2

