Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D106B1ECE
	for <lists+linux-pci@lfdr.de>; Thu,  9 Mar 2023 09:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbjCIIwZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Mar 2023 03:52:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbjCIIwW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Mar 2023 03:52:22 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA1BDF27D
        for <linux-pci@vger.kernel.org>; Thu,  9 Mar 2023 00:51:52 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id i5so1280697pla.2
        for <linux-pci@vger.kernel.org>; Thu, 09 Mar 2023 00:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678351904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TSFkykYkB7c0gJwp2FwEg/ye5mEGILHD2HLR3ehwkBA=;
        b=hc0gwMQFnzalTunvAjm4L58hHwNp7VbTbHo+lbvNwLRqv+H00TGza5uFFfGhU4r2Aa
         ufBz12oVXM+brOBI+yvrO9AvuRl4WSr8FwDEw2mJ0cW/XOC5/z2cUDVEPtlsOZY2E12d
         evzbkEOD05Koq4h7ngnttkZ2Nsy9Hz08S8QbhN1oQB9/yRwre67ituExGeRsvfo03m6i
         kMV9bbvJ/IrRzwoxSOcaTxN6VQ9SEeyxbuaztgUntrLgW2A+k6Dym6tEvNinZfsIoUps
         9KMm1tz1rxbq3rQlhZsFGhVovsNX80Z5NvS3+nCPZiB3fLG8U5iM4OIF/RX8VU0ZTEWe
         bPWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678351904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TSFkykYkB7c0gJwp2FwEg/ye5mEGILHD2HLR3ehwkBA=;
        b=Nkr5YeM4KtUbsnRttcT6NA8IKJJSPq82qNgzhaxmwqNwHryV1NfcnCXZW3lnOiT+3S
         y+eTnAMmdpk+lVPQgJSK5+1czfwcTVtou7aKY57EJLAbVj5EkcS4T/F4Q2pUpz21VrsF
         GEPXFpG2VRP0SIaMD0cEhZM+MH0AqPI5K7SF0nPpkf6pW8oxUNEVLVfU1Hcoq7urkqpY
         +c7o8D/5QSKH18rekbZGNrdb43mtcVD2GKjFZXsCXzj3/JVYMtCHJ/JuyhgGUn/GxdFO
         +tbP6uOBcO+gewqGbRQoqTvJWps+kX5jH9TBnfEFe0i1bItfF8RTv2orZtI3/IZyJ37m
         9IWw==
X-Gm-Message-State: AO0yUKWCmJYgSgvZsCqtATnIBoz8msEeUoO1fGIXr3V+y9B1s6gtgpty
        OO4sMb/EJyZ0E3txuA1Hzm0a
X-Google-Smtp-Source: AK7set9PtpEL7sXKPywKujAuB+LNOQB+ST0LshJZUOcCzup+D7fIp4tjKw5uDpoFiYR/YpYPQr3Tlg==
X-Received: by 2002:a05:6a20:440d:b0:c7:6088:9bc8 with SMTP id ce13-20020a056a20440d00b000c760889bc8mr27454847pzb.52.1678351904178;
        Thu, 09 Mar 2023 00:51:44 -0800 (PST)
Received: from localhost.localdomain ([220.158.158.11])
        by smtp.gmail.com with ESMTPSA id u4-20020aa78484000000b005809d382016sm10638604pfn.74.2023.03.09.00.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 00:51:43 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, lpieralisi@kernel.org, kw@linux.com,
        krzysztof.kozlowski+dt@linaro.org, robh@kernel.org
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 07/17] PCI: qcom: Use bulk clock APIs for handling clocks for IP rev 1.0.0
Date:   Thu,  9 Mar 2023 14:20:52 +0530
Message-Id: <20230309085102.120977-8-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230309085102.120977-1-manivannan.sadhasivam@linaro.org>
References: <20230309085102.120977-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

