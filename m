Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 143DB52F722
	for <lists+linux-pci@lfdr.de>; Sat, 21 May 2022 02:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354296AbiEUAyD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 May 2022 20:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354289AbiEUAyC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 May 2022 20:54:02 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C191AEC45
        for <linux-pci@vger.kernel.org>; Fri, 20 May 2022 17:54:00 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id t25so16940635lfg.7
        for <linux-pci@vger.kernel.org>; Fri, 20 May 2022 17:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6sZg18S8rp1uODywqvEr9TdNrYKlPChLaAXqj+OfCPs=;
        b=bIBGL5V16JPA8slRkMl/7j9TMIJYues+WYVzr6cRgHqb+gPVB2UZIpLsGn7lOwOJb1
         XQavB8hMpD/qPvjGX9Be1qdfOY+N709zcXtB58h+hXfWlxPbp3Vq0A1XQHgCVSoC2EWD
         dEVLSnLsqJpWrxbYOQU86jraD6lgRpSdfqw3P2E1QNuY7WjbxEgxgVTKqzqU1WOQTiWd
         dIhcDdUpmd0J3wcl/6Cr/Ze8aWKKv3YdPuEX9otxmjwZrfFQIIQzBwF6icijQwFOqfLX
         MLjVcTmuYcIxDidx3pcEfjYQCT57il6NuihLvSv5fCZ4Dm/zBthmZyv5qiXG7Zcmlrmx
         /MGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6sZg18S8rp1uODywqvEr9TdNrYKlPChLaAXqj+OfCPs=;
        b=GsQAuiDV9O4ZQrv1Zi1WV87q/wVqdN5v/LulbJ1k1eL4Ii9MU3C9wc99tarkgtoswc
         7KL1SNyabxHtDcitX0CwlTJ2Qf6uS1Lre1U8qPSqyCWUONpEgLX/AeS6VxSpTWPPRf4h
         n5qdDj67X5s7/d7gnocdiBi9xnUbWHLY8pVvONRTrtoj9vqeLt2YV6gGv17La7Vfk5Bs
         1uCCfYJVNsUQB2jZxqwV3/f2C3mdmmrnXS5Thwx7BD5Y9icOipTGZQhprUII4yKSMkl4
         DDEoqOqonSN9yhmowaJV0wzYjtHmM/UYY7BM8BjhdxYrixQZQNvKN0nY6jdsQwIf16RD
         kxvg==
X-Gm-Message-State: AOAM533bFWwxKWT7V1R0MN4e0abBKfL/4q6AnBK5ORkyBCdKo+/rHoQD
        qr6AeMoHlBVn/3sxy+cWppP8Cw==
X-Google-Smtp-Source: ABdhPJy4/Fl9d4OUlxrYbGVNk7So4daENMceTxyBDtcxi7txB6AJPpQKisgd7mjSwqqSfVaUFmJCgw==
X-Received: by 2002:ac2:4294:0:b0:473:e5bc:7a64 with SMTP id m20-20020ac24294000000b00473e5bc7a64mr8927439lfh.84.1653094440018;
        Fri, 20 May 2022 17:54:00 -0700 (PDT)
Received: from eriador.lan ([2001:470:dd84:abc0::8a5])
        by smtp.gmail.com with ESMTPSA id u14-20020a056512094e00b0047255d21187sm844559lft.182.2022.05.20.17.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 17:53:59 -0700 (PDT)
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
Subject: [PATCH v7 7/8] PCI: qcom: Remove unnecessary pipe_clk handling
Date:   Sat, 21 May 2022 03:53:42 +0300
Message-Id: <20220521005343.1429642-8-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220521005343.1429642-1-dmitry.baryshkov@linaro.org>
References: <20220521005343.1429642-1-dmitry.baryshkov@linaro.org>
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

