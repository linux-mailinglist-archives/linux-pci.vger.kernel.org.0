Return-Path: <linux-pci+bounces-9338-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B5991954F
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 21:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 945A6B23CB2
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 19:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FCBC17D365;
	Wed, 26 Jun 2024 19:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0Wux6xPA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bWSUS9H8"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BD21509B8;
	Wed, 26 Jun 2024 19:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719428716; cv=none; b=Jbmspg+2uL097ZUfxpvaUedoVIt18lJdQLUrlQfNQCwjF6fmBlZ/zSRpeBTXBiitIAD3XWiODA0AeJ3SrsD+ES3cVC3R8u3HzDclBCC6A1JHXZiA3u83LRrQwMUU08GnUnfNWyawAoVJHSLZSY3gMEREQOmp+A15eyeTlJ50Gbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719428716; c=relaxed/simple;
	bh=iEky2eVs/O3glvmfOmDCeeC/kYZsH9u9lidZrYV2hRs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=swqQwvwb4JA8hSPEoNIPRl8qKbNIWNU2Ys8t6x8ubq2NFSGM5o2KbNoSy2KifnHrwnCAA1mqW3Kv9dOqlcfAUbxy25V7G3ynGidgV8JDnGhJsiSf6X/OTh4op5zE83ScCCOxZWFL5Wh431PIP3RpsTpIrBzJpp3azL916udMjvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0Wux6xPA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bWSUS9H8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719428713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EoN4fj2HCZ+g0Mng6LNWulvp3O8suPrcrYKI0Bnjr5Y=;
	b=0Wux6xPAFVgp7+gpVoEV8EIVMylNp1e/HDRVtFWKeyZZ1iin6uwo70xKF5Njh/koKi2T06
	GcjuP4tDa6nmJkaLKHy07rfKmQYIiLJrhdH4uSz2WH10rXQdq8TiIRX7M7ntjPdDmuwvEx
	nmfllDzP0INE9phqmqDtzS2Qflq7Rfma6ejDGzM6CtcUQ/uHi4fl768/tG14ELxchFlbeR
	WSE4b7z4zwcMIB+rDX1PFZIZBNAySXrhpwG+RQ8M0wDieBnZSF7S0h0jo+e4L8w0D+47ws
	0zroKJ6A2G4iRbKJgKptNuGtIsWefoZDV1JMoYIFq6ignSFpodBbKSBg0Tn5Pg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719428713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EoN4fj2HCZ+g0Mng6LNWulvp3O8suPrcrYKI0Bnjr5Y=;
	b=bWSUS9H8o0a07mxYPBKc/FjUD9MH5DYeGUJulQv2c3b+enEWz6WaNl6SjMwrResG6vl8Yf
	NY9Q5wStjlTqSfDQ==
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 maz@kernel.org, anna-maria@linutronix.de, shawnguo@kernel.org,
 s.hauer@pengutronix.de, festevam@gmail.com, bhelgaas@google.com,
 rdunlap@infradead.org, vidyas@nvidia.com, ilpo.jarvinen@linux.intel.com,
 apatel@ventanamicro.com, kevin.tian@intel.com, nipun.gupta@amd.com,
 den@valinux.co.jp, andrew@lunn.ch, gregory.clement@bootlin.com,
 sebastian.hesselbarth@gmail.com, gregkh@linuxfoundation.org,
 rafael@kernel.org, alex.williamson@redhat.com, will@kernel.org,
 lorenzo.pieralisi@arm.com, jgg@mellanox.com, ammarfaizi2@gnuweeb.org,
 robin.murphy@arm.com, lpieralisi@kernel.org, nm@ti.com, kristo@kernel.org,
 vkoul@kernel.org, okaya@kernel.org, agross@kernel.org,
 andersson@kernel.org, mark.rutland@arm.com,
 shameerali.kolothum.thodi@huawei.com, yuzenghui@huawei.com,
 shivamurthy.shastri@linutronix.de
Subject: [patch V4-1 01/21] PCI/MSI: Provide MSI_FLAG_PCI_MSI_MASK_PARENT
In-Reply-To: <20240623142234.778182630@linutronix.de>
References: <20240623142137.448898081@linutronix.de>
 <20240623142234.778182630@linutronix.de>
Date: Wed, 26 Jun 2024 21:05:12 +0200
Message-ID: <87ed8j34pj.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

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
v4-1: Remove MSI_FLAG_PCI_MSI_MASK_PARENT from the defaults - Rob
v3: new patch to replace the global static key - Marc Zyngier
---
 drivers/pci/msi/irqdomain.c |   20 ++++++++++++++++++++
 include/linux/msi.h         |    2 ++
 2 files changed, 22 insertions(+)

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
 
@@ -195,10 +213,12 @@ static const struct msi_domain_template
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

