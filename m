Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBDD1EB847
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jun 2020 11:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbgFBJUO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Jun 2020 05:20:14 -0400
Received: from mga07.intel.com ([134.134.136.100]:59541 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbgFBJUO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Jun 2020 05:20:14 -0400
IronPort-SDR: cw3gNLpb9D/O+pySl16xQ73cT9qMrPOVGzVA49sesGC6P01849v2tHs0rUQClDBujBF+5BAwf4
 Gdq86j2IcjVA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2020 02:20:13 -0700
IronPort-SDR: +cEGgRuOAVk6LQEdohGj4ySKkGpeHf2YtOTtWXaONxCBeJcXpx6a+OIsG7/ikgMAGrlIty66iD
 SFpNLQE7Rjng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,463,1583222400"; 
   d="scan'208";a="444621223"
Received: from gklab-125-110.igk.intel.com ([10.91.125.110])
  by orsmga005.jf.intel.com with ESMTP; 02 Jun 2020 02:20:10 -0700
From:   Piotr Stankiewicz <piotr.stankiewicz@intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Piotr Stankiewicz <piotr.stankiewicz@intel.com>
Subject: [PATCH 03/15] PCI: use PCI_IRQ_MSI_TYPES where appropriate
Date:   Tue,  2 Jun 2020 11:20:02 +0200
Message-Id: <20200602092002.31787-1-piotr.stankiewicz@intel.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Seeing as there is shorthand available to use when asking for any type
of interrupt, or any type of message signalled interrupt, leverage it.

Signed-off-by: Piotr Stankiewicz <piotr.stankiewicz@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
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

