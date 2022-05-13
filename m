Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F40F5262D1
	for <lists+linux-pci@lfdr.de>; Fri, 13 May 2022 15:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380651AbiEMNRJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 May 2022 09:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380632AbiEMNRF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 May 2022 09:17:05 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7687365E8
        for <linux-pci@vger.kernel.org>; Fri, 13 May 2022 06:17:04 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 16so10213373lju.13
        for <linux-pci@vger.kernel.org>; Fri, 13 May 2022 06:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xsYP2PoV5UHlV3NU2qBXxqQNUhnoHqc1nwQcURQBJCA=;
        b=pdLG3IP1GXQ2aYw6UEnIrpER/+55hEAUtXLiLZWrER8i8BeSnCpcfl05zZxa9oYI+4
         9nhjwqNYb/faYcDuxVwh6MXNCAp0f6q11ycJelqkUEjRD+GRuyPiBmX4wVoI6zU/aKuW
         2MmMov19BYr9y2yyoHt20tr5jVuc3WD7V+s9TP4FOqotiHQ1cGE+rbNJ1F5fKuk9RQIl
         33pD97bgdtUwHewVX46TEl6bQgVXGmhmQydYdIJViB/WKLAPopjZNBttLNcHA5IHMlf4
         n94DnOAGxmwF1qZpIKgdtcKu8Kah2EcSTDAaqwFTkB4YwMZf8spRWU9q7e1PNWcjkFmk
         6+Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xsYP2PoV5UHlV3NU2qBXxqQNUhnoHqc1nwQcURQBJCA=;
        b=MDx3YoLnjnwG0HgJVZk5h1d7N49/F2gvXOc3EwubeMM6TAw/42Z0ga84jdlNynCoq/
         IMSv6mDH3IAujUo13tRYxuW5D5TReqE4DizBniYT1UYEplVGX2w1nacC84JWZLUBaXtu
         rmQ3x+qCP9xQJcuVW7AK4eodQbSRhGhA/381wk/k8WFWgaAlRkWSvKwvGSo7oR7hxpez
         kGgJM7W22Qo7996HXwJruRzuzVkjxEB/3v61kpKbLHeArSPxJJea3fcxPhx9Iy555Vwo
         EVUNoQLD8P2heq8qvOtEbijgPRW2GMyrra6jnm7WesqsBEplvWqgfdwccXW54ENxWt41
         OYUQ==
X-Gm-Message-State: AOAM5314EtvxKdcSi9v9H4Mq7Ho1RSUuRDndviLKVMSYoAUlJ0ikm18A
        PGCpHHLVL/OjAjaRUuGNLMhc/A==
X-Google-Smtp-Source: ABdhPJwFaDrPmPlF8hCMdncHxbgQLcpiQ/TriAmDtlGeToouYzScTA4Y366PSPn4vWEEag7437XyAg==
X-Received: by 2002:a05:651c:1025:b0:250:a01e:6e5e with SMTP id w5-20020a05651c102500b00250a01e6e5emr3133906ljm.76.1652447822800;
        Fri, 13 May 2022 06:17:02 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id u22-20020a2ea176000000b0024f3d1dae8fsm436991ljl.23.2022.05.13.06.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 06:17:02 -0700 (PDT)
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
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Johan Hovold <johan@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v9 06/10] PCI: dwc: Handle MSIs routed to multiple GIC interrupts
Date:   Fri, 13 May 2022 16:16:51 +0300
Message-Id: <20220513131655.2927616-7-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220513131655.2927616-1-dmitry.baryshkov@linaro.org>
References: <20220513131655.2927616-1-dmitry.baryshkov@linaro.org>
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
 .../pci/controller/dwc/pcie-designware-host.c | 34 +++++++++++++++++--
 drivers/pci/controller/dwc/pcie-designware.h  |  1 +
 2 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 983fff735d7e..007600524b49 100644
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
 
@@ -299,13 +300,42 @@ static int dw_pcie_msi_host_init(struct pcie_port *pp)
 	for (ctrl = 0; ctrl < num_ctrls; ctrl++)
 		pp->irq_mask[ctrl] = ~0;
 
+	if (pp->has_split_msi_irq) {
+		char irq_name[] = "msiXX";
+		int irq;
+
+		for (ctrl = 0; ctrl < num_ctrls; ctrl++) {
+			if (pp->msi_irq[ctrl])
+				continue;
+
+			snprintf(irq_name, sizeof(irq_name), "msi%d", ctrl);
+			irq = platform_get_irq_byname(pdev, irq_name);
+			if (irq == -ENXIO && ctrl == 0) {
+				num_ctrls = 1;
+				pp->num_vectors = min_t(u32,
+							MAX_MSI_IRQS_PER_CTRL,
+							pp->num_vectors);
+				dev_warn(dev, "No split MSI IRQs, fallback to single MSI IRQ\n");
+				break;
+			} else if (irq < 0) {
+				return dev_err_probe(dev, irq,
+						     "Failed to parse MSI IRQ '%s'\n",
+						     irq_name);
+			}
+
+			pp->msi_irq[ctrl] = irq;
+		}
+
+		dev_info(dev, "Using %d MSI vectors\n", pp->num_vectors);
+	}
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

