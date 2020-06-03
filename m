Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C58F1ECF0B
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jun 2020 13:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726015AbgFCLu1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Jun 2020 07:50:27 -0400
Received: from mga11.intel.com ([192.55.52.93]:22510 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725859AbgFCLu0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Jun 2020 07:50:26 -0400
IronPort-SDR: jPuk67EgRyH6/pbAmQYeExvv7YJx6dv9xC62nKF89W2LyDhUP8mjkR9jeQons4sRhA17659on1
 uR5/jN7SsgRA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2020 04:50:26 -0700
IronPort-SDR: qkbrEW2Rx6p01xjZlvSKzwDazVBrViLQgu/fxhAL4SKW3W+yjoQlOgJs0+RTfgzPlYTcfSQf2F
 x/RO4Ht7wvaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,467,1583222400"; 
   d="scan'208";a="269052095"
Received: from gklab-125-110.igk.intel.com ([10.91.125.110])
  by orsmga003.jf.intel.com with ESMTP; 03 Jun 2020 04:50:22 -0700
From:   Piotr Stankiewicz <piotr.stankiewicz@intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Piotr Stankiewicz <piotr.stankiewicz@intel.com>,
        Brian King <brking@us.ibm.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jim Gill <jgill@vmware.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Wen Xiong <wenxiong@linux.vnet.ibm.com>,
        Takashi Iwai <tiwai@suse.de>, Ming Lei <ming.lei@redhat.com>,
        "Ewan D. Milne" <emilne@redhat.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Jan Kara <jack@suse.cz>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 15/15] scsi: Use PCI_IRQ_MSI_TYPES and PCI_IRQ_ALL_TYPES where appropriate
Date:   Wed,  3 Jun 2020 13:50:16 +0200
Message-Id: <20200603115019.13958-1-piotr.stankiewicz@intel.com>
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
---
 drivers/scsi/ipr.c        | 5 +++--
 drivers/scsi/vmw_pvscsi.c | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/ipr.c b/drivers/scsi/ipr.c
index d48a8fa997b9..8e8d66daabea 100644
--- a/drivers/scsi/ipr.c
+++ b/drivers/scsi/ipr.c
@@ -10273,9 +10273,10 @@ static int ipr_probe_ioa(struct pci_dev *pdev,
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
index c3f010df641e..825b7db9c713 100644
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

