Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B2D58F26E
	for <lists+linux-pci@lfdr.de>; Wed, 10 Aug 2022 20:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232835AbiHJSf5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Aug 2022 14:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233582AbiHJSfy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Aug 2022 14:35:54 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67BE5720D
        for <linux-pci@vger.kernel.org>; Wed, 10 Aug 2022 11:35:53 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id v65-20020a626144000000b0052f89472f54so3444834pfb.11
        for <linux-pci@vger.kernel.org>; Wed, 10 Aug 2022 11:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=uv8ak0kfVqp7yv0xyscnxE/AIYOJ9hrsgPAz5hkx6v0=;
        b=K2Ilv/NLIJPQNt1VDFBArRwGT0aWo1Jm8oiRgST50kFGhBTSlT4RrRdyJvMWxO87dp
         O9KVMKGSVU/hT5a8L1WoGSouwVmKm0VkJmg/yXMpVT7SlW1KklL/nBVIXyYYNsEmI+j5
         wIDzsy5pNUvjIVA6KGNhuQplNhROOZyfdnEdMgI/SSczI8yp/aRuQQQCrQcNCEMOgeZ/
         xuobD3T//FAeh1Q0XbWxvKVIYkCrCQ/Di8JmpJaoACSwd9mFNRXkUZXR7M61s13NLtrh
         GzV+blARRmmohSrsuJO2lS3BWuD8TasATxwBGI2RM2P2e2eizLXrttU2P3EsVcxUAnVy
         XgeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=uv8ak0kfVqp7yv0xyscnxE/AIYOJ9hrsgPAz5hkx6v0=;
        b=V4usKTiws2fbRjL+hft9NSNNw3xdMCjB+V0CXDbNm1n/OLxYkvhrWXFu03vipyS/8d
         jxLEssvR60elJIT60lg0wXRMKbQfSf/0OFpSj9dKJ0IcwY9PAIw29nfSjjeDiJjQyBbe
         vosH0/nu6RJezeFrOoBEQanm+BvVg5k00IhWD7x9VDJMvX4BkRm0FOTV1IlsQ4bsqElS
         tXLPkx+cq7bQrFbxvdMW1q0abjOf3N1qyfCFt7GWeBi4ljPktHG6DSLtu6Y3kNS1RLXa
         /cREjS8dLKUde7MHdnoGZ6UTmzSyrHroclaFGA4lFgW17yzOjzuRiQHJqbkGyELIjRoN
         vnsQ==
X-Gm-Message-State: ACgBeo3+J+R/mKlnj1tsaIoANSHt8x8oAVr+fBowZN3Z8SWxTeeJ5Enr
        RH25D8UDE/fBc05Z3mzoS2gllo/TIRSdwOMVS7g=
X-Google-Smtp-Source: AA6agR5obXIExAhqkoSR0o/c5ibnWODXMfJdOKNqvgARm+4EQBilI3PzRBErb77178JnLMQJgOGeKogjUN9YkfMjZ8c=
X-Received: from wmcvicker.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5ebe])
 (user=willmcvicker job=sendgmr) by 2002:a17:902:da8f:b0:16f:e43:efda with
 SMTP id j15-20020a170902da8f00b0016f0e43efdamr28615371plx.164.1660156553111;
 Wed, 10 Aug 2022 11:35:53 -0700 (PDT)
Date:   Wed, 10 Aug 2022 18:35:35 +0000
In-Reply-To: <20220810183536.1630940-1-willmcvicker@google.com>
Message-Id: <20220810183536.1630940-3-willmcvicker@google.com>
Mime-Version: 1.0
References: <20220810183536.1630940-1-willmcvicker@google.com>
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [PATCH v2 2/2] PCI: dwc: add support for 64-bit MSI target address
From:   Will McVicker <willmcvicker@google.com>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        "=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?=" <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Will McVicker <willmcvicker@google.com>
Cc:     kernel-team@android.com, Vidya Sagar <vidyas@nvidia.com>,
        kernel test robot <lkp@intel.com>,
        "Isaac J . Manjarres" <isaacmanjarres@google.com>,
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

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Will McVicker <willmcvicker@google.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 14 ++++++++++++--
 drivers/pci/controller/dwc/pcie-designware.c      |  9 +++++++++
 drivers/pci/controller/dwc/pcie-designware.h      |  1 +
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 8f2222f51671..2b9b63489415 100644
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
index 09b887093a84..4631e26ba6c5 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -333,6 +333,7 @@ void dw_pcie_version_detect(struct dw_pcie *pci);
 
 u8 dw_pcie_find_capability(struct dw_pcie *pci, u8 cap);
 u16 dw_pcie_find_ext_capability(struct dw_pcie *pci, u8 cap);
+u16 dw_pcie_msi_capabilities(struct dw_pcie *pci);
 
 int dw_pcie_read(void __iomem *addr, int size, u32 *val);
 int dw_pcie_write(void __iomem *addr, int size, u32 val);
-- 
2.37.1.559.g78731f0fdb-goog

