Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADE9E45FAAD
	for <lists+linux-pci@lfdr.de>; Sat, 27 Nov 2021 02:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352901AbhK0Bdt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Nov 2021 20:33:49 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40478 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349809AbhK0BbM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Nov 2021 20:31:12 -0500
Message-ID: <20211126232735.309081709@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637976174;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=rqnSsBxgLRUZrf8NprfQGM3zrSARm5hvHEZd8TZTvDo=;
        b=cLRUWibZqIBOtkT8FnlUzaXAXTx8bnOs4nsamr6zno31aQWc2Nj8zK4yYN9cItQKwot9Jb
        XXE7rsOg5YyROIm/jTIPoYtCy9K96sgb0XE4oIc52nD7buR9DssHDK9t6D0Gj7M7KpNbBd
        AbcCjrP5nShZ4P+v8AM9ITOpZ3SCzO2vsme6bX9mmtah17aP8Oph68oOhJthhLec0utuJr
        dP0Hq+M9riChZp9QcoreSmVzB4eBImH/pHE8d/L4A/uX693dxlHFJeOeRv5ZfCYDTmRrt3
        wsV729nsdIs7yAzfUYV17nY9SiGMDlAXSQHNOifjjdEBMSAOAmdx/hCgF5cR1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637976174;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=rqnSsBxgLRUZrf8NprfQGM3zrSARm5hvHEZd8TZTvDo=;
        b=1FRMnB83qeCS2cyTNaCZIdgnPpFtJOR/uXffDXnAA9rvrXk7W3Sf1rlDbwH/SP8yYsE04S
        xiGiZX4Pgv6XzHCQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com
Subject: [patch 17/32] powerpc/pasemi/msi: Convert to msi_on_each_dec()
References: <20211126230957.239391799@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 27 Nov 2021 02:22:53 +0100 (CET)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Replace the about to vanish iterators and make use of the filtering.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/powerpc/platforms/pasemi/msi.c |    9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

--- a/arch/powerpc/platforms/pasemi/msi.c
+++ b/arch/powerpc/platforms/pasemi/msi.c
@@ -62,17 +62,12 @@ static void pasemi_msi_teardown_msi_irqs
 
 	pr_debug("pasemi_msi_teardown_msi_irqs, pdev %p\n", pdev);
 
-	for_each_pci_msi_entry(entry, pdev) {
-		if (!entry->irq)
-			continue;
-
+	msi_for_each_desc(entry, &pdev->dev, MSI_DESC_ASSOCIATED) {
 		hwirq = virq_to_hw(entry->irq);
 		irq_set_msi_desc(entry->irq, NULL);
 		irq_dispose_mapping(entry->irq);
 		msi_bitmap_free_hwirqs(&msi_mpic->msi_bitmap, hwirq, ALLOC_CHUNK);
 	}
-
-	return;
 }
 
 static int pasemi_msi_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
@@ -90,7 +85,7 @@ static int pasemi_msi_setup_msi_irqs(str
 	msg.address_hi = 0;
 	msg.address_lo = PASEMI_MSI_ADDR;
 
-	for_each_pci_msi_entry(entry, pdev) {
+	msi_for_each_desc(entry, &pdev->dev, MSI_DESC_NOTASSOCIATED) {
 		/* Allocate 16 interrupts for now, since that's the grouping for
 		 * affinity. This can be changed later if it turns out 32 is too
 		 * few MSIs for someone, but restrictions will apply to how the

