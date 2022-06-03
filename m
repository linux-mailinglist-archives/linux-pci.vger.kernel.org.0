Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A55F153C681
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jun 2022 09:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242629AbiFCHlp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Jun 2022 03:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242620AbiFCHlo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Jun 2022 03:41:44 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326CD37037
        for <linux-pci@vger.kernel.org>; Fri,  3 Jun 2022 00:41:43 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id g25so7581804ljm.2
        for <linux-pci@vger.kernel.org>; Fri, 03 Jun 2022 00:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PAZRY+9de/r/pRtDdwgg/SxpOS6YpBHgoxmPS8uwmeY=;
        b=kU2crjgCux7+h5UB0tWc0ZhC86cgBd/dRVyh+JBH0dzKQl/AoYPI/8yUUDGFZUMIBF
         SxSc6dGM/qRKTdDAc+wwjlK+pg1g/b8+i+cPqgim2vtcUce9CpvwERsOvMNJJ1iPyoLS
         coNHHJkYhFZeJe61R6rPdYFjm2NpkwaB3sBTlbVXq08nHWUOmclZdUetMyIgX8jAhAwW
         vJw+NJ3NKVSmrOsOEoafZFjMsuXSf4Ojbc+qZKZEvHutyCnrKgopTtkPlzL0izB/xGot
         zNdr6l+Mvm3KnhJzlfBxY/PSU3JKyHptiYqFHOwY4ki/mvPQeSfme2DykZAQ7e6gn+5z
         gfKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PAZRY+9de/r/pRtDdwgg/SxpOS6YpBHgoxmPS8uwmeY=;
        b=v1JpuGBEwIWY5tu0lw066DKZwx2GsA1DRnqIR9BunfsNCM6yKf/uMT+2g3bkC6aHvn
         trD3p1ULRXhlcSKf1TQZS7VG74udn6FrrY9m8iOW+dA/7AtFo1xCWz16NzamiumaHE7a
         z+1mi4BI36eVjSsxkZCaJ8oBPFUUBRanrD9IKcf/mPZUJlbbOsaefbRwMP0n5q4HOU7u
         skUX5veYF5aHT06oCwGEAPtvkO7LbQkg9J96zdtdPGnSbF4iOzZGoIKmTjlQYuTdPPdJ
         uxT2HqRXmQGxWyw13WTDcxrQ/keeVhZ7iMT4w8TPyynllJzztt0xgTz5NWDL06VtdcZF
         BjHw==
X-Gm-Message-State: AOAM530tok9dyboy7cTnkxN/YLbTqTQ2b8WxxoeswSRe2wktsyR6zBnH
        w7I5eRv/MuKZKq5A2/mRl4N8Pw==
X-Google-Smtp-Source: ABdhPJzsEuEd+AgEbOyORQRA+Jggbv0g8/4mru3WmPcMFJ7tHomWA4bT2BbN9Vp3mUIW9DzNRdvZQA==
X-Received: by 2002:a2e:a5ca:0:b0:253:c604:647c with SMTP id n10-20020a2ea5ca000000b00253c604647cmr44525871ljp.403.1654242101550;
        Fri, 03 Jun 2022 00:41:41 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id x6-20020ac24886000000b00477b11144e9sm1450023lfc.66.2022.06.03.00.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 00:41:41 -0700 (PDT)
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
Subject: [PATCH v13 3/7] PCI: dwc: split MSI IRQ parsing/allocation to a separate function
Date:   Fri,  3 Jun 2022 10:41:33 +0300
Message-Id: <20220603074137.1849892-4-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220603074137.1849892-1-dmitry.baryshkov@linaro.org>
References: <20220603074137.1849892-1-dmitry.baryshkov@linaro.org>
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

