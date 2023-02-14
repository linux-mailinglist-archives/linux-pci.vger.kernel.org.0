Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC74696EF1
	for <lists+linux-pci@lfdr.de>; Tue, 14 Feb 2023 22:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbjBNVNp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Feb 2023 16:13:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbjBNVNj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2023 16:13:39 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7F62CFC0;
        Tue, 14 Feb 2023 13:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676409219; x=1707945219;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=puSbuAcz02y9LK3ESZrCo3tJeInFpkfPbwBoqD8i9tE=;
  b=mKxxrRtEdDXqSbvT7wL9X05pqfGG3oJECzyYYH3TJA4LOm6r3kXAwdhJ
   R3sCGcysXOZEJ6/JojSYYxyxhcK23mkTxd2jTvSGVrVU8RVP69OsjUviw
   PN+IKBZGzjegQE8V7S/bEIkQ/WKESxA6FFkE5SK8Fb8KjSd15b73vps5y
   FveR2diIw9J1B3eD8m11QjJeIgFeu0INJLsoE3dHXGL+MkM+RwAX0xsqj
   4KiAmLf3VJkOdkaYhKqhlm/jXLGOm2YpZZ55LfQdF76PItXW8MM/Ajqo5
   25lqdpSV/jMGf2fKQLIIBcmUfsNApAwGwheWQqVk3fi4nzUA9lh8zpoDb
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="417493586"
X-IronPort-AV: E=Sophos;i="5.97,297,1669104000"; 
   d="scan'208";a="417493586"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 13:13:32 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="998214380"
X-IronPort-AV: E=Sophos;i="5.97,297,1669104000"; 
   d="scan'208";a="998214380"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 13:13:31 -0800
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, darwi@linutronix.de, bhelgaas@google.com,
        maz@kernel.org, kevin.tian@intel.com, bagasdotme@gmail.com
Cc:     jing2.liu@intel.com, reinette.chatre@intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH] PCI/MSI: Clarify usage of pci_msix_free_irq()
Date:   Tue, 14 Feb 2023 13:13:20 -0800
Message-Id: <4c3e7a50d6e70f408812cd7ab199c6b4b326f9de.1676408572.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pci_msix_free_irq() is used to free an interrupt on
a PCI/MSI-X interrupt domain.

The API description specifies that the interrupt to
be freed was allocated via pci_msix_alloc_irq_at().
This description limits the usage of pci_msix_free_irq()
since pci_msix_free_irq() can also be used to free
MSI-X interrupts allocated with, for example,
pci_alloc_irq_vectors().

Remove the text stating that the interrupt to be freed had
to be allocated with pci_msix_alloc_irq_at(). The needed
struct msi_map need not be from pci_msix_alloc_irq_at()
but can be created from scratch using pci_irq_vector()
to obtain the Linux IRQ number. Highlight that
pci_msix_free_irq() cannot be used to disable MSI-X to
guide users that, for example, pci_free_irq_vectors()
remains to be needed.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
Dear Maintainers,

Is my understanding correct?

For example, from my understanding the following is
correct API usage:

/*
 * Enable MSI-X and allocate num interrupts.
 */
pci_alloc_irq_vectors()

/*
 * Free one of the interrupts allocated via pci_alloc_irq_vectors().
 * Possibly called num times, but not required.
 */
pci_msix_free_irq()

/*
 * Ensure all remaining interrupts freed and MSI-X disabled.
 */
pci_free_irq_vectors()

This could be interpreted as an asymmetric usage of the API, yet
found to be practical when trying to use these new calls.

Your feedback is appreciated.

Regards,

Reinette

 drivers/pci/msi/api.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/msi/api.c b/drivers/pci/msi/api.c
index b8009aa11f3c..be679aa5db64 100644
--- a/drivers/pci/msi/api.c
+++ b/drivers/pci/msi/api.c
@@ -163,11 +163,11 @@ EXPORT_SYMBOL_GPL(pci_msix_alloc_irq_at);
 
 /**
  * pci_msix_free_irq - Free an interrupt on a PCI/MSIX interrupt domain
- *		      which was allocated via pci_msix_alloc_irq_at()
  *
  * @dev:	The PCI device to operate on
  * @map:	A struct msi_map describing the interrupt to free
- *		as returned from the allocation function.
+ *
+ * Undo an interrupt vector allocation. Does not disable MSI-X.
  */
 void pci_msix_free_irq(struct pci_dev *dev, struct msi_map map)
 {
-- 
2.34.1

