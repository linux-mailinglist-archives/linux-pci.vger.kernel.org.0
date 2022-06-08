Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC93542DC9
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jun 2022 12:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237314AbiFHKat (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jun 2022 06:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238178AbiFHK3z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jun 2022 06:29:55 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50A21952F3
        for <linux-pci@vger.kernel.org>; Wed,  8 Jun 2022 03:22:15 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id y29so22205597ljd.7
        for <linux-pci@vger.kernel.org>; Wed, 08 Jun 2022 03:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PAZRY+9de/r/pRtDdwgg/SxpOS6YpBHgoxmPS8uwmeY=;
        b=bRXPsxn8jK6DstsXeLEpTv79XjGtFN/b+yIy0griFq1V4aggDfXVpLvd/cJCTqnymd
         3DlZBDVZQJktWgvo6NCLVE4DdSXbH5YcIBhBTxphdxgZS1eQBsB0k/t1Xc//60M7omF5
         XlZrCMzd4s/axItdIekwrKOfna6sNguSUCrGc/2HU2jcUZo+zIVJjQ7eCdoQQw6YqmQ4
         l3bJ2kQML4B9zrJDxGUNIrgawcmT2WtSZ/vNO1fEntK7SmfHK4nICcnT9RMTYWrLxiHt
         1L7fFTyNzk0hyqNp6Z4v2NC7h7hRgaqVP4hgt+RslNuyxII5oxg/wt26w41yompGSDI+
         g/Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PAZRY+9de/r/pRtDdwgg/SxpOS6YpBHgoxmPS8uwmeY=;
        b=5ZD0rmr6OyJGSaRXIi6RUGiCE9jsB+rRRMEf+eN94gOTuWHpJv04ImqQXA8AizBvsd
         bDIHFAi8Jo7SPztIKCumrHqDn/JtNqg/8DK6yrZ6mabHDmqipSrDKAbBoRTdd2OApEdw
         Z7R5awU+CepJVXzNkRHIYg4Dy1MkVJM/ioE/24ukWuA9y+jZ9Fnv2jyRH69+7ohjibqD
         DNqAq9DYupzwmi+9I404Plkfno0at0CC41JL0CZ+d07mnaJmj4JiovUW3SjUs+1cUpRf
         j7EhQD6dMeg1DhkvEmAc1OomVHXT6VGicXtHWgYVW7+Sg2IgzGwPNCrj/oWX2Dgr5s/D
         X1cg==
X-Gm-Message-State: AOAM531wNCZSCRA6O0xLz13qfRBLpFMuBCmpAhDuccF2vABpjqQHJi9i
        Xt6Whdhgo7oue8Cbdz+zA3Z0Aw==
X-Google-Smtp-Source: ABdhPJzXjRXru7y049FWjmAalRSo/l4qehPqqPUWUsQ62KGTO0RfO+JmFt2PeclHDP26OdCVJzzyVg==
X-Received: by 2002:a05:651c:101:b0:250:896d:f870 with SMTP id a1-20020a05651c010100b00250896df870mr55894808ljb.235.1654683733975;
        Wed, 08 Jun 2022 03:22:13 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id v1-20020ac25601000000b00478fe3327aasm3642934lfd.217.2022.06.08.03.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 03:22:13 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
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
Subject: [PATCH v14 3/7] PCI: dwc: split MSI IRQ parsing/allocation to a separate function
Date:   Wed,  8 Jun 2022 13:22:04 +0300
Message-Id: <20220608102208.2967438-4-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220608102208.2967438-1-dmitry.baryshkov@linaro.org>
References: <20220608102208.2967438-1-dmitry.baryshkov@linaro.org>
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
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../pci/controller/dwc/pcie-designware-host.c | 100 ++++++++++--------
 1 file changed, 57 insertions(+), 43 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 96b6196f870b..85c1160792e1 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -289,6 +289,61 @@ static void dw_pcie_msi_init(struct pcie_port *pp)
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
+	for (ctrl = 0; ctrl < num_ctrls; ctrl++) {
+		if (pp->msi_irq[ctrl] > 0)
+			irq_set_chained_handler_and_data(pp->msi_irq[ctrl],
+							 dw_chained_msi_isr,
+							 pp);
+	}
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
@@ -366,50 +421,9 @@ int dw_pcie_host_init(struct pcie_port *pp)
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
-				dev_err(pci->dev, "Failed to map MSI data\n");
-				pp->msi_data = 0;
-				goto err_free_msi;
-			}
 		}
 	}
 
-- 
2.35.1

