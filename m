Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A644E58DD9C
	for <lists+linux-pci@lfdr.de>; Tue,  9 Aug 2022 20:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245075AbiHISCU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Aug 2022 14:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344329AbiHISBx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Aug 2022 14:01:53 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678A4DB5
        for <linux-pci@vger.kernel.org>; Tue,  9 Aug 2022 11:01:08 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id b8-20020a17090a010800b001f1f4fc8178so5091042pjb.8
        for <linux-pci@vger.kernel.org>; Tue, 09 Aug 2022 11:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=0naQsNDIr7/tAK4RQoashO+D0OWwjfQP9uh6N2f59FQ=;
        b=E0OZstROSh47tpxJpKX8HBf3moLKJy6IFfy5NC6Hdzk0TlaJw8ObdAjRoyJkZOub/n
         65iscEokmC+ZvKgUCnkydveYOtQ6dpB5plLMkvBOr7wP6ZWHsTfCS6f/gQYq9nN2YXVj
         MBV/LRFKcVeiqThCoaxjac2rfymZGfHhvJTTe/tVwqOQ+ziqt6HWSOii2XsUBNyOd+Ys
         cgE3EZHeickYunSaJVvj4WRSHSpRssiPMyL2uHKkwkDjzcJshWYOENq1rVPncvwZzWYX
         VyyfaLgtIxFWEFRG0HEecXYX3KwnuVm21ycKciBHsAQeGwSdiEYeGlJuwzfrV2uUZ0gO
         4Spg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=0naQsNDIr7/tAK4RQoashO+D0OWwjfQP9uh6N2f59FQ=;
        b=i2L80hjlgsb3s03nFiYuERV1/h/5yNFjsZFeddx72H4njoZQwzSwunXciG76afSzRS
         AAb6qLb1u1SwoZ2naa+TYm4YUq0aPqFJW3nZVkGtq1zOHeiVr9Kq9CHz2FMus/L+HMBf
         IXIqYrSs5+8qnbv7vzUs22u04g8TPRiFsNwcIW05b6ekQkFQfsZNLmQqanCGFFlbllQ1
         rYWw4H3Jndk2jBz5icUgT7r4O+PtYjTlOuMDiiFeBmym5WHC99E92Ws6kNPmHuQe7Go4
         /kTAm8VesOr+UPsQP9YpVb2IEFdBzHNbpu3h+mbCzjC+2RyeFehI3qAYhezsJUGxS+VO
         /wsQ==
X-Gm-Message-State: ACgBeo0BNQIdtUBIaZ3tHYaefgZhfHD39A19AOG/Da6oTocqyaBwJgsS
        EVrbmlH5QqjnJHIEFZMqHgNwAK6tQa3wPaI4sS8=
X-Google-Smtp-Source: AA6agR48VRt/dvuYwc+vflV/Z+atvVVKkGsHFrM7H1GhF17Pfeyb5NTYc06R9UeQBXtLcDO2b7iYAntU0oxxR0aEKVM=
X-Received: from wmcvicker.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5ebe])
 (user=willmcvicker job=sendgmr) by 2002:a17:903:234d:b0:16f:3e9:491b with
 SMTP id c13-20020a170903234d00b0016f03e9491bmr24194019plh.89.1660068067582;
 Tue, 09 Aug 2022 11:01:07 -0700 (PDT)
Date:   Tue,  9 Aug 2022 18:00:50 +0000
In-Reply-To: <20220809180051.1063653-1-willmcvicker@google.com>
Message-Id: <20220809180051.1063653-3-willmcvicker@google.com>
Mime-Version: 1.0
References: <20220809180051.1063653-1-willmcvicker@google.com>
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [PATCH v1 2/2] PCI: dwc: add support for 64-bit MSI target address
From:   Will McVicker <willmcvicker@google.com>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        "=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?=" <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Will McVicker <willmcvicker@google.com>
Cc:     kernel-team@android.com, Vidya Sagar <vidyas@nvidia.com>,
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

Since not all devices require a 32-bit MSI address, add support to the
PCIe host driver to allow setting the DMA mask to 64-bits. This allows
kernels to disable ZONE_DMA32 and bounce buffering (swiotlb) without
risking not being able to get a 32-bit address during DMA allocation.
Basically, in the slim chance that there are no 32-bit allocations
available, the current PCIe host driver will fail to allocate the
msi_msg page due to a DMA address overflow (seen in [1]). With this
patch, the PCIe driver can advertise 64-bit support via it's MSI
capabilities to hint to the PCIe host driver to set the DMA mask to
64-bits.

[1] https://lore.kernel.org/all/Yo0soniFborDl7+C@google.com/

Signed-off-by: Will McVicker <willmcvicker@google.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 14 ++++++++++++--
 drivers/pci/controller/dwc/pcie-designware.c      |  9 +++++++++
 drivers/pci/controller/dwc/pcie-designware.h      |  6 ++++++
 3 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 0cfc3c098f13..630615719236 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -338,6 +338,8 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
 	struct platform_device *pdev = to_platform_device(dev);
 	int ret;
 	u32 ctrl, num_ctrls;
+	bool msi_64b = false;
+	u16 msi_capabilities;
 
 	for (ctrl = 0; ctrl < MAX_MSI_CTRLS; ctrl++)
 		pp->irq_mask[ctrl] = ~0;
@@ -375,9 +377,17 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
 						    dw_chained_msi_isr, pp);
 	}
 
-	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
+	msi_capabilities = dw_pcie_msi_capabilities(pci);
+	if (msi_capabilities & PCI_MSI_FLAGS_ENABLE)
+		msi_64b = msi_capabilities & PCI_MSI_FLAGS_64BIT ? true : false;
+
+	dev_dbg(dev, "Setting MSI DMA mask to %s-bit.\n",
+		msi_64b ? "64" : "32");
+	ret = dma_set_mask_and_coherent(dev, msi_64b ?
+					DMA_BIT_MASK(64) : DMA_BIT_MASK(32));
 	if (ret)
-		dev_warn(dev, "Failed to set DMA mask to 32-bit. Devices with only 32-bit MSI support may not work properly\n");
+		dev_warn(dev, "Failed to set DMA mask to %s-bit.\n",
+			 msi_64b ? "64" : "32");
 
 	pp->msi_page = dma_alloc_coherent(dev, PAGE_SIZE, &pp->msi_data,
 					  GFP_KERNEL);
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index c6725c519a47..8ed402307d7f 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -82,6 +82,15 @@ u8 dw_pcie_find_capability(struct dw_pcie *pci, u8 cap)
 }
 EXPORT_SYMBOL_GPL(dw_pcie_find_capability);
 
+u16 dw_pcie_msi_capabilities(struct dw_pcie *pci)
+{
+	u8 offset;
+
+	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_MSI);
+	return dw_pcie_readw_dbi(pci, offset + PCI_MSI_FLAGS);
+}
+EXPORT_SYMBOL_GPL(dw_pcie_msi_capabilities);
+
 static u16 dw_pcie_find_next_ext_capability(struct dw_pcie *pci, u16 start,
 					    u8 cap)
 {
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 09b887093a84..70a251c8f72b 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -432,6 +432,7 @@ void dw_pcie_host_deinit(struct dw_pcie_rp *pp);
 int dw_pcie_allocate_domains(struct dw_pcie_rp *pp);
 void __iomem *dw_pcie_own_conf_map_bus(struct pci_bus *bus, unsigned int devfn,
 				       int where);
+u16 dw_pcie_msi_capabilities(struct dw_pcie *pci);
 #else
 static inline irqreturn_t dw_handle_msi_irq(struct dw_pcie_rp *pp)
 {
@@ -462,6 +463,11 @@ static inline void __iomem *dw_pcie_own_conf_map_bus(struct pci_bus *bus,
 {
 	return NULL;
 }
+
+static inline u16 dw_pcie_msi_capabilities(struct dw_pcie *pci)
+{
+	return 0;
+}
 #endif
 
 #ifdef CONFIG_PCIE_DW_EP
-- 
2.37.1.559.g78731f0fdb-goog

