Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7635524AA0
	for <lists+linux-pci@lfdr.de>; Thu, 12 May 2022 12:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352795AbiELKqT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 May 2022 06:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352815AbiELKqA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 May 2022 06:46:00 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D83BE0C7
        for <linux-pci@vger.kernel.org>; Thu, 12 May 2022 03:45:53 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id l19so5951091ljb.7
        for <linux-pci@vger.kernel.org>; Thu, 12 May 2022 03:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xqH3lMsIdJoyn/K/QdA0FeBPly9c4ZNuS3iENff/SNc=;
        b=RPZDYcGtFCRcUKdxgQMpvumyPKuxmmW5leF4ZiZSH4XauoQako7anGJYzFJNnPuOMr
         DZJVPtXi923JLpmUSAHJsqBi+h7MqOUZtdDcaHtRBgGtkiBZuneqTxm2DOVsYC/1/D+g
         Cqwuq7lckiQ5XCOiRjgrDXNLhlwLa7H8eV5X358M2jZdtpMXORtfJwkyNl4dyE1NLjP9
         MHDlqA6rlG1lF7UEax8BHlapM2/yJaVy34YXJZNAMCkzfYqBK+AMhP/tvCN+6ae6J7fA
         2649AskWKErSvmD7uhmERIPgkZqJ7DvtETc6Pjzq7ZXPe1liyS1Y2Y95il7/Ov9z7PZF
         1gBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xqH3lMsIdJoyn/K/QdA0FeBPly9c4ZNuS3iENff/SNc=;
        b=3o5sizFQoq4Fp8q+R2xLxuUTxQMn/NUArpJIg+xTcxmR7g7u20cxZsFvRMIwoVuIsQ
         87Z19Z4hOpsIsOHfVfkqI8KXlCL3f8kLpkInPTn8K74jKCBkR5fpebx8W3Cl4SxujC10
         Xki2RJD4bft10GClHrAcOKwC63IYFK1rXUvCmHt7ABNkoszqN8ORIVwFvY7zHJqy9xng
         aZBYPaHtyQWOmjbLi/gogFBoy/z7rtFtYVC/rl9BbPEh5N/l2SAzt+iqlBmMg4uKcpeK
         pUwYDixTZneyi02ItryT+CAPGNL/e4N6W4J638BsO1eti9HKo9o2Ttn23mlSicEsI6OH
         Kraw==
X-Gm-Message-State: AOAM532mSaBdnGa3XGZLpGWW5qJHVcQONaWfijYpOCFUWxMWwGdMSHTJ
        P5DXH3Up/vFLf4VYERwHwpIb+BuEVEH/6g==
X-Google-Smtp-Source: ABdhPJwOsmW27eNFpS6JDpKruKlgEVsG/Q3fheqYkd4h7U954k0Bh4umlOnIt0mQD6V//CRVBfyfbg==
X-Received: by 2002:a2e:8e84:0:b0:24f:1d40:ceb0 with SMTP id z4-20020a2e8e84000000b0024f1d40ceb0mr20910905ljk.292.1652352350928;
        Thu, 12 May 2022 03:45:50 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id q21-20020a2e9695000000b0024f3d1daeafsm831660lji.55.2022.05.12.03.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 03:45:50 -0700 (PDT)
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
Subject: [PATCH v8 06/10] PCI: dwc: Handle MSIs routed to multiple GIC interrupts
Date:   Thu, 12 May 2022 13:45:41 +0300
Message-Id: <20220512104545.2204523-7-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220512104545.2204523-1-dmitry.baryshkov@linaro.org>
References: <20220512104545.2204523-1-dmitry.baryshkov@linaro.org>
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
separate GIC interrupt. Implement support for such configuraions by
parsing "msi0" ... "msi7" interrupts and attaching them to the chained
handler.

Note, that if DT doesn't list an array of MSI interrupts and uses single
"msi" IRQ, the driver will limit the amount of supported MSI vectors
accordingly (to 32).

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../pci/controller/dwc/pcie-designware-host.c | 33 ++++++++++++++++++-
 drivers/pci/controller/dwc/pcie-designware.h  |  1 +
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 6b0c7b75391f..258bafa306dc 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -291,7 +291,8 @@ static void dw_pcie_msi_init(struct pcie_port *pp)
 static int dw_pcie_msi_host_init(struct pcie_port *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	struct platform_device *pdev = to_platform_device(pci->dev);
+	struct device *dev = pci->dev;
+	struct platform_device *pdev = to_platform_device(dev);
 	int ret;
 	u32 ctrl, num_ctrls;
 
@@ -299,6 +300,36 @@ static int dw_pcie_msi_host_init(struct pcie_port *pp)
 	for (ctrl = 0; ctrl < num_ctrls; ctrl++)
 		pp->irq_mask[ctrl] = ~0;
 
+	if (pp->has_split_msi_irq) {
+		char irq_name[] = "msiXX";
+		int irq;
+
+		if (!pp->msi_irq[0]) {
+			irq = platform_get_irq_byname_optional(pdev, irq_name);
+			if (irq == -ENXIO) {
+				num_ctrls = 1;
+				pp->num_vectors = min((u32)MAX_MSI_IRQS_PER_CTRL, pp->num_vectors);
+				dev_warn(dev, "No additional MSI IRQs, limiting amount of MSI vectors to %d\n",
+					 pp->num_vectors);
+			} else {
+				pp->msi_irq[0] = irq;
+			}
+		}
+
+		/* If we fallback to the single MSI ctrl IRQ, this loop will be skipped as num_ctrls is 1 */
+		for (ctrl = 1; ctrl < num_ctrls; ctrl++) {
+			if (pp->msi_irq[ctrl])
+				continue;
+
+			snprintf(irq_name, sizeof(irq_name), "msi%d", ctrl);
+			irq = platform_get_irq_byname(pdev, irq_name);
+			if (irq < 0)
+				return irq;
+
+			pp->msi_irq[ctrl] = irq;
+		}
+	}
+
 	if (!pp->msi_irq[0]) {
 		int irq = platform_get_irq_byname_optional(pdev, "msi");
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 9c1a38b0a6b3..3aa840a5b19c 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -179,6 +179,7 @@ struct dw_pcie_host_ops {
 
 struct pcie_port {
 	bool			has_msi_ctrl:1;
+	bool			has_split_msi_irq:1;
 	u64			cfg0_base;
 	void __iomem		*va_cfg0_base;
 	u32			cfg0_size;
-- 
2.35.1

