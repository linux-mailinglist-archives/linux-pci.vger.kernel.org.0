Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A54B6326C9
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 15:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbiKUOtp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 09:49:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232539AbiKUOsO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 09:48:14 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B15D33B9;
        Mon, 21 Nov 2022 06:42:10 -0800 (PST)
Message-ID: <20221121140049.617825672@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669041595;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=JA4DJhkL/SLZbiCPUtuJ/m0vEuiHsTx0BFOI4LdR10Q=;
        b=ydxHf/DSO9NqBzlSdDCOGZV8yc29f1kRL496Hy5wKB99tucPeKGC07lk3cKpyK9+2COl8c
        hjpk4rku7hZme1xQb60Ze8od18AYw/U/L2FQTdDLhNWxF1q2REtqR5/VICsDuxiJDB+qC0
        lePu9FthiNaXK0Rayd8iIfrfZy6hntLOUUWK3SvBG0wHXaB3rlJfUg+mmaV1yVMogOQ0qO
        iyNdELpqvPfrCQ2G9j99NQ/+0mbIKlUkx7U34Vo67IglWB5tvwZKq+IEfLuluvvIjHQSQs
        ovcOyuCpqFarEwyiIVojI+sCJBBvrZpvQMmJdRhtj7dFDiaAwRJeSDubKzD7Wg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669041595;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=JA4DJhkL/SLZbiCPUtuJ/m0vEuiHsTx0BFOI4LdR10Q=;
        b=tpDw1REhwrgyCWZKJtswkMSb0d8Ir1QxPnOwIaV2QLUMOPSg/Ophl8ZWx4MgtiwRW5aUTF
        J3CTK4CKHP0XrJCw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Will Deacon <will@kernel.org>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Vinod Koul <vkoul@kernel.org>, Sinan Kaya <okaya@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Subject: [patch V2 21/40] genirq/msi: Optionally use dev->fwnode for device domain
References: <20221121135653.208611233@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 21 Nov 2022 15:39:54 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

To support wire to MSI domains via the MSI infrastructure it is required to
use the firmware node of the device which implements this for creating the
MSI domain. Otherwise the existing firmware match mechanisms to find the
correct irqdomain for a wired interrupt which is connected to a wire to MSI
bridge would fail.

This cannot be used for the general case because not all devices provide
firmware nodes and all regular per device MSI domains are directly
associated to the device and have not be searched for.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/msi.h |    2 ++
 kernel/irq/msi.c    |   20 ++++++++++++++++----
 2 files changed, 18 insertions(+), 4 deletions(-)

--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -536,6 +536,8 @@ enum {
 	 * handled in the core MSI code.
 	 */
 	MSI_FLAG_NOMASK_QUIRK		= (1 << 7),
+	/* Use dev->fwnode for MSI device domain creation */
+	MSI_FLAG_USE_DEV_FWNODE		= (1 << 8),
 
 	/* Mask for the generic functionality */
 	MSI_GENERIC_FLAGS_MASK		= GENMASK(15, 0),
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -998,9 +998,9 @@ bool msi_create_device_irq_domain(struct
 				  void *chip_data)
 {
 	struct irq_domain *domain, *parent = dev->msi.domain;
-	const struct msi_parent_ops *pops;
+	struct fwnode_handle *fwnode, *fwnalloced = NULL;
 	struct msi_domain_template *bundle;
-	struct fwnode_handle *fwnode;
+	const struct msi_parent_ops *pops;
 
 	if (!irq_domain_is_msi_parent(parent))
 		return false;
@@ -1023,7 +1023,19 @@ bool msi_create_device_irq_domain(struct
 		 pops->prefix ? : "", bundle->chip.name, dev_name(dev));
 	bundle->chip.name = bundle->name;
 
-	fwnode = irq_domain_alloc_named_fwnode(bundle->name);
+	/*
+	 * Using the device firmware node is required for wire to MSI
+	 * device domains so that the existing firmware results in a domain
+	 * match.
+	 * All other device domains like PCI/MSI use the named firmware
+	 * node as they are not guaranteed to have a fwnode. They are never
+	 * looked up and always handled in the context of the device.
+	 */
+	if (bundle->info.flags & MSI_FLAG_USE_DEV_FWNODE)
+		fwnode = dev->fwnode;
+	else
+		fwnode = fwnalloced = irq_domain_alloc_named_fwnode(bundle->name);
+
 	if (!fwnode)
 		goto free_bundle;
 
@@ -1050,7 +1062,7 @@ bool msi_create_device_irq_domain(struct
 fail:
 	msi_unlock_descs(dev);
 free_fwnode:
-	kfree(fwnode);
+	kfree(fwnalloced);
 free_bundle:
 	kfree(bundle);
 	return false;

