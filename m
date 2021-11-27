Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1BB45FAA3
	for <lists+linux-pci@lfdr.de>; Sat, 27 Nov 2021 02:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350658AbhK0BdB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Nov 2021 20:33:01 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40390 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350687AbhK0BbA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Nov 2021 20:31:00 -0500
Message-ID: <20211126232735.188511206@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637976171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Zss9mzfScWFeJ2auPATLVX18AC4Qn1uic4NkiF38xfU=;
        b=YiFqzeKObYyR8gdLwqWL7lLtGRweq+8gMHyrcavDdDr8GvgDGTkqrIISrqz1G9pvkaRHxZ
        1qiQEd4yaTdbHziLbbOxMfK3Eo9FlLCWGe2Xzw7Pt3HSu06b/mfn0JdNoNyj80YXs9U3M0
        24vibXh/WbTSuhr29fxVLBXqn1uxo3T5lTR97NPlYztbDUrc1FAH3wANoQhSRHqHr6zFqy
        tMAn0zFz/kSYKitw5/F5aWWfZZ3pgYAWV6c5qQtDyZlfzuaewwyKORJjTOA0WaeuvcpjNs
        MoeLLdF92YrFrr+GBawq4ZZr9YnkFS9Cp1tV5YmLBn2/e8oqUbB+bj7hXRMmfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637976171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Zss9mzfScWFeJ2auPATLVX18AC4Qn1uic4NkiF38xfU=;
        b=zKjAT1R2vI2U75x0fa08y7brxNvJnXbqrRec8BgxLyy7+QIU2Gj6vNluAMzKJ4BOxUnbQ9
        Kzk7NbPSPPTNe/Aw==
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
Subject: [patch 15/32] powerpc/4xx/hsta: Rework MSI handling
References: <20211126230957.239391799@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 27 Nov 2021 02:22:50 +0100 (CET)
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

