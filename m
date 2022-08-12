Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF16B590970
	for <lists+linux-pci@lfdr.de>; Fri, 12 Aug 2022 02:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbiHLADs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Aug 2022 20:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiHLADq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Aug 2022 20:03:46 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74FBFA1D3B
        for <linux-pci@vger.kernel.org>; Thu, 11 Aug 2022 17:03:44 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id p36-20020a634f64000000b0041bd62cd236so7035123pgl.14
        for <linux-pci@vger.kernel.org>; Thu, 11 Aug 2022 17:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=NBT3CxRHX8GEU/qW00McBn9/Bm/D8SvEDLg7/zkxpnw=;
        b=R7ZBOxLh8e6jgoMZZNtBAodQik+Ybr/ajqMr8g5jPxUz1F7EXoTKKbgb35JjsIKvc/
         Cn52mq3L72OevluvYstxPbxV/kiU3ZSKLORU1SzkbwxVslO6c//gNDPkN1qnLAeyvyzs
         EKXHtqc13rtvW5vBm9xLCPzYVyWacq+nM736HfQzAMBnh/JuAWbPz8gJ+HzkIQARWwsJ
         eQXffAvoiWvMGmbx8PwvOR1J034fQZaAX4AOJL/Ufw/I5GXTYA/IOluApYWTxClcoiI0
         aCpm2QJzFUT6x6uH+W2Y9SaWT08GlwFefbbtFVnnpHwXfl4yJASZZfJrYK7h7Jm4gsY5
         oGng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=NBT3CxRHX8GEU/qW00McBn9/Bm/D8SvEDLg7/zkxpnw=;
        b=YUa1wQka+wsDy2j+2zYNGMB4++dZQXF36CfzMY3vvx1buhRHJ4w3OwOOfEYWbvXqQ8
         WM2GsmgMdhq4mIVeneJsvCXkd7bUUujLuouo62H52tW4+5HX9pE/8syqa6CbTrWFrjIa
         O1oHDVRO8AyLWM8PEJTfXT1JKtfbuFPO2hgMkZchviP7rvch1Wd1ETxr+Yr0BDRN1JHU
         koDF9v+8y7iot4XcJUjR3DpuzzNZ0wFgv89fjxA8WH3HIR8sAFpurVCPl/K7pTPiNBIK
         O7fzmPs+u10o5Vcho4qjXnLM8blf2dqhUwjI3c4vWgbcrl1oQ4We/bMX/UWzStziD89g
         ojLA==
X-Gm-Message-State: ACgBeo0YJtwTZD+xNT6NE4PXDH2F0VKiAagaOkF5L8hRPO4lUU78ptE6
        Ce6kIqebVJsr21mq75fLe0VKHqq2UomXcJYOfNk=
X-Google-Smtp-Source: AA6agR5AnKp+odWvzlCE0vwdUDiPYLBrfL3ynOsCqZwRUi6mSYS4Ae8XqnhvfS7rcEltrdemQERuIMDNocwEywECrDg=
X-Received: from wmcvicker.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5ebe])
 (user=willmcvicker job=sendgmr) by 2002:a63:4566:0:b0:41d:353:46b4 with SMTP
 id u38-20020a634566000000b0041d035346b4mr1135013pgk.316.1660262623928; Thu,
 11 Aug 2022 17:03:43 -0700 (PDT)
Date:   Fri, 12 Aug 2022 00:03:25 +0000
In-Reply-To: <20220812000327.3154251-1-willmcvicker@google.com>
Message-Id: <20220812000327.3154251-2-willmcvicker@google.com>
Mime-Version: 1.0
References: <20220812000327.3154251-1-willmcvicker@google.com>
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [PATCH v4 1/2] PCI: dwc: Drop dependency on ZONE_DMA32
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
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
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
2.37.1.559.g78731f0fdb-goog

