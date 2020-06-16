Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A10E1FA9F7
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jun 2020 09:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgFPHdY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Jun 2020 03:33:24 -0400
Received: from mga09.intel.com ([134.134.136.24]:62741 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727103AbgFPHdX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 16 Jun 2020 03:33:23 -0400
IronPort-SDR: VgcmTZp4U8HSVbfVR2APRA4sgv6thiF1jC45+yw/6hkYvZnJZltgUyfLSJvtdlptx7xV67fQTL
 2qSaGRen7mSw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2020 00:33:23 -0700
IronPort-SDR: ZBYIUwjIujUX2qz9Msx/5mblCk6MtE/FTrDqW3NppZfi00tP3HBiULLZTVtVjDOl46Wqw90jfT
 91HBstN4BxLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,518,1583222400"; 
   d="scan'208";a="261347211"
Received: from gklab-125-110.igk.intel.com ([10.91.125.110])
  by fmsmga007.fm.intel.com with ESMTP; 16 Jun 2020 00:33:21 -0700
From:   Piotr Stankiewicz <piotr.stankiewicz@intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Piotr Stankiewicz <piotr.stankiewicz@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Jian-Hong Pan <jian-hong@endlessm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] PCI/MSI: Forward MSI-X vector enable error code in pci_alloc_irq_vectors_affinity()
Date:   Tue, 16 Jun 2020 09:33:16 +0200
Message-Id: <20200616073318.20229-1-piotr.stankiewicz@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200609091148.32749-1-piotr.stankiewicz@intel.com>
References: <20200609091148.32749-1-piotr.stankiewicz@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When debugging an issue where I was asking the PCI machinery to enable a
set of MSI-X vectors, without falling back on MSI, I ran across a
behaviour which seems odd. The pci_alloc_irq_vectors_affinity() will
always return -ENOSPC on failure, when allocating MSI-X vectors only,
whereas with MSI fallback it will forward any error returned by
__pci_enable_msi_range(). This is a confusing behaviour, so have the
pci_alloc_irq_vectors_affinity() forward the error code from
__pci_enable_msix_range() when appropriate.

Signed-off-by: Piotr Stankiewicz <piotr.stankiewicz@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/pci/msi.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 6b43a5455c7a..cade9be68b09 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1191,8 +1191,7 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
 				   struct irq_affinity *affd)
 {
 	struct irq_affinity msi_default_affd = {0};
-	int msix_vecs = -ENOSPC;
-	int msi_vecs = -ENOSPC;
+	int nvecs = -ENOSPC;
 
 	if (flags & PCI_IRQ_AFFINITY) {
 		if (!affd)
@@ -1203,17 +1202,16 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
 	}
 
 	if (flags & PCI_IRQ_MSIX) {
-		msix_vecs = __pci_enable_msix_range(dev, NULL, min_vecs,
-						    max_vecs, affd, flags);
-		if (msix_vecs > 0)
-			return msix_vecs;
+		nvecs = __pci_enable_msix_range(dev, NULL, min_vecs, max_vecs,
+						affd, flags);
+		if (nvecs > 0)
+			return nvecs;
 	}
 
 	if (flags & PCI_IRQ_MSI) {
-		msi_vecs = __pci_enable_msi_range(dev, min_vecs, max_vecs,
-						  affd);
-		if (msi_vecs > 0)
-			return msi_vecs;
+		nvecs = __pci_enable_msi_range(dev, min_vecs, max_vecs, affd);
+		if (nvecs > 0)
+			return nvecs;
 	}
 
 	/* use legacy IRQ if allowed */
@@ -1231,9 +1229,7 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
 		}
 	}
 
-	if (msix_vecs == -ENOSPC)
-		return -ENOSPC;
-	return msi_vecs;
+	return nvecs;
 }
 EXPORT_SYMBOL(pci_alloc_irq_vectors_affinity);
 
-- 
2.17.2

