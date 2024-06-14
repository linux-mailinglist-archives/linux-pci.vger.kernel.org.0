Return-Path: <linux-pci+bounces-8802-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 345379089BD
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 12:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A3151C21DBF
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 10:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00BC194AEF;
	Fri, 14 Jun 2024 10:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I0vVvW1z";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MPghu0fl"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58415194A72;
	Fri, 14 Jun 2024 10:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718360715; cv=none; b=cA1Xvqg/DYTbkZwOz3Rw3XFlWoD23mnhDKe+E2MLAlUQQ1K9yKF97tOSiecuiieT+R5ud53uw8BgjXt/UEgdM8KkrKlnsexHtVsHDKEa20hmUjkdb0eVW/M5/YFSzyAT2TPBAGUtwo7MPRplbuNDzSR3U14wuhihCFr/8Ym30tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718360715; c=relaxed/simple;
	bh=hY0utbfIpRN/l3RrXfmhGsph/FJ1Y3i4uMQXAeqn/ao=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UIpYpQ8mfjFAebK7cMjLtyfpmGXcmevAaqPprZdlWCcXqWxSkJRwzqT+KxmK2rP22fb3c2CDkvNfC1FXGQIu6ipXmMGm/3fMrrvFEIGmeVAmiPZ17BfVaTE9B6jkBtZlLMWIg6NG32bkdNaFKosePJKfKDujyRbPM9qZDddNY6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I0vVvW1z; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MPghu0fl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718360712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wTiXMNNyV27ASMB9DQVUDEhGnRLUe2rpf3Z+s7AmUcE=;
	b=I0vVvW1z5twKxpKQ2RvkE2aEgpSyewgwyOugl07WYmtIfkrZ+EU94M+3XA7ddYNm/r0CkK
	ZmMcuwGoamB91LKy9brccwM02IAOfTDBNPH5jArQtp2M117ay2UOMMSGDHjBYFhITEiVPv
	42uEjNpcIMbK0+GMofQPN9BcjD6VoqB4H+z8YMIxwGTyyeYvjVUZbO+E/hscDrE7v7mWew
	r86KikT2FGuhkz2qLRHNBwwycf1IJ2pXA1Zq835Hzk7O1WU//RgT6pH8Qjiz2SUNuy+plC
	NSPFdPSxoat3gsbAaZer0pAUcSPLnxZ3OydovhwKeACAVe7fiTRDXRQOp/ZnaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718360712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wTiXMNNyV27ASMB9DQVUDEhGnRLUe2rpf3Z+s7AmUcE=;
	b=MPghu0flFifR84K3M3RBxhS3QlUmVw2FloZtZ2d+N9gPGsxK6rp6uvlKjH7EHlB77eYPb/
	t+fYOkIkUbIArLAA==
To: linux-kernel@vger.kernel.org
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
Subject: [PATCH v3 03/24] PCI/MSI: Provide MSI_FLAG_PCI_MSI_MASK_PARENT
Date: Fri, 14 Jun 2024 12:23:42 +0200
Message-Id: <20240614102403.13610-4-shivamurthy.shastri@linutronix.de>
In-Reply-To: <20240614102403.13610-1-shivamurthy.shastri@linutronix.de>
References: <20240614102403.13610-1-shivamurthy.shastri@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Most ARM(64) PCI/MSI domains mask and unmask in the parent domain after or
before the PCI mask/unmask operation takes place. So there are more than a
dozen of the same wrapper implementation all over the place.

Don't make the same mistake with the new per device PCI/MSI domains and
provide a new MSI feature flag, which lets the domain implementation
enable this sequence in the PCI/MSI code.

Signed-off-by: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>
---
v3: new patch to replace the global static key - Marc Zyngier
---
 drivers/pci/msi/irqdomain.c | 21 +++++++++++++++++++++
 include/linux/msi.h         |  2 ++
 2 files changed, 23 insertions(+)

diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
index 03d2dd25790d..112c2ff3035c 100644
--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -148,17 +148,35 @@ static void pci_device_domain_set_desc(msi_alloc_info_t *arg, struct msi_desc *d
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
 
@@ -170,6 +188,7 @@ static void pci_irq_unmask_msi(struct irq_data *data)
 
 #define MSI_COMMON_FLAGS	(MSI_FLAG_FREE_MSI_DESCS |	\
 				 MSI_FLAG_ACTIVATE_EARLY |	\
+				 MSI_FLAG_PCI_MSI_MASK_PARENT |	\
 				 MSI_FLAG_DEV_SYSFS |		\
 				 MSI_REACTIVATE)
 
@@ -195,10 +214,12 @@ static const struct msi_domain_template pci_msi_template = {
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
 
diff --git a/include/linux/msi.h b/include/linux/msi.h
index dc27cf3903d5..04f33e7f6f8b 100644
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
-- 
2.34.1


