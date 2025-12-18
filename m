Return-Path: <linux-pci+bounces-43331-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C03B7CCD95E
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 21:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F620306A058
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 20:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5752E34A3CE;
	Thu, 18 Dec 2025 20:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RxpJNMpR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF5C347FCC;
	Thu, 18 Dec 2025 20:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766090603; cv=none; b=m1HjwvyIBPYAWnNKTbz/rmDvqM5SQ+YRUU4yhv+ao4fxyHdH/t5j72q2faBpKcElN/HorVxtc7ct+BcRRAneY7Ivx8em8ljZcp+GaSsTL3uNSNu4Y8B4PO6izmO4IablWZvOdOBRKnPvD7xFcABxSYM0AB4eaqEntnzVpdCccd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766090603; c=relaxed/simple;
	bh=fdXZYRvgZmjXRqoFtAUDp2jqLJelW75FRwvF/8sNTls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DOeCLdqF6g4/VjXuRWBgGji9k/FzQBiGymBYbdtVyV/TrYSiOM6bXNtzr+oNVjgHRKOo3nDmNxJ6ezspIJvC9FAitQVmznFDoreDDL6/cA8zqq4HX5xaLOGXV0rciJ9m0EjX5nAjGR6L3xAR+fzgqXSdyTS6vwYQNEGskOrZz1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RxpJNMpR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D209AC4CEFB;
	Thu, 18 Dec 2025 20:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766090603;
	bh=fdXZYRvgZmjXRqoFtAUDp2jqLJelW75FRwvF/8sNTls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RxpJNMpRr/d9VXilmXhZssnNz3IOpwKNGRnf76MUTq3p3mD3/TYHC6zzNR2ji4L3+
	 ERU6SZyyaaiKoLHD4xtZZLhWJQD2dLEYuND8kD4k63geJfJZAyUOuiF04ZKFDWWrRj
	 aUtVvVsquZZIhHQy2fk4qh1J2fU3rDQsqCyrNYJdj9pwuf2V3PLhI+QuGbiBmv+x5l
	 pli7xd6ozTXDLaYz/pMn5x8cAjlLlkLkPuhUWHmElnv2P23M6zF8wrjjFT/qgiXIjy
	 k0yrYCqguwdr5RrsUhMEsrcZqhgHOTBhsi75UdaEkF0BYCvns0npvbuzNJ5Y8WPrxw
	 R6m2ZWfXFvgBw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Hans de Goede <hansg@kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
Subject:
 [PATCH v1 4/8] ACPI: bus: Split _OSC error processing out of acpi_run_osc()
Date: Thu, 18 Dec 2025 21:36:57 +0100
Message-ID: <10786459.nUPlyArG6x@rafael.j.wysocki>
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

Split a function for processing _OSL errors called acpi_osc_error_check()
out of acpi_run_osc() to facilitate subsequent changes.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/bus.c |   56 ++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 36 insertions(+), 20 deletions(-)

--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -236,13 +236,46 @@ static int acpi_eval_osc(acpi_handle han
 	return 0;
 }
 
+static bool acpi_osc_error_check(acpi_handle handle, guid_t *guid, int rev,
+				 struct acpi_buffer *cap, u32 *retbuf)
+{
+	/* Bit 0 in the query DWORD of the return buffer is reserved. */
+	u32 errors = retbuf[OSC_QUERY_DWORD] & OSC_ERROR_MASK;
+	u32 *capbuf = cap->pointer;
+
+	/*
+	 * If OSC_QUERY_ENABLE is set in the capabilities buffer, ignore bit 4.
+	 */
+	if (capbuf[OSC_QUERY_DWORD] & OSC_QUERY_ENABLE)
+		errors &= ~OSC_CAPABILITIES_MASK_ERROR;
+
+	if (!errors)
+		return false;
+
+	if (errors & OSC_REQUEST_ERROR)
+		acpi_handle_debug(handle, "_OSC: request failed\n");
+
+	if (errors & OSC_INVALID_UUID_ERROR)
+		acpi_handle_debug(handle, "_OSC: invalid UUID\n");
+
+	if (errors & OSC_INVALID_REVISION_ERROR)
+		acpi_handle_debug(handle, "_OSC: invalid revision\n");
+
+	if (errors & OSC_CAPABILITIES_MASK_ERROR)
+		acpi_handle_debug(handle, "_OSC: capability bits masked\n");
+
+	acpi_dump_osc_data(handle, guid, rev, cap);
+
+	return true;
+}
+
 acpi_status acpi_run_osc(acpi_handle handle, struct acpi_osc_context *context)
 {
 	union acpi_object in_params[4], *out_obj;
 	struct acpi_buffer output;
 	acpi_status status = AE_OK;
 	guid_t guid;
-	u32 errors;
+	u32 *retbuf;
 	int ret;
 
 	if (!context || !context->cap.pointer ||
@@ -256,26 +289,9 @@ acpi_status acpi_run_osc(acpi_handle han
 		return AE_ERROR;
 
 	out_obj = output.pointer;
-	/* Only take defined error bits into account. */
-	errors = *((u32 *)out_obj->buffer.pointer) & OSC_ERROR_MASK;
-	/* If OSC_QUERY_ENABLE is set, ignore the "capabilities masked" bit. */
-	if (((u32 *)context->cap.pointer)[OSC_QUERY_DWORD] & OSC_QUERY_ENABLE)
-		errors &= ~OSC_CAPABILITIES_MASK_ERROR;
-
-	if (errors) {
-		if (errors & OSC_REQUEST_ERROR)
-			acpi_handle_debug(handle, "_OSC request failed");
-
-		if (errors & OSC_INVALID_UUID_ERROR)
-			acpi_handle_debug(handle, "_OSC invalid UUID");
-
-		if (errors & OSC_INVALID_REVISION_ERROR)
-			acpi_handle_debug(handle, "_OSC invalid revision");
-
-		if (errors & OSC_CAPABILITIES_MASK_ERROR)
-			acpi_handle_debug(handle, "_OSC capability bits masked");
+	retbuf = (u32 *)out_obj->buffer.pointer;
 
-		acpi_dump_osc_data(handle, &guid, context->rev, &context->cap);
+	if (acpi_osc_error_check(handle, &guid, context->rev, &context->cap, retbuf)) {
 		status = AE_ERROR;
 		goto out_kfree;
 	}




