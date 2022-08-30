Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0B95A68F7
	for <lists+linux-pci@lfdr.de>; Tue, 30 Aug 2022 18:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbiH3Q7F (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Aug 2022 12:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbiH3Q64 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Aug 2022 12:58:56 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC538B6D4D
        for <linux-pci@vger.kernel.org>; Tue, 30 Aug 2022 09:58:54 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id y141so11937441pfb.7
        for <linux-pci@vger.kernel.org>; Tue, 30 Aug 2022 09:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=26/uwpg877kUcP36OEZ2fnl1A+0pDTFxJzbD+WiV7CI=;
        b=i8e6sP2Y8Docm66LdDaQdv4DRn9gJu1+qSc50GmbXZp0bE/imrG+OAvUy2sjxxvfvZ
         u5/pm1+RifQipRyfTN3/7bhfU6YS09f+g5+6/pRhsYogVgWtuwSiySj1tiy0WlYNYeQ4
         n9IDiuVTm3A2CbQsdv6ptN7F2E5xpc5rnc1FSRY59B5shYSNTXYueOLI1DJFJU0g5Y3E
         yTh3Dy6i/575OB+aqvTPZOIB4X9icWam9IUvCCvPI2q9nEhopls4vTVIw23zDGRff8v+
         LV4awYbiu0eDsR+C3ZDNTZ/LewUNYVmrm13EEo0YZ24OM7lSe2ii2Xk52u0+bBPV3SGD
         n3Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=26/uwpg877kUcP36OEZ2fnl1A+0pDTFxJzbD+WiV7CI=;
        b=Bb4SBaHNYeFbU68MjbKu3Ds6bQZzVv3c9Zg2e6cFYAtYIXMs0PPglbl37bErSHWQzZ
         y8r/2SAm/plTdq6saC49WAxhrMbPcdbt4dJ8NEfr7J/3jpFPKYIHGhlPcDei+KuCDkt6
         1Ihm0S7QIakQmi3E6HQwv47Y5Yj259C5JuhL9R06f0VgD3P9mlP4NURbinMqCAgxemdv
         G1lA25bs46Kv8/b/u2jZdwrK0ubNjq04bqCNwvZyoMK9ClEmb1oJPK8M4r5Cy+gm0Myz
         q+QMjsF1UvTYSpxp/N5P5A/ukiz3tTq0D4bmaQN7AqXHxEMHJ0PabmZcsuvDNWzKuhYx
         vY6A==
X-Gm-Message-State: ACgBeo19MHXniHFU3IG45sDfirwhZTUZH4Cyk3/xwbGRxA6+5SpZWVCu
        94ISPp0mFE2Un6L6GGwFG45z
X-Google-Smtp-Source: AA6agR6A57E+jhcVSk0MIoxD9Gl7X2cRLTAlcV2H/cO1MwqANKqc9CRckbkoOiDz1IgMMipx3Fqo6A==
X-Received: by 2002:a05:6a00:14c2:b0:53a:a5bc:a2ec with SMTP id w2-20020a056a0014c200b0053aa5bca2ecmr65216pfu.27.1661878733397;
        Tue, 30 Aug 2022 09:58:53 -0700 (PDT)
Received: from localhost.localdomain ([117.217.182.234])
        by smtp.gmail.com with ESMTPSA id n59-20020a17090a5ac100b001f510175984sm8841261pji.41.2022.08.30.09.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 09:58:53 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, robh@kernel.org, andersson@kernel.org
Cc:     kw@linux.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        dmitry.baryshkov@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 02/11] PCI: qcom-ep: Do not use hardcoded clks in driver
Date:   Tue, 30 Aug 2022 22:28:08 +0530
Message-Id: <20220830165817.183571-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220830165817.183571-1-manivannan.sadhasivam@linaro.org>
References: <20220830165817.183571-1-manivannan.sadhasivam@linaro.org>
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

