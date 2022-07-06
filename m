Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADEED568B7F
	for <lists+linux-pci@lfdr.de>; Wed,  6 Jul 2022 16:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbiGFOkt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Jul 2022 10:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbiGFOks (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Jul 2022 10:40:48 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589201BEB1;
        Wed,  6 Jul 2022 07:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657118447; x=1688654447;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=1Q1SPmE0TB1MVOFbFlru5xZOjHqxMMtJaGfhUic804Q=;
  b=GeLJKkOVn+6yrjwkmou0oMZx8TvwZmdZ9eSS6iN7Kba39AQuGAbGFYWc
   693oWWXIfYqMQd5MOLTMfjehECmp/NULK2GLqPXIpVyI9OLyz9DRGK1IB
   rMM21ro+omLf+vIvFy7GukIk3KOJhVbdbZGvgeF3KgAubW2zKiF0yWjvY
   4=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 06 Jul 2022 07:40:46 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 06 Jul 2022 07:40:45 -0700
X-QCInternal: smtphost
Received: from hu-krichai-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.110.37])
  by ironmsg02-blr.qualcomm.com with ESMTP; 06 Jul 2022 20:10:27 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id 94EF742A3; Wed,  6 Jul 2022 20:10:26 +0530 (+0530)
From:   Krishna chaitanya chundru <quic_krichai@quicinc.com>
To:     helgaas@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mka@chromium.org,
        quic_vbadigan@quicinc.com, quic_hemantk@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_ramkri@quicinc.com, manivannan.sadhasivam@linaro.org,
        swboyd@chromium.org, dmitry.baryshkov@linaro.org,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v4 1/2] PCI: qcom: Add system PM support
Date:   Wed,  6 Jul 2022 20:10:24 +0530
Message-Id: <1657118425-10304-2-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1657118425-10304-1-git-send-email-quic_krichai@quicinc.com>
References: <1656684800-31278-1-git-send-email-quic_krichai@quicinc.com>
 <1657118425-10304-1-git-send-email-quic_krichai@quicinc.com>
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
and power down the phy so that system enters into low power state to
save the maximum power. And when the system resumes, enable the clocks
back and power on phy if they are disabled in the suspend path.

we are doing this only when link is in l1ss but not in L2/L3 as
no where we are forcing link to L2/L3 by sending PME turn off.

is_suspended flag indicates if the clocks are disabled in the suspend
path or not. And this flag is being used to restrict the access to
config space, dbi etc when clock are turned-off.

Changes since v3:
	- Powering down the phy in suspend and powering it on resume to
	  acheive maximum power savings.
Changes since v2:
	- Replaced the enable, disable clks ops with suspend and resume
	- Renamed support_pm_opsi flag  with supports_system_suspend.
Changes since v1:
	- Fixed compilation errors.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 85 ++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 6ab9089..0a9d1ee 100644
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
+	int (*suspend)(struct qcom_pcie *pcie);
+	int (*resume)(struct qcom_pcie *pcie);
 };
 
 struct qcom_pcie_cfg {
@@ -199,6 +204,7 @@ struct qcom_pcie_cfg {
 	unsigned int has_ddrss_sf_tbu_clk:1;
 	unsigned int has_aggre0_clk:1;
 	unsigned int has_aggre1_clk:1;
+	unsigned int supports_system_suspend:1;
 };
 
 struct qcom_pcie {
@@ -209,6 +215,7 @@ struct qcom_pcie {
 	struct phy *phy;
 	struct gpio_desc *reset;
 	const struct qcom_pcie_cfg *cfg;
+	unsigned int is_suspended:1;
 };
 
 #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
@@ -1308,6 +1315,33 @@ static void qcom_pcie_post_deinit_2_7_0(struct qcom_pcie *pcie)
 	clk_disable_unprepare(res->pipe_clk);
 }
 
+static int qcom_pcie_resume_2_7_0(struct qcom_pcie *pcie)
+{
+	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
+	int ret;
+
+	clk_prepare_enable(res->pipe_clk);
+
+	ret = clk_bulk_prepare_enable(res->num_clks, res->clks);
+
+	phy_power_on(pcie->phy);
+
+	return ret;
+}
+
+static int qcom_pcie_suspend_2_7_0(struct qcom_pcie *pcie)
+{
+	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
+
+	phy_power_off(pcie->phy);
+
+	clk_bulk_disable_unprepare(res->num_clks, res->clks);
+
+	clk_disable_unprepare(res->pipe_clk);
+
+	return 0;
+}
+
 static int qcom_pcie_link_up(struct dw_pcie *pci)
 {
 	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
@@ -1496,6 +1530,8 @@ static const struct qcom_pcie_ops ops_1_9_0 = {
 	.post_init = qcom_pcie_post_init_2_7_0,
 	.post_deinit = qcom_pcie_post_deinit_2_7_0,
 	.config_sid = qcom_pcie_config_sid_sm8250,
+	.suspend = qcom_pcie_suspend_2_7_0,
+	.resume = qcom_pcie_resume_2_7_0,
 };
 
 static const struct qcom_pcie_cfg apq8084_cfg = {
@@ -1548,6 +1584,7 @@ static const struct qcom_pcie_cfg sc7280_cfg = {
 	.ops = &ops_1_9_0,
 	.has_tbu_clk = true,
 	.pipe_clk_need_muxing = true,
+	.supports_system_suspend = true,
 };
 
 static const struct dw_pcie_ops dw_pcie_ops = {
@@ -1591,6 +1628,8 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 
 	pcie->cfg = pcie_cfg;
 
+	pcie->is_suspended = false;
+
 	pcie->reset = devm_gpiod_get_optional(dev, "perst", GPIOD_OUT_HIGH);
 	if (IS_ERR(pcie->reset)) {
 		ret = PTR_ERR(pcie->reset);
@@ -1645,6 +1684,51 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static int __maybe_unused qcom_pcie_pm_suspend(struct device *dev)
+{
+	struct qcom_pcie *pcie = dev_get_drvdata(dev);
+	u32 val;
+
+	if (!pcie->cfg->supports_system_suspend)
+		return 0;
+
+	/* if the link is not in l1ss don't turn off clocks */
+	val = readl(pcie->parf + PCIE20_PARF_PM_STTS);
+	if (!(val & PCIE20_PARF_PM_STTS_LINKST_IN_L1SUB)) {
+		dev_warn(dev, "Link is not in L1ss\n");
+		return 0;
+	}
+
+	if (pcie->cfg->ops->suspend)
+		pcie->cfg->ops->suspend(pcie);
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
+	if (!pcie->cfg->supports_system_suspend)
+		return 0;
+
+	if (!pcie->is_suspended)
+		return 0;
+
+	if (pcie->cfg->ops->resume)
+		pcie->cfg->ops->resume(pcie);
+
+	pcie->is_suspended = false;
+
+	return 0;
+}
+
+static const struct dev_pm_ops qcom_pcie_pm_ops = {
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(qcom_pcie_pm_suspend, qcom_pcie_pm_resume)
+};
+
 static const struct of_device_id qcom_pcie_match[] = {
 	{ .compatible = "qcom,pcie-apq8084", .data = &apq8084_cfg },
 	{ .compatible = "qcom,pcie-ipq8064", .data = &ipq8064_cfg },
@@ -1679,6 +1763,7 @@ static struct platform_driver qcom_pcie_driver = {
 	.probe = qcom_pcie_probe,
 	.driver = {
 		.name = "qcom-pcie",
+		.pm = pm_sleep_ptr(&qcom_pcie_pm_ops),
 		.suppress_bind_attrs = true,
 		.of_match_table = qcom_pcie_match,
 	},
-- 
2.7.4

