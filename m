Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E73E96B1EC8
	for <lists+linux-pci@lfdr.de>; Thu,  9 Mar 2023 09:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbjCIIwR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Mar 2023 03:52:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbjCIIwQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Mar 2023 03:52:16 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F84DD342
        for <linux-pci@vger.kernel.org>; Thu,  9 Mar 2023 00:51:48 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id z11so1016748pfh.4
        for <linux-pci@vger.kernel.org>; Thu, 09 Mar 2023 00:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678351900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UJ4Ik+ZoB8puIUL4lEznFsK6NoJYzy77sft3aaSqBZo=;
        b=EHz2tjmuYtQZC+ppekibs8hQWgaxRI51sxEeZgChp+yN4bpsVVdKIisDtsSCaGXMnR
         xJILmaZ4bRMjmFvOwP0QthT+rN/MrjSRhAt+gwVkdJOimOEOavrWXCdjBIcNCURdJPyK
         tAXJIGe/gNRW4ns5lGcwgWqkl2zsphW4qPhuhXLG53RuMAlcKqlqeDj6yhL6gSlePege
         Msz78QBorehzb7XY9+He4+K6xuSyyWQFWiQd60OhUHweKIUMH2zmA8L3H50FXzeU2wME
         Ge272vbogzr2YTgWwLC+WLCxYljVTUZpNiP1TM/O3WIdI+bH6IIE4c2dcgiswb8Oiqvr
         SQ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678351900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UJ4Ik+ZoB8puIUL4lEznFsK6NoJYzy77sft3aaSqBZo=;
        b=jVihVMMOH4Zh93pGKxcAp64N5iStpqvrm+jTNAnGQRDqota4InJ0uhDJ1vmU/tqa64
         /mL+bwSzb+nvGwUZmMKld5Wcpa8GW6lNihaIBIhoJPbiNBivgl4mKoYzY9oDGbJ3yof2
         A1eBdGRbd0bGRbA7VJp44ZzDANN1Q0r2bqLv3KLoBSo70oXiZ+Z8ZXlOAhG2VOKGqfaE
         DrgERfkVWgkxmlKsgdA06KRN5QQsgzeu2oNOYyTRheM3rt7M+CK7quvZC+AmjvnEz7Z8
         R9ud3JxMXb82M2eSCMBn2Sy1NvKtbklUFWnv0XA8NfdRyYWH5ULoIZUHrtLUKNokZQTM
         TBnA==
X-Gm-Message-State: AO0yUKX6T8S+D8zQ7ZjL8ja7kRnx17anBN6udyAZL4g/yrMkW3xGz2g7
        U234GyFg1o47e5cW0M9ct+IZ
X-Google-Smtp-Source: AK7set+cz315+tplBYFaklg8zIAUtuInTs87QAt+Ef0jaC3NqTyQDzBvxHKzDzXXmeagdqEo07/MgQ==
X-Received: by 2002:a62:546:0:b0:5a8:bcf2:125 with SMTP id 67-20020a620546000000b005a8bcf20125mr15409361pff.21.1678351900379;
        Thu, 09 Mar 2023 00:51:40 -0800 (PST)
Received: from localhost.localdomain ([220.158.158.11])
        by smtp.gmail.com with ESMTPSA id u4-20020aa78484000000b005809d382016sm10638604pfn.74.2023.03.09.00.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 00:51:40 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, lpieralisi@kernel.org, kw@linux.com,
        krzysztof.kozlowski+dt@linaro.org, robh@kernel.org
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 06/17] PCI: qcom: Use bulk reset APIs for handling resets for IP rev 2.1.0
Date:   Thu,  9 Mar 2023 14:20:51 +0530
Message-Id: <20230309085102.120977-7-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230309085102.120977-1-manivannan.sadhasivam@linaro.org>
References: <20230309085102.120977-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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

