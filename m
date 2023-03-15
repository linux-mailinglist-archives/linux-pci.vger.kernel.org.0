Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 954366BA808
	for <lists+linux-pci@lfdr.de>; Wed, 15 Mar 2023 07:43:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbjCOGnx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Mar 2023 02:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbjCOGna (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Mar 2023 02:43:30 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BEC334F7A
        for <linux-pci@vger.kernel.org>; Tue, 14 Mar 2023 23:43:23 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id rj10so7194708pjb.4
        for <linux-pci@vger.kernel.org>; Tue, 14 Mar 2023 23:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678862603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=98/PwVeFNeIxQrm0IqUyAA3dXph0wAaYOEANDm444S8=;
        b=e/WMjlwxJBDzqGlBlU3YLHoYIn9O7FTOIsbQjk6UILprZxMjyOSx/xwljt/M3VKkkI
         VqnHdZPiG9P6+DTpl2ZtTUGZB51VGxpAGdFWYuYW2B12lXfj4wbEIT02PhSE3TESTGag
         SstyLcX6qb1Oyx22wwIwcYoNzeA08ArE++QX1ACLDiENUYs7Bo6EPHr12D6VPtPjmSNp
         pWgYn+Hq7syfMzzWzXUyIzBCTIGDLhVDW6KUPDvLIyzZaDsnLY/nvQSu2Ac33WTVrTMY
         9z1MPRrKcX9+656WrxvJ6XIl0KdTSYmnbzevzu1Il/JYKHdA2Vlr+eK/Cqj//PmQuHfI
         /olA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678862603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=98/PwVeFNeIxQrm0IqUyAA3dXph0wAaYOEANDm444S8=;
        b=Qb218h6Y3Tt0CmdciKUb9jaCtY+5uvylqiEu77Knlq2mkPRjFGHfDhIS0zRaHHjgYW
         CXCvecQVn8GA+TZMoYE2r3QTLgVtf3O9kKCfkfcNIMyV5ZbOFBte/J6wJC1ggcSv5eWY
         R4zM8373IWeWZ+EbPID6A53jVRhCcX9axOEpcHUeUVwaDlups48AqvFIPSb4q8+ADJlx
         02yJVWCdmgYoj0sU7SKP5PTGgKAGE/++rcIMnpMmJm4lGj/BT71gIK00J6NqF+xG3yak
         PRJoA+qCWlqdjhosWknC1PrPj/v2qeKJKhMTMrKA7StGI0ff0RhlvpOJaAk7Ol83sOwj
         PyHg==
X-Gm-Message-State: AO0yUKWBe4P9/neV4dwq6Vsl4tdFYF9i84zlbO7kQXv2HiEhKYc/99ia
        Zi+lBhQv94n3BBVEPsxyOxSD
X-Google-Smtp-Source: AK7set8x0ncg8gdctnktNIhgOXVEKw7ypyQcrNYxkT14sOtl4DzVRXSPiYZx4FaC0syvwFg61vm4UQ==
X-Received: by 2002:a17:903:2113:b0:1a0:4859:19ea with SMTP id o19-20020a170903211300b001a0485919eamr1277900ple.39.1678862602878;
        Tue, 14 Mar 2023 23:43:22 -0700 (PDT)
Received: from localhost.localdomain ([117.217.182.35])
        by smtp.gmail.com with ESMTPSA id u4-20020a17090a6a8400b002367325203fsm550747pjj.50.2023.03.14.23.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 23:43:22 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, lpieralisi@kernel.org, kw@linux.com,
        krzysztof.kozlowski+dt@linaro.org, robh@kernel.org
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 04/18] PCI: qcom: Add missing macros for register fields
Date:   Wed, 15 Mar 2023 12:12:41 +0530
Message-Id: <20230315064255.15591-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230315064255.15591-1-manivannan.sadhasivam@linaro.org>
References: <20230315064255.15591-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some of the registers are changed using hardcoded bitfields without macros.
This provides no information on what the register setting is about. So add
the macros to those fields for making the code more understandable.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 42 +++++++++++++++-----------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index e9f4c70b719a..926a531fda3a 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -63,6 +63,7 @@
 #define MISC_CONTROL_1_REG			0x8BC
 
 /* PARF_SYS_CTRL register fields */
+#define MAC_PHY_POWERDOWN_IN_P2_D_MUX_EN	BIT(29)
 #define MST_WAKEUP_EN				BIT(13)
 #define SLV_WAKEUP_EN				BIT(12)
 #define MSTR_ACLK_CGC_DIS			BIT(10)
@@ -87,6 +88,7 @@
 /* PARF_PHY_CTRL register fields */
 #define PHY_CTRL_PHY_TX0_TERM_OFFSET_MASK	GENMASK(20, 16)
 #define PHY_CTRL_PHY_TX0_TERM_OFFSET(x)		FIELD_PREP(PHY_CTRL_PHY_TX0_TERM_OFFSET_MASK, x)
+#define PHY_TEST_PWR_DOWN			BIT(0)
 
 /* PARF_PHY_REFCLK register fields */
 #define PHY_REFCLK_SSP_EN			BIT(16)
@@ -103,6 +105,12 @@
 #define MSTR_AXI_CLK_EN				BIT(1)
 #define BYPASS					BIT(4)
 
+/* PARF_AXI_MSTR_WR_ADDR_HALT register fields */
+#define EN					BIT(31)
+
+/* PARF_LTSSM register fields */
+#define LTSSM_EN				BIT(8)
+
 /* PARF_DEVICE_TYPE register fields */
 #define DEVICE_TYPE_RC				0x4
 
@@ -440,7 +448,7 @@ static int qcom_pcie_post_init_2_1_0(struct qcom_pcie *pcie)
 
 	/* enable PCIe clocks and resets */
 	val = readl(pcie->parf + PARF_PHY_CTRL);
-	val &= ~BIT(0);
+	val &= ~PHY_TEST_PWR_DOWN;
 	writel(val, pcie->parf + PARF_PHY_CTRL);
 
 	ret = clk_bulk_prepare_enable(ARRAY_SIZE(res->clks), res->clks);
@@ -595,7 +603,7 @@ static int qcom_pcie_post_init_1_0_0(struct qcom_pcie *pcie)
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
 		u32 val = readl(pcie->parf + PARF_AXI_MSTR_WR_ADDR_HALT);
 
-		val |= BIT(31);
+		val |= EN;
 		writel(val, pcie->parf + PARF_AXI_MSTR_WR_ADDR_HALT);
 	}
 
@@ -608,7 +616,7 @@ static void qcom_pcie_2_3_2_ltssm_enable(struct qcom_pcie *pcie)
 
 	/* enable link training */
 	val = readl(pcie->parf + PARF_LTSSM);
-	val |= BIT(8);
+	val |= LTSSM_EN;
 	writel(val, pcie->parf + PARF_LTSSM);
 }
 
@@ -715,7 +723,7 @@ static int qcom_pcie_post_init_2_3_2(struct qcom_pcie *pcie)
 
 	/* enable PCIe clocks and resets */
 	val = readl(pcie->parf + PARF_PHY_CTRL);
-	val &= ~BIT(0);
+	val &= ~PHY_TEST_PWR_DOWN;
 	writel(val, pcie->parf + PARF_PHY_CTRL);
 
 	/* change DBI base address */
@@ -723,15 +731,15 @@ static int qcom_pcie_post_init_2_3_2(struct qcom_pcie *pcie)
 
 	/* MAC PHY_POWERDOWN MUX DISABLE  */
 	val = readl(pcie->parf + PARF_SYS_CTRL);
-	val &= ~BIT(29);
+	val &= ~MAC_PHY_POWERDOWN_IN_P2_D_MUX_EN;
 	writel(val, pcie->parf + PARF_SYS_CTRL);
 
 	val = readl(pcie->parf + PARF_MHI_CLOCK_RESET_CTRL);
-	val |= BIT(4);
+	val |= BYPASS;
 	writel(val, pcie->parf + PARF_MHI_CLOCK_RESET_CTRL);
 
 	val = readl(pcie->parf + PARF_AXI_MSTR_WR_ADDR_HALT_V2);
-	val |= BIT(31);
+	val |= EN;
 	writel(val, pcie->parf + PARF_AXI_MSTR_WR_ADDR_HALT_V2);
 
 	return 0;
@@ -994,7 +1002,7 @@ static int qcom_pcie_post_init_2_4_0(struct qcom_pcie *pcie)
 
 	/* enable PCIe clocks and resets */
 	val = readl(pcie->parf + PARF_PHY_CTRL);
-	val &= ~BIT(0);
+	val &= ~PHY_TEST_PWR_DOWN;
 	writel(val, pcie->parf + PARF_PHY_CTRL);
 
 	/* change DBI base address */
@@ -1002,15 +1010,15 @@ static int qcom_pcie_post_init_2_4_0(struct qcom_pcie *pcie)
 
 	/* MAC PHY_POWERDOWN MUX DISABLE  */
 	val = readl(pcie->parf + PARF_SYS_CTRL);
-	val &= ~BIT(29);
+	val &= ~MAC_PHY_POWERDOWN_IN_P2_D_MUX_EN;
 	writel(val, pcie->parf + PARF_SYS_CTRL);
 
 	val = readl(pcie->parf + PARF_MHI_CLOCK_RESET_CTRL);
-	val |= BIT(4);
+	val |= BYPASS;
 	writel(val, pcie->parf + PARF_MHI_CLOCK_RESET_CTRL);
 
 	val = readl(pcie->parf + PARF_AXI_MSTR_WR_ADDR_HALT_V2);
-	val |= BIT(31);
+	val |= EN;
 	writel(val, pcie->parf + PARF_AXI_MSTR_WR_ADDR_HALT_V2);
 
 	return 0;
@@ -1159,7 +1167,7 @@ static int qcom_pcie_post_init_2_3_3(struct qcom_pcie *pcie)
 		pcie->parf + PARF_SLV_ADDR_SPACE_SIZE_2_3_3);
 
 	val = readl(pcie->parf + PARF_PHY_CTRL);
-	val &= ~BIT(0);
+	val &= ~PHY_TEST_PWR_DOWN;
 	writel(val, pcie->parf + PARF_PHY_CTRL);
 
 	writel(0, pcie->parf + PARF_DBI_BASE_ADDR);
@@ -1275,7 +1283,7 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
 
 	/* enable PCIe clocks and resets */
 	val = readl(pcie->parf + PARF_PHY_CTRL);
-	val &= ~BIT(0);
+	val &= ~PHY_TEST_PWR_DOWN;
 	writel(val, pcie->parf + PARF_PHY_CTRL);
 
 	/* change DBI base address */
@@ -1283,11 +1291,11 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
 
 	/* MAC PHY_POWERDOWN MUX DISABLE  */
 	val = readl(pcie->parf + PARF_SYS_CTRL);
-	val &= ~BIT(29);
+	val &= ~MAC_PHY_POWERDOWN_IN_P2_D_MUX_EN;
 	writel(val, pcie->parf + PARF_SYS_CTRL);
 
 	val = readl(pcie->parf + PARF_MHI_CLOCK_RESET_CTRL);
-	val |= BIT(4);
+	val |= BYPASS;
 	writel(val, pcie->parf + PARF_MHI_CLOCK_RESET_CTRL);
 
 	/* Enable L1 and L1SS */
@@ -1297,7 +1305,7 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
 
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
 		val = readl(pcie->parf + PARF_AXI_MSTR_WR_ADDR_HALT);
-		val |= BIT(31);
+		val |= EN;
 		writel(val, pcie->parf + PARF_AXI_MSTR_WR_ADDR_HALT);
 	}
 
@@ -1390,7 +1398,7 @@ static int qcom_pcie_post_init_2_9_0(struct qcom_pcie *pcie)
 		pcie->parf + PARF_SLV_ADDR_SPACE_SIZE);
 
 	val = readl(pcie->parf + PARF_PHY_CTRL);
-	val &= ~BIT(0);
+	val &= ~PHY_TEST_PWR_DOWN;
 	writel(val, pcie->parf + PARF_PHY_CTRL);
 
 	writel(0, pcie->parf + PARF_DBI_BASE_ADDR);
-- 
2.25.1

