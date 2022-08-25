Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B135A1D5E
	for <lists+linux-pci@lfdr.de>; Fri, 26 Aug 2022 01:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244229AbiHYXyS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Aug 2022 19:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244209AbiHYXyN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Aug 2022 19:54:13 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867A9C6516
        for <linux-pci@vger.kernel.org>; Thu, 25 Aug 2022 16:54:11 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id bd20-20020a056a00279400b0053609a39408so17948pfb.3
        for <linux-pci@vger.kernel.org>; Thu, 25 Aug 2022 16:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=tygyO2PFYuXfHZyst5i+EgaagTYAQzq4it8NYXlV8yE=;
        b=TNTdH/vcnr1azAqTc4UnDItuLwArV7U663pOgFTWZP1TEkiNOgBKF7Q+Tm4j0k4YP7
         8uCEE4BgoJLlFI8w/NmSq0urroZG6wu/Kqo3JqkMx+P00IDv3LaImwz4qAWrF/gqFlfu
         hCL/0qEC4fX1EQmoeLpToGHMsf/8OFOl2pKwh8A9TYltlhYewqws6me8Pk/iYAdbTDmL
         DbkelJ6Ct7+LDeTIVUF2YG2W92/av3TI0nU6EMDFYCNvliIw3sZd3S4mVZf3Ea1wrgXw
         2CiXvblz2DHKOQ6NACcQnHtXPvx+dyYQrbJpbggdTfgnAT9csSNR0jh0FLQYmRhc8Han
         9OPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=tygyO2PFYuXfHZyst5i+EgaagTYAQzq4it8NYXlV8yE=;
        b=oprc79ybnsXrs9+9OSsuo0fZbEdj+sQiLsU8PrJT647IBa38GstPRE9jVgT8CLTIU/
         EgSyEd/Bjv7yDD6yrbtGquUjDCk2mKXW9ZY8ytiz/tHlbUGBdJ4yvxartSJUyIjBFWK2
         8nQlFNo5MeaG0X6vkh7+lv1UqJm+xL0c0yrkWe7pJy6OyxcD53uzJI4KU5Ma6Xd9oX7V
         zAMdXxbhEHN/h9eQZQfBT4LfCYHgiMURVaujWK7+jpLF6ppiwt3ler+J2ME6d9lKXSjt
         zbzTlaMQzbJZSN/3ty4GhJFWuaHCOsVbUh+WUHXuoiRCtNG3DJnGjUY/O4DJdwoiccp0
         FyBg==
X-Gm-Message-State: ACgBeo2rVDWSRKdTTOKQLoyzT/R195ABcWTrureHS95IP+ugPSfp3oHE
        kApyWbdRgRy7tehMb8KTkYZZTuNvqKwtvxOqIxs=
X-Google-Smtp-Source: AA6agR66Ef/rjMhqWVcBhDQTJkwW+HndjqAueSvfGx9h6HPfdBzfubtsbOn8V5UByZqJQSoZJYyfQxRKjDaajpJ5zNw=
X-Received: from wmcvicker.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5ebe])
 (user=willmcvicker job=sendgmr) by 2002:a17:90a:e558:b0:1fb:c4b7:1a24 with
 SMTP id ei24-20020a17090ae55800b001fbc4b71a24mr84011pjb.1.1661471650555; Thu,
 25 Aug 2022 16:54:10 -0700 (PDT)
Date:   Thu, 25 Aug 2022 23:54:02 +0000
In-Reply-To: <20220825235404.4132818-1-willmcvicker@google.com>
Mime-Version: 1.0
References: <20220825235404.4132818-1-willmcvicker@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220825235404.4132818-2-willmcvicker@google.com>
Subject: [PATCH v6 1/2] PCI: dwc: Drop dependency on ZONE_DMA32
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

