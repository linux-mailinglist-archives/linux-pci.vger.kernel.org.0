Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBC0DF2329
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2019 01:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbfKGAQw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Nov 2019 19:16:52 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39534 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732364AbfKGAQv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Nov 2019 19:16:51 -0500
Received: by mail-pl1-f195.google.com with SMTP id o9so89834plk.6
        for <linux-pci@vger.kernel.org>; Wed, 06 Nov 2019 16:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ku11UK5M4kBjClOZ9jsUdie4RqmP8PdwQKvUzAijcRU=;
        b=HKtGSHQLHLryzCDWQ1fAxmEr+YAD4wkG/cyr5Zl8adkZqu/3MSYAAFkC0/NGufbzCC
         4dmPWLKiOU6bVjYsN4bOzWUvFmkd0SCX8Ho5sM3wwW1qwaBDX4dVWRaXFC2f2vxVLyTa
         je/gs7AOiKO9EO3NZfb4JUiMfojJaC0KtsJf5ct5g9vRuF+DFauYReSqQl7fZITbEyMc
         B6EZsjFdD7V0V9q7SGZx4z1OSrA40GlSGy9Y6aOocvpiK8EP3fSpD/Mc8T8uOH57g+GA
         W+5iYPSy5cSVyqkC1wEKR0b/zZY1usm+cPTv6ZcGau/M1S+p+X7Uxg0JPGKMAH9SylNH
         LWSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ku11UK5M4kBjClOZ9jsUdie4RqmP8PdwQKvUzAijcRU=;
        b=mJLR3wKwqxz1TPQEfOv6KPjZFsx4kg2ggm17ixLC4W3jIieyKj2o6pxxF3E4FT3N+K
         CmdW5e2R6IEIfTDzGvsLCxUE75qTZ//8xmWo5NZpAWWboRZ0E+hSYku88wTUJIBc9q83
         fU9iufHQYaWnunFBwAkZ1GwTy2SVxm5N05mAN7FFLe5iD/4r0PxDrt4Yb9xLUlgAYddL
         KfNvPzTeJE24c4+r1GjCHf/iRHDjrVsVQGBWjJJVb/PD0vWMi6rJlc2e9/1h+Of6/syh
         9IDXnp3Ej0AkZTidf2oqwFGcGiUHJTI4zRCR7Bltc0svSKeQHBUYqkfTAqV8O6HkGuqR
         U1KA==
X-Gm-Message-State: APjAAAW7oZplip2IniX7xIBAKKfCSl/titwKHVtdlxSG2LqEyZlL05WX
        HlZ1ct13xzFau4Y9sxMHmvEcBA==
X-Google-Smtp-Source: APXvYqyKBySTal5ICDyjqZZChJzUzwSF7LcKZLZMAAisuuTe3GRjRz8u4XnrK/XyZlExPVGGcTprHg==
X-Received: by 2002:a17:902:14e:: with SMTP id 72mr412670plb.271.1573085809358;
        Wed, 06 Nov 2019 16:16:49 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 90sm81044pjz.29.2019.11.06.16.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 16:16:48 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v3 2/2] PCI: qcom: Add support for SDM845 PCIe controller
Date:   Wed,  6 Nov 2019 16:16:42 -0800
Message-Id: <20191107001642.1127561-3-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191107001642.1127561-1-bjorn.andersson@linaro.org>
References: <20191107001642.1127561-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The SDM845 has one Gen2 and one Gen3 controller, add support for these.

Reviewed-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- Don't assert the reset in the failure path

 drivers/pci/controller/dwc/pcie-qcom.c | 150 +++++++++++++++++++++++++
 1 file changed, 150 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 7e581748ee9f..5ea527a6bd9f 100644
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
@@ -1068,6 +1079,134 @@ static int qcom_pcie_init_2_3_3(struct qcom_pcie *pcie)
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
+	usleep_range(1000, 1500);
+
+	ret = reset_control_deassert(res->pci_reset);
+	if (ret < 0) {
+		dev_err(dev, "cannot deassert pci reset\n");
+		goto err_disable_clocks;
+	}
+
+	ret = clk_prepare_enable(res->pipe_clk);
+	if (ret) {
+		dev_err(dev, "cannot prepare/enable pipe clock\n");
+		goto err_disable_clocks;
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
@@ -1167,6 +1306,16 @@ static const struct qcom_pcie_ops ops_2_3_3 = {
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
@@ -1282,6 +1431,7 @@ static const struct of_device_id qcom_pcie_match[] = {
 	{ .compatible = "qcom,pcie-ipq8074", .data = &ops_2_3_3 },
 	{ .compatible = "qcom,pcie-ipq4019", .data = &ops_2_4_0 },
 	{ .compatible = "qcom,pcie-qcs404", .data = &ops_2_4_0 },
+	{ .compatible = "qcom,pcie-sdm845", .data = &ops_2_7_0 },
 	{ }
 };
 
-- 
2.23.0

