Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA7D51BB97
	for <lists+linux-pci@lfdr.de>; Thu,  5 May 2022 11:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351904AbiEEJQR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 May 2022 05:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351912AbiEEJQQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 May 2022 05:16:16 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94AE54BFF7
        for <linux-pci@vger.kernel.org>; Thu,  5 May 2022 02:12:36 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id w1so6445935lfa.4
        for <linux-pci@vger.kernel.org>; Thu, 05 May 2022 02:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ncVhMJxrohn0+P1cFmOcnIFJEP0t7Z52SvJtNUy/BIs=;
        b=ER2VTsvOq2LCrjduxIUhbMKGiBJEGvyC5Wu3W99lakjPL70aD4wsw/EiXe84rguaUd
         g/e6q3E1abhNoijcXiRLzDyGKfUZkJtYFsTJ+djpv7Z49y7LFjMkDwFXN0/EKgmko93c
         RYWDdRauscaPgykwRZijCF4ZmAbhRtyZJ9C3NkoubBtIKptg76c4FjPjtmAEMAwDYLYz
         G45WHyU2Reigo6y2ZptjbcQGi/mZPQ/6yGJ/ZRUSETFNbf37WvGBK2f8jaRjor5XV+jJ
         GGei8p26qXpxnGeQ9zkr7OXWDHbrwSibpUGeS34ybXRX0FHCM1IqF8U7C7Q4Ssok1k8g
         YObw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ncVhMJxrohn0+P1cFmOcnIFJEP0t7Z52SvJtNUy/BIs=;
        b=UJp8MuTR94lR/fQrtvZIakvsLJLLGIZuRGhc/b5JvLiLRY2kCqN3Rc9Beus9LBS7B4
         viCFRghuKnfGlCF8p0VDadWKgbQE7qEQprg01M7vT+KDsfKn4smw52i84FCohYy7SyPA
         ojEzNlLEMpahBqy6O2dzbfnwiTlRaBIG2reBAmjULl7kxuqNpiOF5bWogQWwGQk9cgyf
         2Ji2zyiOhSHp5rm9UZHFErNag2yb6cyQw7TVZsUODm/vhRD5x2wNXnWKkaqjkb9df2/v
         EOZy2SpdHz6BTKr7teactk54mLZE+aBiouNRK2GHts53TSa0ZvqXWYFjyiVnVa6d8RMV
         +HEg==
X-Gm-Message-State: AOAM530s+Xse+wAp8BKuDvfH4hAw/WpT1pSrlQ+GQy4f1I0PMUA7FKyg
        AteHYEZ5yHrF1nwD0gEXK/PbRNue4GUYQg==
X-Google-Smtp-Source: ABdhPJz0OE5hEfPUlrdgJDuB9wb0bPV6T5/O0LJr4MVJk64hHCsgA0akUPwfOg8XtmlQf6LLdQDvvw==
X-Received: by 2002:a05:6512:3982:b0:473:ac4e:8a14 with SMTP id j2-20020a056512398200b00473ac4e8a14mr7326702lfu.73.1651741954880;
        Thu, 05 May 2022 02:12:34 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id v26-20020ac2593a000000b0047255d211e8sm133564lfi.279.2022.05.05.02.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 02:12:34 -0700 (PDT)
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
Subject: [PATCH v6 4/7] PCI: dwc: Export several functions useful for MSI implentations
Date:   Thu,  5 May 2022 12:12:28 +0300
Message-Id: <20220505091231.1308963-5-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220505091231.1308963-1-dmitry.baryshkov@linaro.org>
References: <20220505091231.1308963-1-dmitry.baryshkov@linaro.org>
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

Supporting multiple MSI interrupts on Qualcomm hardware would benefit
from having these functions being exported rather than static. Note that
both designware and qcom driver can not be built as modules, so no need
to use EXPORT_SYMBOL here.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../pci/controller/dwc/pcie-designware-host.c | 62 ++++++++++++-------
 drivers/pci/controller/dwc/pcie-designware.h  | 11 ++++
 2 files changed, 49 insertions(+), 24 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 92dcaeabe2bf..c3b8ab278a00 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -255,7 +255,39 @@ int dw_pcie_allocate_domains(struct pcie_port *pp)
 	return 0;
 }
 
-static void dw_pcie_free_msi(struct pcie_port *pp)
+int dw_pcie_allocate_msi(struct pcie_port *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	int ret;
+
+	ret = dw_pcie_allocate_domains(pp);
+	if (ret)
+		return ret;
+
+	if (pp->msi_irq > 0)
+		irq_set_chained_handler_and_data(pp->msi_irq,
+				dw_chained_msi_isr,
+				pp);
+
+	ret = dma_set_mask(pci->dev, DMA_BIT_MASK(32));
+	if (ret)
+		dev_warn(pci->dev, "Failed to set DMA mask to 32-bit. Devices with only 32-bit MSI support may not work properly\n");
+
+	pp->msi_data = dma_map_single_attrs(pci->dev, &pp->msi_msg,
+			sizeof(pp->msi_msg),
+			DMA_FROM_DEVICE,
+			DMA_ATTR_SKIP_CPU_SYNC);
+	ret = dma_mapping_error(pci->dev, pp->msi_data);
+	if (ret) {
+		dev_err(pci->dev, "Failed to map MSI data\n");
+		pp->msi_data = 0;
+		return ret;
+	}
+
+	return 0;
+}
+
+void dw_pcie_free_msi(struct pcie_port *pp)
 {
 	if (pp->msi_irq > 0)
 		irq_set_chained_handler_and_data(pp->msi_irq, NULL, NULL);
@@ -357,6 +389,9 @@ int dw_pcie_host_init(struct pcie_port *pp)
 			return -EINVAL;
 		}
 
+		/* this can be overridden by msi_host_init() if necessary */
+		pp->msi_irq_chip = &dw_pci_msi_bottom_irq_chip;
+
 		if (pp->ops->msi_host_init) {
 			ret = pp->ops->msi_host_init(pp);
 			if (ret < 0)
@@ -377,30 +412,9 @@ int dw_pcie_host_init(struct pcie_port *pp)
 				}
 			}
 
-			pp->msi_irq_chip = &dw_pci_msi_bottom_irq_chip;
-
-			ret = dw_pcie_allocate_domains(pp);
-			if (ret)
+			ret = dw_pcie_allocate_msi(pp);
+			if (ret < 0)
 				return ret;
-
-			if (pp->msi_irq > 0)
-				irq_set_chained_handler_and_data(pp->msi_irq,
-							    dw_chained_msi_isr,
-							    pp);
-
-			ret = dma_set_mask(pci->dev, DMA_BIT_MASK(32));
-			if (ret)
-				dev_warn(pci->dev, "Failed to set DMA mask to 32-bit. Devices with only 32-bit MSI support may not work properly\n");
-
-			pp->msi_data = dma_map_single_attrs(pci->dev, &pp->msi_msg,
-						      sizeof(pp->msi_msg),
-						      DMA_FROM_DEVICE,
-						      DMA_ATTR_SKIP_CPU_SYNC);
-			if (dma_mapping_error(pci->dev, pp->msi_data)) {
-				dev_err(pci->dev, "Failed to map MSI data\n");
-				pp->msi_data = 0;
-				goto err_free_msi;
-			}
 		}
 	}
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index e1c48b71e0d2..f72447f15dc5 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -374,6 +374,8 @@ void dw_pcie_host_deinit(struct pcie_port *pp);
 int dw_pcie_allocate_domains(struct pcie_port *pp);
 void __iomem *dw_pcie_own_conf_map_bus(struct pci_bus *bus, unsigned int devfn,
 				       int where);
+int dw_pcie_allocate_msi(struct pcie_port *pp);
+void dw_pcie_free_msi(struct pcie_port *pp);
 #else
 static inline irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
 {
@@ -403,6 +405,15 @@ static inline void __iomem *dw_pcie_own_conf_map_bus(struct pci_bus *bus,
 {
 	return NULL;
 }
+
+static int dw_pcie_allocate_msi(struct pcie_port *pp)
+{
+	return -EINVAL;
+}
+
+static void dw_pcie_free_msi(struct pcie_port *pp)
+{
+}
 #endif
 
 #ifdef CONFIG_PCIE_DW_EP
-- 
2.35.1

