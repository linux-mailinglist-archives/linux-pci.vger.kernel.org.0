Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A62363260A
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 15:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbiKUOgv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 09:36:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbiKUOgi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 09:36:38 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD99C80F7;
        Mon, 21 Nov 2022 06:36:23 -0800 (PST)
Message-ID: <20221121083325.684903415@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669041382;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=r4t3gJp+Epgg61Tiq3or6HjYA/efOz+SN1LtRddhdOs=;
        b=ByJ4TGTDiZ/BCKI9AZssqVDMX6vzAcNgwwDKR9d9tUEqtIqB7eYIjBJ8UATg87Yta+GF/1
        4vU8hFIIP3pgRnRpoDk/NXC9rcKc6dhdaBKS7VjKzPEoQRCGKMzk+YNCGOuiMiK9+SKUIt
        4ai1idtByA/HKdfh43swzNhSDkRuC2GkkMRG5br9Nj3I1Xd5Oep6nru74DT9U80IbXR+7w
        X+MnA1Y/WNJOUv+VJBqbnNRxaCiS7C/xZ5usb0hdm4wAraeS3y9jUDC8qSAyyGH1NhV8HU
        3LFpI79QKgF/lqPvCyFMAVIaZztJ95Du29vdMT5XYWGcKC4ziYa/oDuRKqmqLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669041382;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=r4t3gJp+Epgg61Tiq3or6HjYA/efOz+SN1LtRddhdOs=;
        b=C377Nk6LN+Na+cdZLBgNMKV2GHWZARy1u0FfATTUT5yEm2Fmv1vj7kR6hCVIxojpsep9fx
        MZbSP3mGqvJ0BADA==
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
        Jason Gunthorpe <jgg@nvidia.com>
Subject: [patch V2 03/21] genirq/irqdomain: Rename irq_domain::dev to
 irq_domain::pm_dev
References: <20221121083210.309161925@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 21 Nov 2022 15:36:22 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

irq_domain::dev is a misnomer as it's usually the rule that a device
pointer points to something which is directly related to the instance.

irq_domain::dev can point to some other device for power management to
ensure that this underlying device is not powered down when an interrupt is
allocated.

The upcoming per device MSI domains really require a pointer to the device
which instantiated the irq domain and not to some random other device which
is required for power management down the chain.

Rename irq_domain::dev to irq_domain::pm_dev and fixup the few sites which
use that pointer.

Conversion was done with the help of coccinelle.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/irqchip/irq-gic.c |    4 ++--
 include/linux/irqdomain.h |    6 +++---
 kernel/irq/chip.c         |    8 ++++----
 3 files changed, 9 insertions(+), 9 deletions(-)

--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -401,8 +401,8 @@ static void gic_irq_print_chip(struct ir
 {
 	struct gic_chip_data *gic = irq_data_get_irq_chip_data(d);
 
-	if (gic->domain->dev)
-		seq_printf(p, gic->domain->dev->of_node->name);
+	if (gic->domain->pm_dev)
+		seq_printf(p, gic->domain->pm_dev->of_node->name);
 	else
 		seq_printf(p, "GIC-%d", (int)(gic - &gic_data[0]));
 }
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -131,7 +131,7 @@ struct irq_domain_chip_generic;
  * @gc:		Pointer to a list of generic chips. There is a helper function for
  *		setting up one or more generic chips for interrupt controllers
  *		drivers using the generic chip library which uses this pointer.
- * @dev:	Pointer to a device that can be utilized for power management
+ * @pm_dev:	Pointer to a device that can be utilized for power management
  *		purposes related to the irq domain.
  * @parent:	Pointer to parent irq_domain to support hierarchy irq_domains
  *
@@ -153,7 +153,7 @@ struct irq_domain {
 	struct fwnode_handle		*fwnode;
 	enum irq_domain_bus_token	bus_token;
 	struct irq_domain_chip_generic	*gc;
-	struct device			*dev;
+	struct device			*pm_dev;
 #ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
 	struct irq_domain		*parent;
 #endif
@@ -206,7 +206,7 @@ static inline void irq_domain_set_pm_dev
 					    struct device *dev)
 {
 	if (d)
-		d->dev = dev;
+		d->pm_dev = dev;
 }
 
 #ifdef CONFIG_IRQ_DOMAIN
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -1561,10 +1561,10 @@ int irq_chip_compose_msi_msg(struct irq_
 	return 0;
 }
 
-static struct device *irq_get_parent_device(struct irq_data *data)
+static struct device *irq_get_pm_device(struct irq_data *data)
 {
 	if (data->domain)
-		return data->domain->dev;
+		return data->domain->pm_dev;
 
 	return NULL;
 }
@@ -1578,7 +1578,7 @@ static struct device *irq_get_parent_dev
  */
 int irq_chip_pm_get(struct irq_data *data)
 {
-	struct device *dev = irq_get_parent_device(data);
+	struct device *dev = irq_get_pm_device(data);
 	int retval = 0;
 
 	if (IS_ENABLED(CONFIG_PM) && dev)
@@ -1597,7 +1597,7 @@ int irq_chip_pm_get(struct irq_data *dat
  */
 int irq_chip_pm_put(struct irq_data *data)
 {
-	struct device *dev = irq_get_parent_device(data);
+	struct device *dev = irq_get_pm_device(data);
 	int retval = 0;
 
 	if (IS_ENABLED(CONFIG_PM) && dev)

