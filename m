Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEB011F36C8
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jun 2020 11:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbgFIJRA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Jun 2020 05:17:00 -0400
Received: from mga11.intel.com ([192.55.52.93]:34219 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727975AbgFIJRA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 9 Jun 2020 05:17:00 -0400
IronPort-SDR: MkR6RFwfDBgaDqrmS78IzoVRNUH+bBrvN8Mq0N7InUeAN6zu9TcFbLmYMbigC7p50wnMLLxZeL
 wMBZU2C0xoEQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2020 02:17:00 -0700
IronPort-SDR: cJTD43w4V7TEilYLKRfNC0yboYYr2i+S4T2mCC+IywfNuCR/VMLxkNIfMMtjMK5nt7+NBgHAJm
 LArOW+Nwmk9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,491,1583222400"; 
   d="scan'208";a="270830857"
Received: from gklab-125-110.igk.intel.com ([10.91.125.110])
  by orsmga003.jf.intel.com with ESMTP; 09 Jun 2020 02:16:56 -0700
From:   Piotr Stankiewicz <piotr.stankiewicz@intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Piotr Stankiewicz <piotr.stankiewicz@intel.com>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Olof Johansson <olof@lixom.net>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Kelvin Cao <kelvin.cao@microchip.com>,
        Wesley Sheng <wesley.sheng@microchip.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Krzysztof Wilczynski <kw@linux.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 03/15] PCI: Use PCI_IRQ_MSI_TYPES where appropriate
Date:   Tue,  9 Jun 2020 11:16:46 +0200
Message-Id: <20200609091650.801-1-piotr.stankiewicz@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200609091148.32749-1-piotr.stankiewicz@intel.com>
References: <20200609091148.32749-1-piotr.stankiewicz@intel.com>
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
 drivers/pci/pcie/portdrv_core.c | 4 ++--
 drivers/pci/switch/switchtec.c  | 3 +--
 2 files changed, 3 insertions(+), 4 deletions(-)

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
index 850cfeb74608..0ab17a71fe63 100644
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

