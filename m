Return-Path: <linux-pci+bounces-8172-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C518D70BF
	for <lists+linux-pci@lfdr.de>; Sat,  1 Jun 2024 17:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D5422831CC
	for <lists+linux-pci@lfdr.de>; Sat,  1 Jun 2024 15:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660E1152E0E;
	Sat,  1 Jun 2024 15:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="PEFZj/X2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC30153821
	for <linux-pci@vger.kernel.org>; Sat,  1 Jun 2024 15:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717254370; cv=none; b=AQL1dUnih6oH94t7Svx80iPs5v1jT13gP8IJqJlnIA8msuXsy22hDT5itSz6WoYO4lrprGcokml4vpf/uFnxZ9EbwbaxZj34f27qh1dA0x/xJlj2n6ITzWtVdAtAWB3Mz6L4X7ecosrwD5DM7MHYkvMSHHvyWX2rll9NcCHjPc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717254370; c=relaxed/simple;
	bh=lmfXne/NOxF4HQfeNN4+6bTGlS2AvMTMryxXwoQhioU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZDruyAO86Io/jEcqOUMT8nJqZlbWQxbZ+MhytZ73rFwf80GfxGX98XK1z+U853kmy6fSHFXM9wIeCfhB1N9nVc1ngnoQi7mMVwFTnNkLcyVbYdLEhKR56blkr7NZNawxa5c8+yY4l6cIDBkt+DXFT5V1pJZoVMjy/ob/3kxDeOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=PEFZj/X2; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-702508bf0a9so992221b3a.0
        for <linux-pci@vger.kernel.org>; Sat, 01 Jun 2024 08:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1717254368; x=1717859168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bieOckQA/OdAZamZYetSX8Y5sqY4/SqoIaxENg7tXYU=;
        b=PEFZj/X2JndSxASN1fLVvgGVa8s/jTtxLklU1um0sLtwhEMSg6KE0l48Ttwk+pg82z
         Lts1iMhKGCkAXNc06Ue+dF+VWavkuJ5KUuleDkPm3fQ+V4oY90CG44FFFqyOLsJFgb2J
         P7IBHA1+jGjTwUamItnPdH1CPJ5MlUyAxl/MiyxFWwkoTslGGayE0pqG69F/8XiGMnbL
         E8x5PDvYxtvhBTUQ1ONmNwv+NfmsQ26CkJy5ydROrFm0hbpID7RLLNT3XG4KHEJZ3VkE
         5JZEZLUnQ+2kOiAaRVYqRCRUyuk+eA1YuztYcN0+emaWxqfGDgiK4vaUeJXO2vNZ66if
         7S5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717254368; x=1717859168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bieOckQA/OdAZamZYetSX8Y5sqY4/SqoIaxENg7tXYU=;
        b=LNoroMYOT1nGAVY13ltfoAbtKmf8wrBGZgrM5tLI4IZA+OfXf1SNKYYEt8pFoQzYfH
         JwERcZZ42XMezhtKUXtEIEl3aRTc0Rf7trCGWqoh1ndtVgQbhgCylJGjDeid+rgjF+tW
         PF4nPBc+RTdqhToxfNyOgRtQOO+Z0zuI8rJbBGyCgEs56RxW/+U44sCvkx7pCgCyf0SX
         HMaKLqqqqQxkJKL+IFtBy1/k2pl5XCQLrZJKKZ2BiglIphw30P2i7pnezlDI6CJc1DTL
         Z7mQM+hGz1GCdRf9rkRzoodA0cYiDn/1/C70+1UNKzrYCDdxfF8FItw54TM0Y3pnY1Hq
         6WIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKRmnZQHb7FJLW5+XpcnxRPkrs9XGHNB/n+SSjCn8/OBzx7iPig5MDpdDOU1VO5P2AoqQwtKhmkkEVvb3PsYXLdEMXB4u9wnEX
X-Gm-Message-State: AOJu0YyZFKkF5quAijan6SN/Brry/Pp4NbKzDKqBBSCse+7KuazI6GKs
	pZvM0urmNW9+C2bVr1h8GlVed+ID1+jmriNXw36u+MgbTJ7BAX2/fhqlBH91DTI=
X-Google-Smtp-Source: AGHT+IGpQemm+8CE4X9z9ez/Hldkhjrfn9X2HmSTqIXMuf45inJMRNs9j84XQDLO/okfZoTL3FB5+w==
X-Received: by 2002:a05:6a20:9188:b0:1b0:14a0:c873 with SMTP id adf61e73a8af0-1b26f185930mr5757294637.35.1717254368009;
        Sat, 01 Jun 2024 08:06:08 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.187.237])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6c35a4ba741sm2559410a12.85.2024.06.01.08.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jun 2024 08:06:06 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
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
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Marc Zyngier <maz@kernel.org>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Haibo1 Xu <haibo1.xu@intel.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v6 15/17] irqchip/riscv-imsic: Add ACPI support
Date: Sat,  1 Jun 2024 20:34:09 +0530
Message-Id: <20240601150411.1929783-16-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240601150411.1929783-1-sunilvl@ventanamicro.com>
References: <20240601150411.1929783-1-sunilvl@ventanamicro.com>
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
2.40.1


