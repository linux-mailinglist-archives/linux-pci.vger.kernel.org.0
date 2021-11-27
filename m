Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D850345FBCF
	for <lists+linux-pci@lfdr.de>; Sat, 27 Nov 2021 03:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347464AbhK0CSN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Nov 2021 21:18:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350136AbhK0CQK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Nov 2021 21:16:10 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A31C08EB3E;
        Fri, 26 Nov 2021 17:31:12 -0800 (PST)
Message-ID: <20211126232735.249206271@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637976234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=doaEN4PngPF6b3Ms4+nCLub9WRL+cYqg2iUonunceVg=;
        b=fc0JY4ckDKxoH26FfRbTdheQxJnwXrLr3K0QmZPqu792QDpqzfL/Z54oDwHkg4gkBELP77
        jGe5nWrLzad8SPnVh2iJe8FXTuKjwpBePEcz9OQRBhnk8oM2Lg4pXZBtH+xYoa83J+Afxd
        ENoTC6k6lv2PfNo65WSmc8/UrCk4PXrhcqeyH4fGq8BuzO0Wo/CrDnzOcwfoQ9+uCHx3qM
        4CmUe+Iz6gmRd12ABNBM5RUDIlHo1kJ+FqoaEjSMMHDxLyRsOgA0dqRBVOcCRNXT+SUjG1
        zBtgPAfrjQ08JB8YZz4TRhSVMOGxuGr/bAtHGH37AW2SWYVEakQGrCZRqOskcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637976234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=doaEN4PngPF6b3Ms4+nCLub9WRL+cYqg2iUonunceVg=;
        b=GGfmVZnHRteeFHWzloW33y+Uz0hgCJV00muK3lobTlzN0aH4PVXRqMLpZxReeE9oG3e5zr
        qnekNU1sLdEwEqDQ==
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
Subject: [patch 16/32] powerpc/cell/axon_msi: Convert to msi_on_each_desc()
References: <20211126230957.239391799@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 27 Nov 2021 02:23:53 +0100 (CET)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Replace the about to vanish iterators and make use of the filtering.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/powerpc/platforms/cell/axon_msi.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

--- a/arch/powerpc/platforms/cell/axon_msi.c
+++ b/arch/powerpc/platforms/cell/axon_msi.c
@@ -265,7 +265,7 @@ static int axon_msi_setup_msi_irqs(struc
 	if (rc)
 		return rc;
 
-	for_each_pci_msi_entry(entry, dev) {
+	msi_for_each_desc(entry, &dev->dev, MSI_DESC_NOTASSOCIATED) {
 		virq = irq_create_direct_mapping(msic->irq_domain);
 		if (!virq) {
 			dev_warn(&dev->dev,
@@ -288,10 +288,7 @@ static void axon_msi_teardown_msi_irqs(s
 
 	dev_dbg(&dev->dev, "axon_msi: tearing down msi irqs\n");
 
-	for_each_pci_msi_entry(entry, dev) {
-		if (!entry->irq)
-			continue;
-
+	msi_for_each_desc(entry, &dev->dev, MSI_DESC_ASSOCIATED) {
 		irq_set_msi_desc(entry->irq, NULL);
 		irq_dispose_mapping(entry->irq);
 	}

