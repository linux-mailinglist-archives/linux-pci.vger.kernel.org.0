Return-Path: <linux-pci+bounces-1189-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E57818EBF
	for <lists+linux-pci@lfdr.de>; Tue, 19 Dec 2023 18:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEA431C24C5C
	for <lists+linux-pci@lfdr.de>; Tue, 19 Dec 2023 17:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB36F374F3;
	Tue, 19 Dec 2023 17:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="DPqUhByv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A43341862
	for <linux-pci@vger.kernel.org>; Tue, 19 Dec 2023 17:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d3ac28ae81so24266955ad.0
        for <linux-pci@vger.kernel.org>; Tue, 19 Dec 2023 09:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1703008031; x=1703612831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eiwIpb7xuTq5TPRrwpmxnXk+wGzqHEHNo03fDZVsc7I=;
        b=DPqUhByvHwkhPIztuIP+ZkaooDYqBqXQkKL9bf42J6TH0G1MXLHdqk5g0NW5syJiNM
         MZZd+3qXcrhq1fMCi4D2HFR7ILvl5r7WPtOAVrJ1XeUMuVTaXCGsosOYAkPQ4VsFDt3/
         ecQgO5vNjNjNYZCnSBbCE30J5gY7ZRXN0yU4U3y6BeDIN9EX/8vdw56vpHfxc/gGoDJB
         drtKNkS+8hLJN1RsP2Csm0LxiRMt3RzIXHZll+pEdfG0Oh99/8XIQ1zNwVvNEbIcBViE
         LaOJ5B0futn1P3DRy9v3FNmiTemwsppADdCfXj0nLpx01zYxoaM0EeBEvbMQkS/NUkN5
         wnDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703008031; x=1703612831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eiwIpb7xuTq5TPRrwpmxnXk+wGzqHEHNo03fDZVsc7I=;
        b=aCJyGWZ/ZKPAh3knu3Gj4NL3KuH6QhEdocYbw8GY9jmsIQzK89JtGW6BjbkSvABKvq
         9JfqeDS+ZBANYs2oEQfwVPJB8drfMC/I7jMXT/tr+1p/ttYmDR04IQD828rq1zOIZ9UW
         sBrIvk6vP74RjYmJxAyGnj9vzlvyjwMxKLP3VmCfIXoa9oVwnsCW4miO8Q6GBrstRBtT
         Tf9/+clcMs7gtBwXcqz2dno8Noyp4jJZ+gLNlPu2Ec5qL/HGGGiVteqH2CuDOzZDFTmC
         1iA3jmYBjv8cUO2JTdZYSdAk7FusP+wKL5h+2T8Sp/vL82NpgMfJnYbhTWeHnPceW29d
         eApw==
X-Gm-Message-State: AOJu0YykZN89bx7ElC+USvPWc272rI+2drstvZDMNaxRwt8sfwUCJa5q
	XaGnvjKNFkm2PJyss+DwyUk3MQ==
X-Google-Smtp-Source: AGHT+IEpUAW94l/bQ8GlpoYTs7IixfBFrUs4h8FHwGSRGLIfpQTk5UlG5GMDzC6dri1oqSEP3DUUjQ==
X-Received: by 2002:a17:902:ec85:b0:1d3:ab39:abe2 with SMTP id x5-20020a170902ec8500b001d3ab39abe2mr5002223plg.14.1703008030730;
        Tue, 19 Dec 2023 09:47:10 -0800 (PST)
Received: from sunil-pc.Dlink ([106.51.188.200])
        by smtp.gmail.com with ESMTPSA id n16-20020a170903111000b001d3320f6143sm14453015plh.269.2023.12.19.09.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 09:47:10 -0800 (PST)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Haibo Xu <haibo1.xu@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [RFC PATCH v3 17/17] irqchip: riscv-intc: Set ACPI irqmodel
Date: Tue, 19 Dec 2023 23:15:26 +0530
Message-Id: <20231219174526.2235150-18-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231219174526.2235150-1-sunilvl@ventanamicro.com>
References: <20231219174526.2235150-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

INTC being the root interrupt controller, set the ACPI irqmodel with
callback function to get the GSI domain id.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 arch/riscv/include/asm/irq.h     | 13 +------------
 drivers/irqchip/irq-riscv-intc.c |  1 +
 2 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/arch/riscv/include/asm/irq.h b/arch/riscv/include/asm/irq.h
index 7b14f3ebe242..9c2bdf4bd880 100644
--- a/arch/riscv/include/asm/irq.h
+++ b/arch/riscv/include/asm/irq.h
@@ -22,18 +22,7 @@
 #define APLIC_PLIC_ID(x) ((x) >> 24)
 #define IDC_CONTEXT_ID(x) ((x) & 0x0000ffff)
 
-#ifdef CONFIG_RISCV_APLIC
-struct fwnode_handle *aplic_get_gsi_domain_id(u32 gsi);
-#else
-static inline struct fwnode_handle *aplic_get_gsi_domain_id(u32 gsi) { return NULL; }
-#endif
-
-#ifdef CONFIG_SIFIVE_PLIC
-struct fwnode_handle *plic_get_gsi_domain_id(u32 gsi);
-#else
-static inline struct fwnode_handle *plic_get_gsi_domain_id(u32 gsi) { return NULL; }
-#endif
-
+struct fwnode_handle *ext_entc_get_gsi_domain_id(u32 gsi);
 int __init acpi_get_intc_index_hartid(u32 index, unsigned long *hartid);
 int acpi_get_ext_intc_parent_hartid(u8 id, u32 idx, unsigned long *hartid);
 void acpi_get_plic_nr_contexts(u8 id, int *nr_contexts);
diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
index 24bbc5bfc30f..bddfe47df27b 100644
--- a/drivers/irqchip/irq-riscv-intc.c
+++ b/drivers/irqchip/irq-riscv-intc.c
@@ -311,6 +311,7 @@ static int __init riscv_intc_acpi_init(union acpi_subtable_headers *header,
 		return rc;
 	}
 
+	acpi_set_irq_model(ACPI_IRQ_MODEL_RINTC, ext_entc_get_gsi_domain_id);
 	return 0;
 }
 
-- 
2.39.2


