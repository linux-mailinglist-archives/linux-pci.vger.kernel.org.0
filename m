Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68396479B22
	for <lists+linux-pci@lfdr.de>; Sat, 18 Dec 2021 15:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233301AbhLROCf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 18 Dec 2021 09:02:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233289AbhLROCe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 18 Dec 2021 09:02:34 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FFEFC061574
        for <linux-pci@vger.kernel.org>; Sat, 18 Dec 2021 06:02:34 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id m12so7876856ljj.6
        for <linux-pci@vger.kernel.org>; Sat, 18 Dec 2021 06:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BUWOn5eKNvIwdyRJd4jzvmP+6dWkUCLvqOM8SxqkIyM=;
        b=tsAp9EC4yt0icJA1vkMGVuP0WwlhcOGskpBLiqd5jsetUctRDyBv+EHetdKdxtiXcv
         dybTcGCaYAeyv7mpk4JDYebPy12AUpPuzM9M7QthQCLRjhfkKsPmiLDp5abtognPG/tZ
         Op45u9mX4MsIQh9XSpZoYxvIM0uHOnSNodRFDiPhH6Btll2lfrgnWujQO952g5LAhgaM
         hGIPjj+mAuhcc7t9lmOjnro5k+fUrQRUs4OlBt9qHdwXP7UofOxmM/PYGQUkN41K2Cea
         xUb67LshATUebszpZfvvEB+jeZUMTwURJlMZoeR/FPOCVvHLoIE+Yc1hY6GqJUBOH7wA
         YXgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BUWOn5eKNvIwdyRJd4jzvmP+6dWkUCLvqOM8SxqkIyM=;
        b=ly6LXYdBCo0M3BHBHLlt07rY1jAFjR0ZUL9w1sdj7EAfc/qvsseajubRToekLt+rPm
         8YTRf4PDdZv487tMW3OspimUO5cbI12nfcFeGdtMJf+GSdSuqmxaoimLY7+RfYm3bKah
         3zm+dkHmI/1sgSf0TMkyWaLUS2peEbVVni8EUSVHM29iOzx8Cf7bwoK9rwwNxSw/Jzlt
         5HzbsQqC7dBm91RZ8cpGlPH2P5LS0pKMgg8ZuD+GNE2OrmLUUls1OH4S+wC0UeJo8wux
         B3CnWlcBV5SWf1t2RTDdNE/AagNBwlSbtixaFM0pBK1nyRA3x/CKG56RRdq6AsFjuATy
         Ex9g==
X-Gm-Message-State: AOAM531AAdnGX7XSeJ0u2z33umM4Gw6rzUsW0KIc+r39LqWLPeJ3yT2l
        bVEDfOTRAY9kYZw9kCtICAMrcQ==
X-Google-Smtp-Source: ABdhPJxa5Y86yQUN2Fufipjz0vjbyEDIcX5po2nVTgtoD41RSKvE6mdoGMQFOGk1yxOXdgaTipZLEg==
X-Received: by 2002:a2e:a361:: with SMTP id i1mr6921365ljn.32.1639836152452;
        Sat, 18 Dec 2021 06:02:32 -0800 (PST)
Received: from eriador.lan ([2001:470:dd84:abc0::8a5])
        by smtp.gmail.com with ESMTPSA id s15sm2023979ljj.14.2021.12.18.06.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Dec 2021 06:02:32 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        Prasad Malisetty <pmaliset@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>
Subject: [PATCH 2/3] PCI: qcom: Fix pipe_clk_src reparenting
Date:   Sat, 18 Dec 2021 17:02:22 +0300
Message-Id: <20211218140223.500390-3-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211218140223.500390-1-dmitry.baryshkov@linaro.org>
References: <20211218140223.500390-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The hardware requires that pipe_clk_src is fed from TCXO when GDSC is
disabled. It can be fed from PHY's pipe_clk once GDSC is enabled (which
is what is done by the downstream driver).

Currently code does all clk_set_parent() calls after the
pm_runtime_get(), so the GDSC is already enabled.
Implement these requirements by moving pm_runtime_*() calls after
get_resources (so that get_resources() can ensure that the pipe clock
parent is TCXO).

Fixes: aa9c0df98c29 ("PCI: qcom: Switch pcie_1_pipe_clk_src after PHY init in SC7280")
Cc: Prasad Malisetty <pmaliset@codeaurora.org>
Cc: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 52 ++++++++++++--------------
 1 file changed, 24 insertions(+), 28 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 3a0f126db5a3..fbaae6f4eb18 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1188,6 +1188,9 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
 		res->ref_clk_src = devm_clk_get(dev, "ref");
 		if (IS_ERR(res->ref_clk_src))
 			return PTR_ERR(res->ref_clk_src);
+
+		/* Ensure that the TCXO is a clock source for pcie_pipe_clk_src */
+		clk_set_parent(res->pipe_clk_src, res->ref_clk_src);
 	}
 
 	res->pipe_clk = devm_clk_get(dev, "pipe");
@@ -1208,9 +1211,9 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
 		return ret;
 	}
 
-	/* Set TCXO as clock source for pcie_pipe_clk_src */
+	/* Set pipe clock as clock source for pcie_pipe_clk_src */
 	if (pcie->pipe_clk_need_muxing)
-		clk_set_parent(res->pipe_clk_src, res->ref_clk_src);
+		clk_set_parent(res->pipe_clk_src, res->phy_pipe_clk);
 
 	ret = clk_bulk_prepare_enable(res->num_clks, res->clks);
 	if (ret < 0)
@@ -1276,6 +1279,11 @@ static void qcom_pcie_deinit_2_7_0(struct qcom_pcie *pcie)
 	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
 
 	clk_bulk_disable_unprepare(res->num_clks, res->clks);
+
+	/* Set TCXO as clock source for pcie_pipe_clk_src */
+	if (pcie->pipe_clk_need_muxing)
+		clk_set_parent(res->pipe_clk_src, res->ref_clk_src);
+
 	regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
 }
 
@@ -1283,10 +1291,6 @@ static int qcom_pcie_post_init_2_7_0(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
 
-	/* Set pipe clock as clock source for pcie_pipe_clk_src */
-	if (pcie->pipe_clk_need_muxing)
-		clk_set_parent(res->pipe_clk_src, res->phy_pipe_clk);
-
 	return clk_prepare_enable(res->pipe_clk);
 }
 
@@ -1542,11 +1546,6 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	if (!pci)
 		return -ENOMEM;
 
-	pm_runtime_enable(dev);
-	ret = pm_runtime_resume_and_get(dev);
-	if (ret < 0)
-		goto err_pm_runtime_disable;
-
 	pci->dev = dev;
 	pci->ops = &dw_pcie_ops;
 	pp = &pci->pp;
@@ -1563,32 +1562,29 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	pcie->pipe_clk_need_muxing = pcie_cfg->pipe_clk_need_muxing;
 
 	pcie->reset = devm_gpiod_get_optional(dev, "perst", GPIOD_OUT_HIGH);
-	if (IS_ERR(pcie->reset)) {
-		ret = PTR_ERR(pcie->reset);
-		goto err_pm_runtime_put;
-	}
+	if (IS_ERR(pcie->reset))
+		return PTR_ERR(pcie->reset);
 
 	pcie->parf = devm_platform_ioremap_resource_byname(pdev, "parf");
-	if (IS_ERR(pcie->parf)) {
-		ret = PTR_ERR(pcie->parf);
-		goto err_pm_runtime_put;
-	}
+	if (IS_ERR(pcie->parf))
+		return PTR_ERR(pcie->parf);
 
 	pcie->elbi = devm_platform_ioremap_resource_byname(pdev, "elbi");
-	if (IS_ERR(pcie->elbi)) {
-		ret = PTR_ERR(pcie->elbi);
-		goto err_pm_runtime_put;
-	}
+	if (IS_ERR(pcie->elbi))
+		return PTR_ERR(pcie->elbi);
 
 	pcie->phy = devm_phy_optional_get(dev, "pciephy");
-	if (IS_ERR(pcie->phy)) {
-		ret = PTR_ERR(pcie->phy);
-		goto err_pm_runtime_put;
-	}
+	if (IS_ERR(pcie->phy))
+		return PTR_ERR(pcie->phy);
 
 	ret = pcie->ops->get_resources(pcie);
 	if (ret)
-		goto err_pm_runtime_put;
+		return ret;
+
+	pm_runtime_enable(dev);
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret < 0)
+		goto err_pm_runtime_disable;
 
 	pp->ops = &qcom_pcie_dw_ops;
 
-- 
2.34.1

