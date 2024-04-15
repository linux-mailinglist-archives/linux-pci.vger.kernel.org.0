Return-Path: <linux-pci+bounces-6267-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5A48A587F
	for <lists+linux-pci@lfdr.de>; Mon, 15 Apr 2024 19:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 622411C20B80
	for <lists+linux-pci@lfdr.de>; Mon, 15 Apr 2024 17:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3494284038;
	Mon, 15 Apr 2024 17:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="MTPGx8k3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BF184D0D
	for <linux-pci@vger.kernel.org>; Mon, 15 Apr 2024 17:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713200553; cv=none; b=guBhdvRu9A+EeTvtWfH8jJl0ulOoP+H5PYEWWeK4jlgHZmFV2MmuNfOWHn00nV2pWBhDNxGeyywAwS+7xF6LvU2tMBw3ekuVoXDtQYR7b9o5B/uWOhaoW0OIuQ2BZz+L2vi5nz/IrQHXt3KFQQQDLXqeA/ENWchlCvsiXRw6B9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713200553; c=relaxed/simple;
	bh=8faRomOS+YY08OK+jIa6TJx7uMvk/iowqcEmkn3Wzl4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k1Xkk6Dty6FtD9CJozSRaLPoqNUoiJVhugM+wwmr5VElkINKSq67VrjXV2TSS7N2I58uE+LwpRsnnDuSvF6xgepOGc5nL2FNTd83n+Q86+Uv6UveE62+EE4wMpdqWZRbf261L6wIZWfZycOeFHg5dVwGyVK2OSM+khUtIqLthv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=MTPGx8k3; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6ee12766586so2243920b3a.0
        for <linux-pci@vger.kernel.org>; Mon, 15 Apr 2024 10:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1713200551; x=1713805351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qa8aPZaBb5SHnjDhwNe5AO6s82EyT//Q/0nqKZneQ7s=;
        b=MTPGx8k3q+d72gS/sB4MfwDoNH568FqM8IrvodcxAgLFimnlPnAbRkC5fFJ4jX3PLI
         124Srwt+oJY/FcMcKMcgNdBnLIiiTTi2dWGwjA9hMcGVg/yDzkEajsuUNvZ9WikZp184
         ScVQnjlj42ge77Jx/Ion+UmQhhF0Ra+92ZWg+FGi75prYwTRLN9l68BHOmXAwyID/BPl
         J1Z+5jgzePLyMhhH4f4G9jzQp/U/GrbA4JBJGdg0pmZpFRPxqAjVn0fbLPNtwUt+W+hR
         ZgHoSIvkl/xc1Nd+fyUzms/a6Hz8Jf+DInSCLu8daRn+zL8JJaCzAgNmvhFziSbzoc6X
         UokA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713200551; x=1713805351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qa8aPZaBb5SHnjDhwNe5AO6s82EyT//Q/0nqKZneQ7s=;
        b=lQR9uxOzqP+HJ2ygcrKk+x2zSsBMFT8UPVf53+BzLUQ8m16xUwgfZHnNl4eFLgsfZt
         bgCrusDP6967fQX3FiYR4OHXLTnCqEQ/DbcmjdT/Q8TV792g3o/F6JyEfnvhxq2jm8Tg
         OmompKYqN/nOVbTLIL7qzecD5HUUQTz7CBh6oYDfXfdFqiIEGo1tq0H1Stmxi0uMGAIc
         rgHMRv99n0wzwOW5JG7Hv8vQk8utNrrnhE2AuLvXHQrfQy7iQKsVJecMi1KE1fDKFGhd
         VVZrwcZfTxyksv+WG3fSPe0cPIYeoGP6+dFawIXG4bp+Mpz4LjIcXA+AIcXN+Z3VE7FH
         gzIw==
X-Forwarded-Encrypted: i=1; AJvYcCVDcpRb5v2BjKAlgJg749jkTnrdTSUrMEZBt/Mq55Zk017mkKtojxTkUwF7H7DzXTcEPYxu1vdBBPZId5M+S9bVtg5JN8P01L4+
X-Gm-Message-State: AOJu0YzvgQABDGJtj8M2CrYA87xKKiamb8LUxoXi7pVaT2Mkn2mL5TEe
	C5gN/txT1Ss1Tyitd8zsLiCUG6icdacqu+/G56Tqg+MLN/T+ILBYFef2QNETTkE=
X-Google-Smtp-Source: AGHT+IGeXHiOC0F13RXgbWt688j7t9WtlnZZWw2iOK4tJHmoNhJ03Rmp2MstRb1M8cWB8bLvffMYEA==
X-Received: by 2002:a05:6a00:c88:b0:6ec:e21b:24f with SMTP id a8-20020a056a000c8800b006ece21b024fmr288145pfv.10.1713200550215;
        Mon, 15 Apr 2024 10:02:30 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.187.230])
        by smtp.gmail.com with ESMTPSA id 1-20020a056a00072100b006ed045e3a70sm7433158pfm.25.2024.04.15.10.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 10:02:29 -0700 (PDT)
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
	Haibo1 Xu <haibo1.xu@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Andrei Warkentin <andrei.warkentin@intel.com>,
	Marc Zyngier <maz@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [RFC PATCH v4 10/20] RISC-V: ACPI: Initialize GSI mapping structures
Date: Mon, 15 Apr 2024 22:31:03 +0530
Message-Id: <20240415170113.662318-11-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240415170113.662318-1-sunilvl@ventanamicro.com>
References: <20240415170113.662318-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RISC-V has PLIC and APLIC in MADT as well as namespace devices.
Initialize the list of those structures using MADT and namespace devices
to create mapping between the ACPI handle and the GSI ranges. This is
will be used later to add dependencies.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 arch/riscv/include/asm/irq.h |  22 +++++
 drivers/acpi/riscv/init.c    |   2 +
 drivers/acpi/riscv/init.h    |   4 +
 drivers/acpi/riscv/irq.c     | 159 +++++++++++++++++++++++++++++++++++
 4 files changed, 187 insertions(+)
 create mode 100644 drivers/acpi/riscv/init.h

diff --git a/arch/riscv/include/asm/irq.h b/arch/riscv/include/asm/irq.h
index 8e10a94430a2..44a0b128c602 100644
--- a/arch/riscv/include/asm/irq.h
+++ b/arch/riscv/include/asm/irq.h
@@ -16,4 +16,26 @@ void riscv_set_intc_hwnode_fn(struct fwnode_handle *(*fn)(void));
 
 struct fwnode_handle *riscv_get_intc_hwnode(void);
 
+#ifdef CONFIG_ACPI
+
+enum riscv_irqchip_type {
+	ACPI_RISCV_IRQCHIP_INTC		= 0x00,
+	ACPI_RISCV_IRQCHIP_IMSIC	= 0x01,
+	ACPI_RISCV_IRQCHIP_PLIC		= 0x02,
+	ACPI_RISCV_IRQCHIP_APLIC	= 0x03,
+};
+
+int riscv_acpi_get_gsi_info(struct fwnode_handle *fwnode, u32 *gsi_base,
+			    u32 *id, u32 *nr_irqs, u32 *nr_idcs);
+struct fwnode_handle *riscv_acpi_get_gsi_domain_id(u32 gsi);
+
+#else
+static inline int riscv_acpi_get_gsi_info(struct fwnode_handle *fwnode, u32 *gsi_base,
+					  u32 *id, u32 *nr_irqs, u32 *nr_idcs)
+{
+	return 0;
+}
+
+#endif /* CONFIG_ACPI */
+
 #endif /* _ASM_RISCV_IRQ_H */
diff --git a/drivers/acpi/riscv/init.c b/drivers/acpi/riscv/init.c
index b5807bbdb171..56780af6ceb3 100644
--- a/drivers/acpi/riscv/init.c
+++ b/drivers/acpi/riscv/init.c
@@ -6,7 +6,9 @@
  */
 
 #include <linux/acpi.h>
+#include "init.h"
 
 void __init acpi_riscv_init(void)
 {
+	riscv_acpi_init_gsi_mapping();
 }
diff --git a/drivers/acpi/riscv/init.h b/drivers/acpi/riscv/init.h
new file mode 100644
index 000000000000..2a488ec684b9
--- /dev/null
+++ b/drivers/acpi/riscv/init.h
@@ -0,0 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#include <linux/init.h>
+
+int __init riscv_acpi_init_gsi_mapping(void);
diff --git a/drivers/acpi/riscv/irq.c b/drivers/acpi/riscv/irq.c
index 36e0525b3235..de0f1ba92068 100644
--- a/drivers/acpi/riscv/irq.c
+++ b/drivers/acpi/riscv/irq.c
@@ -7,6 +7,21 @@
 
 #include <linux/acpi.h>
 #include <linux/sort.h>
+#include <linux/irq.h>
+
+#include "init.h"
+
+struct riscv_ext_intc_list {
+	acpi_handle handle;
+	u32 gsi_base;
+	u32 nr_irqs;
+	u32 nr_idcs;
+	u32 id;
+	u32 type;
+	struct list_head list;
+};
+
+LIST_HEAD(ext_intc_list);
 
 static int irqchip_cmp_func(const void *in0, const void *in1)
 {
@@ -30,3 +45,147 @@ void arch_sort_irqchip_probe(struct acpi_probe_entry *ap_head, int nr)
 		return;
 	sort(ape, nr, sizeof(*ape), irqchip_cmp_func, NULL);
 }
+
+static int riscv_acpi_update_gsi_handle(u32 gsi_base, acpi_handle handle)
+{
+	struct riscv_ext_intc_list *ext_intc_element;
+	struct list_head *i, *tmp;
+
+	list_for_each_safe(i, tmp, &ext_intc_list) {
+		ext_intc_element = list_entry(i, struct riscv_ext_intc_list, list);
+		if (gsi_base == ext_intc_element->gsi_base) {
+			ext_intc_element->handle = handle;
+			return 0;
+		}
+	}
+
+	return -1;
+}
+
+static acpi_handle riscv_acpi_get_gsi_handle(u32 gsi)
+{
+	struct riscv_ext_intc_list *ext_intc_element;
+	struct list_head *i, *tmp;
+
+	list_for_each_safe(i, tmp, &ext_intc_list) {
+		ext_intc_element = list_entry(i, struct riscv_ext_intc_list, list);
+		if (gsi >= ext_intc_element->gsi_base &&
+		    gsi < (ext_intc_element->gsi_base + ext_intc_element->nr_irqs))
+			return ext_intc_element->handle;
+	}
+
+	return NULL;
+}
+
+int riscv_acpi_get_gsi_info(struct fwnode_handle *fwnode, u32 *gsi_base,
+			    u32 *id, u32 *nr_irqs, u32 *nr_idcs)
+{
+	struct riscv_ext_intc_list *ext_intc_element;
+	struct list_head *i, *tmp;
+
+	list_for_each_safe(i, tmp, &ext_intc_list) {
+		ext_intc_element = list_entry(i, struct riscv_ext_intc_list, list);
+		if (ext_intc_element->handle == ACPI_HANDLE_FWNODE(fwnode)) {
+			*gsi_base = ext_intc_element->gsi_base;
+			*id = ext_intc_element->id;
+			*nr_irqs = ext_intc_element->nr_irqs;
+			if (nr_idcs)
+				*nr_idcs = ext_intc_element->nr_idcs;
+			return 0;
+		}
+	}
+
+	return -ENODEV;
+}
+
+struct fwnode_handle *riscv_acpi_get_gsi_domain_id(u32 gsi)
+{
+	struct riscv_ext_intc_list *ext_intc_element;
+	struct acpi_device *adev;
+	struct list_head *i, *tmp;
+
+	list_for_each_safe(i, tmp, &ext_intc_list) {
+		ext_intc_element = list_entry(i, struct riscv_ext_intc_list, list);
+		if (gsi >= ext_intc_element->gsi_base &&
+		    gsi < (ext_intc_element->gsi_base + ext_intc_element->nr_irqs)) {
+			adev = acpi_fetch_acpi_dev(ext_intc_element->handle);
+			if (!adev)
+				return NULL;
+
+			return acpi_fwnode_handle(adev);
+		}
+	}
+
+	return NULL;
+}
+
+static int __init riscv_acpi_register_ext_intc(u32 gsi_base, u32 nr_irqs, u32 nr_idcs,
+					       u32 id, u32 type)
+{
+	struct riscv_ext_intc_list *ext_intc_element;
+
+	ext_intc_element = kzalloc(sizeof(*ext_intc_element), GFP_KERNEL);
+	if (!ext_intc_element)
+		return -1;
+
+	ext_intc_element->gsi_base = gsi_base;
+	ext_intc_element->nr_irqs = nr_irqs;
+	ext_intc_element->nr_idcs = nr_idcs;
+	ext_intc_element->id = id;
+	list_add_tail(&ext_intc_element->list, &ext_intc_list);
+	return 0;
+}
+
+static acpi_status __init riscv_acpi_create_gsi_map(acpi_handle handle, u32 level,
+						    void *context, void **return_value)
+{
+	acpi_status status;
+	u64 gbase;
+
+	if (!acpi_has_method(handle, "_GSB"))
+		return AE_OK;
+
+	status = acpi_evaluate_integer(handle, "_GSB", NULL, &gbase);
+	if (ACPI_FAILURE(status)) {
+		acpi_handle_err(handle, "failed to evaluate _GSB method\n");
+		return AE_OK;
+	}
+
+	riscv_acpi_update_gsi_handle((u32)gbase, handle);
+	return AE_OK;
+}
+
+static int __init riscv_acpi_aplic_parse_madt(union acpi_subtable_headers *header,
+					      const unsigned long end)
+{
+	struct acpi_madt_aplic *aplic = (struct acpi_madt_aplic *)header;
+
+	riscv_acpi_register_ext_intc(aplic->gsi_base, aplic->num_sources,
+				     aplic->num_idcs, aplic->id, ACPI_RISCV_IRQCHIP_APLIC);
+	return 0;
+}
+
+static int __init riscv_acpi_plic_parse_madt(union acpi_subtable_headers *header,
+					     const unsigned long end)
+{
+	struct acpi_madt_plic *plic = (struct acpi_madt_plic *)header;
+
+	riscv_acpi_register_ext_intc(plic->gsi_base, plic->num_irqs, 0,
+				     plic->id, ACPI_RISCV_IRQCHIP_PLIC);
+	return 0;
+}
+
+int __init riscv_acpi_init_gsi_mapping(void)
+{
+	int count = 0;
+
+	count = acpi_table_parse_madt(ACPI_MADT_TYPE_PLIC, riscv_acpi_plic_parse_madt, 0);
+	if (count <= 0) {
+		acpi_table_parse_madt(ACPI_MADT_TYPE_APLIC, riscv_acpi_aplic_parse_madt, 0);
+		acpi_get_devices("RSCV0002", riscv_acpi_create_gsi_map, NULL, NULL);
+		return 0;
+	}
+
+	acpi_get_devices("RSCV0001", riscv_acpi_create_gsi_map, NULL, NULL);
+	return 0;
+}
-- 
2.40.1


