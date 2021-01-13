Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F37D2F4F2E
	for <lists+linux-pci@lfdr.de>; Wed, 13 Jan 2021 16:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbhAMPuX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Jan 2021 10:50:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbhAMPuX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Jan 2021 10:50:23 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04297C0617A2
        for <linux-pci@vger.kernel.org>; Wed, 13 Jan 2021 07:49:43 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id s26so3429015lfc.8
        for <linux-pci@vger.kernel.org>; Wed, 13 Jan 2021 07:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EGe2d/tltRwx5KCxDzrjJBN1zvE0UZ31mQXprkqZeSc=;
        b=pqMXlFAc7ULhS1zYkm4WvoKrTuJmbEVH/zHmDIVveu/dm+8mN0ZYwe/ojcq/5FpQzB
         UPjWn/hQy6+f6KbWjZIBBvCmnfxgzw26zgITBBDWBuGhvNIRbhWh//LHm5ipZexlduu+
         fUzM/Fk4eJICYI4E+7nnGWafGGI+7dsN9RZuiW0WBy9NM0iz3EYs9NEzuCJRVoa8o8n7
         WxPZ3HBlNjIg9PkTFBovGhQeCenHQEhzLzuCTu3POyte0UC9yadxPfJuMrUr2S8e9E6U
         kt88SbhBcBcx5Y1Zqs5+eds+SNCZ1fJqk3UXubmXoq/aG6F1vMWHFFhzpJbtA6gnAkmG
         RuVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EGe2d/tltRwx5KCxDzrjJBN1zvE0UZ31mQXprkqZeSc=;
        b=fGwofi/8a7vO2vNECXp++bnjYJvMDYJV7U/KmxwAocFLRkKk4Si7BWu57/pMJuRgvp
         RRemPpb7PgleZ62yt9CvdSLp+xJp30qso0qFF+QWoE9SvETTqwu7iINvZ+PO5M2cBb+l
         S756/zLhB941oxoegLAbKBGzHDEWEdH5qMGfJN56hhuYcPg47u6d2PJYvE4qzri+ajL1
         NIUdrY3BKIKQMCgCbT7LxoP/PRK3afXRxEWme1wWZBRVmRjTzZdnqy7ZhnnXBPhDvI6O
         iu/o8BcXlpwB2StaMb6R6W0xb9CZbDA6FVT0bxHVJIxU+QVe9kdTK+nQfbrLiAATPUIo
         kh1w==
X-Gm-Message-State: AOAM532y4ApbNjyiLN16Z2XLzLljI+W/Ulf03fCwVhqOBPUR3FJILN2M
        x0eP0CzMKEeUcSxpA9Ig22n7U+XavuC8hg==
X-Google-Smtp-Source: ABdhPJyBGl5j/48pWHwo1S93XoH4/1ZXHXCUXXN7TyHVK5lEDO/xgnB4Guojsy5Re7KrU+7cNH/i+w==
X-Received: by 2002:a05:6512:41b:: with SMTP id u27mr1066419lfk.434.1610552981500;
        Wed, 13 Jan 2021 07:49:41 -0800 (PST)
Received: from eriador.lumag.spb.ru ([94.25.228.189])
        by smtp.gmail.com with ESMTPSA id g13sm246828lfb.43.2021.01.13.07.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 07:49:40 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-pci@vger.kernel.org
Subject: [PATCH v4 2/2] PCI: qcom: add support for ddrss_sf_tbu clock
Date:   Wed, 13 Jan 2021 18:49:35 +0300
Message-Id: <20210113154935.3972869-3-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210113154935.3972869-1-dmitry.baryshkov@linaro.org>
References: <20210113154935.3972869-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On SM8250 additional clock is required for PCIe devices to access NOC.
Update PCIe controller driver to control this clock.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Fixes: e1dd639e374a ("PCI: qcom: Add SM8250 SoC support")
---
 drivers/pci/controller/dwc/pcie-qcom.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index affa2713bf80..e2140aba220a 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -159,8 +159,10 @@ struct qcom_pcie_resources_2_3_3 {
 	struct reset_control *rst[7];
 };
 
+#define QCOM_PCIE_2_7_0_MAX_CLOCKS	7
 struct qcom_pcie_resources_2_7_0 {
-	struct clk_bulk_data clks[6];
+	struct clk_bulk_data clks[QCOM_PCIE_2_7_0_MAX_CLOCKS];
+	int num_clks;
 	struct regulator_bulk_data supplies[2];
 	struct reset_control *pci_reset;
 	struct clk *pipe_clk;
@@ -1133,6 +1135,7 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
 	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
 	struct dw_pcie *pci = pcie->pci;
 	struct device *dev = pci->dev;
+	bool has_sf_tbu = of_device_is_compatible(dev->of_node, "qcom,pcie-sm8250");
 	int ret;
 
 	res->pci_reset = devm_reset_control_get_exclusive(dev, "pci");
@@ -1152,8 +1155,14 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
 	res->clks[3].id = "bus_slave";
 	res->clks[4].id = "slave_q2a";
 	res->clks[5].id = "tbu";
+	if (has_sf_tbu) {
+		res->clks[6].id = "ddrss_sf_tbu";
+		res->num_clks = 7;
+	} else {
+		res->num_clks = 6;
+	}
 
-	ret = devm_clk_bulk_get(dev, ARRAY_SIZE(res->clks), res->clks);
+	ret = devm_clk_bulk_get(dev, res->num_clks, res->clks);
 	if (ret < 0)
 		return ret;
 
@@ -1175,7 +1184,7 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
 		return ret;
 	}
 
-	ret = clk_bulk_prepare_enable(ARRAY_SIZE(res->clks), res->clks);
+	ret = clk_bulk_prepare_enable(res->num_clks, res->clks);
 	if (ret < 0)
 		goto err_disable_regulators;
 
@@ -1227,7 +1236,7 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
 
 	return 0;
 err_disable_clocks:
-	clk_bulk_disable_unprepare(ARRAY_SIZE(res->clks), res->clks);
+	clk_bulk_disable_unprepare(res->num_clks, res->clks);
 err_disable_regulators:
 	regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
 
@@ -1238,7 +1247,7 @@ static void qcom_pcie_deinit_2_7_0(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
 
-	clk_bulk_disable_unprepare(ARRAY_SIZE(res->clks), res->clks);
+	clk_bulk_disable_unprepare(res->num_clks, res->clks);
 	regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
 }
 
-- 
2.29.2

