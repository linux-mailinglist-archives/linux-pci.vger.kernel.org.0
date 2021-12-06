Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF2546AD83
	for <lists+linux-pci@lfdr.de>; Mon,  6 Dec 2021 23:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376739AbhLFWzm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Dec 2021 17:55:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359421AbhLFWy4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Dec 2021 17:54:56 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70CDBC061D5F;
        Mon,  6 Dec 2021 14:51:24 -0800 (PST)
Message-ID: <20211206210748.251752714@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638831082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=JXvHU/eN0iJfDqMWbOd2UGXYgpl11UY148yTUdaqnAk=;
        b=ukVi5c/T0wAHb0tWABPTJaUJemaPo0rn/ubgZey7RWONU6+1fkTEp8z7nsXym15YfPSOE5
        gnuGJ9tYXfPz/XmKxaGw/rWBKd3wGOGsLUyCa5pt6g4Ho/VHynZ8/8qUrkrrzaKdiUKiFA
        yd7Vz3JZgxduDhmYYHK6QE9T/SuQZan/17wKFT2uBdepAeN0onpzHk7FOnaPQvbNSQJa1u
        fcugKzMmwOWAMJs3UC5IftbkkN1qTj6HFNtFF42kTBKqdsIymhLXws2qmGn3EEYWahrvQZ
        /2BGRgdEm7qxuk081PI2V1XUwse1UmYqbcpvcjMWvU3qKsZ7AolzmuPZFyYsQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638831082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=JXvHU/eN0iJfDqMWbOd2UGXYgpl11UY148yTUdaqnAk=;
        b=YM0Ywg7edi2ZBxPs7s0TLBjJF3/P4WkZ3tMBbv6SeiU4PPQA1i7E5adkZL6TVwgY/+0w4W
        hrhh523QoFEKpCDg==
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
Subject: [patch V2 12/31] xen/pcifront: Rework MSI handling
References: <20211206210600.123171746@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  6 Dec 2021 23:51:21 +0100 (CET)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Replace the about to vanish iterators.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/pci/xen-pcifront.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/pci/xen-pcifront.c
+++ b/drivers/pci/xen-pcifront.c
@@ -262,7 +262,7 @@ static int pci_frontend_enable_msix(stru
 	}
 
 	i = 0;
-	for_each_pci_msi_entry(entry, dev) {
+	msi_for_each_desc(entry, &dev->dev, MSI_DESC_NOTASSOCIATED) {
 		op.msix_entries[i].entry = entry->msi_index;
 		/* Vector is useless at this point. */
 		op.msix_entries[i].vector = -1;

