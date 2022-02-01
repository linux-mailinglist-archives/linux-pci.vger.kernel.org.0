Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA204A633B
	for <lists+linux-pci@lfdr.de>; Tue,  1 Feb 2022 19:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236930AbiBASIT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Feb 2022 13:08:19 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:30991 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232304AbiBASIS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Feb 2022 13:08:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643738899; x=1675274899;
  h=from:to:cc:subject:date:message-id;
  bh=XibvicD4b/B19Mt1CSI3bLsU+ULqNBdRlOGv5+YBSrA=;
  b=BzrXriCsfKfT3QNy2O8Rt8pTp9CjCuNKInXEKya4L3IVMSgWHLHaoP9J
   YKfHbWuiysxC7UKuL6tr+95jcgd541i2zF6LSpQ968vif3yLtfYKUh/3L
   sSuFA15ihI5mD2lURJNk+j1StB8MAFKlvFZ7hkj1+DylLDT7r/Wwx5ory
   0=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 01 Feb 2022 10:08:19 -0800
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 01 Feb 2022 10:08:17 -0800
X-QCInternal: smtphost
Received: from pmaliset-linux.qualcomm.com ([10.206.64.233])
  by ironmsg01-blr.qualcomm.com with ESMTP; 01 Feb 2022 23:37:59 +0530
Received: by pmaliset-linux.qualcomm.com (Postfix, from userid 3848298)
        id 7DAC32121A; Tue,  1 Feb 2022 23:37:58 +0530 (IST)
From:   Prasad Malisetty <quic_pmaliset@quicinc.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     quic_vbadigan@quicinc.com, quic_ramkri@quicinc.com,
        manivannan.sadhasivam@linaro.org, swboyd@chromium.org,
        Prasad Malisetty <quic_pmaliset@quicinc.com>
Subject: [PATCH v2] PCI: qcom: Add system PM support
Date:   Tue,  1 Feb 2022 23:37:56 +0530
Message-Id: <1643738876-18572-1-git-send-email-quic_pmaliset@quicinc.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add suspend_noirq and resume_noirq callbacks to handle
System suspend and resume in dwc pcie controller driver.

When system suspends, send PME turnoff message to enter
link into L2 state. Along with powerdown the PHY, disable
pipe clock, switch gcc_pcie_1_pipe_clk_src to XO if mux is
supported and disable the pcie clocks, regulators.

When system resumes, PCIe link will be re-established and
setup rc settings.

Signed-off-by: Prasad Malisetty <quic_pmaliset@quicinc.com>
Reported-by: kernel test robot <lkp@intel.com>

---
Changes since v1:
	- Removed unnecessary logs and modified log level suggested by Manivannan.
	- Removed platform specific callbacks as PM support is generic.
---
 drivers/pci/controller/dwc/pcie-qcom.c | 97 ++++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index c19cd506..d1dd6c7 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -73,6 +73,8 @@
 
 #define PCIE20_PARF_Q2A_FLUSH			0x1AC
 
+#define PCIE20_PARF_PM_STTS                     0x24
+
 #define PCIE20_MISC_CONTROL_1_REG		0x8BC
 #define DBI_RO_WR_EN				1
 
@@ -1616,6 +1618,100 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static int qcom_pcie_send_pme_turnoff_msg(struct qcom_pcie *pcie)
+{
+	int ret = 0;
+	u32 val = 0, poll_val = 0;
+	u64 l23_rdy_poll_timeout = 100000;
+	struct dw_pcie *pci = pcie->pci;
+	struct device *dev = pci->dev;
+
+	val = readl(pcie->elbi + PCIE20_ELBI_SYS_CTRL);
+	val |= BIT(4);
+	writel(val, pcie->elbi + PCIE20_ELBI_SYS_CTRL);
+
+	ret = readl_poll_timeout((pcie->parf + PCIE20_PARF_PM_STTS), poll_val,
+			(poll_val & BIT(5)), 10000, l23_rdy_poll_timeout);
+	if (!ret)
+		dev_info(dev, "PM_Enter_L23 is received\n");
+	else
+		dev_err(dev, "PM_Enter_L23 is NOT received.PARF_PM_STTS 0x%x\n",
+			readl_relaxed(pcie->parf + PCIE20_PARF_PM_STTS));
+
+	return ret;
+}
+
+static void qcom_pcie_host_disable(struct qcom_pcie *pcie)
+{
+	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
+
+	/* Assert the reset of endpoint */
+	qcom_ep_reset_assert(pcie);
+
+	/* Put PHY into POWER DOWN state */
+	phy_power_off(pcie->phy);
+
+	writel(1, pcie->parf + PCIE20_PARF_PHY_CTRL);
+
+	pcie->ops->post_deinit(pcie);
+
+	/* Disable PCIe clocks and regulators */
+	pcie->ops->deinit(pcie);
+}
+
+static int __maybe_unused qcom_pcie_pm_suspend_noirq(struct device *dev)
+{
+	int ret = 0;
+	struct qcom_pcie *pcie = dev_get_drvdata(dev);
+	struct dw_pcie *pci = pcie->pci;
+
+	if (!dw_pcie_link_up(pci)) {
+		dev_dbg(dev, "Power has been turned off already\n");
+		return ret;
+	}
+
+	/* Send PME turnoff msg */
+	ret = qcom_pcie_send_pme_turnoff_msg(pcie);
+	if (ret)
+		return ret;
+
+	/* Power down the PHY, disable clock and regulators */
+	qcom_pcie_host_disable(pcie);
+
+	return ret;
+}
+
+/* Resume the PCIe link */
+static int __maybe_unused qcom_pcie_pm_resume_noirq(struct device *dev)
+{
+	int ret = 0;
+	struct qcom_pcie *pcie = dev_get_drvdata(dev);
+	struct dw_pcie *pci = pcie->pci;
+	struct pcie_port *pp = &pci->pp;
+
+	/* Initialize PCIe host */
+	ret = qcom_pcie_host_init(pp);
+	if (ret) {
+		dev_err(dev, "cannot initialize host\n");
+		return ret;
+	}
+
+	dw_pcie_setup_rc(pp);
+
+	/* Start the PCIe link */
+	qcom_pcie_start_link(pci);
+
+	ret = dw_pcie_wait_for_link(pci);
+	if (ret)
+		dev_err(dev, "Link never came up, Resume failed\n");
+
+	return ret;
+}
+
+static const struct dev_pm_ops qcom_pcie_pm_ops = {
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(qcom_pcie_pm_suspend_noirq, qcom_pcie_pm_resume_noirq)
+};
+
 static const struct of_device_id qcom_pcie_match[] = {
 	{ .compatible = "qcom,pcie-apq8084", .data = &apq8084_cfg },
 	{ .compatible = "qcom,pcie-ipq8064", .data = &ipq8064_cfg },
@@ -1648,6 +1744,7 @@ static struct platform_driver qcom_pcie_driver = {
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

