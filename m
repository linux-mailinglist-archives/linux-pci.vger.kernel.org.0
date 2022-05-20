Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C18D52F2BD
	for <lists+linux-pci@lfdr.de>; Fri, 20 May 2022 20:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352782AbiETSb5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 May 2022 14:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352678AbiETSby (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 May 2022 14:31:54 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF47F36307
        for <linux-pci@vger.kernel.org>; Fri, 20 May 2022 11:31:24 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id bu29so15838079lfb.0
        for <linux-pci@vger.kernel.org>; Fri, 20 May 2022 11:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H/YuS9QMHMXFKWGsExaNchzpaMNGQwVdXc0LejSjxgg=;
        b=C0aCpF/QOukaOFbpZk7VWyVm3etRLTocFKg+hMk9UXCXPTmoAbNhJzDpB6xmzNRcDI
         lCIXlbtMrJOoKcgYEWxwoX5DjizJAHkIwpYVo9VRjKdYV356vIqnS9X2dHdFnVxkK9DU
         mRviL2bILlr+MsMCJRZp8HgOHxHu1LCIEI6DzwvKPmZS6/BKuU0vlGR+MvH2KYHgHblq
         mCSDdH365QTVk5dJioNBebBWma4nRm1o7Lz0iM16rMVmg7XG5cWiSaxTeJXIWcc529Zi
         QYP75oddWzDhaUJhzoihNDoUNqTEYtJMXxjJgrJ8edrC6OF5hhqLG0lTecKRKh0O28iO
         I3/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H/YuS9QMHMXFKWGsExaNchzpaMNGQwVdXc0LejSjxgg=;
        b=Pl8IphM00zfh5qe7WR8dWXw9O3xcirxmskEewnuuwVFHO5lnHTu7++vobAuHYvo+pk
         e/HWEUu6UCMzzYt6AWMKoFaMid7EMwxd8kq0nCEPAKtRzOeK4iFLtQ5V4MPe6De4doY8
         hDemSyln+UF0kxeoy0Xqwj7qEA2nadE4SAOIiOnKFwwUFv8PHPOhtbH8q1APYwJFhS3n
         Hiee8akSaKKv2AIIDi48M1yVJPrz2QW0vpIxqf0uGLXi7mmQp+18VIfY3FVejwRF3fiP
         lAI0FHhMfku2E3VGu3W16UcJ8iZ0bEO4nxCzEb0xfqo7fYyLD/+7C0ILymPNHhpRfThU
         ma8Q==
X-Gm-Message-State: AOAM530nZTUGHLLvLQyjLs6XBr8sIBc85om+CvAy4WYZWEeGqzWqlw/8
        pYCL1ZFFmXxvzT+hTDqCt9Jpow==
X-Google-Smtp-Source: ABdhPJxRRxiRQN984/CNQIZ1ebccOmz1N7h/3a8Q+pMGETza5DHA4/HamOmjkBezHPwHJSCRhn2Nog==
X-Received: by 2002:ac2:42d1:0:b0:474:68f:2e48 with SMTP id n17-20020ac242d1000000b00474068f2e48mr7633528lfl.215.1653071482512;
        Fri, 20 May 2022 11:31:22 -0700 (PDT)
Received: from eriador.lan ([2001:470:dd84:abc0::8a5])
        by smtp.gmail.com with ESMTPSA id t22-20020a2e9556000000b0024f3d1daef4sm392951ljh.124.2022.05.20.11.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 11:31:22 -0700 (PDT)
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
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH v11 3/7] PCI: dwc: Handle MSIs routed to multiple GIC interrupts
Date:   Fri, 20 May 2022 21:31:10 +0300
Message-Id: <20220520183114.1356599-4-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220520183114.1356599-1-dmitry.baryshkov@linaro.org>
References: <20220520183114.1356599-1-dmitry.baryshkov@linaro.org>
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

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../pci/controller/dwc/pcie-designware-host.c | 58 +++++++++++++++++--
 1 file changed, 54 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index a076abe6611c..381bc24d5715 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -288,6 +288,43 @@ static void dw_pcie_msi_init(struct pcie_port *pp)
 	dw_pcie_writel_dbi(pci, PCIE_MSI_ADDR_HI, upper_32_bits(msi_target));
 }
 
+static const char * const split_msi_names[] = {
+	"msi0", "msi1", "msi2", "msi3",
+	"msi4", "msi5", "msi6", "msi7",
+};
+
+static int dw_pcie_parse_split_msi_irq(struct pcie_port *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct device *dev = pci->dev;
+	struct platform_device *pdev = to_platform_device(dev);
+	int irq;
+	u32 ctrl;
+
+	irq = platform_get_irq_byname_optional(pdev, split_msi_names[0]);
+	if (irq == -ENXIO)
+		return -ENXIO;
+
+	pp->msi_irq[0] = irq;
+
+	/* Parse as many IRQs as described in the DTS. */
+	for (ctrl = 1; ctrl < MAX_MSI_CTRLS; ctrl++) {
+		irq = platform_get_irq_byname_optional(pdev, split_msi_names[ctrl]);
+		if (irq == -ENXIO)
+			break;
+		if (irq < 0)
+			return dev_err_probe(dev, irq,
+					     "Failed to parse MSI IRQ '%s'\n",
+					     split_msi_names[ctrl]);
+
+		pp->msi_irq[ctrl] = irq;
+	}
+
+	pp->num_vectors = ctrl * MAX_MSI_IRQS_PER_CTRL;
+
+	return 0;
+}
+
 static int dw_pcie_msi_host_init(struct pcie_port *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -295,22 +332,34 @@ static int dw_pcie_msi_host_init(struct pcie_port *pp)
 	struct platform_device *pdev = to_platform_device(dev);
 	int ret;
 	u32 ctrl, num_ctrls;
+	bool has_split_msi_irq = false;
 
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
@@ -407,7 +456,8 @@ int dw_pcie_host_init(struct pcie_port *pp)
 				     of_property_read_bool(np, "msi-parent") ||
 				     of_property_read_bool(np, "msi-map"));
 
-		if (!pp->num_vectors) {
+		/* for the has_msi_ctrl the default assignment is handled inside dw_pcie_msi_host_init() */
+		if (!pp->has_msi_ctrl && !pp->num_vectors) {
 			pp->num_vectors = MSI_DEF_NUM_VECTORS;
 		} else if (pp->num_vectors > MAX_MSI_IRQS) {
 			dev_err(dev, "Invalid number of vectors\n");
-- 
2.35.1

