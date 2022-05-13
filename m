Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7125262DC
	for <lists+linux-pci@lfdr.de>; Fri, 13 May 2022 15:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380640AbiEMNRO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 May 2022 09:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380642AbiEMNRI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 May 2022 09:17:08 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A39B65E8
        for <linux-pci@vger.kernel.org>; Fri, 13 May 2022 06:17:06 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 16so10213505lju.13
        for <linux-pci@vger.kernel.org>; Fri, 13 May 2022 06:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vd1rXyGrFLPpJbM8brL1LSfhqsnXPhAcMh1xnhSaVVM=;
        b=wlj+UnnG0n0R9yGsyF6ez6I1tOQyOsp1gLsgbr7cGPoSIWu+C91K/mV8HBi69cypeX
         HawsnxIrxRu5nRUqGZu3I4V2LK8xAJtueWNmZgaOMfahIwiwBC0iFmh0Ty93Y1ZRysPu
         5rcgaEfgoPRPD6kh7pewA05Gu9/2jCMSCEapPTDOnpXs2yLNxhF9labVTmLgMIa8vPqx
         g6Bh5xhNg+T9ZzjkHyUKVtZgSdYd9C3eCpJ18DjX0m1L652NAPNNOdJDcD4Rkyrai+4b
         EDjT+Z9KlbRxtww5hxaDSnXIaBoCHEvjXYz1+Nbn20V3VE0Wesa8KLwnSFPPD9UB136h
         9bug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vd1rXyGrFLPpJbM8brL1LSfhqsnXPhAcMh1xnhSaVVM=;
        b=mlCA3PrTMW+tGFtITVkLjeR4px8e09q9UIeLFGXKQ4hoA5rnHgfum6zoBwudrxpDoF
         z4KKT52MNj3Px6fEDRvrKFtagrOT8HWWbJZlJxu1CJ/DVwuU1/yyhBYR+YS0iWED3N8Y
         hUuw2QuIjZuulymqLcs1Be/x9OBgU9LoWmqCTq0Osqs86NHU2cBvmnjgN7SbrIiNUQpH
         CgZKd6wLv25xsP2Z4SXvjxXWBBcXht3l0pSmcTbDqz85reVgvJLxSlPb5GpRyLx8R4ds
         KAh3+hdU7IrO1nkeLd3ZwGhfq+xUBLET2a3yLsje3wuqSZ1R0EUHZILOBRWzPWHHnKcB
         noDw==
X-Gm-Message-State: AOAM532Utzpmo3vMaY+wbNPQEuyKKSO+djpra86t9qyOp29krm6s2KyD
        1LHRrpEg1Q/uVfNBJdJBWxzhMA==
X-Google-Smtp-Source: ABdhPJyYXYwGURq1yZHnfDTqkaXcs97dFjtV6DbANICSRNbBufisv7kYcDXYQKfDjTiS6MO6LcChvg==
X-Received: by 2002:a2e:9696:0:b0:24f:22cf:e707 with SMTP id q22-20020a2e9696000000b0024f22cfe707mr3071087lji.15.1652447824465;
        Fri, 13 May 2022 06:17:04 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id u22-20020a2ea176000000b0024f3d1dae8fsm436991ljl.23.2022.05.13.06.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 06:17:04 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Johan Hovold <johan@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v9 08/10] PCI: qcom: Handle MSIs routed to multiple GIC interrupts
Date:   Fri, 13 May 2022 16:16:53 +0300
Message-Id: <20220513131655.2927616-9-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220513131655.2927616-1-dmitry.baryshkov@linaro.org>
References: <20220513131655.2927616-1-dmitry.baryshkov@linaro.org>
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

On some of Qualcomm platforms each group of 32 MSI vectors is routed to the
separate GIC interrupt. Thus, to receive higher MSI vectors properly,
declare that the host should use split MSI IRQ handling on these
platforms.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 2e5464edc36e..deee289a342b 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -194,6 +194,7 @@ struct qcom_pcie_ops {
 
 struct qcom_pcie_cfg {
 	const struct qcom_pcie_ops *ops;
+	unsigned int num_vectors;
 	unsigned int pipe_clk_need_muxing:1;
 	unsigned int has_tbu_clk:1;
 	unsigned int has_ddrss_sf_tbu_clk:1;
@@ -1502,6 +1503,7 @@ static const struct qcom_pcie_cfg ipq8064_cfg = {
 
 static const struct qcom_pcie_cfg msm8996_cfg = {
 	.ops = &ops_2_3_2,
+	.num_vectors = MAX_MSI_IRQS,
 };
 
 static const struct qcom_pcie_cfg ipq8074_cfg = {
@@ -1514,6 +1516,7 @@ static const struct qcom_pcie_cfg ipq4019_cfg = {
 
 static const struct qcom_pcie_cfg sdm845_cfg = {
 	.ops = &ops_2_7_0,
+	.num_vectors = MAX_MSI_IRQS,
 	.has_tbu_clk = true,
 };
 
@@ -1522,16 +1525,19 @@ static const struct qcom_pcie_cfg sm8150_cfg = {
 	 * 1.9.0, so reuse the same.
 	 */
 	.ops = &ops_1_9_0,
+	.num_vectors = MAX_MSI_IRQS,
 };
 
 static const struct qcom_pcie_cfg sm8250_cfg = {
 	.ops = &ops_1_9_0,
+	.num_vectors = MAX_MSI_IRQS,
 	.has_tbu_clk = true,
 	.has_ddrss_sf_tbu_clk = true,
 };
 
 static const struct qcom_pcie_cfg sm8450_pcie0_cfg = {
 	.ops = &ops_1_9_0,
+	.num_vectors = MAX_MSI_IRQS,
 	.has_ddrss_sf_tbu_clk = true,
 	.pipe_clk_need_muxing = true,
 	.has_aggre0_clk = true,
@@ -1540,6 +1546,7 @@ static const struct qcom_pcie_cfg sm8450_pcie0_cfg = {
 
 static const struct qcom_pcie_cfg sm8450_pcie1_cfg = {
 	.ops = &ops_1_9_0,
+	.num_vectors = MAX_MSI_IRQS,
 	.has_ddrss_sf_tbu_clk = true,
 	.pipe_clk_need_muxing = true,
 	.has_aggre1_clk = true,
@@ -1547,6 +1554,7 @@ static const struct qcom_pcie_cfg sm8450_pcie1_cfg = {
 
 static const struct qcom_pcie_cfg sc7280_cfg = {
 	.ops = &ops_1_9_0,
+	.num_vectors = MAX_MSI_IRQS,
 	.has_tbu_clk = true,
 	.pipe_clk_need_muxing = true,
 };
@@ -1592,6 +1600,11 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 
 	pcie->cfg = pcie_cfg;
 
+	if (pcie->cfg->num_vectors) {
+		pp->num_vectors = pcie->cfg->num_vectors;
+		pp->has_split_msi_irq = true;
+	}
+
 	pcie->reset = devm_gpiod_get_optional(dev, "perst", GPIOD_OUT_HIGH);
 	if (IS_ERR(pcie->reset)) {
 		ret = PTR_ERR(pcie->reset);
-- 
2.35.1

