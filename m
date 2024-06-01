Return-Path: <linux-pci+bounces-8161-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF8C8D709B
	for <lists+linux-pci@lfdr.de>; Sat,  1 Jun 2024 17:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF7E01F22E98
	for <lists+linux-pci@lfdr.de>; Sat,  1 Jun 2024 15:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4821527BF;
	Sat,  1 Jun 2024 15:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="KslEvNaR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95375152785
	for <linux-pci@vger.kernel.org>; Sat,  1 Jun 2024 15:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717254291; cv=none; b=X5Y9MNLq/I14w1zy/UHgVn10YYdZZ8E3Vism5ihVemK5InWCfC0QnusWxV0CbOcV+oXohsLjhCeubwNHBDQ7HDvTno7sOnDP6mJQw5qh3PQ6FGTaSLc+kCkjWoeye06FN4zrAsihLR3nnRlSTiihfJ5gHzAEnPLqVvwYhJ1JkPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717254291; c=relaxed/simple;
	bh=w8tlK1a9yLZeLFHvsoySlErb7PynOFkH2SuqLxkF9HM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YDEf1kmwcF+DZf0KfF3TpDT9B1onE2zvFCbwzDinpsUqwoJ8B/qY8j8SbexYI0l29KdsIRmdgJr9Gn9g2bRMK8KG9CYH3XwUI9SyCylCePOD+OqRgCe9ORT1iKcSmnJInfWgxoJjAX0kxEVEUavEqf0xRQnq1itAfPJt/FDHG74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=KslEvNaR; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2c1a9b151bcso2300185a91.3
        for <linux-pci@vger.kernel.org>; Sat, 01 Jun 2024 08:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1717254290; x=1717859090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Jv6JEZTD9c0qG8hE1F4MREKLvC6gRJSU0R0wzEFNGA=;
        b=KslEvNaR0kKYdsI3AxhgEu+Xwg77Z981f5vIwgdYoruzR8XizlBzgbfemKxGK3QTnv
         AActfndcpgN7mGaBih5JGQI9MSecU2XCX0q3f2/HrU7Zz6G+Wvy5gaSPaDpw/Ouikrgi
         lKFcv3SYof9nrffZjCI/yoyiITWRdQfsZiLyZAef/dYIbH4z2OriB5oyZZ38Y2bxCysI
         Dd4WgjkUWOabjepZoQwvg/BT75FBTUUib2E4O2FeyzQCjudl8jJKqdZxqeyuO00xzCg7
         aaCjcHrt3wVV7EkVX9RlFn9ghyinw05Z2x/4DYo1wiQ1AhFAV6vID+aIm99V1MTk5g83
         yzHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717254290; x=1717859090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Jv6JEZTD9c0qG8hE1F4MREKLvC6gRJSU0R0wzEFNGA=;
        b=D647YqSDMQk7WsMSRXmVbtoZeCEmpFuG4CoHDgNekmBP+0332pfDOe5A8t/hJOKXUG
         JNKFq/Cxx0UAPw4nNCGU0iDHXX4b18kLfrogvpqvyqQUBS5ltQYDjxyx3pAIboGWgW9f
         NfUBPeqwMFhh77UwYrgk5RNH36Np5GrFkIUFA+yQ6Mt705hlUi9GGIm9dMSuGy90tp/u
         YpiFqElb+7DoAwl4hsQLA2u4yIV1xr99SbCSgOtZ1H2XS4BheMPI4ASbuyuj2Z2ZKrdU
         WSFDVozE424SBBiXEmW9Uo/sfjBMMA+A/iRiEr/KXBcDRFCkXVT/Y5Aq8EqIqmExqRAc
         vdUA==
X-Forwarded-Encrypted: i=1; AJvYcCXtX81uJlLRVPhgJ+g0H2imm+4W9kBWbVmV1cWWOGQ5WFyZZ5hL4IcqXgGxGs+DFs8De7prPQ5ftpRkwytBaf+aDQBgavkW8H2v
X-Gm-Message-State: AOJu0YyfXQiSqAfahUaKKlLB+RqUYPmUlinPbOwhOpBbPeSz5kr1XO3B
	cbiJdx0LFZ3xjhc3/VYrsBa0KI5JMTd1nbFQWK1ulBjKVlFejMv/WT7cMuFOWqM=
X-Google-Smtp-Source: AGHT+IGJ5D/8YHeQidHdEpKROK/FOw4K97CAfABtSV0CK04hYyLyYdtbkd2DgCCxUap3/7WmNzvvWg==
X-Received: by 2002:a17:90a:9a96:b0:2b1:817d:982b with SMTP id 98e67ed59e1d1-2c1dc5701fbmr4453498a91.14.1717254289850;
        Sat, 01 Jun 2024 08:04:49 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.187.237])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6c35a4ba741sm2559410a12.85.2024.06.01.08.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jun 2024 08:04:49 -0700 (PDT)
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
Subject: [PATCH v6 04/17] ACPI: scan: Refactor dependency creation
Date: Sat,  1 Jun 2024 20:33:58 +0530
Message-Id: <20240601150411.1929783-5-sunilvl@ventanamicro.com>
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

Some architectures like RISC-V will use implicit dependencies like GSI
map to create dependencies between interrupt controller and devices. To
support doing that, the function which creates the dependency, is
refactored bit and made public so that dependency can be added from
outside of scan.c as well.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/acpi/scan.c     | 86 ++++++++++++++++++++++-------------------
 include/acpi/acpi_bus.h |  1 +
 2 files changed, 48 insertions(+), 39 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index b325b297bf77..66038fc731fb 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2004,6 +2004,49 @@ void acpi_scan_hotplug_enabled(struct acpi_hotplug_profile *hotplug, bool val)
 	mutex_unlock(&acpi_scan_lock);
 }
 
+int acpi_scan_add_dep(acpi_handle handle, struct acpi_handle_list *dep_devices)
+{
+	u32 count;
+	int i;
+
+	for (count = 0, i = 0; i < dep_devices->count; i++) {
+		struct acpi_device_info *info;
+		struct acpi_dep_data *dep;
+		bool skip, honor_dep;
+		acpi_status status;
+
+		status = acpi_get_object_info(dep_devices->handles[i], &info);
+		if (ACPI_FAILURE(status)) {
+			acpi_handle_debug(handle, "Error reading _DEP device info\n");
+			continue;
+		}
+
+		skip = acpi_info_matches_ids(info, acpi_ignore_dep_ids);
+		honor_dep = acpi_info_matches_ids(info, acpi_honor_dep_ids);
+		kfree(info);
+
+		if (skip)
+			continue;
+
+		dep = kzalloc(sizeof(*dep), GFP_KERNEL);
+		if (!dep)
+			continue;
+
+		count++;
+
+		dep->supplier = dep_devices->handles[i];
+		dep->consumer = handle;
+		dep->honor_dep = honor_dep;
+
+		mutex_lock(&acpi_dep_list_lock);
+		list_add_tail(&dep->node, &acpi_dep_list);
+		mutex_unlock(&acpi_dep_list_lock);
+	}
+
+	acpi_handle_list_free(dep_devices);
+	return count;
+}
+
 static void acpi_scan_init_hotplug(struct acpi_device *adev)
 {
 	struct acpi_hardware_id *hwid;
@@ -2026,8 +2069,7 @@ static void acpi_scan_init_hotplug(struct acpi_device *adev)
 static u32 acpi_scan_check_dep(acpi_handle handle)
 {
 	struct acpi_handle_list dep_devices;
-	u32 count;
-	int i;
+	u32 count = 0;
 
 	/*
 	 * Check for _HID here to avoid deferring the enumeration of:
@@ -2036,48 +2078,14 @@ static u32 acpi_scan_check_dep(acpi_handle handle)
 	 * Still, checking for _HID catches more then just these cases ...
 	 */
 	if (!acpi_has_method(handle, "_DEP") || !acpi_has_method(handle, "_HID"))
-		return 0;
+		return count;
 
 	if (!acpi_evaluate_reference(handle, "_DEP", NULL, &dep_devices)) {
 		acpi_handle_debug(handle, "Failed to evaluate _DEP.\n");
-		return 0;
+		return count;
 	}
 
-	for (count = 0, i = 0; i < dep_devices.count; i++) {
-		struct acpi_device_info *info;
-		struct acpi_dep_data *dep;
-		bool skip, honor_dep;
-		acpi_status status;
-
-		status = acpi_get_object_info(dep_devices.handles[i], &info);
-		if (ACPI_FAILURE(status)) {
-			acpi_handle_debug(handle, "Error reading _DEP device info\n");
-			continue;
-		}
-
-		skip = acpi_info_matches_ids(info, acpi_ignore_dep_ids);
-		honor_dep = acpi_info_matches_ids(info, acpi_honor_dep_ids);
-		kfree(info);
-
-		if (skip)
-			continue;
-
-		dep = kzalloc(sizeof(*dep), GFP_KERNEL);
-		if (!dep)
-			continue;
-
-		count++;
-
-		dep->supplier = dep_devices.handles[i];
-		dep->consumer = handle;
-		dep->honor_dep = honor_dep;
-
-		mutex_lock(&acpi_dep_list_lock);
-		list_add_tail(&dep->node , &acpi_dep_list);
-		mutex_unlock(&acpi_dep_list_lock);
-	}
-
-	acpi_handle_list_free(&dep_devices);
+	count += acpi_scan_add_dep(handle, &dep_devices);
 	return count;
 }
 
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 1a4dfd7a1c4a..28a9b87c23fa 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -993,6 +993,7 @@ static inline void acpi_put_acpi_dev(struct acpi_device *adev)
 
 int acpi_wait_for_acpi_ipmi(void);
 
+int acpi_scan_add_dep(acpi_handle handle, struct acpi_handle_list *dep_devices);
 #else	/* CONFIG_ACPI */
 
 static inline int register_acpi_bus_type(void *bus) { return 0; }
-- 
2.40.1


