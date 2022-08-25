Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0184F5A1D63
	for <lists+linux-pci@lfdr.de>; Fri, 26 Aug 2022 01:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244524AbiHYXyZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Aug 2022 19:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244283AbiHYXyQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Aug 2022 19:54:16 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB11C59D6
        for <linux-pci@vger.kernel.org>; Thu, 25 Aug 2022 16:54:14 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-33dbe61eed8so47102197b3.1
        for <linux-pci@vger.kernel.org>; Thu, 25 Aug 2022 16:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=vUz6Nust5yp1gNz4Uf4QGDc0k3EwgdmOYN4sE8meqr8=;
        b=CtiHcgKrviWMX2NGBRZS+VHzmzJeYi1IOF/PRhdjReTqmrqfKTalpa5giNXz57jOEs
         BDpLTR6o9NZ4FLZfd4EiKm9qk5MAnCkrolAfSryscZe0QkOuJ+IO72uNA1441vmtHXL5
         Sla99irAya3PYuJ+MGxhQHK9Yh/DX9VN0DteGBje8rNSsy8d+pRB9LkYisJz6jG57ZE1
         cUg/N4mgDmaB18+oLKTAHr3Zk6MVQhsFS5z+Vfkbsc9LAKkqom45Zg1fLgA5C8nbPTa3
         Y+FOrtNZPkArsS84DRE8y3jUIJabboBOUyRavyx7VBcPqHNwYINKq+fPmDMQcW7jwC/l
         W/Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=vUz6Nust5yp1gNz4Uf4QGDc0k3EwgdmOYN4sE8meqr8=;
        b=IgfuyoST7/YISibPK+RB5xjz78v80cLAZmHM6CgJcPmopujRoAeTybvj+zqowsUVub
         an7TkkdrkpqBc4T+X3jjjtN8YCJEvPhvABuqIAw5IUSjNsNXSQE11mlnWg3dch86kPae
         vmJV0hCxqu6SXRsOMvq/0IoTkTdEmQBVBFVqOgWuLoUMoGZT+DpEF5rIQU8rfqeRPNfl
         67HrRUNXJ1NcCKKWgf3crjglgQF5HqF1C1Wvek3hjN5uSN5e6NaJnzOcBj0zmBnD+S3E
         bKztqu3PbeBZ5yig3aep0ZWNRv/DwfxjQPwjYUtqr4TdKdK8sgDfLszQwJT8KatX45NK
         PxwQ==
X-Gm-Message-State: ACgBeo1ffsXrXaLXs0HKVBYADHDkQdyFFpgrk8ERX5XDS4byE5/Yr/nJ
        dViod8UPiEC1suQPiIYBDnTXO472VBi444/nbQI=
X-Google-Smtp-Source: AA6agR7iHLfntJEAqSMbg5WG2yYoh67fS0C1ycJi2Z3X+HvBvRFPJ3qx35cuYPmJAraW943ihfv/i4z791j6aUS2tTk=
X-Received: from wmcvicker.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5ebe])
 (user=willmcvicker job=sendgmr) by 2002:a0d:cad1:0:b0:335:8273:e9fd with SMTP
 id m200-20020a0dcad1000000b003358273e9fdmr6347676ywd.154.1661471654046; Thu,
 25 Aug 2022 16:54:14 -0700 (PDT)
Date:   Thu, 25 Aug 2022 23:54:03 +0000
In-Reply-To: <20220825235404.4132818-1-willmcvicker@google.com>
Mime-Version: 1.0
References: <20220825235404.4132818-1-willmcvicker@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220825235404.4132818-3-willmcvicker@google.com>
Subject: [PATCH v6 2/2] PCI: dwc: Add support for 64-bit MSI target address
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
 .../pci/controller/dwc/pcie-designware-host.c | 19 ++++++++++++++++---
 drivers/pci/controller/dwc/pcie-designware.c  |  8 ++++++++
 drivers/pci/controller/dwc/pcie-designware.h  |  1 +
 3 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 39f3b37d4033..7e0352861bcb 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -374,9 +374,22 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
 	msi_vaddr = dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data,
 					GFP_KERNEL);
 	if (!msi_vaddr) {
-		dev_err(dev, "Failed to alloc and map MSI data\n");
-		dw_pcie_free_msi(pp);
-		return -ENOMEM;
+		u16 msi_capabilities;
+
+		/* Retry the allocation with a 64-bit mask if supported. */
+		msi_capabilities = dw_pcie_msi_capabilities(pci);
+		if ((msi_capabilities & PCI_MSI_FLAGS_ENABLE) &&
+		    (msi_capabilities & PCI_MSI_FLAGS_64BIT)) {
+			dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
+			msi_vaddr = dmam_alloc_coherent(dev, sizeof(u64),
+							&pp->msi_data,
+							GFP_KERNEL);
+		}
+		if (!msi_vaddr) {
+			dev_err(dev, "Failed to alloc and map MSI data\n");
+			dw_pcie_free_msi(pp);
+			return -ENOMEM;
+		}
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

