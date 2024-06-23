Return-Path: <linux-pci+bounces-9148-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B35913C2A
	for <lists+linux-pci@lfdr.de>; Sun, 23 Jun 2024 17:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 674C4285E6C
	for <lists+linux-pci@lfdr.de>; Sun, 23 Jun 2024 15:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DCF0186E57;
	Sun, 23 Jun 2024 15:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qp5upnBZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YeEWya1K"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E721862A8;
	Sun, 23 Jun 2024 15:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719155938; cv=none; b=OnSIFoNLLinvE7kOnJVWIC44/Iv8HRsEx0LhzD1TtovyXG9rUu1xhuBGdiW/2d6C/gYJKLGx7djJWx/qKw6b9KQRbpRzVpFos5xVbkOrPBVOIC8d2+GyXQv9g9s2mMq37ECtliOv+iSi3Myq1S2Ut9BK0BWYw6BB26iLeGftwik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719155938; c=relaxed/simple;
	bh=ofpQ4ZFT0LuyPsr7f1Fo7b2LMIcyd59HGFEuWqF/WwY=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=goNXd8R8ny/i7q+01fWu/OUoMloGB3T+rrzW4P1NfkmQscUzbdxYNmVokQBUvyL1Kr1lkygix61pzPTGZfXaXn7SCjCUqR/GhozDTPiHJ5RsGgL84K1CpvpxdUJZDXrsD09wfJJ5iHi8dLeVIRz4UKcAnikRZ+wJ3PCZhv+JngE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qp5upnBZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YeEWya1K; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240623142235.574932935@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719155935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=xmjvOHOYTgqqA8IGPC6dGdyVEF+BEZiptiYdpVIpqZo=;
	b=qp5upnBZ+1NyWs0CvwwCQrncLiBS8I6KTxE67kiH5Nv5eXp+ed7OW+wPcarCMqZCD+n1Tn
	iuVceQsXYCZUWDcCI8TUjcHM0IKFaQjDCSXiqjwxw7ShSL7FPeEy7lnr6LgoAoKKvypvzt
	2Qh21MURYpsA3KtX6Ur1fzBtxQVFj3geo+enAlnAkxYp7s/s8CDE3MzwRVAgBMF1sM6uKQ
	eK0DHvM9lKpmY1AGckCLV/QA7c1NIk73G01ibgFJsw/RLlQGjPp7fpYOssPsUPH5x0C6B2
	XSiMjRq/A7TYxrV5QG6xr/ET744bL/NU8bmyWzBhdAzwbn9rw0yVyG0Y+wTktw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719155935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=xmjvOHOYTgqqA8IGPC6dGdyVEF+BEZiptiYdpVIpqZo=;
	b=YeEWya1KcwBS4zD/3+n3R//OLaeRvAQB9LFZb4QIocoHlRBptQiYET/Ptbotl6nf80+FSP
	Y+H+hqZYpWmTX3Aw==
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
Subject: [patch V4 14/21] irqchip/imx-mu-msi: Switch to MSI parent
References: <20240623142137.448898081@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Sun, 23 Jun 2024 17:18:55 +0200 (CEST)

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
 drivers/irqchip/Kconfig          |    1 
 drivers/irqchip/irq-imx-mu-msi.c |   48 +++++++++++++++++----------------------
 drivers/irqchip/irq-msi-lib.c    |    2 +
 3 files changed, 24 insertions(+), 27 deletions(-)

--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -492,6 +492,7 @@ config IMX_MU_MSI
 	select IRQ_DOMAIN
 	select IRQ_DOMAIN_HIERARCHY
 	select GENERIC_MSI_IRQ
+	select IRQ_MSI_LIB
 	help
 	  Provide a driver for the i.MX Messaging Unit block used as a
 	  CPU-to-CPU MSI controller. This requires a specially crafted DT
--- a/drivers/irqchip/irq-imx-mu-msi.c
+++ b/drivers/irqchip/irq-imx-mu-msi.c
@@ -24,6 +24,8 @@
 #include <linux/pm_domain.h>
 #include <linux/spinlock.h>
 
+#include "irq-msi-lib.h"
+
 #define IMX_MU_CHANS            4
 
 enum imx_mu_xcr {
@@ -114,20 +116,6 @@ static void imx_mu_msi_parent_ack_irq(st
 	imx_mu_read(msi_data, msi_data->cfg->xRR + data->hwirq * 4);
 }
 
-static struct irq_chip imx_mu_msi_irq_chip = {
-	.name = "MU-MSI",
-	.irq_ack = irq_chip_ack_parent,
-};
-
-static struct msi_domain_ops imx_mu_msi_irq_ops = {
-};
-
-static struct msi_domain_info imx_mu_msi_domain_info = {
-	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS),
-	.ops	= &imx_mu_msi_irq_ops,
-	.chip	= &imx_mu_msi_irq_chip,
-};
-
 static void imx_mu_msi_parent_compose_msg(struct irq_data *data,
 					  struct msi_msg *msg)
 {
@@ -195,6 +183,7 @@ static void imx_mu_msi_domain_irq_free(s
 }
 
 static const struct irq_domain_ops imx_mu_msi_domain_ops = {
+	.select	= msi_lib_irq_domain_select,
 	.alloc	= imx_mu_msi_domain_irq_alloc,
 	.free	= imx_mu_msi_domain_irq_free,
 };
@@ -216,6 +205,21 @@ static void imx_mu_msi_irq_handler(struc
 	chained_irq_exit(chip, desc);
 }
 
+#define IMX_MU_MSI_FLAGS_REQUIRED	(MSI_FLAG_USE_DEF_DOM_OPS |	\
+					 MSI_FLAG_USE_DEF_CHIP_OPS |	\
+					 MSI_FLAG_PARENT_PM_DEV)
+
+#define IMX_MU_MSI_FLAGS_SUPPORTED	(MSI_GENERIC_FLAGS_MASK)
+
+static const struct msi_parent_ops imx_mu_msi_parent_ops = {
+	.supported_flags	= IMX_MU_MSI_FLAGS_SUPPORTED,
+	.required_flags		= IMX_MU_MSI_FLAGS_REQUIRED,
+	.bus_select_token       = DOMAIN_BUS_NEXUS,
+	.bus_select_mask	= MATCH_PLATFORM_MSI,
+	.prefix			= "MU-MSI-",
+	.init_dev_msi_info	= msi_lib_init_dev_msi_info,
+};
+
 static int imx_mu_msi_domains_init(struct imx_mu_msi *msi_data, struct device *dev)
 {
 	struct fwnode_handle *fwnodes = dev_fwnode(dev);
@@ -230,19 +234,9 @@ static int imx_mu_msi_domains_init(struc
 	}
 
 	irq_domain_update_bus_token(parent, DOMAIN_BUS_NEXUS);
-
-	msi_data->msi_domain = platform_msi_create_irq_domain(fwnodes,
-					&imx_mu_msi_domain_info,
-					parent);
-
-	if (!msi_data->msi_domain) {
-		dev_err(dev, "failed to create MSI domain\n");
-		irq_domain_remove(parent);
-		return -ENOMEM;
-	}
-
-	irq_domain_set_pm_device(msi_data->msi_domain, dev);
-
+	parent->dev = parent->pm_dev = dev;
+	parent->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT;
+	parent->msi_parent_ops = &imx_mu_msi_parent_ops;
 	return 0;
 }
 
--- a/drivers/irqchip/irq-msi-lib.c
+++ b/drivers/irqchip/irq-msi-lib.c
@@ -89,6 +89,8 @@ bool msi_lib_init_dev_msi_info(struct de
 	/* Chip updates for all child bus types */
 	if (!info->chip->irq_eoi)
 		info->chip->irq_eoi	= irq_chip_eoi_parent;
+	if (!info->chip->irq_ack)
+		info->chip->irq_ack	= irq_chip_ack_parent;
 
 	/*
 	 * The device MSI domain can never have a set affinity callback. It


