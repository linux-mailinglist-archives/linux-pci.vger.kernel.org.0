Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8083C526858
	for <lists+linux-pci@lfdr.de>; Fri, 13 May 2022 19:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383067AbiEMR0p (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 May 2022 13:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383013AbiEMR0l (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 May 2022 13:26:41 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C277A6FD1B
        for <linux-pci@vger.kernel.org>; Fri, 13 May 2022 10:26:30 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id f4so2836401lfu.12
        for <linux-pci@vger.kernel.org>; Fri, 13 May 2022 10:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oohaS0/NrsNdwzWfQDrx5bEWkmIsZz+BGdFzWBg2j1w=;
        b=tH7awqmpg+h0ccW1Yb68p2X6rPqmilnWqvDcdKGQLh+sRudlHyDKuPz1/FWO9FBBTb
         kfqStZdfyyYhjBJYBMrhSly0bVp0GBBhiw+EOxpXuRXTXRFgC7JR5KPfUr+siHP+bmSh
         g+Og1L67OyyBMDsiaNp2HNzXzRLNjtgFBffRKAQ+G4Sq+MJMmU0k+L3LAbid4CuUfmt+
         lVo9Q7Z/HnmKkmwKKSh8EJm5NuU3RGNBtVn49OozbjJ4Sm2ICuhrE96aA1ct8vXrhAQp
         IJJh4ygqjDKri/awnRH+ytVT4HQl0oUIMkOOtb7wAd+erkhzzI7KesDrUlKgJExRIB9g
         Rkaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oohaS0/NrsNdwzWfQDrx5bEWkmIsZz+BGdFzWBg2j1w=;
        b=a68090iZOrGOh11AHRzAcyfcKYEqXrqG4AZZoxWo8vduh5AQE7EVik+Jdrc6+h26Kr
         6JPPZ5iNCUzMAiZ+wh2sspplAKZICiHw63aRu0QTU3Yh7xbAeW4ndIYWUA0FpiNo6qLl
         mkojcJiK1mqJKm7jpasnHAxaGk7GdG/isA+6AIflC3Y6f5BlZ3lYMERa8Gpb7g4jsyRr
         pH9yi61A/0zTRcSN41ZKzzAxHOYNznZZ29iki4TJTuH/UYuLWsE/rlgeEn9JEgM4TrM1
         rWPS2YJ7HwBilOU11a26VXCoCn3SQY1kdRmCvD6VZbZfqpxIDwCVVi6NGhPQkax2iX49
         RhDQ==
X-Gm-Message-State: AOAM531+pooiFNfDiRBcE5BlUTJjbwpzGDlh8yVYZrYLEQ1KgybJA6yn
        nVr6rQn5etrolvQziIKlqLljyA==
X-Google-Smtp-Source: ABdhPJyDBAI+cQ53MLt1ErzLUG3k60J87bOhZ8vGuxwPA9BVDDrEn7pQQmhKRj7bfMvCPIaTiOMpWw==
X-Received: by 2002:a19:770d:0:b0:476:4a1d:286b with SMTP id s13-20020a19770d000000b004764a1d286bmr2956314lfc.88.1652462790318;
        Fri, 13 May 2022 10:26:30 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id e3-20020a2e8183000000b0024f3d1daec0sm511157ljg.72.2022.05.13.10.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 10:26:29 -0700 (PDT)
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
Subject: [PATCH v10 08/10] PCI: qcom: Handle MSIs routed to multiple GIC interrupts
Date:   Fri, 13 May 2022 20:26:20 +0300
Message-Id: <20220513172622.2968887-9-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220513172622.2968887-1-dmitry.baryshkov@linaro.org>
References: <20220513172622.2968887-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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
 drivers/pci/controller/dwc/pcie-qcom.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 2e5464edc36e..f79752d1d680 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -194,6 +194,7 @@ struct qcom_pcie_ops {
 
 struct qcom_pcie_cfg {
 	const struct qcom_pcie_ops *ops;
+	unsigned int has_split_msi_irq:1;
 	unsigned int pipe_clk_need_muxing:1;
 	unsigned int has_tbu_clk:1;
 	unsigned int has_ddrss_sf_tbu_clk:1;
@@ -1502,6 +1503,7 @@ static const struct qcom_pcie_cfg ipq8064_cfg = {
 
 static const struct qcom_pcie_cfg msm8996_cfg = {
 	.ops = &ops_2_3_2,
+	.has_split_msi_irq = true,
 };
 
 static const struct qcom_pcie_cfg ipq8074_cfg = {
@@ -1514,6 +1516,7 @@ static const struct qcom_pcie_cfg ipq4019_cfg = {
 
 static const struct qcom_pcie_cfg sdm845_cfg = {
 	.ops = &ops_2_7_0,
+	.has_split_msi_irq = true,
 	.has_tbu_clk = true,
 };
 
@@ -1526,12 +1529,14 @@ static const struct qcom_pcie_cfg sm8150_cfg = {
 
 static const struct qcom_pcie_cfg sm8250_cfg = {
 	.ops = &ops_1_9_0,
+	.has_split_msi_irq = true,
 	.has_tbu_clk = true,
 	.has_ddrss_sf_tbu_clk = true,
 };
 
 static const struct qcom_pcie_cfg sm8450_pcie0_cfg = {
 	.ops = &ops_1_9_0,
+	.has_split_msi_irq = true,
 	.has_ddrss_sf_tbu_clk = true,
 	.pipe_clk_need_muxing = true,
 	.has_aggre0_clk = true,
@@ -1540,6 +1545,7 @@ static const struct qcom_pcie_cfg sm8450_pcie0_cfg = {
 
 static const struct qcom_pcie_cfg sm8450_pcie1_cfg = {
 	.ops = &ops_1_9_0,
+	.has_split_msi_irq = true,
 	.has_ddrss_sf_tbu_clk = true,
 	.pipe_clk_need_muxing = true,
 	.has_aggre1_clk = true,
@@ -1547,6 +1553,7 @@ static const struct qcom_pcie_cfg sm8450_pcie1_cfg = {
 
 static const struct qcom_pcie_cfg sc7280_cfg = {
 	.ops = &ops_1_9_0,
+	.has_split_msi_irq = true,
 	.has_tbu_clk = true,
 	.pipe_clk_need_muxing = true,
 };
@@ -1592,6 +1599,11 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 
 	pcie->cfg = pcie_cfg;
 
+	if (pcie->cfg->has_split_msi_irq) {
+		pp->num_vectors = MAX_MSI_IRQS;
+		pp->has_split_msi_irq = true;
+	}
+
 	pcie->reset = devm_gpiod_get_optional(dev, "perst", GPIOD_OUT_HIGH);
 	if (IS_ERR(pcie->reset)) {
 		ret = PTR_ERR(pcie->reset);
-- 
2.35.1

