Return-Path: <linux-pci+bounces-10960-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B12A93F80E
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2024 16:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA1781F2188A
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2024 14:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3233615EFA0;
	Mon, 29 Jul 2024 14:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="kC+ig75z"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC69C190678
	for <linux-pci@vger.kernel.org>; Mon, 29 Jul 2024 14:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722263022; cv=none; b=o8xUqF3ABw5zGr70kDGRNjD2kUAb6vPAItBZmyJN6qY2IIICXr8xa0Yw3b8aKbXKgujsIKnMrMVCZqSdhNY5j8NnxQGGcLgI6gM+lwFeir9Z8CNt1xAoctYmYnyO9LHgVvmtBMKvihP+G4YHrPcKxGWnHJTZ/qH7TD8BryxFU1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722263022; c=relaxed/simple;
	bh=clij5LMJhAkONXrZiTSgfsNtHRNuVw9zPAYSRnbzf08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aMPSYBOlBnLGyI5fFTtgn/HnM3fQW5Wbz3ACZVSTRLcBolbMzsUFHO429yBYnEEqzJt+sp24OcLmr3ZnPynkHYfllGs3MlFFDX0oHBTzNQYdoMTKYnPs8bHHQiRae2a6X+w8tTcql9XwCVk9ImNVeqK5BBGdmK0lm8VHoE7O5Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=kC+ig75z; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fc491f9b55so22353505ad.3
        for <linux-pci@vger.kernel.org>; Mon, 29 Jul 2024 07:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1722263020; x=1722867820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SFDunmtzDxNSJrEf+jYEf48MjjKh1U2DF8SfSHqhi3s=;
        b=kC+ig75zr9kQ6wgvHx8coZNoz+ThRIKd7bC8Mmb+UDrie+D5uoI5UsVP1QcxdumVnn
         K6t/W5c+qgzoAPOoB+w2LDDc6VmkakQGx0sHjv0QXQ9zQtiDe0Jker6YDq2ANH0mqvjY
         /lSq2Vin8BFgynt9dEXKDHIb3tgnl1oDqm7p/UuBX/tq/DNts6qiCdW10dZ20KVWpxhD
         lgri9u5YNrd0oC+BCKmcbrDxKmFo4u2BdQ3k848kRSdnc0Yqylk7LCv+0nKATcKRtDLf
         B3jzryaxAMH7GXigiR9c5facqWQfQkFIJEM4g9ZtExaq/1uLHSE/aWWZvFd2/od+IFDv
         h/yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722263020; x=1722867820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SFDunmtzDxNSJrEf+jYEf48MjjKh1U2DF8SfSHqhi3s=;
        b=sDsK9djiKu+d6jgx8O9IRHmcLH42YF48fS4BLLg+QxDWoXV5yb4C0vQxWBPJMEcIT8
         meECCAomv4RT+AThGYSZ7Rra8h9HJMSaibl1WGXmiUG50PhXHqOIp9qJ/FZi6lUGE5hd
         GINIX5J7tKRzfI1zu8e5JB6homF848NdrHj8UFwLbSGGfcjpeuyLwa9t/SWnuZTBpmfu
         hDMXas5g8luZ/f+ZqfXNAANOFFBVIuGX0KJC+UuxhJqQa5LE3jobN2Mb4SXTcef2g9lZ
         hQB49VZP6hisvDyXG1V/0pw8SEuAs5UGPdA/Cb4bb2uI8uTS0Ju0j21ppSu1Hj3xuvik
         eALg==
X-Forwarded-Encrypted: i=1; AJvYcCVeCcnYnoGb2ZqXG49SjsEzQM/nLJ3svWZgOe3GqwNW6+qymtpFvXCP/OddSz0IgfkJB7Tjd46hh8KrgtgVZ1E/5d7A7fjLp+D4
X-Gm-Message-State: AOJu0Yxd27iGUrWvz7zmdg7UnirSwGYc4JbzwkSdIqEy5UvecGDouJ40
	7TUVYlKBca6EQjwbCsGNGIkVCEGe+Ujo5M1AcWU6N0pNT1WOAeuYn0igV66I0GM=
X-Google-Smtp-Source: AGHT+IGU3odbD3sPqAp4C/YNgby17mm2kU5A273xs06JOeimMLExymMBUikKyGUV8C6cXEETPaqERA==
X-Received: by 2002:a17:902:e84a:b0:1fb:82f5:6641 with SMTP id d9443c01a7336-1ff0481bb94mr68486545ad.23.1722263020193;
        Mon, 29 Jul 2024 07:23:40 -0700 (PDT)
Received: from sunil-pc.tail07344b.ts.net ([106.51.198.16])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7fa988dsm83512965ad.263.2024.07.29.07.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 07:23:39 -0700 (PDT)
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
Subject: [PATCH v7 08/17] ACPI: pci_link: Clear the dependencies after probe
Date: Mon, 29 Jul 2024 19:52:30 +0530
Message-ID: <20240729142241.733357-9-sunilvl@ventanamicro.com>
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

RISC-V platforms need to use dependencies between PCI host bridge, Link
devices and the interrupt controllers to ensure probe order. The
dependency is like below.

Interrupt controller <-- Link Device <-- PCI Host bridge.

If there is no dependency added between Link device and PCI Host Bridge,
then the PCI end points can get probed prior to link device, unable to
get mapping for INTx.

So, add the link device's HID to dependency honor list and also clear it
after its probe.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/acpi/pci_link.c | 2 ++
 drivers/acpi/scan.c     | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index aa1038b8aec4..b727db968f33 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -748,6 +748,8 @@ static int acpi_pci_link_add(struct acpi_device *device,
 	if (result)
 		kfree(link);
 
+	acpi_dev_clear_dependencies(device);
+
 	return result < 0 ? result : 1;
 }
 
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 28a221f956d7..753539a1f26b 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -863,6 +863,7 @@ static const char * const acpi_honor_dep_ids[] = {
 	"INTC10CF", /* IVSC (MTL) driver must be loaded to allow i2c access to camera sensors */
 	"RSCV0001", /* RISC-V PLIC */
 	"RSCV0002", /* RISC-V APLIC */
+	"PNP0C0F",  /* PCI Link Device */
 	NULL
 };
 
-- 
2.43.0


