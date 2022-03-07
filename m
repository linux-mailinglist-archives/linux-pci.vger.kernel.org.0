Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8864D0700
	for <lists+linux-pci@lfdr.de>; Mon,  7 Mar 2022 19:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239752AbiCGS41 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Mar 2022 13:56:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbiCGS40 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Mar 2022 13:56:26 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C7491354;
        Mon,  7 Mar 2022 10:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1646679331; x=1678215331;
  h=from:to:cc:subject:date:message-id;
  bh=TkJ7vVlFe3NJoDlij4wI9aVqzEmAv226UcUTPIW6LAk=;
  b=XEz+ROND6Y201SLiV0Q5rXQNlacqYi0x4sDjLvvvERWFXVGnoGJ4mHcF
   DdrrV3l8xn4XgW4e+DzqBmjwUu0H1mLQJMOOQgMfxO2NaA+LrkgahZqiV
   XIPablwQXNq2Op6+7m3zG1xcPF7U10QqAiLC5AqJp8KDhLUCmqnnDZyIc
   w=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 07 Mar 2022 10:55:31 -0800
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 07 Mar 2022 10:55:29 -0800
X-QCInternal: smtphost
Received: from pmaliset-linux.qualcomm.com ([10.206.64.233])
  by ironmsg02-blr.qualcomm.com with ESMTP; 08 Mar 2022 00:25:10 +0530
Received: by pmaliset-linux.qualcomm.com (Postfix, from userid 3848298)
        id 98BDF21422; Tue,  8 Mar 2022 00:25:08 +0530 (IST)
From:   Prasad Malisetty <quic_pmaliset@quicinc.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rajatja@google.com, refactormyself@gmail.com
Cc:     quic_vbadigan@quicinc.com, quic_ramkri@quicinc.com,
        manivannan.sadhasivam@linaro.org, swboyd@chromium.org,
        Prasad Malisetty <quic_pmaliset@quicinc.com>
Subject: [PATCH v4] PCI: qcom: Add system PM support
Date:   Tue,  8 Mar 2022 00:25:06 +0530
Message-Id: <1646679306-4768-1-git-send-email-quic_pmaliset@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add suspend_noirq and resume_noirq callbacks to handle
system suspend and resume in dwc PCIe controller driver.

When system suspends, send PME turnoff message to enter
link into L2 state. Along with powerdown the PHY, disable
pipe clock, switch gcc_pcie_1_pipe_clk_src to XO if mux is
supported and disable the pcie clocks, regulators.

When system resumes, PCIe link will be re-established and
setup rc settings.

Signed-off-by: Prasad Malisetty <quic_pmaliset@quicinc.com>

---
Changes since v3:
	- Replaced noirq hooks with normal suspend/resume hooks.
	- Removed local variable and placed in function itself.

Changes since v2:
	- Removed unnecessary variable initializations and comments.
	- Removed platform specific variables declarations.
	- Added MACRO names for the BIT shiftings.

Changes since v1:
	- Removed unnecessary logs and modified log level suggested by Manivannan.
	- Removed platform specific callbacks as PM support is generic.
---
 drivers/pci/controller/dwc/pcie-qcom.c | 97 ++++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 6ab9089..4d29c80 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -48,6 +48,7 @@
 #define PCIE20_PARF_PHY_REFCLK			0x4C
 #define PHY_REFCLK_SSP_EN			BIT(16)
 #define PHY_REFCLK_USE_PAD			BIT(12)
+#define PHY_POWER_DOWN				0x1
 
 #define PCIE20_PARF_DBI_BASE_ADDR		0x168
 #define PCIE20_PARF_SLV_ADDR_SPACE_SIZE		0x16C
@@ -62,6 +63,8 @@
 
 #define PCIE20_ELBI_SYS_CTRL			0x04
 #define PCIE20_ELBI_SYS_CTRL_LT_ENABLE		BIT(0)
+#define PCIE_PME_TURNOFF_MSG			BIT(4)
+#define PCIE_PM_LINKST_IN_L2			BIT(5)
 
 #define PCIE20_AXI_MSTR_RESP_COMP_CTRL0		0x818
 #define CFG_REMOTE_RD_REQ_BRIDGE_SIZE_2K	0x4
@@ -73,6 +76,8 @@
 
 #define PCIE20_PARF_Q2A_FLUSH			0x1AC
 
+#define PCIE20_PARF_PM_STTS			0x24
+
 #define PCIE20_MISC_CONTROL_1_REG		0x8BC
 #define DBI_RO_WR_EN				1
 
@@ -1645,6 +1650,97 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static int qcom_pcie_send_pme_turnoff_msg(struct qcom_pcie *pcie)
+{
+	int ret;
+	u32 val, poll_val;
+	struct dw_pcie *pci = pcie->pci;
+	struct device *dev = pci->dev;
+
+	val = readl(pcie->elbi + PCIE20_ELBI_SYS_CTRL);
+	val |= PCIE_PME_TURNOFF_MSG;
+	writel(val, pcie->elbi + PCIE20_ELBI_SYS_CTRL);
+
+	ret = readl_poll_timeout((pcie->parf + PCIE20_PARF_PM_STTS), poll_val,
+			(poll_val & PCIE_PM_LINKST_IN_L2),
+			10000, 100000);
+	if (!ret)
+		dev_dbg(dev, "Device entered L23_Ready state\n");
+	else
+		dev_err(dev, "Device failed to enter L23_Ready. PM_STTS 0x%x\n",
+			readl_relaxed(pcie->parf + PCIE20_PARF_PM_STTS));
+
+	return ret;
+}
+
+static void qcom_pcie_host_disable(struct qcom_pcie *pcie)
+{
+	qcom_ep_reset_assert(pcie);
+
+	/* Put PHY into POWER DOWN state */
+	phy_power_off(pcie->phy);
+
+	writel(PHY_POWER_DOWN, pcie->parf + PCIE20_PARF_PHY_CTRL);
+
+	if (pcie->cfg->ops->post_deinit)
+		pcie->cfg->ops->post_deinit(pcie);
+
+	/* Disable PCIe clocks and regulators */
+	pcie->cfg->ops->deinit(pcie);
+}
+
+static int __maybe_unused qcom_pcie_pm_suspend(struct device *dev)
+{
+	int ret;
+	struct qcom_pcie *pcie = dev_get_drvdata(dev);
+	struct dw_pcie *pci = pcie->pci;
+
+	if (!dw_pcie_link_up(pci)) {
+		dev_dbg(dev, "Power has been turned off already\n");
+		return 0;
+	}
+
+	ret = qcom_pcie_send_pme_turnoff_msg(pcie);
+	if (ret)
+		return ret;
+
+	/* Power down the PHY, disable clock and regulators */
+	qcom_pcie_host_disable(pcie);
+
+	return 0;
+}
+
+/* Resume the PCIe link */
+static int __maybe_unused qcom_pcie_pm_resume(struct device *dev)
+{
+	int ret;
+	struct qcom_pcie *pcie = dev_get_drvdata(dev);
+	struct dw_pcie *pci = pcie->pci;
+	struct pcie_port *pp = &pci->pp;
+
+	ret = qcom_pcie_host_init(pp);
+	if (ret) {
+		dev_err(dev, "cannot initialize host\n");
+		return ret;
+	}
+
+	dw_pcie_setup_rc(pp);
+
+	qcom_pcie_start_link(pci);
+
+	ret = dw_pcie_wait_for_link(pci);
+	if (ret) {
+		dev_err(dev, "Link never came up, Resume failed\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct dev_pm_ops qcom_pcie_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(qcom_pcie_pm_suspend, qcom_pcie_pm_resume)
+};
+
 static const struct of_device_id qcom_pcie_match[] = {
 	{ .compatible = "qcom,pcie-apq8084", .data = &apq8084_cfg },
 	{ .compatible = "qcom,pcie-ipq8064", .data = &ipq8064_cfg },
@@ -1679,6 +1775,7 @@ static struct platform_driver qcom_pcie_driver = {
 	.probe = qcom_pcie_probe,
 	.driver = {
 		.name = "qcom-pcie",
+		.pm = &qcom_pcie_pm_ops,
 		.suppress_bind_attrs = true,
 		.of_match_table = qcom_pcie_match,
 	},
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation

