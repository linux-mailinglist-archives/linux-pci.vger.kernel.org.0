Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A643B625BE2
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 14:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234057AbiKKN6G (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 08:58:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234061AbiKKN5B (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 08:57:01 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6172085460;
        Fri, 11 Nov 2022 05:55:16 -0800 (PST)
Message-ID: <20221111122015.749446904@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668174915;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Ih0SYkcSYwketpyalRo87sRSG9j843DJDGdjQI9dFbE=;
        b=VRE7MeUlB+cCM6U0cjMzbGN3WDIQa4HFZh7046HSLFSqzZZR+YCs/CdvdLqq6MWSGZekns
        H/dGx3if2rOBFQbosYmjXgs8H6R5QzfT4Wx9HUiK3bRvDeCd3Y2/aKwsZmLgcB2RLXpdOs
        oVkPfJgyTtJEli4A4Tu93d2MK7EdOeIEH+Y0BZTm7D17rn3qKvvsqjvAZrJgzd7vVJM1e9
        1Z0lHU2nKsnKqYI3bqO1EqiYcRaa2k7iEq2ImYpiFsxIhbdqk1xQCU1UqPFsjb5fWestXq
        04JcUcgHgsR+8pKz5h9KEtGpLzv4hoUBfbtq/MJ4c2jMIoOztbmH2Ysjx6MsoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668174915;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Ih0SYkcSYwketpyalRo87sRSG9j843DJDGdjQI9dFbE=;
        b=3NdsAzuzZxu0dT7r41E3zPAtIf/iHCijDpTpmlZOnjI92Lbu6pLEazC2N//W9XAeQ4XAqW
        7LzccZ7efW9feDBw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ashok Raj <ashok.raj@intel.com>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [patch 37/39] PCI/MSI: Remove redundant msi_check() callback
References: <20221111120501.026511281@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 11 Nov 2022 14:55:14 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

All these sanity checks are now done _before_ any allocation work
happens. No point in doing it twice.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/pci/msi/irqdomain.c |   48 --------------------------------------------
 1 file changed, 48 deletions(-)

--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -64,51 +64,6 @@ static irq_hw_number_t pci_msi_domain_ca
 		(pci_domain_nr(dev->bus) & 0xFFFFFFFF) << 27;
 }
 
-static inline bool pci_msi_desc_is_multi_msi(struct msi_desc *desc)
-{
-	return !desc->pci.msi_attrib.is_msix && desc->nvec_used > 1;
-}
-
-/**
- * pci_msi_domain_check_cap - Verify that @domain supports the capabilities
- *			      for @dev
- * @domain:	The interrupt domain to check
- * @info:	The domain info for verification
- * @dev:	The device to check
- *
- * Returns:
- *  0 if the functionality is supported
- *  1 if Multi MSI is requested, but the domain does not support it
- *  -ENOTSUPP otherwise
- */
-static int pci_msi_domain_check_cap(struct irq_domain *domain,
-				    struct msi_domain_info *info,
-				    struct device *dev)
-{
-	struct msi_desc *desc = msi_first_desc(dev, MSI_DESC_ALL);
-
-	/* Special handling to support __pci_enable_msi_range() */
-	if (pci_msi_desc_is_multi_msi(desc) &&
-	    !(info->flags & MSI_FLAG_MULTI_PCI_MSI))
-		return 1;
-
-	if (desc->pci.msi_attrib.is_msix) {
-		if (!(info->flags & MSI_FLAG_PCI_MSIX))
-			return -ENOTSUPP;
-
-		if (info->flags & MSI_FLAG_MSIX_CONTIGUOUS) {
-			unsigned int idx = 0;
-
-			/* Check for gaps in the entry indices */
-			msi_for_each_desc(desc, dev, MSI_DESC_ALL) {
-				if (desc->msi_index != idx++)
-					return -ENOTSUPP;
-			}
-		}
-	}
-	return 0;
-}
-
 static void pci_msi_domain_set_desc(msi_alloc_info_t *arg,
 				    struct msi_desc *desc)
 {
@@ -118,7 +73,6 @@ static void pci_msi_domain_set_desc(msi_
 
 static struct msi_domain_ops pci_msi_domain_ops_default = {
 	.set_desc	= pci_msi_domain_set_desc,
-	.msi_check	= pci_msi_domain_check_cap,
 };
 
 static void pci_msi_domain_update_dom_ops(struct msi_domain_info *info)
@@ -130,8 +84,6 @@ static void pci_msi_domain_update_dom_op
 	} else {
 		if (ops->set_desc == NULL)
 			ops->set_desc = pci_msi_domain_set_desc;
-		if (ops->msi_check == NULL)
-			ops->msi_check = pci_msi_domain_check_cap;
 	}
 }
 

