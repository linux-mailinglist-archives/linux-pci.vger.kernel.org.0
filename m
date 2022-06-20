Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E09A551738
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jun 2022 13:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241485AbiFTLU0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Jun 2022 07:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240851AbiFTLUZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Jun 2022 07:20:25 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B07713EA9
        for <linux-pci@vger.kernel.org>; Mon, 20 Jun 2022 04:20:24 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id j22so4905191ljg.0
        for <linux-pci@vger.kernel.org>; Mon, 20 Jun 2022 04:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2by5Bt/vQS1TmQjI5mkgsiE5z/umI6jxynKNxO746d4=;
        b=ldnV3ppcMo5Ptak+KMbC4vHPWdx/pfSUyPTLWsqhPCq5r1Tbip2lEqGC6J/T7FpKxm
         SPi6DIzMWS5T4kxxNfz6vzyifSLPqpNvGCmGtiGpDNqVbp4hcDqpS7r6C4s3KXTFPCJW
         v8/xaa/PXyynwXsfygxoY8pRUAIT90zKVixMFBXhGi6if7rkoCHKapv5xxtIMSz9cdIY
         6MNcaKvirL6H1+Tz6ECTp883GtdeMir4GYpK8UDRP8jL9jiU4lm4ejkkr2qFq81dNAx5
         +NO3mFmGkrQQ0Q0b2Tox3BkphkD8SYtvAGoye81zA9zf/UWCbMpX32uG9IYGGJbsjhzG
         Iwhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2by5Bt/vQS1TmQjI5mkgsiE5z/umI6jxynKNxO746d4=;
        b=Lx7vUMf3ebghgALXm0OLFHGGCgyszjUhpu629Xs7SNiKFieBunb9jwwPAn4pG94t3y
         y1SfOSAXOZ248uTUsHcZP710LhQ3ea5HHFcmxeNZlZV0sVpzp2D2jwzFRBFALyfq4mtL
         kV/DsvtUxIedpU3GCoqEqRt0plT/er3xDQwgOmzSDELf2SjQmdSqpW116OM+TYVN2Po3
         YdBVrTJUVM6H9yvC+iBPHObqf+l7AivCWNEstxwt0tbEiRzFiwhEgwBq2oaGxNPZg5tl
         PCzfujyOD6TpSoRy5nlZoLnFE/p5KD0ozwwS5YDrvhyEADdSw2DyM/jlUsOHW3Xc5mba
         o/sg==
X-Gm-Message-State: AJIora8b7ADpOlVTjsDRg3jjgQ+UmLdEpb0V+f/6dbMdWY8m6AkDRicH
        rFkLU4UONyPcP8qdjqq13pljmw==
X-Google-Smtp-Source: AGRyM1vmKiaHggxv2dZfDGwt+FhYy6v7/QhNayc2LLe6OoQ6/acjbr1WzzH9BKkpaWxDuVng0PHC9A==
X-Received: by 2002:a2e:b0d7:0:b0:25a:739c:b0d5 with SMTP id g23-20020a2eb0d7000000b0025a739cb0d5mr611920ljl.208.1655724021857;
        Mon, 20 Jun 2022 04:20:21 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id o23-20020ac24e97000000b00478f5d3de95sm1727270lfr.120.2022.06.20.04.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 04:20:20 -0700 (PDT)
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
Subject: [PATCH v15 4/7] PCI: dwc: Handle MSIs routed to multiple GIC interrupts
Date:   Mon, 20 Jun 2022 14:20:12 +0300
Message-Id: <20220620112015.1600380-5-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220620112015.1600380-1-dmitry.baryshkov@linaro.org>
References: <20220620112015.1600380-1-dmitry.baryshkov@linaro.org>
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
separate GIC interrupt. Implement support for such configurations by
parsing "msi0" ... "msiN" interrupts and attaching them to the chained
handler.

Note, that if DT doesn't list an array of MSI interrupts and uses single
"msi" IRQ, the driver will limit the amount of supported MSI vectors
accordingly (to 32).

Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../pci/controller/dwc/pcie-designware-host.c | 63 +++++++++++++++++--
 1 file changed, 59 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 85c1160792e1..26b50948d6fc 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -289,6 +289,46 @@ static void dw_pcie_msi_init(struct pcie_port *pp)
 	dw_pcie_writel_dbi(pci, PCIE_MSI_ADDR_HI, upper_32_bits(msi_target));
 }
 
+static int dw_pcie_parse_split_msi_irq(struct pcie_port *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct device *dev = pci->dev;
+	struct platform_device *pdev = to_platform_device(dev);
+	int irq;
+	u32 ctrl, max_vectors;
+
+	/* Parse as many IRQs as described in the devicetree. */
+	for (ctrl = 0; ctrl < MAX_MSI_CTRLS; ctrl++) {
+		char msi_name[] = "msiX";
+
+		msi_name[3] = '0' + ctrl;
+		irq = platform_get_irq_byname_optional(pdev, msi_name);
+		if (irq == -ENXIO)
+			break;
+		if (irq < 0)
+			return dev_err_probe(dev, irq,
+					     "Failed to parse MSI IRQ '%s'\n",
+					     msi_name);
+
+		pp->msi_irq[ctrl] = irq;
+	}
+
+	/* If there were no "msiN" IRQs at all, fallback to the standard "msi" IRQ. */
+	if (ctrl == 0)
+		return -ENXIO;
+
+	max_vectors = ctrl * MAX_MSI_IRQS_PER_CTRL;
+	if (pp->num_vectors > max_vectors) {
+		dev_warn(dev, "Exceeding number of MSI vectors, limiting to %u\n",
+			 max_vectors);
+		pp->num_vectors = max_vectors;
+	}
+	if (!pp->num_vectors)
+		pp->num_vectors = max_vectors;
+
+	return 0;
+}
+
 static int dw_pcie_msi_host_init(struct pcie_port *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -297,21 +337,32 @@ static int dw_pcie_msi_host_init(struct pcie_port *pp)
 	int ret;
 	u32 ctrl, num_ctrls;
 
-	num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
-	for (ctrl = 0; ctrl < num_ctrls; ctrl++)
+	for (ctrl = 0; ctrl < MAX_MSI_CTRLS; ctrl++)
 		pp->irq_mask[ctrl] = ~0;
 
+	if (!pp->msi_irq[0]) {
+		ret = dw_pcie_parse_split_msi_irq(pp);
+		if (ret < 0 && ret != -ENXIO)
+			return ret;
+	}
+
+	if (!pp->num_vectors)
+		pp->num_vectors = MSI_DEF_NUM_VECTORS;
+	num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
+
 	if (!pp->msi_irq[0]) {
 		int irq = platform_get_irq_byname_optional(pdev, "msi");
 
 		if (irq < 0) {
 			irq = platform_get_irq(pdev, 0);
 			if (irq < 0)
-				return irq;
+				return dev_err_probe(dev, irq, "Failed to parse MSI irq\n");
 		}
 		pp->msi_irq[0] = irq;
 	}
 
+	dev_dbg(dev, "Using %d MSI vectors\n", pp->num_vectors);
+
 	pp->msi_irq_chip = &dw_pci_msi_bottom_irq_chip;
 
 	ret = dw_pcie_allocate_domains(pp);
@@ -409,7 +460,11 @@ int dw_pcie_host_init(struct pcie_port *pp)
 				     of_property_read_bool(np, "msi-parent") ||
 				     of_property_read_bool(np, "msi-map"));
 
-		if (!pp->num_vectors) {
+		/*
+		 * For the has_msi_ctrl case the default assignment is handled
+		 * in the dw_pcie_msi_host_init().
+		 */
+		if (!pp->has_msi_ctrl && !pp->num_vectors) {
 			pp->num_vectors = MSI_DEF_NUM_VECTORS;
 		} else if (pp->num_vectors > MAX_MSI_IRQS) {
 			dev_err(dev, "Invalid number of vectors\n");
-- 
2.35.1

