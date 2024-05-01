Return-Path: <linux-pci+bounces-6940-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF538B89AF
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2024 14:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F75C281370
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2024 12:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1027312B145;
	Wed,  1 May 2024 12:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="h4HZBs0B"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D082312AAD3
	for <linux-pci@vger.kernel.org>; Wed,  1 May 2024 12:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714565918; cv=none; b=lScFvqEDZVYfMLQLzKxRHAxsj8Kz9Fu/PRSxHaJsrgjiQygEftJ/MDfgKGRIV44DJoWm6ZOklEvdrUzuV+srhdXHZtY9xrcqV2QdELb6i13648mCHk5IObdRc2c1j7cYimC39FujShEXabp26inSF0CrK7vvEfVNeVWFLyBVH3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714565918; c=relaxed/simple;
	bh=40G7efalCDrGiaKldSdMEYPAzuXFlQlo+Lbo7W3hChc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pd2Vud5eD6SGu/dqd2hBzFqRTIT7ixm4oFpGdY5Le1jSsw9+6Jsi6lZEdVGDd7aFTjXLvT5dHkR8R3VqlgbjqNBtfkxLJNfhkAKbueg7sCHEyBBOUEBSqWTHJ+J0a8c/Bx9p6ELgZtoEucVejqkGhN5hwiai+iBgGy6EgmbwLsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=h4HZBs0B; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e8bbcbc2b7so60683025ad.0
        for <linux-pci@vger.kernel.org>; Wed, 01 May 2024 05:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1714565915; x=1715170715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lRvT/oDJzrljnZE8hh4Mfx8UjypBfU2BU36kOdk78lo=;
        b=h4HZBs0Bn73Rm4fNaVr3pul7ugd1BbfuHkILtLV0f8tkse95SrlILOungqpfHgKkrB
         m+NCLQ7JDz1EW/W0yFGhiCvWUBQvg7VGYI7zIGhmx5flfOzHH0dbIeSfoB8pj4IxBvk9
         hjW3FgJo0NEFgTE4siK/J57Fdh4DU6gtAS90zF11b1KPW8n7gzZD//V48eCLAep4WIj5
         jYwKKt4QQ0+TacKZajz1hMh4iTmvTOrP5BXo45l3MNIMx4I9dwOUxif2skIctkQcGmvg
         OrlWzsWPgiuQyuKrUfbZz3o/a5D+iqBjfY1g8v9hd5XU2CudQUBq3PDNTmw8Qmrf6SMH
         rLaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714565915; x=1715170715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lRvT/oDJzrljnZE8hh4Mfx8UjypBfU2BU36kOdk78lo=;
        b=lihkmfEPtmtrIK2PY8NQpEBrKROP7ZjNL9UgP35ohWKzIH4Fm2SFwCMKYvzt56VVXZ
         JGCev3U6+l2DjmmxTYdOmBs5OKGAUJp7tRdsE+BJbm2In+j3ikuxAaYcfChGdhdwXWYF
         jgbbPIAXc2lTsRdsKbOiNh2JsBDi/xqnmzU57lehZvIQsFNlKVrG80H3HZ/6/z+vlOa1
         GPBwnzpuqdH4A+8p+uzk8Bw5dW0E8XI4jxASl0RY6uviUWw6aPcY+Q7gb1/dYVhbA9cw
         WozfG9NxzLqeOI/7pM1biT7zw9pysRW9RoswFxyZ2sXSy70zEwX5CNxx1LQEBENFr2U1
         Mytw==
X-Forwarded-Encrypted: i=1; AJvYcCXHRPcAXKWbU/r/02FEO4wLllPEE6sCSg4AGJWZGRg7o3PS5x8o4dKrQ4RSBqWhK4kRiqYvvQrta+bGPQsUZkC0K8p/gBz4u//J
X-Gm-Message-State: AOJu0YwNyHUCNL7zK12vyePnA0en/1nuCkaWA/1HLuKxXIi6lISEGbNs
	35DHqiwuMavWixQGYjvt9tc1TevJhrBdSh3URQUZWCB31QIJYxbXjd+pc74zUxI=
X-Google-Smtp-Source: AGHT+IFj7UjbvAZWh+cyRVOuEeVGC8mPfC0AaziB0MuMPmALOJzUu9Sq7LhvOrdMq5PmFj31+IKF9Q==
X-Received: by 2002:a17:902:e5c4:b0:1eb:4a72:91ff with SMTP id u4-20020a170902e5c400b001eb4a7291ffmr3011610plf.49.1714565915161;
        Wed, 01 May 2024 05:18:35 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.188.106])
        by smtp.gmail.com with ESMTPSA id im15-20020a170902bb0f00b001ec8888b22esm1336900plb.65.2024.05.01.05.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 05:18:34 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-serial@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Marc Zyngier <maz@kernel.org>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Andrei Warkentin <andrei.warkentin@intel.com>,
	Haibo1 Xu <haibo1.xu@intel.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v5 04/17] ACPI: scan: Refactor dependency creation
Date: Wed,  1 May 2024 17:47:29 +0530
Message-Id: <20240501121742.1215792-5-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240501121742.1215792-1-sunilvl@ventanamicro.com>
References: <20240501121742.1215792-1-sunilvl@ventanamicro.com>
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
index 837b8fc89dfb..3e3320ddb3da 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2023,33 +2023,18 @@ static void acpi_scan_init_hotplug(struct acpi_device *adev)
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
@@ -2068,7 +2053,7 @@ static u32 acpi_scan_check_dep(acpi_handle handle)
 
 		count++;
 
-		dep->supplier = dep_devices.handles[i];
+		dep->supplier = dep_devices->handles[i];
 		dep->consumer = handle;
 		dep->honor_dep = honor_dep;
 
@@ -2077,7 +2062,30 @@ static u32 acpi_scan_check_dep(acpi_handle handle)
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


