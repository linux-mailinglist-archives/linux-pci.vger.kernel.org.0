Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 929F16B1EB3
	for <lists+linux-pci@lfdr.de>; Thu,  9 Mar 2023 09:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjCIIvq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Mar 2023 03:51:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbjCIIvi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Mar 2023 03:51:38 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7428CDD36F
        for <linux-pci@vger.kernel.org>; Thu,  9 Mar 2023 00:51:32 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id bn17so590551pgb.10
        for <linux-pci@vger.kernel.org>; Thu, 09 Mar 2023 00:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678351892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=98/PwVeFNeIxQrm0IqUyAA3dXph0wAaYOEANDm444S8=;
        b=cw9zoD6WIsBHIF18bRw3okh38hbi5gfOn6P/ZfluyDC2AZnjpZGPkSDeJ8sd4wmF1U
         3MjoYLEnZml0jvkpuuiXmnhyfaC/wf5sw9ttgeHbR4V6xJnnY2Op/o/Cgsma29Zm4VV5
         YWbFXSv3VZK0ULUcwWOHwjAzK8VPk0i9Y8tAejTrbazFnOHdy004nkb+my0Gb+sL1wWM
         mRceacimv04rdr3hi24jmWTJFhfGkMckABRNiKyX3jVo+fcCSttyWNAb0QLwOSyBuFgg
         +arK4pLxXUktwLOqm51GraLsBnG2YAmNfwkPhhBpFsOwP/YOzxlYMh8O5Uch5xKZPqXt
         scRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678351892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=98/PwVeFNeIxQrm0IqUyAA3dXph0wAaYOEANDm444S8=;
        b=IXOExbb/BR5N3BiolLQZpOjoebjnwPZ+WG0vr2d9CEOmcm+aMXrYzmQ4DMsDeSLXph
         10LAXOH2dOLGWZ0rpKGf5j3xUVbXAti5Xnl3YMAxOyBEsU//nt/VvEJI5mhC6zzJG+BH
         /YmwgtKJXWlrB+VVjsziWvg8rG/DsBz8DLCyG+UMhRIpJa4Su6Q1RWcfnGzaDQFi+Yok
         FozrHNomvBIdDs4pnHezy3Bhszzdei2NDeLwfNxoAhwgQ/NsPRY1xUXoXbgKYF4P/RW1
         CXWHjZtDJQIw2vTvPEryo5l7XaDvz9fhKNgwp8TnSRkskOl2UhSKnzfR7CmLz0XLTtBC
         RF1A==
X-Gm-Message-State: AO0yUKXYS4wi+n/jCInS2msoV6CsdjtiQvTb8FEMTZJ6uI6qKN4oxEOw
        n+NHV1btwdd9lkBrMIHmg9Cw
X-Google-Smtp-Source: AK7set8KkBjdcVujinvYMJ5SJN1GMFWQr58S2qzZeUrr7sjqoYUXNZIHPXyRkP27DqlDhnSYqgLdkw==
X-Received: by 2002:a62:38c3:0:b0:5d9:e505:3466 with SMTP id f186-20020a6238c3000000b005d9e5053466mr17114034pfa.23.1678351892049;
        Thu, 09 Mar 2023 00:51:32 -0800 (PST)
Received: from localhost.localdomain ([220.158.158.11])
        by smtp.gmail.com with ESMTPSA id u4-20020aa78484000000b005809d382016sm10638604pfn.74.2023.03.09.00.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 00:51:31 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, lpieralisi@kernel.org, kw@linux.com,
        krzysztof.kozlowski+dt@linaro.org, robh@kernel.org
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 04/17] PCI: qcom: Add missing macros for register fields
Date:   Thu,  9 Mar 2023 14:20:49 +0530
Message-Id: <20230309085102.120977-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230309085102.120977-1-manivannan.sadhasivam@linaro.org>
References: <20230309085102.120977-1-manivannan.sadhasivam@linaro.org>
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

