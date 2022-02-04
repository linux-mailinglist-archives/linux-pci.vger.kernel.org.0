Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A607A4A9B5B
	for <lists+linux-pci@lfdr.de>; Fri,  4 Feb 2022 15:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359448AbiBDOq7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Feb 2022 09:46:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359456AbiBDOq6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Feb 2022 09:46:58 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EAE0C06173D
        for <linux-pci@vger.kernel.org>; Fri,  4 Feb 2022 06:46:58 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id k13so13073961lfg.9
        for <linux-pci@vger.kernel.org>; Fri, 04 Feb 2022 06:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NscpyK0buF1esZkGVw7YGC7D0IZRioFEiEIVQa9+trk=;
        b=wbrZgVCHOlYdehazV9tmDN39xAHuYi+3rNFSrkcCq9VN01OvR2OTPSZPG8CyIiKA8G
         DSNHTLRYtsQvq+cXV+9v4ApX5ffBBzhqWhIG9g0JMz3ekQsAPADL5OifjqkIiA4DVIHN
         JhJZ0MNFw7g4ChZDDTvbhYvB1wi0/gGciHVY6fUDT/u0J1oAH1IsL+jMy62Zs986z7gq
         dlS4joOzvAE6h+xri4w9QS2H2/ss2fX1tYkn7aBHojoI0UE/29KAsRa54ZIw2ikpcyJS
         ySjHb2XHrYO/qSNK0lm01Hi/DYNWQDFBAnb4HJvCO67EuObEL1GumW+C0dnOVfeYW7j6
         Roiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NscpyK0buF1esZkGVw7YGC7D0IZRioFEiEIVQa9+trk=;
        b=qZBdnQMdbMElVlERA2P6oBwl/KYWBuM3dVKYH2CuX1P788cemuGrOuQFNvup0PifM7
         mnJ221M0pS0my1GVsiFN1qjKh1xKUh/YhFzqFvDvszEgkV/bgnNFiZSP+p7KZhPFe2pf
         vKPgT66FU2I1QnYzwtAl57GZUP0II7k2nOCAf35R+Myy/XYnCaZ8mqyYJfQ3/7owIrAh
         JVqryae/KlNKX6dodw8IlJKV74rj+ZbJgFXAV7dbvclE8hgs2H/HXBukJtj2F/A7y61a
         0J7foH7nES0u4DnySLAH/XTwYZwbvyG4o3WcwOyltr61kl3DVt4HQL7D2J5RL0A2A1Yk
         a5xw==
X-Gm-Message-State: AOAM530wNrxHJ1FTxE7XiWMsc6z/VBYzklMOWuWPpMIMtoHeUzcgboZb
        aL4t7cHNfgqkh2doGkVhiUYhRA==
X-Google-Smtp-Source: ABdhPJxS9geMjJJ4T0bw6fthvvK2zsIEnWkglafbati+yS00A5lLdU81L665O92HzIUDSHK+IBye+w==
X-Received: by 2002:a05:6512:2804:: with SMTP id cf4mr2498975lfb.412.1643986016828;
        Fri, 04 Feb 2022 06:46:56 -0800 (PST)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id y23sm348222lfb.2.2022.02.04.06.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 06:46:56 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <swboyd@chromium.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Prasad Malisetty <pmaliset@codeaurora.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 11/11] PCI: qcom: Add SM8450 PCIe support
Date:   Fri,  4 Feb 2022 17:46:45 +0300
Message-Id: <20220204144645.3016603-12-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220204144645.3016603-1-dmitry.baryshkov@linaro.org>
References: <20220204144645.3016603-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On SM8450 platform PCIe hosts do not use all the clocks (and add several
additional clocks), so expand the driver to handle these requirements.

PCIe0 and PCIe1 hosts use different sets of clocks, so separate entries
are required.

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 55 ++++++++++++++++++++------
 1 file changed, 42 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 6034a933814d..174a650ffbbb 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -160,7 +160,7 @@ struct qcom_pcie_resources_2_3_3 {
 
 /* 6 clocks typically, 7 for sm8250 */
 struct qcom_pcie_resources_2_7_0 {
-	struct clk_bulk_data clks[7];
+	struct clk_bulk_data clks[9];
 	int num_clks;
 	struct regulator_bulk_data supplies[2];
 	struct reset_control *pci_reset;
@@ -189,7 +189,10 @@ struct qcom_pcie_ops {
 
 struct qcom_pcie_cfg {
 	const struct qcom_pcie_ops *ops;
+	bool has_tbu_clk;
 	bool has_ddrss_sf_tbu_clk;
+	bool has_aggre0_clk;
+	bool has_aggre1_clk;
 };
 
 struct qcom_pcie {
@@ -1113,6 +1116,7 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
 	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
 	struct dw_pcie *pci = pcie->pci;
 	struct device *dev = pci->dev;
+	unsigned int idx;
 	int ret;
 
 	res->pci_reset = devm_reset_control_get_exclusive(dev, "pci");
@@ -1126,18 +1130,22 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
 	if (ret)
 		return ret;
 
-	res->clks[0].id = "aux";
-	res->clks[1].id = "cfg";
-	res->clks[2].id = "bus_master";
-	res->clks[3].id = "bus_slave";
-	res->clks[4].id = "slave_q2a";
-	res->clks[5].id = "tbu";
-	if (pcie->cfg->has_ddrss_sf_tbu_clk) {
-		res->clks[6].id = "ddrss_sf_tbu";
-		res->num_clks = 7;
-	} else {
-		res->num_clks = 6;
-	}
+	idx = 0;
+	res->clks[idx++].id = "aux";
+	res->clks[idx++].id = "cfg";
+	res->clks[idx++].id = "bus_master";
+	res->clks[idx++].id = "bus_slave";
+	res->clks[idx++].id = "slave_q2a";
+	if (pcie->cfg->has_tbu_clk)
+		res->clks[idx++].id = "tbu";
+	if (pcie->cfg->has_ddrss_sf_tbu_clk)
+		res->clks[idx++].id = "ddrss_sf_tbu";
+	if (pcie->cfg->has_aggre0_clk)
+		res->clks[idx++].id = "aggre0";
+	if (pcie->cfg->has_aggre1_clk)
+		res->clks[idx++].id = "aggre1";
+
+	res->num_clks = idx;
 
 	ret = devm_clk_bulk_get(dev, res->num_clks, res->clks);
 	if (ret < 0)
@@ -1178,6 +1186,9 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
 		goto err_disable_clocks;
 	}
 
+	/* Wait for reset to complete, required on SM8450 */
+	usleep_range(1000, 1500);
+
 	/* configure PCIe to RC mode */
 	writel(DEVICE_TYPE_RC, pcie->parf + PCIE20_PARF_DEVICE_TYPE);
 
@@ -1427,15 +1438,31 @@ static const struct qcom_pcie_cfg ipq4019_cfg = {
 
 static const struct qcom_pcie_cfg sdm845_cfg = {
 	.ops = &ops_2_7_0,
+	.has_tbu_clk = true,
 };
 
 static const struct qcom_pcie_cfg sm8250_cfg = {
+	.ops = &ops_1_9_0,
+	.has_tbu_clk = true,
+	.has_ddrss_sf_tbu_clk = true,
+};
+
+static const struct qcom_pcie_cfg sm8450_pcie0_cfg = {
+	.ops = &ops_1_9_0,
+	.has_ddrss_sf_tbu_clk = true,
+	.has_aggre0_clk = true,
+	.has_aggre1_clk = true,
+};
+
+static const struct qcom_pcie_cfg sm8450_pcie1_cfg = {
 	.ops = &ops_1_9_0,
 	.has_ddrss_sf_tbu_clk = true,
+	.has_aggre1_clk = true,
 };
 
 static const struct qcom_pcie_cfg sc7280_cfg = {
 	.ops = &ops_1_9_0,
+	.has_tbu_clk = true,
 };
 
 static const struct dw_pcie_ops dw_pcie_ops = {
@@ -1541,6 +1568,8 @@ static const struct of_device_id qcom_pcie_match[] = {
 	{ .compatible = "qcom,pcie-sdm845", .data = &sdm845_cfg },
 	{ .compatible = "qcom,pcie-sm8250", .data = &sm8250_cfg },
 	{ .compatible = "qcom,pcie-sc8180x", .data = &sm8250_cfg },
+	{ .compatible = "qcom,pcie-sm8450-pcie0", .data = &sm8450_pcie0_cfg },
+	{ .compatible = "qcom,pcie-sm8450-pcie1", .data = &sm8450_pcie1_cfg },
 	{ .compatible = "qcom,pcie-sc7280", .data = &sc7280_cfg },
 	{ }
 };
-- 
2.34.1

