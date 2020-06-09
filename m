Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E20A1F4092
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jun 2020 18:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgFIQWv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Jun 2020 12:22:51 -0400
Received: from mga01.intel.com ([192.55.52.88]:64397 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725894AbgFIQWv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 9 Jun 2020 12:22:51 -0400
IronPort-SDR: ygPXPU273i+Y56NthJaHSQ8MplyXOI8FicpPcQgiF6yXFsfE/uadEFkmw2X20XEQRQAWet+s1g
 hykR9GTkPN6w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2020 09:22:50 -0700
IronPort-SDR: u3wLAA8jj9T4eckHnT2rBy6BcpvPBTqQNd6uftqv3XbmTuAaa6yaqsI0W4n0B2oc0tCM9TpqsM
 MsBnNJWQ6D4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,492,1583222400"; 
   d="scan'208";a="349568491"
Received: from gklab-125-110.igk.intel.com ([10.91.125.110])
  by orsmga001.jf.intel.com with ESMTP; 09 Jun 2020 09:22:46 -0700
From:   Piotr Stankiewicz <piotr.stankiewicz@intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Piotr Stankiewicz <piotr.stankiewicz@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Logan Gunthorpe <logang@deltatee.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Kelsey Skunberg <skunberg.kelsey@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Krzysztof Wilczynski <kw@linux.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Denis Efremov <efremov@linux.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 02/15] PCI: Add macro for message signalled interrupt types
Date:   Tue,  9 Jun 2020 18:22:40 +0200
Message-Id: <20200609162243.9102-1-piotr.stankiewicz@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200609091148.32749-1-piotr.stankiewicz@intel.com>
References: <20200609091148.32749-1-piotr.stankiewicz@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

There are several places in the kernel which check/ask for MSI or MSI-X
interrupts. It would make sense to have a macro which defines all types
of message signalled interrupts, to use in such situations. Add
PCI_IRQ_MSI_TYPES, for this purpose.

Signed-off-by: Piotr Stankiewicz <piotr.stankiewicz@intel.com>
Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 Documentation/PCI/msi-howto.rst | 5 +++--
 include/linux/pci.h             | 4 ++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/PCI/msi-howto.rst b/Documentation/PCI/msi-howto.rst
index aa2046af69f7..2800ff5aa395 100644
--- a/Documentation/PCI/msi-howto.rst
+++ b/Documentation/PCI/msi-howto.rst
@@ -105,7 +105,8 @@ if it can't meet the minimum number of vectors.
 The flags argument is used to specify which type of interrupt can be used
 by the device and the driver (PCI_IRQ_LEGACY, PCI_IRQ_MSI, PCI_IRQ_MSIX).
 A convenient short-hand (PCI_IRQ_ALL_TYPES) is also available to ask for
-any possible kind of interrupt.  If the PCI_IRQ_AFFINITY flag is set,
+any possible kind of interrupt, and (PCI_IRQ_MSI_TYPES) to ask for message
+signalled interrupts (MSI or MSI-X).  If the PCI_IRQ_AFFINITY flag is set,
 pci_alloc_irq_vectors() will spread the interrupts around the available CPUs.
 
 To get the Linux IRQ numbers passed to request_irq() and free_irq() and the
@@ -160,7 +161,7 @@ the single MSI mode for a device.  It could be done by passing two 1s as
 Some devices might not support using legacy line interrupts, in which case
 the driver can specify that only MSI or MSI-X is acceptable::
 
-	nvec = pci_alloc_irq_vectors(pdev, 1, nvec, PCI_IRQ_MSI | PCI_IRQ_MSIX);
+	nvec = pci_alloc_irq_vectors(pdev, 1, nvec, PCI_IRQ_MSI_TYPES);
 	if (nvec < 0)
 		goto out_err;
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index c79d83304e52..a99094f17b21 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1431,8 +1431,8 @@ int pci_set_vga_state(struct pci_dev *pdev, bool decode,
  */
 #define PCI_IRQ_VIRTUAL		(1 << 4)
 
-#define PCI_IRQ_ALL_TYPES \
-	(PCI_IRQ_LEGACY | PCI_IRQ_MSI | PCI_IRQ_MSIX)
+#define PCI_IRQ_MSI_TYPES	(PCI_IRQ_MSI | PCI_IRQ_MSIX)
+#define PCI_IRQ_ALL_TYPES	(PCI_IRQ_LEGACY | PCI_IRQ_MSI_TYPES)
 
 /* kmem_cache style wrapper around pci_alloc_consistent() */
 
-- 
2.17.2

