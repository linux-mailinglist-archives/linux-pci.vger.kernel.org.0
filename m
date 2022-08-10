Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA2658F4B8
	for <lists+linux-pci@lfdr.de>; Thu, 11 Aug 2022 01:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233655AbiHJXPC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Aug 2022 19:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233650AbiHJXPB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Aug 2022 19:15:01 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18700796AB
        for <linux-pci@vger.kernel.org>; Wed, 10 Aug 2022 16:14:59 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id h185-20020a636cc2000000b00419b8e7df69so6202751pgc.18
        for <linux-pci@vger.kernel.org>; Wed, 10 Aug 2022 16:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=Zr/UchgjXaQRCvax9ebUMELOtk9TJjfU+PyC7ZvpbdY=;
        b=ZU9JgHhBYxLYQg88eeROGn3iAG7F2SJ0MGJtVSYrGsYzqTMRzAuYm2qDOcM1ooWoiy
         mYzx8yZ+J+aJoUqLVeBLSDNhwKY/hKEkqTiCTcOr87K5XYKUx00EyzM673WyiqujzP7e
         olL02JmO5ZBGgET3QrTRBgEdDJlZQhP54YvEhP9C2dQAz+QjHEEzkirFQsEyWpOv/EF4
         G4kBC5SPmrk5jsMX1nIS032a6gyoNPZMGvjnf4h8hw8UedyXgBmzsKjviWXrpfpkoY71
         jbUNHeyfTuS4cS8D7bNtEbHP79c1444zBgvYiEwD1byaaoMnFZ7hYWBUhT6hJN3MoEsH
         uA8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=Zr/UchgjXaQRCvax9ebUMELOtk9TJjfU+PyC7ZvpbdY=;
        b=0+mWdg+E+6WFW5zQXOerVZTPDecAUU5g7Q1otVi0vwOMxFSbctQ3tvGqLvLKTbEIju
         2u5eRyrrzSo5+KwW8EaF8QFeZFp+khEMENVyFwT0/Ea46xP8o8WppJjWj4yoKJxYhQo6
         V6WZDZAU0fyr87axTCE9KC1HkhEH9fPzWf3NkU0Xa0jq0Ms4FLGDK3go9V8IUkcD+/IM
         6MjXmqsmT7VDNjBySdEwNKNUW5T+G7QKMBUET4DolF+Y+3Q1qUy+RpP8/Z9VtuWRXzsi
         HTONWaavh8AQSi7rxgmtBIpV6SwcyShpEo13sz4NFjwbX78aamxA0rNQoDHP97ogYfu1
         bxGw==
X-Gm-Message-State: ACgBeo1vPVNYQZ8bAc/pyRDi8KWDK9Lkk3uJEgSKDdXlKmvobmGLEsI1
        GpmcEu/Vf07/75YApkNH/c48xCGcxJF3Pj6X78o=
X-Google-Smtp-Source: AA6agR4KHtxXUDPPXDyjCrJbRcOdxSKoQXTvCjqDztdp79bk2f+zMVtaHn1ptyH11eQs8W0rfiwtB0Yl7gZwLUfXl7E=
X-Received: from wmcvicker.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5ebe])
 (user=willmcvicker job=sendgmr) by 2002:a63:ea11:0:b0:41d:9296:21e6 with SMTP
 id c17-20020a63ea11000000b0041d929621e6mr11622524pgi.603.1660173298625; Wed,
 10 Aug 2022 16:14:58 -0700 (PDT)
Date:   Wed, 10 Aug 2022 23:14:43 +0000
In-Reply-To: <20220810231445.2242126-1-willmcvicker@google.com>
Message-Id: <20220810231445.2242126-2-willmcvicker@google.com>
Mime-Version: 1.0
References: <20220810231445.2242126-1-willmcvicker@google.com>
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [PATCH v3 1/2] PCI: dwc: drop dependency on ZONE_DMA32
From:   Will McVicker <willmcvicker@google.com>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        "=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?=" <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Will McVicker <willmcvicker@google.com>
Cc:     kernel-team@android.com, Vidya Sagar <vidyas@nvidia.com>,
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
uses the coherent DMA mask to try and return an allocation within the DMA
mask limits. With that, we can now drop the msi_page parameter in struct
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

