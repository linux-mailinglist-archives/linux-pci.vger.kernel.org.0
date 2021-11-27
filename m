Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7CA945FB16
	for <lists+linux-pci@lfdr.de>; Sat, 27 Nov 2021 02:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348146AbhK0BgV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Nov 2021 20:36:21 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40678 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345102AbhK0BeU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Nov 2021 20:34:20 -0500
Message-ID: <20211126232735.130164978@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637976231;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=bDqDcBZ6Ac8mk8Pi4m81SdvqMSMLhFM8ia6/waF9mec=;
        b=St0aVbpnc3WECutTSdVn9BPOUKXe38biQ493aKheeovz/6rpzVRtrq6YxfPjt4MyWwkumE
        dn5Rsmc2dUgAYFZjTQnB+RIQZS0mg1dy/PNMXJjIdMUoaOWQT1mDvNXCOcxzDK3KfAUozL
        VA81HVOpGzpkNCldgfVDgq11psm+YdlqZQIiW+FyKPa1vERT0NalYSdqP0yfuKdyqssHro
        zBW9mCYP50vFTvi62vwTbFURmcbuzQyJ7S2Xt1+oSzl9qBlD6Nwa9XpNKi+0PUyNP2opgr
        gZdmrBVQbCFFPbEGN9+lcEfaX81M1uy6ZaI9Z9GYpk906O6OkfMscGgMe6YnKg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637976231;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=bDqDcBZ6Ac8mk8Pi4m81SdvqMSMLhFM8ia6/waF9mec=;
        b=IUp4pTsAMnBJgnLtXNBCngP8Subu5N09d4GuMkS0IoSTXUObgfoJsIKVHdsJF45UG+OH6D
        dyyVGK54UuhcfXCA==
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
Subject: [patch 14/32] s390/pci: Rework MSI descriptor walk
References: <20211126230957.239391799@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 27 Nov 2021 02:23:50 +0100 (CET)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Replace the about to vanish iterators and make use of the filtering.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-s390@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/pci/pci_irq.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- a/arch/s390/pci/pci_irq.c
+++ b/arch/s390/pci/pci_irq.c
@@ -303,7 +303,7 @@ int arch_setup_msi_irqs(struct pci_dev *
 
 	/* Request MSI interrupts */
 	hwirq = bit;
-	for_each_pci_msi_entry(msi, pdev) {
+	msi_for_each_desc(msi, &pdev->dev, MSI_DESC_NOTASSOCIATED) {
 		rc = -EIO;
 		if (hwirq - bit >= msi_vecs)
 			break;
@@ -362,9 +362,7 @@ void arch_teardown_msi_irqs(struct pci_d
 		return;
 
 	/* Release MSI interrupts */
-	for_each_pci_msi_entry(msi, pdev) {
-		if (!msi->irq)
-			continue;
+	msi_for_each_desc(msi, &pdev->dev, MSI_DESC_ASSOCIATED) {
 		irq_set_msi_desc(msi->irq, NULL);
 		irq_free_desc(msi->irq);
 		msi->msg.address_lo = 0;

