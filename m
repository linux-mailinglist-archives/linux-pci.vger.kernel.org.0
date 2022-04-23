Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1973C50CAB4
	for <lists+linux-pci@lfdr.de>; Sat, 23 Apr 2022 15:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235793AbiDWNnV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 23 Apr 2022 09:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235827AbiDWNmn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 23 Apr 2022 09:42:43 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A2D1759EE
        for <linux-pci@vger.kernel.org>; Sat, 23 Apr 2022 06:39:46 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id w19so18800498lfu.11
        for <linux-pci@vger.kernel.org>; Sat, 23 Apr 2022 06:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F1LrhyF1IFwxWcdCQmjBcgoDqXWko6Eulj2xB+qyGAU=;
        b=X8qNAwbtGVQ4LBIrvhBFsiBGbHLz0jpKeK7rGmXK524yZ3HX6XiG6AH/ISjQVGq71d
         ipT1wM7ADYYVlLct66ESdgbcqGRlH1MEdKz7fHd+sG9Kkvmfi5R2gQag8SJ9GEs/kq90
         TjcXsCUUkCbhU1NTOr5vPieBt4Z1K1+2yOWxpGTGxF1ucOPgAxnVI1t8XYOvpAhrdZnq
         5Xug3Tx7Lr+WzGO3Zi7/jLgmQXD0mfdDfquu4SCd5bd8uO4k7J1AcBBgDGvRdoTgvy7w
         ZTyLp1nwN0SSZRlr0Fc6nGaLRrFb+Z4ttpMP1XY9Ouss5dI4LRGrtxHmvMG4dMGrYh0b
         1r5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F1LrhyF1IFwxWcdCQmjBcgoDqXWko6Eulj2xB+qyGAU=;
        b=BRRH+QqhPa4uax+u9rOB+RE7cHps0q36GgR8e3tFiicjBxzmBWxmyOjKjMg5mEwR2R
         RjkFVDh4RAvNCsN7TNAqP46dqM27QuG+ihmfzhJ7yKSKsqAVUl5+kRsVCstCjzuPWokd
         pqCoPKqFvwOO32kOJll06gKM6RgV7XjQLgauoaPl0aE1GTULOlXd7kZGEbSaFQzSYGYI
         xpRqbzeXgHH2Xkp7aH1m2Q3FwGxunQzqBnPEcP7t35B0n10/R4hOQ5xMsmNwCkGQUnMJ
         h1xAgCguQ5PYfJ7XemYisZX6G1Gz+UJ0Xe9GqWuLWScq0DHfwGvVRedZQzcnBqK7I98N
         efeg==
X-Gm-Message-State: AOAM533NHVO0K3h4LChM6BChCRWQBVKN6JKOQBaYf5++oS4SiZRNOn1K
        0G+uVnU5/io8s1sUqDHjzuibyg==
X-Google-Smtp-Source: ABdhPJzutyKcEwX2MckmKMWVgTAc/ue8xrrn5S0lMn2zwB5NBhJd9t8stF1fob3BYWYuZEQxoSfy7g==
X-Received: by 2002:a19:710a:0:b0:471:e7c8:a0db with SMTP id m10-20020a19710a000000b00471e7c8a0dbmr4480600lfc.512.1650721184466;
        Sat, 23 Apr 2022 06:39:44 -0700 (PDT)
Received: from eriador.lumag.spb.ru ([94.25.228.223])
        by smtp.gmail.com with ESMTPSA id c21-20020a2ea795000000b0024ee0f8ef92sm544535ljf.36.2022.04.23.06.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 06:39:44 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Vinod Koul <vkoul@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 2/5] PCI: dwc: Teach dwc core to parse additional MSI interrupts
Date:   Sat, 23 Apr 2022 16:39:36 +0300
Message-Id: <20220423133939.2123449-3-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220423133939.2123449-1-dmitry.baryshkov@linaro.org>
References: <20220423133939.2123449-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DWC driver parses a single "msi" interrupt which gets fired when the EP
sends an MSI interrupt, however for some devices (Qualcomm) devies MSI
vectors are handled in groups of 32 vectors. Add support for parsing
"split" MSI interrupts.

In addition to the "msi" interrupt, the code will lookup the "msi2",
"msi3", etc. IRQs and use them for the MSI group interrupts. For
backwards compatibility with existing DTS files, the code will not error
out if any of these interrupts is missing. Instead it will limit itself
to the amount of MSI group IRQs declared in the DT file.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../pci/controller/dwc/pcie-designware-host.c | 23 +++++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.h  |  1 +
 2 files changed, 24 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 5d90009a0f73..ce7071095006 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -382,6 +382,29 @@ int dw_pcie_host_init(struct pcie_port *pp)
 				pp->msi_irq[0] = irq;
 			}
 
+			if (pp->has_split_msi_irq) {
+				char irq_name[] = "msiXXX";
+				int irq;
+
+				for (ctrl = 1; ctrl < num_ctrls; ctrl++) {
+					if (pp->msi_irq[ctrl])
+						continue;
+
+					snprintf(irq_name, sizeof(irq_name), "msi%d", ctrl + 1);
+					irq = platform_get_irq_byname_optional(pdev, irq_name);
+					if (irq == -ENXIO) {
+						num_ctrls = ctrl;
+						pp->num_vectors = num_ctrls * MAX_MSI_IRQS_PER_CTRL;
+						dev_warn(dev, "Limiting amount of MSI irqs to %d\n", pp->num_vectors);
+						break;
+					}
+					if (irq < 0)
+						return irq;
+
+					pp->msi_irq[ctrl] = irq;
+				}
+			}
+
 			pp->msi_irq_chip = &dw_pci_msi_bottom_irq_chip;
 
 			ret = dw_pcie_allocate_domains(pp);
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

