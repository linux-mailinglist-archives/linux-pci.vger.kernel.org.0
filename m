Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBF255FC15
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jun 2022 11:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232924AbiF2JeD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jun 2022 05:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232910AbiF2JeD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jun 2022 05:34:03 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4164D38BD0;
        Wed, 29 Jun 2022 02:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1656495242; x=1688031242;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=UEubmGg11VtOqxOiF5LZyvt021Nx51xoigARVT6yQCs=;
  b=yP6vWyue//+6pgZaanU+i+3PCLb6na88rMt+Ozvzemx4PD+ylrRx3PIE
   DhjXt1JEaautccrkq+u+UY8PXLD69QV381E+Yv4fwRlK8kGAFgLrC5Y0f
   XxXWmPMomafIPUZheHV+lspTkHiwqOnaYVsGkaVGxrKYLPqyBdzw/NrJa
   g=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 29 Jun 2022 02:34:02 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA; 29 Jun 2022 02:34:00 -0700
X-QCInternal: smtphost
Received: from hu-krichai-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.110.37])
  by ironmsg01-blr.qualcomm.com with ESMTP; 29 Jun 2022 15:03:39 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id A082F423A; Wed, 29 Jun 2022 15:03:39 +0530 (+0530)
From:   Krishna chaitanya chundru <quic_krichai@quicinc.com>
To:     helgaas@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_vbadigan@quicinc.com,
        quic_hemantk@quicinc.com, quic_nitegupt@quicinc.com,
        quic_skananth@quicinc.com, quic_ramkri@quicinc.com,
        manivannan.sadhasivam@linaro.org, swboyd@chromium.org,
        dmitry.baryshkov@linaro.org,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 1/2] PCI: qcom: Add system PM support
Date:   Wed, 29 Jun 2022 15:03:33 +0530
Message-Id: <1656495214-4028-2-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1656495214-4028-1-git-send-email-quic_krichai@quicinc.com>
References: <1656055682-18817-1-git-send-email-quic_krichai@quicinc.com>
 <1656495214-4028-1-git-send-email-quic_krichai@quicinc.com>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add suspend and resume pm callbacks.

When system suspends, and if the link is in L1ss, disable the clocks
so that system enters into low power state to save the maximum power.
And when the system resumes, enable the clocks back if they are
disabled in the suspend path.

Changes since v1:
	- Fixed compilation errors.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 81 ++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 6ab9089..8e9ef37 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -41,6 +41,9 @@
 #define L23_CLK_RMV_DIS				BIT(2)
 #define L1_CLK_RMV_DIS				BIT(1)
 
+#define PCIE20_PARF_PM_STTS                     0x24
+#define PCIE20_PARF_PM_STTS_LINKST_IN_L1SUB    BIT(8)
+
 #define PCIE20_PARF_PHY_CTRL			0x40
 #define PHY_CTRL_PHY_TX0_TERM_OFFSET_MASK	GENMASK(20, 16)
 #define PHY_CTRL_PHY_TX0_TERM_OFFSET(x)		((x) << 16)
@@ -190,6 +193,8 @@ struct qcom_pcie_ops {
 	void (*post_deinit)(struct qcom_pcie *pcie);
 	void (*ltssm_enable)(struct qcom_pcie *pcie);
 	int (*config_sid)(struct qcom_pcie *pcie);
+	int (*enable_clks)(struct qcom_pcie *pcie);
+	int (*disable_clks)(struct qcom_pcie *pcie);
 };
 
 struct qcom_pcie_cfg {
@@ -199,6 +204,7 @@ struct qcom_pcie_cfg {
 	unsigned int has_ddrss_sf_tbu_clk:1;
 	unsigned int has_aggre0_clk:1;
 	unsigned int has_aggre1_clk:1;
+	unsigned int support_pm_ops:1;
 };
 
 struct qcom_pcie {
@@ -209,6 +215,7 @@ struct qcom_pcie {
 	struct phy *phy;
 	struct gpio_desc *reset;
 	const struct qcom_pcie_cfg *cfg;
+	unsigned int is_suspended:1;
 };
 
 #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
@@ -1308,6 +1315,23 @@ static void qcom_pcie_post_deinit_2_7_0(struct qcom_pcie *pcie)
 	clk_disable_unprepare(res->pipe_clk);
 }
 
+static int qcom_pcie_enable_clks_2_7_0(struct qcom_pcie *pcie)
+{
+	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
+
+	return clk_bulk_prepare_enable(res->num_clks, res->clks);
+}
+
+static int qcom_pcie_disable_clks_2_7_0(struct qcom_pcie *pcie)
+{
+	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
+
+	clk_bulk_disable_unprepare(res->num_clks, res->clks);
+
+	return 0;
+}
+
+
 static int qcom_pcie_link_up(struct dw_pcie *pci)
 {
 	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
@@ -1485,6 +1509,8 @@ static const struct qcom_pcie_ops ops_2_7_0 = {
 	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
 	.post_init = qcom_pcie_post_init_2_7_0,
 	.post_deinit = qcom_pcie_post_deinit_2_7_0,
+	.enable_clks = qcom_pcie_enable_clks_2_7_0,
+	.disable_clks = qcom_pcie_disable_clks_2_7_0,
 };
 
 /* Qcom IP rev.: 1.9.0 */
@@ -1548,6 +1574,7 @@ static const struct qcom_pcie_cfg sc7280_cfg = {
 	.ops = &ops_1_9_0,
 	.has_tbu_clk = true,
 	.pipe_clk_need_muxing = true,
+	.support_pm_ops = true,
 };
 
 static const struct dw_pcie_ops dw_pcie_ops = {
@@ -1591,6 +1618,8 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 
 	pcie->cfg = pcie_cfg;
 
+	pcie->is_suspended = false;
+
 	pcie->reset = devm_gpiod_get_optional(dev, "perst", GPIOD_OUT_HIGH);
 	if (IS_ERR(pcie->reset)) {
 		ret = PTR_ERR(pcie->reset);
@@ -1645,6 +1674,57 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static int __maybe_unused qcom_pcie_pm_suspend(struct device *dev)
+{
+	struct qcom_pcie *pcie = dev_get_drvdata(dev);
+	u32 val;
+
+	if (!pcie->cfg->support_pm_ops)
+		return 0;
+
+	/* if the link is not in l1ss don't turn off clocks */
+	val = readl(pcie->parf + PCIE20_PARF_PM_STTS);
+	if (!(val & PCIE20_PARF_PM_STTS_LINKST_IN_L1SUB)) {
+		dev_err(dev, "Link is not in L1ss\n");
+		return 0;
+	}
+
+	if (pcie->cfg->ops->disable_clks)
+		pcie->cfg->ops->disable_clks(pcie);
+
+	if (pcie->cfg->ops->post_deinit)
+		pcie->cfg->ops->post_deinit(pcie);
+
+	pcie->is_suspended = true;
+
+	return 0;
+}
+
+static int __maybe_unused qcom_pcie_pm_resume(struct device *dev)
+{
+	struct qcom_pcie *pcie = dev_get_drvdata(dev);
+
+	if (!pcie->cfg->support_pm_ops)
+		return 0;
+
+	if (!pcie->is_suspended)
+		return 0;
+
+	if (pcie->cfg->ops->enable_clks)
+		pcie->cfg->ops->enable_clks(pcie);
+
+	if (pcie->cfg->ops->post_init)
+		pcie->cfg->ops->post_init(pcie);
+
+	pcie->is_suspended = false;
+
+	return 0;
+}
+
+static const struct dev_pm_ops qcom_pcie_pm_ops = {
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(qcom_pcie_pm_suspend, qcom_pcie_pm_resume)
+};
+
 static const struct of_device_id qcom_pcie_match[] = {
 	{ .compatible = "qcom,pcie-apq8084", .data = &apq8084_cfg },
 	{ .compatible = "qcom,pcie-ipq8064", .data = &ipq8064_cfg },
@@ -1679,6 +1759,7 @@ static struct platform_driver qcom_pcie_driver = {
 	.probe = qcom_pcie_probe,
 	.driver = {
 		.name = "qcom-pcie",
+		.pm = &qcom_pcie_pm_ops,
 		.suppress_bind_attrs = true,
 		.of_match_table = qcom_pcie_match,
 	},
-- 
2.7.4

