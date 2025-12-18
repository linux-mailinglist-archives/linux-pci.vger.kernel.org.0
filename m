Return-Path: <linux-pci+bounces-43328-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 48725CCD9AF
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 21:58:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 430D030D7A3A
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 20:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079E63446B6;
	Thu, 18 Dec 2025 20:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P9nb3+U2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F5C3446A7;
	Thu, 18 Dec 2025 20:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766090593; cv=none; b=cQafOY7PE3o0gNi3ecxbQboXEgigNFA+iPhiB6g9VOkV1xQYzCfQr8vO7t0ruivJfay+oyZGvW3r4zYXLn16HOQXKK8AQAx2nSHNsCLfGjccXEWagJgrIUuvp2tQMVHbsCQuhJyFoJ8ois3PZFAFGNyxZrzqXVvV5FPI/h6YULA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766090593; c=relaxed/simple;
	bh=Lcf7BVQg7WTokVLfksIKdaxed9Ric8tew5QW57OhuX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h1zpv+N3SnyzrCEIXHGlzNsLgpsDS/Rh7gbbjGNUOqCm9083/jvdaROZdNcXHfPOR3I21t0ITR9HQMeQsTG/Bxy8mUmyHazcEfMzXqLQc1ZcyKkg+iQ5qZ3mgj/AfLzRjwvGWgQDWFSwgmlq7hlSK4t8KbeH7Yths+nldqlr19c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P9nb3+U2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84BABC4CEFB;
	Thu, 18 Dec 2025 20:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766090593;
	bh=Lcf7BVQg7WTokVLfksIKdaxed9Ric8tew5QW57OhuX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P9nb3+U2ZfEKaDhK6oBjs3pFCHcxjdF5OM/S3Z9AIT4o7l52zUOlc34Gtw/T0BFkL
	 YSrRsl+TZgf64GBYryltrd6ODcPOCQKi3Hdt8LPbiRhrvkedmlEvZCuyOlFeqQfQHj
	 HLzVOnYpr1uMokHQFi8Zp/zgvvf6E7wRMPXr8Ifem4hQrPz30zE5nDmXk0pEhS3LWV
	 vq0XWzc+PZdeMlHuxev31tePwi8fk/Z6GcnzYaf007U8mBcCfhNE1XQT8frRdtBO1M
	 MyQ3K4PiUumRAS6pvKGSMHeCppDzutBPAuFCoCLSOjZjMYRD8B/s65rLJeLFPEmoSr
	 sU+4HD/ly/8mQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Hans de Goede <hansg@kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v1 7/8] ACPI: bus: Adjust feature mask creation for \_SB._OSC
Date: Thu, 18 Dec 2025 21:41:42 +0100
Message-ID: <9564052.CDJkKcVGEf@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <5049211.GXAFRqVoOG@rafael.j.wysocki>
References: <5049211.GXAFRqVoOG@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The feature mask creation for \_SB._OSC platform features is messy
and hard to follow, so clean it up and make all of the CPPC-related
features depend on CONFIG_ACPI_CPPC_LIB as they will not work if it
is not set anyway.

Also make acpi_bus_osc_negotiate_platform_control() print a message
including a bit mask representing the features for which control has
been granted.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/bus.c |   83 ++++++++++++++++++++++++-----------------------------
 1 file changed, 39 insertions(+), 44 deletions(-)

--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -418,73 +418,68 @@ bool osc_sb_cppc2_support_acked;
 static void acpi_bus_osc_negotiate_platform_control(void)
 {
 	static const u8 sb_uuid_str[] = "0811B06E-4A27-44F9-8D60-3CBBC22E7B48";
-	u32 capbuf[2];
+	u32 capbuf[2], feature_mask;
 	struct acpi_buffer cap = {
 		.pointer = capbuf,
 		.length = sizeof(capbuf),
 	};
 	acpi_handle handle;
 
-	capbuf[OSC_SUPPORT_DWORD] = OSC_SB_PR3_SUPPORT; /* _PR3 is in use */
+	feature_mask = OSC_SB_PR3_SUPPORT | OSC_SB_HOTPLUG_OST_SUPPORT |
+			OSC_SB_PCLPI_SUPPORT | OSC_SB_OVER_16_PSTATES_SUPPORT |
+			OSC_SB_GED_SUPPORT | OSC_SB_IRQ_RESOURCE_SOURCE_SUPPORT;
+
+	if (IS_ENABLED(CONFIG_ARM64) || IS_ENABLED(CONFIG_X86))
+		feature_mask |= OSC_SB_GENERIC_INITIATOR_SUPPORT;
+
+	if (IS_ENABLED(CONFIG_ACPI_CPPC_LIB)) {
+		feature_mask |= OSC_SB_CPC_SUPPORT | OSC_SB_CPCV2_SUPPORT |
+				OSC_SB_CPC_FLEXIBLE_ADR_SPACE;
+		if (IS_ENABLED(CONFIG_SCHED_MC_PRIO))
+			feature_mask |= OSC_SB_CPC_DIVERSE_HIGH_SUPPORT;
+	}
+
 	if (IS_ENABLED(CONFIG_ACPI_PROCESSOR_AGGREGATOR))
-		capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_PAD_SUPPORT;
+		feature_mask |= OSC_SB_PAD_SUPPORT;
+
 	if (IS_ENABLED(CONFIG_ACPI_PROCESSOR))
-		capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_PPC_OST_SUPPORT;
+		feature_mask |= OSC_SB_PPC_OST_SUPPORT;
+
 	if (IS_ENABLED(CONFIG_ACPI_THERMAL))
-		capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_FAST_THERMAL_SAMPLING_SUPPORT;
+		feature_mask |= OSC_SB_FAST_THERMAL_SAMPLING_SUPPORT;
+
 	if (IS_ENABLED(CONFIG_ACPI_BATTERY))
-		capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_BATTERY_CHARGE_LIMITING_SUPPORT;
+		feature_mask |= OSC_SB_BATTERY_CHARGE_LIMITING_SUPPORT;
 
-	capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_HOTPLUG_OST_SUPPORT;
-	capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_PCLPI_SUPPORT;
-	capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_OVER_16_PSTATES_SUPPORT;
-	capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_GED_SUPPORT;
-	capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_IRQ_RESOURCE_SOURCE_SUPPORT;
 	if (IS_ENABLED(CONFIG_ACPI_PRMT))
-		capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_PRM_SUPPORT;
-	if (IS_ENABLED(CONFIG_ACPI_FFH))
-		capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_FFH_OPR_SUPPORT;
-
-#ifdef CONFIG_ARM64
-	capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_GENERIC_INITIATOR_SUPPORT;
-#endif
-#ifdef CONFIG_X86
-	capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_GENERIC_INITIATOR_SUPPORT;
-#endif
-
-#ifdef CONFIG_ACPI_CPPC_LIB
-	capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_CPC_SUPPORT;
-	capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_CPCV2_SUPPORT;
-#endif
+		feature_mask |= OSC_SB_PRM_SUPPORT;
 
-	capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_CPC_FLEXIBLE_ADR_SPACE;
-
-	if (IS_ENABLED(CONFIG_SCHED_MC_PRIO))
-		capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_CPC_DIVERSE_HIGH_SUPPORT;
+	if (IS_ENABLED(CONFIG_ACPI_FFH))
+		feature_mask |= OSC_SB_FFH_OPR_SUPPORT;
 
 	if (IS_ENABLED(CONFIG_USB4))
-		capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_NATIVE_USB4_SUPPORT;
+		feature_mask |= OSC_SB_NATIVE_USB4_SUPPORT;
 
 	if (!ghes_disable)
-		capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_APEI_SUPPORT;
+		feature_mask |= OSC_SB_APEI_SUPPORT;
+
 	if (ACPI_FAILURE(acpi_get_handle(NULL, "\\_SB", &handle)))
 		return;
 
+	capbuf[OSC_SUPPORT_DWORD] = feature_mask;
+
 	if (acpi_osc_handshake(handle, sb_uuid_str, 1, &cap))
 		return;
 
-#ifdef CONFIG_ACPI_CPPC_LIB
-	osc_sb_cppc2_support_acked = capbuf[OSC_SUPPORT_DWORD] & OSC_SB_CPCV2_SUPPORT;
-#endif
-
-	osc_sb_apei_support_acked =
-			capbuf[OSC_SUPPORT_DWORD] & OSC_SB_APEI_SUPPORT;
-	osc_pc_lpi_support_confirmed =
-			capbuf[OSC_SUPPORT_DWORD] & OSC_SB_PCLPI_SUPPORT;
-	osc_sb_native_usb4_support_confirmed =
-			capbuf[OSC_SUPPORT_DWORD] & OSC_SB_NATIVE_USB4_SUPPORT;
-	osc_cpc_flexible_adr_space_confirmed =
-			capbuf[OSC_SUPPORT_DWORD] & OSC_SB_CPC_FLEXIBLE_ADR_SPACE;
+	feature_mask = capbuf[OSC_SUPPORT_DWORD];
+
+	acpi_handle_info(handle, "platform _OSC feature mask [%08x]\n", feature_mask);
+
+	osc_sb_cppc2_support_acked = feature_mask & OSC_SB_CPCV2_SUPPORT;
+	osc_sb_apei_support_acked = feature_mask & OSC_SB_APEI_SUPPORT;
+	osc_pc_lpi_support_confirmed = feature_mask & OSC_SB_PCLPI_SUPPORT;
+	osc_sb_native_usb4_support_confirmed = feature_mask & OSC_SB_NATIVE_USB4_SUPPORT;
+	osc_cpc_flexible_adr_space_confirmed = feature_mask & OSC_SB_CPC_FLEXIBLE_ADR_SPACE;
 }
 
 /*




