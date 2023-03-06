Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7356AC548
	for <lists+linux-pci@lfdr.de>; Mon,  6 Mar 2023 16:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbjCFPeU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Mar 2023 10:34:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbjCFPeH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Mar 2023 10:34:07 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030EE34C0F
        for <linux-pci@vger.kernel.org>; Mon,  6 Mar 2023 07:33:25 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id v11so10764777plz.8
        for <linux-pci@vger.kernel.org>; Mon, 06 Mar 2023 07:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678116796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HLaHkNbeR3pTSpm3EckvQkVoLPurUbKikH/yYKtcjD0=;
        b=thnWH9V+PUlOUgjdtGqI99SmuYfo4Yz63ZHz0BFPBNPEV/bIUh/hIRX/iNVaz4ryVX
         TkGOanFhVf12pylEudeQNgzqlK1LdHLuvO0x4AhPbRL//L81mUowTCRMKkCyrV/plp4K
         6K/a5Ppt0f3gPoSQAHpBe6xNsr5ZW+OUXCq5s+QRqzAUc8L5b8xzMdu6WSUc/uZmYBGf
         rJ3KWI4LCSQtfQQzQs9ZPJa/W+7SX/aIkCnrO9yqiCZkHF2CInJga1Gk+RIJHKHBc/TC
         2wJ+OcYVRKV8dGhQzK78q1xTWjvmcLoO62umVvWboX2pThM+HmLsYkN2/bx0CnyJHB7S
         r0CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678116796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HLaHkNbeR3pTSpm3EckvQkVoLPurUbKikH/yYKtcjD0=;
        b=6ZVGFqeUpD7Mn3mzYwYcKYXP3pDBpjIteZuGrPA1PpYBDGLAPSrkXw1/xns4F6Iozx
         2QkmKUbLU/k3MSwZY1f4VTZlCIuYojZvr5vdbW5zlIKrjY6FUj7fisKKbeMCXDcxv0iZ
         R3wm4qFMQ3qjnTg24pHM2EWyv6XbB8t6vhQ6e+Q0StWOhia767LYj2vWBwOVTMe+LCb0
         5VfVnaiaOQgZqcev/bJg8p6vyJFIDwCSySGbGX3dBIzi1TFzM7U/e3JXaNyssCDOhs/x
         6BYwYYII7bLj7qK5PpiudvWcADxiiicFp3Lkf1mte6lyCZ6yNdja/70EBd4oG/EZKOpd
         JFGg==
X-Gm-Message-State: AO0yUKVlCLaPx8GcAp0Xn6oHm5M/RhSkc+UX1xn/nuHHzegQjFbp1vuj
        5gFnRnimyQrUeOPnCd0LaLyRDyx3brPhbQE/5A==
X-Google-Smtp-Source: AK7set8zmFEsZnK4AI9bdbHTvMbp2MgLVAQPYAHKGXs8ZD8mvu/1dBBvZt8F+IdanvlQP0r8ulzHyg==
X-Received: by 2002:a17:902:e80f:b0:19e:747e:813e with SMTP id u15-20020a170902e80f00b0019e747e813emr12933698plg.23.1678116796557;
        Mon, 06 Mar 2023 07:33:16 -0800 (PST)
Received: from localhost.localdomain ([59.97.52.140])
        by smtp.gmail.com with ESMTPSA id kl4-20020a170903074400b0019a7c890c61sm6837430plb.252.2023.03.06.07.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 07:33:16 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, lpieralisi@kernel.org, kw@linux.com,
        krzysztof.kozlowski+dt@linaro.org, robh@kernel.org
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 09/19] PCI: qcom: Use bulk clock APIs for handling clocks for IP rev 2.3.3
Date:   Mon,  6 Mar 2023 21:02:12 +0530
Message-Id: <20230306153222.157667-10-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230306153222.157667-1-manivannan.sadhasivam@linaro.org>
References: <20230306153222.157667-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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

