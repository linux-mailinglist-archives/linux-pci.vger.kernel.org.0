Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 039881FA260
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jun 2020 23:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731729AbgFOVGa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Jun 2020 17:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730995AbgFOVG3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Jun 2020 17:06:29 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8F5C08C5C2;
        Mon, 15 Jun 2020 14:06:29 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id y13so18995494eju.2;
        Mon, 15 Jun 2020 14:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7DFifidWmIfqxPGThJs01uWYMYz3TIPc9ydTq8/XkuQ=;
        b=UFAgJGy1tM/qKFh3ShK0D4wmnZRDepfHos6eqaeYrVd62Ushgr8wWgoAFEi37bU5GP
         eRXjwiR/EHtON/BGWAy8+c/J69ibQJYAAGpFyK6eOfiitEYtH/lqlaCOyRdWSUlSRgxP
         zYQlUc4KPYPhHKQ61ECySddfCvIwJ3BdjIJBQuCmF/Z1vU924dbi5WnrEswd3mCQMY0n
         eq+Kp3j+Jd1KM5ksJYbMEj+5Yztc3kPhAl7fal+qScF/efPsG+YLdzsnJjv4bDCcJEx6
         LgYgj5sMtmywKPfuUMO9AeHTPQmoC31sjvQ7ccbUgmYpnFE6yu861b0uFeMH19zQex+r
         fiFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7DFifidWmIfqxPGThJs01uWYMYz3TIPc9ydTq8/XkuQ=;
        b=YL8HPUCR3laqkakRGCbFkf3/smNSEPvYR7urvud7oqFnsgUkAxAhwlyAIohpsuERas
         QRbj90pwNDbdbNIOmFbXJJdMmb/4lPr14yBG8yOc6/hyBH13AtOkVL4fz1SSrfSb1QiB
         LnucMlGxeAhYSrfsnz0/hqE9uoPwGf294YO2rXSPSbNe5c3RHIL7ZWkLBQ3WteZZ1XfN
         ZrqhcnZ1wBKVZFeTngrYkquoXXahsjlza+7Sgz2EOOg58JGgocNOlaJ+4OwXft3Bd+vU
         54bCbjD9n1t7aPotAFJMyIbBZfO6HZFveNomKvomTU884dUPg8Fx3LI1u/899WoyJ9Ag
         t4yg==
X-Gm-Message-State: AOAM5308N/BSvus48roRW1xBNRV4apdKsYbvpd9/Yyq+O1gpPxzGIK31
        NBmOSJ6YTneM+sBdqb6PemM=
X-Google-Smtp-Source: ABdhPJw3HHMFLh4xhfQ7ZMs2l1XV85zKNqiYIvzLJbgCoC6GuQcgmwO8eVf9crBewi+yUUIbhGNMpw==
X-Received: by 2002:a17:906:4d42:: with SMTP id b2mr26928156ejv.34.1592255187982;
        Mon, 15 Jun 2020 14:06:27 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host-95-238-254-39.retail.telecomitalia.it. [95.238.254.39])
        by smtp.googlemail.com with ESMTPSA id d5sm9662226ejr.78.2020.06.15.14.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 14:06:27 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Ansuel Smith <ansuelsmth@gmail.com>,
        Rob Herring <robh@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 06/12] PCI: qcom: Use bulk clk api and assert on error
Date:   Mon, 15 Jun 2020 23:06:02 +0200
Message-Id: <20200615210608.21469-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.27.0.rc0
In-Reply-To: <20200615210608.21469-1-ansuelsmth@gmail.com>
References: <20200615210608.21469-1-ansuelsmth@gmail.com>
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
2.27.0.rc0

