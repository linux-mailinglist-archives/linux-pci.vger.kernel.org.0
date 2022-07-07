Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9446F56A413
	for <lists+linux-pci@lfdr.de>; Thu,  7 Jul 2022 15:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236067AbiGGNrv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Jul 2022 09:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236042AbiGGNrj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Jul 2022 09:47:39 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34041F61F
        for <linux-pci@vger.kernel.org>; Thu,  7 Jul 2022 06:47:37 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id bf9so7984501lfb.13
        for <linux-pci@vger.kernel.org>; Thu, 07 Jul 2022 06:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=knhMJ64tkoEodkSTb3CY5+UKqkKQ5noWd6w/bQ+o2vk=;
        b=AQHxF+XIv2mUcnkA1lZ7hiqORJYC9krDS2/NP5K+BqOEap5rY+HEKuYcYUfZaJl1qc
         oke9B9LKA0Qrhz+9j2LMzliBz4kVLwuH141KHFrYtDHn5zqJtKf5oUNdIHGOSf/naK+Y
         wLBiquhv/kcXyMkLPM4P7IZc4IUzS7A01GfcDiPwoc08BNACuUBNm252xsdyp9LK5zLl
         ZHCleYUu7K2yL5jwNZ8C9B9y8ZFKheauMCmR2B8OSCVrOhOJsatT+3cJsK1Ih0iydQtB
         uhaCRvwBOOOU5FCbDMxBxQyLlgw8cVa3kjTlduYHGLd3PnKCD6xZJQms6+CBSEISKHhy
         1lJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=knhMJ64tkoEodkSTb3CY5+UKqkKQ5noWd6w/bQ+o2vk=;
        b=oShfWtzuM5pFtHUtv0kQdXIFgfV6UpobPNH/6vqZQqXW6eGmuTecYEakWVd9drYUh1
         MDjDu3rkbUR5zGL8KTdyhybIbVYDPcJENxVRhbmdRhR3hhxe4W/3eNueoCdxuFwOPBI8
         AmCr0SkoPInFZ9rsTUZyjaIH6eBABkONhB1C6E7jMhw0nvkvK3yGQEAh5Je1ksN0kB4H
         2mTufhrbDGnKDecK3xihx1jbS9E1g89D0Jx7Qj+aRPm9pOMtx3QCzvBn7stkYMY3TFOf
         kNygArgsErkDaDnA601mnwjdxh4soLzb+pXdFo5kZff6JFUB2vZX8qKHtPbeN0meZjyj
         RTxA==
X-Gm-Message-State: AJIora+eCWBqxSm1UKkeGRnUVI3Gz4aWQlbZV5xLr9AltPdY5V1cUnEF
        MQ40RB8ZCbOVlQ1TWYXntwOC4w==
X-Google-Smtp-Source: AGRyM1szyorY2MmJ/IK9rTNpwH71hzPM8WTwbLdhwEypFVEidfCc3TWRKLSAa8h/Gn+RN2q/dinwOA==
X-Received: by 2002:a05:6512:39d5:b0:47f:6e9a:5bf with SMTP id k21-20020a05651239d500b0047f6e9a05bfmr29910694lfu.580.1657201657260;
        Thu, 07 Jul 2022 06:47:37 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id u22-20020a197916000000b0047fa941067fsm6856966lfc.29.2022.07.07.06.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 06:47:36 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        Johan Hovold <johan@kernel.org>, Rob Herring <robh@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v17 3/6] PCI: dwc: split MSI IRQ parsing/allocation to a separate function
Date:   Thu,  7 Jul 2022 16:47:30 +0300
Message-Id: <20220707134733.2436629-4-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220707134733.2436629-1-dmitry.baryshkov@linaro.org>
References: <20220707134733.2436629-1-dmitry.baryshkov@linaro.org>
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

Split handling of MSI host IRQs to a separate dw_pcie_msi_host_init()
function. The code is complex enough to warrant a separate function.

Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../pci/controller/dwc/pcie-designware-host.c | 103 ++++++++++--------
 1 file changed, 59 insertions(+), 44 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 33fe75a78416..3caac9bc265e 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -290,6 +290,63 @@ static void dw_pcie_msi_init(struct dw_pcie_rp *pp)
 	dw_pcie_writel_dbi(pci, PCIE_MSI_ADDR_HI, upper_32_bits(msi_target));
 }
 
+static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct device *dev = pci->dev;
+	struct platform_device *pdev = to_platform_device(dev);
+	int ret;
+	u32 ctrl, num_ctrls;
+
+	num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
+	for (ctrl = 0; ctrl < num_ctrls; ctrl++)
+		pp->irq_mask[ctrl] = ~0;
+
+	if (!pp->msi_irq[0]) {
+		int irq = platform_get_irq_byname_optional(pdev, "msi");
+
+		if (irq < 0) {
+			irq = platform_get_irq(pdev, 0);
+			if (irq < 0)
+				return irq;
+		}
+		pp->msi_irq[0] = irq;
+	}
+
+	pp->msi_irq_chip = &dw_pci_msi_bottom_irq_chip;
+
+	ret = dw_pcie_allocate_domains(pp);
+	if (ret)
+		return ret;
+
+	for (ctrl = 0; ctrl < num_ctrls; ctrl++) {
+		if (pp->msi_irq[ctrl] > 0)
+			irq_set_chained_handler_and_data(pp->msi_irq[ctrl],
+							 dw_chained_msi_isr,
+							 pp);
+	}
+
+	ret = dma_set_mask(dev, DMA_BIT_MASK(32));
+	if (ret)
+		dev_warn(dev, "Failed to set DMA mask to 32-bit. Devices with only 32-bit MSI support may not work properly\n");
+
+	pp->msi_page = alloc_page(GFP_DMA32);
+	pp->msi_data = dma_map_page(dev, pp->msi_page, 0,
+				    PAGE_SIZE, DMA_FROM_DEVICE);
+	ret = dma_mapping_error(dev, pp->msi_data);
+	if (ret) {
+		dev_err(pci->dev, "Failed to map MSI data\n");
+		__free_page(pp->msi_page);
+		pp->msi_page = NULL;
+		pp->msi_data = 0;
+		dw_pcie_free_msi(pp);
+
+		return ret;
+	}
+
+	return 0;
+}
+
 int dw_pcie_host_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -367,51 +424,9 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 			if (ret < 0)
 				return ret;
 		} else if (pp->has_msi_ctrl) {
-			u32 ctrl, num_ctrls;
-
-			num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
-			for (ctrl = 0; ctrl < num_ctrls; ctrl++)
-				pp->irq_mask[ctrl] = ~0;
-
-			if (!pp->msi_irq[0]) {
-				int irq = platform_get_irq_byname_optional(pdev, "msi");
-
-				if (irq < 0) {
-					irq = platform_get_irq(pdev, 0);
-					if (irq < 0)
-						return irq;
-				}
-				pp->msi_irq[0] = irq;
-			}
-
-			pp->msi_irq_chip = &dw_pci_msi_bottom_irq_chip;
-
-			ret = dw_pcie_allocate_domains(pp);
-			if (ret)
+			ret = dw_pcie_msi_host_init(pp);
+			if (ret < 0)
 				return ret;
-
-			for (ctrl = 0; ctrl < num_ctrls; ctrl++) {
-				if (pp->msi_irq[ctrl] > 0)
-					irq_set_chained_handler_and_data(pp->msi_irq[ctrl],
-									 dw_chained_msi_isr,
-									 pp);
-			}
-
-			ret = dma_set_mask(dev, DMA_BIT_MASK(32));
-			if (ret)
-				dev_warn(dev, "Failed to set DMA mask to 32-bit. Devices with only 32-bit MSI support may not work properly\n");
-
-			pp->msi_page = alloc_page(GFP_DMA32);
-			pp->msi_data = dma_map_page(dev, pp->msi_page, 0,
-						    PAGE_SIZE, DMA_FROM_DEVICE);
-			ret = dma_mapping_error(dev, pp->msi_data);
-			if (ret) {
-				dev_err(pci->dev, "Failed to map MSI data\n");
-				__free_page(pp->msi_page);
-				pp->msi_page = NULL;
-				pp->msi_data = 0;
-				goto err_free_msi;
-			}
 		}
 	}
 
-- 
2.35.1

