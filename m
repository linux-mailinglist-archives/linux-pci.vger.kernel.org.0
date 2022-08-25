Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5255A1914
	for <lists+linux-pci@lfdr.de>; Thu, 25 Aug 2022 20:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243480AbiHYSvT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Aug 2022 14:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243512AbiHYSvK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Aug 2022 14:51:10 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF2FB4E80
        for <linux-pci@vger.kernel.org>; Thu, 25 Aug 2022 11:51:09 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id v65-20020a626144000000b0052f89472f54so9456327pfb.11
        for <linux-pci@vger.kernel.org>; Thu, 25 Aug 2022 11:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=lGAqB/GNmrDPPkV5jr9OoJ3q9SKii5qWo4ibcFCW7eo=;
        b=DeaANBLOlr0ppKzAtlWXDTLwAmUNq9XIpss/f40nbT0JHkuWGR7LsYXfdKztC0j5gG
         HiOL2Xh6qQRXSJDdzCKZi86XRNjr6lrlmT4k65meiRrXvQq5u8rPZ3QJXOLKt7FeYyJa
         5M/Z7/erNaZfGrGdUgBr3uSIceCSe5Ul3oByGVVKVt8shq0Uyl3ye9j5cfxJrHtAGBLi
         n8Xc1I5FWqMB/sqcuTWOL44ocC8VC8HYMbmx2Ut8ILk4wYhQrwRDmBf/8XaIc0Xt+vg/
         vt0P6bTefJ956in4EEkcFKuJfzj8EmfCd7DSYWZ8D+2hdwGwyr4t4fewwhKKY6ql0aes
         YuxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=lGAqB/GNmrDPPkV5jr9OoJ3q9SKii5qWo4ibcFCW7eo=;
        b=NKFBnxIp5BH2idTQtjscbqoj2NPw0lfG+pMpsJenAFpLnL2py7HqEXL5MfZFDMRK6p
         pKJlsmaC0S+JNKYegw8Cm/B1dU9F23ftK6B0+CnRGXmIPHQPy6MKLI5kjL4SoSr83T7c
         Z640IfDCxPeguKgfm0o2lx+ZqxaEJsLBtcfXuv9faP3Hg2u8jvWd7xJvSiClH3NdnYGl
         gTfe17r1xFkipqxlO1LjjLBmf9mSdckNlub9x86y+x4SdE0sCX0/mVJjKFm1pPSucf/M
         h7siBad1NhB5d8S92+2ictjNZqZE9WnctHhUpqdzElyA/eH2LjaMj6VkebKvbc2uccJr
         Nbsg==
X-Gm-Message-State: ACgBeo35ynmDvot4WuAW6VjG2fY6MaiLJ75WAgjtMDPNEV2L2XduyxLC
        BH8EOo6Y055LbtFhE/F8vInGKmlSi7Dh2fzT8jQ=
X-Google-Smtp-Source: AA6agR6e/9WCXUqGwvrKzxvLN5CnU2/oDCiswJkCrhOMct7DE+11zW5i2jVa12mcZbU1eqo8VEXW5A18uJTrWpZYsoU=
X-Received: from wmcvicker.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5ebe])
 (user=willmcvicker job=sendgmr) by 2002:a17:90a:e558:b0:1fb:c4b7:1a24 with
 SMTP id ei24-20020a17090ae55800b001fbc4b71a24mr19452pjb.1.1661453467971; Thu,
 25 Aug 2022 11:51:07 -0700 (PDT)
Date:   Thu, 25 Aug 2022 18:50:25 +0000
In-Reply-To: <20220825185026.3816331-1-willmcvicker@google.com>
Mime-Version: 1.0
References: <20220825185026.3816331-1-willmcvicker@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220825185026.3816331-3-willmcvicker@google.com>
Subject: [PATCH v5 2/2] PCI: dwc: Add support for 64-bit MSI target address
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
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
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
PCIe host driver to allow setting the DMA mask to 64-bits if the 32-bit
allocation fails. This allows kernels to disable ZONE_DMA32 and bounce
buffering (swiotlb) without risking not being able to get a 32-bit address
during DMA allocation.

Basically, in the slim chance that there are no 32-bit allocations
available, the current PCIe host driver will fail to allocate the msi_msg
page due to a DMA address overflow (seen in [1]). With this patch, the
PCIe host can retry the allocation with a 64-bit DMA mask if the current
PCIe device advertises 64-bit support via its MSI capabilities.

[1] https://lore.kernel.org/all/Yo0soniFborDl7+C@google.com/

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Will McVicker <willmcvicker@google.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Jingoo Han <jingoohan1@gmail.com>
---
 .../pci/controller/dwc/pcie-designware-host.c | 38 ++++++++++++++-----
 drivers/pci/controller/dwc/pcie-designware.c  |  8 ++++
 drivers/pci/controller/dwc/pcie-designware.h  |  1 +
 3 files changed, 38 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 39f3b37d4033..8928a9a29d58 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -330,6 +330,9 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
 	u64 *msi_vaddr;
 	int ret;
 	u32 ctrl, num_ctrls;
+	bool msi_64bit = false;
+	bool retry_64bit = false;
+	u16 msi_capabilities;
 
 	for (ctrl = 0; ctrl < MAX_MSI_CTRLS; ctrl++)
 		pp->irq_mask[ctrl] = ~0;
@@ -367,16 +370,33 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
 						    dw_chained_msi_isr, pp);
 	}
 
-	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
-	if (ret)
-		dev_warn(dev, "Failed to set DMA mask to 32-bit. Devices with only 32-bit MSI support may not work properly\n");
+	msi_capabilities = dw_pcie_msi_capabilities(pci);
+	if (msi_capabilities & PCI_MSI_FLAGS_ENABLE)
+		msi_64bit = msi_capabilities & PCI_MSI_FLAGS_64BIT;
 
-	msi_vaddr = dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data,
-					GFP_KERNEL);
-	if (!msi_vaddr) {
-		dev_err(dev, "Failed to alloc and map MSI data\n");
-		dw_pcie_free_msi(pp);
-		return -ENOMEM;
+	while (true) {
+		dev_dbg(dev, "Setting MSI DMA mask to %s-bit.\n",
+			retry_64bit ? "64" : "32");
+		ret = dma_set_mask_and_coherent(dev, retry_64bit ?
+						DMA_BIT_MASK(64) :
+						DMA_BIT_MASK(32));
+		if (ret)
+			dev_warn(dev, "Failed to set DMA mask to %s-bit.\n",
+				 retry_64bit ? "64" : "32");
+
+		msi_vaddr = dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data,
+						GFP_KERNEL);
+		if (!msi_vaddr) {
+			dev_err(dev, "Failed to alloc and map MSI data\n");
+			if (msi_64bit && !retry_64bit) {
+				retry_64bit = true;
+				continue;
+			}
+
+			dw_pcie_free_msi(pp);
+			return -ENOMEM;
+		}
+		break;
 	}
 
 	return 0;
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index c6725c519a47..650a7f22f9d0 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -82,6 +82,14 @@ u8 dw_pcie_find_capability(struct dw_pcie *pci, u8 cap)
 }
 EXPORT_SYMBOL_GPL(dw_pcie_find_capability);
 
+u16 dw_pcie_msi_capabilities(struct dw_pcie *pci)
+{
+	u8 offset;
+
+	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_MSI);
+	return dw_pcie_readw_dbi(pci, offset + PCI_MSI_FLAGS);
+}
+
 static u16 dw_pcie_find_next_ext_capability(struct dw_pcie *pci, u16 start,
 					    u8 cap)
 {
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index a871ae7eb59e..45fcdfc8c035 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -332,6 +332,7 @@ void dw_pcie_version_detect(struct dw_pcie *pci);
 
 u8 dw_pcie_find_capability(struct dw_pcie *pci, u8 cap);
 u16 dw_pcie_find_ext_capability(struct dw_pcie *pci, u8 cap);
+u16 dw_pcie_msi_capabilities(struct dw_pcie *pci);
 
 int dw_pcie_read(void __iomem *addr, int size, u32 *val);
 int dw_pcie_write(void __iomem *addr, int size, u32 val);
-- 
2.37.2.672.g94769d06f0-goog

