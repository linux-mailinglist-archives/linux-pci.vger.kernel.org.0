Return-Path: <linux-pci+bounces-10965-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C42C93F81D
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2024 16:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8035282BFE
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2024 14:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E8B1741D5;
	Mon, 29 Jul 2024 14:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="GdpxYCtq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839931922D3
	for <linux-pci@vger.kernel.org>; Mon, 29 Jul 2024 14:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722263051; cv=none; b=sArGiH+t6O7KDFPdrjnCOzoSyARQ/6dSEGBaMs1qkvIex6rMKSmXW9haEqq1ysHwH2ec3tsOwf1WTRwyfiKlCv3XcMNat+9SfycPoTcNdq/krrrzs7Kt9pJuVaJHclVpaUiVSPyaicELGpR9rYOG9LQCZKGz1F0eRJM2fvJac58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722263051; c=relaxed/simple;
	bh=OrwfiHoWI5snN21rvRMu3x1zz1XqGGlBe+KHS3BHII4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lhXSCWmacf961wV96VOH4LBzpK9X2qJNeKTz2TGS7MyrFWZ8dfp9SeCBomuHJ8xktKCehzFiP2uBCyhdzYi6U59nOBjTVhlGZVIFHHm6IZqDnRjaXQvmFQFOALIs8vVIalgg+UD359SWZ5q5+bFLAP+H0aTPri4gyLFewN/eWWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=GdpxYCtq; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fbc3a9d23bso17953755ad.1
        for <linux-pci@vger.kernel.org>; Mon, 29 Jul 2024 07:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1722263049; x=1722867849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kYlVQjcWuKOe+NFOp1Wh7i++2nCqItwyO/PCNQ13gxs=;
        b=GdpxYCtqTE63NNZjrG1FSbqsDg54dO6WMwJEpCBdM62l2wnsiTbZDZnImOto0XbWyN
         w9cPOlhbbqKassYvYJdFO8Tzay78OytkJI0g2/1hPfiIaJ94SX4XB1D1cMLq9OZ2H8Zi
         6yZt0mWLuaMWyTZSFMC+nersCVBrfAPMW6xIZqQesC8zrfwfXVYah4UJd7v5mNb9Jddh
         gKZDIcU7xD0CZbL/yTMQsBXF//3DwZK/DJJohtE3MMR2yUcVfihSn088n6l1lkBmRSJl
         pQt5jgBUUVMIipJILO/BsgoHnW3SZf28oaYewV1dUqG7oGVo5+0i88M207crnVoXVhxV
         kGww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722263049; x=1722867849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kYlVQjcWuKOe+NFOp1Wh7i++2nCqItwyO/PCNQ13gxs=;
        b=EI88J93vB15i76cGCUmFxXSqIIiqkywbAjj7Q0imRzGA3/2rrQ/G4kT/w3vjKfGtPB
         6higNLsev7VXANw3LpW7kQfyWnfc1QlASS8WC08PejhsFkMrAuWuA9TQ0rkfnVa/ou77
         D7yV/1QALh7IX4OzXRT+BcX4dD+sjMr/JDQneWjIMYG37mU/1hwPeoqmmXxi8XoARBcu
         ml8hUiuOP3R9W37ouIPH0priXhLAlGCRxbNmFYEDrAZeE6u32u7IcMIde9oSRaNyUw4z
         U7KWSYNuXlFzrYXyEA/vnhIAD+h+z4i6IVlCcmQ10a3evrVX/9CsvEf6MKba0XljA5rn
         Z68Q==
X-Forwarded-Encrypted: i=1; AJvYcCVIMMWKPqQU8vMPX5pB1oMW3IX2lCfqD5KslVxWXkYxqIvfXYQTioMKpJ4DpDc8pwJ1k+mknFCnzODpQBhDnS7kDxOPOCvQEGqr
X-Gm-Message-State: AOJu0Ywqlh1PztURfDoCYz0yJed9QHEQVzXzcUXssFjjO3gXAdATgYbF
	tKMsDYh5t3Yp7/m/dRkZHQXdQp+s1+iEOue22xErnx48R/jLfVTmDcx1uhm95kY=
X-Google-Smtp-Source: AGHT+IHv8OfHL+oywHkMVCyqgu6uiipWK5S4kQQJeyBrieT8AIn2g14TSQmHke4oYp0sVgW17J6yFA==
X-Received: by 2002:a17:902:fc46:b0:1ff:52c:34ce with SMTP id d9443c01a7336-1ff052c3e33mr60989715ad.53.1722263048905;
        Mon, 29 Jul 2024 07:24:08 -0700 (PDT)
Received: from sunil-pc.tail07344b.ts.net ([106.51.198.16])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7fa988dsm83512965ad.263.2024.07.29.07.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 07:24:08 -0700 (PDT)
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
Subject: [PATCH v7 13/17] irqchip/riscv-intc: Add ACPI support for AIA
Date: Mon, 29 Jul 2024 19:52:35 +0530
Message-ID: <20240729142241.733357-14-sunilvl@ventanamicro.com>
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

The RINTC subtype structure in MADT also has information about other
interrupt controllers. Save this information and provide interfaces to
retrieve them when required by corresponding drivers.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 arch/riscv/include/asm/irq.h     | 33 ++++++++++++
 drivers/irqchip/irq-riscv-intc.c | 90 ++++++++++++++++++++++++++++++++
 2 files changed, 123 insertions(+)

diff --git a/arch/riscv/include/asm/irq.h b/arch/riscv/include/asm/irq.h
index 44a0b128c602..51d86f0b80d2 100644
--- a/arch/riscv/include/asm/irq.h
+++ b/arch/riscv/include/asm/irq.h
@@ -12,6 +12,8 @@
 
 #include <asm-generic/irq.h>
 
+#define INVALID_CONTEXT UINT_MAX
+
 void riscv_set_intc_hwnode_fn(struct fwnode_handle *(*fn)(void));
 
 struct fwnode_handle *riscv_get_intc_hwnode(void);
@@ -28,6 +30,11 @@ enum riscv_irqchip_type {
 int riscv_acpi_get_gsi_info(struct fwnode_handle *fwnode, u32 *gsi_base,
 			    u32 *id, u32 *nr_irqs, u32 *nr_idcs);
 struct fwnode_handle *riscv_acpi_get_gsi_domain_id(u32 gsi);
+unsigned long acpi_get_intc_index_hartid(u32 index);
+unsigned long acpi_get_ext_intc_parent_hartid(unsigned int plic_id, unsigned int ctxt_idx);
+unsigned int acpi_get_plic_nr_contexts(unsigned int plic_id);
+unsigned int acpi_get_plic_context(unsigned int plic_id, unsigned int ctxt_idx);
+int __init acpi_get_imsic_mmio_info(u32 index, struct resource *res);
 
 #else
 static inline int riscv_acpi_get_gsi_info(struct fwnode_handle *fwnode, u32 *gsi_base,
@@ -36,6 +43,32 @@ static inline int riscv_acpi_get_gsi_info(struct fwnode_handle *fwnode, u32 *gsi
 	return 0;
 }
 
+static inline unsigned long acpi_get_intc_index_hartid(u32 index)
+{
+	return INVALID_HARTID;
+}
+
+static inline unsigned long acpi_get_ext_intc_parent_hartid(unsigned int plic_id,
+							    unsigned int ctxt_idx)
+{
+	return INVALID_HARTID;
+}
+
+static inline unsigned int acpi_get_plic_nr_contexts(unsigned int plic_id)
+{
+	return INVALID_CONTEXT;
+}
+
+static inline unsigned int acpi_get_plic_context(unsigned int plic_id, unsigned int ctxt_idx)
+{
+	return INVALID_CONTEXT;
+}
+
+static inline int __init acpi_get_imsic_mmio_info(u32 index, struct resource *res)
+{
+	return 0;
+}
+
 #endif /* CONFIG_ACPI */
 
 #endif /* _ASM_RISCV_IRQ_H */
diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
index 47f3200476da..5ddb12ce8b97 100644
--- a/drivers/irqchip/irq-riscv-intc.c
+++ b/drivers/irqchip/irq-riscv-intc.c
@@ -250,6 +250,85 @@ IRQCHIP_DECLARE(andes, "andestech,cpu-intc", riscv_intc_init);
 
 #ifdef CONFIG_ACPI
 
+struct rintc_data {
+	union {
+		u32		ext_intc_id;
+		struct {
+			u32	context_id	: 16,
+				reserved	:  8,
+				aplic_plic_id	:  8;
+		};
+	};
+	unsigned long		hart_id;
+	u64			imsic_addr;
+	u32			imsic_size;
+};
+
+static u32 nr_rintc;
+static struct rintc_data *rintc_acpi_data[NR_CPUS];
+
+#define for_each_matching_plic(_plic_id)				\
+	unsigned int _plic;						\
+									\
+	for (_plic = 0; _plic < nr_rintc; _plic++)			\
+		if (rintc_acpi_data[_plic]->aplic_plic_id != _plic_id)	\
+			continue;					\
+		else
+
+unsigned int acpi_get_plic_nr_contexts(unsigned int plic_id)
+{
+	unsigned int nctx = 0;
+
+	for_each_matching_plic(plic_id)
+		nctx++;
+
+	return nctx;
+}
+
+static struct rintc_data *get_plic_context(unsigned int plic_id, unsigned int ctxt_idx)
+{
+	unsigned int ctxt = 0;
+
+	for_each_matching_plic(plic_id) {
+		if (ctxt == ctxt_idx)
+			return rintc_acpi_data[_plic];
+
+		ctxt++;
+	}
+
+	return NULL;
+}
+
+unsigned long acpi_get_ext_intc_parent_hartid(unsigned int plic_id, unsigned int ctxt_idx)
+{
+	struct rintc_data *data = get_plic_context(plic_id, ctxt_idx);
+
+	return data ? data->hart_id : INVALID_HARTID;
+}
+
+unsigned int acpi_get_plic_context(unsigned int plic_id, unsigned int ctxt_idx)
+{
+	struct rintc_data *data = get_plic_context(plic_id, ctxt_idx);
+
+	return data ? data->context_id : INVALID_CONTEXT;
+}
+
+unsigned long acpi_get_intc_index_hartid(u32 index)
+{
+	return index >= nr_rintc ? INVALID_HARTID : rintc_acpi_data[index]->hart_id;
+}
+
+int acpi_get_imsic_mmio_info(u32 index, struct resource *res)
+{
+	if (index >= nr_rintc)
+		return -1;
+
+	res->start = rintc_acpi_data[index]->imsic_addr;
+	res->end = res->start + rintc_acpi_data[index]->imsic_size - 1;
+	res->flags = IORESOURCE_MEM;
+	return 0;
+}
+
 static int __init riscv_intc_acpi_init(union acpi_subtable_headers *header,
 				       const unsigned long end)
 {
@@ -258,6 +337,15 @@ static int __init riscv_intc_acpi_init(union acpi_subtable_headers *header,
 	int rc;
 
 	rintc = (struct acpi_madt_rintc *)header;
+	rintc_acpi_data[nr_rintc] = kzalloc(sizeof(*rintc_acpi_data[0]), GFP_KERNEL);
+	if (!rintc_acpi_data[nr_rintc])
+		return -ENOMEM;
+
+	rintc_acpi_data[nr_rintc]->ext_intc_id = rintc->ext_intc_id;
+	rintc_acpi_data[nr_rintc]->hart_id = rintc->hart_id;
+	rintc_acpi_data[nr_rintc]->imsic_addr = rintc->imsic_addr;
+	rintc_acpi_data[nr_rintc]->imsic_size = rintc->imsic_size;
+	nr_rintc++;
 
 	/*
 	 * The ACPI MADT will have one INTC for each CPU (or HART)
@@ -277,6 +365,8 @@ static int __init riscv_intc_acpi_init(union acpi_subtable_headers *header,
 	rc = riscv_intc_init_common(fn, &riscv_intc_chip);
 	if (rc)
 		irq_domain_free_fwnode(fn);
+	else
+		acpi_set_irq_model(ACPI_IRQ_MODEL_RINTC, riscv_acpi_get_gsi_domain_id);
 
 	return rc;
 }
-- 
2.43.0


