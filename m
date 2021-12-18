Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59FC2479B25
	for <lists+linux-pci@lfdr.de>; Sat, 18 Dec 2021 15:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233310AbhLROCg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 18 Dec 2021 09:02:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233289AbhLROCg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 18 Dec 2021 09:02:36 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69FAC06173E
        for <linux-pci@vger.kernel.org>; Sat, 18 Dec 2021 06:02:35 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id cf39so10720244lfb.8
        for <linux-pci@vger.kernel.org>; Sat, 18 Dec 2021 06:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PwQidrKxtxc7LxI1A1WNnO2rsoQKkHIFyh0voA121fU=;
        b=YW9rARps5P5eMdTCHBKedlZF+BZPjD0ng/N6inzA9BPe9fol690EpqPnzEhm0KcQGH
         NyYVc60+BAva8C9Zdw7NfNzKFSTCEqD21kp8EUFEe0Fncl2fmC5XPvTd+kYS5khlcvmE
         AV9pukyctYRcSIe2dL6FHRRaWg96XVhfoFff6Tjd9pQnYUem/jUkJ9zC5W9UAL3LpWth
         H14r66hlp2Ozgo5IqTydr4FN5KUfxIdawh9vtw+QcA4sVPQOLjYhuj/mCTGwUgqXIwSS
         /NYxx7FYU6DEhjfBXI1w+tjC4W1l7jbA5+TkHM9U2wJ43fMYYjFFgUp++gFKvEor4X6V
         zASg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PwQidrKxtxc7LxI1A1WNnO2rsoQKkHIFyh0voA121fU=;
        b=XoPOqsokhbqpXKu5Kyh7hvK38f3GPreSRmkMwO0jPYlSScgI4wsghD5zP0We0Ruo9H
         Ta1ohZG7HkWOYDOysX78/ua9wlUz9oDnyuQroZZyWHKavp/NyEA3TZDMv2tGlden94L0
         zPoGTRFf570Lgnb6sBKQlkyduyQDBk6dig2wjqc+V+Kg8XiMFHGoPGg04u649rDz2aA8
         Ol4b8/X4gD6vFYkdfkUWMYLNSsYXMjgGu/Qx9RJGuuaELxOfa4NK4RSzCyIlMWaxLYJV
         xSxdRTlXXJU7yBTvB7Jf6GVTh/VjK5BSPUbhlQlT3g6tDVHfpXxYD5QUEE6zKJNH374n
         tEFQ==
X-Gm-Message-State: AOAM533ZNFdPsRhfdSEVxYBGSr4wFuw/PuTebAHbpaOmW+6H3ffaZ9or
        qLh3y/rVJlkfaVJgDPQB6fjw3g==
X-Google-Smtp-Source: ABdhPJxzSXnjTXlCR34OZtC7RGvlgWGHyy8slj1J3YsYccSqF4LxuMddFWYl8lXABJ0Gk+iPlrlnMA==
X-Received: by 2002:ac2:51b4:: with SMTP id f20mr7347803lfk.391.1639836153845;
        Sat, 18 Dec 2021 06:02:33 -0800 (PST)
Received: from eriador.lan ([2001:470:dd84:abc0::8a5])
        by smtp.gmail.com with ESMTPSA id s15sm2023979ljj.14.2021.12.18.06.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Dec 2021 06:02:33 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        Prasad Malisetty <pmaliset@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>
Subject: [PATCH 3/3] PCI: qcom: Remove unnecessary pipe_clk handling
Date:   Sat, 18 Dec 2021 17:02:23 +0300
Message-Id: <20211218140223.500390-4-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211218140223.500390-1-dmitry.baryshkov@linaro.org>
References: <20211218140223.500390-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

QMP PHY driver already does clk_prepare_enable()/_disable() pipe_clk.
Remove extra calls to enable/disable this clock from the PCIe driver, so
that the PHY driver can manage the clock on its own.

Fixes: aa9c0df98c29 ("PCI: qcom: Switch pcie_1_pipe_clk_src after PHY init in SC7280")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 71 +-------------------------
 1 file changed, 2 insertions(+), 69 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index fbaae6f4eb18..4e668da96ef4 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -128,7 +128,6 @@ struct qcom_pcie_resources_2_3_2 {
 	struct clk *master_clk;
 	struct clk *slave_clk;
 	struct clk *cfg_clk;
-	struct clk *pipe_clk;
 	struct regulator_bulk_data supplies[QCOM_PCIE_2_3_2_MAX_SUPPLY];
 };
 
@@ -165,7 +164,6 @@ struct qcom_pcie_resources_2_7_0 {
 	int num_clks;
 	struct regulator_bulk_data supplies[2];
 	struct reset_control *pci_reset;
-	struct clk *pipe_clk;
 	struct clk *pipe_clk_src;
 	struct clk *phy_pipe_clk;
 	struct clk *ref_clk_src;
@@ -185,9 +183,7 @@ struct qcom_pcie;
 struct qcom_pcie_ops {
 	int (*get_resources)(struct qcom_pcie *pcie);
 	int (*init)(struct qcom_pcie *pcie);
-	int (*post_init)(struct qcom_pcie *pcie);
 	void (*deinit)(struct qcom_pcie *pcie);
-	void (*post_deinit)(struct qcom_pcie *pcie);
 	void (*ltssm_enable)(struct qcom_pcie *pcie);
 	int (*config_sid)(struct qcom_pcie *pcie);
 };
@@ -591,11 +587,7 @@ static int qcom_pcie_get_resources_2_3_2(struct qcom_pcie *pcie)
 		return PTR_ERR(res->master_clk);
 
 	res->slave_clk = devm_clk_get(dev, "bus_slave");
-	if (IS_ERR(res->slave_clk))
-		return PTR_ERR(res->slave_clk);
-
-	res->pipe_clk = devm_clk_get(dev, "pipe");
-	return PTR_ERR_OR_ZERO(res->pipe_clk);
+	return PTR_ERR_OR_ZERO(res->slave_clk);
 }
 
 static void qcom_pcie_deinit_2_3_2(struct qcom_pcie *pcie)
@@ -610,13 +602,6 @@ static void qcom_pcie_deinit_2_3_2(struct qcom_pcie *pcie)
 	regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
 }
 
-static void qcom_pcie_post_deinit_2_3_2(struct qcom_pcie *pcie)
-{
-	struct qcom_pcie_resources_2_3_2 *res = &pcie->res.v2_3_2;
-
-	clk_disable_unprepare(res->pipe_clk);
-}
-
 static int qcom_pcie_init_2_3_2(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_resources_2_3_2 *res = &pcie->res.v2_3_2;
@@ -691,22 +676,6 @@ static int qcom_pcie_init_2_3_2(struct qcom_pcie *pcie)
 	return ret;
 }
 
-static int qcom_pcie_post_init_2_3_2(struct qcom_pcie *pcie)
-{
-	struct qcom_pcie_resources_2_3_2 *res = &pcie->res.v2_3_2;
-	struct dw_pcie *pci = pcie->pci;
-	struct device *dev = pci->dev;
-	int ret;
-
-	ret = clk_prepare_enable(res->pipe_clk);
-	if (ret) {
-		dev_err(dev, "cannot prepare/enable pipe clock\n");
-		return ret;
-	}
-
-	return 0;
-}
-
 static int qcom_pcie_get_resources_2_4_0(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_resources_2_4_0 *res = &pcie->res.v2_4_0;
@@ -1193,8 +1162,7 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
 		clk_set_parent(res->pipe_clk_src, res->ref_clk_src);
 	}
 
-	res->pipe_clk = devm_clk_get(dev, "pipe");
-	return PTR_ERR_OR_ZERO(res->pipe_clk);
+	return 0;
 }
 
 static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
@@ -1233,12 +1201,6 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
 		goto err_disable_clocks;
 	}
 
-	ret = clk_prepare_enable(res->pipe_clk);
-	if (ret) {
-		dev_err(dev, "cannot prepare/enable pipe clock\n");
-		goto err_disable_clocks;
-	}
-
 	/* configure PCIe to RC mode */
 	writel(DEVICE_TYPE_RC, pcie->parf + PCIE20_PARF_DEVICE_TYPE);
 
@@ -1287,20 +1249,6 @@ static void qcom_pcie_deinit_2_7_0(struct qcom_pcie *pcie)
 	regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
 }
 
-static int qcom_pcie_post_init_2_7_0(struct qcom_pcie *pcie)
-{
-	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
-
-	return clk_prepare_enable(res->pipe_clk);
-}
-
-static void qcom_pcie_post_deinit_2_7_0(struct qcom_pcie *pcie)
-{
-	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
-
-	clk_disable_unprepare(res->pipe_clk);
-}
-
 static int qcom_pcie_link_up(struct dw_pcie *pci)
 {
 	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
@@ -1396,12 +1344,6 @@ static int qcom_pcie_host_init(struct pcie_port *pp)
 	if (ret)
 		goto err_deinit;
 
-	if (pcie->ops->post_init) {
-		ret = pcie->ops->post_init(pcie);
-		if (ret)
-			goto err_disable_phy;
-	}
-
 	qcom_ep_reset_deassert(pcie);
 
 	if (pcie->ops->config_sid) {
@@ -1414,9 +1356,6 @@ static int qcom_pcie_host_init(struct pcie_port *pp)
 
 err:
 	qcom_ep_reset_assert(pcie);
-	if (pcie->ops->post_deinit)
-		pcie->ops->post_deinit(pcie);
-err_disable_phy:
 	phy_power_off(pcie->phy);
 err_deinit:
 	pcie->ops->deinit(pcie);
@@ -1448,9 +1387,7 @@ static const struct qcom_pcie_ops ops_1_0_0 = {
 static const struct qcom_pcie_ops ops_2_3_2 = {
 	.get_resources = qcom_pcie_get_resources_2_3_2,
 	.init = qcom_pcie_init_2_3_2,
-	.post_init = qcom_pcie_post_init_2_3_2,
 	.deinit = qcom_pcie_deinit_2_3_2,
-	.post_deinit = qcom_pcie_post_deinit_2_3_2,
 	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
 };
 
@@ -1476,8 +1413,6 @@ static const struct qcom_pcie_ops ops_2_7_0 = {
 	.init = qcom_pcie_init_2_7_0,
 	.deinit = qcom_pcie_deinit_2_7_0,
 	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
-	.post_init = qcom_pcie_post_init_2_7_0,
-	.post_deinit = qcom_pcie_post_deinit_2_7_0,
 };
 
 /* Qcom IP rev.: 1.9.0 */
@@ -1486,8 +1421,6 @@ static const struct qcom_pcie_ops ops_1_9_0 = {
 	.init = qcom_pcie_init_2_7_0,
 	.deinit = qcom_pcie_deinit_2_7_0,
 	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
-	.post_init = qcom_pcie_post_init_2_7_0,
-	.post_deinit = qcom_pcie_post_deinit_2_7_0,
 	.config_sid = qcom_pcie_config_sid_sm8250,
 };
 
-- 
2.34.1

