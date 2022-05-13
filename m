Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE82526855
	for <lists+linux-pci@lfdr.de>; Fri, 13 May 2022 19:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382989AbiEMR0d (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 May 2022 13:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382990AbiEMR03 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 May 2022 13:26:29 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462476FD1B
        for <linux-pci@vger.kernel.org>; Fri, 13 May 2022 10:26:28 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id c24so6183426lfv.11
        for <linux-pci@vger.kernel.org>; Fri, 13 May 2022 10:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/4ophsDbiPr806TFQqSTBvrFc8pW6UoHaavUsHfpmAE=;
        b=afOrUPFvW3gqzI5Az36+lfkWn0GQzI63GZNs6K7QqjlJATaSXn2InmBo+l2WWF8BCp
         ta9S6ZnK9SPicp8letbnP+PuECOzyhvqDvEV1+i45K/L0GZT2ckD2orG0d4hA7Fa50ds
         3L5k4KjgRxZxmxptXJj6pjx1wwTY2EF0U/IkDRjeZ0IjVg7T0kFvlvI21gnVAjq95qKj
         azF9XIacDaVJWzL0ufyzrwnfMHqPdD6+Fm/HQcoQwU59ECPUAzcNc29SEu4P911+DRLw
         tGUZjQReK+1YLfY3O07+mAi24/JwFdMSr9qHoJ9F3uO4hwzi4kPqY7URWW+vKIcHM32n
         NMWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/4ophsDbiPr806TFQqSTBvrFc8pW6UoHaavUsHfpmAE=;
        b=h3dKZLeP1X96HqDurNx2BSWWcSR8zwBDTQMSgCzvtCW4WHIzjAFqrHojTIaZCBgT3T
         T6sLnamFHq4IsJR2VSwmtJOyZJmBoPfl2rSCb906if+HL5cFUITffsFCMGxx0PmYMlIr
         xvDDShsNLtqI8UbtZQnP0ydVS72CGRYPdjxx6UmcQpAbgjGjsUQqE3cO1+7wWaVb96/6
         cpBCSlxmBc1afd0G8gUgFgT2hRZa91dA0Zh5cif39aF6gXT9B+MZ+BBqngkHwWOd5EqG
         MZ2jH6NGVcA9xirZdujHu3zN1/9MFaante+DfLmxPE8+WUB8k+ajxhpapZZkgztfRP4M
         ZRYw==
X-Gm-Message-State: AOAM531ZflphmZADb3MecwGUYmxnAzLcQfJ1RYUWtBcCfO04bdqiKeHk
        ftcLcjTWtVJeeCzgik03whqlRQ==
X-Google-Smtp-Source: ABdhPJwODYfhiaGRm5Ha9NwqlSDFEDqTCctQW/Tcamv4dx7h6tKKfybOadofWAKlPE4EjcXpl6WQuQ==
X-Received: by 2002:ac2:5921:0:b0:471:fabe:ad90 with SMTP id v1-20020ac25921000000b00471fabead90mr4248663lfi.496.1652462787745;
        Fri, 13 May 2022 10:26:27 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id e3-20020a2e8183000000b0024f3d1daec0sm511157ljg.72.2022.05.13.10.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 10:26:27 -0700 (PDT)
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
Subject: [PATCH v10 05/10] PCI: dwc: split MSI IRQ parsing/allocation to a separate function
Date:   Fri, 13 May 2022 20:26:17 +0300
Message-Id: <20220513172622.2968887-6-dmitry.baryshkov@linaro.org>
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

Split handling of MSI host IRQs to a separate dw_pcie_msi_host_init()
function. The code is complex enough to warrant a separate function.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../pci/controller/dwc/pcie-designware-host.c | 98 +++++++++++--------
 1 file changed, 56 insertions(+), 42 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 5f6590929319..70f0435907c1 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -288,6 +288,60 @@ static void dw_pcie_msi_init(struct pcie_port *pp)
 	dw_pcie_writel_dbi(pci, PCIE_MSI_ADDR_HI, upper_32_bits(msi_target));
 }
 
+static int dw_pcie_msi_host_init(struct pcie_port *pp)
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
+	for (ctrl = 0; ctrl < num_ctrls; ctrl++)
+		if (pp->msi_irq[ctrl] > 0)
+			irq_set_chained_handler_and_data(pp->msi_irq[ctrl],
+							 dw_chained_msi_isr,
+							 pp);
+
+	ret = dma_set_mask(pci->dev, DMA_BIT_MASK(32));
+	if (ret)
+		dev_warn(pci->dev, "Failed to set DMA mask to 32-bit. Devices with only 32-bit MSI support may not work properly\n");
+
+	pp->msi_data = dma_map_single_attrs(pci->dev, &pp->msi_msg,
+					    sizeof(pp->msi_msg),
+					    DMA_FROM_DEVICE,
+					    DMA_ATTR_SKIP_CPU_SYNC);
+	ret = dma_mapping_error(pci->dev, pp->msi_data);
+	if (ret) {
+		dev_err(pci->dev, "Failed to map MSI data: %d\n", ret);
+		pp->msi_data = 0;
+		dw_pcie_free_msi(pp);
+		return ret;
+	}
+
+	return 0;
+}
+
 int dw_pcie_host_init(struct pcie_port *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -365,49 +419,9 @@ int dw_pcie_host_init(struct pcie_port *pp)
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
-			for (ctrl = 0; ctrl < num_ctrls; ctrl++)
-				if (pp->msi_irq[ctrl] > 0)
-					irq_set_chained_handler_and_data(pp->msi_irq[ctrl],
-									 dw_chained_msi_isr,
-									 pp);
-
-			ret = dma_set_mask(pci->dev, DMA_BIT_MASK(32));
-			if (ret)
-				dev_warn(pci->dev, "Failed to set DMA mask to 32-bit. Devices with only 32-bit MSI support may not work properly\n");
-
-			pp->msi_data = dma_map_single_attrs(pci->dev, &pp->msi_msg,
-						      sizeof(pp->msi_msg),
-						      DMA_FROM_DEVICE,
-						      DMA_ATTR_SKIP_CPU_SYNC);
-			ret = dma_mapping_error(pci->dev, pp->msi_data);
-			if (ret) {
-				dev_err(pci->dev, "Failed to map MSI data: %d\n", ret);
-				pp->msi_data = 0;
-				goto err_free_msi;
-			}
 		}
 	}
 
-- 
2.35.1

