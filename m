Return-Path: <linux-pci+bounces-43334-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CC112CCD921
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 21:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 90760302EFC2
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 20:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD2734B1A4;
	Thu, 18 Dec 2025 20:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YO3nu2E1"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9191B34B19F;
	Thu, 18 Dec 2025 20:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766090612; cv=none; b=P4LyA5MC6sLrKFjpS2XE5bltRvJ3n7RhNRgej/B/cZAg1+mRc6SYrHhRiNj72SaYdeUoi+KpbPlObG4lZ3UVVoVSlIBLkIpwEjfkhluiNqgawn92r6zfXKTP2SM29t4QPOjvS2D1k6RYB7qKlG1DH7WXukg2QNOgx6yfVVbSfY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766090612; c=relaxed/simple;
	bh=WiukSp8abPA7Ir/NI7fjD316gPQSi0iDAzSeRz3fYWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y9z74qg5xA4JMFCVCd6qecKxkBa+nqfyaQc44pU7Wy+dlnXil/ycxO0KFezF4o86u7vO8DtQvjm3U9lg5lri76KW1fN11YbXlYEqVfsl3Jw0feDMWnqd6czUIWuhrlTesUNnrg9xCqDeXcT805f+qn2+//TrJVMcjPXtPRDN9iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YO3nu2E1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46AA6C116D0;
	Thu, 18 Dec 2025 20:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766090612;
	bh=WiukSp8abPA7Ir/NI7fjD316gPQSi0iDAzSeRz3fYWQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YO3nu2E1kn57iq1NiVU5+RtM6p3KfYMCYH+yZNuGE/yABYxezTXIP4iHmo+imZhxp
	 FCtfO8xbjS2gXjAmpzaFOx/ArRCw1O9P8XH93j6gR21e3w8vhd2jHdZb0tL7V5yQZr
	 gzMA6wunGqZS8RjdrvIiwKUGDTqjM/c5ho+woFW6w0eEV260ix3XNRFHS4C1n7EhC4
	 7f9AgeVSfsu0qVlR7voqCU1DL+sKL34+rm/89K09vmgWpiokdWFS1ZBYNdWHf20lOr
	 lkFJM8admHdIlLzM1oxBVU8Fj+GsxjI0LIP52VzrpFCxnNcCynW2bzjA6O5yQANOdx
	 3y523qjmfH+oA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Hans de Goede <hansg@kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
Subject:
 [PATCH v1 1/8] ACPI: bus: Fix handling of _OSC errors in acpi_run_osc()
Date: Thu, 18 Dec 2025 21:34:26 +0100
Message-ID: <2261695.irdbgypaU6@rafael.j.wysocki>
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

The handling of _OSC errors in acpi_run_osc() is inconsistent.

For example, if OSC_CAPABILITIES_MASK_ERROR is set in the return buffer
and OSC_QUERY_ENABLE is set in the capabilities buffer, all of the
_OSC errors will be ignored even though some of them indicate that
_OSC evaluation has failed.  However, if OSC_QUERY_ENABLE is not set in
the capabilities buffer, all _OSC errors will be reported, but the error
value returned by acpi_run_osc() depends on whether or not
OSC_CAPABILITIES_MASK_ERROR is set in the return buffer.

Adress this by making acpi_run_osc() clear OSC_CAPABILITIES_MASK_ERROR
in the return buffer if OSC_QUERY_ENABLE is set in the capabilities
buffer and then check if any other _OSC errors have been returned.  Also
make it use the same error return value for all _OSC errors and print
a message for OSC_CAPABILITIES_MASK_ERROR like for the other error
types.

Moreover, make acpi_run_osc() only take the defined _OSC error bits into
account when checking _OSC errors.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/bus.c |   25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -194,6 +194,10 @@ static void acpi_print_osc_error(acpi_ha
 	pr_debug("\n");
 }
 
+#define OSC_ERROR_MASK 	(OSC_REQUEST_ERROR | OSC_INVALID_UUID_ERROR | \
+			 OSC_INVALID_REVISION_ERROR | \
+			 OSC_CAPABILITIES_MASK_ERROR)
+
 acpi_status acpi_run_osc(acpi_handle handle, struct acpi_osc_context *context)
 {
 	acpi_status status;
@@ -240,8 +244,12 @@ acpi_status acpi_run_osc(acpi_handle han
 		status = AE_TYPE;
 		goto out_kfree;
 	}
-	/* Need to ignore the bit0 in result code */
-	errors = *((u32 *)out_obj->buffer.pointer) & ~(1 << 0);
+	/* Only take defined error bits into account. */
+	errors = *((u32 *)out_obj->buffer.pointer) & OSC_ERROR_MASK;
+	/* If OSC_QUERY_ENABLE is set, ignore the "capabilities masked" bit. */
+	if (((u32 *)context->cap.pointer)[OSC_QUERY_DWORD] & OSC_QUERY_ENABLE)
+		errors &= ~OSC_CAPABILITIES_MASK_ERROR;
+
 	if (errors) {
 		if (errors & OSC_REQUEST_ERROR)
 			acpi_print_osc_error(handle, context,
@@ -252,17 +260,14 @@ acpi_status acpi_run_osc(acpi_handle han
 		if (errors & OSC_INVALID_REVISION_ERROR)
 			acpi_print_osc_error(handle, context,
 				"_OSC invalid revision");
-		if (errors & OSC_CAPABILITIES_MASK_ERROR) {
-			if (((u32 *)context->cap.pointer)[OSC_QUERY_DWORD]
-			    & OSC_QUERY_ENABLE)
-				goto out_success;
-			status = AE_SUPPORT;
-			goto out_kfree;
-		}
+		if (errors & OSC_CAPABILITIES_MASK_ERROR)
+			acpi_print_osc_error(handle, context,
+				"_OSC capability bits masked");
+
 		status = AE_ERROR;
 		goto out_kfree;
 	}
-out_success:
+
 	context->ret.length = out_obj->buffer.length;
 	context->ret.pointer = kmemdup(out_obj->buffer.pointer,
 				       context->ret.length, GFP_KERNEL);




