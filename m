Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2DF33D1710
	for <lists+linux-pci@lfdr.de>; Wed, 21 Jul 2021 21:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240140AbhGUSro (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Jul 2021 14:47:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48968 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbhGUSro (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Jul 2021 14:47:44 -0400
Message-Id: <20210721192650.106154171@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626895699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=OrDJU+xft+e5MU/yz4DSTjhy6EYE85pzXmPlv5dSTyM=;
        b=pEtE4n9a+U9pdcmzFrnqriRsVoeLABV/5mE9m1mj9qgaRvtV8x+UV1m/e/2ujmqUQuN2gG
        pLW/96aL2/XHMTNB5j+W7tMkRf3QCr6u0WXmd/hwVdI52LyG0ovT4HNcCwAtQ1NZ+fVPoW
        1j4OqVhVTXz0vRazP+gY11TbJO/AkH48Nf5BNSoMXW7y7g6EuwtjzuukvvzUhYgbRHf1/0
        6ah45BoEH2E18P6j+UmrqKs/vo9xulLWee+aUe5KEFOJbe3fv0lU8W83znOCdqmDEpHt05
        2Hjne6ETdj6z7WQ/OF3oO0WOcuDpSBZR3lbNOoZwKWNkruxzIWTRi0NLOlv5kw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626895699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=OrDJU+xft+e5MU/yz4DSTjhy6EYE85pzXmPlv5dSTyM=;
        b=vcfPvsdU7UXpTnUyVOh43/yJsMaH4b6FoFNjDn1YBHwJSTaJM1Yi44y+hR042ozTIcpgp1
        ezoqCokvU5m9AqAg==
Date:   Wed, 21 Jul 2021 21:11:27 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Kevin Tian <kevin.tian@intel.com>,
        Marc Zyngier <maz@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org
Subject: [patch 1/8] PCI/MSI: Enable and mask MSIX early
References: <20210721191126.274946280@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The ordering of MSI-X enable in hardware is disfunctional:

 1) MSI-X is disabled in the control register
 2) Various setup functions
 3) pci_msi_setup_msi_irqs() is invoked which ends up accessing
    the MSI-X table entries
 4) MSI-X is enabled and masked in the control register with the
    comment that enabling is required for some hardware to access
    the MSI-X table

#4 obviously contradicts #3. The history of this is an issue with the NIU
hardware. When #4 was introduced the table access actually happened in
msix_program_entries() which was invoked after enabling and masking MSI-X.

This was changed in commit d71d6432e105 ("PCI/MSI: Kill redundant call of
irq_set_msi_desc() for MSI-X interrupts") which removed the table write
from msix_program_entries().

Interestingly enough nobody noticed and either NIU still works or it did
not get any testing with a kernel 3.19 or later.

Nevertheless this is inconsistent and there is no reason why MSI-X can't be
enabled and masked in the control register early on, i.e. move #4 above to
#1. This preserves the NIU workaround and has no side effects on other
hardware.

Fixes: d71d6432e105 ("PCI/MSI: Kill redundant call of irq_set_msi_desc() for MSI-X interrupts")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: David S. Miller <davem@davemloft.net>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
---
 drivers/pci/msi.c |   28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -772,18 +772,25 @@ static int msix_capability_init(struct p
 	u16 control;
 	void __iomem *base;
 
-	/* Ensure MSI-X is disabled while it is set up */
-	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_ENABLE, 0);
+	/*
+	 * Some devices require MSI-X to be enabled before the MSI-X
+	 * registers can be accessed.  Mask all the vectors to prevent
+	 * interrupts coming in before they're fully set up.
+	 */
+	pci_msix_clear_and_set_ctrl(dev, 0, PCI_MSIX_FLAGS_MASKALL |
+				    PCI_MSIX_FLAGS_ENABLE);
 
 	pci_read_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, &control);
 	/* Request & Map MSI-X table region */
 	base = msix_map_region(dev, msix_table_size(control));
-	if (!base)
-		return -ENOMEM;
+	if (!base) {
+		ret = -ENOMEM;
+		goto out_disable;
+	}
 
 	ret = msix_setup_entries(dev, base, entries, nvec, affd);
 	if (ret)
-		return ret;
+		goto out_disable;
 
 	ret = pci_msi_setup_msi_irqs(dev, nvec, PCI_CAP_ID_MSIX);
 	if (ret)
@@ -794,14 +801,6 @@ static int msix_capability_init(struct p
 	if (ret)
 		goto out_free;
 
-	/*
-	 * Some devices require MSI-X to be enabled before we can touch the
-	 * MSI-X registers.  We need to mask all the vectors to prevent
-	 * interrupts coming in before they're fully set up.
-	 */
-	pci_msix_clear_and_set_ctrl(dev, 0,
-				PCI_MSIX_FLAGS_MASKALL | PCI_MSIX_FLAGS_ENABLE);
-
 	msix_program_entries(dev, entries);
 
 	ret = populate_msi_sysfs(dev);
@@ -836,6 +835,9 @@ static int msix_capability_init(struct p
 out_free:
 	free_msi_irqs(dev);
 
+out_disable:
+	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_ENABLE, 0);
+
 	return ret;
 }
 

