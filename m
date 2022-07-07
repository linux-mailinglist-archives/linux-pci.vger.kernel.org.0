Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A5056A40C
	for <lists+linux-pci@lfdr.de>; Thu,  7 Jul 2022 15:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235663AbiGGNru (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Jul 2022 09:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236058AbiGGNrl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Jul 2022 09:47:41 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086EC21260
        for <linux-pci@vger.kernel.org>; Thu,  7 Jul 2022 06:47:40 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id j21so31276131lfe.1
        for <linux-pci@vger.kernel.org>; Thu, 07 Jul 2022 06:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/7Nu9JIM7dV+LZJx7sxeNILQIWX9AauAsLWFjiWt2Tw=;
        b=f0WfehWxKpBTuaFYsifqFVlmuw2PitQOP6fQRZeI6Xfp9/5iGhMqTU5axZrkJ2IawD
         oYKPPSAZ2QM4NXIOHSk95LG+n06YrcqD1WsItfBYsFoW8+7DIfSKJlE+zfe7ZiZVFMlH
         EaUXfWqdqSLKwcxZcHDdC/urr59P0tvWjN5h+cCmPYm1Ig3sW0VMV/XSuqlOjZwIbxKc
         BQgOZvHOL6xlZTOp0CmN0JQ6JRuzzaJfkslmtzEJa/hTLM0bBSX0I/COslTo/IqKqAPp
         89qtEsLneYEbx56Y4TRSIitNuV5amiwNqMW6Jh6xJ00NLZZF6Tl4jzMd03hfVxtHwI4+
         HYBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/7Nu9JIM7dV+LZJx7sxeNILQIWX9AauAsLWFjiWt2Tw=;
        b=MBzfZ6cAZgeUtCI3R4J18MhOC6Jg9FHOCxtVakAZCF6Qz19H4pO2y8KsMCnRn76BZE
         vHUeQfxseZcyDa3GUqgMCABoLJgX4XNQCelQ0Uf+nIaoELn7u2DgqcbuiDnngsZIUPgK
         wI27FdBJrEYLMaxX0FcnGi1bkSH93gPaw4njvZuXOmQ3pWY9IoxGHKNcdAML3HyAfU4E
         +O96911OSoU14w9l6I29z4Ah4H2w5U120Xayd4Fk8TJQLHj1bdSZadIHFXrgzrVb8QzS
         hgm8sD5g6goyLtEoCrzDXOgjXhMW6S8tSIo0A6sWVFELUuBq8lPZwPjlTESief8LQE57
         QImw==
X-Gm-Message-State: AJIora/AEoFoLPXUBz8qD0gBk2hm7OpTJnf38SMgdxbpI+D+nVAMrHCv
        D03GakDJVrSPun/cx0DKYP0c9Q==
X-Google-Smtp-Source: AGRyM1uj/GQL5W4QbJv2W25LBMso/15pxtptCMlL7Uxjd9xH+DowqmsGVgsfPtLSBUBFw9Ij+g7rXw==
X-Received: by 2002:a05:6512:11d2:b0:47f:7ca3:c533 with SMTP id h18-20020a05651211d200b0047f7ca3c533mr29398317lfr.388.1657201658380;
        Thu, 07 Jul 2022 06:47:38 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id u22-20020a197916000000b0047fa941067fsm6856966lfc.29.2022.07.07.06.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 06:47:37 -0700 (PDT)
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
Subject: [PATCH v17 4/6] PCI: dwc: Handle MSIs routed to multiple GIC interrupts
Date:   Thu,  7 Jul 2022 16:47:31 +0300
Message-Id: <20220707134733.2436629-5-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220707134733.2436629-1-dmitry.baryshkov@linaro.org>
References: <20220707134733.2436629-1-dmitry.baryshkov@linaro.org>
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
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../pci/controller/dwc/pcie-designware-host.c | 63 +++++++++++++++++--
 1 file changed, 59 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 3caac9bc265e..7c917211c733 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -290,6 +290,46 @@ static void dw_pcie_msi_init(struct dw_pcie_rp *pp)
 	dw_pcie_writel_dbi(pci, PCIE_MSI_ADDR_HI, upper_32_bits(msi_target));
 }
 
+static int dw_pcie_parse_split_msi_irq(struct dw_pcie_rp *pp)
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
 static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -298,21 +338,32 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
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
@@ -412,7 +463,11 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
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

