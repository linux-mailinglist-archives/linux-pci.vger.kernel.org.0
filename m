Return-Path: <linux-pci+bounces-43329-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD031CCD98B
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 21:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 056B1302C47A
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 20:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30EAB346AC9;
	Thu, 18 Dec 2025 20:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KHq0Wnqq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063B8346A1B;
	Thu, 18 Dec 2025 20:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766090597; cv=none; b=slbHrRlgNrcR2ZYdD+nNbiWfyBFNKg8dIGthQ7/AL+q/e00Hbq4hI+hBXG3lD5a++RZruY3pplQSCJlke3RJtm2k1349w5mc5ZBRbr1+pjGQ1TPhtcIwEbWnsPoW7EAWtattN8hmUeGyv9Of1i56djsv+BUhTnoRJo870YsmqSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766090597; c=relaxed/simple;
	bh=TRz4UmjZYVBoGvjkGjAaJ4KVllyNLIuvUaPbwbc4FEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k+QJrud+Udtz5NKwHmkS0DBe5xAmPAd4JsPNXelzDb0SHHMlAgdzFR3NVqSjmgRWo/J8qsrw6+jFc8EDmNe1J4OpduOesvayf2MVEyNV5b81H+P6KJpD8CBE5mBhBoJrTHlDk7NvAX8UbCmKPccdJzYXjShf5oJN7PDiuqiFdBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KHq0Wnqq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96C34C4CEFB;
	Thu, 18 Dec 2025 20:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766090596;
	bh=TRz4UmjZYVBoGvjkGjAaJ4KVllyNLIuvUaPbwbc4FEU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KHq0Wnqq95x70BfeTJhu4mfDSe00Wue3Y39FLc/16tXKWDqwsHm5dBJKCfVS+t4GH
	 PXZw9angCHzVTkCby5L7+SpiBDnnF61rcemPvbVCISDCeQxl6xZO0Y8nCcJ76XRJ/F
	 AtB0fhoLXZ7DZkmqEDUws3EPYOzuBe7Kph0cHZnB85FsSFWqBgHZmD7kq6saaPkn6d
	 jl3Y8J1fTCqkEbYnprLf3jn0YqQBs8LgC9FKli1cUV9rtDkdDdN8qzimM2g87/FpEu
	 fbBy1c6MQjqEkmSDn/pw3UngRM+JmVS5Mrh+yEl/oQ685FYGdt7vNdT/AAogyWIrZ9
	 bI0koq40wkmtw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Hans de Goede <hansg@kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
Subject:
 [PATCH v1 6/8] ACPI: bus: Rework the handling of \_SB._OSC platform features
Date: Thu, 18 Dec 2025 21:39:43 +0100
Message-ID: <3933560.kQq0lBPeGt@rafael.j.wysocki>
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

The current handling of \_SB._OSC is susceptible to problems with
setting error bits in the output buffer by mistake if the platform
firmware is supplied with a feature mask previously acknowledged
by the analogous _OSC call with OSC_QUERY_ENABLE set.  If that
happens, acpi_run_osc() will return an error and the kernel will
assume that it cannot control any of the features it has asked
for.  If an error bit has been set by mistake, however, the platform
firmware may expect the kernel to actually take over the control of
those features and nobody will take care of them going forward.

If the given feature mask has been already acknowledged once though,
the kernel may reasonably expect the _OSC evaluation to succeed and
acknowledge all of the features in the current mask again, but that
is not generally guaranteed to happen, so it is actually good to
verify the return buffer.  Still, it is sufficient to check the
feature bits in the return buffer for this purpose.

Namely, the OSC_INVALID_UUID_ERROR and OSC_INVALID_REVISION_ERROR bits
should not be set then because they were not set during the previous
_OSC evaluation that has acknowledged the feature mask.  Moreover,
if all of the feature bits that are set in the capabilities buffer
are also set in the return buffer, the OSC_CAPABILITIES_MASK_ERROR
should not be set either and the OSC_REQUEST_ERROR bit doesn't matter
even if set.  Thus if that is the case, the kernel may regard the
entire feature mask as acknowledged and take over the control of the
given features as per Section 6.2.12 of ACPI 6.6 [1].

If the feature masks in the capabilities buffer and in the return
buffer are different, the bits that are set in both masks may still
be regarded as acknowledged and the corresponding features may be
controlled by the kernel.

Introduce a new function carrying out an _OSC handshake along the
lines of the above description and make the \_SB._OSC handling code
use it to avoid failing in some cases in which it may succeed
regardless of platform firmware deficiencies.

Link: https://uefi.org/specs/ACPI/6.6/06_Device_Configuration.html#osc-operating-system-capabilities
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/bus.c |  128 ++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 88 insertions(+), 40 deletions(-)

--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -311,6 +311,79 @@ out:
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
+	 * more to do.
+	 */
+	if (!test)
+		goto out;
+
+	retbuf[OSC_QUERY_DWORD] = 0;
+	/*
+	 * Now evaluate _OSC again (directly) with OSC_QUERY_ENABLE clear and
+	 * the updated input and output buffers used before.
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
+	/* Clear the feature bits that have not been acknowledged in capbuf[]. */
+	for (i = OSC_QUERY_DWORD + 1; i < bufsize; i++)
+		capbuf[i] &= retbuf[i];
+
+	/* Check _OSC errors to print debug messages if any. */
+	acpi_osc_error_check(handle, &guid, rev, cap, retbuf);
+
+out:
+	ACPI_FREE(out_obj);
+	return ret;
+}
+
 bool osc_sb_apei_support_acked;
 
 /*
@@ -342,19 +415,16 @@ EXPORT_SYMBOL_GPL(osc_sb_native_usb4_sup
 
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
@@ -400,43 +470,21 @@ static void acpi_bus_osc_negotiate_platf
 	if (ACPI_FAILURE(acpi_get_handle(NULL, "\\_SB", &handle)))
 		return;
 
-	if (ACPI_FAILURE(acpi_run_osc(handle, &context)))
-		return;
-
-	capbuf_ret = context.ret.pointer;
-	if (context.ret.length <= OSC_SUPPORT_DWORD) {
-		kfree(context.ret.pointer);
-		return;
-	}
-
-	/*
-	 * Now run _OSC again with query flag clear and with the caps
-	 * supported by both the OS and the platform.
-	 */
-	capbuf[OSC_QUERY_DWORD] = 0;
-	capbuf[OSC_SUPPORT_DWORD] = capbuf_ret[OSC_SUPPORT_DWORD];
-	kfree(context.ret.pointer);
-
-	if (ACPI_FAILURE(acpi_run_osc(handle, &context)))
+	if (acpi_osc_handshake(handle, sb_uuid_str, 1, &cap))
 		return;
 
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




