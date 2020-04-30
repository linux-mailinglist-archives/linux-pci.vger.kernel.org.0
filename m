Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D04E1C09F7
	for <lists+linux-pci@lfdr.de>; Fri,  1 May 2020 00:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbgD3WGw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Apr 2020 18:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727955AbgD3WGv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Apr 2020 18:06:51 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08295C035494;
        Thu, 30 Apr 2020 15:06:51 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id s9so6028433eju.1;
        Thu, 30 Apr 2020 15:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T7fxTmFHD/7QIFtrzRSLVLRXMToDkzdfYoVrqZS2ee8=;
        b=YAgKdCsBI9EVHZ0rPbeQL9a8iOzCbMAEtAivW4tqMSnAzsxp06oNOsp/RZsYBzqXgm
         /0RFmx7pDFLpyjzOyshiLRRIqnQeCjKc//S6f5FdXNvUTkSJGAzF9Sj7ftU52+Ksw5dl
         etWKjYQcVrA7aa4jnRkFxKkU9EBu0EpyT7bC6jR0LzRLx/DLKnu/ww715dHEm1LpWQml
         SRrQJ6iXRc3bbCAk+LTQ54VQtrRDKOUCRTSRb6Vy0H0/kmWk2qJDMrsPH46452uK2f62
         OGTRL0bRul2Y0USsJ5xnELbnfGhEpbtqb6XBmsqEG7v9lasiAy2Rl64t6WkXKCyXy0Jk
         W1kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T7fxTmFHD/7QIFtrzRSLVLRXMToDkzdfYoVrqZS2ee8=;
        b=tiJWtzr5SKXZD+j0JdWkSXMC1kRyd/3RN4MJBIlNvijgnuzxC/eC2WGTOwiTeSDyjg
         4vRQS9F5JYK2xQBJx3TukEar9gqu3URYKTNqv3v+Hly4LYyL6kPRkIRJ09FihjbLO1Ps
         0wm+SHo9MZGHjtnlQkMeUf3wJKtNMLvAvnAa1YCqDjtP2ITzQoukjDfQa5NqbbVDuO2c
         Lxglp4krQhZAAXrKpHkJoJYabF/9oUFyXy5oy4cIG74USIagONXno8ANHpeLFM+tENER
         QxQJEsF8KF2jBcAuOk7QdLPWWzmochgxRR3XnD7OWrNdcWyAtw3gfGzqUCbMM0brcOYo
         +Lqw==
X-Gm-Message-State: AGi0PuYom5D9RBKgpGEP/YgooyUDerSFarpwgScntulTqH9MDJPaRQFR
        eLSnt1zdqXs01vxZyjQTlmw=
X-Google-Smtp-Source: APiQypIqSPFMQHiJV9RlWmmf6BGqJL0Xri2zN7mWx4whRpYlSTSCkS103E6lLBPhKiwa88tvlSgTUg==
X-Received: by 2002:a17:906:72c8:: with SMTP id m8mr589017ejl.318.1588284409578;
        Thu, 30 Apr 2020 15:06:49 -0700 (PDT)
Received: from Ansuel-XPS.localdomain ([79.37.253.240])
        by smtp.googlemail.com with ESMTPSA id t17sm54185edq.88.2020.04.30.15.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 15:06:48 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 06/11] PCI: qcom: introduce qcom_clear_and_set_dword
Date:   Fri,  1 May 2020 00:06:13 +0200
Message-Id: <20200430220619.3169-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200430220619.3169-1-ansuelsmth@gmail.com>
References: <20200430220619.3169-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use qcom_clear_and_set_dword instead of use the same code many times in
the entire driver.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 108 ++++++++++---------------
 1 file changed, 41 insertions(+), 67 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 921030a64bab..a4fd5baada34 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -184,6 +184,16 @@ struct qcom_pcie {
 
 #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
 
+static void qcom_clear_and_set_dword(void __iomem *addr, u32 clear_mask,
+				     u32 set_mask)
+{
+	u32 val = readl(addr);
+
+	val &= ~clear_mask;
+	val |= set_mask;
+	writel(val, addr);
+}
+
 static void qcom_ep_reset_assert(struct qcom_pcie *pcie)
 {
 	gpiod_set_value_cansleep(pcie->reset, 1);
@@ -214,12 +224,9 @@ static int qcom_pcie_establish_link(struct qcom_pcie *pcie)
 
 static void qcom_pcie_2_1_0_ltssm_enable(struct qcom_pcie *pcie)
 {
-	u32 val;
-
 	/* enable link training */
-	val = readl(pcie->elbi + PCIE20_ELBI_SYS_CTRL);
-	val |= PCIE20_ELBI_SYS_CTRL_LT_ENABLE;
-	writel(val, pcie->elbi + PCIE20_ELBI_SYS_CTRL);
+	qcom_clear_and_set_dword(pcie->elbi + PCIE20_ELBI_SYS_CTRL, 0,
+				 PCIE20_ELBI_SYS_CTRL_LT_ENABLE);
 }
 
 static int qcom_pcie_get_resources_2_1_0(struct qcom_pcie *pcie)
@@ -304,7 +311,6 @@ static int qcom_pcie_init_2_1_0(struct qcom_pcie *pcie)
 	struct qcom_pcie_resources_2_1_0 *res = &pcie->res.v2_1_0;
 	struct dw_pcie *pci = pcie->pci;
 	struct device *dev = pci->dev;
-	u32 val;
 	int ret;
 
 	ret = regulator_bulk_enable(ARRAY_SIZE(res->supplies), res->supplies);
@@ -360,14 +366,11 @@ static int qcom_pcie_init_2_1_0(struct qcom_pcie *pcie)
 	}
 
 	/* enable PCIe clocks and resets */
-	val = readl(pcie->parf + PCIE20_PARF_PHY_CTRL);
-	val &= ~BIT(0);
-	writel(val, pcie->parf + PCIE20_PARF_PHY_CTRL);
+	qcom_clear_and_set_dword(pcie->parf + PCIE20_PARF_PHY_CTRL, BIT(0), 0);
 
 	/* enable external reference clock */
-	val = readl(pcie->parf + PCIE20_PARF_PHY_REFCLK);
-	val |= BIT(16);
-	writel(val, pcie->parf + PCIE20_PARF_PHY_REFCLK);
+	qcom_clear_and_set_dword(pcie->parf + PCIE20_PARF_PHY_REFCLK, 0,
+				 BIT(16));
 
 	ret = reset_control_deassert(res->phy_reset);
 	if (ret) {
@@ -514,10 +517,9 @@ static int qcom_pcie_init_1_0_0(struct qcom_pcie *pcie)
 	writel(0, pcie->parf + PCIE20_PARF_DBI_BASE_ADDR);
 
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
-		u32 val = readl(pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT);
-
-		val |= BIT(31);
-		writel(val, pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT);
+		qcom_clear_and_set_dword(
+			pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT, 0,
+			BIT(31));
 	}
 
 	return 0;
@@ -537,12 +539,8 @@ static int qcom_pcie_init_1_0_0(struct qcom_pcie *pcie)
 
 static void qcom_pcie_2_3_2_ltssm_enable(struct qcom_pcie *pcie)
 {
-	u32 val;
-
 	/* enable link training */
-	val = readl(pcie->parf + PCIE20_PARF_LTSSM);
-	val |= BIT(8);
-	writel(val, pcie->parf + PCIE20_PARF_LTSSM);
+	qcom_clear_and_set_dword(pcie->parf + PCIE20_PARF_LTSSM, 0, BIT(8));
 }
 
 static int qcom_pcie_get_resources_2_3_2(struct qcom_pcie *pcie)
@@ -603,7 +601,6 @@ static int qcom_pcie_init_2_3_2(struct qcom_pcie *pcie)
 	struct qcom_pcie_resources_2_3_2 *res = &pcie->res.v2_3_2;
 	struct dw_pcie *pci = pcie->pci;
 	struct device *dev = pci->dev;
-	u32 val;
 	int ret;
 
 	ret = regulator_bulk_enable(ARRAY_SIZE(res->supplies), res->supplies);
@@ -637,25 +634,19 @@ static int qcom_pcie_init_2_3_2(struct qcom_pcie *pcie)
 	}
 
 	/* enable PCIe clocks and resets */
-	val = readl(pcie->parf + PCIE20_PARF_PHY_CTRL);
-	val &= ~BIT(0);
-	writel(val, pcie->parf + PCIE20_PARF_PHY_CTRL);
+	qcom_clear_and_set_dword(pcie->parf + PCIE20_PARF_PHY_CTRL, BIT(0), 0);
 
 	/* change DBI base address */
 	writel(0, pcie->parf + PCIE20_PARF_DBI_BASE_ADDR);
 
 	/* MAC PHY_POWERDOWN MUX DISABLE  */
-	val = readl(pcie->parf + PCIE20_PARF_SYS_CTRL);
-	val &= ~BIT(29);
-	writel(val, pcie->parf + PCIE20_PARF_SYS_CTRL);
+	qcom_clear_and_set_dword(pcie->parf + PCIE20_PARF_SYS_CTRL, BIT(29), 0);
 
-	val = readl(pcie->parf + PCIE20_PARF_MHI_CLOCK_RESET_CTRL);
-	val |= BIT(4);
-	writel(val, pcie->parf + PCIE20_PARF_MHI_CLOCK_RESET_CTRL);
+	qcom_clear_and_set_dword(pcie->parf + PCIE20_PARF_MHI_CLOCK_RESET_CTRL,
+				 0, BIT(4));
 
-	val = readl(pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT_V2);
-	val |= BIT(31);
-	writel(val, pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT_V2);
+	qcom_clear_and_set_dword(
+		pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT_V2, 0, BIT(31));
 
 	return 0;
 
@@ -792,7 +783,6 @@ static int qcom_pcie_init_2_4_0(struct qcom_pcie *pcie)
 	struct qcom_pcie_resources_2_4_0 *res = &pcie->res.v2_4_0;
 	struct dw_pcie *pci = pcie->pci;
 	struct device *dev = pci->dev;
-	u32 val;
 	int ret;
 
 	ret = reset_control_assert(res->axi_m_reset);
@@ -918,25 +908,19 @@ static int qcom_pcie_init_2_4_0(struct qcom_pcie *pcie)
 		goto err_clks;
 
 	/* enable PCIe clocks and resets */
-	val = readl(pcie->parf + PCIE20_PARF_PHY_CTRL);
-	val &= ~BIT(0);
-	writel(val, pcie->parf + PCIE20_PARF_PHY_CTRL);
+	qcom_clear_and_set_dword(pcie->parf + PCIE20_PARF_PHY_CTRL, BIT(0), 0);
 
 	/* change DBI base address */
 	writel(0, pcie->parf + PCIE20_PARF_DBI_BASE_ADDR);
 
 	/* MAC PHY_POWERDOWN MUX DISABLE  */
-	val = readl(pcie->parf + PCIE20_PARF_SYS_CTRL);
-	val &= ~BIT(29);
-	writel(val, pcie->parf + PCIE20_PARF_SYS_CTRL);
+	qcom_clear_and_set_dword(pcie->parf + PCIE20_PARF_SYS_CTRL, BIT(29), 0);
 
-	val = readl(pcie->parf + PCIE20_PARF_MHI_CLOCK_RESET_CTRL);
-	val |= BIT(4);
-	writel(val, pcie->parf + PCIE20_PARF_MHI_CLOCK_RESET_CTRL);
+	qcom_clear_and_set_dword(pcie->parf + PCIE20_PARF_MHI_CLOCK_RESET_CTRL,
+				 0, BIT(4));
 
-	val = readl(pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT_V2);
-	val |= BIT(31);
-	writel(val, pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT_V2);
+	qcom_clear_and_set_dword(
+		pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT_V2, 0, BIT(31));
 
 	return 0;
 
@@ -1017,7 +1001,6 @@ static int qcom_pcie_init_2_3_3(struct qcom_pcie *pcie)
 	struct dw_pcie *pci = pcie->pci;
 	struct device *dev = pci->dev;
 	int i, ret;
-	u32 val;
 
 	for (i = 0; i < ARRAY_SIZE(res->rst); i++) {
 		ret = reset_control_assert(res->rst[i]);
@@ -1077,9 +1060,7 @@ static int qcom_pcie_init_2_3_3(struct qcom_pcie *pcie)
 	writel(SLV_ADDR_SPACE_SZ,
 		pcie->parf + PCIE20_v3_PARF_SLV_ADDR_SPACE_SIZE);
 
-	val = readl(pcie->parf + PCIE20_PARF_PHY_CTRL);
-	val &= ~BIT(0);
-	writel(val, pcie->parf + PCIE20_PARF_PHY_CTRL);
+	qcom_clear_and_set_dword(pcie->parf + PCIE20_PARF_PHY_CTRL, BIT(0), 0);
 
 	writel(0, pcie->parf + PCIE20_PARF_DBI_BASE_ADDR);
 
@@ -1093,9 +1074,8 @@ static int qcom_pcie_init_2_3_3(struct qcom_pcie *pcie)
 	writel(DBI_RO_WR_EN, pci->dbi_base + PCIE20_MISC_CONTROL_1_REG);
 	writel(PCIE_CAP_LINK1_VAL, pci->dbi_base + PCIE20_CAP_LINK_1);
 
-	val = readl(pci->dbi_base + PCIE20_CAP_LINK_CAPABILITIES);
-	val &= ~PCIE20_CAP_ACTIVE_STATE_LINK_PM_SUPPORT;
-	writel(val, pci->dbi_base + PCIE20_CAP_LINK_CAPABILITIES);
+	qcom_clear_and_set_dword(pcie->dbi_base + PCIE20_CAP_LINK_CAPABILITIES,
+				 PCIE20_CAP_ACTIVE_STATE_LINK_PM_SUPPORT, 0);
 
 	writel(PCIE_CAP_CPL_TIMEOUT_DISABLE, pci->dbi_base +
 		PCIE20_DEVICE_CONTROL2_STATUS2);
@@ -1159,7 +1139,6 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
 	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
 	struct dw_pcie *pci = pcie->pci;
 	struct device *dev = pci->dev;
-	u32 val;
 	int ret;
 
 	ret = regulator_bulk_enable(ARRAY_SIZE(res->supplies), res->supplies);
@@ -1196,26 +1175,21 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
 	writel(DEVICE_TYPE_RC, pcie->parf + PCIE20_PARF_DEVICE_TYPE);
 
 	/* enable PCIe clocks and resets */
-	val = readl(pcie->parf + PCIE20_PARF_PHY_CTRL);
-	val &= ~BIT(0);
-	writel(val, pcie->parf + PCIE20_PARF_PHY_CTRL);
+	qcom_clear_and_set_dword(pcie->parf + PCIE20_PARF_PHY_CTRL, BIT(0), 0);
 
 	/* change DBI base address */
 	writel(0, pcie->parf + PCIE20_PARF_DBI_BASE_ADDR);
 
 	/* MAC PHY_POWERDOWN MUX DISABLE  */
-	val = readl(pcie->parf + PCIE20_PARF_SYS_CTRL);
-	val &= ~BIT(29);
-	writel(val, pcie->parf + PCIE20_PARF_SYS_CTRL);
+	qcom_clear_and_set_dword(pcie->parf + PCIE20_PARF_SYS_CTRL, BIT(29), 0);
 
-	val = readl(pcie->parf + PCIE20_PARF_MHI_CLOCK_RESET_CTRL);
-	val |= BIT(4);
-	writel(val, pcie->parf + PCIE20_PARF_MHI_CLOCK_RESET_CTRL);
+	qcom_clear_and_set_dword(pcie->parf + PCIE20_PARF_MHI_CLOCK_RESET_CTRL,
+				 0, BIT(4));
 
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
-		val = readl(pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT);
-		val |= BIT(31);
-		writel(val, pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT);
+		qcom_clear_and_set_dword(
+			pcie->parf + PCIE20_PARF_MHI_CLOCK_RESET_CTRL, 0,
+			BIT(31));
 	}
 
 	return 0;
-- 
2.25.1

