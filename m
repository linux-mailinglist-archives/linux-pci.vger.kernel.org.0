Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21ED4625BD9
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 14:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234079AbiKKN5h (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 08:57:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233995AbiKKN4g (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 08:56:36 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C197E82C56;
        Fri, 11 Nov 2022 05:55:09 -0800 (PST)
Message-ID: <20221111122015.516946468@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668174908;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=o9tkl2d2tC9egQPEBUifcDdfF9knjDTOjOdgLUksEhs=;
        b=Su8WkdktmaQZnQFe4G4U9ma1vOuBXXYDHeKzs+nJ4ypK8tbIDeDg8t6p/+iwp2yjUe4Ht2
        /IZqPBRcKzvLSqBTBkToQ1mY4FdrLYKjU4mUPBPRZkmYWS7wxcklecLp+/LDx6I692inbi
        Pib/VAL+L1e3KDQHzOZDaZQh/oyZaQw7ZJnPjVjU/EA3ZFoLLwCEMCjYytL8YLpcWgzJTS
        t4HDKCTcEHB4VWAjNHDLvB05QuEGqQq0NPv2w1YnGFMqdqAC5n7pRdANlemgsj9cTxS0Pq
        0NgymSBVP6eTSi+POjdh2sZLy0a//ARWXxQnrBVfmVehy/yDf52zIoCs24JUFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668174908;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=o9tkl2d2tC9egQPEBUifcDdfF9knjDTOjOdgLUksEhs=;
        b=KIGuSY4SHqfY2xYt0UXwXFotUsRZ7MwILcY+hFirUyhfKVZQYvYuooVliEYPFYi0XbVRDs
        q/SAL05mXclgyDCw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ashok Raj <ashok.raj@intel.com>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [patch 33/39] PCI/MSI: Sanitize MSI-X checks
References: <20221111120501.026511281@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 11 Nov 2022 14:55:07 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

There is no point in doing the same sanity checks over and over in a loop
during MSI-X enablement. Put them in front of the loop and return early
when they fail.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/pci/msi/msi.c |   67 +++++++++++++++++++++++++-------------------------
 1 file changed, 34 insertions(+), 33 deletions(-)

--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -721,47 +721,31 @@ static int msix_capability_init(struct p
 	return ret;
 }
 
-static int __pci_enable_msix(struct pci_dev *dev, struct msix_entry *entries,
-			     int nvec, struct irq_affinity *affd, int flags)
+static bool pci_msix_validate_entries(struct msix_entry *entries, int nvec, int hwsize)
 {
-	int nr_entries;
 	int i, j;
 
-	if (!pci_msi_supported(dev, nvec) || dev->current_state != PCI_D0)
-		return -EINVAL;
+	if (!entries)
+		return true;
 
-	nr_entries = pci_msix_vec_count(dev);
-	if (nr_entries < 0)
-		return nr_entries;
-	if (nvec > nr_entries && !(flags & PCI_IRQ_VIRTUAL))
-		return nr_entries;
-
-	if (entries) {
-		/* Check for any invalid entries */
-		for (i = 0; i < nvec; i++) {
-			if (entries[i].entry >= nr_entries)
-				return -EINVAL;		/* invalid entry */
-			for (j = i + 1; j < nvec; j++) {
-				if (entries[i].entry == entries[j].entry)
-					return -EINVAL;	/* duplicate entry */
-			}
+	for (i = 0; i < nvec; i++) {
+		/* Entry within hardware limit? */
+		if (entries[i].entry >= hwsize)
+			return false;
+
+		/* Check for duplicate entries */
+		for (j = i + 1; j < nvec; j++) {
+			if (entries[i].entry == entries[j].entry)
+				return false;
 		}
 	}
-
-	/* Check whether driver already requested for MSI IRQ */
-	if (dev->msi_enabled) {
-		pci_info(dev, "can't enable MSI-X (MSI IRQ already assigned)\n");
-		return -EINVAL;
-	}
-	return msix_capability_init(dev, entries, nvec, affd);
+	return true;
 }
 
-int __pci_enable_msix_range(struct pci_dev *dev,
-			    struct msix_entry *entries, int minvec,
-			    int maxvec, struct irq_affinity *affd,
-			    int flags)
+int __pci_enable_msix_range(struct pci_dev *dev, struct msix_entry *entries, int minvec,
+			    int maxvec, struct irq_affinity *affd, int flags)
 {
-	int rc, nvec = maxvec;
+	int hwsize, rc, nvec = maxvec;
 
 	if (maxvec < minvec)
 		return -ERANGE;
@@ -774,6 +758,23 @@ int __pci_enable_msix_range(struct pci_d
 	if (WARN_ON_ONCE(dev->msix_enabled))
 		return -EINVAL;
 
+	if (!pci_msi_supported(dev, nvec) || dev->current_state != PCI_D0)
+		return -EINVAL;
+
+	hwsize = pci_msix_vec_count(dev);
+	if (hwsize < 0)
+		return hwsize;
+
+	if (!pci_msix_validate_entries(entries, nvec, hwsize))
+		return -EINVAL;
+
+	/* PCI_IRQ_VIRTUAL is a horrible hack! */
+	if (nvec > hwsize && !(flags & PCI_IRQ_VIRTUAL))
+		nvec = hwsize;
+
+	if (nvec < minvec)
+		return -ENOSPC;
+
 	rc = pci_setup_msi_context(dev);
 	if (rc)
 		return rc;
@@ -785,7 +786,7 @@ int __pci_enable_msix_range(struct pci_d
 				return -ENOSPC;
 		}
 
-		rc = __pci_enable_msix(dev, entries, nvec, affd, flags);
+		rc = msix_capability_init(dev, entries, nvec, affd);
 		if (rc == 0)
 			return nvec;
 

