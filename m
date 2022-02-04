Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA154A9B4D
	for <lists+linux-pci@lfdr.de>; Fri,  4 Feb 2022 15:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359449AbiBDOq5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Feb 2022 09:46:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359451AbiBDOq4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Feb 2022 09:46:56 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989ECC061756
        for <linux-pci@vger.kernel.org>; Fri,  4 Feb 2022 06:46:55 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id i34so13175129lfv.2
        for <linux-pci@vger.kernel.org>; Fri, 04 Feb 2022 06:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=834ZeSQv8JRt/AoDg49+kb7R02sAA8A0g9Z5La4Rnzg=;
        b=CyhYJKOVMc1esvIiUcWVd5WK2YZuhualCB6ZHsuAHJ6f8hAcxs6mnd16A964xpcIbm
         LM8xCIn5QyLW2g0AO9oHQbC+jZazXm8TIgY7hz6cw9SPfKas77V6DDaelGfFLVGqr4O5
         MXsJDqW7mGhsYquwva0a69p4p5wKQt0LjG2rPRmUHCBDeVxX8I5QvTWQqg49rYJcWOGN
         j0WXI4D8ChzJnrxRD51XNZk3DTkFlHA2hEHE+DCB/7e0W5aHS1+kOFPkfA9XdRvOL92W
         VP73gg8kQDnQIExZEH8cY++tvXzdSr8og/TWM4REA/Y3Oqfc178iE1eI1Jt9+iAHkYpA
         AGCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=834ZeSQv8JRt/AoDg49+kb7R02sAA8A0g9Z5La4Rnzg=;
        b=LJxbCupVJUals0Q7H9knv0ti8SdDblImKOfYLaCPNVkt+aEUau9qA2FMa26CSsUIuR
         neF8QxfB6pkYMjeHyPPWDJiilqyGoECj3ZBhZVd9mUxLTUR/LdlrutUj0tui1jZVl580
         N27Iu6ICz6akqSkMoNZ27+Xp5RTxNWEFZ7XDS8r0Bybgb3nAwwwRsIap/oR47/P7fbAR
         7M6CujVczuGNWqlNrYAWrjIbFZ0hqPUutviDbrvBct+uemC4GiMTb1rcGKTLTNGIJ9WY
         NfGKVWLp0niSSgekYvd1F5o+F3dC6mxSef2xkXlqkfPCaz0G46VMwUVsJCHsv3UhKGev
         hQUQ==
X-Gm-Message-State: AOAM532+R+nCvwtyFauoWujyMvzGVIUvVkTxklv1btb4eA6GIRXUfeGP
        W3RgUgFWfdiyT6l8hcaq93UO+w==
X-Google-Smtp-Source: ABdhPJx4sRd11IQeo9M/dqAxTE76YJ5x7QE8Rs6t0Opx5T30kV8t1z5SL1VMXhhmPmB12DTQgQm11Q==
X-Received: by 2002:a05:6512:2215:: with SMTP id h21mr2514037lfu.570.1643986013961;
        Fri, 04 Feb 2022 06:46:53 -0800 (PST)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id y23sm348222lfb.2.2022.02.04.06.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 06:46:53 -0800 (PST)
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
Subject: [PATCH v2 08/11] PCI: qcom: Remove pipe_clk_src reparenting
Date:   Fri,  4 Feb 2022 17:46:42 +0300
Message-Id: <20220204144645.3016603-9-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220204144645.3016603-1-dmitry.baryshkov@linaro.org>
References: <20220204144645.3016603-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The SC7280 platform has switched to using GDSC wrapper for setting
pipe_clk_src parent clock. Remove supporting code from the pcie-qcom
driver.

Cc: Prasad Malisetty <pmaliset@codeaurora.org>
Cc: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 38 --------------------------
 1 file changed, 38 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 85e84b621dbc..7df8632a21a8 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -164,9 +164,6 @@ struct qcom_pcie_resources_2_7_0 {
 	int num_clks;
 	struct regulator_bulk_data supplies[2];
 	struct reset_control *pci_reset;
-	struct clk *pipe_clk_src;
-	struct clk *phy_pipe_clk;
-	struct clk *ref_clk_src;
 };
 
 union qcom_pcie_resources {
@@ -192,7 +189,6 @@ struct qcom_pcie_ops {
 
 struct qcom_pcie_cfg {
 	const struct qcom_pcie_ops *ops;
-	unsigned int pipe_clk_need_muxing:1;
 };
 
 struct qcom_pcie {
@@ -203,7 +199,6 @@ struct qcom_pcie {
 	struct phy *phy;
 	struct gpio_desc *reset;
 	const struct qcom_pcie_ops *ops;
-	unsigned int pipe_clk_need_muxing:1;
 };
 
 #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
@@ -1147,20 +1142,6 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
 	if (ret < 0)
 		return ret;
 
-	if (pcie->pipe_clk_need_muxing) {
-		res->pipe_clk_src = devm_clk_get(dev, "pipe_mux");
-		if (IS_ERR(res->pipe_clk_src))
-			return PTR_ERR(res->pipe_clk_src);
-
-		res->phy_pipe_clk = devm_clk_get(dev, "phy_pipe");
-		if (IS_ERR(res->phy_pipe_clk))
-			return PTR_ERR(res->phy_pipe_clk);
-
-		res->ref_clk_src = devm_clk_get(dev, "ref");
-		if (IS_ERR(res->ref_clk_src))
-			return PTR_ERR(res->ref_clk_src);
-	}
-
 	return 0;
 }
 
@@ -1178,10 +1159,6 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
 		return ret;
 	}
 
-	/* Set TCXO as clock source for pcie_pipe_clk_src */
-	if (pcie->pipe_clk_need_muxing)
-		clk_set_parent(res->pipe_clk_src, res->ref_clk_src);
-
 	ret = clk_bulk_prepare_enable(res->num_clks, res->clks);
 	if (ret < 0)
 		goto err_disable_regulators;
@@ -1243,17 +1220,6 @@ static void qcom_pcie_deinit_2_7_0(struct qcom_pcie *pcie)
 	regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
 }
 
-static int qcom_pcie_post_init_2_7_0(struct qcom_pcie *pcie)
-{
-	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
-
-	/* Set pipe clock as clock source for pcie_pipe_clk_src */
-	if (pcie->pipe_clk_need_muxing)
-		clk_set_parent(res->pipe_clk_src, res->phy_pipe_clk);
-
-	return 0;
-}
-
 static int qcom_pcie_link_up(struct dw_pcie *pci)
 {
 	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
@@ -1427,7 +1393,6 @@ static const struct qcom_pcie_ops ops_2_7_0 = {
 	.init = qcom_pcie_init_2_7_0,
 	.deinit = qcom_pcie_deinit_2_7_0,
 	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
-	.post_init = qcom_pcie_post_init_2_7_0,
 };
 
 /* Qcom IP rev.: 1.9.0 */
@@ -1436,7 +1401,6 @@ static const struct qcom_pcie_ops ops_1_9_0 = {
 	.init = qcom_pcie_init_2_7_0,
 	.deinit = qcom_pcie_deinit_2_7_0,
 	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
-	.post_init = qcom_pcie_post_init_2_7_0,
 	.config_sid = qcom_pcie_config_sid_sm8250,
 };
 
@@ -1470,7 +1434,6 @@ static const struct qcom_pcie_cfg sm8250_cfg = {
 
 static const struct qcom_pcie_cfg sc7280_cfg = {
 	.ops = &ops_1_9_0,
-	.pipe_clk_need_muxing = true,
 };
 
 static const struct dw_pcie_ops dw_pcie_ops = {
@@ -1513,7 +1476,6 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	pcie->pci = pci;
 
 	pcie->ops = pcie_cfg->ops;
-	pcie->pipe_clk_need_muxing = pcie_cfg->pipe_clk_need_muxing;
 
 	pcie->reset = devm_gpiod_get_optional(dev, "perst", GPIOD_OUT_HIGH);
 	if (IS_ERR(pcie->reset)) {
-- 
2.34.1

