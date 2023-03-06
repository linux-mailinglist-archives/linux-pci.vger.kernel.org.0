Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3BCF6AC532
	for <lists+linux-pci@lfdr.de>; Mon,  6 Mar 2023 16:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbjCFPdw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Mar 2023 10:33:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjCFPdp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Mar 2023 10:33:45 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999D922DC7
        for <linux-pci@vger.kernel.org>; Mon,  6 Mar 2023 07:33:12 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id n6so10784688plf.5
        for <linux-pci@vger.kernel.org>; Mon, 06 Mar 2023 07:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678116783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UJ4Ik+ZoB8puIUL4lEznFsK6NoJYzy77sft3aaSqBZo=;
        b=DL/hWjcip5WwJihBQjlGRTyZlqBoBlVO70mke6sPwAFBexxy0QGwmm2ijXriVql0oe
         TRVvfCp4t/xUO3qKZi8uh3VWBeZIITWyeHunerFBBr1gYlHI26R/e9WWDliuowslxNQh
         6HdVnWrJA5XzwQUv3ISLrX3BxakQeZ0VBSeqXU9e7z58KrH/Aw+NltpoJ1RAxxzc0ns7
         fN7Haa9QrqK9nhLpkpQhcaJ9WXYMGWJ9RMuT3Kwg6oViI1O3JJ465NMXo67heZTvWV66
         HHqFeb22MWOpiesOEOHfbQ5f8g9+ONjRxSHaoaIUrlUbetYI22R/SQlqfTAFz84Jx6YL
         92Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678116783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UJ4Ik+ZoB8puIUL4lEznFsK6NoJYzy77sft3aaSqBZo=;
        b=epfXW/7hdDZb4EWAIuvvJD5X/oCalw/Qfy9qR5W8813yb4QrvJEkNIMUeiB0KS7bP3
         F4qx5bYuYJYyQsHvcBAKAusjDL3AdU3CorDpJXcOx8LOG7L2fjJyJNUxY2G0GVTCUMVV
         PU+BrGp8msncCbxhVvok+oAExZ94MVQ0lyZ+iy2MjI7IpSxeZ7y1L6Dgnm/EHzNHOGDX
         NmvHiAOL7kssVH+MPZJNbeehArjiVzHO/SJIAKgVAX44YCrd0a9KSNfwV6olT1zRnyk+
         8CVutYk8v/Bq01T3JOYBv7u8t34mqkCCui7nJXiSk5u4FMvOw7OZUsIaXcQEJqQSUl9q
         9gtg==
X-Gm-Message-State: AO0yUKXHcvpUK7n+ZKuuKgBvvUp+naIFtLPCXsue18HrMqk5KCBHOnKc
        TWs/Qkh74U3kx5imj3Mq/UX4
X-Google-Smtp-Source: AK7set871MSWRLqqkyk9FYiJLBPTaygut8yRIHWpaPH8i7gzVxJsAqzV7/Ph7Yw86EW7lF47DB5VGQ==
X-Received: by 2002:a17:902:ec8a:b0:19d:138b:7c4a with SMTP id x10-20020a170902ec8a00b0019d138b7c4amr13600090plg.3.1678116783618;
        Mon, 06 Mar 2023 07:33:03 -0800 (PST)
Received: from localhost.localdomain ([59.97.52.140])
        by smtp.gmail.com with ESMTPSA id kl4-20020a170903074400b0019a7c890c61sm6837430plb.252.2023.03.06.07.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 07:33:03 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, lpieralisi@kernel.org, kw@linux.com,
        krzysztof.kozlowski+dt@linaro.org, robh@kernel.org
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 06/19] PCI: qcom: Use bulk reset APIs for handling resets for IP rev 2.1.0
Date:   Mon,  6 Mar 2023 21:02:09 +0530
Message-Id: <20230306153222.157667-7-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230306153222.157667-1-manivannan.sadhasivam@linaro.org>
References: <20230306153222.157667-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

All the resets are asserted and deasserted at the same time. So the bulk
reset APIs can be used to handle them together. This simplifies the code
a lot.

While at it, let's also move the qcom_pcie_resources_2_1_0 struct below
qcom_pcie_resources_1_0_0 to keep it sorted.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 129 +++++++------------------
 1 file changed, 34 insertions(+), 95 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 4179ac973147..2d9116464842 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -143,22 +143,8 @@
 
 #define PERST_DELAY_US				1000
 
-#define QCOM_PCIE_2_1_0_MAX_SUPPLY		3
-#define QCOM_PCIE_2_1_0_MAX_CLOCKS		5
-
 #define QCOM_PCIE_CRC8_POLYNOMIAL		(BIT(2) | BIT(1) | BIT(0))
 
-struct qcom_pcie_resources_2_1_0 {
-	struct clk_bulk_data clks[QCOM_PCIE_2_1_0_MAX_CLOCKS];
-	struct reset_control *pci_reset;
-	struct reset_control *axi_reset;
-	struct reset_control *ahb_reset;
-	struct reset_control *por_reset;
-	struct reset_control *phy_reset;
-	struct reset_control *ext_reset;
-	struct regulator_bulk_data supplies[QCOM_PCIE_2_1_0_MAX_SUPPLY];
-};
-
 struct qcom_pcie_resources_1_0_0 {
 	struct clk *iface;
 	struct clk *aux;
@@ -168,6 +154,16 @@ struct qcom_pcie_resources_1_0_0 {
 	struct regulator *vdda;
 };
 
+#define QCOM_PCIE_2_1_0_MAX_CLOCKS		5
+#define QCOM_PCIE_2_1_0_MAX_RESETS		6
+#define QCOM_PCIE_2_1_0_MAX_SUPPLY		3
+struct qcom_pcie_resources_2_1_0 {
+	struct clk_bulk_data clks[QCOM_PCIE_2_1_0_MAX_CLOCKS];
+	struct reset_control_bulk_data resets[QCOM_PCIE_2_1_0_MAX_RESETS];
+	int num_resets;
+	struct regulator_bulk_data supplies[QCOM_PCIE_2_1_0_MAX_SUPPLY];
+};
+
 #define QCOM_PCIE_2_3_2_MAX_SUPPLY	2
 struct qcom_pcie_resources_2_3_2 {
 	struct clk *aux_clk;
@@ -295,6 +291,7 @@ static int qcom_pcie_get_resources_2_1_0(struct qcom_pcie *pcie)
 	struct qcom_pcie_resources_2_1_0 *res = &pcie->res.v2_1_0;
 	struct dw_pcie *pci = pcie->pci;
 	struct device *dev = pci->dev;
+	bool is_apq = of_device_is_compatible(dev->of_node, "qcom,pcie-apq8064");
 	int ret;
 
 	res->supplies[0].supply = "vdda";
@@ -321,28 +318,20 @@ static int qcom_pcie_get_resources_2_1_0(struct qcom_pcie *pcie)
 	if (ret < 0)
 		return ret;
 
-	res->pci_reset = devm_reset_control_get_exclusive(dev, "pci");
-	if (IS_ERR(res->pci_reset))
-		return PTR_ERR(res->pci_reset);
-
-	res->axi_reset = devm_reset_control_get_exclusive(dev, "axi");
-	if (IS_ERR(res->axi_reset))
-		return PTR_ERR(res->axi_reset);
-
-	res->ahb_reset = devm_reset_control_get_exclusive(dev, "ahb");
-	if (IS_ERR(res->ahb_reset))
-		return PTR_ERR(res->ahb_reset);
+	res->resets[0].id = "pci";
+	res->resets[1].id = "axi";
+	res->resets[2].id = "ahb";
+	res->resets[3].id = "por";
+	res->resets[4].id = "phy";
+	res->resets[5].id = "ext";
 
-	res->por_reset = devm_reset_control_get_exclusive(dev, "por");
-	if (IS_ERR(res->por_reset))
-		return PTR_ERR(res->por_reset);
-
-	res->ext_reset = devm_reset_control_get_optional_exclusive(dev, "ext");
-	if (IS_ERR(res->ext_reset))
-		return PTR_ERR(res->ext_reset);
+	/* ext is optional on APQ8016 */
+	res->num_resets = is_apq ? 5 : 6;
+	ret = devm_reset_control_bulk_get_exclusive(dev, res->num_resets, res->resets);
+	if (ret < 0)
+		return ret;
 
-	res->phy_reset = devm_reset_control_get_exclusive(dev, "phy");
-	return PTR_ERR_OR_ZERO(res->phy_reset);
+	return 0;
 }
 
 static void qcom_pcie_deinit_2_1_0(struct qcom_pcie *pcie)
@@ -350,12 +339,7 @@ static void qcom_pcie_deinit_2_1_0(struct qcom_pcie *pcie)
 	struct qcom_pcie_resources_2_1_0 *res = &pcie->res.v2_1_0;
 
 	clk_bulk_disable_unprepare(ARRAY_SIZE(res->clks), res->clks);
-	reset_control_assert(res->pci_reset);
-	reset_control_assert(res->axi_reset);
-	reset_control_assert(res->ahb_reset);
-	reset_control_assert(res->por_reset);
-	reset_control_assert(res->ext_reset);
-	reset_control_assert(res->phy_reset);
+	reset_control_bulk_assert(res->num_resets, res->resets);
 
 	writel(1, pcie->parf + PARF_PHY_CTRL);
 
@@ -370,12 +354,11 @@ static int qcom_pcie_init_2_1_0(struct qcom_pcie *pcie)
 	int ret;
 
 	/* reset the PCIe interface as uboot can leave it undefined state */
-	reset_control_assert(res->pci_reset);
-	reset_control_assert(res->axi_reset);
-	reset_control_assert(res->ahb_reset);
-	reset_control_assert(res->por_reset);
-	reset_control_assert(res->ext_reset);
-	reset_control_assert(res->phy_reset);
+	ret = reset_control_bulk_assert(res->num_resets, res->resets);
+	if (ret < 0) {
+		dev_err(dev, "cannot assert resets\n");
+		return ret;
+	}
 
 	ret = regulator_bulk_enable(ARRAY_SIZE(res->supplies), res->supplies);
 	if (ret < 0) {
@@ -383,58 +366,14 @@ static int qcom_pcie_init_2_1_0(struct qcom_pcie *pcie)
 		return ret;
 	}
 
-	ret = reset_control_deassert(res->ahb_reset);
-	if (ret) {
-		dev_err(dev, "cannot deassert ahb reset\n");
-		goto err_deassert_ahb;
-	}
-
-	ret = reset_control_deassert(res->ext_reset);
-	if (ret) {
-		dev_err(dev, "cannot deassert ext reset\n");
-		goto err_deassert_ext;
-	}
-
-	ret = reset_control_deassert(res->phy_reset);
-	if (ret) {
-		dev_err(dev, "cannot deassert phy reset\n");
-		goto err_deassert_phy;
-	}
-
-	ret = reset_control_deassert(res->pci_reset);
-	if (ret) {
-		dev_err(dev, "cannot deassert pci reset\n");
-		goto err_deassert_pci;
-	}
-
-	ret = reset_control_deassert(res->por_reset);
-	if (ret) {
-		dev_err(dev, "cannot deassert por reset\n");
-		goto err_deassert_por;
-	}
-
-	ret = reset_control_deassert(res->axi_reset);
-	if (ret) {
-		dev_err(dev, "cannot deassert axi reset\n");
-		goto err_deassert_axi;
+	ret = reset_control_bulk_deassert(res->num_resets, res->resets);
+	if (ret < 0) {
+		dev_err(dev, "cannot deassert resets\n");
+		regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
+		return ret;
 	}
 
 	return 0;
-
-err_deassert_axi:
-	reset_control_assert(res->por_reset);
-err_deassert_por:
-	reset_control_assert(res->pci_reset);
-err_deassert_pci:
-	reset_control_assert(res->phy_reset);
-err_deassert_phy:
-	reset_control_assert(res->ext_reset);
-err_deassert_ext:
-	reset_control_assert(res->ahb_reset);
-err_deassert_ahb:
-	regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
-
-	return ret;
 }
 
 static int qcom_pcie_post_init_2_1_0(struct qcom_pcie *pcie)
-- 
2.25.1

