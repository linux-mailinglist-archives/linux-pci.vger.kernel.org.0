Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11F6C1F36DF
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jun 2020 11:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbgFIJSb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Jun 2020 05:18:31 -0400
Received: from mga03.intel.com ([134.134.136.65]:4040 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728436AbgFIJSa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 9 Jun 2020 05:18:30 -0400
IronPort-SDR: l0dkD4nT8XHCetHA3RgUdpJqp2DQm3OPI76qYbZP7YDGIv9GZtASe5HhXQaUsTEawbi0SXJ4hx
 jU+X58FaQ8yw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2020 02:18:30 -0700
IronPort-SDR: +olPD0zhM290Umf18+sPDZZPw+ga0IPL2XIZkaoeeqo0oJ41smWh9kqflrscC/dJF2qDz6FjPb
 0bIpyVbyCFaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,491,1583222400"; 
   d="scan'208";a="314149665"
Received: from gklab-125-110.igk.intel.com ([10.91.125.110])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Jun 2020 02:18:27 -0700
From:   Piotr Stankiewicz <piotr.stankiewicz@intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Piotr Stankiewicz <piotr.stankiewicz@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 08/15] IB/qib: Use PCI_IRQ_MSI_TYPES where appropriate
Date:   Tue,  9 Jun 2020 11:18:22 +0200
Message-Id: <20200609091823.1346-1-piotr.stankiewicz@intel.com>
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
 drivers/infiniband/hw/qib/qib_pcie.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/qib/qib_pcie.c b/drivers/infiniband/hw/qib/qib_pcie.c
index 3dc6ce033319..caff44d2c12c 100644
--- a/drivers/infiniband/hw/qib/qib_pcie.c
+++ b/drivers/infiniband/hw/qib/qib_pcie.c
@@ -213,7 +213,7 @@ int qib_pcie_params(struct qib_devdata *dd, u32 minw, u32 *nent)
 	u16 linkstat, speed;
 	int nvec;
 	int maxvec;
-	unsigned int flags = PCI_IRQ_MSIX | PCI_IRQ_MSI;
+	unsigned int flags;
 
 	if (!pci_is_pcie(dd->pcidev)) {
 		qib_dev_err(dd, "Can't find PCI Express capability!\n");
@@ -225,7 +225,9 @@ int qib_pcie_params(struct qib_devdata *dd, u32 minw, u32 *nent)
 	}
 
 	if (dd->flags & QIB_HAS_INTX)
-		flags |= PCI_IRQ_LEGACY;
+		flags = PCI_IRQ_ALL_TYPES;
+	else
+		flags = PCI_IRQ_MSI_TYPES;
 	maxvec = (nent && *nent) ? *nent : 1;
 	nvec = pci_alloc_irq_vectors(dd->pcidev, 1, maxvec, flags);
 	if (nvec < 0)
-- 
2.17.2

