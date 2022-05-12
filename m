Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB6F524AA8
	for <lists+linux-pci@lfdr.de>; Thu, 12 May 2022 12:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352819AbiELKq1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 May 2022 06:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352824AbiELKqA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 May 2022 06:46:00 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA30F10FEC
        for <linux-pci@vger.kernel.org>; Thu, 12 May 2022 03:45:53 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id o22so5065005ljp.8
        for <linux-pci@vger.kernel.org>; Thu, 12 May 2022 03:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oohaS0/NrsNdwzWfQDrx5bEWkmIsZz+BGdFzWBg2j1w=;
        b=J9g5Z0bZ539s/uMofYNXZV+yq/DBC8Jqxys7vplojrb9n/P8ttq60p1sFh04X25C8/
         6z86XbCS/JZWGyKsvNxWiMZKUTtGxDItd/lo9f4LznrDJALgQhvcaySPezSzOsr/Q2pp
         2jg1VsRpg6LysgpXTHgsFgh3BKwdjUowePIwa4ueRBiDPY3jtz+S2nPRVl/hDIy+awUM
         sEWu03tS7EcnA+l9vPWs+2xs5ZyV4nscuQfalG8vUN4jQEVwaF6/ma7Cw65UWhS1wJI2
         TKF9NDWQbJlYnmj43r7REPUKKhuYcERpsiET3FbKo2M2a53Yq9SmS8jU5a4nXZtH7048
         1Fwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oohaS0/NrsNdwzWfQDrx5bEWkmIsZz+BGdFzWBg2j1w=;
        b=U5Fmy9fIM8RR8phzVPCJT+6ak4HdsOZjuNMPsTqZur9xjW1sKlLI4JzIQpFaXXt0x4
         dPdFd94QyJkYwrDcS2Tl+zVDMU5IbX+8uiNTJZr993QklrEDvb7vAQGUi5pSiLR/LzwD
         uCc4pwME4ABKX5H2Bc67qDLDmnmDPZzsmBnya9FJRmhBnhF/xSWzGM/Ihd2DrNsXr3JR
         /Ab7X2W9xJ+GJN/YOxEt+e1v38g4uwM5lsEHzLpk/rp9F9msxTZJpeirpNUGhGhlbLg1
         LVTSkKLEXigRhfy2ETgk4btgX6xxFF0ZgWKxVd9zGOp4BGa45WSg7IEu6nz3Z6cxLSOa
         FyFw==
X-Gm-Message-State: AOAM533LiOF19GIME3kChozPkGofqm3nCjd58ZSUxwVGKysDXvtnF7kV
        SS8lu8ZQqhy5ce5X1d7UnddGuw==
X-Google-Smtp-Source: ABdhPJxyJAGexajtWnN7E4JiPN3TBnnlbIZrEVW0WanEbhgdvjWPMjGhTMGOvPdFH/g3FcoTioIk+A==
X-Received: by 2002:a05:651c:399:b0:24f:18d:5bbd with SMTP id e25-20020a05651c039900b0024f018d5bbdmr19623897ljp.481.1652352351687;
        Thu, 12 May 2022 03:45:51 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id q21-20020a2e9695000000b0024f3d1daeafsm831660lji.55.2022.05.12.03.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 03:45:51 -0700 (PDT)
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
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v8 07/10] PCI: qcom: Handle MSIs routed to multiple GIC interrupts
Date:   Thu, 12 May 2022 13:45:42 +0300
Message-Id: <20220512104545.2204523-8-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220512104545.2204523-1-dmitry.baryshkov@linaro.org>
References: <20220512104545.2204523-1-dmitry.baryshkov@linaro.org>
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

