Return-Path: <linux-pci+bounces-9135-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FE9913C0F
	for <lists+linux-pci@lfdr.de>; Sun, 23 Jun 2024 17:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A8E81C20410
	for <lists+linux-pci@lfdr.de>; Sun, 23 Jun 2024 15:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1074181D1C;
	Sun, 23 Jun 2024 15:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CDNZhraU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z4LL5lNb"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699961DFD8;
	Sun, 23 Jun 2024 15:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719155916; cv=none; b=W/JWEB5jR/hdfKWsD0oeW7KzCePR7WkjJadm1zwhTPWURhMUe5FB9LdY35n3ZKPYggPhuCvDhRqjqeBH3bYC8fGWZJoE9MSzoG7kYg0Mzv9Ws7yIWYdYpG+1kN/I71hs4vASYIGKM1/esrp1CWcPaCoRgNqL1Ca0+4P+gOeiI6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719155916; c=relaxed/simple;
	bh=f8xGPFDKoVmXxxBKUIjdT+tAW23biHX7pA1jFBkoz48=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=qENQu0yyjSkTWwRfXBDEjW/TBt/dMdUOMrBOXjWGBQujogMzlUoAFZucntDdUMNJx3hBkZcwNlQRJhPWdYKrOZWV5/MYFsXs+yi8/fGQWczfn1YrXQPhQSzfH4XOL//LgQ6OMFJ6919IxI+weDwusM8qHO7Mnv9No7kxQM/by3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CDNZhraU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z4LL5lNb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240623142234.778182630@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719155913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=7zed2ApO1A0l+AMF7k5JuDHT0SeOqOmE9ZPbqJW1fRY=;
	b=CDNZhraUiKZ2vR3f7Q3xX4IJVwXt/9slLpZbzhmgYQnFq3j91deA8FSScuZhRSZQuPp1z1
	s6/kE+vpZ2R9R83G8b+MyyIjsqhKpbqORcFTlOVJTFn/95Q0ss/G0IlLydcXHf51hK0OIN
	PDapEYtioPIRkxEeez97HHdGwNwt3bnk/3qYnwcw7m9KPAQV8xx19hACRq9kJbaFD8RpCg
	RhaPur2REZs9cFgh8/vZncDhehwRC5pGBVn4yCLv4A66Sx7mNCL9WoR7wcTr2jPZtyQSOp
	ewnuT35xLulL7V8jzKncVH+VajfLDERB/s2/8Ptr14O4HrftJ3l3qKPy/XDPkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719155913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=7zed2ApO1A0l+AMF7k5JuDHT0SeOqOmE9ZPbqJW1fRY=;
	b=z4LL5lNb0HXIkrOSnlYAinh6zEvBKupTRlF9STu8aswDBVFw6tEc4hlUy/H4NtCofvDrQ8
	PsFQdeTITEykr5Dg==
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
Subject: [patch V4 01/21] PCI/MSI: Provide MSI_FLAG_PCI_MSI_MASK_PARENT
References: <20240623142137.448898081@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Sun, 23 Jun 2024 17:18:32 +0200 (CEST)

From: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>

Most ARM(64) PCI/MSI domains mask and unmask in the parent domain after or
before the PCI mask/unmask operation takes place. So there are more than a
dozen of the same wrapper implementation all over the place.

Don't make the same mistake with the new per device PCI/MSI domains and
provide a new MSI feature flag, which lets the domain implementation
enable this sequence in the PCI/MSI code.

Signed-off-by: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
v3: new patch to replace the global static key - Marc Zyngier
---
 drivers/pci/msi/irqdomain.c |   21 +++++++++++++++++++++
 include/linux/msi.h         |    2 ++
 2 files changed, 23 insertions(+)

--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -148,17 +148,35 @@ static void pci_device_domain_set_desc(m
 	arg->hwirq = desc->msi_index;
 }
 
+static __always_inline void cond_mask_parent(struct irq_data *data)
+{
+	struct msi_domain_info *info = data->domain->host_data;
+
+	if (unlikely(info->flags & MSI_FLAG_PCI_MSI_MASK_PARENT))
+		irq_chip_mask_parent(data);
+}
+
+static __always_inline void cond_unmask_parent(struct irq_data *data)
+{
+	struct msi_domain_info *info = data->domain->host_data;
+
+	if (unlikely(info->flags & MSI_FLAG_PCI_MSI_MASK_PARENT))
+		irq_chip_unmask_parent(data);
+}
+
 static void pci_irq_mask_msi(struct irq_data *data)
 {
 	struct msi_desc *desc = irq_data_get_msi_desc(data);
 
 	pci_msi_mask(desc, BIT(data->irq - desc->irq));
+	cond_mask_parent(data);
 }
 
 static void pci_irq_unmask_msi(struct irq_data *data)
 {
 	struct msi_desc *desc = irq_data_get_msi_desc(data);
 
+	cond_unmask_parent(data);
 	pci_msi_unmask(desc, BIT(data->irq - desc->irq));
 }
 
@@ -170,6 +188,7 @@ static void pci_irq_unmask_msi(struct ir
 
 #define MSI_COMMON_FLAGS	(MSI_FLAG_FREE_MSI_DESCS |	\
 				 MSI_FLAG_ACTIVATE_EARLY |	\
+				 MSI_FLAG_PCI_MSI_MASK_PARENT |	\
 				 MSI_FLAG_DEV_SYSFS |		\
 				 MSI_REACTIVATE)
 
@@ -195,10 +214,12 @@ static const struct msi_domain_template
 static void pci_irq_mask_msix(struct irq_data *data)
 {
 	pci_msix_mask(irq_data_get_msi_desc(data));
+	cond_mask_parent(data);
 }
 
 static void pci_irq_unmask_msix(struct irq_data *data)
 {
+	cond_unmask_parent(data);
 	pci_msix_unmask(irq_data_get_msi_desc(data));
 }
 
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -556,6 +556,8 @@ enum {
 	MSI_FLAG_USE_DEV_FWNODE		= (1 << 7),
 	/* Set parent->dev into domain->pm_dev on device domain creation */
 	MSI_FLAG_PARENT_PM_DEV		= (1 << 8),
+	/* Support for parent mask/unmask */
+	MSI_FLAG_PCI_MSI_MASK_PARENT	= (1 << 9),
 
 	/* Mask for the generic functionality */
 	MSI_GENERIC_FLAGS_MASK		= GENMASK(15, 0),


