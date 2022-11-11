Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C32A0625BA7
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 14:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233681AbiKKNzl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 08:55:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233688AbiKKNzT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 08:55:19 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4414742D2;
        Fri, 11 Nov 2022 05:54:35 -0800 (PST)
Message-ID: <20221111122014.294554462@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668174874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=bJxkwerKAjiWe6cHbEqN33xS2DP9tmAemXhkKdu0gyY=;
        b=QLffNtOU+BM9Q6v/Z8H95R6LwiMPRmhfbmoj75MKEHMyuvoWkxB4RbZv0LOe8zConFdPn3
        FoUFDUYVoPhjPiUz6C+xwY6wbZBS5lKJg3/Gsu3284EwPDC+c//3QKxn3kDkoOFde3hYQC
        +pd/Xgm/h8dGs8OjV+shpssdUDGjerTJOwD/8mC4GG/L0S4ZPt/7rL+PeupLgtvUpTDE1N
        Un9QztBWeePvOOGEhy8v40+sFh0e4oCbUYoSJSn1XhDvUlTbCyxiOgkrR743ROQ9a0ADqn
        +HbdIbRhYeOip7Q6YM6FLWMKuOVt6JtuB76/8dQyT2nLcE1Cab8xY9yYhSPJGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668174874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=bJxkwerKAjiWe6cHbEqN33xS2DP9tmAemXhkKdu0gyY=;
        b=REJ8yjGkmRMaCMvX4cw1m2qo8vf54uF9WaXNDdGlD7gTrIZa0CONrZEpNhXpv0sciserxB
        AcKM8IQKL5Qmr3BQ==
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
Subject: [patch 12/39] genirq/msi: Add bus token to struct msi_domain_info
References: <20221111120501.026511281@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 11 Nov 2022 14:54:33 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ahmed S. Darwish <darwi@linutronix.de>

Add a bus token member to struct msi_domain_info and let
msi_create_irq_domain() set the bus token.

That allows to remove the bus token updates at the call sites.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/msi.h |   19 +++++++++++--------
 kernel/irq/msi.c    |    7 +++++--
 2 files changed, 16 insertions(+), 10 deletions(-)

--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -16,6 +16,7 @@
  * abuse. The only function which is relevant for drivers is msi_get_virq().
  */
 
+#include <linux/irqdomain_defs.h>
 #include <linux/cpumask.h>
 #include <linux/xarray.h>
 #include <linux/mutex.h>
@@ -365,6 +366,7 @@ struct msi_domain_ops {
 /**
  * struct msi_domain_info - MSI interrupt domain data
  * @flags:		Flags to decribe features and capabilities
+ * @bus_token:		The domain bus token
  * @ops:		The callback data structure
  * @chip:		Optional: associated interrupt chip
  * @chip_data:		Optional: associated interrupt chip data
@@ -374,14 +376,15 @@ struct msi_domain_ops {
  * @data:		Optional: domain specific data
  */
 struct msi_domain_info {
-	u32			flags;
-	struct msi_domain_ops	*ops;
-	struct irq_chip		*chip;
-	void			*chip_data;
-	irq_flow_handler_t	handler;
-	void			*handler_data;
-	const char		*handler_name;
-	void			*data;
+	u32				flags;
+	enum irq_domain_bus_token	bus_token;
+	struct msi_domain_ops		*ops;
+	struct irq_chip			*chip;
+	void				*chip_data;
+	irq_flow_handler_t		handler;
+	void				*handler_data;
+	const char			*handler_name;
+	void				*data;
 };
 
 /* Flags for msi_domain_info */
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -694,8 +694,11 @@ struct irq_domain *msi_create_irq_domain
 	domain = irq_domain_create_hierarchy(parent, IRQ_DOMAIN_FLAG_MSI, 0,
 					     fwnode, &msi_domain_ops, info);
 
-	if (domain && !domain->name && info->chip)
-		domain->name = info->chip->name;
+	if (domain) {
+		if (!domain->name && info->chip)
+			domain->name = info->chip->name;
+		irq_domain_update_bus_token(domain, info->bus_token);
+	}
 
 	return domain;
 }

