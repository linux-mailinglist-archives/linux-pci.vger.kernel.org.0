Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD11A552DA2
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jun 2022 10:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348542AbiFUIzX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Jun 2022 04:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348583AbiFUIzL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jun 2022 04:55:11 -0400
Received: from mail.tkos.co.il (mail.tkos.co.il [84.110.109.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A4F2314C;
        Tue, 21 Jun 2022 01:55:08 -0700 (PDT)
Received: from tarshish.tkos.co.il (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.tkos.co.il (Postfix) with ESMTPS id 65FE54409E5;
        Tue, 21 Jun 2022 11:54:41 +0300 (IDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
        s=default; t=1655801682;
        bh=0Y0Ri14xuLP5X+iXRIK2+ymwcmo17downUAEOoFEq6E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WbsQfucmzf3Six2TuN3Utz6U5OjG3xraToSBatkgu1n4e7XK9Cm7W62yvY6J04JxP
         uooEPwOjLoMLxOcSojNfKLYy9u5wHwgpiiKQrWyR5/LrggiN+klRq9HRAPxbQVrX37
         W0pMe2bC2SouGU5n3RF75ux1fAle76OxhVlnOzbp4Se/98op8nvcMT/1Heytxggtb5
         eK7SuSrMTe9w8QN9WU5xIj60fVa4vJYNIIVZALmwFkkXNfXd+GHrbpWSFwMOed3unQ
         I9+/aIc5feUj+EgYoNFqt65G5vlRhCP23fkqXLHYu3L7lH/iLeNTVvL3bIiZCYon0W
         l/xFGIjEmhNxw==
From:   Baruch Siach <baruch@tkos.co.il>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>
Cc:     Selvam Sathappan Periakaruppan <quic_speriaka@quicinc.com>,
        Rob Herring <robh@kernel.org>,
        Robert Marko <robert.marko@sartura.hr>,
        Baruch Siach <baruch.siach@siklu.com>,
        Kathiravan T <quic_kathirav@quicinc.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bryan O'Donoghue <pure.logic@nexus-software.ie>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Johan Hovold <johan@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: [PATCH v8 3/3] PCI: qcom: Add IPQ60xx support
Date:   Tue, 21 Jun 2022 11:54:54 +0300
Message-Id: <f7f848653c99abbf9a0f877949a44e52329543ae.1655799816.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1655799816.git.baruch@tkos.co.il>
References: <cover.1655799816.git.baruch@tkos.co.il>
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

Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Stanimir Varbanov <svarbanov@mm-sol.com>
Tested-by: Robert Marko <robert.marko@sartura.hr>
Signed-off-by: Selvam Sathappan Periakaruppan <quic_speriaka@quicinc.com>
Signed-off-by: Baruch Siach <baruch.siach@siklu.com>
---
v8:

  * Add review, ack, and test tags from Rob, Stanimir, and Robert

Addressed Johan Hovold's comments:

  * Drop reset assert on init error path

  * Code formatting cleanup

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
 drivers/pci/controller/dwc/pcie-qcom.c       | 130 +++++++++++++++++++
 2 files changed, 131 insertions(+)

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
index 5ad9be6372f4..a1f1aca2fb59 100644
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
@@ -1315,6 +1325,112 @@ static void qcom_pcie_post_deinit_2_7_0(struct qcom_pcie *pcie)
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
+	return clk_bulk_prepare_enable(ARRAY_SIZE(res->clks), res->clks);
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
+	writel(GEN3_RELATED_OFF_RXEQ_RGRDLESS_RXTS |
+		GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL,
+		pci->dbi_base + GEN3_RELATED_OFF);
+
+	writel(MST_WAKEUP_EN | SLV_WAKEUP_EN | MSTR_ACLK_CGC_DIS |
+		SLV_ACLK_CGC_DIS | CORE_CLK_CGC_DIS |
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
+		writel(0, pcie->parf + PCIE20_PARF_BDF_TO_SID_TABLE_N + (4 * i));
+
+	return 0;
+}
+
 static int qcom_pcie_link_up(struct dw_pcie *pci)
 {
 	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
@@ -1505,6 +1621,15 @@ static const struct qcom_pcie_ops ops_1_9_0 = {
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
@@ -1569,6 +1694,10 @@ static const struct qcom_pcie_cfg sc8180x_cfg = {
 	.has_tbu_clk = true,
 };
 
+static const struct qcom_pcie_cfg ipq6018_cfg = {
+	.ops = &ops_2_9_0,
+};
+
 static const struct dw_pcie_ops dw_pcie_ops = {
 	.link_up = qcom_pcie_link_up,
 	.start_link = qcom_pcie_start_link,
@@ -1679,6 +1808,7 @@ static const struct of_device_id qcom_pcie_match[] = {
 	{ .compatible = "qcom,pcie-sm8450-pcie0", .data = &sm8450_pcie0_cfg },
 	{ .compatible = "qcom,pcie-sm8450-pcie1", .data = &sm8450_pcie1_cfg },
 	{ .compatible = "qcom,pcie-sc7280", .data = &sc7280_cfg },
+	{ .compatible = "qcom,pcie-ipq6018", .data = &ipq6018_cfg },
 	{ }
 };
 
-- 
2.35.1

