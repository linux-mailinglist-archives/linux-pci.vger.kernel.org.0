Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 390CA5A2E44
	for <lists+linux-pci@lfdr.de>; Fri, 26 Aug 2022 20:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344540AbiHZSTu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Aug 2022 14:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344539AbiHZSTs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Aug 2022 14:19:48 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8082627A
        for <linux-pci@vger.kernel.org>; Fri, 26 Aug 2022 11:19:45 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id y141so2280444pfb.7
        for <linux-pci@vger.kernel.org>; Fri, 26 Aug 2022 11:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=26/uwpg877kUcP36OEZ2fnl1A+0pDTFxJzbD+WiV7CI=;
        b=I7rC3TM+QYgSx+Yn3/roI3whxhDTL98tp0j54avWuc3snEUzo85oavP5qM2gla3nVn
         QjOlwK9A/dmD3TgVDhe/uRiMfy7yprut2/IfugGyTmbShTg+k66xxGIjLkuzQnOJveFf
         IXo3vkq7dteCK1zVV9MHqTB6EbZO9IIkj4HJbKPIOu8Rkbv2wPyRD2nNMjR5w8KtWuso
         uQafnp4Gtjma+LlVHT+8Lsslkyq15mfUA1c2Asl4JIOMhnWAlxTvFK4crLiqCQnsneWL
         zEn0ZTYyus9RJn+ChueBjzC97PtMqVnXt0mcA9yuena3fPcwvvBDku1esBf5XNvkQNji
         q37w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=26/uwpg877kUcP36OEZ2fnl1A+0pDTFxJzbD+WiV7CI=;
        b=CtwGY54hkmu2EwYBasC/YOb/Zl/qlVmIzwMPZcuh37PS1/0m1Fi76z/sZ3XYPBiXbx
         j4yjttak2vmhNJ7LwQh6bkdOT0zNhZi6dZWU4ZsOkah7INus38MjH0s1grbNIt39+hvM
         W+0LRvRzAINghRjAuoOn5djZVAwaFS0CXj+715Z2Y9Dm4UZOAOsQwFyS3sU1oYvpU7wG
         HldbvnO3VNCeAAnkAqMuwGFohexqySTbrtcsvgZuv0bLRtCKcJUlhWDUzlFRWu4zk5fY
         uvtPn7vac2d7KA2gXHtZAwb8XagJ9NQHj65x+/d/EWgl0WhaxkL2HMKMSvWf9tdRXIr0
         mncw==
X-Gm-Message-State: ACgBeo2wTLJXBBZ6sT2fPL42gAhsPVxBeFvke8Do70eVDvjGjvp5DVqy
        u0ZQnrHLDIuIVE7DwfIYSZ3N
X-Google-Smtp-Source: AA6agR7vHAkRx/lJEa8ntuqLkDeYyizTY/pUU+SIppgwDc7OJdW0/PONTzpk/NMrisBb5E4FUs2Rxg==
X-Received: by 2002:a05:6a00:1251:b0:536:b942:35c7 with SMTP id u17-20020a056a00125100b00536b94235c7mr4954694pfi.72.1661537984708;
        Fri, 26 Aug 2022 11:19:44 -0700 (PDT)
Received: from localhost.localdomain ([117.193.214.147])
        by smtp.gmail.com with ESMTPSA id s5-20020a170902b18500b00173368e9dedsm1881868plr.252.2022.08.26.11.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 11:19:44 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, robh@kernel.org, andersson@kernel.org
Cc:     kw@linux.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        dmitry.baryshkov@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 02/11] PCI: qcom-ep: Do not use hardcoded clks in driver
Date:   Fri, 26 Aug 2022 23:49:14 +0530
Message-Id: <20220826181923.251564-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220826181923.251564-1-manivannan.sadhasivam@linaro.org>
References: <20220826181923.251564-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
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

