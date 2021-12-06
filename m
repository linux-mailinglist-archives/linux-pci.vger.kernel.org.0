Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7F146ADAF
	for <lists+linux-pci@lfdr.de>; Mon,  6 Dec 2021 23:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359071AbhLFW4U (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Dec 2021 17:56:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359721AbhLFWzM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Dec 2021 17:55:12 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F137CC061D7E;
        Mon,  6 Dec 2021 14:51:26 -0800 (PST)
Message-ID: <20211206210748.359766435@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638831085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Zss9mzfScWFeJ2auPATLVX18AC4Qn1uic4NkiF38xfU=;
        b=QbOlaYLd67illK+RXm69ncvgL9zwen35YS0qk4pw2VmlWKfHuqtlqEHHBm8vTfCpXOVtGC
        /YwYsNN2mahTQwgaL5yHyodmBR4odrjNXlKrzL/KtcBH6KXWAa4V/sWDWnkIubcpUyPHLb
        WSphnGnNUyWJ23dyyU1+ZSv9x7GgoRVYZObpp2cDLcN8+Vd4BcIZ5tJ9Mu3arYQje2EL2W
        yzXoWqEcFaE3Ua/TtvSqE+g/9BboZUtfpvfEwH+AS94IqtD9d3NU2w2eybpzXq9zn1r0w+
        rTmvXHoN/7+UEFzjo2qzKQhqJJY8iJqDqw5N5DZ2ZCTqJli84gAxmaYA1nl4KQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638831085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Zss9mzfScWFeJ2auPATLVX18AC4Qn1uic4NkiF38xfU=;
        b=z/DvlpsspWgWro1GdhpcO0qe0cuCFF8HxhKT/D0ITEBaCrXK2e5haCQ2KBiMQ5WWMYJW+s
        H9AWbWwHjRClppAw==
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
Subject: [patch V2 14/31] powerpc/4xx/hsta: Rework MSI handling
References: <20211206210600.123171746@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  6 Dec 2021 23:51:25 +0100 (CET)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Replace the about to vanish iterators and make use of the filtering.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/powerpc/platforms/4xx/hsta_msi.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

--- a/arch/powerpc/platforms/4xx/hsta_msi.c
+++ b/arch/powerpc/platforms/4xx/hsta_msi.c
@@ -47,7 +47,7 @@ static int hsta_setup_msi_irqs(struct pc
 		return -EINVAL;
 	}
 
-	for_each_pci_msi_entry(entry, dev) {
+	msi_for_each_desc(entry, &dev->dev, MSI_DESC_NOTASSOCIATED) {
 		irq = msi_bitmap_alloc_hwirqs(&ppc4xx_hsta_msi.bmp, 1);
 		if (irq < 0) {
 			pr_debug("%s: Failed to allocate msi interrupt\n",
@@ -105,10 +105,7 @@ static void hsta_teardown_msi_irqs(struc
 	struct msi_desc *entry;
 	int irq;
 
-	for_each_pci_msi_entry(entry, dev) {
-		if (!entry->irq)
-			continue;
-
+	msi_for_each_desc(entry, &dev->dev, MSI_DESC_ASSOCIATED) {
 		irq = hsta_find_hwirq_offset(entry->irq);
 
 		/* entry->irq should always be in irq_map */

