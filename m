Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99D6111BEA8
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2019 21:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbfLKU4X (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Dec 2019 15:56:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:50602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726141AbfLKU4W (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Dec 2019 15:56:22 -0500
Received: from localhost (mobile-166-170-223-177.mycingular.net [166.170.223.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D93B20836;
        Wed, 11 Dec 2019 20:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576097781;
        bh=W21JTWaGa/ZoqxuyazaAcOIJgri7SXi4lkogMT3HvPA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=YcJLoh79oaRfo8o/snWm+fsgAai5UlqO1s7cxWIwHawvowzpAMQqbn3XcWKbArK6M
         oT9iCQnBRjeZcXPCjkRXvYtsRPVovTca/t52YqHpgQfZRcdG96w1ve/gzGaXId4TYO
         lNiYJVErKtfwQZyyl/nGX07HqC9A/CZTbcDUireI=
Date:   Wed, 11 Dec 2019 14:56:19 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     James Sewart <jamessewart@arista.com>
Cc:     linux-pci@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Dmitry Safonov <dima@arista.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v6 2/3] PCI: Add parameter nr_devfns to pci_add_dma_alias
Message-ID: <20191211205619.GA109675@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <826A0459-FA8D-4BDB-A342-CE46974466DF@arista.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 11, 2019 at 03:37:30PM +0000, James Sewart wrote:
> > On 10 Dec 2019, at 22:37, Bjorn Helgaas <helgaas@kernel.org> wrote:
> >> -void pci_add_dma_alias(struct pci_dev *dev, u8 devfn)
> >> +void pci_add_dma_alias(struct pci_dev *dev, u8 devfn_from, unsigned nr_devfns)
> >> {
> >> +	int devfn_to;
> >> +
> >> +	nr_devfns = min(nr_devfns, (unsigned)MAX_NR_DEVFNS);
> >> +	devfn_to = devfn_from + nr_devfns - 1;
> > 
> > I made this look like:
> > 
> > +       devfn_to = min(devfn_from + nr_devfns - 1,
> > +                      (unsigned) MAX_NR_DEVFNS - 1);
> > 
> > so devfn_from=0xf0, nr_devfns=0x20 doesn't cause devfn_to to wrap
> > around.
> > 
> > I did keep Logan's reviewed-by, so let me know if I broke something.
> 
> I think nr_devfns still needs updating as it is used for bitmap_set. 
> Although thinking about it now we should limit the number to alias to be 
> maximum (MAX_NR_DEVFNS - devfn_from), so that we don’t set past the end of 
> the bitmap:
> 
>  nr_devfns = min(nr_devfns, (unsigned) MAX_NR_DEVFNS - devfn_from);
> 
> I think with this change we wont need to clip devfn_to.

Indeed, you're right, thanks!  I put this in, so it now looks like
the following.  I dropped Logan's reviewed-by to avoid putting words
in his mouth ;)

commit 5ddcd840395a ("PCI: Add nr_devfns parameter to pci_add_dma_alias()")
Author: James Sewart <jamessewart@arista.com>
Date:   Tue Dec 10 16:07:30 2019 -0600

    PCI: Add nr_devfns parameter to pci_add_dma_alias()
    
    Add a "nr_devfns" parameter to pci_add_dma_alias() so it can be used to
    create DMA aliases for a range of devfns.
    
    [bhelgaas: incorporate nr_devfns fix from James, update
    quirk_pex_vca_alias() and setup_aliases()]
    Signed-off-by: James Sewart <jamessewart@arista.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index bd25674ee4db..7a6c056b9b9c 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -230,11 +230,8 @@ static struct pci_dev *setup_aliases(struct device *dev)
 	 */
 	ivrs_alias = amd_iommu_alias_table[pci_dev_id(pdev)];
 	if (ivrs_alias != pci_dev_id(pdev) &&
-	    PCI_BUS_NUM(ivrs_alias) == pdev->bus->number) {
-		pci_add_dma_alias(pdev, ivrs_alias & 0xff);
-		pci_info(pdev, "Added PCI DMA alias %02x.%d\n",
-			PCI_SLOT(ivrs_alias), PCI_FUNC(ivrs_alias));
-	}
+	    PCI_BUS_NUM(ivrs_alias) == pdev->bus->number)
+		pci_add_dma_alias(pdev, ivrs_alias & 0xff, 1);
 
 	clone_aliases(pdev);
 
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 7b5fa2eabe09..951099279192 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5998,7 +5998,8 @@ EXPORT_SYMBOL_GPL(pci_pr3_present);
 /**
  * pci_add_dma_alias - Add a DMA devfn alias for a device
  * @dev: the PCI device for which alias is added
- * @devfn: alias slot and function
+ * @devfn_from: alias slot and function
+ * @nr_devfns: number of subsequent devfns to alias
  *
  * This helper encodes an 8-bit devfn as a bit number in dma_alias_mask
  * which is used to program permissible bus-devfn source addresses for DMA
@@ -6014,8 +6015,13 @@ EXPORT_SYMBOL_GPL(pci_pr3_present);
  * cannot be left as a userspace activity).  DMA aliases should therefore
  * be configured via quirks, such as the PCI fixup header quirk.
  */
-void pci_add_dma_alias(struct pci_dev *dev, u8 devfn)
+void pci_add_dma_alias(struct pci_dev *dev, u8 devfn_from, unsigned nr_devfns)
 {
+	int devfn_to;
+
+	nr_devfns = min(nr_devfns, (unsigned) MAX_NR_DEVFNS - devfn_from);
+	devfn_to = devfn_from + nr_devfns - 1;
+
 	if (!dev->dma_alias_mask)
 		dev->dma_alias_mask = bitmap_zalloc(MAX_NR_DEVFNS, GFP_KERNEL);
 	if (!dev->dma_alias_mask) {
@@ -6023,9 +6029,15 @@ void pci_add_dma_alias(struct pci_dev *dev, u8 devfn)
 		return;
 	}
 
-	set_bit(devfn, dev->dma_alias_mask);
-	pci_info(dev, "Enabling fixed DMA alias to %02x.%d\n",
-		 PCI_SLOT(devfn), PCI_FUNC(devfn));
+	bitmap_set(dev->dma_alias_mask, devfn_from, nr_devfns);
+
+	if (nr_devfns == 1)
+		pci_info(dev, "Enabling fixed DMA alias to %02x.%d\n",
+				PCI_SLOT(devfn_from), PCI_FUNC(devfn_from));
+	else if (nr_devfns > 1)
+		pci_info(dev, "Enabling fixed DMA alias for devfn range from %02x.%d to %02x.%d\n",
+				PCI_SLOT(devfn_from), PCI_FUNC(devfn_from),
+				PCI_SLOT(devfn_to), PCI_FUNC(devfn_to));
 }
 
 bool pci_devs_are_dma_aliases(struct pci_dev *dev1, struct pci_dev *dev2)
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 4937a088d7d8..2fcad18622eb 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3932,7 +3932,7 @@ int pci_dev_specific_reset(struct pci_dev *dev, int probe)
 static void quirk_dma_func0_alias(struct pci_dev *dev)
 {
 	if (PCI_FUNC(dev->devfn) != 0)
-		pci_add_dma_alias(dev, PCI_DEVFN(PCI_SLOT(dev->devfn), 0));
+		pci_add_dma_alias(dev, PCI_DEVFN(PCI_SLOT(dev->devfn), 0), 1);
 }
 
 /*
@@ -3946,7 +3946,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_RICOH, 0xe476, quirk_dma_func0_alias);
 static void quirk_dma_func1_alias(struct pci_dev *dev)
 {
 	if (PCI_FUNC(dev->devfn) != 1)
-		pci_add_dma_alias(dev, PCI_DEVFN(PCI_SLOT(dev->devfn), 1));
+		pci_add_dma_alias(dev, PCI_DEVFN(PCI_SLOT(dev->devfn), 1), 1);
 }
 
 /*
@@ -4031,7 +4031,7 @@ static void quirk_fixed_dma_alias(struct pci_dev *dev)
 
 	id = pci_match_id(fixed_dma_alias_tbl, dev);
 	if (id)
-		pci_add_dma_alias(dev, id->driver_data);
+		pci_add_dma_alias(dev, id->driver_data, 1);
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ADAPTEC2, 0x0285, quirk_fixed_dma_alias);
 
@@ -4072,9 +4072,9 @@ DECLARE_PCI_FIXUP_HEADER(0x8086, 0x244e, quirk_use_pcie_bridge_dma_alias);
  */
 static void quirk_mic_x200_dma_alias(struct pci_dev *pdev)
 {
-	pci_add_dma_alias(pdev, PCI_DEVFN(0x10, 0x0));
-	pci_add_dma_alias(pdev, PCI_DEVFN(0x11, 0x0));
-	pci_add_dma_alias(pdev, PCI_DEVFN(0x12, 0x3));
+	pci_add_dma_alias(pdev, PCI_DEVFN(0x10, 0x0), 1);
+	pci_add_dma_alias(pdev, PCI_DEVFN(0x11, 0x0), 1);
+	pci_add_dma_alias(pdev, PCI_DEVFN(0x12, 0x3), 1);
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2260, quirk_mic_x200_dma_alias);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2264, quirk_mic_x200_dma_alias);
@@ -4098,13 +4098,8 @@ static void quirk_pex_vca_alias(struct pci_dev *pdev)
 	const unsigned int num_pci_slots = 0x20;
 	unsigned int slot;
 
-	for (slot = 0; slot < num_pci_slots; slot++) {
-		pci_add_dma_alias(pdev, PCI_DEVFN(slot, 0x0));
-		pci_add_dma_alias(pdev, PCI_DEVFN(slot, 0x1));
-		pci_add_dma_alias(pdev, PCI_DEVFN(slot, 0x2));
-		pci_add_dma_alias(pdev, PCI_DEVFN(slot, 0x3));
-		pci_add_dma_alias(pdev, PCI_DEVFN(slot, 0x4));
-	}
+	for (slot = 0; slot < num_pci_slots; slot++)
+		pci_add_dma_alias(pdev, PCI_DEVFN(slot, 0x0), 5);
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2954, quirk_pex_vca_alias);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2955, quirk_pex_vca_alias);
@@ -5332,7 +5327,7 @@ static void quirk_switchtec_ntb_dma_alias(struct pci_dev *pdev)
 			pci_dbg(pdev,
 				"Aliasing Partition %d Proxy ID %02x.%d\n",
 				pp, PCI_SLOT(devfn), PCI_FUNC(devfn));
-			pci_add_dma_alias(pdev, devfn);
+			pci_add_dma_alias(pdev, devfn, 1);
 		}
 	}
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index c393dff2d66f..930fab293073 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2310,7 +2310,7 @@ static inline struct eeh_dev *pci_dev_to_eeh_dev(struct pci_dev *pdev)
 }
 #endif
 
-void pci_add_dma_alias(struct pci_dev *dev, u8 devfn);
+void pci_add_dma_alias(struct pci_dev *dev, u8 devfn_from, unsigned nr_devfns);
 bool pci_devs_are_dma_aliases(struct pci_dev *dev1, struct pci_dev *dev2);
 int pci_for_each_dma_alias(struct pci_dev *pdev,
 			   int (*fn)(struct pci_dev *pdev,
