Return-Path: <linux-pci+bounces-8170-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9478D70B9
	for <lists+linux-pci@lfdr.de>; Sat,  1 Jun 2024 17:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82D811F253D9
	for <lists+linux-pci@lfdr.de>; Sat,  1 Jun 2024 15:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03ED153810;
	Sat,  1 Jun 2024 15:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="NzoiAJng"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6B2152E15
	for <linux-pci@vger.kernel.org>; Sat,  1 Jun 2024 15:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717254355; cv=none; b=OgEwobToLY23S5MLtLCGg8rZ1J0/iaCzhy4SBHR/z9jXfmFZoXng74UOnQOKSaKPd0yZ8Kfd0cLd1R9M0OyzqJOJcOV2+bESON/YfLVntQqG8Y3CTRxPWA7gxeCdWahExwdiS6vwU+Y/c8gUOxtehYQtvGp0D4/k+hDUfWKXENU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717254355; c=relaxed/simple;
	bh=HduTz1DhrFN/riIadkO3PLfqAkboPSlWmc+plvBcO6E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JmB6q4mCNOd+MTV4Ui1WF6o9j4q9CfYysQkq+UaQEYKphJ/U0uLt8Z6MaZ/EA/2ysOUKjWDxoScu7tYkylgrwqg9PoxX2xuzrO3jPoTku6CioN6rvrqhNjVQzLpD/pWi2zqHLVv5IGpVhJKcn3ntPewx0/BlnE55WJqAgKeSWCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=NzoiAJng; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7024e7e55f7so1152509b3a.2
        for <linux-pci@vger.kernel.org>; Sat, 01 Jun 2024 08:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1717254353; x=1717859153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ix1ya63KBdI8Z0XgPmU9L/YxtTKVM9YoT3mmPmDGYrI=;
        b=NzoiAJngDeXUMYojC8EnYQcx/47x3i61LcvozReASTIG2B91L6zycNPMdjTTzwn5b8
         4RpzI0iWj9xWnrin/WYYv1RG8dK/vidJs3akauU3txcD5+tvkMWyfuSw8N2w5s1GKqS8
         KprEx4YiXLChP84SYVisUlA+PdvRRU60Ley4F4auJ7SJNuelVD0sw0Wglc5kp1oZUCvk
         k+2NoTJGU6ps4fWAl2McwjfUPYe0SnXMFiox79YMrobKhxQv3/2rbrOGTYBk9wKa3diQ
         qJoUZfC1MF0/x4mFuR2OQhmYpMi29fzIAPjVOQTghwrG8l4wddIbPP7rs3q5BwCrS/Rm
         N/CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717254353; x=1717859153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ix1ya63KBdI8Z0XgPmU9L/YxtTKVM9YoT3mmPmDGYrI=;
        b=NiyDE8VJqoTqvovdUpDOFUTsfUbz/Dza2xv33r7xxijc66yTay9Ookw3sQjP96Uifk
         IjOFTr1cZbTonV2shgSlEBCeI8ueGWOwYO4U2thix3vnLQwETMCustWcU9voyP5/AK/H
         TW11pNTtwaoy/de+uoZE+E/O1wD5ucM7x+QwMuptv1lT5PQgTG5FbJFmECudkB7KZl/q
         Yj7XUlvHoNA1wRwmaOMy3wXIFoYAOOfPesLRUZXwMBkx6EG15AnvAK4ZhLtEszMCQP80
         x99bk8oZOulATaDTLJK+YUs0ty071mCE3fdiuXIUERpQMBbluUYKZ0qYwGPc2fITDIuh
         X5mw==
X-Forwarded-Encrypted: i=1; AJvYcCWVyJS6R698L9swpKPSlTOnNAcpXral/N3mae8VdESTUZ7z+jJ53HxLiinNekL7nO9NnsPueCcjLuxPPOQF1obZ5GA5fpHFjzN1
X-Gm-Message-State: AOJu0YzjUqGKHStN/nU74/Ua+g/wLVWyH68wefGDq+/lLNtoPtygSX4s
	wvbJtKmyAWN4rm0AfZ27vfE79atKSxLcRTHqc1zcbIQnI9/Qrw4cvW9A9H1oXb0=
X-Google-Smtp-Source: AGHT+IFPfDTfjt04oqk3q/MnI8wec/rdNH1fBWtlh1LZy3yCp1vhuEJfNDXv5tm5xoTuwiRZpnV72g==
X-Received: by 2002:a05:6a20:914e:b0:1af:4ea2:5424 with SMTP id adf61e73a8af0-1b26f20d7e3mr5216779637.33.1717254353608;
        Sat, 01 Jun 2024 08:05:53 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.187.237])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6c35a4ba741sm2559410a12.85.2024.06.01.08.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jun 2024 08:05:52 -0700 (PDT)
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
Subject: [PATCH v6 13/17] irqchip/riscv-intc: Add ACPI support for AIA
Date: Sat,  1 Jun 2024 20:34:07 +0530
Message-Id: <20240601150411.1929783-14-sunilvl@ventanamicro.com>
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
index 4f3a12383a1e..3c6494f1cb02 100644
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
2.40.1


