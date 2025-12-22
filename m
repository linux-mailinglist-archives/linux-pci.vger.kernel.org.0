Return-Path: <linux-pci+bounces-43541-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C940BCD6F4E
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 20:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB2B73018F6C
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 19:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B43327C0B;
	Mon, 22 Dec 2025 19:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BbanWyCb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D18E307AD6;
	Mon, 22 Dec 2025 19:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766431619; cv=none; b=KtHX8ukvOwP4+IvGbeVzfchurwuklDuJdBV1C4oyX51xIfiGYcnE9E4fz7v7KHlts6CSYTfBwGTGP5eIHJMxv7LoSs26D9xsRd0RvFXoN/DWInazJecEi+18YVRltBuY06lMDajDHd2YFTKhIVJ1vJnp4XoNVlE8kgPAm1TrSf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766431619; c=relaxed/simple;
	bh=OLCadIv+zN48COV6/4DpvIa30w9QH3dUgKsSm6B8O2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MYvtEHaOhoZPv3uHEA9Ylits3NzvlNXMlGKSQ6Z0j9+c3hkYvsf1STjcrerBV2pVPEHsyzYDNEWMzrWI+5/6eeCRJsauiWpl7mzFxslHi3a52YA63AyFLLB36yW3K+UBRChv+u9708fZK1biD1Ja5ztkRW2FDyeTaPPvZeq8lYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BbanWyCb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 523F4C4CEF1;
	Mon, 22 Dec 2025 19:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766431618;
	bh=OLCadIv+zN48COV6/4DpvIa30w9QH3dUgKsSm6B8O2w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BbanWyCb1XWcm9eZirW+Ae0A+zOAiImdESFESzZDeA9uD1fyVHIUsd7FJx+07O2wO
	 DR+PYiobzMOSdnrJChnKRdqNIY2VovSj9LRNTWBPG+HCC88K8zoNLpJuIeMSpHqLfl
	 ZprvXrVZcSzsxtVXr3fIvexmR2VuFS7iPiHOCGRjwVEU0oPbDrrxsnrdmIFpRKGW1I
	 CrSwF+iQ0jiWewuzhgqztjrl9pgBRn1iDq6zf9jCdEyMW+Mz7a9fDj2u30fhCH3Exd
	 CX5VqIt7DQ8wwCq8YXyNETEhjE0ie5b93hPNcxEUEilzMJHm5wDI17yhz3zOctbJz5
	 cB2MDBsQwlDHQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Hans de Goede <hansg@kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
Subject:
 [PATCH v2.1 6/8] ACPI: bus: Rework the handling of \_SB._OSC platform
 features
Date: Mon, 22 Dec 2025 20:21:19 +0100
Message-ID: <1966378.CQOukoFCf9@rafael.j.wysocki>
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

Both acpi_bus_osc_negotiate_platform_control() and
acpi_bus_osc_negotiate_usb_control() first call acpi_run_osc() to
evaluate _OSC in "query mode", with OSC_QUERY_ENABLE set in the
capabilities buffer, and then use the resultant feature mask as
the input buffer for requesting control of those features by
calling acpi_run_osc() to evaluate _OSC with OSC_QUERY_ENABLE clear.

This involves some code duplication and unnecessary memory
allocations, so introduce a new helper function carrying out an
_OSC handshake along the lines of the above description in a simpler
way and update acpi_bus_osc_negotiate_platform_control() to use it.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2.1:
   * Add printing error messages regarding unexpected _OSC errors when
     processing a feature mask acknowledged previously (Jonathan).
   * Update the changelog after moving the essential change to patch [1/8].

---
 drivers/acpi/bus.c |  141 +++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 101 insertions(+), 40 deletions(-)

--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -325,6 +325,92 @@ out:
 }
 EXPORT_SYMBOL(acpi_run_osc);
 
+static int acpi_osc_handshake(acpi_handle handle, const char *uuid_str,
+			      int rev, struct acpi_buffer *cap)
+{
+	union acpi_object in_params[4], *out_obj;
+	size_t bufsize = cap->length / sizeof(u32);
+	struct acpi_object_list input;
+	struct acpi_buffer output;
+	u32 *capbuf, *retbuf, test;
+	guid_t guid;
+	int ret, i;
+
+	if (!cap || cap->length < 2 * sizeof(32) || guid_parse(uuid_str, &guid))
+		return -EINVAL;
+
+	/* First evaluate _OSC with OSC_QUERY_ENABLE set. */
+	capbuf = cap->pointer;
+	capbuf[OSC_QUERY_DWORD] = OSC_QUERY_ENABLE;
+
+	ret = acpi_eval_osc(handle, &guid, rev, cap, in_params, &output);
+	if (ret)
+		return ret;
+
+	out_obj = output.pointer;
+	retbuf = (u32 *)out_obj->buffer.pointer;
+
+	if (acpi_osc_error_check(handle, &guid, rev, cap, retbuf)) {
+		ret = -ENODATA;
+		goto out;
+	}
+
+	/*
+	 * Clear the feature bits in the capabilities buffer that have not been
+	 * acknowledged and clear the return buffer.
+	 */
+	for (i = OSC_QUERY_DWORD + 1, test = 0; i < bufsize; i++) {
+		capbuf[i] &= retbuf[i];
+		test |= capbuf[i];
+		retbuf[i] = 0;
+	}
+	/*
+	 * If none of the feature bits have been acknowledged, there's nothing
+	 * more to do.  capbuf[] contains a feature mask of all zeros.
+	 */
+	if (!test)
+		goto out;
+
+	retbuf[OSC_QUERY_DWORD] = 0;
+	/*
+	 * Now evaluate _OSC again (directly) with OSC_QUERY_ENABLE clear and
+	 * the updated input and output buffers used before.  Since the feature
+	 * bits that were clear in the return buffer from the previous _OSC
+	 * evaluation are also clear in the capabilities buffer now, this _OSC
+	 * evaluation is not expected to fail.
+	 */
+	capbuf[OSC_QUERY_DWORD] = 0;
+	/* Reuse in_params[] populated by acpi_eval_osc(). */
+	input.pointer = in_params;
+	input.count = 4;
+
+	if (ACPI_FAILURE(acpi_evaluate_object(handle, "_OSC", &input, &output))) {
+		ret = -ENODATA;
+		goto out;
+	}
+
+	/*
+	 * Clear the feature bits in capbuf[] that have not been acknowledged.
+	 * After that, capbuf[] contains the resultant feature mask.
+	 */
+	for (i = OSC_QUERY_DWORD + 1; i < bufsize; i++)
+		capbuf[i] &= retbuf[i];
+
+	if (retbuf[OSC_QUERY_DWORD] & OSC_ERROR_MASK) {
+		/*
+		 * Complain about the unexpected errors and print diagnostic
+		 * information related to them.
+		 */
+		acpi_handle_err(handle, "_OSC: errors while processing control request\n");
+		acpi_handle_err(handle, "_OSC: some features may be missing\n");
+		acpi_osc_error_check(handle, &guid, rev, cap, retbuf);
+	}
+
+out:
+	ACPI_FREE(out_obj);
+	return ret;
+}
+
 bool osc_sb_apei_support_acked;
 
 /*
@@ -356,19 +442,16 @@ EXPORT_SYMBOL_GPL(osc_sb_native_usb4_sup
 
 bool osc_sb_cppc2_support_acked;
 
-static u8 sb_uuid_str[] = "0811B06E-4A27-44F9-8D60-3CBBC22E7B48";
 static void acpi_bus_osc_negotiate_platform_control(void)
 {
-	u32 capbuf[2], *capbuf_ret;
-	struct acpi_osc_context context = {
-		.uuid_str = sb_uuid_str,
-		.rev = 1,
-		.cap.length = 8,
-		.cap.pointer = capbuf,
+	static const u8 sb_uuid_str[] = "0811B06E-4A27-44F9-8D60-3CBBC22E7B48";
+	u32 capbuf[2];
+	struct acpi_buffer cap = {
+		.pointer = capbuf,
+		.length = sizeof(capbuf),
 	};
 	acpi_handle handle;
 
-	capbuf[OSC_QUERY_DWORD] = OSC_QUERY_ENABLE;
 	capbuf[OSC_SUPPORT_DWORD] = OSC_SB_PR3_SUPPORT; /* _PR3 is in use */
 	if (IS_ENABLED(CONFIG_ACPI_PROCESSOR_AGGREGATOR))
 		capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_PAD_SUPPORT;
@@ -414,43 +497,21 @@ static void acpi_bus_osc_negotiate_platf
 	if (ACPI_FAILURE(acpi_get_handle(NULL, "\\_SB", &handle)))
 		return;
 
-	if (ACPI_FAILURE(acpi_run_osc(handle, &context)))
-		return;
-
-	capbuf_ret = context.ret.pointer;
-	if (context.ret.length <= OSC_SUPPORT_DWORD) {
-		kfree(context.ret.pointer);
+	if (acpi_osc_handshake(handle, sb_uuid_str, 1, &cap))
 		return;
-	}
-
-	/*
-	 * Now run _OSC again with query flag clear and with the caps
-	 * supported by both the OS and the platform.
-	 */
-	capbuf[OSC_QUERY_DWORD] = 0;
-	capbuf[OSC_SUPPORT_DWORD] = capbuf_ret[OSC_SUPPORT_DWORD];
-	kfree(context.ret.pointer);
 
-	if (ACPI_FAILURE(acpi_run_osc(handle, &context)))
-		return;
-
-	capbuf_ret = context.ret.pointer;
-	if (context.ret.length > OSC_SUPPORT_DWORD) {
 #ifdef CONFIG_ACPI_CPPC_LIB
-		osc_sb_cppc2_support_acked = capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_CPCV2_SUPPORT;
+	osc_sb_cppc2_support_acked = capbuf[OSC_SUPPORT_DWORD] & OSC_SB_CPCV2_SUPPORT;
 #endif
 
-		osc_sb_apei_support_acked =
-			capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_APEI_SUPPORT;
-		osc_pc_lpi_support_confirmed =
-			capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_PCLPI_SUPPORT;
-		osc_sb_native_usb4_support_confirmed =
-			capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_NATIVE_USB4_SUPPORT;
-		osc_cpc_flexible_adr_space_confirmed =
-			capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_CPC_FLEXIBLE_ADR_SPACE;
-	}
-
-	kfree(context.ret.pointer);
+	osc_sb_apei_support_acked =
+			capbuf[OSC_SUPPORT_DWORD] & OSC_SB_APEI_SUPPORT;
+	osc_pc_lpi_support_confirmed =
+			capbuf[OSC_SUPPORT_DWORD] & OSC_SB_PCLPI_SUPPORT;
+	osc_sb_native_usb4_support_confirmed =
+			capbuf[OSC_SUPPORT_DWORD] & OSC_SB_NATIVE_USB4_SUPPORT;
+	osc_cpc_flexible_adr_space_confirmed =
+			capbuf[OSC_SUPPORT_DWORD] & OSC_SB_CPC_FLEXIBLE_ADR_SPACE;
 }
 
 /*




