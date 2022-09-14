Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08D5C5B8257
	for <lists+linux-pci@lfdr.de>; Wed, 14 Sep 2022 09:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbiINHyU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Sep 2022 03:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbiINHyQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Sep 2022 03:54:16 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2CBD72FE5
        for <linux-pci@vger.kernel.org>; Wed, 14 Sep 2022 00:54:13 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id o70-20020a17090a0a4c00b00202f898fa86so4230540pjo.2
        for <linux-pci@vger.kernel.org>; Wed, 14 Sep 2022 00:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=26/uwpg877kUcP36OEZ2fnl1A+0pDTFxJzbD+WiV7CI=;
        b=BN4PaskBUK1LAkG0wxpTxXoYt++UqRhab0y4tgn3dXjJHzldWqV8WwKMK982MTSRJL
         rWSHJJkvTufKdHlyJRXR8o+HhXX60yT5K8sCg7dRaGwbICO7A9To5ShmkRREplABlFnt
         6axrQnYA95nTtk+9kpuoqO/l8gV3WxKZZTMG07ilyoqRPJDSGj6Mn4r0nBeEPZfIZ7oK
         Qdj/se1AipSOG+fGF/rl69e8phdEySpp7VsURfzuBy0nL4M0eSDy1cp+tRnUHxyO5Fwm
         swyipe9SIudc/HbF1qO0iMqT0TNuD+wNpF389l7THnncbrl7Efwd1CoCDAzgyMfuvMuz
         LjCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=26/uwpg877kUcP36OEZ2fnl1A+0pDTFxJzbD+WiV7CI=;
        b=Eu51CU5w8IYLvTQWyYvFzrz4OaitwDSQ5jdZ9yQS/es7PRNQxLGZfNYc/hpD+nOKL5
         w5eBDbHZqPPBpNfEZ8T1bNLJJjxZ23QT6EPWqeX189Knz+RydELzffo+QsXAMxpeYJzz
         A0Q9nnOlMzG3ncyB/Zaped1sx6//F60mfHgKbKD+LYLXaN5GE3eQAWF7Js2rf+g9JluS
         l5DJ+dOg+E/P68oUUo2wU8/H4u1Pi6gqCvX8Lp4rweb6Y1wtYL+ey1YYZmZtMGkuGO4w
         8mNHn43rbUYuoD5fwwTGZ5+RXOJdXyocyoQaiAnq/E7gDisSq4ZspEC/PJORu6SvlEYA
         5Q9w==
X-Gm-Message-State: ACrzQf33T4kx1WqLT9cxsDz8qtAygQ1pxZIp0EthDxC3x4eV2z4pjDSo
        iGXZMZVxVGAUkqIbYi7lRxKU
X-Google-Smtp-Source: AMsMyM5gQvdgJBCMaErQI1GsuC5WTIi7rcyhvK3RfM5sljJvEnzEkshNysDxavhPhzNglmiYNI4oxQ==
X-Received: by 2002:a17:90b:3a87:b0:202:d8b7:2c03 with SMTP id om7-20020a17090b3a8700b00202d8b72c03mr3453142pjb.199.1663142053270;
        Wed, 14 Sep 2022 00:54:13 -0700 (PDT)
Received: from localhost.localdomain ([117.202.184.122])
        by smtp.gmail.com with ESMTPSA id p8-20020a1709027ec800b00174ea015ee2sm10119054plb.38.2022.09.14.00.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 00:54:12 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, robh@kernel.org, andersson@kernel.org
Cc:     kw@linux.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        dmitry.baryshkov@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 02/12] PCI: qcom-ep: Rely on the clocks supplied by devicetree
Date:   Wed, 14 Sep 2022 13:23:40 +0530
Message-Id: <20220914075350.7992-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220914075350.7992-1-manivannan.sadhasivam@linaro.org>
References: <20220914075350.7992-1-manivannan.sadhasivam@linaro.org>
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

