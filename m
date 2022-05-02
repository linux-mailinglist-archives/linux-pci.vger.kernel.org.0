Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7390B516A1D
	for <lists+linux-pci@lfdr.de>; Mon,  2 May 2022 06:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382573AbiEBEuQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 May 2022 00:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352623AbiEBEuP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 May 2022 00:50:15 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D0E20193
        for <linux-pci@vger.kernel.org>; Sun,  1 May 2022 21:46:47 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id j8so11602524pll.11
        for <linux-pci@vger.kernel.org>; Sun, 01 May 2022 21:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s57ARSA94pPZPqDottlmXRZq12YDZaNbYb69xMN7IG4=;
        b=ytWdhCoC34qw4fTbqu60vecvNnmKWy7jGvokRxmcYhPIMMTjVWdyy5hq/p/Dz4qxRl
         Ur4Z2h2hINXCYmiPYTW77cVt18nRooMetzcWeEsH8eq1/wtF6d5IgrpyV3MIx+O2fpyv
         +aPCLx1C+iY4b0wLyfePD68clv0yzj/kIQALWLJe+Hz1SMLu0VcvWc62bW+KmjsAQcBN
         PHGHFi264goOdeyD/qK8CokMU+8Pd1K2bYh8nQv8+Qx5iQV83wIhQ2SRX34HHqUNC+jN
         fXoEcOGbWQTSmhMFDddbTqKdDPTFIhSyj8rivaT5YvWCgq9j+59NACGnslVIaqCzeX7T
         jmDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s57ARSA94pPZPqDottlmXRZq12YDZaNbYb69xMN7IG4=;
        b=HU3OxU4aRgEkIYfPvn/DKATOqhZ84NQK6K7XJoMFjCoMxmQ+XVY5P38CYGBiPxeLJM
         KWzKJXifgbfX9qOdQE1Pj8QwsXwM6n7Tah9syBz3j5wE/yBYkPWo4tI/vT1v3EB2zAr6
         I3CemV9qXkMwH81r0dhVqOONEFl2C/xdS5Dww5CVi/YIPTt+2e/rgrhJTS1nyphwFEHt
         BeDeMDKfSPHrYgk4xDphwf5U3K7j/TKpth3qTPbahwZIe5kPlaWwY+cP/Lot13ElUQrB
         P4bMcl8bqgAsPKCbxQKHNym97S5J5MSjqI5wGehc7KH//QcZzh7BWGWPt1PLicrTcOVK
         dD6w==
X-Gm-Message-State: AOAM533k+0gdqO5GUREMHE/ZRpMKK7yM3+5GYOMXFqCounlahXFgUaUq
        r26psAaAn/nOWX8t2ebNU1+4
X-Google-Smtp-Source: ABdhPJzCUjDUYqxv8Wa4kYEoqw6GPAng1W0s+fb29/aRsm5fulQ9nXySkKxO0DwzKZvkvdXnu/7nRQ==
X-Received: by 2002:a17:903:1211:b0:15e:8208:8cc0 with SMTP id l17-20020a170903121100b0015e82088cc0mr10184715plh.52.1651466806727;
        Sun, 01 May 2022 21:46:46 -0700 (PDT)
Received: from localhost.localdomain ([27.111.75.99])
        by smtp.gmail.com with ESMTPSA id r13-20020a62e40d000000b0050dc76281bcsm3659243pfh.150.2022.05.01.21.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 May 2022 21:46:46 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH] PCI: qcom-ep: Move enable/disable resources code to common functions
Date:   Mon,  2 May 2022 10:16:25 +0530
Message-Id: <20220502044625.25210-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
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

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Remove code duplication by moving the code related to enabling/disabling
the resources (PHY, CLK, Reset) to common functions so that they can be
called from multiple places.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
[mani: renamed the functions and reworded the commit message]
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 86 ++++++++++++-----------
 1 file changed, 45 insertions(+), 41 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 6ce8eddf3a37..1c38dcf3e52e 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -223,11 +223,8 @@ static void qcom_pcie_dw_stop_link(struct dw_pcie *pci)
 	disable_irq(pcie_ep->perst_irq);
 }
 
-static int qcom_pcie_perst_deassert(struct dw_pcie *pci)
+static int qcom_pcie_enable_resources(struct qcom_pcie_ep *pcie_ep)
 {
-	struct qcom_pcie_ep *pcie_ep = to_pcie_ep(pci);
-	struct device *dev = pci->dev;
-	u32 val, offset;
 	int ret;
 
 	ret = clk_bulk_prepare_enable(ARRAY_SIZE(qcom_pcie_ep_clks),
@@ -247,6 +244,38 @@ static int qcom_pcie_perst_deassert(struct dw_pcie *pci)
 	if (ret)
 		goto err_phy_exit;
 
+	return 0;
+
+err_phy_exit:
+	phy_exit(pcie_ep->phy);
+err_disable_clk:
+	clk_bulk_disable_unprepare(ARRAY_SIZE(qcom_pcie_ep_clks),
+				   qcom_pcie_ep_clks);
+
+	return ret;
+}
+
+static void qcom_pcie_disable_resources(struct qcom_pcie_ep *pcie_ep)
+{
+	phy_power_off(pcie_ep->phy);
+	phy_exit(pcie_ep->phy);
+	clk_bulk_disable_unprepare(ARRAY_SIZE(qcom_pcie_ep_clks),
+				   qcom_pcie_ep_clks);
+}
+
+static int qcom_pcie_perst_deassert(struct dw_pcie *pci)
+{
+	struct qcom_pcie_ep *pcie_ep = to_pcie_ep(pci);
+	struct device *dev = pci->dev;
+	u32 val, offset;
+	int ret;
+
+	ret = qcom_pcie_enable_resources(pcie_ep);
+	if (ret) {
+		dev_err(dev, "Failed to enable resources: %d\n", ret);
+		return ret;
+	}
+
 	/* Assert WAKE# to RC to indicate device is ready */
 	gpiod_set_value_cansleep(pcie_ep->wake, 1);
 	usleep_range(WAKE_DELAY_US, WAKE_DELAY_US + 500);
@@ -335,7 +364,7 @@ static int qcom_pcie_perst_deassert(struct dw_pcie *pci)
 	ret = dw_pcie_ep_init_complete(&pcie_ep->pci.ep);
 	if (ret) {
 		dev_err(dev, "Failed to complete initialization: %d\n", ret);
-		goto err_phy_power_off;
+		goto err_disable_resources;
 	}
 
 	/*
@@ -355,13 +384,8 @@ static int qcom_pcie_perst_deassert(struct dw_pcie *pci)
 
 	return 0;
 
-err_phy_power_off:
-	phy_power_off(pcie_ep->phy);
-err_phy_exit:
-	phy_exit(pcie_ep->phy);
-err_disable_clk:
-	clk_bulk_disable_unprepare(ARRAY_SIZE(qcom_pcie_ep_clks),
-				   qcom_pcie_ep_clks);
+err_disable_resources:
+	qcom_pcie_disable_resources(pcie_ep);
 
 	return ret;
 }
@@ -376,10 +400,7 @@ static void qcom_pcie_perst_assert(struct dw_pcie *pci)
 		return;
 	}
 
-	phy_power_off(pcie_ep->phy);
-	phy_exit(pcie_ep->phy);
-	clk_bulk_disable_unprepare(ARRAY_SIZE(qcom_pcie_ep_clks),
-				   qcom_pcie_ep_clks);
+	qcom_pcie_disable_resources(pcie_ep);
 	pcie_ep->link_status = QCOM_PCIE_EP_LINK_DISABLED;
 }
 
@@ -643,43 +664,26 @@ static int qcom_pcie_ep_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = clk_bulk_prepare_enable(ARRAY_SIZE(qcom_pcie_ep_clks),
-				      qcom_pcie_ep_clks);
-	if (ret)
+	ret = qcom_pcie_enable_resources(pcie_ep);
+	if (ret) {
+		dev_err(dev, "Failed to enable resources: %d\n", ret);
 		return ret;
-
-	ret = qcom_pcie_ep_core_reset(pcie_ep);
-	if (ret)
-		goto err_disable_clk;
-
-	ret = phy_init(pcie_ep->phy);
-	if (ret)
-		goto err_disable_clk;
-
-	/* PHY needs to be powered on for dw_pcie_ep_init() */
-	ret = phy_power_on(pcie_ep->phy);
-	if (ret)
-		goto err_phy_exit;
+	}
 
 	ret = dw_pcie_ep_init(&pcie_ep->pci.ep);
 	if (ret) {
 		dev_err(dev, "Failed to initialize endpoint: %d\n", ret);
-		goto err_phy_power_off;
+		goto err_disable_resources;
 	}
 
 	ret = qcom_pcie_ep_enable_irq_resources(pdev, pcie_ep);
 	if (ret)
-		goto err_phy_power_off;
+		goto err_disable_resources;
 
 	return 0;
 
-err_phy_power_off:
-	phy_power_off(pcie_ep->phy);
-err_phy_exit:
-	phy_exit(pcie_ep->phy);
-err_disable_clk:
-	clk_bulk_disable_unprepare(ARRAY_SIZE(qcom_pcie_ep_clks),
-				   qcom_pcie_ep_clks);
+err_disable_resources:
+	qcom_pcie_disable_resources(pcie_ep);
 
 	return ret;
 }
-- 
2.25.1

