Return-Path: <linux-pci+bounces-9451-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 995F391CEE4
	for <lists+linux-pci@lfdr.de>; Sat, 29 Jun 2024 21:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9942C1C20C29
	for <lists+linux-pci@lfdr.de>; Sat, 29 Jun 2024 19:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22839132118;
	Sat, 29 Jun 2024 19:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z0oc6H7e";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jJQh9BTG"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FA13C36;
	Sat, 29 Jun 2024 19:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719690673; cv=none; b=QA3BkPf/XQT23KTU3RdtxsviVWTZBOa9YzG5kDUgWbMSFwRrmy8zwU5LMTgTD9iLb8EUYkQa/sDHfvE6k3L0f70Xff4zTW7gxTH9cVb6o0QNK+zArsm7Rw01iKAeLwYE+mwIX4Ux43TQRK1YqoBsiGb4EGPF8zkPmpNEhaFx99Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719690673; c=relaxed/simple;
	bh=QoaRwZusgOzBQ0m/2C0fMMC3NN4ucy2xdBqxSUrjGoc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TJIqWH0QGxb9lY9zIvklG8G/Y7Ph3B1MgJwVBgua0fmsxvhlCVLOAoidIA/85Wk29JiixTPjgfdyADri57rA56Ee38OUUYRVCfGLFEwm03aC7doB3qILVoisCT+Vcttfv14Pa8rrhtxNyYj47Qrt6JH8komeDxq+KXkBmCIzbjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z0oc6H7e; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jJQh9BTG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719690669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gYd76jymSW3+iML9PqsgM4zxAkj+V/7ihGaZ9scpYZA=;
	b=z0oc6H7eRIiBSqs++Rt4PP/T8Pb+E+d0AuLLqn4DI++p+ozgnP+ZOu6zk+FJswuMPeVdJK
	iEX6NoXfirX1cf6NDqCGINI/p14m+YI9VdJxM9XlmqpWu2OABCv4h+rThI7jf3SpQEGpxl
	r4ixlv8UJTxPZK7M6fbiKeGvbSQa+sMrPmPwHdqSHvVDz4TZ5zTQQftMHihrNTE9oo7qxY
	glJH2E8tGkOuW/MBLe3dOXp43IJ8CjaZR/3TI+v1/e6jfHPlkaobb7cn+EriwXZX+koo5t
	AHoXBapI9ZwNTrbALyoRUeno6FM/DFafITqSA3oBI98XfsQRapuCZTHZwHLJLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719690669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gYd76jymSW3+iML9PqsgM4zxAkj+V/7ihGaZ9scpYZA=;
	b=jJQh9BTG+NaCoSBih9r1ffGUc7/f5KNN2ukIj1UiYVUHmHeH7FVx0ne5s1vs89Fa1qS476
	tqwCDel3GJTPZrBA==
To: Marc Zyngier <maz@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, LKML
 <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-pci@vger.kernel.org, anna-maria@linutronix.de, shawnguo@kernel.org,
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
 shivamurthy.shastri@linutronix.de, Rob Herring <robh@kernel.org>
Subject: Re: [patch V4 05/21] irqchip/gic-v3-its: Provide MSI parent for
 PCI/MSI[-X]
In-Reply-To: <87ed8gxc2u.ffs@tglx>
References: <20240623142137.448898081@linutronix.de>
 <20240623142235.024567623@linutronix.de> <Zn84OIS0zLWASKr2@arm.com>
 <87h6dcxhy0.ffs@tglx> <86ed8ghypg.wl-maz@kernel.org>
 <86cyo0hyc6.wl-maz@kernel.org> <86bk3khxdt.wl-maz@kernel.org>
 <87ed8gxc2u.ffs@tglx>
Date: Sat, 29 Jun 2024 21:51:08 +0200
Message-ID: <87a5j3y1cj.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Jun 29 2024 at 12:44, Thomas Gleixner wrote:
>> With this hack, I can boot a GICv3+ITS guest as usual.
>
> It's not a hack. It's the proper solution. Let me fold that back and
> look at the other PCI conversions which probably have the same issue.
>
> Thanks for digging into this. This help is truly welcome right now.

So while I pondered to do it slightly differently for a moment I went
back to this approach and fixed up the other affected ones too. Full
delta vs. devmsi-arm-v4-1 below.

Updated branch:

   git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git devmsi-arm-v4-2

Thanks,

	tglx
---
diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index 428132aa26cc..51af63c046ed 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -243,13 +243,14 @@ static void __init gicv2m_teardown(void)
 	}
 }
 
-#define GICV2M_MSI_FLAGS_REQUIRED  (MSI_FLAG_USE_DEF_DOM_OPS |	\
-				    MSI_FLAG_USE_DEF_CHIP_OPS)
+
+#define GICV2M_MSI_FLAGS_REQUIRED  (MSI_FLAG_USE_DEF_DOM_OPS |		\
+				    MSI_FLAG_USE_DEF_CHIP_OPS |		\
+				    MSI_FLAG_PCI_MSI_MASK_PARENT)
 
 #define GICV2M_MSI_FLAGS_SUPPORTED (MSI_GENERIC_FLAGS_MASK |	\
 				    MSI_FLAG_PCI_MSIX      |	\
-				    MSI_FLAG_MULTI_PCI_MSI |	\
-				    MSI_FLAG_PCI_MSI_MASK_PARENT)
+				    MSI_FLAG_MULTI_PCI_MSI)
 
 static struct msi_parent_ops gicv2m_msi_parent_ops = {
 	.supported_flags	= GICV2M_MSI_FLAGS_SUPPORTED,
diff --git a/drivers/irqchip/irq-gic-v3-its-msi-parent.c b/drivers/irqchip/irq-gic-v3-its-msi-parent.c
index 21daa452ffa6..780e1bc9df54 100644
--- a/drivers/irqchip/irq-gic-v3-its-msi-parent.c
+++ b/drivers/irqchip/irq-gic-v3-its-msi-parent.c
@@ -11,12 +11,12 @@
 #include "irq-msi-lib.h"
 
 #define ITS_MSI_FLAGS_REQUIRED  (MSI_FLAG_USE_DEF_DOM_OPS |	\
-				 MSI_FLAG_USE_DEF_CHIP_OPS)
+				 MSI_FLAG_USE_DEF_CHIP_OPS |	\
+				 MSI_FLAG_PCI_MSI_MASK_PARENT)
 
 #define ITS_MSI_FLAGS_SUPPORTED (MSI_GENERIC_FLAGS_MASK |	\
 				 MSI_FLAG_PCI_MSIX      |	\
-				 MSI_FLAG_MULTI_PCI_MSI |	\
-				 MSI_FLAG_PCI_MSI_MASK_PARENT)
+				 MSI_FLAG_MULTI_PCI_MSI)
 
 #ifdef CONFIG_PCI_MSI
 static int its_pci_msi_vec_count(struct pci_dev *pdev, void *data)
diff --git a/drivers/irqchip/irq-gic-v3-mbi.c b/drivers/irqchip/irq-gic-v3-mbi.c
index 0aad9699be33..3fe870f8ee17 100644
--- a/drivers/irqchip/irq-gic-v3-mbi.c
+++ b/drivers/irqchip/irq-gic-v3-mbi.c
@@ -191,12 +191,12 @@ static bool mbi_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
 }
 
 #define MBI_MSI_FLAGS_REQUIRED  (MSI_FLAG_USE_DEF_DOM_OPS |	\
-				 MSI_FLAG_USE_DEF_CHIP_OPS)
+				 MSI_FLAG_USE_DEF_CHIP_OPS |	\
+				 MSI_FLAG_PCI_MSI_MASK_PARENT)
 
 #define MBI_MSI_FLAGS_SUPPORTED (MSI_GENERIC_FLAGS_MASK |	\
 				 MSI_FLAG_PCI_MSIX      |	\
-				 MSI_FLAG_MULTI_PCI_MSI |	\
-				 MSI_FLAG_PCI_MSI_MASK_PARENT)
+				 MSI_FLAG_MULTI_PCI_MSI)
 
 static const struct msi_parent_ops gic_v3_mbi_msi_parent_ops = {
 	.supported_flags	= MBI_MSI_FLAGS_SUPPORTED,
diff --git a/drivers/irqchip/irq-msi-lib.c b/drivers/irqchip/irq-msi-lib.c
index 15f92ce4d1e8..e93917b98d7d 100644
--- a/drivers/irqchip/irq-msi-lib.c
+++ b/drivers/irqchip/irq-msi-lib.c
@@ -28,6 +28,7 @@ bool msi_lib_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
 			       struct msi_domain_info *info)
 {
 	const struct msi_parent_ops *pops = real_parent->msi_parent_ops;
+	u32 required_flags = pops->required_flags;
 
 	/*
 	 * MSI parent domain specific settings. For now there is only the
@@ -66,8 +67,10 @@ bool msi_lib_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
 
 		/* Core managed MSI descriptors */
 		info->flags = MSI_FLAG_ALLOC_SIMPLE_MSI_DESCS | MSI_FLAG_FREE_MSI_DESCS;
-		break;
+		fallthrough;
 	case DOMAIN_BUS_WIRED_TO_MSI:
+		/* Remove PCI specific flags */
+		required_flags &= ~MSI_FLAG_PCI_MSI_MASK_PARENT;
 		break;
 	default:
 		/*
@@ -84,7 +87,7 @@ bool msi_lib_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
 	 */
 	info->flags			&= pops->supported_flags;
 	/* Enforce the required flags */
-	info->flags			|= pops->required_flags;
+	info->flags			|= required_flags;
 
 	/* Chip updates for all child bus types */
 	if (!info->chip->irq_eoi)

