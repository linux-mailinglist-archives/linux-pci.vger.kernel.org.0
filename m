Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1576E59096E
	for <lists+linux-pci@lfdr.de>; Fri, 12 Aug 2022 02:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235278AbiHLADw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Aug 2022 20:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236336AbiHLADw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Aug 2022 20:03:52 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16E6A1D64
        for <linux-pci@vger.kernel.org>; Thu, 11 Aug 2022 17:03:49 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id p36-20020a634f64000000b0041bd62cd236so7035189pgl.14
        for <linux-pci@vger.kernel.org>; Thu, 11 Aug 2022 17:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=m7527aFul0HrbbuBntbmDHrqSY870ZpVEAPOl+klW5o=;
        b=KIzkL7W7UcyQgNv7j41yw7gXPlbta5vSpM+sLv64+9h8DeJlVxAFUP4cNJqnkH7jiE
         fjD5f4ZAtMqMV36gCGWr64gjAYsHT6/5ZSj2aaESnktuYOn0CLmj1TUNuytsh/lqrLcr
         3JD3LXT2HFLoGXq3gMVO5VkpFuhQ1U10zusjtdPPxfCLxAtz/UNW7O8GbYlIm8xkN2jW
         ommfgot9guR5ctGtIINhWDApgcjLbTopVtpHgvaA5u3AcugNDZ6Vt+Ru7RN2e9dsUQOg
         OqoJm7V46OXlZfilSW4vVe5nO+JqPu70Gs5c60X7c7L6nkh13HywJHWbO9w9Dfp0QiWN
         fR4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=m7527aFul0HrbbuBntbmDHrqSY870ZpVEAPOl+klW5o=;
        b=J2f5vnmmOxiieUMt+FCGlYGb/3HTTO6vC2y0SstZ3rUmVxM3/vIi+ZqgfZbaT0d4Wk
         Sn9jMJ9GB7k2/Yqass+nvf/hUjYM/mXMWq7jHtI0Q7PrwRloZkh8U4qKJAjfQeXp164X
         AXUqUPajsaEqNxR5bDqYAcW7PAyWOEd/fVIQbmEKy0TErwIR4WRdJem07HvcCmY0uhTK
         Sei875D114xYLrN4ovsAWrNm/Ld0CrYDmHmAzFPbvo6HzIHBpq1GsOKlw6y9wndcINli
         9EPske7vtLqJ+t2PzR71YKF8QXaD8sGrRG5KsHy0SAynkUe6p1PfTLeYVDVEsmXqXMJ9
         LZWw==
X-Gm-Message-State: ACgBeo3U21odnBcJAoxFSKGviL7pJ8SE6f59Vt6xd8hUn/aiSCQwwjQD
        WkgVM2AdBqi5eyt7fZ21H6i6yP3ARtXF4UKKDcM=
X-Google-Smtp-Source: AA6agR4FCxLHclqHp4BxLS20+HY/XXK8unbv97uKxD3lFIZ6owNRBOayEEByxcRkhZAknDX36DmOhm30IVxmS2LOV3E=
X-Received: from wmcvicker.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5ebe])
 (user=willmcvicker job=sendgmr) by 2002:a05:6a00:23d3:b0:52e:27c8:b8f3 with
 SMTP id g19-20020a056a0023d300b0052e27c8b8f3mr1476118pfc.43.1660262629361;
 Thu, 11 Aug 2022 17:03:49 -0700 (PDT)
Date:   Fri, 12 Aug 2022 00:03:26 +0000
In-Reply-To: <20220812000327.3154251-1-willmcvicker@google.com>
Message-Id: <20220812000327.3154251-3-willmcvicker@google.com>
Mime-Version: 1.0
References: <20220812000327.3154251-1-willmcvicker@google.com>
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [PATCH v4 2/2] PCI: dwc: Add support for 64-bit MSI target address
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
patch, the PCIe device can advertise 64-bit support via its MSI
capabilities to hint to the PCIe host driver to set the DMA mask to
64-bits.

[1] https://lore.kernel.org/all/Yo0soniFborDl7+C@google.com/

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Will McVicker <willmcvicker@google.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 14 ++++++++++++--
 drivers/pci/controller/dwc/pcie-designware.c      |  8 ++++++++
 drivers/pci/controller/dwc/pcie-designware.h      |  1 +
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 39f3b37d4033..d7831040791b 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -330,6 +330,8 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
 	u64 *msi_vaddr;
 	int ret;
 	u32 ctrl, num_ctrls;
+	bool msi_64bit = false;
+	u16 msi_capabilities;
 
 	for (ctrl = 0; ctrl < MAX_MSI_CTRLS; ctrl++)
 		pp->irq_mask[ctrl] = ~0;
@@ -367,9 +369,17 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
 						    dw_chained_msi_isr, pp);
 	}
 
-	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
+	msi_capabilities = dw_pcie_msi_capabilities(pci);
+	if (msi_capabilities & PCI_MSI_FLAGS_ENABLE)
+		msi_64bit = msi_capabilities & PCI_MSI_FLAGS_64BIT;
+
+	dev_dbg(dev, "Setting MSI DMA mask to %s-bit.\n",
+		msi_64bit ? "64" : "32");
+	ret = dma_set_mask_and_coherent(dev, msi_64bit ?
+					DMA_BIT_MASK(64) : DMA_BIT_MASK(32));
 	if (ret)
-		dev_warn(dev, "Failed to set DMA mask to 32-bit. Devices with only 32-bit MSI support may not work properly\n");
+		dev_warn(dev, "Failed to set DMA mask to %s-bit.\n",
+			 msi_64bit ? "64" : "32");
 
 	msi_vaddr = dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data,
 					GFP_KERNEL);
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
2.37.1.559.g78731f0fdb-goog

