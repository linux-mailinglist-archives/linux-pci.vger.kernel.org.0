Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF53F4710BB
	for <lists+linux-pci@lfdr.de>; Sat, 11 Dec 2021 03:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240857AbhLKCVr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Dec 2021 21:21:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238399AbhLKCVp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Dec 2021 21:21:45 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48525C061A72
        for <linux-pci@vger.kernel.org>; Fri, 10 Dec 2021 18:18:09 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id l22so21168213lfg.7
        for <linux-pci@vger.kernel.org>; Fri, 10 Dec 2021 18:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L4pIImixrdWMTKaYWRmzrWP1bf+OcXW6Av2PMVI53nk=;
        b=anAS2AffHvkqcz593MNMYdZcymv3KcdnEyExrvaDx8vZDiyDTkHFUXLGBP4fv6ezj9
         FQtU/AV2zpBwCAHBnXXBLKaoXVRuy8k4uL+qq/fnkYz/bX9UgEsPCxRr7wujIHx48Lyo
         oh1N3fzssZ6LJ+coDhBCYpjYL0MxgrMUP3PavpQ9aNfu22nIGfJHqQEgsSsQKixPCiKB
         26vg2ffozvYb1Ysc84Wd0kaUIwmMyWBXw8iyXxw42qrQyIT39tgjidPR08A1peVSYUIl
         fA/PolXO8svkyzZDIQSdjMskf9UJ+o4ycxY+OqIHb8rshUiMKPm/OBQfdlmKYfyZuOGs
         2h4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L4pIImixrdWMTKaYWRmzrWP1bf+OcXW6Av2PMVI53nk=;
        b=LvGbVWEyBu1nuASdlh7eqW12Dz/rw2uT8BfXxyRen/R4ApvdWFz2/fLMjEwssz9JZR
         8VcvcvE/qTidfpxG1zm2TSC0N5W2AbPHpOCaNWoo24pNv87YtnHpaEds0n5/hpfh63iA
         MKKBBExUPuhvm/YV87o4yp4kHXgJjwt4ocOk6ucuQeGL65joS69HBWTUqwAobt8dSKLI
         JNNzp4am2dCZggTgXKsbS3lBJyRsk/L3lWvGUgvQXHSRWVHdv4jZP/tguAvWOnBiMheR
         R4X4SOoZqyULzcl2b7FdLPpNCVz3/qUrwmmhQ9/EciB+Y3e8dwJgdr+8fUMjyocVmce3
         NSiw==
X-Gm-Message-State: AOAM533TLd0PiIwqVx4YDuoKHRYG0WM/8hxeVfH0jrvz4OPtP+oVTKdB
        spsW/oJ44V9kwf+v6X0e2i6yVQ==
X-Google-Smtp-Source: ABdhPJzEjDYrJWa/xhu240z4ZgBNcYSqY9o3we0Jxy7AeW7wyDx9Pl4xJLyBGMsyUQqMo9fyJrLK3Q==
X-Received: by 2002:a19:6752:: with SMTP id e18mr15688396lfj.195.1639189087537;
        Fri, 10 Dec 2021 18:18:07 -0800 (PST)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id y7sm504663lfj.90.2021.12.10.18.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 18:18:07 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-phy@lists.infradead.org
Subject: [PATCH v3 06/10] PCI: qcom: Add SM8450 PCIe support
Date:   Sat, 11 Dec 2021 05:17:54 +0300
Message-Id: <20211211021758.1712299-7-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211211021758.1712299-1-dmitry.baryshkov@linaro.org>
References: <20211211021758.1712299-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On SM8450 platform PCIe hosts do not use all the clocks (and add several
additional clocks), so expand the driver to handle these requirements.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 47 +++++++++++++++++++-------
 1 file changed, 34 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 2f9a9497733e..d129729bb2a6 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -161,7 +161,7 @@ struct qcom_pcie_resources_2_3_3 {
 
 /* 6 clocks typically, 7 for sm8250 */
 struct qcom_pcie_resources_2_7_0 {
-	struct clk_bulk_data clks[7];
+	struct clk_bulk_data clks[9];
 	int num_clks;
 	struct regulator_bulk_data supplies[2];
 	struct reset_control *pci_reset;
@@ -195,7 +195,10 @@ struct qcom_pcie_ops {
 struct qcom_pcie_cfg {
 	const struct qcom_pcie_ops *ops;
 	unsigned int pipe_clk_need_muxing:1;
+	unsigned int has_tbu_clk:1;
 	unsigned int has_ddrss_sf_tbu_clk:1;
+	unsigned int has_aggre0_clk:1;
+	unsigned int has_aggre1_clk:1;
 };
 
 struct qcom_pcie {
@@ -1146,6 +1149,7 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
 	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
 	struct dw_pcie *pci = pcie->pci;
 	struct device *dev = pci->dev;
+	unsigned int idx;
 	int ret;
 
 	res->pci_reset = devm_reset_control_get_exclusive(dev, "pci");
@@ -1159,18 +1163,22 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
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
@@ -1509,15 +1517,27 @@ static const struct qcom_pcie_cfg ipq4019_cfg = {
 
 static const struct qcom_pcie_cfg sdm845_cfg = {
 	.ops = &ops_2_7_0,
+	.has_tbu_clk = true,
 };
 
 static const struct qcom_pcie_cfg sm8250_cfg = {
 	.ops = &ops_1_9_0,
+	.has_tbu_clk = true,
 	.has_ddrss_sf_tbu_clk = true,
 };
 
+/* Only for the PCIe0! */
+static const struct qcom_pcie_cfg sm8450_cfg = {
+	.ops = &ops_1_9_0,
+	.has_ddrss_sf_tbu_clk = true,
+	.pipe_clk_need_muxing = true,
+	.has_aggre0_clk = true,
+	.has_aggre1_clk = true,
+};
+
 static const struct qcom_pcie_cfg sc7280_cfg = {
 	.ops = &ops_1_9_0,
+	.has_tbu_clk = true,
 	.pipe_clk_need_muxing = true,
 };
 
@@ -1625,6 +1645,7 @@ static const struct of_device_id qcom_pcie_match[] = {
 	{ .compatible = "qcom,pcie-sdm845", .data = &sdm845_cfg },
 	{ .compatible = "qcom,pcie-sm8250", .data = &sm8250_cfg },
 	{ .compatible = "qcom,pcie-sc8180x", .data = &sm8250_cfg },
+	{ .compatible = "qcom,pcie-sm8450", .data = &sm8450_cfg },
 	{ .compatible = "qcom,pcie-sc7280", .data = &sc7280_cfg },
 	{ }
 };
-- 
2.33.0

