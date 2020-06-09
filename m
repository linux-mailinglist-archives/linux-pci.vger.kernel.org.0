Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E410F1F36BA
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jun 2020 11:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbgFIJPa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Jun 2020 05:15:30 -0400
Received: from mga01.intel.com ([192.55.52.88]:19611 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726187AbgFIJP3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 9 Jun 2020 05:15:29 -0400
IronPort-SDR: wDxBlxE1goElNLjzWI1owja+MkbhW0cN60lmx0+C7yBJqmUt459E+XyY0H59np+nTtSk9kVX5M
 idzBKddX6JSw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2020 02:15:27 -0700
IronPort-SDR: zuVF1mpKEINGAUTfFgnW32ujP1+dFBFdKRMr5TZil/7TzHAJ8widMg9onu+E1zBPM7s1hY41vc
 yQpBURsN6aiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,491,1583222400"; 
   d="scan'208";a="259739056"
Received: from gklab-125-110.igk.intel.com ([10.91.125.110])
  by orsmga007.jf.intel.com with ESMTP; 09 Jun 2020 02:15:25 -0700
From:   Piotr Stankiewicz <piotr.stankiewicz@intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Piotr Stankiewicz <piotr.stankiewicz@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jian-Hong Pan <jian-hong@endlessm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 01/15] PCI/MSI: Forward MSI-X vector enable error code in pci_alloc_irq_vectors_affinity()
Date:   Tue,  9 Jun 2020 11:14:39 +0200
Message-Id: <20200609091440.497-1-piotr.stankiewicz@intel.com>
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

