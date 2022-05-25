Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 155F353467F
	for <lists+linux-pci@lfdr.de>; Thu, 26 May 2022 00:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237597AbiEYWeB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 May 2022 18:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232822AbiEYWeA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 May 2022 18:34:00 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB047FD08
        for <linux-pci@vger.kernel.org>; Wed, 25 May 2022 15:33:58 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id nn14-20020a17090b38ce00b001e00df82de8so2020124pjb.1
        for <linux-pci@vger.kernel.org>; Wed, 25 May 2022 15:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ZyIIorKaUER6LtO0NEcxpfUt30IgN+0/p0qPefAvRDM=;
        b=KEQ8220B+o1IAuHb1yGZnxebmZq0POedJgpa1YqeUfAytXWe34R5nCB8Az52B0eM/M
         tBlr2pJ62Qb5n59net1LP+4gczmyU+3F1TjQKx1KdBaFEjVbLQi/ROhjkhXY6qfwMMNO
         2CKQtsBmKqsZF3I2Zhb2SL5E8QarPHLKZ0vMUA8INy2HguvbiG0PtKwzj2yr4LYu7z6t
         1Ol73eKjkz7ut0ImXV/H4XMQXBMPpTDzm3jEQZtoxLTkY2SReYqnFTlp0trVHmUurRAm
         yFaJNjvH7qRufXPZzxT0SR3simhLIz4bPyxQnGXKekY96Y10Q9Jg47tPdB4grmJpXAgi
         mupA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ZyIIorKaUER6LtO0NEcxpfUt30IgN+0/p0qPefAvRDM=;
        b=CQ08VNVjj+6AJV2k5s3CDMFGsU2PhYMmTrTC7MBhqpfnyvq/nM7dLRaZAMQFZsGuWD
         XElq3BF7wV+dUFWviKydfqTIvYo3LvbebcvANHvj1Bh5t9T9xnec9Mu1YRTZdnajXCgc
         tqJVzPnPqMd/UBPQIqJLYcawJODGBJmihAz9LPWO4/Y8EPlY7zRwxtojO5L2Z2cV0nbm
         bUyTDUZHIyGLOPsUGjey3qVH7HJofm2fiz5y7i2xlpee9p0URDNMQkxJelg8XiKepi3T
         r64dYMCexQ2g3h96mKKbaTbQbkOIXEWdntRTIhVXJJRt9AYKj8mmPfyDb13ysLTomxuT
         FnGw==
X-Gm-Message-State: AOAM530fqd8N+aqZuogRswSTsMxke8n7Wq9I1aOLhh97ZkDHYpyqbtb8
        orMWHqPNPEJrieeYl8cWtxoiZG6FavPird27vbw=
X-Google-Smtp-Source: ABdhPJzxJKUCpKjTUBjtan2qU2XEohu8OHlV0MifZ+uRWy3GDLz1i97cXxGi8swtD+kf9CiHBjIQjNc+Qxqei4OZWIc=
X-Received: from willmcvicker.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:2dd0])
 (user=willmcvicker job=sendgmr) by 2002:a17:90a:d3d2:b0:1dd:30bb:6a45 with
 SMTP id d18-20020a17090ad3d200b001dd30bb6a45mr12943653pjw.206.1653518038298;
 Wed, 25 May 2022 15:33:58 -0700 (PDT)
Date:   Wed, 25 May 2022 22:33:16 +0000
Message-Id: <20220525223316.388490-1-willmcvicker@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
Subject: [PATCH v1 1/1] PCI: dwc: Fix MSI msi_msg dma mapping
From:   Will McVicker <willmcvicker@google.com>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        "=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?=" <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     kernel-team@android.com, Vidya Sagar <vidyas@nvidia.com>,
        Will McVicker <willmcvicker@google.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
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

As of commit 07940c369a6b ("PCI: dwc: Fix MSI page leakage in
suspend/resume"), the PCIe designware host driver has been using the
driver data allocation for the msi_msg dma mapping which can result in
a DMA_MAPPING_ERROR due to the DMA overflow check in
dma_direct_map_page() when the address is greater than 32-bits (reported
in [1]). The commit was trying to address a memory leak on
suspend/resume by moving the MSI mapping to dw_pcie_host_init(), but
subsequently dropped the page allocation thinking it wasn't needed.

To fix the DMA mapping issue as well as make msi_msg DMA'able, let's
switch back to allocating a 32-bit page for the msi_msg. To avoid the
suspend/resume leak, we can allocate the page in dw_pcie_host_init()
since that function shouldn't be called during suspend/resume.

[1] https://lore.kernel.org/all/Yo0soniFborDl7+C@google.com/

Signed-off-by: Will McVicker <willmcvicker@google.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 14 ++++++++------
 drivers/pci/controller/dwc/pcie-designware.h      |  2 +-
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 2fa86f32d964..3655c6f88bf1 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -267,8 +267,9 @@ static void dw_pcie_free_msi(struct pcie_port *pp)
 		struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 		struct device *dev = pci->dev;
 
-		dma_unmap_single_attrs(dev, pp->msi_data, sizeof(pp->msi_msg),
-				       DMA_FROM_DEVICE, DMA_ATTR_SKIP_CPU_SYNC);
+		dma_unmap_page(dev, pp->msi_data, PAGE_SIZE, DMA_FROM_DEVICE);
+		if (pp->msi_page)
+			__free_page(pp->msi_page);
 	}
 }
 
@@ -392,12 +393,13 @@ int dw_pcie_host_init(struct pcie_port *pp)
 			if (ret)
 				dev_warn(pci->dev, "Failed to set DMA mask to 32-bit. Devices with only 32-bit MSI support may not work properly\n");
 
-			pp->msi_data = dma_map_single_attrs(pci->dev, &pp->msi_msg,
-						      sizeof(pp->msi_msg),
-						      DMA_FROM_DEVICE,
-						      DMA_ATTR_SKIP_CPU_SYNC);
+			pp->msi_page = alloc_page(GFP_DMA32);
+			pp->msi_data = dma_map_page(pci->dev, pp->msi_page, 0, PAGE_SIZE,
+						    DMA_FROM_DEVICE);
 			if (dma_mapping_error(pci->dev, pp->msi_data)) {
 				dev_err(pci->dev, "Failed to map MSI data\n");
+				__free_page(pp->msi_page);
+				pp->msi_page = NULL;
 				pp->msi_data = 0;
 				goto err_free_msi;
 			}
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 7d6e9b7576be..b5f528536358 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -190,8 +190,8 @@ struct pcie_port {
 	int			msi_irq;
 	struct irq_domain	*irq_domain;
 	struct irq_domain	*msi_domain;
-	u16			msi_msg;
 	dma_addr_t		msi_data;
+	struct page		*msi_page;
 	struct irq_chip		*msi_irq_chip;
 	u32			num_vectors;
 	u32			irq_mask[MAX_MSI_CTRLS];
-- 
2.36.1.124.g0e6072fb45-goog

