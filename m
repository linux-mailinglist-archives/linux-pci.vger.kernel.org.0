Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 934E2625BAA
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 14:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233695AbiKKNzr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 08:55:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233702AbiKKNzU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 08:55:20 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521B1748CE;
        Fri, 11 Nov 2022 05:54:37 -0800 (PST)
Message-ID: <20221111122014.352437595@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668174875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=SR+JTKB3rKiZ73e/G+mgOLVXr9oQkVaEjTjLGttb2Gk=;
        b=cquks9wvdwGZvfTVGMseDqonmMru5Jvd1Wp80d+QA7r+OPUBjVQ33nkUC2zM/Xj1+O8fPG
        vtb671Sgwa26sjZk08mR0d6Khag9L+dcgpdaaiX3gijScukZ+VHAfliD2IMtv3iaBOUF0H
        z/MslAY6PXFpX332pOy1ThF73fCI+4dA58/e9E/htDuO/wELj5pOCP8hkEbevCn9g05Q6e
        Dc8lugCbNGIQGIngKhOUPod5JqprevnRQk8hF+mBQQn/l8M/1bzTmQzN7g8pOmzecptGGk
        /UJmMPp34YQm20YaIUWb6Ef0Mc9mjvia3FKyyNDWpMCxHg3It/xaV2cgV2oHEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668174875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=SR+JTKB3rKiZ73e/G+mgOLVXr9oQkVaEjTjLGttb2Gk=;
        b=upJdg7cKT2Y7T72CwaobIKCBWj/eDCRfZapw31fhp5ESPdWoHIOrAME2ohvtTWo1VMweL7
        27ljumxd1t7PlDBA==
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
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org
Subject: [patch 13/39] PCI/MSI: Use msi_domain_info::bus_token
References: <20221111120501.026511281@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 11 Nov 2022 14:54:35 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ahmed S. Darwish <darwi@linutronix.de>

Set the bus token in the msi_domain_info structure and let the core code
handle the update.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/pci/msi/irqdomain.c |   11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -162,8 +162,6 @@ struct irq_domain *pci_msi_create_irq_do
 					     struct msi_domain_info *info,
 					     struct irq_domain *parent)
 {
-	struct irq_domain *domain;
-
 	if (WARN_ON(info->flags & MSI_FLAG_LEVEL_CAPABLE))
 		info->flags &= ~MSI_FLAG_LEVEL_CAPABLE;
 
@@ -178,13 +176,10 @@ struct irq_domain *pci_msi_create_irq_do
 
 	/* PCI-MSI is oneshot-safe */
 	info->chip->flags |= IRQCHIP_ONESHOT_SAFE;
+	/* Let the core update the bus token */
+	info->bus_token = DOMAIN_BUS_PCI_MSI;
 
-	domain = msi_create_irq_domain(fwnode, info, parent);
-	if (!domain)
-		return NULL;
-
-	irq_domain_update_bus_token(domain, DOMAIN_BUS_PCI_MSI);
-	return domain;
+	return msi_create_irq_domain(fwnode, info, parent);
 }
 EXPORT_SYMBOL_GPL(pci_msi_create_irq_domain);
 

