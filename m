Return-Path: <linux-pci+bounces-10967-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD55C93F823
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2024 16:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CEE62837D2
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2024 14:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1AE4181B87;
	Mon, 29 Jul 2024 14:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="kKp/eGoL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0386E181B83
	for <linux-pci@vger.kernel.org>; Mon, 29 Jul 2024 14:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722263062; cv=none; b=lgZg1rbZkc74BKWaI1/0Wd38g8BepXB2AAdJjb0SNONrOFpmOVCQvlN/NWTki+PyNDVr8dNwQj/npRRIkX5mUmzq9SZDL7ZYvAja7JmW+0ytR/b2lz6k/7FcIXa47E3hsW0Ig3Jd4ko7o8CpFibOgOVOR+GVC/j1whu5b0ogFL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722263062; c=relaxed/simple;
	bh=9lJVyphjY0BAzy5we3ocHsm7N89Vz5rw7d1oslrbQiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NnXAdDkrO5skWMp1WEVoNGNJY0uYXuVDb+Xh2fxGzBf8Do+AYoZ+lCkg1D10GoidxOmDp3XLTJLKKf8f3AA+05Lyi08QI9w0ty8FOVrBzu2G5oFSerZIDr4Km8iCsky+DwU1Oevai5G4uYLzNOcaqs0Fk6jFZDyfFIcVnmZ3nek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=kKp/eGoL; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fc56fd4de1so19356635ad.0
        for <linux-pci@vger.kernel.org>; Mon, 29 Jul 2024 07:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1722263060; x=1722867860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tEavi2oCbfZUL041rDq3pUhsFVNcsCR7JV/lSvs1zjE=;
        b=kKp/eGoLqFs69dE4ggTP/dVlRahtcMRWk66PFZK9xUJ8JrwH//RsfpzE8Vfz743TTD
         lei0xdGripmPVmsfWPHbv7x3srzuQ8GYgFryP3FA2T31CK3vIKhcusxfnj6+nYWjJ1a3
         rRxdmsAfu+pW4AgBbKPiNwq3yZU2dQCMOwXzk9iWT/53/igXAt5GzBhUJJ3r5L47QcGv
         UpH5GiSZ+Q+y3n0GwiaGDFqqkO8vS4e+joYDauXlVALHIvwTpW3fiG6Pza/7g/KrcaRP
         RHDC/8urkMp0WwYVeyHc7AiCAIFgOrtoZw3Ka1QIrytBY+YaST2ZhNd+n6CXrP5s+Y10
         v8gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722263060; x=1722867860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tEavi2oCbfZUL041rDq3pUhsFVNcsCR7JV/lSvs1zjE=;
        b=KN+nAPm1glk6QUqir3BWSGLUzmNI8YjHXmZb9xYiTUI4iJ1DDK44PFCyVzIqYWk5aB
         +pgFi8SxcoKUgEPCdIg0ZSyM+8O+jWJfXZB2I3gcs+IVXnFhY4Qfkv6VpZR4B/NkL0Cj
         S6ats58CL7VdAqbU5mxp3eEQqvncitVXXOP5S8DDWF7QHLB1ZCZvryHMMC+teWJqY868
         9aY8bpMB4117kyZMigzLJDl/5L8RK6ThyrV4/Ydr0HfZQO6eQQy6KZC4YKOP/iJzIn75
         kyPdQ8+hFJ3lkNxk5DXyW4mrdPhynyUJWe5raLLSTeE8rsMSX7OfBvEODr4tbnrnlTYb
         nYgA==
X-Forwarded-Encrypted: i=1; AJvYcCXoIiEaziZiAXTE3KbdyRPneCTw1j7FSUAQOqM03bA7tD4suXCSybpJdiJBeg+NBxtWDEmR42auREBUgWAi098i2X4Npy4MxFSe
X-Gm-Message-State: AOJu0YxXg1Dxv8JHjIXz+5yKCPFV5dv7bu59UJ8fmB+Pm/jwERCc7b+e
	pwSsUql+diBeutzyMKwNRR93OHYhjBFmKEDO67ncHdnC9GvX0dEBy4VYJ7gc3ng=
X-Google-Smtp-Source: AGHT+IHpL4tMIkOEacG2+8mAK1PfaiVTS/v+kCY6IpxY2HmFK244CWhCYJb8BR2pVzEQrYXct8BHbA==
X-Received: by 2002:a17:903:22cd:b0:1fb:5f9c:a86c with SMTP id d9443c01a7336-1ff04a23828mr133458135ad.3.1722263060022;
        Mon, 29 Jul 2024 07:24:20 -0700 (PDT)
Received: from sunil-pc.tail07344b.ts.net ([106.51.198.16])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7fa988dsm83512965ad.263.2024.07.29.07.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 07:24:19 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-pci@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Robert Moore <robert.moore@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Haibo Xu <haibo1.xu@intel.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Drew Fustini <dfustini@tenstorrent.com>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v7 15/17] irqchip/riscv-imsic: Add ACPI support
Date: Mon, 29 Jul 2024 19:52:37 +0530
Message-ID: <20240729142241.733357-16-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240729142241.733357-1-sunilvl@ventanamicro.com>
References: <20240729142241.733357-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RISC-V IMSIC interrupt controller provides IPI and MSI support.
Currently, DT based drivers setup the IPI feature early during boot but
defer setting up the MSI functionality. However, in ACPI systems, PCI
subsystem is probed early and assume MSI controller is already setup.
Hence, both IPI and MSI features need to be initialized early itself.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/irqchip/irq-riscv-imsic-early.c    | 64 +++++++++++++++++++++-
 drivers/irqchip/irq-riscv-imsic-platform.c | 32 +++++++++--
 drivers/irqchip/irq-riscv-imsic-state.c    | 57 +++++++++++--------
 drivers/irqchip/irq-riscv-imsic-state.h    |  2 +-
 include/linux/irqchip/riscv-imsic.h        |  9 +++
 5 files changed, 134 insertions(+), 30 deletions(-)

diff --git a/drivers/irqchip/irq-riscv-imsic-early.c b/drivers/irqchip/irq-riscv-imsic-early.c
index 4fbb37074d29..c5c2e6929a2f 100644
--- a/drivers/irqchip/irq-riscv-imsic-early.c
+++ b/drivers/irqchip/irq-riscv-imsic-early.c
@@ -5,13 +5,16 @@
  */
 
 #define pr_fmt(fmt) "riscv-imsic: " fmt
+#include <linux/acpi.h>
 #include <linux/cpu.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/irq.h>
 #include <linux/irqchip.h>
 #include <linux/irqchip/chained_irq.h>
+#include <linux/irqchip/riscv-imsic.h>
 #include <linux/module.h>
+#include <linux/pci.h>
 #include <linux/spinlock.h>
 #include <linux/smp.h>
 
@@ -182,7 +185,7 @@ static int __init imsic_early_dt_init(struct device_node *node, struct device_no
 	int rc;
 
 	/* Setup IMSIC state */
-	rc = imsic_setup_state(fwnode);
+	rc = imsic_setup_state(fwnode, NULL);
 	if (rc) {
 		pr_err("%pfwP: failed to setup state (error %d)\n", fwnode, rc);
 		return rc;
@@ -199,3 +202,62 @@ static int __init imsic_early_dt_init(struct device_node *node, struct device_no
 }
 
 IRQCHIP_DECLARE(riscv_imsic, "riscv,imsics", imsic_early_dt_init);
+
+#ifdef CONFIG_ACPI
+
+static struct fwnode_handle *imsic_acpi_fwnode;
+
+struct fwnode_handle *imsic_acpi_get_fwnode(struct device *dev)
+{
+	return imsic_acpi_fwnode;
+}
+
+static int __init imsic_early_acpi_init(union acpi_subtable_headers *header,
+					const unsigned long end)
+{
+	struct acpi_madt_imsic *imsic = (struct acpi_madt_imsic *)header;
+	int rc;
+
+	imsic_acpi_fwnode = irq_domain_alloc_named_fwnode("imsic");
+	if (!imsic_acpi_fwnode) {
+		pr_err("unable to allocate IMSIC FW node\n");
+		return -ENOMEM;
+	}
+
+	/* Setup IMSIC state */
+	rc = imsic_setup_state(imsic_acpi_fwnode, imsic);
+	if (rc) {
+		pr_err("%pfwP: failed to setup state (error %d)\n", imsic_acpi_fwnode, rc);
+		return rc;
+	}
+
+	/* Do early setup of IMSIC state and IPIs */
+	rc = imsic_early_probe(imsic_acpi_fwnode);
+	if (rc) {
+		irq_domain_free_fwnode(imsic_acpi_fwnode);
+		imsic_acpi_fwnode = NULL;
+		return rc;
+	}
+
+	rc = imsic_platform_acpi_probe(imsic_acpi_fwnode);
+
+#ifdef CONFIG_PCI
+	if (!rc)
+		pci_msi_register_fwnode_provider(&imsic_acpi_get_fwnode);
+#endif
+
+	if (rc)
+		pr_err("%pfwP: failed to register IMSIC for MSI functionality (error %d)\n",
+		       imsic_acpi_fwnode, rc);
+
+	/*
+	 * Even if imsic_platform_acpi_probe() fails, the IPI part of IMSIC can
+	 * continue to work. So, no need to return failure. This is similar to
+	 * DT where IPI works but MSI probe fails for some reason.
+	 */
+	return 0;
+}
+
+IRQCHIP_ACPI_DECLARE(riscv_imsic, ACPI_MADT_TYPE_IMSIC, NULL,
+		     1, imsic_early_acpi_init);
+#endif
diff --git a/drivers/irqchip/irq-riscv-imsic-platform.c b/drivers/irqchip/irq-riscv-imsic-platform.c
index 11723a763c10..64905e6f52d7 100644
--- a/drivers/irqchip/irq-riscv-imsic-platform.c
+++ b/drivers/irqchip/irq-riscv-imsic-platform.c
@@ -5,6 +5,7 @@
  */
 
 #define pr_fmt(fmt) "riscv-imsic: " fmt
+#include <linux/acpi.h>
 #include <linux/bitmap.h>
 #include <linux/cpu.h>
 #include <linux/interrupt.h>
@@ -348,18 +349,37 @@ int imsic_irqdomain_init(void)
 	return 0;
 }
 
-static int imsic_platform_probe(struct platform_device *pdev)
+static int imsic_platform_probe_common(struct fwnode_handle *fwnode)
 {
-	struct device *dev = &pdev->dev;
-
-	if (imsic && imsic->fwnode != dev->fwnode) {
-		dev_err(dev, "fwnode mismatch\n");
+	if (imsic && imsic->fwnode != fwnode) {
+		pr_err("%pfwP: fwnode mismatch\n", fwnode);
 		return -ENODEV;
 	}
 
 	return imsic_irqdomain_init();
 }
 
+static int imsic_platform_dt_probe(struct platform_device *pdev)
+{
+	return imsic_platform_probe_common(pdev->dev.fwnode);
+}
+
+#ifdef CONFIG_ACPI
+
+/*
+ *  On ACPI based systems, PCI enumeration happens early during boot in
+ *  acpi_scan_init(). PCI enumeration expects MSI domain setup before
+ *  it calls pci_set_msi_domain(). Hence, unlike in DT where
+ *  imsic-platform drive probe happens late during boot, ACPI based
+ *  systems need to setup the MSI domain early.
+ */
+int imsic_platform_acpi_probe(struct fwnode_handle *fwnode)
+{
+	return imsic_platform_probe_common(fwnode);
+}
+
+#endif
+
 static const struct of_device_id imsic_platform_match[] = {
 	{ .compatible = "riscv,imsics" },
 	{}
@@ -370,6 +390,6 @@ static struct platform_driver imsic_platform_driver = {
 		.name		= "riscv-imsic",
 		.of_match_table	= imsic_platform_match,
 	},
-	.probe = imsic_platform_probe,
+	.probe = imsic_platform_dt_probe,
 };
 builtin_platform_driver(imsic_platform_driver);
diff --git a/drivers/irqchip/irq-riscv-imsic-state.c b/drivers/irqchip/irq-riscv-imsic-state.c
index f9e70832863a..73faa64bffda 100644
--- a/drivers/irqchip/irq-riscv-imsic-state.c
+++ b/drivers/irqchip/irq-riscv-imsic-state.c
@@ -5,6 +5,7 @@
  */
 
 #define pr_fmt(fmt) "riscv-imsic: " fmt
+#include <linux/acpi.h>
 #include <linux/cpu.h>
 #include <linux/bitmap.h>
 #include <linux/interrupt.h>
@@ -564,18 +565,36 @@ static int __init imsic_populate_global_dt(struct fwnode_handle *fwnode,
 	return 0;
 }
 
+static int __init imsic_populate_global_acpi(struct fwnode_handle *fwnode,
+					     struct imsic_global_config *global,
+					     u32 *nr_parent_irqs, void *opaque)
+{
+	struct acpi_madt_imsic *imsic = (struct acpi_madt_imsic *)opaque;
+
+	global->guest_index_bits = imsic->guest_index_bits;
+	global->hart_index_bits = imsic->hart_index_bits;
+	global->group_index_bits = imsic->group_index_bits;
+	global->group_index_shift = imsic->group_index_shift;
+	global->nr_ids = imsic->num_ids;
+	global->nr_guest_ids = imsic->num_guest_ids;
+	return 0;
+}
+
 static int __init imsic_get_parent_hartid(struct fwnode_handle *fwnode,
 					  u32 index, unsigned long *hartid)
 {
 	struct of_phandle_args parent;
 	int rc;
 
-	/*
-	 * Currently, only OF fwnode is supported so extend this
-	 * function for ACPI support.
-	 */
-	if (!is_of_node(fwnode))
-		return -EINVAL;
+	if (!is_of_node(fwnode)) {
+		if (hartid)
+			*hartid = acpi_get_intc_index_hartid(index);
+
+		if (!hartid || (*hartid == INVALID_HARTID))
+			return -EINVAL;
+
+		return 0;
+	}
 
 	rc = of_irq_parse_one(to_of_node(fwnode), index, &parent);
 	if (rc)
@@ -594,12 +613,8 @@ static int __init imsic_get_parent_hartid(struct fwnode_handle *fwnode,
 static int __init imsic_get_mmio_resource(struct fwnode_handle *fwnode,
 					  u32 index, struct resource *res)
 {
-	/*
-	 * Currently, only OF fwnode is supported so extend this
-	 * function for ACPI support.
-	 */
 	if (!is_of_node(fwnode))
-		return -EINVAL;
+		return acpi_get_imsic_mmio_info(index, res);
 
 	return of_address_to_resource(to_of_node(fwnode), index, res);
 }
@@ -607,20 +622,14 @@ static int __init imsic_get_mmio_resource(struct fwnode_handle *fwnode,
 static int __init imsic_parse_fwnode(struct fwnode_handle *fwnode,
 				     struct imsic_global_config *global,
 				     u32 *nr_parent_irqs,
-				     u32 *nr_mmios)
+				     u32 *nr_mmios,
+				     void *opaque)
 {
 	unsigned long hartid;
 	struct resource res;
 	int rc;
 	u32 i;
 
-	/*
-	 * Currently, only OF fwnode is supported so extend this
-	 * function for ACPI support.
-	 */
-	if (!is_of_node(fwnode))
-		return -EINVAL;
-
 	*nr_parent_irqs = 0;
 	*nr_mmios = 0;
 
@@ -632,7 +641,11 @@ static int __init imsic_parse_fwnode(struct fwnode_handle *fwnode,
 		return -EINVAL;
 	}
 
-	rc = imsic_populate_global_dt(fwnode, global, nr_parent_irqs);
+	if (is_of_node(fwnode))
+		rc = imsic_populate_global_dt(fwnode, global, nr_parent_irqs);
+	else
+		rc = imsic_populate_global_acpi(fwnode, global, nr_parent_irqs, opaque);
+
 	if (rc)
 		return rc;
 
@@ -701,7 +714,7 @@ static int __init imsic_parse_fwnode(struct fwnode_handle *fwnode,
 	return 0;
 }
 
-int __init imsic_setup_state(struct fwnode_handle *fwnode)
+int __init imsic_setup_state(struct fwnode_handle *fwnode, void *opaque)
 {
 	u32 i, j, index, nr_parent_irqs, nr_mmios, nr_handlers = 0;
 	struct imsic_global_config *global;
@@ -742,7 +755,7 @@ int __init imsic_setup_state(struct fwnode_handle *fwnode)
 	}
 
 	/* Parse IMSIC fwnode */
-	rc = imsic_parse_fwnode(fwnode, global, &nr_parent_irqs, &nr_mmios);
+	rc = imsic_parse_fwnode(fwnode, global, &nr_parent_irqs, &nr_mmios, opaque);
 	if (rc)
 		goto out_free_local;
 
diff --git a/drivers/irqchip/irq-riscv-imsic-state.h b/drivers/irqchip/irq-riscv-imsic-state.h
index 5ae2f69b035b..391e44280827 100644
--- a/drivers/irqchip/irq-riscv-imsic-state.h
+++ b/drivers/irqchip/irq-riscv-imsic-state.h
@@ -102,7 +102,7 @@ void imsic_vector_debug_show_summary(struct seq_file *m, int ind);
 
 void imsic_state_online(void);
 void imsic_state_offline(void);
-int imsic_setup_state(struct fwnode_handle *fwnode);
+int imsic_setup_state(struct fwnode_handle *fwnode, void *opaque);
 int imsic_irqdomain_init(void);
 
 #endif
diff --git a/include/linux/irqchip/riscv-imsic.h b/include/linux/irqchip/riscv-imsic.h
index faf0b800b1b0..7494952c5518 100644
--- a/include/linux/irqchip/riscv-imsic.h
+++ b/include/linux/irqchip/riscv-imsic.h
@@ -8,6 +8,8 @@
 
 #include <linux/types.h>
 #include <linux/bitops.h>
+#include <linux/device.h>
+#include <linux/fwnode.h>
 #include <asm/csr.h>
 
 #define IMSIC_MMIO_PAGE_SHIFT		12
@@ -84,4 +86,11 @@ static inline const struct imsic_global_config *imsic_get_global_config(void)
 
 #endif
 
+#ifdef CONFIG_ACPI
+int imsic_platform_acpi_probe(struct fwnode_handle *fwnode);
+struct fwnode_handle *imsic_acpi_get_fwnode(struct device *dev);
+#else
+static inline struct fwnode_handle *imsic_acpi_get_fwnode(struct device *dev) { return NULL; }
+#endif
+
 #endif
-- 
2.43.0


