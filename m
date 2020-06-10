Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B99E31F58AB
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jun 2020 18:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730583AbgFJQID (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Jun 2020 12:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730485AbgFJQHY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Jun 2020 12:07:24 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A90C03E96F;
        Wed, 10 Jun 2020 09:07:23 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id l12so3175635ejn.10;
        Wed, 10 Jun 2020 09:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zEaDqgFgLdCp9SI9RIDjLkOE1A27X8Da9cpu+tesTho=;
        b=Zll90zRHNW3+Bt5d2afTGpZOGjlPghMTJOIjLc5WXM51701EoDYdLAxEy48XjdJ7No
         iCktVOJKOSr8P3/LFMRQXW8wUR8FQEbvF++XnnU11AU5+0BZsFSiuxBRhFbaftb6/jW9
         hWLgk/t6RrTycxkMQuRbE1KrLUYK4rqKG46gZzFLb+syz5IqCXZ7dlUKVdo7fLH9GZRM
         kxmOmc4OVVD4XTgpt9cpoLmgv9qCHU/mmtJBRUNY+Yyhnf/jje6Z+zKcg3DD5E+iP4l7
         bCKWzAq+2cTyLbwPHJx8QpCqDXHF8WAsN8D1qaGNK7BShmd3yyt2Fm/IeYYvfZ+l0Nby
         ydPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zEaDqgFgLdCp9SI9RIDjLkOE1A27X8Da9cpu+tesTho=;
        b=Ja08+pNjZ+l1VBh3OAkUCcOogXhKcW4BPO0h8C9AjGO7gaA9mx8V5C/P6tTTXte84L
         fXt9ilM5USWI4acVdHUKo98xAb/8eMmgF9vdUgvxKzWB8dwyNRSZgvC9Elpl+Pk4m1Bg
         7X/VLt/Uk4hl7FTqeB/BiE0AXNq9r56kmWTN7IccP0c+TnTk4CzF95/rP1bUGfMQgCZG
         B03h9aSvh954pHpUvgp+NhtGAN0YrN65fZ1lKliObd412xdw6w2/Y4kqzjCnTpzAVQns
         lGJ8uUZSimhGeHobBSpD7co8fYelkemZZeEO29fpe8RHNO6osLKN8ePZElqZUSGaC4f5
         /c7g==
X-Gm-Message-State: AOAM532YaI2yduEcDO+4we+K0MiRPvSJjNrE8na81ZpU9ppsaLpDV1jf
        tFooCjsDgs7xkFhVEY1WS00=
X-Google-Smtp-Source: ABdhPJzRHaUCCRTimWA52dbg0bDTNzKdEM/XlLrh7hR0uPAsWlXzdLOs94j1yO6OQsYEUPqHHIuD4Q==
X-Received: by 2002:a17:906:799:: with SMTP id l25mr3993618ejc.234.1591805242054;
        Wed, 10 Jun 2020 09:07:22 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host-79-35-249-242.retail.telecomitalia.it. [79.35.249.242])
        by smtp.googlemail.com with ESMTPSA id ce25sm56067edb.45.2020.06.10.09.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 09:07:21 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>, Rob Herring <robh@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 06/12] PCI: qcom: Use bulk clk api and assert on error
Date:   Wed, 10 Jun 2020 18:06:48 +0200
Message-Id: <20200610160655.27799-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200610160655.27799-1-ansuelsmth@gmail.com>
References: <20200610160655.27799-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Rework 2.1.0 revision to use bulk clk api and fix missing assert on
reset_control_deassert error.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 131 +++++++++----------------
 1 file changed, 46 insertions(+), 85 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 4dab5ef630cc..f2ea1ab6f584 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -84,12 +84,9 @@
 #define DEVICE_TYPE_RC				0x4
 
 #define QCOM_PCIE_2_1_0_MAX_SUPPLY	3
+#define QCOM_PCIE_2_1_0_MAX_CLOCKS	5
 struct qcom_pcie_resources_2_1_0 {
-	struct clk *iface_clk;
-	struct clk *core_clk;
-	struct clk *phy_clk;
-	struct clk *aux_clk;
-	struct clk *ref_clk;
+	struct clk_bulk_data clks[QCOM_PCIE_2_1_0_MAX_CLOCKS];
 	struct reset_control *pci_reset;
 	struct reset_control *axi_reset;
 	struct reset_control *ahb_reset;
@@ -237,25 +234,21 @@ static int qcom_pcie_get_resources_2_1_0(struct qcom_pcie *pcie)
 	if (ret)
 		return ret;
 
-	res->iface_clk = devm_clk_get(dev, "iface");
-	if (IS_ERR(res->iface_clk))
-		return PTR_ERR(res->iface_clk);
-
-	res->core_clk = devm_clk_get(dev, "core");
-	if (IS_ERR(res->core_clk))
-		return PTR_ERR(res->core_clk);
-
-	res->phy_clk = devm_clk_get(dev, "phy");
-	if (IS_ERR(res->phy_clk))
-		return PTR_ERR(res->phy_clk);
+	res->clks[0].id = "iface";
+	res->clks[1].id = "core";
+	res->clks[2].id = "phy";
+	res->clks[3].id = "aux";
+	res->clks[4].id = "ref";
 
-	res->aux_clk = devm_clk_get_optional(dev, "aux");
-	if (IS_ERR(res->aux_clk))
-		return PTR_ERR(res->aux_clk);
+	/* iface, core, phy are required */
+	ret = devm_clk_bulk_get(dev, 3, res->clks);
+	if (ret < 0)
+		return ret;
 
-	res->ref_clk = devm_clk_get_optional(dev, "ref");
-	if (IS_ERR(res->ref_clk))
-		return PTR_ERR(res->ref_clk);
+	/* aux, ref are optional */
+	ret = devm_clk_bulk_get_optional(dev, 2, res->clks + 3);
+	if (ret < 0)
+		return ret;
 
 	res->pci_reset = devm_reset_control_get_exclusive(dev, "pci");
 	if (IS_ERR(res->pci_reset))
@@ -285,17 +278,13 @@ static void qcom_pcie_deinit_2_1_0(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_resources_2_1_0 *res = &pcie->res.v2_1_0;
 
-	clk_disable_unprepare(res->phy_clk);
+	clk_bulk_disable_unprepare(ARRAY_SIZE(res->clks), res->clks);
 	reset_control_assert(res->pci_reset);
 	reset_control_assert(res->axi_reset);
 	reset_control_assert(res->ahb_reset);
 	reset_control_assert(res->por_reset);
 	reset_control_assert(res->ext_reset);
 	reset_control_assert(res->phy_reset);
-	clk_disable_unprepare(res->iface_clk);
-	clk_disable_unprepare(res->core_clk);
-	clk_disable_unprepare(res->aux_clk);
-	clk_disable_unprepare(res->ref_clk);
 	regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
 }
 
@@ -313,36 +302,6 @@ static int qcom_pcie_init_2_1_0(struct qcom_pcie *pcie)
 		return ret;
 	}
 
-	ret = reset_control_assert(res->ahb_reset);
-	if (ret) {
-		dev_err(dev, "cannot assert ahb reset\n");
-		goto err_assert_ahb;
-	}
-
-	ret = clk_prepare_enable(res->iface_clk);
-	if (ret) {
-		dev_err(dev, "cannot prepare/enable iface clock\n");
-		goto err_assert_ahb;
-	}
-
-	ret = clk_prepare_enable(res->core_clk);
-	if (ret) {
-		dev_err(dev, "cannot prepare/enable core clock\n");
-		goto err_clk_core;
-	}
-
-	ret = clk_prepare_enable(res->aux_clk);
-	if (ret) {
-		dev_err(dev, "cannot prepare/enable aux clock\n");
-		goto err_clk_aux;
-	}
-
-	ret = clk_prepare_enable(res->ref_clk);
-	if (ret) {
-		dev_err(dev, "cannot prepare/enable ref clock\n");
-		goto err_clk_ref;
-	}
-
 	ret = reset_control_deassert(res->ahb_reset);
 	if (ret) {
 		dev_err(dev, "cannot deassert ahb reset\n");
@@ -352,48 +311,46 @@ static int qcom_pcie_init_2_1_0(struct qcom_pcie *pcie)
 	ret = reset_control_deassert(res->ext_reset);
 	if (ret) {
 		dev_err(dev, "cannot deassert ext reset\n");
-		goto err_deassert_ahb;
+		goto err_deassert_ext;
 	}
 
-	/* enable PCIe clocks and resets */
-	val = readl(pcie->parf + PCIE20_PARF_PHY_CTRL);
-	val &= ~BIT(0);
-	writel(val, pcie->parf + PCIE20_PARF_PHY_CTRL);
-
-	/* enable external reference clock */
-	val = readl(pcie->parf + PCIE20_PARF_PHY_REFCLK);
-	val |= BIT(16);
-	writel(val, pcie->parf + PCIE20_PARF_PHY_REFCLK);
-
 	ret = reset_control_deassert(res->phy_reset);
 	if (ret) {
 		dev_err(dev, "cannot deassert phy reset\n");
-		return ret;
+		goto err_deassert_phy;
 	}
 
 	ret = reset_control_deassert(res->pci_reset);
 	if (ret) {
 		dev_err(dev, "cannot deassert pci reset\n");
-		return ret;
+		goto err_deassert_pci;
 	}
 
 	ret = reset_control_deassert(res->por_reset);
 	if (ret) {
 		dev_err(dev, "cannot deassert por reset\n");
-		return ret;
+		goto err_deassert_por;
 	}
 
 	ret = reset_control_deassert(res->axi_reset);
 	if (ret) {
 		dev_err(dev, "cannot deassert axi reset\n");
-		return ret;
+		goto err_deassert_axi;
 	}
 
-	ret = clk_prepare_enable(res->phy_clk);
-	if (ret) {
-		dev_err(dev, "cannot prepare/enable phy clock\n");
-		goto err_deassert_ahb;
-	}
+	ret = clk_bulk_prepare_enable(ARRAY_SIZE(res->clks), res->clks);
+	if (ret)
+		goto err_clks;
+
+	/* enable PCIe clocks and resets */
+	val = readl(pcie->parf + PCIE20_PARF_PHY_CTRL);
+	val &= ~BIT(0);
+	writel(val, pcie->parf + PCIE20_PARF_PHY_CTRL);
+
+	/* enable external reference clock */
+	val = readl(pcie->parf + PCIE20_PARF_PHY_REFCLK);
+	val |= BIT(16);
+	writel(val, pcie->parf + PCIE20_PARF_PHY_REFCLK);
 
 	/* wait for clock acquisition */
 	usleep_range(1000, 1500);
@@ -407,15 +364,19 @@ static int qcom_pcie_init_2_1_0(struct qcom_pcie *pcie)
 
 	return 0;
 
+err_clks:
+	reset_control_assert(res->axi_reset);
+err_deassert_axi:
+	reset_control_assert(res->por_reset);
+err_deassert_por:
+	reset_control_assert(res->pci_reset);
+err_deassert_pci:
+	reset_control_assert(res->phy_reset);
+err_deassert_phy:
+	reset_control_assert(res->ext_reset);
+err_deassert_ext:
+	reset_control_assert(res->ahb_reset);
 err_deassert_ahb:
-	clk_disable_unprepare(res->ref_clk);
-err_clk_ref:
-	clk_disable_unprepare(res->aux_clk);
-err_clk_aux:
-	clk_disable_unprepare(res->core_clk);
-err_clk_core:
-	clk_disable_unprepare(res->iface_clk);
-err_assert_ahb:
 	regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
 
 	return ret;
-- 
2.25.1

