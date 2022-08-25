Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 425BD5A1911
	for <lists+linux-pci@lfdr.de>; Thu, 25 Aug 2022 20:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243506AbiHYSvH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Aug 2022 14:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243470AbiHYSvG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Aug 2022 14:51:06 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767C0B276A
        for <linux-pci@vger.kernel.org>; Thu, 25 Aug 2022 11:51:05 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id g9-20020a056a00078900b005366c5fa183so6082560pfu.12
        for <linux-pci@vger.kernel.org>; Thu, 25 Aug 2022 11:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=tygyO2PFYuXfHZyst5i+EgaagTYAQzq4it8NYXlV8yE=;
        b=JYmM/LaanczpZXc8FicUlLTdPcEufZxVnfyC8MxneGRytIoEsvI7SAfJuN/mAYgSm6
         CjSDRzLpYl8nMwaaQsMslKv5KFqn9KI4jiqUmuaIgEVcEXGvK+JrjnySFrsm6c5aNyXH
         f4yAKfroHEpTHbPvUrglrrRTArXfxj3eyItIaThw4Z6rwf5JlDK5RpjD162RRVLEFpNy
         jpMoQ6wiysX1/eFjvdWBYzsmF4oeY9Puesv8Y/fTXeGwq1BCfqMCJsA2v/d6C//NZ992
         AMkmD4xix7H4zgyfJUtgjjZVwbMRKFb7UswG35cMEacs21Rg90D+ncxl9reAU7+OP89U
         OaNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=tygyO2PFYuXfHZyst5i+EgaagTYAQzq4it8NYXlV8yE=;
        b=cqy5OI/j9OOp2WNonVDdHiMeJ4E0iSpmQC+Df8rRiBDJRx2+//jlHGaT5NS5cgChil
         Gs+iHMJX291CBuahIG/3WbDjX/XLkBvttHjk6uDZMP/lwE0bpPkOAL4FKhIJMdRp1QG0
         fFJ8j4LOr5x4GLAVoQyI89GQZkQSUJl40Cyz8LNB5Tbhg7i/LW3FtwrfyaRoQp2X2AsQ
         ttNHIwI7TX3dIMUm7De0r4tx6M9E5oG1t5nLnEQ+9J9H9cnM9HyZSy5X2z3wzth4Ed5T
         qStK6FgfdxCMiMnzjoCI0fo9AsidWi+yp1adxbJDGXlmnpNm/tVUhC0zebGgSdOFsYAz
         S0pw==
X-Gm-Message-State: ACgBeo1EcimIXj6Gf01DXV0Kmf/iax3uWazzFUFzny7P24/kuY52pfvC
        C4pn0PBcjPmsqeuMcmMDnHYII9ET/3Im0cqKcpE=
X-Google-Smtp-Source: AA6agR4CCj8ppM4p5JEAP3jexpSQa9OQaMFvlC+MhwHxNvkjEVf2DRTaegebNKEurVTjr/CxVe15AMgQpQApIzMLBaU=
X-Received: from wmcvicker.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5ebe])
 (user=willmcvicker job=sendgmr) by 2002:aa7:9430:0:b0:537:ab14:6cd8 with SMTP
 id y16-20020aa79430000000b00537ab146cd8mr328878pfo.29.1661453464664; Thu, 25
 Aug 2022 11:51:04 -0700 (PDT)
Date:   Thu, 25 Aug 2022 18:50:24 +0000
In-Reply-To: <20220825185026.3816331-1-willmcvicker@google.com>
Mime-Version: 1.0
References: <20220825185026.3816331-1-willmcvicker@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220825185026.3816331-2-willmcvicker@google.com>
Subject: [PATCH v5 1/2] PCI: dwc: Drop dependency on ZONE_DMA32
From:   Will McVicker <willmcvicker@google.com>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        "=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?=" <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Will McVicker <willmcvicker@google.com>
Cc:     kernel-team@android.com, Vidya Sagar <vidyas@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Robin Murphy <robin.murphy@arm.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Isaac J . Manjarres" <isaacmanjarres@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Re-work the msi_msg DMA allocation logic to use dmam_alloc_coherent() which
uses the coherent DMA mask to try to return an allocation within the DMA
mask limits. With that, we now can drop the msi_page parameter in struct
dw_pcie_rp. This allows kernel configurations that disable ZONE_DMA32 to
continue supporting a 32-bit DMA mask. Without this patch, the PCIe host
device will fail to probe when ZONE_DMA32 is disabled.

Fixes: 35797e672ff0 ("PCI: dwc: Fix MSI msi_msg DMA mapping")
Reported-by: Isaac J. Manjarres <isaacmanjarres@google.com>
Signed-off-by: Will McVicker <willmcvicker@google.com>
Acked-by: Jingoo Han <jingoohan1@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../pci/controller/dwc/pcie-designware-host.c | 28 +++++--------------
 drivers/pci/controller/dwc/pcie-designware.h  |  1 -
 2 files changed, 7 insertions(+), 22 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 7746f94a715f..39f3b37d4033 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -267,15 +267,6 @@ static void dw_pcie_free_msi(struct dw_pcie_rp *pp)
 
 	irq_domain_remove(pp->msi_domain);
 	irq_domain_remove(pp->irq_domain);
-
-	if (pp->msi_data) {
-		struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-		struct device *dev = pci->dev;
-
-		dma_unmap_page(dev, pp->msi_data, PAGE_SIZE, DMA_FROM_DEVICE);
-		if (pp->msi_page)
-			__free_page(pp->msi_page);
-	}
 }
 
 static void dw_pcie_msi_init(struct dw_pcie_rp *pp)
@@ -336,6 +327,7 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct device *dev = pci->dev;
 	struct platform_device *pdev = to_platform_device(dev);
+	u64 *msi_vaddr;
 	int ret;
 	u32 ctrl, num_ctrls;
 
@@ -375,22 +367,16 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
 						    dw_chained_msi_isr, pp);
 	}
 
-	ret = dma_set_mask(dev, DMA_BIT_MASK(32));
+	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
 	if (ret)
 		dev_warn(dev, "Failed to set DMA mask to 32-bit. Devices with only 32-bit MSI support may not work properly\n");
 
-	pp->msi_page = alloc_page(GFP_DMA32);
-	pp->msi_data = dma_map_page(dev, pp->msi_page, 0,
-				    PAGE_SIZE, DMA_FROM_DEVICE);
-	ret = dma_mapping_error(dev, pp->msi_data);
-	if (ret) {
-		dev_err(pci->dev, "Failed to map MSI data\n");
-		__free_page(pp->msi_page);
-		pp->msi_page = NULL;
-		pp->msi_data = 0;
+	msi_vaddr = dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data,
+					GFP_KERNEL);
+	if (!msi_vaddr) {
+		dev_err(dev, "Failed to alloc and map MSI data\n");
 		dw_pcie_free_msi(pp);
-
-		return ret;
+		return -ENOMEM;
 	}
 
 	return 0;
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 09b887093a84..a871ae7eb59e 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -243,7 +243,6 @@ struct dw_pcie_rp {
 	struct irq_domain	*irq_domain;
 	struct irq_domain	*msi_domain;
 	dma_addr_t		msi_data;
-	struct page		*msi_page;
 	struct irq_chip		*msi_irq_chip;
 	u32			num_vectors;
 	u32			irq_mask[MAX_MSI_CTRLS];
-- 
2.37.2.672.g94769d06f0-goog

