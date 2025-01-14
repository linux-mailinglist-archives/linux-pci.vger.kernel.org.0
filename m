Return-Path: <linux-pci+bounces-19717-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F028A1044B
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 11:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99C5C1885EAC
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 10:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C3628EC91;
	Tue, 14 Jan 2025 10:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="FjixIOWB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B24728EC61
	for <linux-pci@vger.kernel.org>; Tue, 14 Jan 2025 10:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736850895; cv=none; b=FD3k3fIEzLrPEY8EltiqUa1AUcZh6+avstzS0iyjGR4nDjeufFBvIxsbQIOHa2QWGmXftEj4bDKY3rGOjvv+AbXQhFHBPoPsza8bukBwmhvhVYGjuoAbQz3BbjXwtTD08Q6I2T2AZLvoL842fYu8rOJ4O0uM8GQx0y/WM67u9Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736850895; c=relaxed/simple;
	bh=N6aNZrKltH7utHvV505q19D+W+brmirqcznbxR/KWtk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TzyIKAesISNPRwcYeMRCae4Bj9N7iPuiQxJqyerNntUzvTEQWWLhQGWWQvVOjo163M5CkJbYoUOpNNy3TiTcjDPvZW8teAsO8PKtDT8i4+FOjBEeQ3ItnC7hvdpr1lqmEn5ce6u0LjbpOxuMOae/DanDxG0KkZuS8pICaPdnMbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=FjixIOWB; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aaeecbb7309so998572566b.0
        for <linux-pci@vger.kernel.org>; Tue, 14 Jan 2025 02:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1736850892; x=1737455692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pp4xDXQjDMI49K9qEvJ9bqARGwd0TmK51XhdPXSIbuI=;
        b=FjixIOWBlvKqNGQBV68ZaYJ51MGB+TI8MErhyWqodU4rNzeHva/xavcnw+NM8LvnU9
         YJKub31pXNqaipZbkpMD4ybz+H1WibP7UCIIgQJBOFi82AKap/6OapFmKdatoswgzwaF
         p49ySYhbWxXp61pD3JwwJltmMWEN//4g4aAeo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736850892; x=1737455692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pp4xDXQjDMI49K9qEvJ9bqARGwd0TmK51XhdPXSIbuI=;
        b=R4MWvVwuRisOiq9qXJky+J+k4H0xyWVjAf4P4doygxpLlOuWa+m9QbO+pnN6z8LjQh
         MT2cAKg+plw6OLS7/qVjZ+k1nD3jOmm6HVEycKBCurnE5zX3hWafQ7IGbziZlSZZb7QQ
         MU0U8clnzDybTmwVkj4CfqCbD/KeooUvOwnd+YB7Y/aeY3egHGqJzQH5LC6rew8tRgCn
         pkKP39OZWzh+AiYg7hGid5XPuY6GE1BtVUh7iV4zx/Nlbn92IE9yySGV+cTmzCEIy8NR
         MUWLKVE9zcqY5v5pTsBLXkdZVUpI8uhJGFH5w/gV3hTBLHy4XUHNjuV+PJ7cCVq8TQ02
         j5nA==
X-Forwarded-Encrypted: i=1; AJvYcCXtL9t8kS91ExwMga6/vJKX/1qOfLIsgZH6TojEOIyXjEooJKexaAr4J5LXlJEE5OTcYiEUi0j462E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy35mZocZ9xggEzKCXHV93gd1TB7JPD5k/ullegC2BgWQzPkUQE
	dTrmFCy6aNITDcXlkV2+baxsnhnfjGzeLVsMzFsLpGdldr8mZRb5P8ts+d84KRE=
X-Gm-Gg: ASbGncuBExTEBho5Iz/czVRZqOKzsL3XUHgBtTHzIx/OTX2FaB1WoFzGR46PGmASEdk
	IMDCbePP1P1LFjXj3wjWrfnXUmDBc2AIS3Umn10T+JthgcuejCPWJVujR9EOMH9JTirWNpFKQSL
	aT7IrExK0+8/wCiy18hPKh/ZKr/GCXFfMJFay1WRdP6Ylyp7ocvBjhZOQtnWkOYjVUsEoHfTSHX
	J4rQE52imKIQFp0OSU51KrF2bamJoboYEaBDbJVVOMpcZ2qFnml0l5YzM5JQkL+FWY=
X-Google-Smtp-Source: AGHT+IGXqQ3VAh46MQysKbOAR+DLjCoKyT5Dy9LF7Cz4wRYLy+8kN1pTiCGZzrg1gwpYg14rVYHFOQ==
X-Received: by 2002:a17:907:1c98:b0:ab3:3b81:876f with SMTP id a640c23a62f3a-ab33b818a59mr177651466b.4.1736850891725;
        Tue, 14 Jan 2025 02:34:51 -0800 (PST)
Received: from localhost ([84.78.159.3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c96475besm608318466b.180.2025.01.14.02.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 02:34:50 -0800 (PST)
From: Roger Pau Monne <roger.pau@citrix.com>
To: linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	linux-pci@vger.kernel.org
Cc: Roger Pau Monne <roger.pau@citrix.com>,
	Juergen Gross <jgross@suse.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v2 3/3] pci/msi: remove pci_msi_ignore_mask
Date: Tue, 14 Jan 2025 11:33:13 +0100
Message-ID: <20250114103315.51328-4-roger.pau@citrix.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250114103315.51328-1-roger.pau@citrix.com>
References: <20250114103315.51328-1-roger.pau@citrix.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Setting pci_msi_ignore_mask inhibits the toggling of the mask bit for both
MSI and MSI-X entries globally, regardless of the IRQ chip they are using.
Only Xen sets the pci_msi_ignore_mask when routing physical interrupts over
event channels, to prevent PCI code from attempting to toggle the maskbit,
as it's Xen that controls the bit.

However, the pci_msi_ignore_mask being global will affect devices that use
MSI interrupts but are not routing those interrupts over event channels
(not using the Xen pIRQ chip).  One example is devices behind a VMD PCI
bridge.  In that scenario the VMD bridge configures MSI(-X) using the
normal IRQ chip (the pIRQ one in the Xen case), and devices behind the
bridge configure the MSI entries using indexes into the VMD bridge MSI
table.  The VMD bridge then demultiplexes such interrupts and delivers to
the destination device(s).  Having pci_msi_ignore_mask set in that scenario
prevents (un)masking of MSI entries for devices behind the VMD bridge.

Move the signaling of no entry masking into the MSI domain flags, as that
allows setting it on a per-domain basis.  Set it for the Xen MSI domain
that uses the pIRQ chip, while leaving it unset for the rest of the
cases.

Remove pci_msi_ignore_mask at once, since it was only used by Xen code, and
with Xen dropping usage the variable is unneeded.

This fixes using devices behind a VMD bridge on Xen PV hardware domains.

Albeit Devices behind a VMD bridge are not known to Xen, that doesn't mean
Linux cannot use them.  By inhibiting the usage of
VMD_FEAT_CAN_BYPASS_MSI_REMAP and the removal of the pci_msi_ignore_mask
bodge devices behind a VMD bridge do work fine when use from a Linux Xen
hardware domain.  That's the whole point of the series.

Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
---
Changes since v1:
 - Fix build.
 - Expand commit message.
---
 arch/x86/pci/xen.c    |  8 ++------
 drivers/pci/msi/msi.c | 37 +++++++++++++++++++++----------------
 include/linux/msi.h   |  3 ++-
 kernel/irq/msi.c      |  2 +-
 4 files changed, 26 insertions(+), 24 deletions(-)

diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
index 0f2fe524f60d..b8755cde2419 100644
--- a/arch/x86/pci/xen.c
+++ b/arch/x86/pci/xen.c
@@ -436,7 +436,8 @@ static struct msi_domain_ops xen_pci_msi_domain_ops = {
 };
 
 static struct msi_domain_info xen_pci_msi_domain_info = {
-	.flags			= MSI_FLAG_PCI_MSIX | MSI_FLAG_FREE_MSI_DESCS | MSI_FLAG_DEV_SYSFS,
+	.flags			= MSI_FLAG_PCI_MSIX | MSI_FLAG_FREE_MSI_DESCS |
+				  MSI_FLAG_DEV_SYSFS | MSI_FLAG_NO_MASK,
 	.ops			= &xen_pci_msi_domain_ops,
 };
 
@@ -484,11 +485,6 @@ static __init void xen_setup_pci_msi(void)
 	 * in allocating the native domain and never use it.
 	 */
 	x86_init.irqs.create_pci_msi_domain = xen_create_pci_msi_domain;
-	/*
-	 * With XEN PIRQ/Eventchannels in use PCI/MSI[-X] masking is solely
-	 * controlled by the hypervisor.
-	 */
-	pci_msi_ignore_mask = 1;
 }
 
 #else /* CONFIG_PCI_MSI */
diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index 3a45879d85db..dcbb4f9ac578 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -10,12 +10,12 @@
 #include <linux/err.h>
 #include <linux/export.h>
 #include <linux/irq.h>
+#include <linux/irqdomain.h>
 
 #include "../pci.h"
 #include "msi.h"
 
 int pci_msi_enable = 1;
-int pci_msi_ignore_mask;
 
 /**
  * pci_msi_supported - check whether MSI may be enabled on a device
@@ -285,6 +285,8 @@ static void pci_msi_set_enable(struct pci_dev *dev, int enable)
 static int msi_setup_msi_desc(struct pci_dev *dev, int nvec,
 			      struct irq_affinity_desc *masks)
 {
+	const struct irq_domain *d = dev_get_msi_domain(&dev->dev);
+	const struct msi_domain_info *info = d->host_data;
 	struct msi_desc desc;
 	u16 control;
 
@@ -295,8 +297,7 @@ static int msi_setup_msi_desc(struct pci_dev *dev, int nvec,
 	/* Lies, damned lies, and MSIs */
 	if (dev->dev_flags & PCI_DEV_FLAGS_HAS_MSI_MASKING)
 		control |= PCI_MSI_FLAGS_MASKBIT;
-	/* Respect XEN's mask disabling */
-	if (pci_msi_ignore_mask)
+	if (info->flags & MSI_FLAG_NO_MASK)
 		control &= ~PCI_MSI_FLAGS_MASKBIT;
 
 	desc.nvec_used			= nvec;
@@ -600,12 +601,15 @@ static void __iomem *msix_map_region(struct pci_dev *dev,
  */
 void msix_prepare_msi_desc(struct pci_dev *dev, struct msi_desc *desc)
 {
+	const struct irq_domain *d = dev_get_msi_domain(&dev->dev);
+	const struct msi_domain_info *info = d->host_data;
+
 	desc->nvec_used				= 1;
 	desc->pci.msi_attrib.is_msix		= 1;
 	desc->pci.msi_attrib.is_64		= 1;
 	desc->pci.msi_attrib.default_irq	= dev->irq;
 	desc->pci.mask_base			= dev->msix_base;
-	desc->pci.msi_attrib.can_mask		= !pci_msi_ignore_mask &&
+	desc->pci.msi_attrib.can_mask		= !(info->flags & MSI_FLAG_NO_MASK) &&
 						  !desc->pci.msi_attrib.is_virtual;
 
 	if (desc->pci.msi_attrib.can_mask) {
@@ -655,9 +659,6 @@ static void msix_mask_all(void __iomem *base, int tsize)
 	u32 ctrl = PCI_MSIX_ENTRY_CTRL_MASKBIT;
 	int i;
 
-	if (pci_msi_ignore_mask)
-		return;
-
 	for (i = 0; i < tsize; i++, base += PCI_MSIX_ENTRY_SIZE)
 		writel(ctrl, base + PCI_MSIX_ENTRY_VECTOR_CTRL);
 }
@@ -710,6 +711,8 @@ static int msix_setup_interrupts(struct pci_dev *dev, struct msix_entry *entries
 static int msix_capability_init(struct pci_dev *dev, struct msix_entry *entries,
 				int nvec, struct irq_affinity *affd)
 {
+	const struct irq_domain *d = dev_get_msi_domain(&dev->dev);
+	const struct msi_domain_info *info = d->host_data;
 	int ret, tsize;
 	u16 control;
 
@@ -740,15 +743,17 @@ static int msix_capability_init(struct pci_dev *dev, struct msix_entry *entries,
 	/* Disable INTX */
 	pci_intx_for_msi(dev, 0);
 
-	/*
-	 * Ensure that all table entries are masked to prevent
-	 * stale entries from firing in a crash kernel.
-	 *
-	 * Done late to deal with a broken Marvell NVME device
-	 * which takes the MSI-X mask bits into account even
-	 * when MSI-X is disabled, which prevents MSI delivery.
-	 */
-	msix_mask_all(dev->msix_base, tsize);
+	if (!(info->flags & MSI_FLAG_NO_MASK)) {
+		/*
+		 * Ensure that all table entries are masked to prevent
+		 * stale entries from firing in a crash kernel.
+		 *
+		 * Done late to deal with a broken Marvell NVME device
+		 * which takes the MSI-X mask bits into account even
+		 * when MSI-X is disabled, which prevents MSI delivery.
+		 */
+		msix_mask_all(dev->msix_base, tsize);
+	}
 	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_MASKALL, 0);
 
 	pcibios_free_irq(dev);
diff --git a/include/linux/msi.h b/include/linux/msi.h
index b10093c4d00e..59a421fc42bf 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -73,7 +73,6 @@ struct msi_msg {
 	};
 };
 
-extern int pci_msi_ignore_mask;
 /* Helper functions */
 struct msi_desc;
 struct pci_dev;
@@ -556,6 +555,8 @@ enum {
 	MSI_FLAG_PCI_MSIX_ALLOC_DYN	= (1 << 20),
 	/* PCI MSIs cannot be steered separately to CPU cores */
 	MSI_FLAG_NO_AFFINITY		= (1 << 21),
+	/* Inhibit usage of entry masking */
+	MSI_FLAG_NO_MASK		= (1 << 22),
 };
 
 /**
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 396a067a8a56..7682c36cbccc 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -1143,7 +1143,7 @@ static bool msi_check_reservation_mode(struct irq_domain *domain,
 	if (!(info->flags & MSI_FLAG_MUST_REACTIVATE))
 		return false;
 
-	if (IS_ENABLED(CONFIG_PCI_MSI) && pci_msi_ignore_mask)
+	if (info->flags & MSI_FLAG_NO_MASK)
 		return false;
 
 	/*
-- 
2.46.0


