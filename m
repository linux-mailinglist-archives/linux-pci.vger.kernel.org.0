Return-Path: <linux-pci+bounces-6265-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8868B8A5879
	for <lists+linux-pci@lfdr.de>; Mon, 15 Apr 2024 19:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E168EB24214
	for <lists+linux-pci@lfdr.de>; Mon, 15 Apr 2024 17:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69DB84A32;
	Mon, 15 Apr 2024 17:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="g8VaR1/m"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA6B86655
	for <linux-pci@vger.kernel.org>; Mon, 15 Apr 2024 17:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713200538; cv=none; b=n0jAsQmK6QMe4zEErWF+Ng3mlTnYetXH7/l/add8+O9uUS3QssYx8CB7r3nWdiImBuBJ1q2boFJ4h0qPiaJ3ICX1DLiqmt1w9mC7wM7DPDape4kNoUOwUOr7aBt+K8bFYu+7GKb3LxzLtaG8Ig28xvBLfZM8X5kIq4JiLZkdcOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713200538; c=relaxed/simple;
	bh=2Gz5QkDmnr7hC62yIyTV6F1j/bp+6gUwdzqqwho4EiY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aYMNuMoWs7AMRGK9kr4q2XXPxsdmaxwupG2XFt0VMS9FmrjCrIQD8e+lP6x29eSfsM2crn4k0m0FkWsU0eHA2d3qhsluojsR5iXeSr/bERlpNOAet5k0L262QH7nM18rtmGGDro9HGMlUEtTo1Lhm9z5P+6GArQRyKa3xTkOrDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=g8VaR1/m; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6effe9c852eso927696b3a.3
        for <linux-pci@vger.kernel.org>; Mon, 15 Apr 2024 10:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1713200537; x=1713805337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wQjMcgzCCX1zvyyhnfJhjMc7UuQWOWfTm7mVOWGolO4=;
        b=g8VaR1/m3IE/227Bo+gzhO/WkqQiWRT+aN5TF6XOdmS0ACj8BJfeGXzAvjNJkWUeRh
         WihRMp590qQS3MpkgRKqdwavMDkkz0HIHFioE9TgjFtCR0VypVzIejirZ3AQJSgm5fY0
         gEXGMz5A8FrhDEQO2+YPVlyjg2pMJthxpkgaEsvbxobMy2oqgMVu5tz0mLu/Ue+/ntfv
         GX7OkZvx/8uyJsT+oxuNI7kC3VjR6L1U2YRFAfA8IP+OVTmm7XeTQ0k64aalN+EZCftL
         FERWHQlSfdrPazQXuuwRQO4jcMPLOk7N8tcQiFE562urEdoA9KneK1UlKO8sxU2RHL9j
         8Gbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713200537; x=1713805337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wQjMcgzCCX1zvyyhnfJhjMc7UuQWOWfTm7mVOWGolO4=;
        b=uNk8TryBqo9vefSPzS31EdPZoEuzhLwXuFI1HtTCnfwss+aIFQV8u8MwgitsD75i8W
         UbK8/u+3dm87fb5LE3DfLKoGIL3pHvbD6LMgxSWbShuxjeGZ/o7e9m2Swba5KL+ESfey
         xJpMWvml5gE7iHv9uvC7qLan5EXB8ZMDl7EGGgbnOAzAef8RKhkIxm3u+JcV5MZ5tiOp
         M1e4+x5WGE0XxZSGVuitowNs4rWwAcBo6EFYgeCT7fc33f7EvXLIGrz6AjODD7svhTdf
         PIyqMVOI2aVvSb8c9URuYas4mkR/IQmQMgl+dTy4EFa1xA27DekiVH/4ZxaqSf3jLARj
         X+rw==
X-Forwarded-Encrypted: i=1; AJvYcCXeQ+uKihoJCswEDDzin+kc/vxtARAMelyN6DouaRNezpLmC9Qm58ZNlz1WWsPO3d3aNoGbU18jMG574FBUBlFR/qwsyM4K7Q9H
X-Gm-Message-State: AOJu0Yz4WCHl3mbKuLaPUG3z+1legxfW8Um4Y5KBp43r3L4LIgsdmLyA
	BglzNhz93gyuQ2LCfXvLjmJWVHxoxDUhennKovOzZg86oztPDmfdKWSu3nBpROE=
X-Google-Smtp-Source: AGHT+IEOKdv2GIoPVzAfszA+Mczkslu8VP2JvMat3iDp2rWUvNRo9ufo+FIpILZ6uWBafbyo9KluZw==
X-Received: by 2002:a05:6a00:2314:b0:6ec:cec1:8fe3 with SMTP id h20-20020a056a00231400b006eccec18fe3mr10562037pfh.11.1713200536823;
        Mon, 15 Apr 2024 10:02:16 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.187.230])
        by smtp.gmail.com with ESMTPSA id 1-20020a056a00072100b006ed045e3a70sm7433158pfm.25.2024.04.15.10.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 10:02:16 -0700 (PDT)
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
Subject: [RFC PATCH v4 08/20] ACPI: scan: Refactor dependency creation
Date: Mon, 15 Apr 2024 22:31:01 +0530
Message-Id: <20240415170113.662318-9-sunilvl@ventanamicro.com>
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

Some architectures like RISC-V will use implicit dependencies like GSI
map to create dependencies between interrupt controller and devices. To
support doing that, the function which creates the dependency, is
refactored bit and made public so that dependency can be added from
outside of scan.c as well.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/acpi/scan.c     | 48 ++++++++++++++++++++++++-----------------
 include/acpi/acpi_bus.h |  1 +
 2 files changed, 29 insertions(+), 20 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index de30a0af7a2f..c8f40d81b6cb 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2028,33 +2028,18 @@ static void acpi_scan_init_hotplug(struct acpi_device *adev)
 	}
 }
 
-static u32 acpi_scan_check_dep(acpi_handle handle)
+int acpi_scan_add_dep(acpi_handle handle, struct acpi_handle_list *dep_devices)
 {
-	struct acpi_handle_list dep_devices;
 	u32 count;
 	int i;
 
-	/*
-	 * Check for _HID here to avoid deferring the enumeration of:
-	 * 1. PCI devices.
-	 * 2. ACPI nodes describing USB ports.
-	 * Still, checking for _HID catches more then just these cases ...
-	 */
-	if (!acpi_has_method(handle, "_DEP") || !acpi_has_method(handle, "_HID"))
-		return 0;
-
-	if (!acpi_evaluate_reference(handle, "_DEP", NULL, &dep_devices)) {
-		acpi_handle_debug(handle, "Failed to evaluate _DEP.\n");
-		return 0;
-	}
-
-	for (count = 0, i = 0; i < dep_devices.count; i++) {
+	for (count = 0, i = 0; i < dep_devices->count; i++) {
 		struct acpi_device_info *info;
 		struct acpi_dep_data *dep;
 		bool skip, honor_dep;
 		acpi_status status;
 
-		status = acpi_get_object_info(dep_devices.handles[i], &info);
+		status = acpi_get_object_info(dep_devices->handles[i], &info);
 		if (ACPI_FAILURE(status)) {
 			acpi_handle_debug(handle, "Error reading _DEP device info\n");
 			continue;
@@ -2073,7 +2058,7 @@ static u32 acpi_scan_check_dep(acpi_handle handle)
 
 		count++;
 
-		dep->supplier = dep_devices.handles[i];
+		dep->supplier = dep_devices->handles[i];
 		dep->consumer = handle;
 		dep->honor_dep = honor_dep;
 
@@ -2082,7 +2067,30 @@ static u32 acpi_scan_check_dep(acpi_handle handle)
 		mutex_unlock(&acpi_dep_list_lock);
 	}
 
-	acpi_handle_list_free(&dep_devices);
+	acpi_handle_list_free(dep_devices);
+	return count;
+}
+
+static u32 acpi_scan_check_dep(acpi_handle handle)
+{
+	struct acpi_handle_list dep_devices;
+	u32 count = 0;
+
+	/*
+	 * Check for _HID here to avoid deferring the enumeration of:
+	 * 1. PCI devices.
+	 * 2. ACPI nodes describing USB ports.
+	 * Still, checking for _HID catches more then just these cases ...
+	 */
+	if (!acpi_has_method(handle, "_DEP") || !acpi_has_method(handle, "_HID"))
+		return count;
+
+	if (!acpi_evaluate_reference(handle, "_DEP", NULL, &dep_devices)) {
+		acpi_handle_debug(handle, "Failed to evaluate _DEP.\n");
+		return count;
+	}
+
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


