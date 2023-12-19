Return-Path: <linux-pci+bounces-1179-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FF2818E8B
	for <lists+linux-pci@lfdr.de>; Tue, 19 Dec 2023 18:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7D71287914
	for <lists+linux-pci@lfdr.de>; Tue, 19 Dec 2023 17:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF0537D10;
	Tue, 19 Dec 2023 17:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="fN0YXFY+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137F039AED
	for <linux-pci@vger.kernel.org>; Tue, 19 Dec 2023 17:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6d3cb1ccccbso1898776b3a.0
        for <linux-pci@vger.kernel.org>; Tue, 19 Dec 2023 09:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1703007974; x=1703612774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wXn1vXDcIcY9aE9ZluWKdogaSHoQIJLjYHgL6fRVi5k=;
        b=fN0YXFY+gKPhiZ28irmQajOEihnMc2/x/Tb8coMkWVkhcvzCYaAqElbcdFrydToIxB
         jhtUFiv9wKlfT3L/g+An+Sb3ZKwLSCGcQ8PsFoSVeV0C81+XtOgdMCIvXUHph8l8FOxI
         IncCGyZZXZGpDL/lqgeYBq6ubejtYR8AceNniMAXBjJZwExKxlXKzHsTuK6RapdIHJD0
         K/bU14mD+vslgXgse2YkFiexegHQN/rVX7JzNSf8lTVqC576BMG4/St5tKzeBNTd9Ary
         Nf9LN9e60ksjQNs0viggAeb+KmhubBlOvim677CS8cALprD6z3xcv63WX/3EFkUROwMS
         lFHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703007974; x=1703612774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wXn1vXDcIcY9aE9ZluWKdogaSHoQIJLjYHgL6fRVi5k=;
        b=TaXQt5SaJShKMoN5BldUpR5luWYfvihQBtF3bCyGrG/nHvzJl0EqJXskTw+dMIXBoM
         c37QxWRuiOYTYMzbEmu6Fr3P8ZLLIT8VKtTR5ut5Agz8ibKfivNzi666AqNA/5oGmTWi
         FeM8BefE2ODFcJ93mvlp7MtgjqbA/1KGAMxQXktR+TGMhC6H3foohur0lR/3tHEOZ1M5
         hmORdPd1RTQkVKQpAimRajNjsshhm5fu2Q+/rOV7t6pABJCzvzAqxdVtGJX5kPdZc11h
         hwRO5OlpnEUD445RccLahrIXKr1Owz7t1LFFYxhnFFr56lSkg9YiuUlCvFExy8gYier2
         bGWw==
X-Gm-Message-State: AOJu0YysFDc3QND1Wy2IJnJTSCAQ0jqSXFTkMOS5garfcEdiqGmHZGG4
	/vqzy+5EJtSeCt0cxFLuiBnUMg==
X-Google-Smtp-Source: AGHT+IEyMcGZ8gZDustI/NrEk9p7KXDerpeWb1pADnYIYBEjwIh1UqME5pxQY3avzxvrA+zMIvUqTw==
X-Received: by 2002:a17:902:ab84:b0:1d0:6ffe:1e6d with SMTP id f4-20020a170902ab8400b001d06ffe1e6dmr8678824plr.80.1703007974481;
        Tue, 19 Dec 2023 09:46:14 -0800 (PST)
Received: from sunil-pc.Dlink ([106.51.188.200])
        by smtp.gmail.com with ESMTPSA id n16-20020a170903111000b001d3320f6143sm14453015plh.269.2023.12.19.09.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 09:46:14 -0800 (PST)
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
Subject: [RFC PATCH v3 07/17] ACPI: scan.c: Add weak arch specific function to reorder the IRQCHIP probe
Date: Tue, 19 Dec 2023 23:15:16 +0530
Message-Id: <20231219174526.2235150-8-sunilvl@ventanamicro.com>
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

Unlike OF framework, the irqchip probe using IRQCHIP_ACPI_DECLARE has no
order defined. Depending on the driver Makefile is not a good idea. So,
usually it is worked around by mandating only root interrupt controller
probed using IRQCHIP_ACPI_DECLARE and other interrupt controllers are
probed via cascade mechanism.

However, this is also not a clean solution because if there are multiple
root controllers (ex: RINTC in RISC-V which is per CPU) which need to be
probed first, then the cascade will happen for every root controller.
So, introduce a architecture specific weak function to order the probing
of the interrupt controllers which can be implemented by different
architectures as per their interrupt controller hierarchy.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/acpi/scan.c  | 3 +++
 include/linux/acpi.h | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 691d4b7686ee..87f4baebd497 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2685,6 +2685,8 @@ static int __init acpi_match_madt(union acpi_subtable_headers *header,
 	return 0;
 }
 
+void __weak arch_sort_irqchip_probe(struct acpi_probe_entry *ap_head, int nr) { }
+
 int __init __acpi_probe_device_table(struct acpi_probe_entry *ap_head, int nr)
 {
 	int count = 0;
@@ -2693,6 +2695,7 @@ int __init __acpi_probe_device_table(struct acpi_probe_entry *ap_head, int nr)
 		return 0;
 
 	mutex_lock(&acpi_probe_mutex);
+	arch_sort_irqchip_probe(ap_head, nr);
 	for (ape = ap_head; nr; ape++, nr--) {
 		if (ACPI_COMPARE_NAMESEG(ACPI_SIG_MADT, ape->id)) {
 			acpi_probe_count = 0;
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index e9a9659314f2..ae045e14126b 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1338,6 +1338,8 @@ struct acpi_probe_entry {
 	kernel_ulong_t driver_data;
 };
 
+void arch_sort_irqchip_probe(struct acpi_probe_entry *ap_head, int nr);
+
 #define ACPI_DECLARE_PROBE_ENTRY(table, name, table_id, subtable,	\
 				 valid, data, fn)			\
 	static const struct acpi_probe_entry __acpi_probe_##name	\
-- 
2.39.2


