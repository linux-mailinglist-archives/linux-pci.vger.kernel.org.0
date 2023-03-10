Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22B3C6B3554
	for <lists+linux-pci@lfdr.de>; Fri, 10 Mar 2023 05:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbjCJEKs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Mar 2023 23:10:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbjCJEJq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Mar 2023 23:09:46 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF8FF5D33
        for <linux-pci@vger.kernel.org>; Thu,  9 Mar 2023 20:09:17 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id z10so2347201pgr.8
        for <linux-pci@vger.kernel.org>; Thu, 09 Mar 2023 20:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678421354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KBoZXs7oWaG22XZASLiUsiWHjHyRIoI/eDEhjgIXc7Q=;
        b=m+C/YrwHwt2i9/sGEdK99+vcNqF83EGmJ0/z8OiTYb6lKp60bIz/sMYHQCqg5FNrbJ
         iSmESv8doN6a3D2ie0bXRPD76AD78QJLwNXsGzuXp7UA+XHooI4aFObllYc0LpLc9SVy
         jTXrF2/Ziz3ZdSJ6KZK0GQO5ia05ylEgJyx8cpO4ndxSsj0VPkHqVd7JPigEgGEw5RYc
         Iu27AP/FFtrxv4WOdfCpTy1Ps2f4WecyAfm6UJEkISFEJs5O1XTiRc09I14LoTXZRM+x
         7HXfKPkzL4yHSIuWsVCevdXUbW+LCCfYej8orKO4hqi7lj6rC6zkc5OQOmBAQ3gWN4H+
         lxPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678421354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KBoZXs7oWaG22XZASLiUsiWHjHyRIoI/eDEhjgIXc7Q=;
        b=gXYLVcYwvYksxxhGDJG5g2A3CQIVG5nQzR2S+qlDIYWTICg7T1mMjKz6jjBfaPzpon
         71IBHyPj5+MqoL2UJbGGQAFdVuZ5WRI+rpKxTOEVjvUssg+Khqs3zjOlNjxXiFBNbqRU
         RJ2SHR/ZQ45HbjCqURXGytJxILnwKbfHJqdEowLtnOs4aNTRL1JzRl7Ld9+Pi7uN0dxq
         yg6eM6Iet7sJxRpHes77PQ+OUIt2WkqintyCIaKbKj9q4dKoOz3crD76Oml/goTJlHTf
         z2wQgHMCsmW3hdPbJW287g930kzbpIPlCIvzBY1OWWsCR3zRXj6bfazk8lur+jkN/H13
         6CvA==
X-Gm-Message-State: AO0yUKWRAaJK1nui0RtsJIOZpk9fhr7mzVcehU/r97fHmt7+Pjb6DdN+
        8PSlqVUj4TZXol/NnEM99mot
X-Google-Smtp-Source: AK7set/AJ2+DzvJ2I71zGLW8T6uvslhwcV827GsM+Bm42w+YtQUPm0rY+8/qzt+KDVJBvErtFaS2ig==
X-Received: by 2002:aa7:942a:0:b0:5e0:1073:1f25 with SMTP id y10-20020aa7942a000000b005e010731f25mr20028021pfo.7.1678421354009;
        Thu, 09 Mar 2023 20:09:14 -0800 (PST)
Received: from localhost.localdomain ([27.111.75.67])
        by smtp.gmail.com with ESMTPSA id y26-20020aa7855a000000b0058d92d6e4ddsm361846pfn.5.2023.03.09.20.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 20:09:13 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, lpieralisi@kernel.org, kw@linux.com,
        krzysztof.kozlowski+dt@linaro.org, robh@kernel.org
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 10/19] PCI: qcom: Use bulk reset APIs for handling resets for IP rev 2.3.3
Date:   Fri, 10 Mar 2023 09:38:07 +0530
Message-Id: <20230310040816.22094-11-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230310040816.22094-1-manivannan.sadhasivam@linaro.org>
References: <20230310040816.22094-1-manivannan.sadhasivam@linaro.org>
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

All the resets are asserted and deasserted at the same time. So the bulk
reset APIs can be used to handle them together. This simplifies the code
a lot.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 49 ++++++++++++--------------
 1 file changed, 23 insertions(+), 26 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 6b83e3627336..8c39fc554a89 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -170,9 +170,10 @@ struct qcom_pcie_resources_2_3_2 {
 };
 
 #define QCOM_PCIE_2_3_3_MAX_CLOCKS		5
+#define QCOM_PCIE_2_3_3_MAX_RESETS		7
 struct qcom_pcie_resources_2_3_3 {
 	struct clk_bulk_data clks[QCOM_PCIE_2_3_3_MAX_CLOCKS];
-	struct reset_control *rst[7];
+	struct reset_control_bulk_data rst[QCOM_PCIE_2_3_3_MAX_RESETS];
 };
 
 #define QCOM_PCIE_2_4_0_MAX_CLOCKS	4
@@ -889,10 +890,6 @@ static int qcom_pcie_get_resources_2_3_3(struct qcom_pcie *pcie)
 	struct qcom_pcie_resources_2_3_3 *res = &pcie->res.v2_3_3;
 	struct dw_pcie *pci = pcie->pci;
 	struct device *dev = pci->dev;
-	int i;
-	const char *rst_names[] = { "axi_m", "axi_s", "pipe",
-				    "axi_m_sticky", "sticky",
-				    "ahb", "sleep", };
 	int ret;
 
 	res->clks[0].id = "iface";
@@ -905,11 +902,17 @@ static int qcom_pcie_get_resources_2_3_3(struct qcom_pcie *pcie)
 	if (ret < 0)
 		return ret;
 
-	for (i = 0; i < ARRAY_SIZE(rst_names); i++) {
-		res->rst[i] = devm_reset_control_get(dev, rst_names[i]);
-		if (IS_ERR(res->rst[i]))
-			return PTR_ERR(res->rst[i]);
-	}
+	res->rst[0].id = "axi_m";
+	res->rst[1].id = "axi_s";
+	res->rst[2].id = "pipe";
+	res->rst[3].id = "axi_m_sticky";
+	res->rst[4].id = "sticky";
+	res->rst[5].id = "ahb";
+	res->rst[6].id = "sleep";
+
+	ret = devm_reset_control_bulk_get_exclusive(dev, ARRAY_SIZE(res->rst), res->rst);
+	if (ret < 0)
+		return ret;
 
 	return 0;
 }
@@ -926,25 +929,20 @@ static int qcom_pcie_init_2_3_3(struct qcom_pcie *pcie)
 	struct qcom_pcie_resources_2_3_3 *res = &pcie->res.v2_3_3;
 	struct dw_pcie *pci = pcie->pci;
 	struct device *dev = pci->dev;
-	int i, ret;
+	int ret;
 
-	for (i = 0; i < ARRAY_SIZE(res->rst); i++) {
-		ret = reset_control_assert(res->rst[i]);
-		if (ret) {
-			dev_err(dev, "reset #%d assert failed (%d)\n", i, ret);
-			return ret;
-		}
+	ret = reset_control_bulk_assert(ARRAY_SIZE(res->rst), res->rst);
+	if (ret < 0) {
+		dev_err(dev, "cannot assert resets\n");
+		return ret;
 	}
 
 	usleep_range(2000, 2500);
 
-	for (i = 0; i < ARRAY_SIZE(res->rst); i++) {
-		ret = reset_control_deassert(res->rst[i]);
-		if (ret) {
-			dev_err(dev, "reset #%d deassert failed (%d)\n", i,
-				ret);
-			return ret;
-		}
+	ret = reset_control_bulk_deassert(ARRAY_SIZE(res->rst), res->rst);
+	if (ret < 0) {
+		dev_err(dev, "cannot deassert resets\n");
+		return ret;
 	}
 
 	/*
@@ -966,8 +964,7 @@ static int qcom_pcie_init_2_3_3(struct qcom_pcie *pcie)
 	 * Not checking for failure, will anyway return
 	 * the original failure in 'ret'.
 	 */
-	for (i = 0; i < ARRAY_SIZE(res->rst); i++)
-		reset_control_assert(res->rst[i]);
+	reset_control_bulk_assert(ARRAY_SIZE(res->rst), res->rst);
 
 	return ret;
 }
-- 
2.25.1

