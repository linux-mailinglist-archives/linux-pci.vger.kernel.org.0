Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 882A55479C0
	for <lists+linux-pci@lfdr.de>; Sun, 12 Jun 2022 12:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235984AbiFLKSy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 12 Jun 2022 06:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbiFLKSx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 12 Jun 2022 06:18:53 -0400
Received: from mail.tkos.co.il (mail.tkos.co.il [84.110.109.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 385411D325;
        Sun, 12 Jun 2022 03:18:52 -0700 (PDT)
Received: from tarshish.tkos.co.il (unknown [10.0.8.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.tkos.co.il (Postfix) with ESMTPS id 2AC4344093E;
        Sun, 12 Jun 2022 13:18:34 +0300 (IDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
        s=default; t=1655029114;
        bh=72rLR3ZWabLQRGvDf9HsFCrKRpmbdEQHN8Hm7Oxg5j4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BB49CZgykfhnKXB+DAeAoL0n8+BkFWXS73gMtKAC1IXF+L9fJUqwQ4NjbDG3KXyPN
         od0teFJEz8aW19XPfUNYSFr6XfixfEl+C8tmEV2WZPpFcBirHWZvK4ZBdPkz8pL6xg
         ahob1BWIj1wLInbBW98rSSJ29tXEQbHdbD34jRTkYdNR+1OwnTEMO5aIWd8ZJ3Valq
         AN4CqNA6e/r2FDnQQnX6JlKgcQl3OnRAGCrE8OSVU6gbAey+A4H1pmhGtrGkycPVUz
         Tm+gj9xlrVat2I6kkUT6nZsK/d0TBkAfSMMo4cOwIhiXUI6yrGgic8V7mz58qddV6b
         69grQ0UPyu8pg==
From:   Baruch Siach <baruch@tkos.co.il>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>
Cc:     Selvam Sathappan Periakaruppan <quic_speriaka@quicinc.com>,
        Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>,
        Baruch Siach <baruch.siach@siklu.com>,
        Kathiravan T <quic_kathirav@quicinc.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Bryan O'Donoghue <pure.logic@nexus-software.ie>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: [PATCH v7 3/3] PCI: qcom: Add IPQ60xx support
Date:   Sun, 12 Jun 2022 13:18:35 +0300
Message-Id: <a470b27a642d21e7b3e64d0f3287c0c3521bd182.1655028401.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1655028401.git.baruch@tkos.co.il>
References: <cover.1655028401.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Selvam Sathappan Periakaruppan <quic_speriaka@quicinc.com>

IPQ60xx series of SoCs have one port of PCIe gen 3. Add support for that
platform.

The code is based on downstream[1] Codeaurora kernel v5.4 (branch
win.linuxopenwrt.2.0).

Split out the DBI registers access part from .init into .post_init. DBI
registers are only accessible after phy_power_on().

[1] https://source.codeaurora.org/quic/qsdk/oss/kernel/linux-ipq-5.4/

Signed-off-by: Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>
Signed-off-by: Baruch Siach <baruch.siach@siklu.com>
---
v7:

  * Rebase on v5.19-rc1 (Bjorn Helgaas)

v6:

Address Bjorn Helgaas comments:

  * Rename PCIE_CAP_LINK1_VAL to PCIE_CAP_SLOT_VAL

  * Drop a vague comment about ASPM configuration

  * Add a comment about the source of delay periods

v5:

  * Remove comments from qcom_pcie_init_2_9_0() (Bjorn Andersson)

v4:

  * Rebase on v5.16-rc1

v3:
  * Drop speed setup; rely on generic code (Rob Herring)

  * Drop unused CLK_RATE macros (Bjorn Helgaas)

  * Minor formatting fixes (Bjorn Helgaas)

  * Add reference to downstream Codeaurora kernel tree (Bjorn Helgaas)

v2:
  * Drop ATU configuration; rely on common code instead

  * Use more common register macros

  * Use bulk clk and reset APIs
---
 drivers/pci/controller/dwc/pcie-designware.h |   1 +
 drivers/pci/controller/dwc/pcie-qcom.c       | 140 +++++++++++++++++++
 2 files changed, 141 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index ea87809ee298..279c3778a13b 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -76,6 +76,7 @@
 
 #define GEN3_RELATED_OFF			0x890
 #define GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL	BIT(0)
+#define GEN3_RELATED_OFF_RXEQ_RGRDLESS_RXTS	BIT(13)
 #define GEN3_RELATED_OFF_GEN3_EQ_DISABLE	BIT(16)
 #define GEN3_RELATED_OFF_RATE_SHADOW_SEL_SHIFT	24
 #define GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK	GENMASK(25, 24)
diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 5ad9be6372f4..acfbfc3d32bd 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -52,6 +52,10 @@
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
@@ -184,6 +188,11 @@ struct qcom_pcie_resources_2_7_0 {
 	struct clk *ref_clk_src;
 };
 
+struct qcom_pcie_resources_2_9_0 {
+	struct clk_bulk_data clks[5];
+	struct reset_control *rst;
+};
+
 union qcom_pcie_resources {
 	struct qcom_pcie_resources_1_0_0 v1_0_0;
 	struct qcom_pcie_resources_2_1_0 v2_1_0;
@@ -191,6 +200,7 @@ union qcom_pcie_resources {
 	struct qcom_pcie_resources_2_3_3 v2_3_3;
 	struct qcom_pcie_resources_2_4_0 v2_4_0;
 	struct qcom_pcie_resources_2_7_0 v2_7_0;
+	struct qcom_pcie_resources_2_9_0 v2_9_0;
 };
 
 struct qcom_pcie;
@@ -1315,6 +1325,122 @@ static void qcom_pcie_post_deinit_2_7_0(struct qcom_pcie *pcie)
 	clk_disable_unprepare(res->pipe_clk);
 }
 
+static int qcom_pcie_get_resources_2_9_0(struct qcom_pcie *pcie)
+{
+	struct qcom_pcie_resources_2_9_0 *res = &pcie->res.v2_9_0;
+	struct dw_pcie *pci = pcie->pci;
+	struct device *dev = pci->dev;
+	int ret;
+
+	res->clks[0].id = "iface";
+	res->clks[1].id = "axi_m";
+	res->clks[2].id = "axi_s";
+	res->clks[3].id = "axi_bridge";
+	res->clks[4].id = "rchng";
+
+	ret = devm_clk_bulk_get(dev, ARRAY_SIZE(res->clks), res->clks);
+	if (ret < 0)
+		return ret;
+
+	res->rst = devm_reset_control_array_get_exclusive(dev);
+	if (IS_ERR(res->rst))
+		return PTR_ERR(res->rst);
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
+static int qcom_pcie_init_2_9_0(struct qcom_pcie *pcie)
+{
+	struct qcom_pcie_resources_2_9_0 *res = &pcie->res.v2_9_0;
+	struct device *dev = pcie->pci->dev;
+	int ret;
+
+	ret = reset_control_assert(res->rst);
+	if (ret) {
+		dev_err(dev, "reset assert failed (%d)\n", ret);
+		return ret;
+	}
+
+	/*
+	 * Delay periods before and after reset deassert are working values
+	 * from downstream Codeaurora kernel
+	 */
+	usleep_range(2000, 2500);
+
+	ret = reset_control_deassert(res->rst);
+	if (ret) {
+		dev_err(dev, "reset deassert failed (%d)\n", ret);
+		return ret;
+	}
+
+	usleep_range(2000, 2500);
+
+	ret = clk_bulk_prepare_enable(ARRAY_SIZE(res->clks), res->clks);
+	if (ret)
+		goto err_reset;
+
+	return 0;
+
+err_reset:
+	reset_control_assert(res->rst);
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
+	writel(GEN3_RELATED_OFF_RXEQ_RGRDLESS_RXTS
+		| GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL,
+		pci->dbi_base + GEN3_RELATED_OFF);
+
+	writel(MST_WAKEUP_EN | SLV_WAKEUP_EN | MSTR_ACLK_CGC_DIS
+		| SLV_ACLK_CGC_DIS | CORE_CLK_CGC_DIS |
+		AUX_PWR_DET | L23_CLK_RMV_DIS | L1_CLK_RMV_DIS,
+		pcie->parf + PCIE20_PARF_SYS_CTRL);
+
+	writel(0, pcie->parf + PCIE20_PARF_Q2A_FLUSH);
+
+	dw_pcie_dbi_ro_wr_en(pci);
+	writel(PCIE_CAP_SLOT_VAL, pci->dbi_base + offset + PCI_EXP_SLTCAP);
+
+	val = readl(pci->dbi_base + offset + PCI_EXP_LNKCAP);
+	val &= ~PCI_EXP_LNKCAP_ASPMS;
+	writel(val, pci->dbi_base + offset + PCI_EXP_LNKCAP);
+
+	writel(PCI_EXP_DEVCTL2_COMP_TMOUT_DIS, pci->dbi_base + offset +
+			PCI_EXP_DEVCTL2);
+
+	for (i = 0; i < 256; i++)
+		writel(0x0, pcie->parf + PCIE20_PARF_BDF_TO_SID_TABLE_N
+				+ (4 * i));
+
+	return 0;
+}
+
 static int qcom_pcie_link_up(struct dw_pcie *pci)
 {
 	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
@@ -1505,6 +1631,15 @@ static const struct qcom_pcie_ops ops_1_9_0 = {
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
 static const struct qcom_pcie_cfg apq8084_cfg = {
 	.ops = &ops_1_0_0,
 };
@@ -1569,6 +1704,10 @@ static const struct qcom_pcie_cfg sc8180x_cfg = {
 	.has_tbu_clk = true,
 };
 
+static const struct qcom_pcie_cfg ipq6018_cfg = {
+	.ops = &ops_2_9_0,
+};
+
 static const struct dw_pcie_ops dw_pcie_ops = {
 	.link_up = qcom_pcie_link_up,
 	.start_link = qcom_pcie_start_link,
@@ -1679,6 +1818,7 @@ static const struct of_device_id qcom_pcie_match[] = {
 	{ .compatible = "qcom,pcie-sm8450-pcie0", .data = &sm8450_pcie0_cfg },
 	{ .compatible = "qcom,pcie-sm8450-pcie1", .data = &sm8450_pcie1_cfg },
 	{ .compatible = "qcom,pcie-sc7280", .data = &sc7280_cfg },
+	{ .compatible = "qcom,pcie-ipq6018", .data = &ipq6018_cfg },
 	{ }
 };
 
-- 
2.35.1

