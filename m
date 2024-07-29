Return-Path: <linux-pci+bounces-10956-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5B893F805
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2024 16:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97C601F229F1
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2024 14:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B532D15D5A1;
	Mon, 29 Jul 2024 14:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="NDPSipNI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D362190058
	for <linux-pci@vger.kernel.org>; Mon, 29 Jul 2024 14:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722262999; cv=none; b=FEXqrDD76T4PKTJb422TjWVMOQ9E/et48R2pNzHAuDQXIwf3M1aIkNNo2Sk7ljl0Og3hCR072LgCoWG0F/5mDvT9a5BfDHOkU57cLJTvfxD/gLvhxNDcmkKYswm93xSDF7Ltg+bhDeQqOi9NaZ8UUWheQCClGpnmtpeEA5PJfvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722262999; c=relaxed/simple;
	bh=gYe8Acoq1pYfCPuSY82IUXZ3f3Ne+bwOq2e9EgeJCLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X+gLEQIqqnAeOZuTJ24alK1bfvnjIbIKtxwBhUXiYTmruyWlDxLbwh73FkOSgJDvt76XTot5gBinHOV1ScvaOMUuzo6TrE9wsp+tKFkWmaYyTVp6++nSKAKTdGluBVWvxTQ7Qi1/L0MmNMHBcaDgom/uSe2C9dqmADMYkWzDv6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=NDPSipNI; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1fc60c3ead4so18740185ad.0
        for <linux-pci@vger.kernel.org>; Mon, 29 Jul 2024 07:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1722262998; x=1722867798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sQDYeCPMpR4X4S963fAEbe/mK838iVz52tFUEQviIac=;
        b=NDPSipNICF5gageMHOUZtWdPCli2tHzAKszMpbnEixrl48hxBfMhpZdUZ1m3XUV7dt
         tmMNb09uFZLwsp8L1+fPOxL7Juc+BZPzRsVDrGsH49eH41VwLS+lloknFpBCSkxi6Ei0
         Sx1bUFfl1eDrbp5kogU+bx/wyVQyJME7xri2eFtcQGDUZ6VOKnAJOsmgae52d9usw9UD
         kh+TDfDEMFav+A2ux6dCrEDqkfS8KmHZcI6tDDnj3Tux+utMqWBvFE1aZqXEmNnFwiCT
         tRvuH9Noyc0Sh+uuagC/pNJUD9E3/yaBsnxV04EWS+pT9VevxVv+J8lfAr1uE0HrZ9zc
         Vp3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722262998; x=1722867798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sQDYeCPMpR4X4S963fAEbe/mK838iVz52tFUEQviIac=;
        b=myxAB4jipIe4NTNtCE0G6Vbv6L6p9R8WsVUvr2E26Yx8+R5McF7GioRDOHNfIBpq8N
         //QFxyZ9wDIYVDEX3azJJ3MSXRFaFJbRgO3BclAHFNYVmLCcfqjuUX90M2PJsJul6vcF
         0cpiS6n0mjgxvXxbEbHVtDvu7PTQzCBMxq6GG779oWS+zX2o08WmWNjPQfkwiSTQ/Pmb
         75sXmpiF1YapkhhDYV6GYasCy7wrU2CvsWf7Fc9CAwKCUX9MA+uhYqqFXVSvTANoR6lg
         JKYANdx8LEe7SCBbmBO0sPVYrvquaM5i6iOKesXWGhbpzYUzazKuSEZlHP3devrZ0JWx
         jkZA==
X-Forwarded-Encrypted: i=1; AJvYcCXRE+ctVW0Q/m96cXWHRZwMRFRA70xAqtYcHzRuL3EnY3grFnQp/18efmO8Cd4goEnZNeZ/1LUdEnvM4BxcocX00dRQL5vAzB3j
X-Gm-Message-State: AOJu0YzEpSKRqZ1TbcWklEUf2/P3oWA+CxKufOz3xnVvHR5YbkTtx+G2
	ulkbcSYM6MWfo6pHY5eCDiK13hpS0c4mz4oe6gaLltcXiB0dGTUaUQND2j33a1s=
X-Google-Smtp-Source: AGHT+IHRfKhuOi58y2gNq6JrnPRM6LI4wl21FmFrPGpsAor4rfs3r540grBj2gDL5SzyBewH4Ncnbw==
X-Received: by 2002:a17:903:189:b0:1fc:4197:d786 with SMTP id d9443c01a7336-1ff048434bcmr60175465ad.30.1722262997684;
        Mon, 29 Jul 2024 07:23:17 -0700 (PDT)
Received: from sunil-pc.tail07344b.ts.net ([106.51.198.16])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7fa988dsm83512965ad.263.2024.07.29.07.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 07:23:16 -0700 (PDT)
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
Subject: [PATCH v7 04/17] ACPI: scan: Refactor dependency creation
Date: Mon, 29 Jul 2024 19:52:26 +0530
Message-ID: <20240729142241.733357-5-sunilvl@ventanamicro.com>
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
index 52a9dfc8e18c..374cae4aef78 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2013,6 +2013,49 @@ void acpi_scan_hotplug_enabled(struct acpi_hotplug_profile *hotplug, bool val)
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
@@ -2035,8 +2078,7 @@ static void acpi_scan_init_hotplug(struct acpi_device *adev)
 static u32 acpi_scan_check_dep(acpi_handle handle)
 {
 	struct acpi_handle_list dep_devices;
-	u32 count;
-	int i;
+	u32 count = 0;
 
 	/*
 	 * Check for _HID here to avoid deferring the enumeration of:
@@ -2045,48 +2087,14 @@ static u32 acpi_scan_check_dep(acpi_handle handle)
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
index 8db5bd382915..d6a4dd58e36f 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -993,6 +993,7 @@ static inline void acpi_put_acpi_dev(struct acpi_device *adev)
 
 int acpi_wait_for_acpi_ipmi(void);
 
+int acpi_scan_add_dep(acpi_handle handle, struct acpi_handle_list *dep_devices);
 #else	/* CONFIG_ACPI */
 
 static inline int register_acpi_bus_type(void *bus) { return 0; }
-- 
2.43.0


