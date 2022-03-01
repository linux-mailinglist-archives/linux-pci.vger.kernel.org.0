Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF3D4C8503
	for <lists+linux-pci@lfdr.de>; Tue,  1 Mar 2022 08:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232946AbiCAH0o (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Mar 2022 02:26:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232943AbiCAH0m (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Mar 2022 02:26:42 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4917D00E
        for <linux-pci@vger.kernel.org>; Mon, 28 Feb 2022 23:25:56 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id b8so13328723pjb.4
        for <linux-pci@vger.kernel.org>; Mon, 28 Feb 2022 23:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XcrSCga7Xm8Y9zIpO0tHWnQ34+nJVndVvWu2AXj24uM=;
        b=If1P716/92hDw1jMXqlLzXvQYbk72lwK4le2ixsBP8IEOjTM2xOwm+k4DEFp+v3BxO
         nf+lUAGLMgXYuNU9CU2/J9pZUBq936xE4qnmydds4QWElOowHXvzr9fiAT7B1WbOhKfO
         EcHmt/cfdPJPd2VW/hAMKXlOnSb0+YcULfnp4QLT9eAQgzsBBtMjgiDsyGD8BjZdOnyP
         mkW42zTrxODKU4KYbIJHGP0WSFGQeSqZ6F+dxvYCV4Y4ST+feTd2QbypKHmdJSwleC6O
         cJW16MhgCOIQQ4J1Gul80cdMhSYG/KzjWI30MDnZX8EIY1D/5Aa40U64YTwO0VvoaA/r
         WrGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XcrSCga7Xm8Y9zIpO0tHWnQ34+nJVndVvWu2AXj24uM=;
        b=RBL8FTiqzHinbJ+PW/oMbdmG0NERV3nY7Yf2BIh/nnzxN0kVtR3CnoN8ItyTEgDzu6
         MRHal3ryn1TpDY/squKgVre3T5Ih1ekkJMUdIdbSp9KRDs8mgDHOgecALtlJyFC8lEdF
         muwSwBORc02gzafGNt6WzJwDHEMQgKgL4p4bJb3h/0yO6UJapGzAprpG979kS9ajWzUz
         FQmbDqzA49kWKaZi/cS1bBOtc9FttL71iqMbugVFKUXY59lKqw6cuBjxZGVtto6gX7hO
         Fptg4nxlKDtrA+074kTa9mrA18E5AufGeWSGfpZRQ6wrwnoJpUypyi0gcsB9l+hU2e2h
         nt4A==
X-Gm-Message-State: AOAM531ykTLKPGgAqRgKFzNS4Y+SSFEsXpfzDT4hY6xU5p/GAGDccDj9
        TdODxDFWFrJBacBmmeTXIoYjrw==
X-Google-Smtp-Source: ABdhPJyeE8ix9wVipAppJN34/BQ4VA0zwFYopWYflf1/qZdstP7yls7AGk8udujTC4i1KYaA1n9mFA==
X-Received: by 2002:a17:90a:348f:b0:1be:d738:9736 with SMTP id p15-20020a17090a348f00b001bed7389736mr2813523pjb.65.1646119555894;
        Mon, 28 Feb 2022 23:25:55 -0800 (PST)
Received: from localhost.localdomain ([223.179.136.225])
        by smtp.gmail.com with ESMTPSA id m6-20020a62f206000000b004e152bc0527sm15680445pfh.153.2022.02.28.23.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 23:25:55 -0800 (PST)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        lorenzo.pieralisi@arm.com, agross@kernel.org,
        bjorn.andersson@linaro.org, svarbanov@mm-sol.com,
        bhelgaas@google.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, sboyd@kernel.org, mturquette@baylibre.com,
        linux-clk@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v2 5/7] PCI: qcom: Add SM8150 SoC support
Date:   Tue,  1 Mar 2022 12:55:09 +0530
Message-Id: <20220301072511.117818-6-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220301072511.117818-1-bhupesh.sharma@linaro.org>
References: <20220301072511.117818-1-bhupesh.sharma@linaro.org>
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

The PCIe IP (rev 1.5.0) on SM8150 SoC is similar to the one used on
SM8250. Hence the support is added reusing the members of ops_2_7_0.

Cc: Vinod Koul <vkoul@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index c19cd506ed3f..66fbc0234888 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1487,6 +1487,17 @@ static const struct qcom_pcie_ops ops_1_9_0 = {
 	.config_sid = qcom_pcie_config_sid_sm8250,
 };
 
+/* Qcom IP rev.: 1.5.0 */
+static const struct qcom_pcie_ops ops_1_5_0 = {
+	.get_resources = qcom_pcie_get_resources_2_7_0,
+	.init = qcom_pcie_init_2_7_0,
+	.deinit = qcom_pcie_deinit_2_7_0,
+	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
+	.post_init = qcom_pcie_post_init_2_7_0,
+	.post_deinit = qcom_pcie_post_deinit_2_7_0,
+	.config_sid = qcom_pcie_config_sid_sm8250,
+};
+
 static const struct qcom_pcie_cfg apq8084_cfg = {
 	.ops = &ops_1_0_0,
 };
@@ -1511,6 +1522,10 @@ static const struct qcom_pcie_cfg sdm845_cfg = {
 	.ops = &ops_2_7_0,
 };
 
+static const struct qcom_pcie_cfg sm8150_cfg = {
+	.ops = &ops_1_5_0,
+};
+
 static const struct qcom_pcie_cfg sm8250_cfg = {
 	.ops = &ops_1_9_0,
 };
@@ -1626,6 +1641,7 @@ static const struct of_device_id qcom_pcie_match[] = {
 	{ .compatible = "qcom,pcie-ipq4019", .data = &ipq4019_cfg },
 	{ .compatible = "qcom,pcie-qcs404", .data = &ipq4019_cfg },
 	{ .compatible = "qcom,pcie-sdm845", .data = &sdm845_cfg },
+	{ .compatible = "qcom,pcie-sm8150", .data = &sm8150_cfg },
 	{ .compatible = "qcom,pcie-sm8250", .data = &sm8250_cfg },
 	{ .compatible = "qcom,pcie-sc8180x", .data = &sm8250_cfg },
 	{ .compatible = "qcom,pcie-sc7280", .data = &sc7280_cfg },
-- 
2.35.1

