Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAFC9625BDE
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 14:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234045AbiKKN5u (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 08:57:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234050AbiKKN5A (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 08:57:00 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB607F572;
        Fri, 11 Nov 2022 05:55:14 -0800 (PST)
Message-ID: <20221111122015.691357406@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668174913;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=ZT2wqZQe1H/I6Zbp9NC+LKW2/0gzRDmAQRTFrKQsKJ4=;
        b=pZhlEC8HQoltxfUbzgMXHkDfB0GRlxnLvSjN1dc3PiVBo8WSLYIF9ktMwc0XjNYb4kLS8+
        FqTCjJWZeq1j8WqGwul0V0shm019qcC15aTTmWrBmibPa4iyBaHln17GO+B7a+FZ7HzxkG
        0nigWZfumb9aUEbIyEZcIeoXLpiQyjkTbnipeH21yJ5xwmTxonq864TxZUl+LihVftel2x
        Ph1PWWqEcs7OLda5Ee6GdGF+KAXyt4i9XvX9Y9f9J76I48MVaA77REkSGiMVd5hEo8Wn9s
        7pMPZ0LZKwuqpeWH/NkpM1YFXBbaazZjlZyRkesNTxkBHo+2AUSp+C++9BSUwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668174913;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=ZT2wqZQe1H/I6Zbp9NC+LKW2/0gzRDmAQRTFrKQsKJ4=;
        b=XzyeTFE4zXDDmgsFpNdLl62MN8+2pdKYw4Ip6qUuQqqfIw4P9A9EW8A7NpauZTzTWtO0LS
        F5TDeOWU93205LDg==
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
Subject: [patch 36/39] PCI/MSI: Validate MSIX contiguous restriction early
References: <20221111120501.026511281@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 11 Nov 2022 14:55:12 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

With interrupt domains the sanity check for MSI-X vector validation can be
done _before_ any allocation happens. The sanity check only applies to the
allocation functions which have an 'entries' array argument. The entries
array is filled by the caller with the requested MSI-X indicies. Some drivers
have gaps in the index space which is not supported on all architectures.

The PCI/MSI irqdomain has a 'feature' bit to enforce this validation late
during the allocation phase.

Just do it right away before doing any other work along with the other
sanity checks on that array.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/pci/msi/msi.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -725,13 +725,17 @@ static int msix_capability_init(struct p
 	return ret;
 }
 
-static bool pci_msix_validate_entries(struct msix_entry *entries, int nvec, int hwsize)
+static bool pci_msix_validate_entries(struct pci_dev *dev, struct msix_entry *entries,
+				      int nvec, int hwsize)
 {
+	bool nogap;
 	int i, j;
 
 	if (!entries)
 		return true;
 
+	nogap = pci_msi_domain_supports(dev, MSI_FLAG_MSIX_CONTIGUOUS, DENY_LEGACY);
+
 	for (i = 0; i < nvec; i++) {
 		/* Entry within hardware limit? */
 		if (entries[i].entry >= hwsize)
@@ -742,6 +746,9 @@ static bool pci_msix_validate_entries(st
 			if (entries[i].entry == entries[j].entry)
 				return false;
 		}
+		/* Check for unsupported gaps */
+		if (nogap && entries[i].entry != i)
+			return false;
 	}
 	return true;
 }
@@ -773,7 +780,7 @@ int __pci_enable_msix_range(struct pci_d
 	if (hwsize < 0)
 		return hwsize;
 
-	if (!pci_msix_validate_entries(entries, nvec, hwsize))
+	if (!pci_msix_validate_entries(dev, entries, nvec, hwsize))
 		return -EINVAL;
 
 	/* PCI_IRQ_VIRTUAL is a horrible hack! */

