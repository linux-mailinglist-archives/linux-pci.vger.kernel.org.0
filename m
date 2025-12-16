Return-Path: <linux-pci+bounces-43147-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7289BCC515E
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 21:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B602304A29B
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 20:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A548E3346A0;
	Tue, 16 Dec 2025 20:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aq2mnlOk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7998F212552;
	Tue, 16 Dec 2025 20:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765916338; cv=none; b=fdBul32/a1h8+jiKaKIPN2x2nuUBlSyVP0JN7QtNpx97pri7E/2VCo1AHtLKL/B+DK85A5Jgh3shZdbtt8037OJ4Myz2be5RRLmIIgSj9kq1ikcG4mz4xE/eVjrjeRxOoGcTWbf8sfzG2L56BiZnAiKQ73Y6P2gKVk8YLGPzLsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765916338; c=relaxed/simple;
	bh=5cd8Ans3am9z/gkhPuWlJI1KgxuV7qh/0MzugBTYAJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t8sLamkbZw0CjQRXjzzhCsaqnPoF+MAF18p/Odtd4ggC5NWeLrsdFMmFUo1oMHs76ev4Tmlu5y+pD514yGvfU3K2z3BS0wVahcW1wm8X/9+debVXoUpTZIQaL6pfwzd/C7kN2OzRC0LnKGt9or/sqYO9Y9jo6YzzsceVjEVcQWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aq2mnlOk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC353C4CEF1;
	Tue, 16 Dec 2025 20:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765916338;
	bh=5cd8Ans3am9z/gkhPuWlJI1KgxuV7qh/0MzugBTYAJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aq2mnlOkGImqitF1prNu579YahoEhkl02xMmm1TcFD1Rk7fsY2wpyhxShisGOunr4
	 srePulKZPY+C8OE+0FaqnGLKNnJ6Zz0Q2wtFrkB/OxoEwPf7uGSK3gNJ7kgloOojRg
	 RHbs/dxR87aEVTAy/GB/6kY1tX8z3Su2FIrdxwM4bwFbSfg8fOBXCAnPxekL8PfC4E
	 Yvkl0hG6DP06od7NoW1oyNrM7tgEPVCPZGRo5TITvkI6ztTsCCIAmUof+7G0HvIgnL
	 i3KJ7c/uLCMsgsPPNQLdDG+XBTMW3n5VrpLrAoTtI2L5+7g5J/Ue8gEifkKWjtodwZ
	 +hJkJ80QALNtQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Hans de Goede <hansg@kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v1 1/2] ACPI: bus: Adjust error handling in acpi_run_osc()
Date: Tue, 16 Dec 2025 21:17:06 +0100
Message-ID: <6225184.lOV4Wx5bFT@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <12803663.O9o76ZdvQC@rafael.j.wysocki>
References: <12803663.O9o76ZdvQC@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Some platform firmware incorrectly sets the OSC_CAPABILITIES_MASK_ERROR
bit in its _OSC return buffer even if no support bits have been actually
masked, which causes acpi_run_osc() to return an error when executed
with OSC_QUERY_ENABLE clear in the OC capabilities buffer.  As a result,
the OS assumes that the _OSC evaluation has failed and the platform has
not acknowledged any capabilities, while the platform assumes that it
actually has acknowledged some of them.  This confusion may lead to
missing functionality (and possibly other issues) down the road.

To address this problem, adjust acpi_run_osc() to avoid returning an
error when OSC_CAPABILITIES_MASK_ERROR is set in the return buffer
and OSC_QUERY_ENABLE is clear in the OC capabilities, but all of the
bits in the support mask supplied by the OS are also set in the bit
mask returned by the platform firmware.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/bus.c |   23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -240,9 +240,13 @@ acpi_status acpi_run_osc(acpi_handle han
 		status = AE_TYPE;
 		goto out_kfree;
 	}
+	if (out_obj->buffer.length <= OSC_SUPPORT_DWORD) {
+		status = AE_BAD_DATA;
+		goto out_kfree;
+	}
 	/* Need to ignore the bit0 in result code */
 	errors = *((u32 *)out_obj->buffer.pointer) & ~(1 << 0);
-	if (errors) {
+	if (errors & ~OSC_CAPABILITIES_MASK_ERROR) {
 		if (errors & OSC_REQUEST_ERROR)
 			acpi_print_osc_error(handle, context,
 				"_OSC request failed");
@@ -252,17 +256,20 @@ acpi_status acpi_run_osc(acpi_handle han
 		if (errors & OSC_INVALID_REVISION_ERROR)
 			acpi_print_osc_error(handle, context,
 				"_OSC invalid revision");
-		if (errors & OSC_CAPABILITIES_MASK_ERROR) {
-			if (((u32 *)context->cap.pointer)[OSC_QUERY_DWORD]
-			    & OSC_QUERY_ENABLE)
-				goto out_success;
+		status = AE_ERROR;
+		goto out_kfree;
+	}
+	if (errors) {
+		u32 retbuf = ((u32 *)out_obj->buffer.pointer)[OSC_SUPPORT_DWORD];
+		u32 capbuf = ((u32 *)context->cap.pointer)[OSC_SUPPORT_DWORD];
+		u32 querybuf = ((u32 *)context->cap.pointer)[OSC_QUERY_DWORD];
+
+		/* OSC_CAPABILITIES_MASK_ERROR is set in errors. */
+		if (!(querybuf & OSC_QUERY_ENABLE) && (capbuf & retbuf) != capbuf) {
 			status = AE_SUPPORT;
 			goto out_kfree;
 		}
-		status = AE_ERROR;
-		goto out_kfree;
 	}
-out_success:
 	context->ret.length = out_obj->buffer.length;
 	context->ret.pointer = kmemdup(out_obj->buffer.pointer,
 				       context->ret.length, GFP_KERNEL);




