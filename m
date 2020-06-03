Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 541931ECED6
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jun 2020 13:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbgFCLrF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Jun 2020 07:47:05 -0400
Received: from mga11.intel.com ([192.55.52.93]:22263 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbgFCLrE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Jun 2020 07:47:04 -0400
IronPort-SDR: HITp9jl9xSJ5UeC+NQR2AvX2PnId09dVx489JQ3VTnwU0HxMba2nYr/bCtH6r7kcr8kPR/vtZD
 o/edV3lePYrA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2020 04:47:04 -0700
IronPort-SDR: uYU61oDyq4QGHj7sT3RCcYyexZOkUVa8y3ZV/s5uFfyOaQcSN03bFI21QQadqmd8GUBr4scAva
 2SMgjHolQI2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,467,1583222400"; 
   d="scan'208";a="257426382"
Received: from gklab-125-110.igk.intel.com ([10.91.125.110])
  by fmsmga007.fm.intel.com with ESMTP; 03 Jun 2020 04:47:00 -0700
From:   Piotr Stankiewicz <piotr.stankiewicz@intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Piotr Stankiewicz <piotr.stankiewicz@intel.com>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jian-Hong Pan <jian-hong@endlessm.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Olof Johansson <olof@lixom.net>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Kelvin Cao <kelvin.cao@microchip.com>,
        Wesley Sheng <wesley.sheng@microchip.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/15] PCI: Use PCI_IRQ_MSI_TYPES where appropriate
Date:   Wed,  3 Jun 2020 13:46:48 +0200
Message-Id: <20200603114652.12954-1-piotr.stankiewicz@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200603114212.12525-1-piotr.stankiewicz@intel.com>
References: <20200603114212.12525-1-piotr.stankiewicz@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Seeing as there is shorthand available to use when asking for any type
of interrupt, or any type of message signalled interrupt, leverage it.

Signed-off-by: Piotr Stankiewicz <piotr.stankiewicz@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/pci/msi.c               | 3 +--
 drivers/pci/pcie/portdrv_core.c | 4 ++--
 drivers/pci/switch/switchtec.c  | 3 +--
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 443cc324b196..9db9ce5dddb3 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1231,8 +1231,7 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
 		}
 	}
 
-	if (msix_vecs == -ENOSPC ||
-	    (flags & (PCI_IRQ_MSI | PCI_IRQ_MSIX)) == PCI_IRQ_MSIX)
+	if (msix_vecs == -ENOSPC || (flags & PCI_IRQ_MSI_TYPES) == PCI_IRQ_MSIX)
 		return msix_vecs;
 	return msi_vecs;
 }
diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index 50a9522ab07d..2a38a918ba12 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -105,7 +105,7 @@ static int pcie_port_enable_irq_vec(struct pci_dev *dev, int *irqs, int mask)
 
 	/* Allocate the maximum possible number of MSI/MSI-X vectors */
 	nr_entries = pci_alloc_irq_vectors(dev, 1, PCIE_PORT_MAX_MSI_ENTRIES,
-			PCI_IRQ_MSIX | PCI_IRQ_MSI);
+			PCI_IRQ_MSI_TYPES);
 	if (nr_entries < 0)
 		return nr_entries;
 
@@ -131,7 +131,7 @@ static int pcie_port_enable_irq_vec(struct pci_dev *dev, int *irqs, int mask)
 		pci_free_irq_vectors(dev);
 
 		nr_entries = pci_alloc_irq_vectors(dev, nvec, nvec,
-				PCI_IRQ_MSIX | PCI_IRQ_MSI);
+				PCI_IRQ_MSI_TYPES);
 		if (nr_entries < 0)
 			return nr_entries;
 	}
diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index e69cac84b605..11fbe9c6b201 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -1442,8 +1442,7 @@ static int switchtec_init_isr(struct switchtec_dev *stdev)
 		nirqs = 4;
 
 	nvecs = pci_alloc_irq_vectors(stdev->pdev, 1, nirqs,
-				      PCI_IRQ_MSIX | PCI_IRQ_MSI |
-				      PCI_IRQ_VIRTUAL);
+				      PCI_IRQ_MSI_TYPES | PCI_IRQ_VIRTUAL);
 	if (nvecs < 0)
 		return nvecs;
 
-- 
2.17.2

