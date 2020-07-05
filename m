Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0641F214B5F
	for <lists+linux-pci@lfdr.de>; Sun,  5 Jul 2020 11:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbgGEJS0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 5 Jul 2020 05:18:26 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:47006 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726763AbgGEJS0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 5 Jul 2020 05:18:26 -0400
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 05 Jul 2020 02:18:23 -0700
Received: from sivaprak-linux.qualcomm.com ([10.201.3.202])
  by ironmsg03-sd.qualcomm.com with ESMTP; 05 Jul 2020 02:18:17 -0700
Received: by sivaprak-linux.qualcomm.com (Postfix, from userid 459349)
        id 053CC213CA; Sun,  5 Jul 2020 14:48:10 +0530 (IST)
From:   Sivaprakash Murugesan <sivaprak@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, bhelgaas@google.com,
        robh+dt@kernel.org, kishon@ti.com, vkoul@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, svarbanov@mm-sol.com,
        lorenzo.pieralisi@arm.com, p.zabel@pengutronix.de,
        sivaprak@codeaurora.org, mgautam@codeaurora.org,
        smuthayy@codeaurora.org, varada@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>
Subject: [PATCH 8/9] pci: qcom: Add support for ipq8074 pci controller
Date:   Sun,  5 Jul 2020 14:47:59 +0530
Message-Id: <1593940680-2363-9-git-send-email-sivaprak@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593940680-2363-1-git-send-email-sivaprak@codeaurora.org>
References: <1593940680-2363-1-git-send-email-sivaprak@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

ipq8074 has one gen2 and one gen3 pcie port, with support for gen2 port
is already available add support for pcie gen3 port.

Co-developed-by: Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>
Signed-off-by: Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>
Signed-off-by: Sivaprakash Murugesan <sivaprak@codeaurora.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 175 ++++++++++++++++++++++++++++++++-
 1 file changed, 174 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index aa52a2124760..1a6fafdb2642 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -39,8 +39,17 @@
 #define L23_CLK_RMV_DIS				BIT(2)
 #define L1_CLK_RMV_DIS				BIT(1)
 
+#define PCIE_ATU_CR1_OUTBOUND_6_GEN3		0xC00
+#define PCIE_ATU_CR2_OUTBOUND_6_GEN3		0xC04
+#define PCIE_ATU_LIMIT_OUTBOUND_6_GEN3		0xC10
+#define PCIE_ATU_CR1_OUTBOUND_7_GEN3		0xE00
+#define PCIE_ATU_CR2_OUTBOUND_7_GEN3		0xE04
+#define PCIE_ATU_LOWER_BASE_OUTBOUND_7_GEN3	0xE08
+#define PCIE_ATU_LIMIT_OUTBOUND_7_GEN3		0xE10
+
 #define PCIE20_COMMAND_STATUS			0x04
 #define CMD_BME_VAL				0x4
+#define BUS_MASTER_EN				0x7
 #define PCIE20_DEVICE_CONTROL2_STATUS2		0x98
 #define PCIE_CAP_CPL_TIMEOUT_DISABLE		0x10
 
@@ -49,6 +58,15 @@
 #define PCIE20_PARF_DBI_BASE_ADDR		0x168
 #define PCIE20_PARF_SLV_ADDR_SPACE_SIZE		0x16C
 #define PCIE20_PARF_MHI_CLOCK_RESET_CTRL	0x174
+
+#define AHB_CLK_EN				BIT(0)
+#define MSTR_AXI_CLK_EN				BIT(1)
+#define BYPASS					BIT(4)
+
+#define PCIE20_LNK_CONTROL2_LINK_STATUS2	0xA0
+#define PCIE_CAP_CURR_DEEMPHASIS		BIT(16)
+#define SPEED_GEN3				0x3
+
 #define PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT	0x178
 #define PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT_V2	0x1A8
 #define PCIE20_PARF_LTSSM			0x1B0
@@ -56,6 +74,9 @@
 #define PCIE20_PARF_BDF_TRANSLATE_CFG		0x24C
 #define PCIE20_PARF_DEVICE_TYPE			0x1000
 
+#define PCIE20_PARF_BDF_TO_SID_TABLE		0x2000
+#define BDF_TO_SID_TABLE_SIZE			0x100
+
 #define PCIE20_ELBI_SYS_CTRL			0x04
 #define PCIE20_ELBI_SYS_CTRL_LT_ENABLE		BIT(0)
 
@@ -83,6 +104,10 @@
 
 #define DEVICE_TYPE_RC				0x4
 
+#define PCIE30_GEN3_RELATED_OFF			0x890
+#define RXEQ_RGRDLESS_RXTS			BIT(13)
+#define GEN3_ZRXDC_NONCOMPL			BIT(0)
+
 #define QCOM_PCIE_2_1_0_MAX_SUPPLY	3
 struct qcom_pcie_resources_2_1_0 {
 	struct clk *iface_clk;
@@ -149,6 +174,11 @@ struct qcom_pcie_resources_2_7_0 {
 	struct clk *pipe_clk;
 };
 
+struct qcom_pcie_resources_2_9_0 {
+	struct clk_bulk_data clks[7];
+	struct reset_control *rst[8];
+};
+
 union qcom_pcie_resources {
 	struct qcom_pcie_resources_1_0_0 v1_0_0;
 	struct qcom_pcie_resources_2_1_0 v2_1_0;
@@ -156,6 +186,7 @@ union qcom_pcie_resources {
 	struct qcom_pcie_resources_2_3_3 v2_3_3;
 	struct qcom_pcie_resources_2_4_0 v2_4_0;
 	struct qcom_pcie_resources_2_7_0 v2_7_0;
+	struct qcom_pcie_resources_2_9_0 v2_9_0;
 };
 
 struct qcom_pcie;
@@ -1207,6 +1238,133 @@ static void qcom_pcie_post_deinit_2_7_0(struct qcom_pcie *pcie)
 	clk_disable_unprepare(res->pipe_clk);
 }
 
+static int qcom_pcie_get_resources_2_9_0(struct qcom_pcie *pcie)
+{
+	struct qcom_pcie_resources_2_9_0 *res = &pcie->res.v2_9_0;
+	struct dw_pcie *pci = pcie->pci;
+	struct device *dev = pci->dev;
+	int ret, i;
+	const char *rst_names[] = { "pipe", "sleep", "sticky", "axi_m",
+				    "axi_s", "ahb", "axi_m_sticky",
+				    "axi_s_sticky" };
+
+	res->clks[0].id = "iface";
+	res->clks[1].id = "axi_m";
+	res->clks[2].id = "axi_s";
+	res->clks[3].id = "ahb";
+	res->clks[4].id = "aux";
+	res->clks[5].id = "axi_bridge";
+	res->clks[6].id = "rchng";
+
+	ret = devm_clk_bulk_get(dev, ARRAY_SIZE(res->clks), res->clks);
+	if (ret < 0)
+		return ret;
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
+static int qcom_pcie_init_2_9_0(struct qcom_pcie *pcie)
+{
+	struct qcom_pcie_resources_2_9_0 *res = &pcie->res.v2_9_0;
+	struct dw_pcie *pci = pcie->pci;
+	struct device *dev = pci->dev;
+	int i, ret;
+	u32 val;
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
+	ret = clk_bulk_prepare_enable(ARRAY_SIZE(res->clks), res->clks);
+	if (ret)
+		return ret;
+
+	/* Parf config */
+	writel(SLV_ADDR_SPACE_SZ,
+	       pcie->parf + PCIE20_v3_PARF_SLV_ADDR_SPACE_SIZE);
+
+	val = readl(pcie->parf + PCIE20_PARF_PHY_CTRL);
+	val &= ~BIT(0);
+	writel(val, pcie->parf + PCIE20_PARF_PHY_CTRL);
+
+	writel(0, pcie->parf + PCIE20_PARF_DBI_BASE_ADDR);
+	writel(DEVICE_TYPE_RC, pcie->parf + PCIE20_PARF_DEVICE_TYPE);
+	writel(BYPASS | MSTR_AXI_CLK_EN | AHB_CLK_EN,
+	       pcie->parf + PCIE20_PARF_MHI_CLOCK_RESET_CTRL);
+
+	writel(RXEQ_RGRDLESS_RXTS | GEN3_ZRXDC_NONCOMPL,
+	       pci->dbi_base + PCIE30_GEN3_RELATED_OFF);
+	writel(MST_WAKEUP_EN | SLV_WAKEUP_EN | MSTR_ACLK_CGC_DIS
+		| SLV_ACLK_CGC_DIS | CORE_CLK_CGC_DIS |
+		AUX_PWR_DET | L23_CLK_RMV_DIS | L1_CLK_RMV_DIS,
+		pcie->parf + PCIE20_PARF_SYS_CTRL);
+	writel(0, pcie->parf + PCIE20_PARF_Q2A_FLUSH);
+
+	/* DBI config */
+	writel(BUS_MASTER_EN, pci->dbi_base + PCIE20_COMMAND_STATUS);
+
+	writel(DBI_RO_WR_EN, pci->dbi_base + PCIE20_MISC_CONTROL_1_REG);
+	writel(PCIE_CAP_LINK1_VAL, pci->dbi_base + PCIE20_CAP_LINK_1);
+
+	/* Configure PCIe link capabilities for ASPM */
+	val = readl(pci->dbi_base + PCIE20_CAP_LINK_CAPABILITIES);
+	val &= ~PCIE20_CAP_ACTIVE_STATE_LINK_PM_SUPPORT;
+	writel(val, pci->dbi_base + PCIE20_CAP_LINK_CAPABILITIES);
+
+	writel(PCIE_CAP_CPL_TIMEOUT_DISABLE, pci->dbi_base +
+		PCIE20_DEVICE_CONTROL2_STATUS2);
+
+	writel(PCIE_CAP_CURR_DEEMPHASIS | SPEED_GEN3,
+	       pci->dbi_base + PCIE20_LNK_CONTROL2_LINK_STATUS2);
+
+	for (i = 0 ; i < BDF_TO_SID_TABLE_SIZE ; i++)
+		writel(0x0, pcie->parf + PCIE20_PARF_BDF_TO_SID_TABLE + (4 * i));
+
+	writel(0x4, pci->atu_base + PCIE_ATU_CR1_OUTBOUND_6_GEN3);
+	writel(0x90000000, pci->atu_base + PCIE_ATU_CR2_OUTBOUND_6_GEN3);
+	writel(0x00107FFFF, pci->atu_base + PCIE_ATU_LIMIT_OUTBOUND_6_GEN3);
+	writel(0x5, pci->atu_base + PCIE_ATU_CR1_OUTBOUND_7_GEN3);
+	writel(0x90000000, pci->atu_base + PCIE_ATU_CR2_OUTBOUND_7_GEN3);
+	writel(0x200000, pci->atu_base + PCIE_ATU_LOWER_BASE_OUTBOUND_7_GEN3);
+	writel(0x7FFFFF, pci->atu_base + PCIE_ATU_LIMIT_OUTBOUND_7_GEN3);
+
+	return 0;
+}
+
+static void qcom_pcie_deinit_2_9_0(struct qcom_pcie *pcie)
+{
+	struct qcom_pcie_resources_2_9_0 *res = &pcie->res.v2_9_0;
+
+	clk_bulk_disable_unprepare(ARRAY_SIZE(res->clks), res->clks);
+}
+
 static int qcom_pcie_link_up(struct dw_pcie *pci)
 {
 	u16 val = readw(pci->dbi_base + PCIE20_CAP + PCI_EXP_LNKSTA);
@@ -1246,7 +1404,6 @@ static int qcom_pcie_host_init(struct pcie_port *pp)
 	ret = qcom_pcie_establish_link(pcie);
 	if (ret)
 		goto err;
-
 	return 0;
 err:
 	qcom_ep_reset_assert(pcie);
@@ -1316,6 +1473,14 @@ static const struct qcom_pcie_ops ops_2_7_0 = {
 	.post_deinit = qcom_pcie_post_deinit_2_7_0,
 };
 
+/* Qcom IP rev.: 2.9.0	Synopsys IP rev.: 5.00a */
+static const struct qcom_pcie_ops ops_2_9_0 = {
+	.get_resources = qcom_pcie_get_resources_2_9_0,
+	.init = qcom_pcie_init_2_9_0,
+	.deinit = qcom_pcie_deinit_2_9_0,
+	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
+};
+
 static const struct dw_pcie_ops dw_pcie_ops = {
 	.link_up = qcom_pcie_link_up,
 };
@@ -1358,6 +1523,13 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 		goto err_pm_runtime_put;
 	}
 
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "atu");
+	pci->atu_base = devm_pci_remap_cfg_resource(dev, res);
+	if (IS_ERR(pci->atu_base) && pcie->ops == &ops_2_9_0) {
+		ret = PTR_ERR(pci->atu_base);
+		goto err_pm_runtime_put;
+	}
+
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "parf");
 	pcie->parf = devm_ioremap_resource(dev, res);
 	if (IS_ERR(pcie->parf)) {
@@ -1432,6 +1604,7 @@ static const struct of_device_id qcom_pcie_match[] = {
 	{ .compatible = "qcom,pcie-ipq4019", .data = &ops_2_4_0 },
 	{ .compatible = "qcom,pcie-qcs404", .data = &ops_2_4_0 },
 	{ .compatible = "qcom,pcie-sdm845", .data = &ops_2_7_0 },
+	{ .compatible = "qcom,pcie-ipq8074-gen3", .data = &ops_2_9_0 },
 	{ }
 };
 
-- 
2.7.4

