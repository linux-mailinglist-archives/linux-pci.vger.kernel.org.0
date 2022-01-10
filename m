Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 361F5489EE0
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jan 2022 19:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238788AbiAJSMs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Jan 2022 13:12:48 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44422 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238786AbiAJSMs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Jan 2022 13:12:48 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1641838366;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2zo1GoaegfwLq8ByWLgrCdt6kQL15RfNmR27qdFkCXs=;
        b=wg+0jYPkfyXBANMF9DrbB1VZY/A2H3NxCDNL0PdKZaQjveELygI6vChYjpmK8mezF1B8JM
        3Q6Fgd45hThR6NFyrAztLFQW0Du/St5l9y9ZtElwgFl9NDDq0PXVzJtEVKov8EaNRDZ81L
        eVdqnmysikOkVjpjAg882Gsjz6yZ54Uctmk12wQHCofZiwWVPnCbHkpvv4tDyYO3vZLG9w
        e64U20W7FggbG9+ID3eENSFzucC7Eorc5fEgfrJ4OKYz0CE6hPEZM+Xgk2ce8kuvb0VAsa
        X3V2Ri9KCwv0+VUgAxjPNl/CVqXJXoiumYuNcRD9koqxMMscv8p75zWFHCgf8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1641838366;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2zo1GoaegfwLq8ByWLgrCdt6kQL15RfNmR27qdFkCXs=;
        b=1JyyFqm//sjHNxcOA43/6zXwebeoZM76NF5Ms6lFcm7i8cDw3SAOwzaBpYafr8eAGkMdhU
        XC6nlPN+OSbMq8AQ==
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
Subject: [patch] genirq/msi: Populate sysfs entry only once
In-Reply-To: <20211206210749.224917330@linutronix.de>
References: <20211206210600.123171746@linutronix.de>
 <20211206210749.224917330@linutronix.de>
Date:   Mon, 10 Jan 2022 19:12:45 +0100
Message-ID: <87leznqx2a.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The MSI entries for multi-MSI are populated en bloc for the MSI descriptor,
but the current code invokes the population inside the per interrupt loop
which triggers a warning in the sysfs code and causes the interrupt
allocation to fail.

Move it outside of the loop so it works correctly for single and multi-MSI.

Fixes: bf5e758f02fc ("genirq/msi: Simplify sysfs handling")
Reported-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/msi.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -887,12 +887,11 @@ int __msi_domain_alloc_irqs(struct irq_d
 			ret = msi_init_virq(domain, virq + i, vflags);
 			if (ret)
 				return ret;
-
-			if (info->flags & MSI_FLAG_DEV_SYSFS) {
-				ret = msi_sysfs_populate_desc(dev, desc);
-				if (ret)
-					return ret;
-			}
+		}
+		if (info->flags & MSI_FLAG_DEV_SYSFS) {
+			ret = msi_sysfs_populate_desc(dev, desc);
+			if (ret)
+				return ret;
 		}
 		allocated++;
 	}
