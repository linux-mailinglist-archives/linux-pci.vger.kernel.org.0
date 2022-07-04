Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA945659CB
	for <lists+linux-pci@lfdr.de>; Mon,  4 Jul 2022 17:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234093AbiGDP2K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Jul 2022 11:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234234AbiGDP1y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Jul 2022 11:27:54 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA06FD0E
        for <linux-pci@vger.kernel.org>; Mon,  4 Jul 2022 08:27:52 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id a4so16433331lfm.0
        for <linux-pci@vger.kernel.org>; Mon, 04 Jul 2022 08:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rGzZ2u3PPD5gFzW39rNL30eGdjw+uzSfaV3NYHvk1Ig=;
        b=HWeErQDDO++2q1M+K1cp3pLgH+b8bptmAdN9LW5/L/j0ivQn+f4+weTK8Q9q8CVKDg
         0cAGipp0xjan7auWEzAqhTpOYEgbnG/qjbTxUGHcSbk+YPYApVfiYB+7mU6shTGk9pmq
         PZ/FfHLZlKkMaHEA83Xt+3jx755PSPNknxEJHcDCrccP2lIx/XwBK5ZtGKnVoMViMpvw
         AUIYyS6uDSElXRAEcHRoSdYFOH3kZRPua6Oqfy9z12m0pZArRpz/JwzABfBQGgCKpmAS
         tmlk6EQy8ivZuCaElEVf7aYzAj6WOjJI/U8sITzan84jZ52mYOtCP4JzVZgox/y2zj6D
         aHcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rGzZ2u3PPD5gFzW39rNL30eGdjw+uzSfaV3NYHvk1Ig=;
        b=OD/pkK0tckDaBtA1vqhskmh9IkUBV6Ujow69pCxuezKNusMF8sTjk5M45vo1YznA4l
         NO7FTCL4o0JilJyrrNHW9JHx2ZKcJAIUJDoKgvuQTJNlWG0HljB4Z9GaT2dxp5Qz/vnW
         wD1Guq2PDW+5pZZ6g83vSfbt21mINFiArirTY9TLjb3ojoeDGheE6CL88EW4TQ6sjHPo
         BH7DqCCNuzwTNl2YMVzlOunzgR1uCMFE7+ZJb6DbR2FawMNb0JJ/+xyWUxwxs3PsqD5+
         IRotTebDrTD1PtSEbSGiVhAJgZinVj73wJ2LMGah0OqxJKU0b6INAdidOHiALpuBNSsy
         4PyQ==
X-Gm-Message-State: AJIora/6TfpqSyCd2O9oDzbifQrOtYb178kLARUU1UMh/+RGpzrOsnDT
        gKzR9nwLmXFHvPZVGkjvBzfiuA==
X-Google-Smtp-Source: AGRyM1vfrv8RKCH+kLcxf2lTIre4gJVcKiktPmxLkQ+tOH04B9PLtJo9WSqaMbbk7YqzK38WXyq3wQ==
X-Received: by 2002:a05:6512:2611:b0:478:da8f:e2d8 with SMTP id bt17-20020a056512261100b00478da8fe2d8mr18615101lfb.460.1656948470874;
        Mon, 04 Jul 2022 08:27:50 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id h14-20020a056512220e00b004786eb19049sm5175820lfu.24.2022.07.04.08.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 08:27:50 -0700 (PDT)
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
Subject: [PATCH v16 4/6] PCI: dwc: Handle MSIs routed to multiple GIC interrupts
Date:   Mon,  4 Jul 2022 18:27:44 +0300
Message-Id: <20220704152746.807550-5-dmitry.baryshkov@linaro.org>
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
index 3ba531da99d4..2bab0c395ea9 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -290,6 +290,46 @@ static void dw_pcie_msi_init(struct pcie_port *pp)
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
@@ -298,21 +338,32 @@ static int dw_pcie_msi_host_init(struct pcie_port *pp)
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
@@ -410,7 +461,11 @@ int dw_pcie_host_init(struct pcie_port *pp)
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

