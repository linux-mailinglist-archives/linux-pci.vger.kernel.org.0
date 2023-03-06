Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B301D6AC558
	for <lists+linux-pci@lfdr.de>; Mon,  6 Mar 2023 16:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjCFPeh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Mar 2023 10:34:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbjCFPeU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Mar 2023 10:34:20 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9E7AD00
        for <linux-pci@vger.kernel.org>; Mon,  6 Mar 2023 07:33:43 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id n6so10787026plf.5
        for <linux-pci@vger.kernel.org>; Mon, 06 Mar 2023 07:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678116819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FSZTsxFvrcK51n2zirybFkKL1X1N/PtWqccn7VlsBoE=;
        b=CMF2lbQmJRo/nSmptNkmWK25ase0/6LStx4Q+kyliXRBjgF8nMVTfzYXz5xRwHy+Uv
         s+3dRUyQXoGOMT/psC+HQXqSQhG9talllgrxQD+Pnsuk4fPpHoJit7axA7AvnkB8btqk
         meyPqkjSgSQUrdMta+uFqNIbTvTXqJmPa13TztxaJWrSjFHQK/nEpyvbKStVlm42ieNM
         qn62Q4fQgXauS6szDyp+a6ckwa9dMilh4FrY9G/czNTeMtZtFReH8VaQmCi1KiUa3uFV
         wL/hqCcj4DM+qlvfnZ//SIAmRixAbI2MI9Iotny/xoGllPvYPbQEB+0iTg5XBQIaVkrS
         65yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678116819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FSZTsxFvrcK51n2zirybFkKL1X1N/PtWqccn7VlsBoE=;
        b=CCmfftWIggw9T4kFIrqmGlU9xc2eDTvCB8RebohV1C6tOw74gcSxDHa4uUfYgOVNck
         PsuBmtNgEYUt/sIQy6QqJIinP+rxefXySGqnMb/0Cgd/uvl7UmdWxrDrF/smRSTWFKgx
         Oxka6EXRq9T67IQgLOi5evANDWL5N6T3gYX4wOp7166KsRrrKDQZwcCyroMpAaYQTPeG
         P664tZOMT5Rx4GnQHPUVY7XyAs71xPSSHeagjw2m+QwlKpUHFSnH1usniDUt6XeEDzkf
         b2nI+EDXzyXQviFi6Z8/XnJXEs/LRwpfx3/aDn4XAS0JOr/e69bCS0Ni2P+0YkeVvJds
         ra5Q==
X-Gm-Message-State: AO0yUKVTH26EoEzuuzDWbuerFg3nCnsbyUXhFE1HKJXkmcrYvo2uIM2A
        MaLSjT57fedH4FTNrON57adf
X-Google-Smtp-Source: AK7set82IVvmz55x2cDlnkyaJV0+PnXaPQyULxNMeE+2vqBXVrH5YGgrlSTA2fAZcnEoKeHTkfXNCw==
X-Received: by 2002:a17:903:2290:b0:19e:25b4:7740 with SMTP id b16-20020a170903229000b0019e25b47740mr13907805plh.28.1678116819521;
        Mon, 06 Mar 2023 07:33:39 -0800 (PST)
Received: from localhost.localdomain ([59.97.52.140])
        by smtp.gmail.com with ESMTPSA id kl4-20020a170903074400b0019a7c890c61sm6837430plb.252.2023.03.06.07.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 07:33:39 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, lpieralisi@kernel.org, kw@linux.com,
        krzysztof.kozlowski+dt@linaro.org, robh@kernel.org
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 14/19] PCI: qcom-ep: Rename "mmio" region to "mhi"
Date:   Mon,  6 Mar 2023 21:02:17 +0530
Message-Id: <20230306153222.157667-15-manivannan.sadhasivam@linaro.org>
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

As per Qualcomm's internal documentation, the name of the region is "mhi"
and not "mmio". So let's rename it to follow the convention.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 38 +++++++++++------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 19b32839ea26..a4983d3844f7 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -147,9 +147,9 @@ enum qcom_pcie_ep_link_status {
  * @pci: Designware PCIe controller struct
  * @parf: Qualcomm PCIe specific PARF register base
  * @elbi: Designware PCIe specific ELBI register base
- * @mmio: MMIO register base
+ * @mhi: MHI register base
  * @perst_map: PERST regmap
- * @mmio_res: MMIO region resource
+ * @mhi_res: MHI region resource
  * @core_reset: PCIe Endpoint core reset
  * @reset: PERST# GPIO
  * @wake: WAKE# GPIO
@@ -168,9 +168,9 @@ struct qcom_pcie_ep {
 
 	void __iomem *parf;
 	void __iomem *elbi;
-	void __iomem *mmio;
+	void __iomem *mhi;
 	struct regmap *perst_map;
-	struct resource *mmio_res;
+	struct resource *mhi_res;
 
 	struct reset_control *core_reset;
 	struct gpio_desc *reset;
@@ -405,10 +405,10 @@ static int qcom_pcie_perst_deassert(struct dw_pcie *pci)
 	}
 
 	/*
-	 * The physical address of the MMIO region which is exposed as the BAR
-	 * should be written to MHI BASE registers.
+	 * The physical address of the MHI region which is exposed as the BAR
+	 * should be written to PARF_MHI_BASE registers.
 	 */
-	writel_relaxed(pcie_ep->mmio_res->start,
+	writel_relaxed(pcie_ep->mhi_res->start,
 		       pcie_ep->parf + PARF_MHI_BASE_ADDR_LOWER);
 	writel_relaxed(0, pcie_ep->parf + PARF_MHI_BASE_ADDR_UPPER);
 
@@ -477,16 +477,16 @@ static int qcom_pcie_ep_get_io_resources(struct platform_device *pdev,
 	if (IS_ERR(pcie_ep->elbi))
 		return PTR_ERR(pcie_ep->elbi);
 
-	pcie_ep->mmio_res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
-							 "mmio");
-	if (!pcie_ep->mmio_res) {
-		dev_err(dev, "Failed to get mmio resource\n");
+	pcie_ep->mhi_res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
+							 "mhi");
+	if (!pcie_ep->mhi_res) {
+		dev_err(dev, "Failed to get mhi resource\n");
 		return -EINVAL;
 	}
 
-	pcie_ep->mmio = devm_pci_remap_cfg_resource(dev, pcie_ep->mmio_res);
-	if (IS_ERR(pcie_ep->mmio))
-		return PTR_ERR(pcie_ep->mmio);
+	pcie_ep->mhi = devm_pci_remap_cfg_resource(dev, pcie_ep->mhi_res);
+	if (IS_ERR(pcie_ep->mhi))
+		return PTR_ERR(pcie_ep->mhi);
 
 	syscon = of_parse_phandle(dev->of_node, "qcom,perst-regs", 0);
 	if (!syscon) {
@@ -674,19 +674,19 @@ static int qcom_pcie_ep_link_transition_count(struct seq_file *s, void *data)
 				     dev_get_drvdata(s->private);
 
 	seq_printf(s, "L0s transition count: %u\n",
-		   readl_relaxed(pcie_ep->mmio + PARF_DEBUG_CNT_PM_LINKST_IN_L0S));
+		   readl_relaxed(pcie_ep->mhi + PARF_DEBUG_CNT_PM_LINKST_IN_L0S));
 
 	seq_printf(s, "L1 transition count: %u\n",
-		   readl_relaxed(pcie_ep->mmio + PARF_DEBUG_CNT_PM_LINKST_IN_L1));
+		   readl_relaxed(pcie_ep->mhi + PARF_DEBUG_CNT_PM_LINKST_IN_L1));
 
 	seq_printf(s, "L1.1 transition count: %u\n",
-		   readl_relaxed(pcie_ep->mmio + PARF_DEBUG_CNT_AUX_CLK_IN_L1SUB_L1));
+		   readl_relaxed(pcie_ep->mhi + PARF_DEBUG_CNT_AUX_CLK_IN_L1SUB_L1));
 
 	seq_printf(s, "L1.2 transition count: %u\n",
-		   readl_relaxed(pcie_ep->mmio + PARF_DEBUG_CNT_AUX_CLK_IN_L1SUB_L2));
+		   readl_relaxed(pcie_ep->mhi + PARF_DEBUG_CNT_AUX_CLK_IN_L1SUB_L2));
 
 	seq_printf(s, "L2 transition count: %u\n",
-		   readl_relaxed(pcie_ep->mmio + PARF_DEBUG_CNT_PM_LINKST_IN_L2));
+		   readl_relaxed(pcie_ep->mhi + PARF_DEBUG_CNT_PM_LINKST_IN_L2));
 
 	return 0;
 }
-- 
2.25.1

