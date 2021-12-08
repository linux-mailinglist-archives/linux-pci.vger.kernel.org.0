Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8DB46D966
	for <lists+linux-pci@lfdr.de>; Wed,  8 Dec 2021 18:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237681AbhLHRSf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Dec 2021 12:18:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234654AbhLHRSf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Dec 2021 12:18:35 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF252C0617A1
        for <linux-pci@vger.kernel.org>; Wed,  8 Dec 2021 09:15:02 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id c32so6954221lfv.4
        for <linux-pci@vger.kernel.org>; Wed, 08 Dec 2021 09:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6Y2ZRqeUmO4YUgR9WAjDKyt8+cTdgMvUnERg/yjIeS0=;
        b=GuOsyfhM7U8NLOaFPbHfTXydlacGVNIdo07Wcp/KXWEYEYEMUmVMPIHUIWmOgm7t2B
         sab7GvFpCsGpnL4wA7MiW3fzZ9jkqyeom90ws7C5jh9QrCfTPEfpXrZ5MUlx62ietrXQ
         em6yKkQHe98RtyuxPOHOl9FOGbq/UJ4LDNrwa7Im22p/jxScmUmPKpEP7CagzLgdWtlL
         AOfN8W7iriFNAvIdCeT2eLNfcz0yHnt3hXsMWQqPtKyiUL0XrY5D9cJNLVqz1evr5AYh
         ls4Vcwg+JIQw5vl6GWxfTe/YO7VQbaIG88na09Eyar8q5O8Whha7ZkaYh1867lECjdSE
         PbCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6Y2ZRqeUmO4YUgR9WAjDKyt8+cTdgMvUnERg/yjIeS0=;
        b=m40aXabQQDBzXiP/sY3vgQwFphkO8HRrX4nMxj656zQ/NrPNLsCsEMG62h8PMN5oU8
         37+cpvUI5eyDoc3Z5GMpSfso2QgLAqcHrSQhJbZ+xZEXecxEgS9C2dQZxBMXGRYKDCMg
         yLp8m2U5gFORZL5sjHlpYHER0ibWfaQ0tQ6f7fj+ZRxPzMoAa+duDvKSpKo9uf+fj3Om
         SHboTKywOucSry/g0VF7ILyozVidWVg0VKiMwiTMmCAPNXoNFZ5upoeX38uNAHkFjap0
         W1+hXXGISQX2IkFC3PWZcq9v9QbPqOsr6oaYbB6mz5xvzSxgKIkLcUd/d7CxJrUFkRT3
         Jxzg==
X-Gm-Message-State: AOAM530Fx0baMoP2hhjPaaHegtj5gAz7KKeT/6mH3LkrHH+fq9Fy23ih
        5vMSJhoD6Eg9OtTtj2uV8y9bgg==
X-Google-Smtp-Source: ABdhPJx3H6nIbQd3ebp/Xslw3u28UjBJZ0zTZlwzG9437QXxZijY/iAplLEbcHACPOnr0cLngF/DqQ==
X-Received: by 2002:ac2:455c:: with SMTP id j28mr720603lfm.582.1638983701136;
        Wed, 08 Dec 2021 09:15:01 -0800 (PST)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id t9sm307213lfe.88.2021.12.08.09.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 09:15:00 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-phy@lists.infradead.org
Subject: [PATCH v2 04/10] PCI: qcom: Remove redundancy between qcom_pcie and qcom_pcie_cfg
Date:   Wed,  8 Dec 2021 20:14:36 +0300
Message-Id: <20211208171442.1327689-5-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211208171442.1327689-1-dmitry.baryshkov@linaro.org>
References: <20211208171442.1327689-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In preparation to adding more flags to configuration data, use struct
qcom_pcie_cfg directly inside struct qcom_pcie, rather than duplicating
all its fields. This would save us from the boilerplate code that just
copies flags values from one sruct to another one.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 39 +++++++++++---------------
 1 file changed, 17 insertions(+), 22 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 1c3d1116bb60..51a0475173fb 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -204,8 +204,7 @@ struct qcom_pcie {
 	union qcom_pcie_resources res;
 	struct phy *phy;
 	struct gpio_desc *reset;
-	const struct qcom_pcie_ops *ops;
-	unsigned int pipe_clk_need_muxing:1;
+	const struct qcom_pcie_cfg *cfg;
 };
 
 #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
@@ -229,8 +228,8 @@ static int qcom_pcie_start_link(struct dw_pcie *pci)
 	struct qcom_pcie *pcie = to_qcom_pcie(pci);
 
 	/* Enable Link Training state machine */
-	if (pcie->ops->ltssm_enable)
-		pcie->ops->ltssm_enable(pcie);
+	if (pcie->cfg->ops->ltssm_enable)
+		pcie->cfg->ops->ltssm_enable(pcie);
 
 	return 0;
 }
@@ -1176,7 +1175,7 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
 	if (ret < 0)
 		return ret;
 
-	if (pcie->pipe_clk_need_muxing) {
+	if (pcie->cfg->pipe_clk_need_muxing) {
 		res->pipe_clk_src = devm_clk_get(dev, "pipe_mux");
 		if (IS_ERR(res->pipe_clk_src))
 			return PTR_ERR(res->pipe_clk_src);
@@ -1209,7 +1208,7 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
 	}
 
 	/* Set TCXO as clock source for pcie_pipe_clk_src */
-	if (pcie->pipe_clk_need_muxing)
+	if (pcie->cfg->pipe_clk_need_muxing)
 		clk_set_parent(res->pipe_clk_src, res->ref_clk_src);
 
 	ret = clk_bulk_prepare_enable(res->num_clks, res->clks);
@@ -1284,7 +1283,7 @@ static int qcom_pcie_post_init_2_7_0(struct qcom_pcie *pcie)
 	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
 
 	/* Set pipe clock as clock source for pcie_pipe_clk_src */
-	if (pcie->pipe_clk_need_muxing)
+	if (pcie->cfg->pipe_clk_need_muxing)
 		clk_set_parent(res->pipe_clk_src, res->phy_pipe_clk);
 
 	return clk_prepare_enable(res->pipe_clk);
@@ -1384,7 +1383,7 @@ static int qcom_pcie_host_init(struct pcie_port *pp)
 
 	qcom_ep_reset_assert(pcie);
 
-	ret = pcie->ops->init(pcie);
+	ret = pcie->cfg->ops->init(pcie);
 	if (ret)
 		return ret;
 
@@ -1392,16 +1391,16 @@ static int qcom_pcie_host_init(struct pcie_port *pp)
 	if (ret)
 		goto err_deinit;
 
-	if (pcie->ops->post_init) {
-		ret = pcie->ops->post_init(pcie);
+	if (pcie->cfg->ops->post_init) {
+		ret = pcie->cfg->ops->post_init(pcie);
 		if (ret)
 			goto err_disable_phy;
 	}
 
 	qcom_ep_reset_deassert(pcie);
 
-	if (pcie->ops->config_sid) {
-		ret = pcie->ops->config_sid(pcie);
+	if (pcie->cfg->ops->config_sid) {
+		ret = pcie->cfg->ops->config_sid(pcie);
 		if (ret)
 			goto err;
 	}
@@ -1410,12 +1409,12 @@ static int qcom_pcie_host_init(struct pcie_port *pp)
 
 err:
 	qcom_ep_reset_assert(pcie);
-	if (pcie->ops->post_deinit)
-		pcie->ops->post_deinit(pcie);
+	if (pcie->cfg->ops->post_deinit)
+		pcie->cfg->ops->post_deinit(pcie);
 err_disable_phy:
 	phy_power_off(pcie->phy);
 err_deinit:
-	pcie->ops->deinit(pcie);
+	pcie->cfg->ops->deinit(pcie);
 
 	return ret;
 }
@@ -1531,7 +1530,6 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	struct pcie_port *pp;
 	struct dw_pcie *pci;
 	struct qcom_pcie *pcie;
-	const struct qcom_pcie_cfg *pcie_cfg;
 	int ret;
 
 	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
@@ -1553,15 +1551,12 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 
 	pcie->pci = pci;
 
-	pcie_cfg = of_device_get_match_data(dev);
-	if (!pcie_cfg || !pcie_cfg->ops) {
+	pcie->cfg = of_device_get_match_data(dev);
+	if (!pcie->cfg || !pcie->cfg->ops) {
 		dev_err(dev, "Invalid platform data\n");
 		return -EINVAL;
 	}
 
-	pcie->ops = pcie_cfg->ops;
-	pcie->pipe_clk_need_muxing = pcie_cfg->pipe_clk_need_muxing;
-
 	pcie->reset = devm_gpiod_get_optional(dev, "perst", GPIOD_OUT_HIGH);
 	if (IS_ERR(pcie->reset)) {
 		ret = PTR_ERR(pcie->reset);
@@ -1586,7 +1581,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 		goto err_pm_runtime_put;
 	}
 
-	ret = pcie->ops->get_resources(pcie);
+	ret = pcie->cfg->ops->get_resources(pcie);
 	if (ret)
 		goto err_pm_runtime_put;
 
-- 
2.33.0

