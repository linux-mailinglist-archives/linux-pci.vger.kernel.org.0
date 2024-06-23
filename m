Return-Path: <linux-pci+bounces-9151-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5DB913C30
	for <lists+linux-pci@lfdr.de>; Sun, 23 Jun 2024 17:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE9C41C20B66
	for <lists+linux-pci@lfdr.de>; Sun, 23 Jun 2024 15:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC271891A8;
	Sun, 23 Jun 2024 15:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kR6cbeGX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iN/afFJ8"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4128B18757B;
	Sun, 23 Jun 2024 15:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719155943; cv=none; b=lCxiw0QqcBV/FXzxqmp0HDUacnYwTJLXYWAAqJQzl42D7fryHlFanBlM/9nNKvluZ+5OYlSonG5MAi6dzzK2IX1krSURsd5LJEzjSgSEHb/rJa1f9IrNUd0/TCpHSVg3q3aWDDtWMkauBi0tShV+pzy5LSI2hfFszX+fqG2399c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719155943; c=relaxed/simple;
	bh=zpXKrWYZqQ55KEbkRpRY5kX5TcipB52CDEf6S2N+Jys=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=AHiyfh2iJusRoN/Kf1He50BeFPNuQ0lfRXdI6rpbsI1Ua0468XmP6NlSGPPW7F3UQli6q6GaUdlQcEklfwmiuWq9A1QpSCqbuACqji2auH2fPsi2PKq8aDQ+1XNI7xp8uLQfZcj21IY/J3qh8Sei+d7vyfRc1YY7FgV2PYmSWHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kR6cbeGX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iN/afFJ8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240623142235.759892514@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719155940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=qfvY3/+4AY7ZG/NMFi+HrnHcwQA7ELZ3bkFLIgrjRpY=;
	b=kR6cbeGXV+f6FjMCyn0o6ymuJQLJXWZDvCMGcUkK3rB1KCETnV6HC7J9XMxOFLGLv5MGS8
	3JEB2/vxeAc+ZIfxlfd81x4jVJuUHbpIhTv1pf7VIkp3JwlXuyMRCnfx1bAtf1duRoYoog
	Mjttw0ZfnmLIu9o6Su1sd/eVLD1aiWzqempCkUKLJXAYYkHMjc6KXMjvCaPaw2rwONLyR1
	cO7LvQgw69eCpVWu4GmBc1aSQOyop56atakxnIsMbXLO2kUL4oovyuYVoarJVTqz9lP2sO
	dB2ifQRQQ0u38R9KzY68M3wf0PQCjoKPQa7WNkzLgZVe3bYuqKWJvH5X/owNOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719155940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=qfvY3/+4AY7ZG/NMFi+HrnHcwQA7ELZ3bkFLIgrjRpY=;
	b=iN/afFJ8HI55tBxA/WU466ogZe88bIJaon01ZH7YuuldhZ7WH1mva3HnAz25P97KBBztY+
	StEjiMGhTx5xJ3AA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
 linux-pci@vger.kernel.org,
 maz@kernel.org,
 tglx@linutronix.de,
 anna-maria@linutronix.de,
 shawnguo@kernel.org,
 s.hauer@pengutronix.de,
 festevam@gmail.com,
 bhelgaas@google.com,
 rdunlap@infradead.org,
 vidyas@nvidia.com,
 ilpo.jarvinen@linux.intel.com,
 apatel@ventanamicro.com,
 kevin.tian@intel.com,
 nipun.gupta@amd.com,
 den@valinux.co.jp,
 andrew@lunn.ch,
 gregory.clement@bootlin.com,
 sebastian.hesselbarth@gmail.com,
 gregkh@linuxfoundation.org,
 rafael@kernel.org,
 alex.williamson@redhat.com,
 will@kernel.org,
 lorenzo.pieralisi@arm.com,
 jgg@mellanox.com,
 ammarfaizi2@gnuweeb.org,
 robin.murphy@arm.com,
 lpieralisi@kernel.org,
 nm@ti.com,
 kristo@kernel.org,
 vkoul@kernel.org,
 okaya@kernel.org,
 agross@kernel.org,
 andersson@kernel.org,
 mark.rutland@arm.com,
 shameerali.kolothum.thodi@huawei.com,
 yuzenghui@huawei.com,
 shivamurthy.shastri@linutronix.de
Subject: [patch V4 17/21] irqchip/mvebu-odmi: Switch to parent MSI
References: <20240623142137.448898081@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Sun, 23 Jun 2024 17:19:00 +0200 (CEST)

From: Thomas Gleixner <tglx@linutronix.de>

All platform MSI users and the PCI/MSI code handle per device MSI domains
when the irqdomain associated to the device provides MSI parent
functionality.

Remove the "global" platform domain related code and provide the MSI parent
functionality by filling in msi_parent_ops.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>


---
---
 drivers/irqchip/Kconfig          |    1 +
 drivers/irqchip/irq-mvebu-odmi.c |   37 ++++++++++++++++++-------------------
 2 files changed, 19 insertions(+), 19 deletions(-)

--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -379,6 +379,7 @@ config MVEBU_ICU
 
 config MVEBU_ODMI
 	bool
+	select IRQ_MSI_LIB
 	select GENERIC_MSI_IRQ
 
 config MVEBU_PIC
--- a/drivers/irqchip/irq-mvebu-odmi.c
+++ b/drivers/irqchip/irq-mvebu-odmi.c
@@ -17,6 +17,9 @@
 #include <linux/msi.h>
 #include <linux/of_address.h>
 #include <linux/slab.h>
+
+#include "irq-msi-lib.h"
+
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
 #define GICP_ODMIN_SET			0x40
@@ -141,27 +144,29 @@ static void odmi_irq_domain_free(struct
 }
 
 static const struct irq_domain_ops odmi_domain_ops = {
+	.select	= msi_lib_irq_domain_select,
 	.alloc	= odmi_irq_domain_alloc,
 	.free	= odmi_irq_domain_free,
 };
 
-static struct irq_chip odmi_msi_irq_chip = {
-	.name	= "ODMI",
-};
+#define ODMI_MSI_FLAGS_REQUIRED  (MSI_FLAG_USE_DEF_DOM_OPS |	\
+				  MSI_FLAG_USE_DEF_CHIP_OPS)
 
-static struct msi_domain_ops odmi_msi_ops = {
-};
+#define ODMI_MSI_FLAGS_SUPPORTED (MSI_GENERIC_FLAGS_MASK)
 
-static struct msi_domain_info odmi_msi_domain_info = {
-	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS),
-	.ops	= &odmi_msi_ops,
-	.chip	= &odmi_msi_irq_chip,
+static const struct msi_parent_ops odmi_msi_parent_ops = {
+	.supported_flags	= ODMI_MSI_FLAGS_SUPPORTED,
+	.required_flags		= ODMI_MSI_FLAGS_REQUIRED,
+	.bus_select_token	= DOMAIN_BUS_GENERIC_MSI,
+	.bus_select_mask	= MATCH_PLATFORM_MSI,
+	.prefix			= "ODMI-",
+	.init_dev_msi_info	= msi_lib_init_dev_msi_info,
 };
 
 static int __init mvebu_odmi_init(struct device_node *node,
 				  struct device_node *parent)
 {
-	struct irq_domain *parent_domain, *inner_domain, *plat_domain;
+	struct irq_domain *parent_domain, *inner_domain;
 	int ret, i;
 
 	if (of_property_read_u32(node, "marvell,odmi-frames", &odmis_count))
@@ -208,18 +213,12 @@ static int __init mvebu_odmi_init(struct
 		goto err_unmap;
 	}
 
-	plat_domain = platform_msi_create_irq_domain(of_node_to_fwnode(node),
-						     &odmi_msi_domain_info,
-						     inner_domain);
-	if (!plat_domain) {
-		ret = -ENOMEM;
-		goto err_remove_inner;
-	}
+	irq_domain_update_bus_token(inner_domain, DOMAIN_BUS_GENERIC_MSI);
+	inner_domain->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT;
+	inner_domain->msi_parent_ops = &odmi_msi_parent_ops;
 
 	return 0;
 
-err_remove_inner:
-	irq_domain_remove(inner_domain);
 err_unmap:
 	for (i = 0; i < odmis_count; i++) {
 		struct odmi_data *odmi = &odmis[i];


