Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05B2946AD97
	for <lists+linux-pci@lfdr.de>; Mon,  6 Dec 2021 23:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377118AbhLFWz6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Dec 2021 17:55:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376292AbhLFWzR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Dec 2021 17:55:17 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30FBCC0698C0;
        Mon,  6 Dec 2021 14:51:30 -0800 (PST)
Message-ID: <20211206210748.468512783@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638831088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=rqnSsBxgLRUZrf8NprfQGM3zrSARm5hvHEZd8TZTvDo=;
        b=h9HO3s1ktar1QeAbr3otNX0rmxAlcW1iQ88vyJogrIMq41wqZRiE89OLLV+PN6bEroFkHj
        H3ATEdX2zJOFD1nguj09YCLx3R6eZsFH5kdhDX8CpEUlVbN9Ph5FEjF84eTddzqBWNFBR5
        ypH18/7SUa5inaLDA+TTnwmgnQfHDjztdKXryvbI22vPIMfBpBKXAC2LJkU/1W00LDagBQ
        dYuRA0G0MDWP3yUTLdCMVCgSG6GaLDPglC9ZXiTbk+0m9+uvHXPqeyGyRSSfgslep8BueY
        WhdIKyOSOg2ZGorzCHLkcATlyXF92ldijDDv8FlXniMtkwUmZ5qTeqenZ/2niA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638831088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=rqnSsBxgLRUZrf8NprfQGM3zrSARm5hvHEZd8TZTvDo=;
        b=w5AdxxaOLU0xPGWEInq++C8OVVfck3vvMYuz0+9mwGNrvA/PCygz8XkOrssgo6p/9Q5c7a
        lsWj5BB4Ewc5fsCg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Cedric Le Goater <clg@kaod.org>,
        xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com
Subject: [patch V2 16/31] powerpc/pasemi/msi: Convert to msi_on_each_dec()
References: <20211206210600.123171746@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  6 Dec 2021 23:51:28 +0100 (CET)
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

