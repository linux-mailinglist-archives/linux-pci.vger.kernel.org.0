Return-Path: <linux-pci+bounces-43546-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6B6CD6F4A
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 20:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 86351301C884
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 19:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1F733B6E5;
	Mon, 22 Dec 2025 19:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PzpIWSKT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDBC2C1595;
	Mon, 22 Dec 2025 19:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766431635; cv=none; b=jov2ALx5syFUSJarflV/jCaqAxq0AqxmR5QR2sXPuC1w+oT61dmjARKlgNyqbg8ABlVYpygrYWFgVJxDNXbLcVdjESIIonjRBv+a1ZS8/f7jg+YMrpluHu6N+PfEZLUCbr0FtupUAYziiyMc1sEfUSWQOCuOJbNKhLn7Xx1U4I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766431635; c=relaxed/simple;
	bh=iM4tplBMR+F8pcoBdC5WU9tHrrFnmr1mMXayfLhEHN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tnhcOVXLGVyQ1SRzWXSdywIeKaCMiit7pScRNjyvQr75rMCoczpDh6kFQclCm5gxmw5gJGkCoQrJzZGstbU9f0ZFNknmWIU6bTi5UoEoTp6kz3alKSSLIusLJ1/9Gj3vLEUXzvvDo06JCdgwC+aOjlVGRZBdEhW+xdS2vRmFUcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PzpIWSKT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B189BC16AAE;
	Mon, 22 Dec 2025 19:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766431635;
	bh=iM4tplBMR+F8pcoBdC5WU9tHrrFnmr1mMXayfLhEHN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PzpIWSKTPWQEtWtR2SSgQYcZOyykjLCiEJL0Re27nKHpnc/80B0hmkrdVTOhcfVQ3
	 JeRFBhlQGv880mz1zdKH4LMkW8EP2L7L7vjiyZE8JmWSUjU16yQwru2BvQUcaSx+BT
	 m2VYf7BrAgiQHNtlf71+f01tIOvHHPrmWGgv0pA8ur9wjEwFl0ysp2ysw1SMrMOFMQ
	 Nagdx0k0FDxphcrHLS9mQph/9+ThvreCkF93kATYMLTEgN5ebhdtflp5QbPrr+atjj
	 kiY+Xlet2tRblXvNAoaI2LwE+NI5vmUHKPkMK8ePxPYUZ9q58+2unWkZhqANHHLISo
	 xJl13ZxVTCQkg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Hans de Goede <hansg@kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
Subject:
 [PATCH v2.1 1/8] ACPI: bus: Fix handling of _OSC errors in acpi_run_osc()
Date: Mon, 22 Dec 2025 20:05:44 +0100
Message-ID: <3042649.e9J7NaK4W3@rafael.j.wysocki>
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

The handling of _OSC errors in acpi_run_osc() is inconsistent and
arguably not compliant with the _OSC definition (cf. Section 6.2.12 of
ACPI 6.6 [1]).

Namely, if OSC_QUERY_ENABLE is not set in the capabilities buffer and
any of the error bits are set in the _OSC return buffer, acpi_run_osc()
returns an error code and the _OSC return buffer is discarded.  However,
in that case, depending on what error bits are set, the return buffer
may contain acknowledged bits for features that need to be controlled by
the kernel going forward.

If the OSC_INVALID_UUID_ERROR bit is set, the request could not be
processed at all and so in that particular case discarding the _OSC
return buffer and returning an error is the right thing to do regardless
of whether or not OSC_QUERY_ENABLE is set in the capabilities buffer.

If OSC_QUERY_ENABLE is set in the capabilities buffer and the
OSC_REQUEST_ERROR or OSC_INVALID_REVISION_ERROR bits are set in the
return buffer, acpi_run_osc() may return an error and discard the _OSC
return buffer because in that case the platform configuration does not
change.  However, if any of them is set in the return buffer when
OSC_QUERY_ENABLE is not set in the capabilities buffer, the feature
mask in the _OSC return buffer still representes a set of acknowleded
features as per the _OSC definition:

 The platform acknowledges the Capabilities Buffer by returning a
 buffer of DWORDs of the same length. Set bits indicate acknowledgment
 that OSPM may take control of the capability and cleared bits indicate
 that the platform either does not support the capability or that OSPM
 may not assume control.

which is not conditional on the error bits being clear, so in that case,
discarding the _OSC return buffer is questionable.  There is also no
reason to return an error and discard the _OSC return buffer if the
OSC_CAPABILITIES_MASK_ERROR bit is set in it, but printing diagnostic
messages is appropriate when that happens with OSC_QUERY_ENABLE clear
in the capabilities buffer.

Adress this issue by making acpi_run_osc() follow the rules outlined
above.

Moreover, make acpi_run_osc() only take the defined _OSC error bits into
account when checking _OSC errors.

Link: https://uefi.org/specs/ACPI/6.6/06_Device_Configuration.html#osc-operating-system-capabilities [1]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v2 -> v2.1:
   * Print diagnostic messages for all error bits set in the _OSC return buffer
     when OSC_INVALID_UUID_ERROR is set.
   * Strengthen the changelog language related to printing diagnostic messages
     when OSC_CAPABILITIES_MASK_ERROR is set in the _OSC return buffer (Jonathan).

v1 -> v2:
   * In addition to making the behavior consistent, also make the code
     follow the specification more closely in the cases when the "query
     enable" bit is not set in _OSC the capabilities buffer an error bits
     are set in the _OSC return buffer.
   * Update the changelog accordingly.

---
 drivers/acpi/bus.c |   52 ++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 38 insertions(+), 14 deletions(-)

--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -194,14 +194,18 @@ static void acpi_print_osc_error(acpi_ha
 	pr_debug("\n");
 }
 
+#define OSC_ERROR_MASK 	(OSC_REQUEST_ERROR | OSC_INVALID_UUID_ERROR | \
+			 OSC_INVALID_REVISION_ERROR | \
+			 OSC_CAPABILITIES_MASK_ERROR)
+
 acpi_status acpi_run_osc(acpi_handle handle, struct acpi_osc_context *context)
 {
+	u32 errors, *capbuf = context->cap.pointer;
 	acpi_status status;
 	struct acpi_object_list input;
 	union acpi_object in_params[4];
 	union acpi_object *out_obj;
 	guid_t guid;
-	u32 errors;
 	struct acpi_buffer output = {ACPI_ALLOCATE_BUFFER, NULL};
 
 	if (!context)
@@ -240,29 +244,49 @@ acpi_status acpi_run_osc(acpi_handle han
 		status = AE_TYPE;
 		goto out_kfree;
 	}
-	/* Need to ignore the bit0 in result code */
-	errors = *((u32 *)out_obj->buffer.pointer) & ~(1 << 0);
+	/* Only take defined error bits into account. */
+	errors = *((u32 *)out_obj->buffer.pointer) & OSC_ERROR_MASK;
+	/*
+	 * If OSC_QUERY_ENABLE is set, ignore the "capabilities masked"
+	 * bit because it merely means that some features have not been
+	 * acknowledged which is not unexpected.
+	 */
+	if (capbuf[OSC_QUERY_DWORD] & OSC_QUERY_ENABLE)
+		errors &= ~OSC_CAPABILITIES_MASK_ERROR;
+
 	if (errors) {
+		/*
+		 * As a rule, fail only if OSC_QUERY_ENABLE is set because
+		 * otherwise the acknowledged features need to be controlled.
+		 */
+		bool fail = !!(capbuf[OSC_QUERY_DWORD] & OSC_QUERY_ENABLE);
+
+		if (errors & OSC_INVALID_UUID_ERROR) {
+			acpi_print_osc_error(handle, context,
+				"_OSC invalid UUID");
+			/*
+			 * Always fail if this bit is set because it means that
+			 * the request could not be processed.
+			 */
+			fail = true;
+			goto out_kfree;
+		}
 		if (errors & OSC_REQUEST_ERROR)
 			acpi_print_osc_error(handle, context,
 				"_OSC request failed");
-		if (errors & OSC_INVALID_UUID_ERROR)
-			acpi_print_osc_error(handle, context,
-				"_OSC invalid UUID");
 		if (errors & OSC_INVALID_REVISION_ERROR)
 			acpi_print_osc_error(handle, context,
 				"_OSC invalid revision");
-		if (errors & OSC_CAPABILITIES_MASK_ERROR) {
-			if (((u32 *)context->cap.pointer)[OSC_QUERY_DWORD]
-			    & OSC_QUERY_ENABLE)
-				goto out_success;
-			status = AE_SUPPORT;
+		if (errors & OSC_CAPABILITIES_MASK_ERROR)
+			acpi_print_osc_error(handle, context,
+				"_OSC capability bits masked");
+
+		if (fail) {
+			status = AE_ERROR;
 			goto out_kfree;
 		}
-		status = AE_ERROR;
-		goto out_kfree;
 	}
-out_success:
+
 	context->ret.length = out_obj->buffer.length;
 	context->ret.pointer = kmemdup(out_obj->buffer.pointer,
 				       context->ret.length, GFP_KERNEL);




