Return-Path: <linux-pci+bounces-43545-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E6562CD6F44
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 20:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3DFAA301AE06
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 19:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82665A937;
	Mon, 22 Dec 2025 19:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uyVQsAPo"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562C6238D52;
	Mon, 22 Dec 2025 19:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766431632; cv=none; b=Lg+W9/LFmxYrc//7/rYfD6OYNEBpuMY1bHLzHh0BscJ5j/seNlkULgiLYk3BDuUAIOgBm52qJMmHt04CWIB3/KtN7Sv3R9Z+R4S62ne0OsVih1vPPZlA/MfNDEbGBmUnWpVj6pTEh5+9HomrsnsRYWCBuCJ1am0TKOnRHxdHN3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766431632; c=relaxed/simple;
	bh=IZ9qwJewa9Smq0paPPZv9Dt6MLxAeBrNwsYAyDWmC24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GiNvlo4F46fe7hkDSyHXAWkyCLVu9LScCbLDJscPcHWEkAEEXJ3HswXtjbTk17S1Xz/I58PGebSAE1xfivx5DFQb5dbHzMhovsVcRL41QCaSMpV3c5XfutJyjnJLGZ8yAdRh6oA+mbNWx9Az1WhYwqDPXNm+peKeSZtpmg0Dbec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uyVQsAPo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BC63C116D0;
	Mon, 22 Dec 2025 19:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766431631;
	bh=IZ9qwJewa9Smq0paPPZv9Dt6MLxAeBrNwsYAyDWmC24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uyVQsAPom/gu0vEbTj7CTxnAW2q8sHW9SCeJ9WwJjuv/rXwUMRdYatn3UBv+XzUPG
	 d19Zhhxs1+FgQUJWrpkyjsChNAZEr+BND56hDRum+z6rzQu54+yCavb0qovcm9rpaF
	 H7Djfuof730cy7nvTtEpHkPDMMjKqH2n8ztO//Bqpr7mUb7dng2JQ4Pnj6HPxRuoYs
	 wCVFX/TZVvL6BmTrp0re9ehp0M0AiW1djq0GQ/R0iONEJj3zLWf8f03PIWjxDd7bvi
	 bdmQDcQa4OGCeegpCvHlaZ/tIyyaXDMvmT6wFybgIipB9yuJOklhbL3rwu2w2WGxsT
	 dwP69I0WVoC2g==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Hans de Goede <hansg@kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
Subject:
 [PATCH v2.1 2/8] ACPI: bus: Rework printing debug messages on _OSC errors
Date: Mon, 22 Dec 2025 20:11:08 +0100
Message-ID: <10794028.nUPlyArG6x@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <2413407.ElGaqSPkdT@rafael.j.wysocki>
References: <2413407.ElGaqSPkdT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Instead of using one function, acpi_print_osc_error(), for printing a
debug message and dumping the _OSC request data in one go, use
acpi_handle_debug() directly for printing messages and a separate
function called acpi_dump_osc_data() for dumping the _OSC request data
before printing one or more of them.

This avoids
 * dumping _OSC request data multiple times when there are
   multiple error bits set in the return buffer,
 * wrapping message lines on terminals with 80 character line width,
 * mixing up unrelated messages by printing full lines only,
and generally helps to make the messages easier to parse.

Also, use %pUL for UUID printing instead of printing UUIDs as strings
and include the revision number into the dumped _OSC request data.

This is how the debug printout looks like when the
OSC_REQUEST_ERROR and OSC_INVALID_REVISION_ERROR bits
are set in the return buffer before the change:

 ACPI: \_SB_: ACPI: (0811B06E-4A27-44F9-8D60-3CBBC22E7B48): _OSC request failed
 ACPI: _OSC request data:
 ACPI:  1
 ACPI:  2e7eff
 ACPI: 
 ACPI: \_SB_: ACPI: (0811B06E-4A27-44F9-8D60-3CBBC22E7B48): _OSC invalid revision
 ACPI: _OSC request data:
 ACPI:  1
 ACPI:  2e7eff
 ACPI:

and this is how it is going to look like afterward:

 ACPI: \_SB_: ACPI: _OSC: UUID: 0811B06E-4A27-44F9-8D60-3CBBC22E7B48, rev: 1
 ACPI: \_SB_: ACPI: _OSC: capabilities DWORD 0: [00000001]
 ACPI: \_SB_: ACPI: _OSC: capabilities DWORD 1: [002e7eff]
 ACPI: \_SB_: ACPI: _OSC: request failed
 ACPI: \_SB_: ACPI: _OSC: invalid revision

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2.1:
   * Dump _OSC request data before printing diagnostic messages.
   * Add example "before" and "after" debug output to the changelog (Jonathan).
   * Reformat messages to avoid crossing the 80 characters boundary.
   * Update the changelog.

---
 drivers/acpi/bus.c |   35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -180,18 +180,16 @@ void acpi_bus_detach_private_data(acpi_h
 }
 EXPORT_SYMBOL_GPL(acpi_bus_detach_private_data);
 
-static void acpi_print_osc_error(acpi_handle handle,
-				 struct acpi_osc_context *context, char *error)
+static void acpi_dump_osc_data(acpi_handle handle, const guid_t *guid, int rev,
+			       struct acpi_buffer *cap)
 {
+	u32 *capbuf = cap->pointer;
 	int i;
 
-	acpi_handle_debug(handle, "(%s): %s\n", context->uuid_str, error);
-
-	pr_debug("_OSC request data:");
-	for (i = 0; i < context->cap.length; i += sizeof(u32))
-		pr_debug(" %x", *((u32 *)(context->cap.pointer + i)));
-
-	pr_debug("\n");
+	acpi_handle_debug(handle, "_OSC: UUID: %pUL, rev: %d\n", guid, rev);
+	for (i = 0; i < cap->length / sizeof(u32); i++)
+		acpi_handle_debug(handle, "_OSC: capabilities DWORD %i: [%08x]\n",
+				  i, capbuf[i]);
 }
 
 #define OSC_ERROR_MASK 	(OSC_REQUEST_ERROR | OSC_INVALID_UUID_ERROR | \
@@ -239,8 +237,8 @@ acpi_status acpi_run_osc(acpi_handle han
 	out_obj = output.pointer;
 	if (out_obj->type != ACPI_TYPE_BUFFER
 		|| out_obj->buffer.length != context->cap.length) {
-		acpi_print_osc_error(handle, context,
-			"_OSC evaluation returned wrong type");
+		acpi_dump_osc_data(handle, &guid, context->rev, &context->cap);
+		acpi_handle_debug(handle, "_OSC: evaluation returned wrong type");
 		status = AE_TYPE;
 		goto out_kfree;
 	}
@@ -261,9 +259,9 @@ acpi_status acpi_run_osc(acpi_handle han
 		 */
 		bool fail = !!(capbuf[OSC_QUERY_DWORD] & OSC_QUERY_ENABLE);
 
+		acpi_dump_osc_data(handle, &guid, context->rev, &context->cap);
 		if (errors & OSC_INVALID_UUID_ERROR) {
-			acpi_print_osc_error(handle, context,
-				"_OSC invalid UUID");
+			acpi_handle_debug(handle, "_OSC: invalid UUID");
 			/*
 			 * Always fail if this bit is set because it means that
 			 * the request could not be processed.
@@ -272,14 +270,13 @@ acpi_status acpi_run_osc(acpi_handle han
 			goto out_kfree;
 		}
 		if (errors & OSC_REQUEST_ERROR)
-			acpi_print_osc_error(handle, context,
-				"_OSC request failed");
+			acpi_handle_debug(handle, "_OSC: request failed");
+
 		if (errors & OSC_INVALID_REVISION_ERROR)
-			acpi_print_osc_error(handle, context,
-				"_OSC invalid revision");
+			acpi_handle_debug(handle, "_OSC: invalid revision");
+
 		if (errors & OSC_CAPABILITIES_MASK_ERROR)
-			acpi_print_osc_error(handle, context,
-				"_OSC capability bits masked");
+			acpi_handle_debug(handle, "_OSC: capability bits masked");
 
 		if (fail) {
 			status = AE_ERROR;




