Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A701C52E24F
	for <lists+linux-pci@lfdr.de>; Fri, 20 May 2022 04:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344637AbiETB6w (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 May 2022 21:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344625AbiETB6v (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 May 2022 21:58:51 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB87EC304
        for <linux-pci@vger.kernel.org>; Thu, 19 May 2022 18:58:50 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id l13so5311615lfp.11
        for <linux-pci@vger.kernel.org>; Thu, 19 May 2022 18:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6sZg18S8rp1uODywqvEr9TdNrYKlPChLaAXqj+OfCPs=;
        b=CCCsPDNrDrB6OHWTfIayCgdZOnLBKMRkRBfx2TOv3P8DE1CQ9Z1PlTJBWHYtXJ5T6U
         RMwGNdeauNl7J7Xlnds8VB1O8Y/1FOnuflbYwfdaCBbqtafaHXuIjQTCi34TEyhDYh9T
         6mS6UPcbhbt1Frj1QEPRzgvDPJj02gnH1F2P1anXj7lGlz+5kTutaYZWWC1cRLuCwhpV
         P1oMqkiQQxuFlh0YoemvQ7TA91EvPwDS0rVZTS7ES0iS6M7lL6dGKLHtq/jCJ2Szubl4
         j0VAipO264WbtBj4mJzs9evDQCC1eQb0/HV3Yt/8W6wwpkLmERfDPQadUh+fkQAZFJ/z
         SSEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6sZg18S8rp1uODywqvEr9TdNrYKlPChLaAXqj+OfCPs=;
        b=HrFiKRAKu7lnf6kQ04LRmACS0KJPP4gOjUqm9KQB7c0PJ0HQjm4ycMY1P+aFT1U/Jn
         KVBDxE7oL6L6llLVChlO+CYk/ZKo4Bn7nqhhwmu4Ibiwnzu8fGHqj+kYh4GmscK/ZiAQ
         ARfNmUd9987NuzD2M5LdG4kjeKthU5I4HzEq8zhKMPZFvS/aPQcgL3YOSZDzaIaGbnm2
         4Lw9ezslrzX8DtbMt2qNyOuRLzNVmzcU7UvhdlFnZFrjBhOWOH30arEdiRwe4sTtdbWi
         Rz/feWltWnbOogC5fP7EoDZeN3kEfTFPwD8CUHnhtCujIjr/xXJ1IEPk8/XHHRnwfY5K
         HxIw==
X-Gm-Message-State: AOAM533ZTqvwiDO7JC5zRwgklplzCubp30PtlkvJ2/6yufv/qRvhuxig
        RPed41LZTu3GIS2F1tv9n07YQg==
X-Google-Smtp-Source: ABdhPJz4G3ijx7sqg6vvqnIVCUe+WnnWophtFNp+rftMsmEv/MHP6OzwikdQVkLWSL8Sng7Msmj4Hg==
X-Received: by 2002:a05:6512:1681:b0:477:a451:131a with SMTP id bu1-20020a056512168100b00477a451131amr5098208lfb.318.1653011928440;
        Thu, 19 May 2022 18:58:48 -0700 (PDT)
Received: from eriador.lan ([2001:470:dd84:abc0::8a5])
        by smtp.gmail.com with ESMTPSA id u28-20020ac24c3c000000b0047255d21192sm467370lfq.193.2022.05.19.18.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 18:58:48 -0700 (PDT)
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
        linux-pci@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v7 1/6] PCI: qcom: Remove unnecessary pipe_clk handling
Date:   Fri, 20 May 2022 04:58:39 +0300
Message-Id: <20220520015844.1190511-2-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220520015844.1190511-1-dmitry.baryshkov@linaro.org>
References: <20220520015844.1190511-1-dmitry.baryshkov@linaro.org>
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
index 9055bb20777e..91e58edc7ea9 100644
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

