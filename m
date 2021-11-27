Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B361545FAAF
	for <lists+linux-pci@lfdr.de>; Sat, 27 Nov 2021 02:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349752AbhK0Bdt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Nov 2021 20:33:49 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40482 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350786AbhK0BbP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Nov 2021 20:31:15 -0500
Message-ID: <20211126232735.369004773@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637976175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=ir5jZb4IZcCDGObECwlZouR2K23XLyndrt4jAkdV6zI=;
        b=WPJ+FRFy5v5PNjMEye9NWhFG90LSbL/ajZ3Ot+1c/4H7f9U6tl/BtR4r0uGYtWK6s8vseW
        vcFLmfz1feQTeGxE/iakq9hKo8jcHYbZbO8c0ziVNoNKyZnAHOjjZRkqpiQR/bjVsjFcDA
        X3b2hjWqnvwhD2Mx//rY9KgfJ2Qu5cG286epPAu1FHp+cdcXw05ulMGgIgjvGCZdeow2HJ
        +5cuqrQlp+J44/Ojce4VAKnTGdpgxbLjdyKCcUCng8aEDIE69yITv6G+4UXmqqDzspD/pE
        ykT82aDz0ejfSTzhHUAWR6wpLvszlMWK3nNIVH6F2i5QvNnKaXC9iQascFXxMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637976175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=ir5jZb4IZcCDGObECwlZouR2K23XLyndrt4jAkdV6zI=;
        b=gGV8Rw/qG6+hc0b+o6fGuBNh1BQB3U/mDF24NlJdOWuOeOvCKhAHxqIwjaSx8hIwGVQV2B
        rgrXeKexct6+b0DA==
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
Subject: [patch 18/32] powerpc/fsl_msi: Use msi_for_each_desc()
References: <20211126230957.239391799@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 27 Nov 2021 02:22:55 +0100 (CET)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Replace the about to vanish iterators and make use of the filtering.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/powerpc/sysdev/fsl_msi.c |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

--- a/arch/powerpc/sysdev/fsl_msi.c
+++ b/arch/powerpc/sysdev/fsl_msi.c
@@ -125,17 +125,13 @@ static void fsl_teardown_msi_irqs(struct
 	struct fsl_msi *msi_data;
 	irq_hw_number_t hwirq;
 
-	for_each_pci_msi_entry(entry, pdev) {
-		if (!entry->irq)
-			continue;
+	msi_for_each_desc(entry, &pdev->dev, MSI_DESC_ASSOCIATED) {
 		hwirq = virq_to_hw(entry->irq);
 		msi_data = irq_get_chip_data(entry->irq);
 		irq_set_msi_desc(entry->irq, NULL);
 		irq_dispose_mapping(entry->irq);
 		msi_bitmap_free_hwirqs(&msi_data->bitmap, hwirq, 1);
 	}
-
-	return;
 }
 
 static void fsl_compose_msi_msg(struct pci_dev *pdev, int hwirq,
@@ -215,7 +211,7 @@ static int fsl_setup_msi_irqs(struct pci
 		}
 	}
 
-	for_each_pci_msi_entry(entry, pdev) {
+	msi_for_each_desc(entry, &pdev->dev, MSI_DESC_NOTASSOCIATED) {
 		/*
 		 * Loop over all the MSI devices until we find one that has an
 		 * available interrupt.

