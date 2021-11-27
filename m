Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F031145FADF
	for <lists+linux-pci@lfdr.de>; Sat, 27 Nov 2021 02:31:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348991AbhK0BfJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Nov 2021 20:35:09 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40490 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349876AbhK0BbS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Nov 2021 20:31:18 -0500
Message-ID: <20211126232735.429897588@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637976177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=dSVT/iBVTDrru1VCPsyUkPO+wlN5QYdJblBQDMf4a+Q=;
        b=Xm0GCVY1m+0W428IA6zGlHkNzF9WUJ0VrGj0AezNSlzDGyPtju25fv3yLiH3aOBo8zYnsZ
        PkyybXTSGBtd7i42Mo/8Qr+Ls1Ld6BoGicHqofwK+Pqx6fd3qJ/kljV6VOtE8cjdDhCtf6
        rde5xFjmCAtXxiun8vFjXX0B/4mFbhEDIbBy96a9UtKX7vo6TDELi9ZoB1T/+C772xj7Pv
        N6bv0WFrn/JjstShZBGC3axkfms4GgHc0zLMyMC0ISPAbnOZiBmG1/Vz7u7ZSyRTGSRtYN
        h6/1Djh0B6XIHK3ktmLO+5sqJoLVItCf5KTZvmefZQU4xNds1zG4TIngfDuARQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637976177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=dSVT/iBVTDrru1VCPsyUkPO+wlN5QYdJblBQDMf4a+Q=;
        b=xLS/rnrS52pKeIJoXWDMu7CBvqad8o74liCuyH1ND4Vvp+xDnyL9QzY6iar2s06evHw/uW
        SnVpRUgfZJzhyRBQ==
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
Subject: [patch 19/32] powerpc/mpic_u3msi: Use msi_for_each-desc()
References: <20211126230957.239391799@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 27 Nov 2021 02:22:56 +0100 (CET)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Replace the about to vanish iterators and make use of the filtering.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/powerpc/sysdev/mpic_u3msi.c |    9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

--- a/arch/powerpc/sysdev/mpic_u3msi.c
+++ b/arch/powerpc/sysdev/mpic_u3msi.c
@@ -104,17 +104,12 @@ static void u3msi_teardown_msi_irqs(stru
 	struct msi_desc *entry;
 	irq_hw_number_t hwirq;
 
-	for_each_pci_msi_entry(entry, pdev) {
-		if (!entry->irq)
-			continue;
-
+	msi_for_each_desc(entry, &pdev->dev, MSI_DESC_ASSOCIATED) {
 		hwirq = virq_to_hw(entry->irq);
 		irq_set_msi_desc(entry->irq, NULL);
 		irq_dispose_mapping(entry->irq);
 		msi_bitmap_free_hwirqs(&msi_mpic->msi_bitmap, hwirq, 1);
 	}
-
-	return;
 }
 
 static int u3msi_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
@@ -136,7 +131,7 @@ static int u3msi_setup_msi_irqs(struct p
 		return -ENXIO;
 	}
 
-	for_each_pci_msi_entry(entry, pdev) {
+	msi_for_each_desc(entry, &pdev->dev, MSI_DESC_NOTASSOCIATED) {
 		hwirq = msi_bitmap_alloc_hwirqs(&msi_mpic->msi_bitmap, 1);
 		if (hwirq < 0) {
 			pr_debug("u3msi: failed allocating hwirq\n");

