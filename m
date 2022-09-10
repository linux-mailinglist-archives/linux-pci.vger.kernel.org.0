Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3495B447C
	for <lists+linux-pci@lfdr.de>; Sat, 10 Sep 2022 08:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiIJGb1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 10 Sep 2022 02:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbiIJGb0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 10 Sep 2022 02:31:26 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B99DA1A49
        for <linux-pci@vger.kernel.org>; Fri,  9 Sep 2022 23:31:20 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id bd26-20020a05600c1f1a00b003a5e82a6474so3194857wmb.4
        for <linux-pci@vger.kernel.org>; Fri, 09 Sep 2022 23:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=26/uwpg877kUcP36OEZ2fnl1A+0pDTFxJzbD+WiV7CI=;
        b=FzZlz3yNsH4nAO27cG6JX1X9/Iz0rM4otNc9g1k1HgNBlCE+6JbdeMYLRfXWaTSMyK
         gbqW/ur2AeaieoW1gQOP/+3C9v1ASV+Wy7tserxclG4ChCwGMh1zm3NDij6Vb7o9YP5Z
         Lw1x10Bttln8pfggX+nIG8ifmnh+TYK7lx6fLSMAk8FvUwMt2E95Gdc5zUSRMybCN89V
         bYLovBm89Pk2bqvoZvv4CucYi1WchYDloA0dyg1ZSUsxtCgyU8D60Bm6KyDEEacjP5xP
         BptD0pwfJ8YxkAmAnPQzUQcTL3P8z+NuOh+YsD+dS6JaL5BT3AwsWizHUhvy4rXUccYv
         6a6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=26/uwpg877kUcP36OEZ2fnl1A+0pDTFxJzbD+WiV7CI=;
        b=FAOZDPzzqa7sot/7DFcgODwVrm31c5kYQyRtk0AOVDQA8gaoI1nd/Chgw8ZtsjXDp6
         agLN3lt+4hPWUGKMw6z15pFIYW5G4bNLrxrnHZtwYrh1IhgoUprYJvXH27z4NNCz0YWP
         FfE4KE/xwuH6+gEiJsS/H3OpBoH7ZQem4VrJgRL2IrybIqPpcg9n+kAWF/z0F3D3JFYM
         xdpHIXokdxkJksd5V2pzRtLctErKcyFRM88leq5p7qztzWQaaESsm9zoMCDFPLM3LVWe
         7adulng+wOOPrSq/nvlFnC8v9cr8AiGMS8YxbIVJVqy5IQNutV99clJFDbIVMUW8kfEu
         TeAQ==
X-Gm-Message-State: ACgBeo30YhiN5FqZpuEwYpRnB8+XqX9aLxZjwTrdcDeiLNN9PQZL3HeR
        qL6r5jzetiyAl7xRX6so19a/
X-Google-Smtp-Source: AA6agR5LbQPl/dPMENW2aVEm2V9TO+13LfZuyRgQjOOawU1iK1bAd1yQqUsB+Mr+LVMQnM0AfbYFag==
X-Received: by 2002:a7b:c34b:0:b0:3a6:8516:a729 with SMTP id l11-20020a7bc34b000000b003a68516a729mr7702925wmj.83.1662791478442;
        Fri, 09 Sep 2022 23:31:18 -0700 (PDT)
Received: from localhost.localdomain ([117.217.182.47])
        by smtp.gmail.com with ESMTPSA id n16-20020a05600c4f9000b003a5c7a942edsm2828122wmq.28.2022.09.09.23.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 23:31:17 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, robh@kernel.org, andersson@kernel.org
Cc:     kw@linux.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        dmitry.baryshkov@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 02/12] PCI: qcom-ep: Do not use hardcoded clks in driver
Date:   Sat, 10 Sep 2022 12:00:35 +0530
Message-Id: <20220910063045.16648-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220910063045.16648-1-manivannan.sadhasivam@linaro.org>
References: <20220910063045.16648-1-manivannan.sadhasivam@linaro.org>
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

Generally, device drivers should just rely on the platform data like
devicetree to supply the clocks required for the functioning of the
peripheral. There is no need to hardcode the clk info in the driver.
So get rid of the static clk info and obtain the platform supplied
clks.

The total number of clocks supplied is obtained using the
devm_clk_bulk_get_all() API and used for the rest of the clk_bulk_ APIs.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 33 +++++++++--------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 27b7c9710b5f..34c498d581de 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -130,16 +130,6 @@ enum qcom_pcie_ep_link_status {
 	QCOM_PCIE_EP_LINK_DOWN,
 };
 
-static struct clk_bulk_data qcom_pcie_ep_clks[] = {
-	{ .id = "cfg" },
-	{ .id = "aux" },
-	{ .id = "bus_master" },
-	{ .id = "bus_slave" },
-	{ .id = "ref" },
-	{ .id = "sleep" },
-	{ .id = "slave_q2a" },
-};
-
 /**
  * struct qcom_pcie_ep - Qualcomm PCIe Endpoint Controller
  * @pci: Designware PCIe controller struct
@@ -151,6 +141,8 @@ static struct clk_bulk_data qcom_pcie_ep_clks[] = {
  * @reset: PERST# GPIO
  * @wake: WAKE# GPIO
  * @phy: PHY controller block
+ * @clks: PCIe clocks
+ * @num_clks: PCIe clocks count
  * @perst_en: Flag for PERST enable
  * @perst_sep_en: Flag for PERST separation enable
  * @link_status: PCIe Link status
@@ -170,6 +162,9 @@ struct qcom_pcie_ep {
 	struct gpio_desc *wake;
 	struct phy *phy;
 
+	struct clk_bulk_data *clks;
+	int num_clks;
+
 	u32 perst_en;
 	u32 perst_sep_en;
 
@@ -244,8 +239,7 @@ static int qcom_pcie_enable_resources(struct qcom_pcie_ep *pcie_ep)
 {
 	int ret;
 
-	ret = clk_bulk_prepare_enable(ARRAY_SIZE(qcom_pcie_ep_clks),
-				      qcom_pcie_ep_clks);
+	ret = clk_bulk_prepare_enable(pcie_ep->num_clks, pcie_ep->clks);
 	if (ret)
 		return ret;
 
@@ -266,8 +260,7 @@ static int qcom_pcie_enable_resources(struct qcom_pcie_ep *pcie_ep)
 err_phy_exit:
 	phy_exit(pcie_ep->phy);
 err_disable_clk:
-	clk_bulk_disable_unprepare(ARRAY_SIZE(qcom_pcie_ep_clks),
-				   qcom_pcie_ep_clks);
+	clk_bulk_disable_unprepare(pcie_ep->num_clks, pcie_ep->clks);
 
 	return ret;
 }
@@ -276,8 +269,7 @@ static void qcom_pcie_disable_resources(struct qcom_pcie_ep *pcie_ep)
 {
 	phy_power_off(pcie_ep->phy);
 	phy_exit(pcie_ep->phy);
-	clk_bulk_disable_unprepare(ARRAY_SIZE(qcom_pcie_ep_clks),
-				   qcom_pcie_ep_clks);
+	clk_bulk_disable_unprepare(pcie_ep->num_clks, pcie_ep->clks);
 }
 
 static int qcom_pcie_perst_deassert(struct dw_pcie *pci)
@@ -495,10 +487,11 @@ static int qcom_pcie_ep_get_resources(struct platform_device *pdev,
 		return ret;
 	}
 
-	ret = devm_clk_bulk_get(dev, ARRAY_SIZE(qcom_pcie_ep_clks),
-				qcom_pcie_ep_clks);
-	if (ret)
-		return ret;
+	pcie_ep->num_clks = devm_clk_bulk_get_all(dev, &pcie_ep->clks);
+	if (pcie_ep->num_clks < 0) {
+		dev_err(dev, "Failed to get clocks\n");
+		return pcie_ep->num_clks;
+	}
 
 	pcie_ep->core_reset = devm_reset_control_get_exclusive(dev, "core");
 	if (IS_ERR(pcie_ep->core_reset))
-- 
2.25.1

