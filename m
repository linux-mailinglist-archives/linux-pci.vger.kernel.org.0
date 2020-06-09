Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3E851F36FC
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jun 2020 11:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbgFIJU4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Jun 2020 05:20:56 -0400
Received: from mga03.intel.com ([134.134.136.65]:4325 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728024AbgFIJUz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 9 Jun 2020 05:20:55 -0400
IronPort-SDR: ZbiYHTRS4glaDIOlQfqi1bq+zu7SeDOI7Cdf75phjOZ73YP4dc4BqbzqBPLXz8odlPLchJ+/Eu
 Xt5bJwwA8uCw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2020 02:20:55 -0700
IronPort-SDR: gcHUIYywt1/Pk50P+Z7CaFycv7MMxrwnX9RySDkwKoSy7QRqQQFiMoYkopfrd/plcKB1dM+2gI
 zYMi49UOBZxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,491,1583222400"; 
   d="scan'208";a="418346674"
Received: from gklab-125-110.igk.intel.com ([10.91.125.110])
  by orsmga004.jf.intel.com with ESMTP; 09 Jun 2020 02:20:51 -0700
From:   Piotr Stankiewicz <piotr.stankiewicz@intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Piotr Stankiewicz <piotr.stankiewicz@intel.com>,
        Brian King <brking@us.ibm.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jim Gill <jgill@vmware.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Jason Yan <yanaijie@huawei.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Wen Xiong <wenxiong@linux.vnet.ibm.com>,
        Takashi Iwai <tiwai@suse.de>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        "Ewan D. Milne" <emilne@redhat.com>, Jan Kara <jack@suse.cz>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 15/15] scsi: Use PCI_IRQ_MSI_TYPES and PCI_IRQ_ALL_TYPES where appropriate
Date:   Tue,  9 Jun 2020 11:20:45 +0200
Message-Id: <20200609092048.2106-1-piotr.stankiewicz@intel.com>
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
 drivers/scsi/ipr.c        | 5 +++--
 drivers/scsi/vmw_pvscsi.c | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/ipr.c b/drivers/scsi/ipr.c
index 7d77997d26d4..b320fc765a57 100644
--- a/drivers/scsi/ipr.c
+++ b/drivers/scsi/ipr.c
@@ -10272,9 +10272,10 @@ static int ipr_probe_ioa(struct pci_dev *pdev,
 		ipr_number_of_msix = IPR_MAX_MSIX_VECTORS;
 	}
 
-	irq_flag = PCI_IRQ_LEGACY;
 	if (ioa_cfg->ipr_chip->has_msi)
-		irq_flag |= PCI_IRQ_MSI | PCI_IRQ_MSIX;
+		irq_flag = PCI_IRQ_ALL_TYPES;
+	else
+		irq_flag = PCI_IRQ_LEGACY;
 	rc = pci_alloc_irq_vectors(pdev, 1, ipr_number_of_msix, irq_flag);
 	if (rc < 0) {
 		ipr_wait_for_pci_err_recovery(ioa_cfg);
diff --git a/drivers/scsi/vmw_pvscsi.c b/drivers/scsi/vmw_pvscsi.c
index 8dbb4db6831a..4aa7166d13fb 100644
--- a/drivers/scsi/vmw_pvscsi.c
+++ b/drivers/scsi/vmw_pvscsi.c
@@ -1347,7 +1347,7 @@ static u32 pvscsi_get_max_targets(struct pvscsi_adapter *adapter)
 
 static int pvscsi_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
-	unsigned int irq_flag = PCI_IRQ_MSIX | PCI_IRQ_MSI | PCI_IRQ_LEGACY;
+	unsigned int irq_flag = PCI_IRQ_ALL_TYPES;
 	struct pvscsi_adapter *adapter;
 	struct pvscsi_adapter adapter_temp;
 	struct Scsi_Host *host = NULL;
-- 
2.17.2

