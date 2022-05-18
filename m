Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B85DF52BC15
	for <lists+linux-pci@lfdr.de>; Wed, 18 May 2022 16:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237637AbiERNUB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 May 2022 09:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237657AbiERNUA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 May 2022 09:20:00 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B321796CF
        for <linux-pci@vger.kernel.org>; Wed, 18 May 2022 06:19:58 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id c14so2135407pfn.2
        for <linux-pci@vger.kernel.org>; Wed, 18 May 2022 06:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=txATEk4JZM2jQy2RKz/BeGooaFu5CSNU01MtDQRxfaQ=;
        b=nIQmnqo4Rz4+1DLw5lorzvCXpRFs2B3NZa0m8W4N/JxNEqItRgCCf/nxhj64sR4iow
         gt5jEf6JgZMcDab7hEsHWwC21YW1x3iDNzVYn4nHHzuOPcSKkn724F6nRKkpzFgvc28z
         3ttes+LANUdhqegEed37V7LvT9+d5wX5gC+zf4NUqykgFeIxMVbnh5Y2VRrpZsJ1O/ni
         jFpkbQ9/k9wbZ+XUYZWNob5F41LhL6QtFqJ5UYaM1y96nHrKig0NvC9RsCQDWooxywAi
         5MbA0HYb1Rygrh/XHNPk/L1nD6chMinbu3FaJzb/3E76iiKuL5SlUQb1XA94njVrb9Bi
         qExw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=txATEk4JZM2jQy2RKz/BeGooaFu5CSNU01MtDQRxfaQ=;
        b=AiVdU/9lJVTa3hccS9vSbZWncTgWXKnc4cFEetJ6bGUHBEzkRecUp6Aob723ZMWQXB
         fB/nDeUrcva4v3RtoGcEbJaBfQgkhX91rGDNcpZ3ZtJyEXVBLC9m+uLO5Q8d6f3NF+is
         2zoUjhoU9mqt2SodriaYS8PgIPaIQyVb929X4z6Cqx3HQlqmzjtnDf832jHCt4eQzaHn
         KNkDceY4vDaPoxg8WlPHgEnWtDE5paLSkyJ4oj+4sS/A9xZwkMauNtKz3O2xyduF1NiM
         kjIsx611FOicR+jtdseRz1/v021/lgXzhdwvgGSmSgPPMo0OyfVUj2W96Ee18BIvHxVv
         U4Vg==
X-Gm-Message-State: AOAM531si5c5llsWHikZGMjARxOVoyKf6VeqHY1rMGUQlXhY1IwVCqut
        uwAEls/18+COX7MAkz7By5z1
X-Google-Smtp-Source: ABdhPJwza2H4RAuSmX+mr9/p1a18xwE96l79O/kDfY2T0ZDpQBEOEo+0ehBH5TXhTMNBUg/E65fAmQ==
X-Received: by 2002:a63:1b49:0:b0:3f2:cf90:5ad4 with SMTP id b9-20020a631b49000000b003f2cf905ad4mr8023542pgm.450.1652879997896;
        Wed, 18 May 2022 06:19:57 -0700 (PDT)
Received: from localhost.localdomain ([117.217.181.192])
        by smtp.gmail.com with ESMTPSA id b5-20020a170903228500b0015e8d4eb27esm1663908plh.200.2022.05.18.06.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 06:19:57 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     bhelgaas@google.com, lorenzo.pieralisi@arm.com, kbusch@kernel.org,
        hch@lst.de
Cc:     linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        svarbanov@mm-sol.com, bjorn.andersson@linaro.org, axboe@fb.com,
        quic_vbadigan@quicinc.com, quic_krichai@quicinc.com,
        quic_nitirawa@quicinc.com, vidyas@nvidia.com, sagi@grimberg.me,
        linux-pm@vger.kernel.org, rafael@kernel.org,
        Prasad Malisetty <quic_pmaliset@quicinc.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 3/3] PCI: qcom: Add system PM support
Date:   Wed, 18 May 2022 18:49:13 +0530
Message-Id: <20220518131913.26974-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220518131913.26974-1-manivannan.sadhasivam@linaro.org>
References: <20220518131913.26974-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Prasad Malisetty <quic_pmaliset@quicinc.com>

Add suspend and resume callbacks to handle system suspend and resume in
the Qcom PCIe controller driver. When the system suspends, PME turnoff
message will be sent to the device and the RC driver will wait for the
device to enter L23 Ready state. After that, the PHY will be powered down
and clocks/regulators will be disabled.

When the system resumes, RC driver gets initialized and re-establishes the
link.

The system suspend and resume are only handled when the underlying platform
supports the "suspend_poweroff" flag that notifies the PCI drivers about
powerdown during suspend.

Otherwise, these callbacks are NO-OPs. Currently, this flag is only enabled
for SC7280 SoC, where aggressive powersaving is required during system
suspend. It should be noted that on this platform, RPMh will also cutoff
the power to PCIe domain during suspend, independent of the RC driver as
rest of the RPMh clients de-vote for the resources. But ideally, the PCIe
devices should be put into D3cold state during suspend by the PCIe RC
driver and that's what this commit also does.

Signed-off-by: Prasad Malisetty <quic_pmaliset@quicinc.com>
[mani: Reworded commit message, removed pipe_clk & added "suspend_poweroff" flag]
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---

Changes in v2:

* Picked the suspend/resume patch from Prasad and squashed the suspend_poweroff
  patch
* Rebased on top of pipe_clk handling series from Dmitry
  https://lore.kernel.org/all/20220513175339.2981959-1-dmitry.baryshkov@linaro.org/

 drivers/pci/controller/dwc/pcie-qcom.c | 108 +++++++++++++++++++++++++
 1 file changed, 108 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index b48c899bcc97..bfcc79058b3f 100644
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
 
@@ -193,6 +198,7 @@ struct qcom_pcie_cfg {
 	unsigned int has_ddrss_sf_tbu_clk:1;
 	unsigned int has_aggre0_clk:1;
 	unsigned int has_aggre1_clk:1;
+	unsigned int suspend_poweroff:1;
 };
 
 struct qcom_pcie {
@@ -1171,6 +1177,10 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
 		return ret;
 	}
 
+	/* Indicate PCI device drivers that the power will be taken off during system suspend */
+	if (pcie->cfg->suspend_poweroff)
+		pci->pp.bridge->suspend_poweroff = true;
+
 	ret = clk_bulk_prepare_enable(res->num_clks, res->clks);
 	if (ret < 0)
 		goto err_disable_regulators;
@@ -1467,6 +1477,7 @@ static const struct qcom_pcie_cfg sm8450_pcie1_cfg = {
 static const struct qcom_pcie_cfg sc7280_cfg = {
 	.ops = &ops_1_9_0,
 	.has_tbu_clk = true,
+	.suspend_poweroff = true,
 };
 
 static const struct dw_pcie_ops dw_pcie_ops = {
@@ -1564,6 +1575,102 @@ static int qcom_pcie_probe(struct platform_device *pdev)
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
+	/* Disable PCIe clocks and regulators */
+	pcie->cfg->ops->deinit(pcie);
+}
+
+static int qcom_pcie_pm_suspend(struct device *dev)
+{
+	int ret;
+	struct qcom_pcie *pcie = dev_get_drvdata(dev);
+	struct dw_pcie *pci = pcie->pci;
+
+	/* If the platform doesn't support powerdown during suspend, just return */
+	if (!pcie->cfg->suspend_poweroff)
+		return 0;
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
+static int qcom_pcie_pm_resume(struct device *dev)
+{
+	int ret;
+	struct qcom_pcie *pcie = dev_get_drvdata(dev);
+	struct dw_pcie *pci = pcie->pci;
+	struct pcie_port *pp = &pci->pp;
+
+	/* If the platform doesn't support powerdown during suspend, just return */
+	if (!pcie->cfg->suspend_poweroff)
+		return 0;
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
@@ -1600,6 +1707,7 @@ static struct platform_driver qcom_pcie_driver = {
 		.name = "qcom-pcie",
 		.suppress_bind_attrs = true,
 		.of_match_table = qcom_pcie_match,
+		.pm = pm_sleep_ptr(&qcom_pcie_pm_ops),
 	},
 };
 builtin_platform_driver(qcom_pcie_driver);
-- 
2.25.1

