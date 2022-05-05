Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF1F651C19F
	for <lists+linux-pci@lfdr.de>; Thu,  5 May 2022 15:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380164AbiEEN56 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 May 2022 09:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380179AbiEEN5y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 May 2022 09:57:54 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2EA56FBF
        for <linux-pci@vger.kernel.org>; Thu,  5 May 2022 06:54:12 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id m23so5725353ljc.0
        for <linux-pci@vger.kernel.org>; Thu, 05 May 2022 06:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jGw/lLg9OlqfdvL7cNrU1hBDjhfr/K5voQlMrct/zrg=;
        b=fHR6fYS4NKiYPqmHLQTNxVa8eO1vNs9yW1byIP0uAKXwfMVbM8vDlJ5nVlkYbCSnzp
         ZlaQsjlljMAwK48qKuiyOGVw6psv1tGH96Y7pf8jw1VbRf660yNxBm8B0hkDfB2vqyV6
         uP3dD/iEDcHbVzoQm28srSx7OvZNvPwqMcQFCQNmXdxuUrGX24T6KofGl9ctAuqazG42
         /YGpNeTyzapKHpCJ/u7nImqyvfksvDcwcPOtJEL9UfyLEW0RS0/XSZE5oVmjpHSBCoXi
         KR0UbbqoYLEsbtHD6WRiJp5BLvKSf+CxAS1WcqK46rzhTNJbzBd8HGZxfjTFJ3HF48YH
         zeig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jGw/lLg9OlqfdvL7cNrU1hBDjhfr/K5voQlMrct/zrg=;
        b=fNMvx2caKoWllf3zqI3T41bRk0imIAJ0Gy5rw2A8PicTA24UDDi576Db1sQmaJeZP9
         DW0GTHbh4hdaxN2z1YTBWf9jyB1hE17QqrZOoPL8ouFnXXmjl5PxQReaXi4r7e+W1aeM
         RPQwt9UeoDKsPWou9oSt4iuK4lk/qNScyX3o0Fe5EwkVRHE8cgSdxJhpSF0xdibsbDmM
         w7Ua5ZpzXzTSPZt3N6WUq5Kp/INoNE1P0l8I/d/saUf/NvJK7uDBtYzfA4wOlupa+egx
         qk20/lgPlNKGWrcC+fLq2V7mO9OsLPO9OFVW/uJ74IS+YKn7niEIaMm5jGr0fT7ssL5/
         USLQ==
X-Gm-Message-State: AOAM530s/slQibd5cbUzPwpgpPYuRMTtWdYUztqF1v3rTWhZF0+Inc2e
        O/nDSt/BmxX9t416BbFczk80Zw==
X-Google-Smtp-Source: ABdhPJyWWgwnFW7LtXiL94rJJ/eWWGxJbRdHTP/BNwJoGQwVKXyVepwvJ6pxhpHBCe/BsWAhaQktlA==
X-Received: by 2002:a2e:97c7:0:b0:24f:e5b:21a8 with SMTP id m7-20020a2e97c7000000b0024f0e5b21a8mr16523614ljj.143.1651758851213;
        Thu, 05 May 2022 06:54:11 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id z24-20020ac25df8000000b0047255d211ccsm221788lfq.251.2022.05.05.06.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 06:54:10 -0700 (PDT)
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
Subject: [PATCH v7 4/7] PCI: dwc: Export several functions useful for MSI implentations
Date:   Thu,  5 May 2022 16:54:04 +0300
Message-Id: <20220505135407.1352382-5-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220505135407.1352382-1-dmitry.baryshkov@linaro.org>
References: <20220505135407.1352382-1-dmitry.baryshkov@linaro.org>
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
index 92dcaeabe2bf..b09b7244a558 100644
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
+						 dw_chained_msi_isr,
+						 pp);
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

