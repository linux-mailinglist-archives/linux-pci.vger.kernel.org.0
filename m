Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 626884C0FF3
	for <lists+linux-pci@lfdr.de>; Wed, 23 Feb 2022 11:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239500AbiBWKPL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Feb 2022 05:15:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239506AbiBWKPK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Feb 2022 05:15:10 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577298B6D5
        for <linux-pci@vger.kernel.org>; Wed, 23 Feb 2022 02:14:43 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id t14so23819247ljh.8
        for <linux-pci@vger.kernel.org>; Wed, 23 Feb 2022 02:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WA3fhXKz11zSRT18uh5lWgyZMPbayuJGb3v+A3A9reA=;
        b=HodvyXEopC6Rhn8fGedL0X9MMjBw9Lu5v+EsadaDkonNcIgPQ4X0cJg1BONqWOQ9H+
         g1X+UNd3jlSGFamkHvcAnZ58jL93oRqCBbb4km24aal8v+sDmi7iwX0r0AGyCYkG9DNG
         1CGLqW/NVcFVeAqxR+joIaSDoV36EGMW92YDJwwLaLYWTEd/D6WdwIRMWfDX1HnRTJQx
         93MozVwQJx5wMpfCL49pOWm+YVAXYpq8/QW3INtc+sDmhxt8mLwwkUbOLRZzkYUgtQ3Q
         YvB53v2pkWg+SuK7QpApus6/U5Ij9KgIlTIdmv6ERAqdWXa5kEMwq7PyQCR/qmpTbjRk
         LMag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WA3fhXKz11zSRT18uh5lWgyZMPbayuJGb3v+A3A9reA=;
        b=Yv1Xa3Jq6WBEp4Onp9bGYbG5eLS7eWI1ezPHEQJ9lMPysJMqTSZGRTiW1e97pJFPNe
         WYCPMcfqYVFgm5lhOHaiA1WZF9SJ/dseOGVF5Dyy048+qXPF+ZZfraVeONsU+LTZ7VO0
         IQ5UOXGI9ADcVAZK5F/1NAxJS7FqdrtKHohmvCtBUKipnq1g06KTLuI3ljA5xH+53G6S
         99YZUymLAqVQozsmH0qxHItm8AZl7qK+ofeicufqFnhNshEySzSYOcIbYnCJR73Fb3fz
         M8tMFu3QmwCbSigRgRvMxpG0wQT80DVkJV4S0sLY92otVt8MEMkRh4J75a/Rp1r4f0WY
         pxUg==
X-Gm-Message-State: AOAM530jLeVzl/SujV+3fwyontpYUZULA1WF+WSXjfp4Xzjj657d5/YN
        4OgB+MItE9OMIfyB7i8XgYcm7A==
X-Google-Smtp-Source: ABdhPJyBzvC5YXap0MKOU54W5OcmPRyG5+/UsDKt+f6SOeKw8Lszf2+OM/EcQnvlBhIqy4Bb9WLQyQ==
X-Received: by 2002:a2e:99d0:0:b0:244:c392:2326 with SMTP id l16-20020a2e99d0000000b00244c3922326mr19735654ljj.355.1645611281624;
        Wed, 23 Feb 2022 02:14:41 -0800 (PST)
Received: from eriador.lumag.spb.ru ([94.25.228.217])
        by smtp.gmail.com with ESMTPSA id s9sm2060256ljd.79.2022.02.23.02.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 02:14:41 -0800 (PST)
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
Subject: [PATCH v6 2/4] PCI: qcom: Remove redundancy between qcom_pcie and qcom_pcie_cfg
Date:   Wed, 23 Feb 2022 13:14:33 +0300
Message-Id: <20220223101435.447839-3-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220223101435.447839-1-dmitry.baryshkov@linaro.org>
References: <20220223101435.447839-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
 drivers/pci/controller/dwc/pcie-qcom.c | 34 ++++++++++++--------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index c19cd506ed3f..b2db2180e1bc 100644
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
@@ -1559,8 +1558,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 
 	pcie->pci = pci;
 
-	pcie->ops = pcie_cfg->ops;
-	pcie->pipe_clk_need_muxing = pcie_cfg->pipe_clk_need_muxing;
+	pcie->cfg = pcie_cfg;
 
 	pcie->reset = devm_gpiod_get_optional(dev, "perst", GPIOD_OUT_HIGH);
 	if (IS_ERR(pcie->reset)) {
@@ -1586,7 +1584,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 		goto err_pm_runtime_put;
 	}
 
-	ret = pcie->ops->get_resources(pcie);
+	ret = pcie->cfg->ops->get_resources(pcie);
 	if (ret)
 		goto err_pm_runtime_put;
 
-- 
2.34.1

