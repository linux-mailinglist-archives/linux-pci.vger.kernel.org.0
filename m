Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96A663DAEFB
	for <lists+linux-pci@lfdr.de>; Fri, 30 Jul 2021 00:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbhG2Wey (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Jul 2021 18:34:54 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49110 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233476AbhG2Wew (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Jul 2021 18:34:52 -0400
Message-ID: <20210729222542.568173099@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627598086;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=e0Rg8yrqC6ByF4Ayj0lHWiTUdgX75JlD8npB4aXrydI=;
        b=PAW9Y/qOxI0ArBO+RbjV3Q6z1O7mYfJIX/7ME5tY4aCrEoT6ry0X9M0vH7GYeEoiAJgqKy
        0OEbIr+DfeZD3kA5yV1Y0AidOUgXOBgag6/itAXSdzOlBqOJYIGsk1EVv/W/pmKjbIgIOG
        otQVZyOesyir/RmwWKUsOBbM1xlczYY7w3vReSZOtbiEzCpj2v2EZ/nhUYfWZmEhPWNOhm
        wSaiVbZrv5MTUtI8zv+49kh97tX/AV+BkVof4JTHW8k3HP/ehO5NJo+HFHyr9vxkyfCTIB
        HFLElDF9hJA/515YAgtUwLkRsouOgssBNFLJuuy9Fuk/h6QhTRGjrOL6qbUlTA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627598086;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=e0Rg8yrqC6ByF4Ayj0lHWiTUdgX75JlD8npB4aXrydI=;
        b=PgfzGnAC5dVd7xUw+4fdCRttRA+s0n6kcWisJrm1CCjNVx3nHonlb6PxPI61294cp8b6zE
        bpwZAT/b3sNUvkCA==
Date:   Thu, 29 Jul 2021 23:51:44 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Kevin Tian <kevin.tian@intel.com>,
        Marc Zyngier <maz@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-s390@vger.kernel.org,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [patch V2 05/19] PCI/MSI: Do not set invalid bits in MSI mask
References: <20210729215139.889204656@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

msi_mask_irq() takes a mask and a flags argument. The mask argument is used
to mask out bits from the cached mask and the flags argument to set bits.

Some places invoke it with a flags argument which sets bits which are not
used by the device, i.e. when the device supports up to 8 vectors a full
unmask in some places sets the mask to 0xFFFFFF00. While devices probably
do not care, it's still bad practice.

Fixes: 7ba1930db02f ("PCI MSI: Unmask MSI if setup failed")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: New patch
---
 drivers/pci/msi.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -656,21 +656,21 @@ static int msi_capability_init(struct pc
 	/* Configure MSI capability structure */
 	ret = pci_msi_setup_msi_irqs(dev, nvec, PCI_CAP_ID_MSI);
 	if (ret) {
-		msi_mask_irq(entry, mask, ~mask);
+		msi_mask_irq(entry, mask, 0);
 		free_msi_irqs(dev);
 		return ret;
 	}
 
 	ret = msi_verify_entries(dev);
 	if (ret) {
-		msi_mask_irq(entry, mask, ~mask);
+		msi_mask_irq(entry, mask, 0);
 		free_msi_irqs(dev);
 		return ret;
 	}
 
 	ret = populate_msi_sysfs(dev);
 	if (ret) {
-		msi_mask_irq(entry, mask, ~mask);
+		msi_mask_irq(entry, mask, 0);
 		free_msi_irqs(dev);
 		return ret;
 	}
@@ -962,7 +962,7 @@ static void pci_msi_shutdown(struct pci_
 	/* Return the device with MSI unmasked as initial states */
 	mask = msi_mask(desc->msi_attrib.multi_cap);
 	/* Keep cached state to be restored */
-	__pci_msi_desc_mask_irq(desc, mask, ~mask);
+	__pci_msi_desc_mask_irq(desc, mask, 0);
 
 	/* Restore dev->irq to its default pin-assertion IRQ */
 	dev->irq = desc->msi_attrib.default_irq;

