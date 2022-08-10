Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E497058F4BA
	for <lists+linux-pci@lfdr.de>; Thu, 11 Aug 2022 01:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233668AbiHJXPG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Aug 2022 19:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233665AbiHJXPE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Aug 2022 19:15:04 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF4B7C1A7
        for <linux-pci@vger.kernel.org>; Wed, 10 Aug 2022 16:15:02 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id j184-20020a6255c1000000b0052d459139a3so7010166pfb.4
        for <linux-pci@vger.kernel.org>; Wed, 10 Aug 2022 16:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=GOce7Y6jdCY/zfkNNeO74zrYEvTJd53x8wkrPeEDjgU=;
        b=ESsqWe3q8UeR7CxcjqoZATYdaP+BDRWBc4eIg8oOW2jltJ7lFVgCYASg5Xgtje53VN
         DvVALBqdXWfXdNFYD0+7+VaPzxJjbBABh1JHvq5HYO7yAHAQusqnUlLTjasjKPmsuRvJ
         eCighSfmzf/OPh4tmTfsixyppIzhMX0fQ0pBKDH2irzUdCzWS4c28SF2roUkSibwCrPy
         lUUryf/wH04POtNjy54uxDvYDHR0KB3Ph190dCSMdLJ8GZ6AY13VTU0k/qLkZTjlX6Zt
         1Xvm78AUqy1IqRVJkVMWn5pYC3MixJwdOyy2+mAhEfHZwyeOcFERDQMvru1vqi3cVq6e
         me4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=GOce7Y6jdCY/zfkNNeO74zrYEvTJd53x8wkrPeEDjgU=;
        b=QTLRSkYEsmvbAxjfsY6bbLl/YI9aA10ECNqkTEDirT9UllqjbWQmUKYOVKJm/oUn9t
         QUq5YWXpT9ulRQX3K5CZpCtAi8jB2yXDen7CQr7yeuIEl3YkJbIrAuhs7EtlTntFD+hz
         JgHVcwhUS/t4l8UrO/k79t+mqOvNK30kgZxdsu29MzJpLrKyyN/BjtPmYkXXv0T+o/NE
         8NrixrWVEO6e3UPiBoy4f+LH9XnbVuFsP19WCUn+dIFtCKympK9sbzAMBoqyKoFaKlpB
         TM5NHh/CE/nf3QukeiF/+73OlFDL6Tx9ov6t1SNjdeV4UGOI+Cd3g9fzkivmjrxpI/zM
         Sq/A==
X-Gm-Message-State: ACgBeo2hBklcjOsFFVr1WOu8PiYetizBqaUBo4VmPptzlK9C+Be4OClW
        cQVuYzlswndQJj74fOrTXeg/BRBuwnnOwWMC27g=
X-Google-Smtp-Source: AA6agR6OHCmnn8tCZdB3wLnDYiSz4MjJQaPKAnZVBxL4jkwALTzbKb5l7EwTPFYBGXhMb4ufXWIlKKqjMss8REmZi3g=
X-Received: from wmcvicker.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5ebe])
 (user=willmcvicker job=sendgmr) by 2002:a17:902:b484:b0:170:a2d8:80f6 with
 SMTP id y4-20020a170902b48400b00170a2d880f6mr16898465plr.97.1660173302008;
 Wed, 10 Aug 2022 16:15:02 -0700 (PDT)
Date:   Wed, 10 Aug 2022 23:14:44 +0000
In-Reply-To: <20220810231445.2242126-1-willmcvicker@google.com>
Message-Id: <20220810231445.2242126-3-willmcvicker@google.com>
Mime-Version: 1.0
References: <20220810231445.2242126-1-willmcvicker@google.com>
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [PATCH v3 2/2] PCI: dwc: add support for 64-bit MSI target address
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
        kernel test robot <lkp@intel.com>
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
Reviewed-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 14 ++++++++++++--
 drivers/pci/controller/dwc/pcie-designware.c      |  9 +++++++++
 drivers/pci/controller/dwc/pcie-designware.h      |  1 +
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 39f3b37d4033..18cf96f911dc 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -330,6 +330,8 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
 	u64 *msi_vaddr;
 	int ret;
 	u32 ctrl, num_ctrls;
+	bool msi_64b = false;
+	u16 msi_capabilities;
 
 	for (ctrl = 0; ctrl < MAX_MSI_CTRLS; ctrl++)
 		pp->irq_mask[ctrl] = ~0;
@@ -367,9 +369,17 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
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
 
 	msi_vaddr = dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data,
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
2.37.1.559.g78731f0fdb-goog

