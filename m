Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4E44A9B53
	for <lists+linux-pci@lfdr.de>; Fri,  4 Feb 2022 15:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359455AbiBDOq7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Feb 2022 09:46:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359441AbiBDOq4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Feb 2022 09:46:56 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B7EC061759
        for <linux-pci@vger.kernel.org>; Fri,  4 Feb 2022 06:46:56 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id u6so13046042lfm.10
        for <linux-pci@vger.kernel.org>; Fri, 04 Feb 2022 06:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HPUGyE4Nk9oPo2Yg3WSJOeaAAEN9ud1SRrakuqfnozg=;
        b=mmaPvAcJDueGpIgs4jA53BCLqQvurzMx/Nyn17E0TVVfou3e3M8hc52onWApdPEghB
         XcUBHryIUEEJ/0UIrMOF7Q7Ihd0pv0Tfo1fLYVncJb9DzNOcLu5+dA2WaRoh5/42hO1R
         ZSqCfpw5nYull3ABCNL89WBAVAuBXVUOpmZ8cG5K5ab4oQbgU8y8ZuP7RaZnP8GGyIBD
         O51c7j4r9JZWdmksJEkkBxYAxQAoiF2Y/Zx1mejMToFNY3qx38gkRDEP8IXytv/vD+LT
         2wDRuJObV6fpfHSqWx006vS6l6Oez+mfqKuke3Qz8sgqpWiS7CaHoMYO0Ob8riodefHu
         BVaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HPUGyE4Nk9oPo2Yg3WSJOeaAAEN9ud1SRrakuqfnozg=;
        b=ft40KpNtp9TkbCePEs+ko7oVASJcXEiqtXgvV+mVrSeIOgvXeQ30eZXOcHiODoOxuW
         UI8TX36xApi6/2SabxnyvqRpfo8ADS2KsKIV9A/0nwVSqPIW0lDhmgmpyQBM7HqPR0/4
         HJLhqsikHLEMZnPuRHCAihQPgMiSj424e5h1rGwNrIHySStYHjektOItf75fyHXgFVng
         AeT73lqtlhZFX8r+pzSNIUgR9H6YeE+nngewBl2lXQ9AT9FNNCZYMn+YADpfEY3cwEL2
         zeS/DT7wJRPcMvC9MhVmEAH+vhCvshNprYASgGEuTjG0ldAoRqXAECxTaeZkb8CIDKUY
         DWhA==
X-Gm-Message-State: AOAM530A8c9Ye/P/w1mWJ07uAHT5BDiTsIi0F+hnq9sO8Qfmnlo57krd
        9+IqPp9U/Y2mVrERWBIJOmTTIQ==
X-Google-Smtp-Source: ABdhPJzGLjwztb/DqyhxaopwJIiTqXpIZdMeMY4lS9a85hecKhebwgns9Mu3IyMUWsIbMHhtvX0dhw==
X-Received: by 2002:a05:6512:22c9:: with SMTP id g9mr2563230lfu.148.1643986014780;
        Fri, 04 Feb 2022 06:46:54 -0800 (PST)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id y23sm348222lfb.2.2022.02.04.06.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 06:46:54 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <swboyd@chromium.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Prasad Malisetty <pmaliset@codeaurora.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 09/11] PCI: qcom: Remove redundancy between qcom_pcie and qcom_pcie_cfg
Date:   Fri,  4 Feb 2022 17:46:43 +0300
Message-Id: <20220204144645.3016603-10-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220204144645.3016603-1-dmitry.baryshkov@linaro.org>
References: <20220204144645.3016603-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In preparation to adding more flags to configuration data, use pointer
to struct qcom_pcie_cfg directly inside struct qcom_pcie, rather than
duplicating all its fields. This would save us from the boilerplate code
that just copies flag values from one struct to another one.

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 37 ++++++++++++--------------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 7df8632a21a8..3a0da577b75d 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -198,7 +198,7 @@ struct qcom_pcie {
 	union qcom_pcie_resources res;
 	struct phy *phy;
 	struct gpio_desc *reset;
-	const struct qcom_pcie_ops *ops;
+	const struct qcom_pcie_cfg *cfg;
 };
 
 #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
@@ -222,8 +222,8 @@ static int qcom_pcie_start_link(struct dw_pcie *pci)
 	struct qcom_pcie *pcie = to_qcom_pcie(pci);
 
 	/* Enable Link Training state machine */
-	if (pcie->ops->ltssm_enable)
-		pcie->ops->ltssm_enable(pcie);
+	if (pcie->cfg->ops->ltssm_enable)
+		pcie->cfg->ops->ltssm_enable(pcie);
 
 	return 0;
 }
@@ -1307,7 +1307,7 @@ static int qcom_pcie_host_init(struct pcie_port *pp)
 
 	qcom_ep_reset_assert(pcie);
 
-	ret = pcie->ops->init(pcie);
+	ret = pcie->cfg->ops->init(pcie);
 	if (ret)
 		return ret;
 
@@ -1315,16 +1315,16 @@ static int qcom_pcie_host_init(struct pcie_port *pp)
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
@@ -1333,12 +1333,12 @@ static int qcom_pcie_host_init(struct pcie_port *pp)
 
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
@@ -1447,15 +1447,8 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	struct pcie_port *pp;
 	struct dw_pcie *pci;
 	struct qcom_pcie *pcie;
-	const struct qcom_pcie_cfg *pcie_cfg;
 	int ret;
 
-	pcie_cfg = of_device_get_match_data(dev);
-	if (!pcie_cfg || !pcie_cfg->ops) {
-		dev_err(dev, "Invalid platform data\n");
-		return -EINVAL;
-	}
-
 	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
 	if (!pcie)
 		return -ENOMEM;
@@ -1475,7 +1468,11 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 
 	pcie->pci = pci;
 
-	pcie->ops = pcie_cfg->ops;
+	pcie->cfg = of_device_get_match_data(dev);
+	if (!pcie->cfg || !pcie->cfg->ops) {
+		dev_err(dev, "Invalid platform data\n");
+		return -EINVAL;
+	}
 
 	pcie->reset = devm_gpiod_get_optional(dev, "perst", GPIOD_OUT_HIGH);
 	if (IS_ERR(pcie->reset)) {
@@ -1501,7 +1498,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 		goto err_pm_runtime_put;
 	}
 
-	ret = pcie->ops->get_resources(pcie);
+	ret = pcie->cfg->ops->get_resources(pcie);
 	if (ret)
 		goto err_pm_runtime_put;
 
-- 
2.34.1

