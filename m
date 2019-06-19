Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C717C4C333
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2019 23:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730596AbfFSVlq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jun 2019 17:41:46 -0400
Received: from mga11.intel.com ([192.55.52.93]:10385 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725908AbfFSVlq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Jun 2019 17:41:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jun 2019 14:41:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,394,1557212400"; 
   d="scan'208";a="170683471"
Received: from megha-z97x-ud7-th.sc.intel.com ([143.183.85.162])
  by orsmga002.jf.intel.com with ESMTP; 19 Jun 2019 14:41:45 -0700
From:   Megha Dey <megha.dey@linux.intel.com>
To:     bhelgaas@google.com, linux-pci@vger.kernel.org
Cc:     ashok.raj@intel.com, jacob.jun.pan@linux.intel.com,
        megha.dey@intel.com, Megha Dey <megha.dey@linux.intel.com>
Subject: [RFC V1 6/6] Documentation: PCI/MSI: Document dynamic MSI-X infrastructure
Date:   Wed, 19 Jun 2019 15:03:44 -0700
Message-Id: <1560981824-3966-7-git-send-email-megha.dey@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1560981824-3966-1-git-send-email-megha.dey@linux.intel.com>
References: <1560981824-3966-1-git-send-email-megha.dey@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add Documentation for the newly introduced dynamic allocation
and deallocation of MSI-X vectors.

Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Megha Dey <megha.dey@linux.intel.com>
---
 Documentation/PCI/MSI-HOWTO.txt | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/Documentation/PCI/MSI-HOWTO.txt b/Documentation/PCI/MSI-HOWTO.txt
index 618e13d..5f6daf4 100644
--- a/Documentation/PCI/MSI-HOWTO.txt
+++ b/Documentation/PCI/MSI-HOWTO.txt
@@ -156,6 +156,44 @@ the driver can specify that only MSI or MSI-X is acceptable:
 	if (nvec < 0)
 		goto out_err;
 
+4.2.1 Dynamic MSI-X Allocation:
+
+The pci_alloc_irq_vectors() API is a one-shot method to allocate MSI resources
+i.e. they cannot be called multiple times. In order to allocate MSI-X vectors
+post probe phase, multiple times, use the following API:
+
+  int pci_alloc_irq_vectors_dyn(struct pci_dev *dev, unsigned int min_vecs,
+                unsigned int max_vecs, unsigned int flags, int *group_id);
+
+This API allocates up to max_vecs interrupt vectors for a PCI device. It returns
+the number of vectors allocated or a negative error. If the device has a
+requirement for a minimum number of vectors the driver can pass a min_vecs
+argument set to this limit, and the PCI core will return -ENOSPC if it can't
+meet the minimum number of vectors. This API is only to be used for MSI-X vectors.
+
+A group ID pointer is passed which gets populated by this function. A unique
+group_id will associated with all the MSI-X vectors allocated each time this
+function is called:
+
+	int group_id;
+	nvec = pci_alloc_irq_vectors_dyn(pdev, minvecs, maxvecs,
+					flags | PCI_IRQ_MSIX, &group_id);
+	if (nvec < 0)
+		goto out_err;
+
+To get the Linux IRQ numbers to pass to request_irq() and free_irq(), use the
+following function:
+
+  int pci_irq_vec_grp(struct pci_dev *dev, unsigned int nr, unsigned int group_id);
+
+In order to free the MSI-X resources associated with a particular group, use
+the following function:
+
+  int pci_free_irq_vectors_grp(struct pci_dev *dev, int group_id);
+
+For example, to delete the group allocated with the pci_alloc_irq_vectors_dyn(),
+	nvec = pci_free_irq_vectors_grp(pdev, group_id);
+
 4.3 Legacy APIs
 
 The following old APIs to enable and disable MSI or MSI-X interrupts should
-- 
2.7.4

