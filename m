Return-Path: <linux-pci+bounces-10954-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8F393F7F9
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2024 16:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB80C1C21F9C
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2024 14:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E80C15B546;
	Mon, 29 Jul 2024 14:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="O3hMCUdp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB1615F402
	for <linux-pci@vger.kernel.org>; Mon, 29 Jul 2024 14:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722262988; cv=none; b=kdwlz8sdpBw1hKKlA6/Djcg8q9x8CD8lNA5Tt33Ma2muC/BniyPrnnIqlgiaZMpcB9ZGKQvhTnTHx2TsjqiE3hpipPj4pKX6FHSbG8peRDeVrMMBR4m3UWkfc4/kJlIA+zR5E6wmi5u9VB64uK8d5Vsz7b+rlmjRysM5yf7ZL6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722262988; c=relaxed/simple;
	bh=dIAC5ACjszKWc4p8Ai+3npuM+9XIxGXpMSvp0kw9aIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cEg/nZjuo4MaU4Qvn3wPBwUratj+QfDbp6qUL3x4u5yiHhWBxjLsXBH6V7Uau2HT3arrHtpQCU8H8q6DbEGJjf294HkyFv0itXg5ops0jbnnHUqZjge636Nx/bCgqUMU18PRTsPauqB179odeozI/TIlLbWhr9nRrDH381qFYLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=O3hMCUdp; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fc66fc35f2so19359665ad.0
        for <linux-pci@vger.kernel.org>; Mon, 29 Jul 2024 07:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1722262986; x=1722867786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1v7P8DgVWEOiQraKJZCp7Th7levU77nqOCGgGfYFy3k=;
        b=O3hMCUdp+5sEdNHT6tV4YjWbFZN93Ltj3VUd0YhCVu6egiGxVaaWNKV/+S76CeyAiJ
         uNQQWz0SBQO8wkk/C5moGSSQP6m1862sjIvMqJE0kwHvJtWV88AVTm/WemL1c62vEsC3
         MGzQtWvw8mFMSN0H7sUuFxHOSZQX7fRGOPHhk4vLFFtfyTn5Cjx/7UHKfH0GS0xSighV
         mjE2JL1Iq2csGdMuyMwSxIkjYWiPE/KCpezECmqNDm3UvXEVzqAKC69LixadXpYrIWC5
         9zmEei+V0TBxNc9QiVF+oYrSBlda2cF5mN9NVv8aPBWeVR5UT4ypj4EYR4WRdrPlaGZq
         +0bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722262986; x=1722867786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1v7P8DgVWEOiQraKJZCp7Th7levU77nqOCGgGfYFy3k=;
        b=nmTyZFF8qlBYQ6JLCoFxNTizXM9DziS9k90FQHWdD2DiGEmj4S3uQTtcfi4zHOjJcS
         vDXALwP2qsXi12e/YDtF4uyxHPgNXwihK525G9gUvlQ+7K+tByEsmtpYGtC0BThZ/ha7
         cfdcQkhAlsQzOw5zJhc7M0Bs5BjKkPsVf15H2ned3R1whgCmKoyfjrQ0zc8EcpEM3XPX
         Iyak/hB4lakv+OT4JX5KvGT4ocHjxpknsofFGkI2SNZaLUa+p09ebsWhXhixlQ8LKLqh
         5Q5TrcvSLbUsz89BzzDv2AInN06EGE6Uqn/S8oBjq4plLophFfvOsM+FeJ6PIEnv/Sv7
         nEQg==
X-Forwarded-Encrypted: i=1; AJvYcCXsFl2/6z+VcaRiqiGdi28VNADOIXfq6u3SlStwlngNfTDwt6F0tn8THqFQprV+ueZW7aC0FzpOKeSUBOz2STn1hokqXHM4lXUU
X-Gm-Message-State: AOJu0Yz8OWPxWYwFhZml06IBwFTSmMWyYSXlLWwLPw4PlGT+qPern4zz
	W8tcUQIL4BDYahvFcM4Io8KYuObsOV6PncM0Ayivpa4LXvyGVa4wlxEKRYxa4jU=
X-Google-Smtp-Source: AGHT+IH0i4SJoksic7K7uCsgqP3M+9IpULgJ5o8eJTMb+FKn2Lo8UBe751+qjL2E7UCdZzZIpyOlyw==
X-Received: by 2002:a17:902:d4c8:b0:1fd:6f24:efad with SMTP id d9443c01a7336-1ff04b01aebmr124703345ad.26.1722262986279;
        Mon, 29 Jul 2024 07:23:06 -0700 (PDT)
Received: from sunil-pc.tail07344b.ts.net ([106.51.198.16])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7fa988dsm83512965ad.263.2024.07.29.07.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 07:23:05 -0700 (PDT)
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
Subject: [PATCH v7 02/17] ACPI: scan: Add a weak function to reorder the IRQCHIP probe
Date: Mon, 29 Jul 2024 19:52:24 +0530
Message-ID: <20240729142241.733357-3-sunilvl@ventanamicro.com>
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

Unlike OF framework, the irqchip probe using IRQCHIP_ACPI_DECLARE has no
order defined. Depending on the Makefile is not a good idea. So,
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
index 59771412686b..52a9dfc8e18c 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2755,6 +2755,8 @@ static int __init acpi_match_madt(union acpi_subtable_headers *header,
 	return 0;
 }
 
+void __weak arch_sort_irqchip_probe(struct acpi_probe_entry *ap_head, int nr) { }
+
 int __init __acpi_probe_device_table(struct acpi_probe_entry *ap_head, int nr)
 {
 	int count = 0;
@@ -2763,6 +2765,7 @@ int __init __acpi_probe_device_table(struct acpi_probe_entry *ap_head, int nr)
 		return 0;
 
 	mutex_lock(&acpi_probe_mutex);
+	arch_sort_irqchip_probe(ap_head, nr);
 	for (ape = ap_head; nr; ape++, nr--) {
 		if (ACPI_COMPARE_NAMESEG(ACPI_SIG_MADT, ape->id)) {
 			acpi_probe_count = 0;
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 0687a442fec7..3fff86f95c2f 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1343,6 +1343,8 @@ struct acpi_probe_entry {
 	kernel_ulong_t driver_data;
 };
 
+void arch_sort_irqchip_probe(struct acpi_probe_entry *ap_head, int nr);
+
 #define ACPI_DECLARE_PROBE_ENTRY(table, name, table_id, subtable,	\
 				 valid, data, fn)			\
 	static const struct acpi_probe_entry __acpi_probe_##name	\
-- 
2.43.0


