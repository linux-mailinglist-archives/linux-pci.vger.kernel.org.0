Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53376515716
	for <lists+linux-pci@lfdr.de>; Fri, 29 Apr 2022 23:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238692AbiD2VqS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Apr 2022 17:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238667AbiD2VqR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Apr 2022 17:46:17 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E841C79395
        for <linux-pci@vger.kernel.org>; Fri, 29 Apr 2022 14:42:55 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id j4so16215788lfh.8
        for <linux-pci@vger.kernel.org>; Fri, 29 Apr 2022 14:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ncVhMJxrohn0+P1cFmOcnIFJEP0t7Z52SvJtNUy/BIs=;
        b=kSx8B5MYfuey4jDbsS/+ZnbpWUK2aYadezjOYORGZO7ZMCnbSzJEx+qjmYl4jCkBTP
         NgcQUoKQh8FUG1ZLnHV6dJM1decZ/GZ9SH76nDJY+TW9r+Qej48E5wXQKcLuRz3c0MxF
         9Mf1YmC2uEoNbARiCHawAfNQmyyyfRelRQrjAprm+w5yg1UpUL+PkFRGKOnAMpIPEsGw
         H2gXXniOUJ3bb7sQfc/7Am/RExBpGuyPDp7ZPG5mYxNMV/T+vnKdjjh51PaUVTGrXEOz
         plx9CPa+pufDSZd+YBIgHSPbbks5NO2WSl4+h5kOBzNI/jMLKbO7xX1pESblv73aJdEW
         27sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ncVhMJxrohn0+P1cFmOcnIFJEP0t7Z52SvJtNUy/BIs=;
        b=qK3zu8jH3ILem2Gmu0uc26gln26xFBgLKLGJuJzD7gdfDkj86yKE1F0aowsYWu7aHZ
         eQk0X2/oRz8feGappkZzFSohFFrL+EKTmUQ1VYdAfqh8rQ3fm4r0wvGCY+sGlLLDkdem
         BpKlX9AhB2M0OXZv9Djnbi8MaWpOus5OAqINq+rJPVR12Pz0qzUSKiYnV/YzOX17cszB
         C8+5GICIQxzmdo7r7WkOxVeVYRUznu/QG1aR4x1H289eQingrZZhWxmtj57TsEeCivbM
         dLGp8AKtOer99qU7cvbVTs1/nlqGjHR/OJ4n2qV61Xv/diOfQRsMqqvkkT6nuo0KuaW0
         5f1A==
X-Gm-Message-State: AOAM531oGD4Z9bgP3O+NO89lorpEV9yhs8t5t3a9WI6T11P6Muqx0NF2
        SbKE7p3QnAGuBFk2q6oezahmSg==
X-Google-Smtp-Source: ABdhPJzkBzz2G5DWzhONhXDruSg7+Bk4LQdmYe9bzBfn6j9UQ2ibE3/hmIHstMCJACe4hozziai3YA==
X-Received: by 2002:ac2:4ac9:0:b0:471:f6da:640d with SMTP id m9-20020ac24ac9000000b00471f6da640dmr900074lfp.286.1651268574342;
        Fri, 29 Apr 2022 14:42:54 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id g4-20020a19ac04000000b0047255d211f6sm30520lfc.293.2022.04.29.14.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 14:42:54 -0700 (PDT)
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
Subject: [PATCH v5 4/7] PCI: dwc: Export several functions useful for MSI implentations
Date:   Sat, 30 Apr 2022 00:42:47 +0300
Message-Id: <20220429214250.3728510-5-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429214250.3728510-1-dmitry.baryshkov@linaro.org>
References: <20220429214250.3728510-1-dmitry.baryshkov@linaro.org>
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

