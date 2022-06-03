Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1ECA53C679
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jun 2022 09:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242474AbiFCHlq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Jun 2022 03:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242591AbiFCHlq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Jun 2022 03:41:46 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4983137A35
        for <linux-pci@vger.kernel.org>; Fri,  3 Jun 2022 00:41:44 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id y32so11332053lfa.6
        for <linux-pci@vger.kernel.org>; Fri, 03 Jun 2022 00:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QRppX71CIdksxMk7Q75MQ38Y0PsHcW4taRNHBU5NIuU=;
        b=YX0Xws/wuO2LhGKSTRtDuJmuwHG0h5msad3YfSFGT6XAqOmeGmOhGU/NyApXKVjmoy
         RnLUaVfLAGRFcjZkrgNnPqWOTCRUgWXv+eomLWR5eVmztLtw15QyeEgPysqZraLpJOru
         WyM+hbYvXw/AOxkzk0rINpQlwMN15x6TIAd2K1CkJMGd6UhmU8uQknLF1lRSefcs5Qal
         I9vMNtT3yqahtrMKF3XBfFYOf3Gdt0Vrk3C2DbNVZAgGd310x/QIiaWilnSVW04d65DL
         f/KTUiYbTd7B5gY6xscmc4zR9rS624v5jFwd25BqPgc1fTapSFJWdznx0gp/RkU/pT3X
         RKPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QRppX71CIdksxMk7Q75MQ38Y0PsHcW4taRNHBU5NIuU=;
        b=jbiQMXu3iqfT4l0EjH1pvttJBchQs2P7jgl9Tswg0YjsAQCxq3mla+leNCsgFB4cBJ
         fcviQUmoAky2K8xiIRWffVwnspvpz9jt6NWUo77xEU2G0JcLRLacPXfbLLHWsQEbBAK0
         4U9rI4nmLiiCO1os4pamEGs4+Jx7fBiasaJ6yTz0nyJEtRxJR6Q9mquSzVcbCfLy/S0U
         D46F1zv4Tu2G6sw57n0pY4KcD5Y8O2Cj+/gOc3QIpBWXU0HmYeC9MQAU2IErF9b5Ihzi
         IGdrOQ9aXxPWY7P+/JS54cSRrPYIRBjdmjOF+OfdbWZg8p5/SsWSgvKofIU2p8cXxT2d
         xNNA==
X-Gm-Message-State: AOAM530b5Kdlawr+k/QMiHQ/C6p9qevZFIuecKa0jUiV9PBG5ymaz0hh
        7AZKh7qgHcj7d7HY5gn9a+5/kw==
X-Google-Smtp-Source: ABdhPJzOQfdBLwpyOxe+ir3uaurIZ+Rh/BetqkrZraTj2x2VABQx5XTmtIA/SI+HgASRnb+MJ2cn1A==
X-Received: by 2002:a05:6512:3c82:b0:478:5dde:4865 with SMTP id h2-20020a0565123c8200b004785dde4865mr6358233lfv.424.1654242102486;
        Fri, 03 Jun 2022 00:41:42 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id x6-20020ac24886000000b00477b11144e9sm1450023lfc.66.2022.06.03.00.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 00:41:42 -0700 (PDT)
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
Subject: [PATCH v13 4/7] PCI: dwc: Handle MSIs routed to multiple GIC interrupts
Date:   Fri,  3 Jun 2022 10:41:34 +0300
Message-Id: <20220603074137.1849892-5-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220603074137.1849892-1-dmitry.baryshkov@linaro.org>
References: <20220603074137.1849892-1-dmitry.baryshkov@linaro.org>
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
index 85c1160792e1..d1f9e20df903 100644
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
+		char *msi_name = "msiX";
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

