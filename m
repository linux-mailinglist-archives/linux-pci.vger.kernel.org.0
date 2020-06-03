Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1E571ECEC7
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jun 2020 13:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbgFCLpN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Jun 2020 07:45:13 -0400
Received: from mga18.intel.com ([134.134.136.126]:38373 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbgFCLpN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Jun 2020 07:45:13 -0400
IronPort-SDR: nUL+41uTDePePXgHWKniSn+knzhaQMD2ep0OgC+elYossHHmnFW5xkJBTH+Vc/RjU62h6APhfD
 hsjxKz+XlNtQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2020 04:45:13 -0700
IronPort-SDR: RXaXwBfnEa2vJF7njd9g1r5Z3O+PfhmTiUfJE6RzAMCMCg3LUTk0T+quFPkwVnhZZilZ4B79EU
 8zzMOra2kNJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,467,1583222400"; 
   d="scan'208";a="445083811"
Received: from gklab-125-110.igk.intel.com ([10.91.125.110])
  by orsmga005.jf.intel.com with ESMTP; 03 Jun 2020 04:45:10 -0700
From:   Piotr Stankiewicz <piotr.stankiewicz@intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Piotr Stankiewicz <piotr.stankiewicz@intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Jian-Hong Pan <jian-hong@endlessm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/15] PCI/MSI: Forward MSI-X vector enable error code in pci_alloc_irq_vectors_affinity()
Date:   Wed,  3 Jun 2020 13:44:24 +0200
Message-Id: <20200603114425.12734-1-piotr.stankiewicz@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200603114212.12525-1-piotr.stankiewicz@intel.com>
References: <20200603114212.12525-1-piotr.stankiewicz@intel.com>
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
---
 drivers/pci/msi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 6b43a5455c7a..443cc324b196 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1231,8 +1231,9 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
 		}
 	}
 
-	if (msix_vecs == -ENOSPC)
-		return -ENOSPC;
+	if (msix_vecs == -ENOSPC ||
+	    (flags & (PCI_IRQ_MSI | PCI_IRQ_MSIX)) == PCI_IRQ_MSIX)
+		return msix_vecs;
 	return msi_vecs;
 }
 EXPORT_SYMBOL(pci_alloc_irq_vectors_affinity);
-- 
2.17.2

