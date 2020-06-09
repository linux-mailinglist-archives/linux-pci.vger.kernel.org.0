Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89B461F36CA
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jun 2020 11:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbgFIJRR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Jun 2020 05:17:17 -0400
Received: from mga09.intel.com ([134.134.136.24]:23588 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727941AbgFIJRQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 9 Jun 2020 05:17:16 -0400
IronPort-SDR: LAP8rWwxODkyBVO1UwgnqQALfAmrg8NIop5MpltPduc56x4qCAtgNcQhCricP0Cp5CVZQ4/ntG
 44hWOPLEkbXQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2020 02:17:16 -0700
IronPort-SDR: 7cluu1AJqmlLsVdBgUdaomWUS4wfBrnR/7XQqSWOrWqQqGI3r3Sp5GIcqS7x7Ojdke7kdoxDtD
 hE5DknQ8/NaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,491,1583222400"; 
   d="scan'208";a="306123608"
Received: from gklab-125-110.igk.intel.com ([10.91.125.110])
  by fmsmga002.fm.intel.com with ESMTP; 09 Jun 2020 02:17:13 -0700
From:   Piotr Stankiewicz <piotr.stankiewicz@intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Piotr Stankiewicz <piotr.stankiewicz@intel.com>,
        Jens Axboe <axboe@kernel.dk>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Prabhakar Kushwaha <pkushwaha@marvell.com>,
        Hanna Hawa <hhhawa@amazon.com>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 04/15] ahci: Use PCI_IRQ_MSI_TYPES where appropriate
Date:   Tue,  9 Jun 2020 11:17:09 +0200
Message-Id: <20200609091711.892-1-piotr.stankiewicz@intel.com>
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
---
 drivers/ata/ahci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 0c0a736eb861..ca1bf4ef0f17 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1556,7 +1556,7 @@ static int ahci_init_msi(struct pci_dev *pdev, unsigned int n_ports,
 	 */
 	if (n_ports > 1) {
 		nvec = pci_alloc_irq_vectors(pdev, n_ports, INT_MAX,
-				PCI_IRQ_MSIX | PCI_IRQ_MSI);
+				PCI_IRQ_MSI_TYPES);
 		if (nvec > 0) {
 			if (!(readl(hpriv->mmio + HOST_CTL) & HOST_MRSM)) {
 				hpriv->get_irq_vector = ahci_get_irq_vector;
-- 
2.17.2

