Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 028706BC871
	for <lists+linux-pci@lfdr.de>; Thu, 16 Mar 2023 09:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbjCPIMS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Mar 2023 04:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbjCPIMC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Mar 2023 04:12:02 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B0FB3717
        for <linux-pci@vger.kernel.org>; Thu, 16 Mar 2023 01:11:56 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id q14so601297pff.10
        for <linux-pci@vger.kernel.org>; Thu, 16 Mar 2023 01:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678954314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4JHGWZSYaFvVifV4OMGWWGNepJIHTu1iMCkiUrPmu5M=;
        b=FOWBx60B1YTP9tyGRuiRHI4HU18wVfXtaJ42vutMmeKx23gZCOrbl2b/ZMWPOgGjLU
         /bdFjRo2mzbj5583LqRUmkvsxpu+KHM5j6K0dFuI9pnNz3Z6LYsIKXHc7QPQEAxl+18C
         2s86AnfaXAFrtwSDdqldRqKYKcv1M1chWl4d3IqrswkQ8thyoKl0+Wf78dVARdtgM+op
         C+kWXtFwYQVVcpoAylhljqp1pfSdsME+Kcroa8F4xICndyyXfdz5W9D1ITDyFHnC2qKK
         0GhejYJQrSfRd0/vLhapIk4fcLKrGXMefWFbVmDJRyST43U4b1iW8yfJUxR2g7hWSlWr
         ulJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678954314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4JHGWZSYaFvVifV4OMGWWGNepJIHTu1iMCkiUrPmu5M=;
        b=oToqFWCZTjh9EL/9tXHyoUM2We0Y3S8ma/oayL59KzbjaocfMMXrIWhwb5ruzrHS9u
         jbTMep5r/hZwy+dcv9C2Bu83YqDPY7+IZD3rtfab03t378FPqmpMPoFOcnaFCPiw/ew3
         R3pLbgZVcWonAyWr0vPQP0l/wUWgHnfs0CUSoAOHSaW/BAKuSUGm7L8paLLCxGJvkkfg
         tFQr1gD7HZKxIntGmdhUy02yCBGvTS51aTKH1U1Z+QOXGHBKD4RVRyqYpP0HzJg70vuu
         9ZnRqoF/dCCr/5F6+gxy7lTZv+MSlaDoGTovRHVq9oKInLLX0dEmVm6GtzqW4a/bQcQZ
         GHUA==
X-Gm-Message-State: AO0yUKVOIp6CSfXKxo6mzxURXt57TIETSth6+Wei7FHF50YfozWq1vOw
        vAGrAnW1H1nRzsAF3o7E+3yA5W1Vy/FLdu2zTg==
X-Google-Smtp-Source: AK7set+LM2FvSThIvk+l9hS4cPQx1xagnPNicRg/hU9YW9GkANYObiPIz7bC437iqQ8OtDTGx89S7g==
X-Received: by 2002:aa7:9433:0:b0:625:14cb:8b7c with SMTP id y19-20020aa79433000000b0062514cb8b7cmr2301708pfo.0.1678954314606;
        Thu, 16 Mar 2023 01:11:54 -0700 (PDT)
Received: from localhost.localdomain ([117.207.30.24])
        by smtp.gmail.com with ESMTPSA id 13-20020aa7910d000000b005d9984a947bsm4804422pfh.139.2023.03.16.01.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 01:11:54 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, lpieralisi@kernel.org, kw@linux.com,
        krzysztof.kozlowski+dt@linaro.org, robh@kernel.org
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v5 05/19] PCI: qcom: Add missing macros for register fields
Date:   Thu, 16 Mar 2023 13:41:03 +0530
Message-Id: <20230316081117.14288-6-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230316081117.14288-1-manivannan.sadhasivam@linaro.org>
References: <20230316081117.14288-1-manivannan.sadhasivam@linaro.org>
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

Some of the registers are changed using hardcoded bitfields without macros.
This provides no information on what the register setting is about. So add
the macros to those fields for making the code more understandable.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 42 +++++++++++++++-----------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 44c31c65695a..f48990ac86dd 100644
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
@@ -1296,7 +1304,7 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
 	writel(val, pcie->parf + PARF_PM_CTRL);
 
 	val = readl(pcie->parf + PARF_AXI_MSTR_WR_ADDR_HALT_V2);
-	val |= BIT(31);
+	val |= EN;
 	writel(val, pcie->parf + PARF_AXI_MSTR_WR_ADDR_HALT_V2);
 
 	return 0;
@@ -1388,7 +1396,7 @@ static int qcom_pcie_post_init_2_9_0(struct qcom_pcie *pcie)
 		pcie->parf + PARF_SLV_ADDR_SPACE_SIZE);
 
 	val = readl(pcie->parf + PARF_PHY_CTRL);
-	val &= ~BIT(0);
+	val &= ~PHY_TEST_PWR_DOWN;
 	writel(val, pcie->parf + PARF_PHY_CTRL);
 
 	writel(0, pcie->parf + PARF_DBI_BASE_ADDR);
-- 
2.25.1

