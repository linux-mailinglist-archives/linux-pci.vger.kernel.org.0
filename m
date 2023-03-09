Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28F86B1ECA
	for <lists+linux-pci@lfdr.de>; Thu,  9 Mar 2023 09:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjCIIwX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Mar 2023 03:52:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbjCIIwT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Mar 2023 03:52:19 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F921DBB56
        for <linux-pci@vger.kernel.org>; Thu,  9 Mar 2023 00:51:50 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id i5so1280835pla.2
        for <linux-pci@vger.kernel.org>; Thu, 09 Mar 2023 00:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678351908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=amLlMnvqqV/ACQXsqFtaJlfI0hCQH92ixpD+YcVSgsE=;
        b=lPU0O1gSI3XQPZSiu5PrFa3Thv5xviQqS3pJTpjNXdfTzQTmhJ6qhPj8FqWiVjS0p9
         419fZecD4pZ0csSDp2nyJfdcUta0/XHsRkOKKdcTMDOTNgtpyGlMs+Nayk4EZNLoODR5
         e7eRRD5LQysSbllVlVSY5WrGQizg/FntgIDEIAUa69CEtcbsrnd8Uk5+hxnijpzWj3oZ
         Mv8JY8NQs9NQ8A4OdD4Lb5MKJXwlK3rklcYE0lC9T/281r+RUDqS6P+xcANEmgXKcd4Y
         LJfg2eCkm+NSMmLShu4lzI9vRFP3PHwJmufql8IwSiXv30TNrXwp9nCUsbY4/nl9qS0E
         H0bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678351908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=amLlMnvqqV/ACQXsqFtaJlfI0hCQH92ixpD+YcVSgsE=;
        b=yl0oR2VYrumyFCTA1zccFiPhYYrYI6kgb0EPLd/n5M9dZHTAkU0euJf7M5qqJ9EH8Q
         rXqpgjLHZcrqkKWPktPPl9sMMnNI+iW/41qKvA1Cf023kMGMsnp0q3fsPQCCjKNV1alM
         pKrqyzLvI1lXJMZLBK9+0OIL+ljEHQb0RMj6dkDZ2w8f3Czzbe9g7hRw2j1pxu5SPhMi
         vSPKrRl6gm3MpjqyzoPvKkrpwv7/GYryDMbQSNuTM64bVCUxd/OtACZrlnNdPTP3ei1P
         dcWB6qfP2T2TctcfFwkolaIiUEIy6frBQbK6o0PK4j99MQvV5TcDB6V+ieHamn8Jwow9
         R7Fw==
X-Gm-Message-State: AO0yUKUh2jOsb1ynEpNoADTXQAXRd2AOT5w12Y6zYHxw6xDRezOEUHKc
        RHRqnQL1H8PwcN3cuTyolUFk
X-Google-Smtp-Source: AK7set9GzHFlFRu9bwNc4A1Ftnto2ionjzTOrPVNegKUeIpmaGVK/2KrIF3KZouQfNkTNdohpkF3qQ==
X-Received: by 2002:a05:6a20:7d88:b0:cc:fa4b:3a6a with SMTP id v8-20020a056a207d8800b000ccfa4b3a6amr28376975pzj.58.1678351907950;
        Thu, 09 Mar 2023 00:51:47 -0800 (PST)
Received: from localhost.localdomain ([220.158.158.11])
        by smtp.gmail.com with ESMTPSA id u4-20020aa78484000000b005809d382016sm10638604pfn.74.2023.03.09.00.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 00:51:47 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, lpieralisi@kernel.org, kw@linux.com,
        krzysztof.kozlowski+dt@linaro.org, robh@kernel.org
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 08/17] PCI: qcom: Use bulk clock APIs for handling clocks for IP rev 2.3.2
Date:   Thu,  9 Mar 2023 14:20:53 +0530
Message-Id: <20230309085102.120977-9-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230309085102.120977-1-manivannan.sadhasivam@linaro.org>
References: <20230309085102.120977-1-manivannan.sadhasivam@linaro.org>
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

