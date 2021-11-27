Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 124EE45FBD1
	for <lists+linux-pci@lfdr.de>; Sat, 27 Nov 2021 03:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347519AbhK0CSO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Nov 2021 21:18:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347495AbhK0CQM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Nov 2021 21:16:12 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78395C08EB46;
        Fri, 26 Nov 2021 17:31:15 -0800 (PST)
Message-ID: <20211126232735.369004773@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637976237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=ir5jZb4IZcCDGObECwlZouR2K23XLyndrt4jAkdV6zI=;
        b=CEbEncBFd79SOa0EOimvV896J6bDWoEgGfC/nt/eAMUctI0xYECPNgFVc9ByreqQYS0YKB
        SQZD9itZD5tnR4I/OYO0xDpvdw2RZNucDT+P0pKbpgAMNe7d3GX7qlUJkOns/efuHRoZnD
        Vf2dfLKwTXxXPw34aqdm6fHJX8r6QL2nUP5nv/bx+uBVp33mMux8kA/tzWvfcLsOQgIYr3
        fVZneV5WsksZXFTAHSF/U73nD+D4VVHVAIPwFgEQPCbr8sombgcBIpKXkDmmrzJTHu36Xr
        KoFyZdZx3lDHKVoBt/gCd1MzD16iW5AvWWgGSvBsxBoydzwbOD57QneIIHJmyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637976237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=ir5jZb4IZcCDGObECwlZouR2K23XLyndrt4jAkdV6zI=;
        b=IamFMDenlbmI8hzLNYVPnhk6KWomGRfmSixhD0rXfq5X+g8vI1vy6Q0YeZtmhO4RD8TZD7
        p7HOHcT6xreIZmDw==
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
Date:   Sat, 27 Nov 2021 02:23:56 +0100 (CET)
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

