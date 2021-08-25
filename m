Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6DD3F733D
	for <lists+linux-pci@lfdr.de>; Wed, 25 Aug 2021 12:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240232AbhHYK2i (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Aug 2021 06:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240237AbhHYK2W (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Aug 2021 06:28:22 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108F0C0611C2;
        Wed, 25 Aug 2021 03:27:19 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id oa17so16250094pjb.1;
        Wed, 25 Aug 2021 03:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hd2Dai++XCp1izyWWai/1zyp7iVlPjRdTg8VyPtehoQ=;
        b=IfUDrOJngZqRfVPJW9NSXmam52kJzeN4voE6qxhiIcc+YlAXAUI0VBPjWM6mhZyMwg
         F0zzq1TNa8OimIIG3dGaJZmDyWuJUR1XP69kww/vbD2TSiBiqHlI43KFQR9awO7NGN4s
         l0ZrpcTSvAlTj9M8eFQxelOInUeORGRax0leaNTv7oBOVbwcJg52o6dvUv6jZHsPzEGs
         puKjQtXseMK854CTFuxPjSENN4OblmQVngvBxAfKj0Y4WsWHj6JcqseqYYTp8PiRxmJQ
         GA3MW93e7pDFOGSNom+RGZpChMkFM/oVEiI8t4Dz565PeIMguVBdExfjeiWbNSXAcK3w
         JAbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hd2Dai++XCp1izyWWai/1zyp7iVlPjRdTg8VyPtehoQ=;
        b=Br12lt6By5F/LEFLPzppWXl4SCqQJQaaonzaRBPDwosCFBOyIH47/ui1eAokjX71ta
         4Va7X/higwyKm3Z2Qxdv6ypi21etKSxkw6xkKeDltsC0nR4DPZgu56I6sbl4eqTNhdzh
         c/tfp24qaXXmXv+h0zClapEKWjQipT6DatA/g8FJ+CibA3XshPOoQ/QvcnLN2w4t4cpo
         ENvbPJgNonwOQ06uK0gNqXRzaAM3+ra9tG52rwEZRCPtsZ2dMhnLCIcon0Lhn1BpOJoj
         NHqUdTj69CjP1eEQXCmog7jNtckHrkOWWnyEcseQgyCeBFtjugCXYvOR5HJ2Uv45D44/
         nUvA==
X-Gm-Message-State: AOAM531MkH0ToIoKyMExVpbsNNJmhmJrxQ4Y7xSAKm/DCCPTuIQMwa/J
        lP90Kjo/PvjVvFYf4KQ9Y/0=
X-Google-Smtp-Source: ABdhPJwgqyBrhi/1S0rX3cyTRL2FVtROfeKKuiE0BADwPgAxsfBnTqK4KGlUdcDxJqvzNbH6ScPtQA==
X-Received: by 2002:a17:902:a710:b029:12b:9b9f:c461 with SMTP id w16-20020a170902a710b029012b9b9fc461mr37110846plq.59.1629887238609;
        Wed, 25 Aug 2021 03:27:18 -0700 (PDT)
Received: from baohua-VirtualBox.localdomain (203-173-222-16.dialup.ihug.co.nz. [203.173.222.16])
        by smtp.gmail.com with ESMTPSA id f23sm1786403pfa.94.2021.08.25.03.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 03:27:18 -0700 (PDT)
From:   Barry Song <21cnbao@gmail.com>
To:     bhelgaas@google.com, maz@kernel.org, tglx@linutronix.de
Cc:     Jonathan.Cameron@huawei.com, bilbao@vt.edu, corbet@lwn.net,
        gregkh@linuxfoundation.org, leon@kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linuxarm@huawei.com, luzmaximilian@gmail.com,
        mchehab+huawei@kernel.org, schnelle@linux.ibm.com,
        jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
        intel-wired-lan@lists.osuosl.org,
        Barry Song <song.bao.hua@hisilicon.com>
Subject: [PATCH v3 3/3] PCI/MSI: remove msi_attrib.default_irq in msi_desc
Date:   Wed, 25 Aug 2021 18:26:36 +0800
Message-Id: <20210825102636.52757-4-21cnbao@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210825102636.52757-1-21cnbao@gmail.com>
References: <20210825102636.52757-1-21cnbao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Marc Zyngier <maz@kernel.org>

default_irq is hideous as it should be per-device but not per-desc.
On the other hand, MSI-X case doesn't use it at all. Since sysfs
IRQ has moved to use the msi_entry instead of pci_dev.irq, now it
seems it is safe to remove msi_attrib.default_irq.

Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
[Barry: Updated pci_irq_vector and __pci_restore_msi_state]
Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 drivers/pci/msi.c   | 12 +++++-------
 include/linux/msi.h |  2 --
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index e5e7533..9434afa 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -422,7 +422,7 @@ static void __pci_restore_msi_state(struct pci_dev *dev)
 	if (!dev->msi_enabled)
 		return;
 
-	entry = irq_get_msi_desc(dev->irq);
+	entry = first_pci_msi_entry(dev);
 
 	pci_intx_for_msi(dev, 0);
 	pci_msi_set_enable(dev, 0);
@@ -591,7 +591,6 @@ static int populate_msi_sysfs(struct pci_dev *pdev)
 	entry->msi_attrib.is_virtual    = 0;
 	entry->msi_attrib.entry_nr	= 0;
 	entry->msi_attrib.maskbit	= !!(control & PCI_MSI_FLAGS_MASKBIT);
-	entry->msi_attrib.default_irq	= dev->irq;	/* Save IOAPIC IRQ */
 	entry->msi_attrib.multi_cap	= (control & PCI_MSI_FLAGS_QMASK) >> 1;
 	entry->msi_attrib.multiple	= ilog2(__roundup_pow_of_two(nvec));
 
@@ -682,7 +681,6 @@ static int msi_capability_init(struct pci_dev *dev, int nvec,
 	dev->msi_enabled = 1;
 
 	pcibios_free_irq(dev);
-	dev->irq = entry->irq;
 	return 0;
 }
 
@@ -742,7 +740,6 @@ static int msix_setup_entries(struct pci_dev *dev, void __iomem *base,
 		entry->msi_attrib.is_virtual =
 			entry->msi_attrib.entry_nr >= vec_count;
 
-		entry->msi_attrib.default_irq	= dev->irq;
 		entry->mask_base		= base;
 
 		addr = pci_msix_desc_addr(entry);
@@ -964,8 +961,6 @@ static void pci_msi_shutdown(struct pci_dev *dev)
 	mask = msi_mask(desc->msi_attrib.multi_cap);
 	msi_mask_irq(desc, mask, 0);
 
-	/* Restore dev->irq to its default pin-assertion IRQ */
-	dev->irq = desc->msi_attrib.default_irq;
 	pcibios_alloc_irq(dev);
 }
 
@@ -1301,12 +1296,15 @@ int pci_irq_vector(struct pci_dev *dev, unsigned int nr)
 
 		if (WARN_ON_ONCE(nr >= entry->nvec_used))
 			return -EINVAL;
+
+		return entry->irq + nr;
 	} else {
 		if (WARN_ON_ONCE(nr > 0))
 			return -EINVAL;
 	}
 
-	return dev->irq + nr;
+	/* legacy INTx */
+	return dev->irq;
 }
 EXPORT_SYMBOL(pci_irq_vector);
 
diff --git a/include/linux/msi.h b/include/linux/msi.h
index e8bdcb8..a631664 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -114,7 +114,6 @@ struct ti_sci_inta_msi_desc {
  * @maskbit:	[PCI MSI/X] Mask-Pending bit supported?
  * @is_64:	[PCI MSI/X] Address size: 0=32bit 1=64bit
  * @entry_nr:	[PCI MSI/X] Entry which is described by this descriptor
- * @default_irq:[PCI MSI/X] The default pre-assigned non-MSI irq
  * @mask_pos:	[PCI MSI]   Mask register position
  * @mask_base:	[PCI MSI-X] Mask register base address
  * @platform:	[platform]  Platform device specific msi descriptor data
@@ -148,7 +147,6 @@ struct msi_desc {
 				u8	is_64		: 1;
 				u8	is_virtual	: 1;
 				u16	entry_nr;
-				unsigned default_irq;
 			} msi_attrib;
 			union {
 				u8	mask_pos;
-- 
1.8.3.1

