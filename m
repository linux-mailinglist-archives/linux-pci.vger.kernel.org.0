Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F355E53C69F
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jun 2022 09:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242672AbiFCH7X (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Jun 2022 03:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242676AbiFCH7V (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Jun 2022 03:59:21 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261833630B
        for <linux-pci@vger.kernel.org>; Fri,  3 Jun 2022 00:59:20 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id a2so11407622lfc.2
        for <linux-pci@vger.kernel.org>; Fri, 03 Jun 2022 00:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dk6py7H+zwmwDeBfBIzUUxARUG//K7qIEfBexVi1vfk=;
        b=kty9P3hHb+p8ASEkHPs7edpAlcQ5NPszGjPs760KipaD42SuEVb2qzS7upfy9RQWuj
         gv23eYLMmF8N29RHQFZ/BbfakFGePCvtz2LqMAYAJX2FleMoGTD98+hGYnwqxXwKrd4F
         wwqfVWJeXbtHqfkcxl1kJZDVlmJdiMdukbgPkrWTKIzXDTSfclwZEIyIiVsuMwuedgAd
         LW8i22Iy3pl7LMKjbyqqo6KoqrVXvbe5BPF1KZDyl66iMKg/AAVy2lJOgnn3lOukRr2z
         WfnHsOdrcUjlpXyNkCSeU4C9mR2EtnGUegnEhJCQCyjHIgsNBYCaYNMfqZW3WgSf3Tok
         nNkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dk6py7H+zwmwDeBfBIzUUxARUG//K7qIEfBexVi1vfk=;
        b=OG1DmVAft2ZtAqWcB++9rbbMG0izuIfXPh1uFbikxe56bbrSV/iDPQ4mUY8FHnKYuj
         FN5r2Gq1bujhGAuK3aUiuZrdqOWt1akeCPuIzH7CIooEDIc6TlBZWR1iRJ+q5n+oF5jw
         YNMwl0t7jJyXMJ9bIj9ChikAQW2F1QkEeyZN03g4ZG9+v1JG2EPfN8dlkuvlSQofG3uh
         mk6mFhMYWkBBgwaYnhwoCx4L9+LjA40IfKxUXfSfdl/HK5B7Fnb4c4xSxlfhiqH8sh7f
         +olLZ0Kbn/5kQKdr7NdNPBdh7bZMgUxb5aP4RMOPGdHcXosYZHGeGjgFh1iC1y7UUqUZ
         U+Nw==
X-Gm-Message-State: AOAM533RtidLQQaoLyNHx/qAZYByFLqy7nF4ux6j3QIhhx/oCQRiwWoK
        LN4WqWmmuMJviT5ZU87t05ks+A==
X-Google-Smtp-Source: ABdhPJxoyAUMb1BVE3aa90qC54OqnOjhT2oZcWyEMNevCGrkfFcJ40J5MbSo0ec2AKU4Q1R3empFcA==
X-Received: by 2002:ac2:5b08:0:b0:479:16ed:e624 with SMTP id v8-20020ac25b08000000b0047916ede624mr2247464lfn.618.1654243158276;
        Fri, 03 Jun 2022 00:59:18 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id bp2-20020a056512158200b00477c5940bbasm1438428lfb.265.2022.06.03.00.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 00:59:17 -0700 (PDT)
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
        linux-pci@vger.kernel.org
Subject: [PATCH v9 5/5] PCI: qcom: Drop manual pipe_clk_src handling
Date:   Fri,  3 Jun 2022 10:59:08 +0300
Message-Id: <20220603075908.1853011-6-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220603075908.1853011-1-dmitry.baryshkov@linaro.org>
References: <20220603075908.1853011-1-dmitry.baryshkov@linaro.org>
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

Manual reparenting of pipe_clk_src is being replaced with the parking of
the clock with clk_disable()/clk_enable() in the phy driver. Drop
redundant code switching of the pipe clock between the PHY clock source
and the safe bi_tcxo.

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Tested-by: Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 39 +-------------------------
 1 file changed, 1 insertion(+), 38 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 8c1073452196..9a95ecf5a688 100644
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
 	unsigned int has_tbu_clk:1;
 	unsigned int has_ddrss_sf_tbu_clk:1;
 	unsigned int has_aggre0_clk:1;
@@ -1158,20 +1154,6 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
 	if (ret < 0)
 		return ret;
 
-	if (pcie->cfg->pipe_clk_need_muxing) {
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
 
@@ -1189,10 +1171,6 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
 		return ret;
 	}
 
-	/* Set TCXO as clock source for pcie_pipe_clk_src */
-	if (pcie->cfg->pipe_clk_need_muxing)
-		clk_set_parent(res->pipe_clk_src, res->ref_clk_src);
-
 	ret = clk_bulk_prepare_enable(res->num_clks, res->clks);
 	if (ret < 0)
 		goto err_disable_regulators;
@@ -1254,18 +1232,8 @@ static void qcom_pcie_deinit_2_7_0(struct qcom_pcie *pcie)
 	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
 
 	clk_bulk_disable_unprepare(res->num_clks, res->clks);
-	regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
-}
 
-static int qcom_pcie_post_init_2_7_0(struct qcom_pcie *pcie)
-{
-	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
-
-	/* Set pipe clock as clock source for pcie_pipe_clk_src */
-	if (pcie->cfg->pipe_clk_need_muxing)
-		clk_set_parent(res->pipe_clk_src, res->phy_pipe_clk);
-
-	return 0;
+	regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
 }
 
 static int qcom_pcie_link_up(struct dw_pcie *pci)
@@ -1441,7 +1409,6 @@ static const struct qcom_pcie_ops ops_2_7_0 = {
 	.init = qcom_pcie_init_2_7_0,
 	.deinit = qcom_pcie_deinit_2_7_0,
 	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
-	.post_init = qcom_pcie_post_init_2_7_0,
 };
 
 /* Qcom IP rev.: 1.9.0 */
@@ -1450,7 +1417,6 @@ static const struct qcom_pcie_ops ops_1_9_0 = {
 	.init = qcom_pcie_init_2_7_0,
 	.deinit = qcom_pcie_deinit_2_7_0,
 	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
-	.post_init = qcom_pcie_post_init_2_7_0,
 	.config_sid = qcom_pcie_config_sid_sm8250,
 };
 
@@ -1495,7 +1461,6 @@ static const struct qcom_pcie_cfg sm8250_cfg = {
 static const struct qcom_pcie_cfg sm8450_pcie0_cfg = {
 	.ops = &ops_1_9_0,
 	.has_ddrss_sf_tbu_clk = true,
-	.pipe_clk_need_muxing = true,
 	.has_aggre0_clk = true,
 	.has_aggre1_clk = true,
 };
@@ -1503,14 +1468,12 @@ static const struct qcom_pcie_cfg sm8450_pcie0_cfg = {
 static const struct qcom_pcie_cfg sm8450_pcie1_cfg = {
 	.ops = &ops_1_9_0,
 	.has_ddrss_sf_tbu_clk = true,
-	.pipe_clk_need_muxing = true,
 	.has_aggre1_clk = true,
 };
 
 static const struct qcom_pcie_cfg sc7280_cfg = {
 	.ops = &ops_1_9_0,
 	.has_tbu_clk = true,
-	.pipe_clk_need_muxing = true,
 };
 
 static const struct qcom_pcie_cfg sc8180x_cfg = {
-- 
2.35.1

