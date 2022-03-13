Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 870754D71BB
	for <lists+linux-pci@lfdr.de>; Sun, 13 Mar 2022 01:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233128AbiCMAJo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 12 Mar 2022 19:09:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232989AbiCMAJn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 12 Mar 2022 19:09:43 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D5827CFE
        for <linux-pci@vger.kernel.org>; Sat, 12 Mar 2022 16:08:36 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id h14so21170164lfk.11
        for <linux-pci@vger.kernel.org>; Sat, 12 Mar 2022 16:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TJSAvpvAUY0nSypSi9vcvDnYnHSZ/E9Lbv0gYBbs488=;
        b=ICKerC9QrbP4H8cjcVkuvV72gz1h6gBB3wEwzhDEqwE3P8KlCin8v3qWyxLfBiexPc
         UHse5KkUhS4NT45IM/HHYS95lXGILFcb7+bHGVskKEajfBgZns31fS5557XFBPTVJg3F
         qeqQkAXChqPz9nXSWpuWj3lxp4ch6/RbqtHWMGNIVZFm1k37cARWEIO/8cdT+0/Ef9V5
         7jf+35YLrSdrvQlsDSFk8n8bbl9bWA+7hyD+aTSq6Mug97b8rSKMCN6nyqoMsSqFeheO
         OHnWazVQ3ElXFs9qn1K5Ps08Fmf7ONfpDh+ov8aWv/y2CmWFQQwticG6CWfv2r3rrs2d
         nFVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TJSAvpvAUY0nSypSi9vcvDnYnHSZ/E9Lbv0gYBbs488=;
        b=38omc8q/3q+9IKwO7uSJCLXUjCPEHSCv7A+qbNoXaudoAphgXa35NTUcONNp9EwCeX
         TH7l4VuPvq/2TFcO0JD0bJwYxmpbl907scVLIoSOL/3j6ihVkkHKagiVEwkGlTyysXjf
         8ioFWKbLgOlxBahz0SinF+ET9S6otxPFmwM+8qfCnpT3aEvnz1lp0l5X5AF+47ZWjDTv
         VIkQTf1M8IfS0uWiw+KO3F9kX7OPUFYzdHBBOCL8/8Pfe6/bps36zG1PPQy3GGitQDrb
         pD/nd9GBNtrgJ6Y5asaEu58TKE0GVJiX1wox/wwHnEa8s4hLKjrLa20NiVo6Y49tTPMB
         6I5A==
X-Gm-Message-State: AOAM532wrfGKac7P2JMqcFUITENQ4wd38MAH+V1ArBwaehJlpWRugE0Q
        0nLUoWy9r+rd0akGzbCBmtP4q/5pwPLshA==
X-Google-Smtp-Source: ABdhPJxxDtEwIza4y8hRPrRksZOwkZPXKnKvngaWlDKW12k4I5y2e143idU6iRcyB+v+SJlOLfWh2Q==
X-Received: by 2002:a05:6512:22c5:b0:448:7a65:9a0c with SMTP id g5-20020a05651222c500b004487a659a0cmr4874105lfu.141.1647130115067;
        Sat, 12 Mar 2022 16:08:35 -0800 (PST)
Received: from eriador.lumag.spb.ru (pppoe.178-66-158-48.dynamic.avangarddsl.ru. [178.66.158.48])
        by smtp.gmail.com with ESMTPSA id e7-20020a05651c038700b00247dbb3e476sm2776017ljp.40.2022.03.12.16.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Mar 2022 16:08:34 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Prasad Malisetty <quic_pmaliset@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [RFC PATCH 4/5] PCI: qcom: Remove unnecessary pipe_clk handling
Date:   Sun, 13 Mar 2022 03:08:23 +0300
Message-Id: <20220313000824.229405-5-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220313000824.229405-1-dmitry.baryshkov@linaro.org>
References: <20220313000824.229405-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

QMP PHY driver already does clk_prepare_enable()/_disable() pipe_clk.
Remove extra calls to enable/disable this clock from the PCIe driver, so
that the PHY driver can manage the clock on its own.

Fixes: aa9c0df98c29 ("PCI: qcom: Switch pcie_1_pipe_clk_src after PHY init in SC7280")
Cc: Prasad Malisetty <quic_pmaliset@quicinc.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 50 ++------------------------
 1 file changed, 3 insertions(+), 47 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 6ab90891801d..a6becafb6a77 100644
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
@@ -597,8 +595,7 @@ static int qcom_pcie_get_resources_2_3_2(struct qcom_pcie *pcie)
 	if (IS_ERR(res->slave_clk))
 		return PTR_ERR(res->slave_clk);
 
-	res->pipe_clk = devm_clk_get(dev, "pipe");
-	return PTR_ERR_OR_ZERO(res->pipe_clk);
+	return 0;
 }
 
 static void qcom_pcie_deinit_2_3_2(struct qcom_pcie *pcie)
@@ -613,13 +610,6 @@ static void qcom_pcie_deinit_2_3_2(struct qcom_pcie *pcie)
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
@@ -694,22 +684,6 @@ static int qcom_pcie_init_2_3_2(struct qcom_pcie *pcie)
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
@@ -1198,8 +1172,7 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
 			return PTR_ERR(res->ref_clk_src);
 	}
 
-	res->pipe_clk = devm_clk_get(dev, "pipe");
-	return PTR_ERR_OR_ZERO(res->pipe_clk);
+	return 0;
 }
 
 static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
@@ -1238,12 +1211,6 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
 		goto err_disable_clocks;
 	}
 
-	ret = clk_prepare_enable(res->pipe_clk);
-	if (ret) {
-		dev_err(dev, "cannot prepare/enable pipe clock\n");
-		goto err_disable_clocks;
-	}
-
 	/* Wait for reset to complete, required on SM8450 */
 	usleep_range(1000, 1500);
 
@@ -1298,14 +1265,7 @@ static int qcom_pcie_post_init_2_7_0(struct qcom_pcie *pcie)
 	if (pcie->cfg->pipe_clk_need_muxing)
 		clk_set_parent(res->pipe_clk_src, res->phy_pipe_clk);
 
-	return clk_prepare_enable(res->pipe_clk);
-}
-
-static void qcom_pcie_post_deinit_2_7_0(struct qcom_pcie *pcie)
-{
-	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
-
-	clk_disable_unprepare(res->pipe_clk);
+	return 0;
 }
 
 static int qcom_pcie_link_up(struct dw_pcie *pci)
@@ -1455,9 +1415,7 @@ static const struct qcom_pcie_ops ops_1_0_0 = {
 static const struct qcom_pcie_ops ops_2_3_2 = {
 	.get_resources = qcom_pcie_get_resources_2_3_2,
 	.init = qcom_pcie_init_2_3_2,
-	.post_init = qcom_pcie_post_init_2_3_2,
 	.deinit = qcom_pcie_deinit_2_3_2,
-	.post_deinit = qcom_pcie_post_deinit_2_3_2,
 	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
 };
 
@@ -1484,7 +1442,6 @@ static const struct qcom_pcie_ops ops_2_7_0 = {
 	.deinit = qcom_pcie_deinit_2_7_0,
 	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
 	.post_init = qcom_pcie_post_init_2_7_0,
-	.post_deinit = qcom_pcie_post_deinit_2_7_0,
 };
 
 /* Qcom IP rev.: 1.9.0 */
@@ -1494,7 +1451,6 @@ static const struct qcom_pcie_ops ops_1_9_0 = {
 	.deinit = qcom_pcie_deinit_2_7_0,
 	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
 	.post_init = qcom_pcie_post_init_2_7_0,
-	.post_deinit = qcom_pcie_post_deinit_2_7_0,
 	.config_sid = qcom_pcie_config_sid_sm8250,
 };
 
-- 
2.34.1

