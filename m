Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD6AE45FBCA
	for <lists+linux-pci@lfdr.de>; Sat, 27 Nov 2021 03:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349696AbhK0CSF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Nov 2021 21:18:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350089AbhK0CQE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Nov 2021 21:16:04 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E10C08EB3B;
        Fri, 26 Nov 2021 17:31:06 -0800 (PST)
Message-ID: <20211126232735.069709622@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637976229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=JXvHU/eN0iJfDqMWbOd2UGXYgpl11UY148yTUdaqnAk=;
        b=lSmmn8UQUMHaA27oGWhQLdRMIwwKOAAOugFuLESWrhOHRA0aO8qY5X/spCYMfdo+DWtgt/
        EiODp9I8nmnYJ5JPIrquNFnczbXu4k53zacEouvHyV9kaUOniBabuAhTHAyeZ5WSb7N4VE
        d+pWHde0JfVhC+CASELRdaucgofCV1jyaSKZXUCTUXLG52sM0HTvz87W7O15eeok3WhGxm
        pXiS+RCNLsQUGictBvlomudk7UNUosYq86OyVha2p1HRivqcvKldhq0AZ/ct8g4RiZNjIm
        JarVsbJw/nHNXkTNfySt+FLD/Lid42RxqdWZZnM2S/dRZaK0KBN81F0dSvfaog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637976229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=JXvHU/eN0iJfDqMWbOd2UGXYgpl11UY148yTUdaqnAk=;
        b=0jNcPNgz56R9m5AGoyTj7IbGVRdx1dNEXeV5JlIcEI27fXTSQCtAvXBudMGXD7KkOugn5p
        xQqnq+Ij5fdYP4Bw==
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
Subject: [patch 13/32] xen/pcifront: Rework MSI handling
References: <20211126230957.239391799@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 27 Nov 2021 02:23:49 +0100 (CET)
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

