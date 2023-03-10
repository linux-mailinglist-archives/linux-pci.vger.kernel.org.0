Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7E86B3548
	for <lists+linux-pci@lfdr.de>; Fri, 10 Mar 2023 05:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjCJEKN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Mar 2023 23:10:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbjCJEJ3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Mar 2023 23:09:29 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B1CF4B61
        for <linux-pci@vger.kernel.org>; Thu,  9 Mar 2023 20:09:11 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id u3-20020a17090a450300b00239db6d7d47so3997161pjg.4
        for <linux-pci@vger.kernel.org>; Thu, 09 Mar 2023 20:09:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678421342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TSFkykYkB7c0gJwp2FwEg/ye5mEGILHD2HLR3ehwkBA=;
        b=oVXd7b4kdJXE2amluOUwK2rOccTnxwOAz+X3RJz2cnGo1HefalrMrz6t14sziJg5q4
         ofJaHZB9odTHGcjJjRZPBSIUiZcjCZMBchnYshU9CvJ+mmYgamjo9cgNKLdbpcSAepL3
         Hs8chovDO71Wq1b+pxpX1grybkFKxsl7f0kWPCmba/LV2bX5ZDMyHn1BULT36M+J57Og
         dYB9mtzjcvFbHwh4MQ4Rbn0QveRr7m15aEddm9lHQSmC3sip6eoL8gRdCmYzegDVix+8
         RzcaUvqNdi1Ba6jlNPCWHHRc0jGK4BuEnmunQSNLlS3MhoTjvBbN+Dv2HZZDUhqEqXwJ
         dl5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678421342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TSFkykYkB7c0gJwp2FwEg/ye5mEGILHD2HLR3ehwkBA=;
        b=KDrSfe0Dr67O+02gD2lBQteGAmyWxUd7avvhb7AJmeHm6CGadquA6y/6Onp0UEMFxr
         suLdfUH8XL6s7U8TElki10rrKg3AvJ1G+dOvRUpEsiyu+sImylTvcnlbRzNpih6nyt80
         03Y9v1qyctHVN5CMNDnhVd5dargHjCkhP/j240GT88BawaYAtvYputMWg7if37En1NgH
         iMQL1th2JPW/AB/lZyOHozMgyZeEy3JGMxMWYVZOLyGlzzAIJr32fWv5d8fXZioeGwWs
         CpmkKcduOYG1/wQJeKasu/eLtsti5VTk7UYQzmvqwLQSelJAWUlOmuAz895F6UZ7sJO5
         07CQ==
X-Gm-Message-State: AO0yUKVyenXlfYVXUj3sT7MwiPqhwrYgZmohH7gHbucDBD5CRiV5jQTW
        ypEFnwBy9cI/1rAwHA+GXOsS
X-Google-Smtp-Source: AK7set84Utm1kWLabtW+KVnPXPPKWSJqMAoG2LYNpVRU5FZ9oO8wgSIcUqf0aw6vHoj8nlH9farfDg==
X-Received: by 2002:a05:6a20:6620:b0:c7:3209:f24d with SMTP id n32-20020a056a20662000b000c73209f24dmr18679656pzh.56.1678421341970;
        Thu, 09 Mar 2023 20:09:01 -0800 (PST)
Received: from localhost.localdomain ([27.111.75.67])
        by smtp.gmail.com with ESMTPSA id y26-20020aa7855a000000b0058d92d6e4ddsm361846pfn.5.2023.03.09.20.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 20:09:01 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, lpieralisi@kernel.org, kw@linux.com,
        krzysztof.kozlowski+dt@linaro.org, robh@kernel.org
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 07/19] PCI: qcom: Use bulk clock APIs for handling clocks for IP rev 1.0.0
Date:   Fri, 10 Mar 2023 09:38:04 +0530
Message-Id: <20230310040816.22094-8-manivannan.sadhasivam@linaro.org>
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

All the clocks are enabled and disabled at the same time. So the bulk clock
APIs can be used to handle them together. This simplifies the code a lot.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 72 +++++++-------------------
 1 file changed, 19 insertions(+), 53 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 2d9116464842..0bb27d3c95a0 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -145,11 +145,9 @@
 
 #define QCOM_PCIE_CRC8_POLYNOMIAL		(BIT(2) | BIT(1) | BIT(0))
 
+#define QCOM_PCIE_1_0_0_MAX_CLOCKS		4
 struct qcom_pcie_resources_1_0_0 {
-	struct clk *iface;
-	struct clk *aux;
-	struct clk *master_bus;
-	struct clk *slave_bus;
+	struct clk_bulk_data clks[QCOM_PCIE_1_0_0_MAX_CLOCKS];
 	struct reset_control *core;
 	struct regulator *vdda;
 };
@@ -439,26 +437,20 @@ static int qcom_pcie_get_resources_1_0_0(struct qcom_pcie *pcie)
 	struct qcom_pcie_resources_1_0_0 *res = &pcie->res.v1_0_0;
 	struct dw_pcie *pci = pcie->pci;
 	struct device *dev = pci->dev;
+	int ret;
 
 	res->vdda = devm_regulator_get(dev, "vdda");
 	if (IS_ERR(res->vdda))
 		return PTR_ERR(res->vdda);
 
-	res->iface = devm_clk_get(dev, "iface");
-	if (IS_ERR(res->iface))
-		return PTR_ERR(res->iface);
-
-	res->aux = devm_clk_get(dev, "aux");
-	if (IS_ERR(res->aux))
-		return PTR_ERR(res->aux);
-
-	res->master_bus = devm_clk_get(dev, "master_bus");
-	if (IS_ERR(res->master_bus))
-		return PTR_ERR(res->master_bus);
+	res->clks[0].id = "iface";
+	res->clks[1].id = "aux";
+	res->clks[2].id = "master_bus";
+	res->clks[3].id = "slave_bus";
 
-	res->slave_bus = devm_clk_get(dev, "slave_bus");
-	if (IS_ERR(res->slave_bus))
-		return PTR_ERR(res->slave_bus);
+	ret = devm_clk_bulk_get(dev, ARRAY_SIZE(res->clks), res->clks);
+	if (ret < 0)
+		return ret;
 
 	res->core = devm_reset_control_get_exclusive(dev, "core");
 	return PTR_ERR_OR_ZERO(res->core);
@@ -469,10 +461,7 @@ static void qcom_pcie_deinit_1_0_0(struct qcom_pcie *pcie)
 	struct qcom_pcie_resources_1_0_0 *res = &pcie->res.v1_0_0;
 
 	reset_control_assert(res->core);
-	clk_disable_unprepare(res->slave_bus);
-	clk_disable_unprepare(res->master_bus);
-	clk_disable_unprepare(res->iface);
-	clk_disable_unprepare(res->aux);
+	clk_bulk_disable_unprepare(ARRAY_SIZE(res->clks), res->clks);
 	regulator_disable(res->vdda);
 }
 
@@ -489,46 +478,23 @@ static int qcom_pcie_init_1_0_0(struct qcom_pcie *pcie)
 		return ret;
 	}
 
-	ret = clk_prepare_enable(res->aux);
-	if (ret) {
-		dev_err(dev, "cannot prepare/enable aux clock\n");
-		goto err_res;
-	}
-
-	ret = clk_prepare_enable(res->iface);
-	if (ret) {
-		dev_err(dev, "cannot prepare/enable iface clock\n");
-		goto err_aux;
-	}
-
-	ret = clk_prepare_enable(res->master_bus);
-	if (ret) {
-		dev_err(dev, "cannot prepare/enable master_bus clock\n");
-		goto err_iface;
-	}
-
-	ret = clk_prepare_enable(res->slave_bus);
+	ret = clk_bulk_prepare_enable(ARRAY_SIZE(res->clks), res->clks);
 	if (ret) {
-		dev_err(dev, "cannot prepare/enable slave_bus clock\n");
-		goto err_master;
+		dev_err(dev, "cannot prepare/enable clocks\n");
+		goto err_assert_reset;
 	}
 
 	ret = regulator_enable(res->vdda);
 	if (ret) {
 		dev_err(dev, "cannot enable vdda regulator\n");
-		goto err_slave;
+		goto err_disable_clks;
 	}
 
 	return 0;
-err_slave:
-	clk_disable_unprepare(res->slave_bus);
-err_master:
-	clk_disable_unprepare(res->master_bus);
-err_iface:
-	clk_disable_unprepare(res->iface);
-err_aux:
-	clk_disable_unprepare(res->aux);
-err_res:
+
+err_disable_clks:
+	clk_bulk_disable_unprepare(ARRAY_SIZE(res->clks), res->clks);
+err_assert_reset:
 	reset_control_assert(res->core);
 
 	return ret;
-- 
2.25.1

