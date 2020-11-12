Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D970A2B0D9C
	for <lists+linux-pci@lfdr.de>; Thu, 12 Nov 2020 20:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgKLTPF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Nov 2020 14:15:05 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46606 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbgKLTPE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Nov 2020 14:15:04 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605208502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VT0wgNNnYfg403e5d0pAs+2XCLbbkpVLyNxvOBCDBuE=;
        b=ht3hNrDRCVGymMncVEg5pjAcDv08tWywC6nLFZ8yD77PdLFXCLO0Ue46Y1S68o/VtPYazI
        Xmw6baNY48Jphh6gQVv9vgE9TnmXAKVbv1WXuWF15pzAwMHmYiy5o99xh6OH6bHDXqJrRW
        Si3X+wwQUbexkqsUdkQPQruWfFCf7QsZcISN5ORskkgtGXEeh9lS2Tn5ub+GvZM0s7FhAB
        5WQwYNqTWgh1xWwB6amImhyDfWZe2+NerCuq1n7RpJtn1AFHz0MVnXLWbfEzqvlbQ73/Ko
        PEa8f6IIiyv00ZloSWluRID8KzI5Ao1lH2HdcNX/Nv8XcwK5ayWi8Bh83JwNfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605208502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VT0wgNNnYfg403e5d0pAs+2XCLbbkpVLyNxvOBCDBuE=;
        b=Az6qw/Q+kOFcEDQj8L6u+EJlRh4aQzhE/iNGjllYzvg/z9F90alZL2d95mOZbTNLrzOOjh
        Ka4aBVfxaajGxqAg==
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Ziyad Atiyyeh <ziyadat@nvidia.com>,
        Itay Aveksis <itayav@nvidia.com>,
        Moshe Shemesh <moshe@nvidia.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marc Zyngier <maz@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>
Subject: iommu/vt-d: Cure VF irqdomain hickup
In-Reply-To: <87k0uqmwn4.fsf@nanos.tec.linutronix.de>
References: <20200826111628.794979401@linutronix.de> <20201112125531.GA873287@nvidia.com> <87mtzmmzk6.fsf@nanos.tec.linutronix.de> <87k0uqmwn4.fsf@nanos.tec.linutronix.de>
Date:   Thu, 12 Nov 2020 20:15:02 +0100
Message-ID: <87d00imlop.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The recent changes to store the MSI irqdomain pointer in struct device
missed that Intel DMAR does not register virtual function devices.  Due to
that a VF device gets the plain PCI-MSI domain assigned and then issues
compat MSI messages which get caught by the interrupt remapping unit.

Cure that by inheriting the irq domain from the physical function
device.

That's a temporary workaround. The correct fix is to inherit the irq domain
from the bus, but that's a larger effort which needs quite some other
changes to the way how x86 manages PCI and MSI domains.

Fixes: 85a8dfc57a0b ("iommm/vt-d: Store irq domain in struct device")
Reported-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/iommu/intel/dmar.c |   19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -333,6 +333,11 @@ static void  dmar_pci_bus_del_dev(struct
 	dmar_iommu_notify_scope_dev(info);
 }
 
+static inline void vf_inherit_msi_domain(struct pci_dev *pdev)
+{
+	dev_set_msi_domain(&pdev->dev, dev_get_msi_domain(&pdev->physfn->dev));
+}
+
 static int dmar_pci_bus_notifier(struct notifier_block *nb,
 				 unsigned long action, void *data)
 {
@@ -342,8 +347,20 @@ static int dmar_pci_bus_notifier(struct
 	/* Only care about add/remove events for physical functions.
 	 * For VFs we actually do the lookup based on the corresponding
 	 * PF in device_to_iommu() anyway. */
-	if (pdev->is_virtfn)
+	if (pdev->is_virtfn) {
+		/*
+		 * Note: This is a horrible hack and needs to be cleaned
+		 * up by assigning the domain to the bus, but that's too
+		 * big of a change for post rc3.
+		 *
+		 * Ensure that the VF device inherits the irq domain of the
+		 * PF device:
+		 */
+		if (action == BUS_NOTIFY_ADD_DEVICE)
+			vf_inherit_msi_domain(pdev);
 		return NOTIFY_DONE;
+	}
+
 	if (action != BUS_NOTIFY_ADD_DEVICE &&
 	    action != BUS_NOTIFY_REMOVED_DEVICE)
 		return NOTIFY_DONE;
