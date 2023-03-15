Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 151D76BA825
	for <lists+linux-pci@lfdr.de>; Wed, 15 Mar 2023 07:44:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbjCOGoc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Mar 2023 02:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbjCOGoZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Mar 2023 02:44:25 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5BD311EB
        for <linux-pci@vger.kernel.org>; Tue, 14 Mar 2023 23:43:43 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id d13so7720044pjh.0
        for <linux-pci@vger.kernel.org>; Tue, 14 Mar 2023 23:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678862623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HLaHkNbeR3pTSpm3EckvQkVoLPurUbKikH/yYKtcjD0=;
        b=Aohq1SjeCSITo6hnONIla7Ui2v2jqAHnUTZXoNGF0zLA4+CW50GrNMRbUvv+PAkCap
         vy4Qw5nR3Ky64/K00n5Wk5OUJKLsUkrKYLwjunM0ldrY7aGrbcG/0MKFObBojlvlXa5Q
         aMsvcTY12GJGlt6+dQ97nV5C0NJt6Ey1wyAP/hP0YXogEEdPTHTatfb7FZP8lJszxrzu
         L/znDI+5HfEtSow78SEmK74Cb0W9KFp/daGHCreKPji1bAAJ0h27egW1WZYnZ6KgXNUf
         wGnyRcoUc6lWiukDG8Li/SUYeHrKqylwv4WSzzRcUjuV03UX0TEoCTQgAREInFXXlzu/
         uBNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678862623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HLaHkNbeR3pTSpm3EckvQkVoLPurUbKikH/yYKtcjD0=;
        b=b/u+Dk9Hus3I12oqo6es9aLBBW0SbFLLneMd8d8muABFUMzl2I7nD4+e0vKWFELb9u
         8NHTg/Ph790YQHiEfATp5g5Htyj/ALug452YAas41/DtwqJuR+qZmM5XnHPBVZj/neVZ
         Fyow9cvyi/YRvMgC8L5SOl0DYB5oPtq2FvwJJ8oB2YUqkkQSJHEqo8QJUQkmKC26rCY4
         vuOpoc2LWG/05oB64suWFF1I6JK8GCbJGxkkEs2M5L81lcTv5fBKI23lIekBOM3UszVz
         UMgsyi6dO0TpeWKIJ8Io3OFT5WdM79/poLu6o6y50kQGemL6fWKDbF54SNZJGHPswxZJ
         vwxg==
X-Gm-Message-State: AO0yUKW8dCds+S70MnxHsf19ADIy85O5Lfa8Xp6jyk3ARPzm8V/KvHB2
        KeKT1wLz4z78rRE9ucfAtS45
X-Google-Smtp-Source: AK7set++SgD9ps/UD76o0D4gDLbdbzVeS2rccHA3FEl1a7sSKubiAujQ+cLnH2Tf6H8Tjg/mBPa8Nw==
X-Received: by 2002:a17:90b:943:b0:23d:198c:a5ec with SMTP id dw3-20020a17090b094300b0023d198ca5ecmr7960346pjb.39.1678862623379;
        Tue, 14 Mar 2023 23:43:43 -0700 (PDT)
Received: from localhost.localdomain ([117.217.182.35])
        by smtp.gmail.com with ESMTPSA id u4-20020a17090a6a8400b002367325203fsm550747pjj.50.2023.03.14.23.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 23:43:42 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, lpieralisi@kernel.org, kw@linux.com,
        krzysztof.kozlowski+dt@linaro.org, robh@kernel.org
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 09/18] PCI: qcom: Use bulk clock APIs for handling clocks for IP rev 2.3.3
Date:   Wed, 15 Mar 2023 12:12:46 +0530
Message-Id: <20230315064255.15591-10-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230315064255.15591-1-manivannan.sadhasivam@linaro.org>
References: <20230315064255.15591-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

All the clocks are enabled and disabled at the same time. So the bulk clock
APIs can be used to handle them together. This simplifies the code a lot.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 88 ++++++--------------------
 1 file changed, 20 insertions(+), 68 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 939973733a1e..6b83e3627336 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -169,6 +169,12 @@ struct qcom_pcie_resources_2_3_2 {
 	struct regulator_bulk_data supplies[QCOM_PCIE_2_3_2_MAX_SUPPLY];
 };
 
+#define QCOM_PCIE_2_3_3_MAX_CLOCKS		5
+struct qcom_pcie_resources_2_3_3 {
+	struct clk_bulk_data clks[QCOM_PCIE_2_3_3_MAX_CLOCKS];
+	struct reset_control *rst[7];
+};
+
 #define QCOM_PCIE_2_4_0_MAX_CLOCKS	4
 struct qcom_pcie_resources_2_4_0 {
 	struct clk_bulk_data clks[QCOM_PCIE_2_4_0_MAX_CLOCKS];
@@ -187,15 +193,6 @@ struct qcom_pcie_resources_2_4_0 {
 	struct reset_control *phy_ahb_reset;
 };
 
-struct qcom_pcie_resources_2_3_3 {
-	struct clk *iface;
-	struct clk *axi_m_clk;
-	struct clk *axi_s_clk;
-	struct clk *ahb_clk;
-	struct clk *aux_clk;
-	struct reset_control *rst[7];
-};
-
 /* 6 clocks typically, 7 for sm8250 */
 struct qcom_pcie_resources_2_7_0 {
 	struct clk_bulk_data clks[12];
@@ -896,26 +893,17 @@ static int qcom_pcie_get_resources_2_3_3(struct qcom_pcie *pcie)
 	const char *rst_names[] = { "axi_m", "axi_s", "pipe",
 				    "axi_m_sticky", "sticky",
 				    "ahb", "sleep", };
+	int ret;
 
-	res->iface = devm_clk_get(dev, "iface");
-	if (IS_ERR(res->iface))
-		return PTR_ERR(res->iface);
-
-	res->axi_m_clk = devm_clk_get(dev, "axi_m");
-	if (IS_ERR(res->axi_m_clk))
-		return PTR_ERR(res->axi_m_clk);
-
-	res->axi_s_clk = devm_clk_get(dev, "axi_s");
-	if (IS_ERR(res->axi_s_clk))
-		return PTR_ERR(res->axi_s_clk);
-
-	res->ahb_clk = devm_clk_get(dev, "ahb");
-	if (IS_ERR(res->ahb_clk))
-		return PTR_ERR(res->ahb_clk);
+	res->clks[0].id = "iface";
+	res->clks[1].id = "axi_m";
+	res->clks[2].id = "axi_s";
+	res->clks[3].id = "ahb";
+	res->clks[4].id = "aux";
 
-	res->aux_clk = devm_clk_get(dev, "aux");
-	if (IS_ERR(res->aux_clk))
-		return PTR_ERR(res->aux_clk);
+	ret = devm_clk_bulk_get(dev, ARRAY_SIZE(res->clks), res->clks);
+	if (ret < 0)
+		return ret;
 
 	for (i = 0; i < ARRAY_SIZE(rst_names); i++) {
 		res->rst[i] = devm_reset_control_get(dev, rst_names[i]);
@@ -930,11 +918,7 @@ static void qcom_pcie_deinit_2_3_3(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_resources_2_3_3 *res = &pcie->res.v2_3_3;
 
-	clk_disable_unprepare(res->iface);
-	clk_disable_unprepare(res->axi_m_clk);
-	clk_disable_unprepare(res->axi_s_clk);
-	clk_disable_unprepare(res->ahb_clk);
-	clk_disable_unprepare(res->aux_clk);
+	clk_bulk_disable_unprepare(ARRAY_SIZE(res->clks), res->clks);
 }
 
 static int qcom_pcie_init_2_3_3(struct qcom_pcie *pcie)
@@ -969,47 +953,15 @@ static int qcom_pcie_init_2_3_3(struct qcom_pcie *pcie)
 	 */
 	usleep_range(2000, 2500);
 
-	ret = clk_prepare_enable(res->iface);
-	if (ret) {
-		dev_err(dev, "cannot prepare/enable core clock\n");
-		goto err_clk_iface;
-	}
-
-	ret = clk_prepare_enable(res->axi_m_clk);
-	if (ret) {
-		dev_err(dev, "cannot prepare/enable core clock\n");
-		goto err_clk_axi_m;
-	}
-
-	ret = clk_prepare_enable(res->axi_s_clk);
-	if (ret) {
-		dev_err(dev, "cannot prepare/enable axi slave clock\n");
-		goto err_clk_axi_s;
-	}
-
-	ret = clk_prepare_enable(res->ahb_clk);
-	if (ret) {
-		dev_err(dev, "cannot prepare/enable ahb clock\n");
-		goto err_clk_ahb;
-	}
-
-	ret = clk_prepare_enable(res->aux_clk);
+	ret = clk_bulk_prepare_enable(ARRAY_SIZE(res->clks), res->clks);
 	if (ret) {
-		dev_err(dev, "cannot prepare/enable aux clock\n");
-		goto err_clk_aux;
+		dev_err(dev, "cannot prepare/enable clocks\n");
+		goto err_assert_resets;
 	}
 
 	return 0;
 
-err_clk_aux:
-	clk_disable_unprepare(res->ahb_clk);
-err_clk_ahb:
-	clk_disable_unprepare(res->axi_s_clk);
-err_clk_axi_s:
-	clk_disable_unprepare(res->axi_m_clk);
-err_clk_axi_m:
-	clk_disable_unprepare(res->iface);
-err_clk_iface:
+err_assert_resets:
 	/*
 	 * Not checking for failure, will anyway return
 	 * the original failure in 'ret'.
-- 
2.25.1

