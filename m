Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C00542E65
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jun 2022 12:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237075AbiFHKwy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jun 2022 06:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237116AbiFHKwt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jun 2022 06:52:49 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9E0176D45
        for <linux-pci@vger.kernel.org>; Wed,  8 Jun 2022 03:52:45 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id t25so32584741lfg.7
        for <linux-pci@vger.kernel.org>; Wed, 08 Jun 2022 03:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z6yrtmOBco3WyChFHwByIszU0CSTBNUIahumUa0EHAM=;
        b=XSE5oUuTDgtPlBtkzxuDPbNKJfqhw2afsEWuFApKMy8hPMeM6f8XwXMt2YatqNI/3/
         JgAWmQ4DASl5zMggDcf91W1bU8DuP40ec5FBlz5pxX+NYXKb0LmJ8GmUmvmE2+R+aHAd
         6WydVsDAc8gy5kwTiZGXtuzD4LpJblXNTRA1Lqq20+Uip/A7DvZwe+svm1HJY3vZ2IJJ
         wDUAiGcKWV5YDKEABwouaudTw07uxFc927o1j/uznsjqDuVBITsx+Y3efhOuQq9VwWM2
         1E64kkAT4YjIBJIQ96L+DRzjmVgxjwVwaEknHVWqxLZTsCipOASSbCuX5ORme2a0hpHL
         D4EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z6yrtmOBco3WyChFHwByIszU0CSTBNUIahumUa0EHAM=;
        b=MsX1UXb8Bii2k5Bmq2tg/jhGDXaHzg0o0A4qWPM5fPY/8yOOr2/S4HE24bHEW6gARL
         w/Q2B0QmudK0nxUxEP05bDk1G6E9yu9bYtRPZTbSlPkBQUZCNS+Y6n1XIl+nihQR3gxN
         zB+T1zCFJmU3Rl94XpMebkTnzQalysodb9U8DCdygZQG35VPF28etI3C2//eH+bsNDyj
         jGjnXrJZv2Tq2HiEMuVcMVgWbMwnsKVigufzlWQXrhcn5jE9TFMNzrJlEFCPZNHFAcBM
         pZ7d+CkVTGQ2KBIfurx0lqrnKdpj/pjAmugEa4TtZYsWzqFsRNnlrzQQNgEvOVHkfdhg
         0Czw==
X-Gm-Message-State: AOAM531gXdkxTm/SJrtB+MZICqPLCevHXKMsq/XEjR6F+MA2QBb3mqrK
        +5xDDAdS1gt659hHQZZgFDZZnw==
X-Google-Smtp-Source: ABdhPJxtNE6Qqn4j890N067vYH1aIFVLlOFLq1pwuhn2LOVtBa0Y22HGvsmQPEmOHn9rTTKvVeBfLA==
X-Received: by 2002:a05:6512:1293:b0:479:4bbb:f785 with SMTP id u19-20020a056512129300b004794bbbf785mr8994176lfs.170.1654685563404;
        Wed, 08 Jun 2022 03:52:43 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id e9-20020a2e5009000000b002556b0cd5acsm3232337ljb.56.2022.06.08.03.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 03:52:42 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <quic_tdas@quicinc.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pci@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v11 4/5] PCI: qcom: Remove unnecessary pipe_clk handling
Date:   Wed,  8 Jun 2022 13:52:37 +0300
Message-Id: <20220608105238.2973600-5-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220608105238.2973600-1-dmitry.baryshkov@linaro.org>
References: <20220608105238.2973600-1-dmitry.baryshkov@linaro.org>
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

PCIe PHY drivers (both QMP and PCIe2) already do clk_prepare_enable() /
clk_prepare_disable() pipe_clk. Remove extra calls to enable/disable
this clock from the PCIe driver, so that the PHY driver can manage the
clock on its own.

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Tested-by: Johan Hovold <johan+linaro@kernel.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 44 ++------------------------
 1 file changed, 3 insertions(+), 41 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 2ea13750b492..8c1073452196 100644
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
@@ -1292,14 +1265,7 @@ static int qcom_pcie_post_init_2_7_0(struct qcom_pcie *pcie)
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
@@ -1449,9 +1415,7 @@ static const struct qcom_pcie_ops ops_1_0_0 = {
 static const struct qcom_pcie_ops ops_2_3_2 = {
 	.get_resources = qcom_pcie_get_resources_2_3_2,
 	.init = qcom_pcie_init_2_3_2,
-	.post_init = qcom_pcie_post_init_2_3_2,
 	.deinit = qcom_pcie_deinit_2_3_2,
-	.post_deinit = qcom_pcie_post_deinit_2_3_2,
 	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
 };
 
@@ -1478,7 +1442,6 @@ static const struct qcom_pcie_ops ops_2_7_0 = {
 	.deinit = qcom_pcie_deinit_2_7_0,
 	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
 	.post_init = qcom_pcie_post_init_2_7_0,
-	.post_deinit = qcom_pcie_post_deinit_2_7_0,
 };
 
 /* Qcom IP rev.: 1.9.0 */
@@ -1488,7 +1451,6 @@ static const struct qcom_pcie_ops ops_1_9_0 = {
 	.deinit = qcom_pcie_deinit_2_7_0,
 	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
 	.post_init = qcom_pcie_post_init_2_7_0,
-	.post_deinit = qcom_pcie_post_deinit_2_7_0,
 	.config_sid = qcom_pcie_config_sid_sm8250,
 };
 
-- 
2.35.1

