Return-Path: <linux-pci+bounces-8165-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 499A78D70A9
	for <lists+linux-pci@lfdr.de>; Sat,  1 Jun 2024 17:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDD131F23DD6
	for <lists+linux-pci@lfdr.de>; Sat,  1 Jun 2024 15:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35658153504;
	Sat,  1 Jun 2024 15:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="BBBbQ44E"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AE7152783
	for <linux-pci@vger.kernel.org>; Sat,  1 Jun 2024 15:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717254320; cv=none; b=oUrq+TqZS9g+vMGVWuDKPC404subCY1ELj5EboSK47kEJALlwMrLWpcD8KrV4aoJHBx/vKds1zQM1PyPzqi8C19CP52huCYYK39/iFXpFqCS43wPDAj1QTxeKtAGhtsPSzDhIOu/3SlHpsqwWa75gq4bBxjMbO3N74wWcTo+1JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717254320; c=relaxed/simple;
	bh=W0OyoZZELdi3XoEeDkVWUSqd7/veUNR99vJr5QS1Ml4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zj2hOM7WIWvVfGcamEsnZhXvpoPW2tg27T9PZLLnEVYK8sZL7wd36etSawFPOr6VZYBILvPALgIBeV+qzvDUnul5mFNF13QgWe3YY9LsLt10qGGwWCD/TZDrZInAr9+2YCIpOQuch3gqkXDKzNV5uO/QAV1ldju+nMdxaSE6ohI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=BBBbQ44E; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3748d68b7b8so6699715ab.1
        for <linux-pci@vger.kernel.org>; Sat, 01 Jun 2024 08:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1717254318; x=1717859118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xln7tORKkifGXhXo2mks++Fmg8FnhH/zBNmrN9CYLQo=;
        b=BBBbQ44EhKJlAEZX1vP2lnI4YaNZsvpym9ajQvc8XbakKS0jNtInMBSr7SEw0Ulhx9
         LplchPBhUaYXkb3cxGAcnZYodC7ZK3wyyF7ZKUbX0zUgtageYczPHWd0TLTqTOjLF4ou
         OHuTI1FEuaExMX+cRQhqfORaFOu0BktQOwoWq2djKiPvMfyeuDUl7Yf2gxR5ClqbQmZP
         8ABTFCvSUn7411sCWThf+A6Ezawxpv632d5aiaXVxHMNj3Gl+nEopUB+5OsBw4/oPkhY
         hh7wQvEHoblnKMugUX0rcM1SJgrDQXctt0k9zX2YseOK+/zETkvkDfGcCLZ6hrrCj7WL
         8VRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717254318; x=1717859118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xln7tORKkifGXhXo2mks++Fmg8FnhH/zBNmrN9CYLQo=;
        b=CHC/FBL8BOIT/6AaZvtBrEjWzJ9fibcfJHrQQEk+q/jrfq7epLBenK2OerP3y+mudU
         rXwmMa6hTgAi7BGxuCc9qhjuw/LOAWPcy53yA6y1e03nLmRZoUu1ZrO/ClAqXqo+dWwA
         LyEkYAh7ImOtYPxmxWxQh+YNUfYJAM3kFkQhPwX0X5PnFPCuM8ULZd0cY9AJZPhPGh9N
         BnPgrOwiYruK9yKu2e3SGOE2VzQnsEVTl1iqImiOIFblLBmymdigLLnedMyXSnxqmYXd
         E77DqAb9L6u9Ku3UimZ3aDpoLFNM+/pm9JrokWdbF/GNg8AqgijFafYCRcGpFd9cAPsE
         F26A==
X-Forwarded-Encrypted: i=1; AJvYcCUSQG6QcTjVUYNHS8J+m3uijD6SQHwR03jqK1kcU7PX40KPwPLRwUPZ4qosmWcu7QmPgqXeAw6JVPATxnHpbOTo1k8flBap+37u
X-Gm-Message-State: AOJu0YyzdSdjGdRXiw6iAbhU6KRHVd/uQOAL9uIPj6+1Jghy59t+NPR2
	OkoX8KbjhDTjo9r+iQqsMRAP+Pa5mGcXQZ9sE+10po7cYkWVV/A2T0iDOTAjm5M=
X-Google-Smtp-Source: AGHT+IGwBTAKeY5fhp4d/uHQX4CpW74WCuXLPUcacrekwQIOgiTzG+e+uX/rDZRV2vhHKygHe3+bDg==
X-Received: by 2002:a05:6e02:198a:b0:374:5641:bb8f with SMTP id e9e14a558f8ab-3748b9dd6a4mr60478395ab.27.1717254317893;
        Sat, 01 Jun 2024 08:05:17 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.187.237])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6c35a4ba741sm2559410a12.85.2024.06.01.08.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jun 2024 08:05:17 -0700 (PDT)
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
Subject: [PATCH v6 08/17] ACPI: pci_link: Clear the dependencies after probe
Date: Sat,  1 Jun 2024 20:34:02 +0530
Message-Id: <20240601150411.1929783-9-sunilvl@ventanamicro.com>
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
index 918e71fc54cb..0280056a326b 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -834,6 +834,7 @@ static const char * const acpi_honor_dep_ids[] = {
 	"INTC10CF", /* IVSC (MTL) driver must be loaded to allow i2c access to camera sensors */
 	"RSCV0001", /* RISC-V PLIC */
 	"RSCV0002", /* RISC-V APLIC */
+	"PNP0C0F",  /* PCI Link Device */
 	NULL
 };
 
-- 
2.40.1


