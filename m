Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8515659D3
	for <lists+linux-pci@lfdr.de>; Mon,  4 Jul 2022 17:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234106AbiGDP2J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Jul 2022 11:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234188AbiGDP1y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Jul 2022 11:27:54 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D02F580
        for <linux-pci@vger.kernel.org>; Mon,  4 Jul 2022 08:27:51 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id j21so16403690lfe.1
        for <linux-pci@vger.kernel.org>; Mon, 04 Jul 2022 08:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y02pUzaIb4vWAuHWJrfEhGoFcBGtFsnOoH2dr3h2e/c=;
        b=RADDo9oz2yYxYzwcI+l/XVSnfHGHouq7bPNm4JtM58qS5Zw5Ee/bi2YYEekk3zNlYV
         1oNVtQDwSiOeoqgd3FXyuhOBTHbYJ1yeq/1WsJ2cLrlixm/TRfip9SUwS39XOtX/O2QK
         JCa2TVFDI0kAeajcljJ2YeeCnzhQnDV1YX5XEJZthhEGLwbTxwMw1WjbTveJa2MqT73T
         xwYOfTcSNroEU3Z9a0C8k8uQMPKmVG6PeOFCaFeCJPREj8tYLlV5EN3K18gswsr9FzI8
         sQJ7Mx51mC221Ec9FE9FHorSPSInaTuyaHiRYwHUYbXnhttbyE6pKHRN/v6KRC6whQiV
         gdUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y02pUzaIb4vWAuHWJrfEhGoFcBGtFsnOoH2dr3h2e/c=;
        b=2FBzjZhLAcP9RTT++BB0ioPnlyToEXtfjCrpz+0gA0+1DW3Wf3bEBMqyJa4ys91qIv
         M5G0H9KHLfffTW/9BScEGES2bTFgIIx2kr/w1Ra+60olx364F1M9rx43Lsr4WtNc8CXR
         Yok5ejQeyXBkIqrUiacF+vrYRz5+8beVoT/5lY55Th4WiiEryXulLIFYwR8Aqbl/Msuv
         tFuyL0X1GqMIoEwm19JyRWl2pXv2mixaOfsshFR3nlzE4ZxD2uHHNnR1YZW1kbY51ZIx
         sf2ob2Jj/YkS3RGc6ZNzmWjv2Xk50XmcEOFaxSLh0eFnTwkedjVZgQDlpOfb1GWsSQJk
         C40Q==
X-Gm-Message-State: AJIora9e1OObwPJxm8KZxEeak7eKAjo5nchUgWrzSC6azA0J7mLQc5qO
        tC7nWv37Qo+dzuHpR/vZjs0G4g==
X-Google-Smtp-Source: AGRyM1sRtunOzOc702ZgyS9egEBzllJSY+uvqPl1hLzS0zf37PJBO8rgG5Kq9FyTwJloeR6NcArNLQ==
X-Received: by 2002:a19:650b:0:b0:47f:7dd0:5ec6 with SMTP id z11-20020a19650b000000b0047f7dd05ec6mr18686111lfb.149.1656948469950;
        Mon, 04 Jul 2022 08:27:49 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id h14-20020a056512220e00b004786eb19049sm5175820lfu.24.2022.07.04.08.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 08:27:49 -0700 (PDT)
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
Subject: [PATCH v16 3/6] PCI: dwc: split MSI IRQ parsing/allocation to a separate function
Date:   Mon,  4 Jul 2022 18:27:43 +0300
Message-Id: <20220704152746.807550-4-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220704152746.807550-1-dmitry.baryshkov@linaro.org>
References: <20220704152746.807550-1-dmitry.baryshkov@linaro.org>
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

Split handling of MSI host IRQs to a separate dw_pcie_msi_host_init()
function. The code is complex enough to warrant a separate function.

Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../pci/controller/dwc/pcie-designware-host.c | 101 ++++++++++--------
 1 file changed, 57 insertions(+), 44 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 4c5b3f70ab17..3ba531da99d4 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -290,6 +290,61 @@ static void dw_pcie_msi_init(struct pcie_port *pp)
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
+	pp->msi_page = alloc_page(GFP_DMA32);
+	pp->msi_data = dma_map_page(pci->dev, pp->msi_page, 0,
+						    PAGE_SIZE, DMA_FROM_DEVICE);
+	ret = dma_mapping_error(pci->dev, pp->msi_data);
+	if (ret) {
+		dev_err(pci->dev, "Failed to map MSI data\n");
+		pp->msi_page = NULL;
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
@@ -367,51 +422,9 @@ int dw_pcie_host_init(struct pcie_port *pp)
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
-			pp->msi_page = alloc_page(GFP_DMA32);
-			pp->msi_data = dma_map_page(pci->dev, pp->msi_page, 0,
-						    PAGE_SIZE, DMA_FROM_DEVICE);
-			ret = dma_mapping_error(pci->dev, pp->msi_data);
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

