Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13D8BECC5A
	for <lists+linux-pci@lfdr.de>; Sat,  2 Nov 2019 01:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbfKBA1a (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Nov 2019 20:27:30 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39397 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728261AbfKBA12 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Nov 2019 20:27:28 -0400
Received: by mail-pf1-f196.google.com with SMTP id x28so4887275pfo.6
        for <linux-pci@vger.kernel.org>; Fri, 01 Nov 2019 17:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vFqrKarSu4urzy42UwvFd4yq3nvmvCs/1fD8SGzZ4r8=;
        b=IALPQzjCnyHQzQNEsh1IvMPmjikosHIhcu9sj70gWrUsP5JCIECRW3weXGyhezUQim
         AuQcrAZOHvTT1mp7bJh92rwTqAjTTnGwTFJrbXxdVhBjKeAnLAqMpDaqdrWVNhN6Xwar
         JBUMdPpoOJtEVeh9pwIGGtEjd2SW/moiVhNefTJ8h0bdlLnGKhiV0G5AmwIqv2mpXGj2
         unsXZKommqbyzWycIFF/jk+PZYsGLmZyWG/3KVzBdCXLd56nXJvSW98nTFbMUN5WkQuV
         Uix3cS9kg2Knab0g5FIwAnqQBAnjDXf7dhi3ocxdBNoHGN6qQ6gRrCSOsV5Lz2rH4lDh
         iADw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vFqrKarSu4urzy42UwvFd4yq3nvmvCs/1fD8SGzZ4r8=;
        b=QJR6VZojShcMkAeDgo37D6zOH/KvB2lC9T3wdVma8rCnKjUS1l70gJim3NCNhToGwj
         mmOzFN6t3FtzPLk3ADQsUZRQOoaMG+ALX/sqxLyGWUu5tCyXl1/emg1vM0I7ZpQoV9bl
         vV3f9nyKfv9wTIUIrAu2Zmy5bV/7Z3ATA1bzTIDjMzBzDIQ9HGpeGoDTBm/g8Ic/bQHF
         TYinaWH2/qk4LIDKipHsT4fwxU73D5E7CBUl3L1sGXyuoyuX1yRnN9CidNHn6k+DQhhZ
         Px2E3ayQnnwam4+oK7/O+r6sx9IQvs0w0JXtC4k77eT9zYDRNZF8ysFc97qB02AVKrLJ
         E07w==
X-Gm-Message-State: APjAAAWiZg5zl1iu9NksvFB+nAMWvUvZ7P0p0hXMQmbCCGfgJXdhmSKB
        ENuZvg9t0hjX8HBtyC5cS2IynQ==
X-Google-Smtp-Source: APXvYqyPyIhTPlYhvJ3fcH+iO3ypCwhbYtkQJLDP/+vSP1ivHZhVjIKGsFP9d6HbYvmU8ddgkcKYAA==
X-Received: by 2002:a63:69c7:: with SMTP id e190mr15948658pgc.195.1572654447596;
        Fri, 01 Nov 2019 17:27:27 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id e8sm9395910pga.17.2019.11.01.17.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 17:27:26 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] PCI: qcom: Add support for SDM845 PCIe controller
Date:   Fri,  1 Nov 2019 17:27:21 -0700
Message-Id: <20191102002721.4091180-3-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191102002721.4091180-1-bjorn.andersson@linaro.org>
References: <20191102002721.4091180-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The SDM845 has one Gen2 and one Gen3 controller, add support for these.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- Style changes requested by Stan
- Tested with second PCIe controller as well

 drivers/pci/controller/dwc/pcie-qcom.c | 152 +++++++++++++++++++++++++
 1 file changed, 152 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 7e581748ee9f..35f4980480bb 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -54,6 +54,7 @@
 #define PCIE20_PARF_LTSSM			0x1B0
 #define PCIE20_PARF_SID_OFFSET			0x234
 #define PCIE20_PARF_BDF_TRANSLATE_CFG		0x24C
+#define PCIE20_PARF_DEVICE_TYPE			0x1000
 
 #define PCIE20_ELBI_SYS_CTRL			0x04
 #define PCIE20_ELBI_SYS_CTRL_LT_ENABLE		BIT(0)
@@ -80,6 +81,8 @@
 #define PCIE20_v3_PARF_SLV_ADDR_SPACE_SIZE	0x358
 #define SLV_ADDR_SPACE_SZ			0x10000000
 
+#define DEVICE_TYPE_RC				0x4
+
 #define QCOM_PCIE_2_1_0_MAX_SUPPLY	3
 struct qcom_pcie_resources_2_1_0 {
 	struct clk *iface_clk;
@@ -139,12 +142,20 @@ struct qcom_pcie_resources_2_3_3 {
 	struct reset_control *rst[7];
 };
 
+struct qcom_pcie_resources_2_7_0 {
+	struct clk_bulk_data clks[6];
+	struct regulator_bulk_data supplies[2];
+	struct reset_control *pci_reset;
+	struct clk *pipe_clk;
+};
+
 union qcom_pcie_resources {
 	struct qcom_pcie_resources_1_0_0 v1_0_0;
 	struct qcom_pcie_resources_2_1_0 v2_1_0;
 	struct qcom_pcie_resources_2_3_2 v2_3_2;
 	struct qcom_pcie_resources_2_3_3 v2_3_3;
 	struct qcom_pcie_resources_2_4_0 v2_4_0;
+	struct qcom_pcie_resources_2_7_0 v2_7_0;
 };
 
 struct qcom_pcie;
@@ -1068,6 +1079,136 @@ static int qcom_pcie_init_2_3_3(struct qcom_pcie *pcie)
 	return ret;
 }
 
+static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
+{
+	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
+	struct dw_pcie *pci = pcie->pci;
+	struct device *dev = pci->dev;
+	int ret;
+
+	res->pci_reset = devm_reset_control_get_exclusive(dev, "pci");
+	if (IS_ERR(res->pci_reset))
+		return PTR_ERR(res->pci_reset);
+
+	res->supplies[0].supply = "vdda";
+	res->supplies[1].supply = "vddpe-3v3";
+	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(res->supplies),
+				      res->supplies);
+	if (ret)
+		return ret;
+
+	res->clks[0].id = "aux";
+	res->clks[1].id = "cfg";
+	res->clks[2].id = "bus_master";
+	res->clks[3].id = "bus_slave";
+	res->clks[4].id = "slave_q2a";
+	res->clks[5].id = "tbu";
+
+	ret = devm_clk_bulk_get(dev, ARRAY_SIZE(res->clks), res->clks);
+	if (ret < 0)
+		return ret;
+
+	res->pipe_clk = devm_clk_get(dev, "pipe");
+	return PTR_ERR_OR_ZERO(res->pipe_clk);
+}
+
+static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
+{
+	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
+	struct dw_pcie *pci = pcie->pci;
+	struct device *dev = pci->dev;
+	u32 val;
+	int ret;
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(res->supplies), res->supplies);
+	if (ret < 0) {
+		dev_err(dev, "cannot enable regulators\n");
+		return ret;
+	}
+
+	ret = clk_bulk_prepare_enable(ARRAY_SIZE(res->clks), res->clks);
+	if (ret < 0)
+		goto err_disable_regulators;
+
+	ret = reset_control_assert(res->pci_reset);
+	if (ret < 0) {
+		dev_err(dev, "cannot deassert pci reset\n");
+		goto err_disable_clocks;
+	}
+
+	msleep(20);
+
+	ret = reset_control_deassert(res->pci_reset);
+	if (ret < 0) {
+		dev_err(dev, "cannot deassert pci reset\n");
+		goto err_assert_resets;
+	}
+
+	ret = clk_prepare_enable(res->pipe_clk);
+	if (ret) {
+		dev_err(dev, "cannot prepare/enable pipe clock\n");
+		goto err_assert_resets;
+	}
+
+	/* configure PCIe to RC mode */
+	writel(DEVICE_TYPE_RC, pcie->parf + PCIE20_PARF_DEVICE_TYPE);
+
+	/* enable PCIe clocks and resets */
+	val = readl(pcie->parf + PCIE20_PARF_PHY_CTRL);
+	val &= ~BIT(0);
+	writel(val, pcie->parf + PCIE20_PARF_PHY_CTRL);
+
+	/* change DBI base address */
+	writel(0, pcie->parf + PCIE20_PARF_DBI_BASE_ADDR);
+
+	/* MAC PHY_POWERDOWN MUX DISABLE  */
+	val = readl(pcie->parf + PCIE20_PARF_SYS_CTRL);
+	val &= ~BIT(29);
+	writel(val, pcie->parf + PCIE20_PARF_SYS_CTRL);
+
+	val = readl(pcie->parf + PCIE20_PARF_MHI_CLOCK_RESET_CTRL);
+	val |= BIT(4);
+	writel(val, pcie->parf + PCIE20_PARF_MHI_CLOCK_RESET_CTRL);
+
+	if (IS_ENABLED(CONFIG_PCI_MSI)) {
+		val = readl(pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT);
+		val |= BIT(31);
+		writel(val, pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT);
+	}
+
+	return 0;
+err_assert_resets:
+	reset_control_assert(res->pci_reset);
+err_disable_clocks:
+	clk_bulk_disable_unprepare(ARRAY_SIZE(res->clks), res->clks);
+err_disable_regulators:
+	regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
+
+	return ret;
+}
+
+static void qcom_pcie_deinit_2_7_0(struct qcom_pcie *pcie)
+{
+	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
+
+	clk_bulk_disable_unprepare(ARRAY_SIZE(res->clks), res->clks);
+	regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
+}
+
+static int qcom_pcie_post_init_2_7_0(struct qcom_pcie *pcie)
+{
+	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
+
+	return clk_prepare_enable(res->pipe_clk);
+}
+
+static void qcom_pcie_post_deinit_2_7_0(struct qcom_pcie *pcie)
+{
+	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
+
+	clk_disable_unprepare(res->pipe_clk);
+}
+
 static int qcom_pcie_link_up(struct dw_pcie *pci)
 {
 	u16 val = readw(pci->dbi_base + PCIE20_CAP + PCI_EXP_LNKSTA);
@@ -1167,6 +1308,16 @@ static const struct qcom_pcie_ops ops_2_3_3 = {
 	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
 };
 
+/* Qcom IP rev.: 2.7.0	Synopsys IP rev.: 4.30a */
+static const struct qcom_pcie_ops ops_2_7_0 = {
+	.get_resources = qcom_pcie_get_resources_2_7_0,
+	.init = qcom_pcie_init_2_7_0,
+	.deinit = qcom_pcie_deinit_2_7_0,
+	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
+	.post_init = qcom_pcie_post_init_2_7_0,
+	.post_deinit = qcom_pcie_post_deinit_2_7_0,
+};
+
 static const struct dw_pcie_ops dw_pcie_ops = {
 	.link_up = qcom_pcie_link_up,
 };
@@ -1282,6 +1433,7 @@ static const struct of_device_id qcom_pcie_match[] = {
 	{ .compatible = "qcom,pcie-ipq8074", .data = &ops_2_3_3 },
 	{ .compatible = "qcom,pcie-ipq4019", .data = &ops_2_4_0 },
 	{ .compatible = "qcom,pcie-qcs404", .data = &ops_2_4_0 },
+	{ .compatible = "qcom,pcie-sdm845", .data = &ops_2_7_0 },
 	{ }
 };
 
-- 
2.23.0

