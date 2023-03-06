Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A78C16AC543
	for <lists+linux-pci@lfdr.de>; Mon,  6 Mar 2023 16:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbjCFPeT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Mar 2023 10:34:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbjCFPeH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Mar 2023 10:34:07 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B194D34004
        for <linux-pci@vger.kernel.org>; Mon,  6 Mar 2023 07:33:23 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id n6so10785241plf.5
        for <linux-pci@vger.kernel.org>; Mon, 06 Mar 2023 07:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678116792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=amLlMnvqqV/ACQXsqFtaJlfI0hCQH92ixpD+YcVSgsE=;
        b=GeZbKJur8/ECXVMvdE/iCuGPL98R+cQgfcpYGzyP8oeC6QEOMrgXyTo+o4C3i09BlS
         VoKSAFHbnQtpmsMrVreMCBpcS9vLYeriUd4wSxUV/XKKWm33rFSe2R2ikj462OPO/MPJ
         W0e+X+XJJ6yHcWmLg4eOyREhQgUInFGBKYoT3MbU0GWj//GwEE4XUD5TqPLoJ9xcHGeZ
         noG8oWTtx3jVS7PycN0HLI/zwD1xvat2l+t1wwfH6d9zAH8yeClzepTm0+wOotsUXt5B
         Wog8AzTZWW+/PoQDcPcJhhRkz3m1zelEXISHWJ2yxP8az5FBWIOrdjMVuoWwD4vR/6QK
         /kWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678116792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=amLlMnvqqV/ACQXsqFtaJlfI0hCQH92ixpD+YcVSgsE=;
        b=vQz9oQ5St5SpRwZeWCmU6/ul/bb3WW8GRC/IInb+Uu5N2Io8Nh1DnqQUx5DKHpSXp0
         pNPTwZirsgyEQZ5C82YQikccTVN1ZeNwaL+xZX29yd5F2LHjs+jkLvzuyZ6gYbFl2dFB
         IJWeKEH2ZeQkT6asd+XsNQm1GJEk28UlzOOfohiBUo2Dd0iRRwhjzrvAM59sbjdsKwgy
         Mo9rjursoS4u3Hh9wymXsphJMMP1kWX7fjdS3X/Vo1SHQOybiFTMhLajaNsURnAT02pZ
         juQ1crkRlhu8LO7OC+CeU00eT4kk2lr64RBR8AzPqhye+H1KORLPUsvJZIv9YdmAHXho
         YHWQ==
X-Gm-Message-State: AO0yUKX9/YEqElcEHMFVHQ6THAN3ZQ1qoIDKxoVpCRdiPED2I57OhSsA
        2llpzgJgrjEjwTinpxYX2rQW
X-Google-Smtp-Source: AK7set+YIQGecqYbNVKVz5rM05gFtbtQRV5Tx9YLSB/WUz9Mz8gZwHtks67MdFSBYvBczOL9NMdexg==
X-Received: by 2002:a17:903:228b:b0:19c:bae2:681a with SMTP id b11-20020a170903228b00b0019cbae2681amr11872205plh.66.1678116791770;
        Mon, 06 Mar 2023 07:33:11 -0800 (PST)
Received: from localhost.localdomain ([59.97.52.140])
        by smtp.gmail.com with ESMTPSA id kl4-20020a170903074400b0019a7c890c61sm6837430plb.252.2023.03.06.07.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 07:33:11 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, lpieralisi@kernel.org, kw@linux.com,
        krzysztof.kozlowski+dt@linaro.org, robh@kernel.org
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 08/19] PCI: qcom: Use bulk clock APIs for handling clocks for IP rev 2.3.2
Date:   Mon,  6 Mar 2023 21:02:11 +0530
Message-Id: <20230306153222.157667-9-manivannan.sadhasivam@linaro.org>
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
 drivers/pci/controller/dwc/pcie-qcom.c | 72 ++++++--------------------
 1 file changed, 15 insertions(+), 57 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 0bb27d3c95a0..939973733a1e 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -162,12 +162,10 @@ struct qcom_pcie_resources_2_1_0 {
 	struct regulator_bulk_data supplies[QCOM_PCIE_2_1_0_MAX_SUPPLY];
 };
 
-#define QCOM_PCIE_2_3_2_MAX_SUPPLY	2
+#define QCOM_PCIE_2_3_2_MAX_CLOCKS		4
+#define QCOM_PCIE_2_3_2_MAX_SUPPLY		2
 struct qcom_pcie_resources_2_3_2 {
-	struct clk *aux_clk;
-	struct clk *master_clk;
-	struct clk *slave_clk;
-	struct clk *cfg_clk;
+	struct clk_bulk_data clks[QCOM_PCIE_2_3_2_MAX_CLOCKS];
 	struct regulator_bulk_data supplies[QCOM_PCIE_2_3_2_MAX_SUPPLY];
 };
 
@@ -539,21 +537,14 @@ static int qcom_pcie_get_resources_2_3_2(struct qcom_pcie *pcie)
 	if (ret)
 		return ret;
 
-	res->aux_clk = devm_clk_get(dev, "aux");
-	if (IS_ERR(res->aux_clk))
-		return PTR_ERR(res->aux_clk);
-
-	res->cfg_clk = devm_clk_get(dev, "cfg");
-	if (IS_ERR(res->cfg_clk))
-		return PTR_ERR(res->cfg_clk);
-
-	res->master_clk = devm_clk_get(dev, "bus_master");
-	if (IS_ERR(res->master_clk))
-		return PTR_ERR(res->master_clk);
+	res->clks[0].id = "aux";
+	res->clks[1].id = "cfg";
+	res->clks[2].id = "bus_master";
+	res->clks[3].id = "bus_slave";
 
-	res->slave_clk = devm_clk_get(dev, "bus_slave");
-	if (IS_ERR(res->slave_clk))
-		return PTR_ERR(res->slave_clk);
+	ret = devm_clk_bulk_get(dev, ARRAY_SIZE(res->clks), res->clks);
+	if (ret < 0)
+		return ret;
 
 	return 0;
 }
@@ -562,11 +553,7 @@ static void qcom_pcie_deinit_2_3_2(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_resources_2_3_2 *res = &pcie->res.v2_3_2;
 
-	clk_disable_unprepare(res->slave_clk);
-	clk_disable_unprepare(res->master_clk);
-	clk_disable_unprepare(res->cfg_clk);
-	clk_disable_unprepare(res->aux_clk);
-
+	clk_bulk_disable_unprepare(ARRAY_SIZE(res->clks), res->clks);
 	regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
 }
 
@@ -583,43 +570,14 @@ static int qcom_pcie_init_2_3_2(struct qcom_pcie *pcie)
 		return ret;
 	}
 
-	ret = clk_prepare_enable(res->aux_clk);
-	if (ret) {
-		dev_err(dev, "cannot prepare/enable aux clock\n");
-		goto err_aux_clk;
-	}
-
-	ret = clk_prepare_enable(res->cfg_clk);
-	if (ret) {
-		dev_err(dev, "cannot prepare/enable cfg clock\n");
-		goto err_cfg_clk;
-	}
-
-	ret = clk_prepare_enable(res->master_clk);
-	if (ret) {
-		dev_err(dev, "cannot prepare/enable master clock\n");
-		goto err_master_clk;
-	}
-
-	ret = clk_prepare_enable(res->slave_clk);
+	ret = clk_bulk_prepare_enable(ARRAY_SIZE(res->clks), res->clks);
 	if (ret) {
-		dev_err(dev, "cannot prepare/enable slave clock\n");
-		goto err_slave_clk;
+		dev_err(dev, "cannot prepare/enable clocks\n");
+		regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
+		return ret;
 	}
 
 	return 0;
-
-err_slave_clk:
-	clk_disable_unprepare(res->master_clk);
-err_master_clk:
-	clk_disable_unprepare(res->cfg_clk);
-err_cfg_clk:
-	clk_disable_unprepare(res->aux_clk);
-
-err_aux_clk:
-	regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
-
-	return ret;
 }
 
 static int qcom_pcie_post_init_2_3_2(struct qcom_pcie *pcie)
-- 
2.25.1

