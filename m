Return-Path: <linux-pci+bounces-43543-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B31A3CD6F62
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 20:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53B5F3056548
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 19:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D3232693E;
	Mon, 22 Dec 2025 19:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RrmqnpFx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE78B2FFF89;
	Mon, 22 Dec 2025 19:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766431627; cv=none; b=KgXJaX6Fp02ShPBCY4ZnjUuKzaOPla3IPax5QcWIsqRSvtPZry2D2IbZHYKh+386FVS54imaN2gfOkOBljir7wVK6doyJbx/zoar6clXvBg42cSumNuJmaZ/QeObUFLP6u+/FTTiHjtAgaiQe/8/5+tHXzPfiU7rFXgZnwO768I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766431627; c=relaxed/simple;
	bh=xPMBYlg9lvKm+1jZ2Re655+ewZrEi58/qodFJBDdwf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AnEg6/qWanbI6/VtGJA2phQa+XXfEK2W/CyFWn/1TleRD612Du5SycZ1wyE+nzP/xPS2baBsqmrZb72CfzLF2KiJWX/BGXYRU0AHgDu8YKPX+aq4ySVSxAZ2pqBJipn8WaHWyZs2Bbm0RepRO7OcSvM/1GjgR1f3HL38XNJA/u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RrmqnpFx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEB60C116D0;
	Mon, 22 Dec 2025 19:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766431625;
	bh=xPMBYlg9lvKm+1jZ2Re655+ewZrEi58/qodFJBDdwf0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RrmqnpFx604DJQB65JRe4OXUHL8cq8qybwyo5QWEW8BwzxWboOizLGHAaFKkc43EY
	 0NcbPbEwl90GphaRym7MY99SozTwQyTb4NuQIaC4QBg6ezIVfh9G0Pp9i0aA9olprE
	 LaBqxWOtbv9OGUuLZtvetPT7bgT0duc9aaFkPIIyXQGLiLTHdgK+CvEZjyBntxPq4C
	 Ac3f2IZwHmlVGAS9dRTCzACo+To0GxqhZk6MnMT/b2LXakTUeSp0MJKFlJEf7XTDPI
	 NxygdaHktlyGY8G3i4MdLpWQqmrOvedxYvAuDUX8AUa8SVyf9Uz6RWCXZjOINmFH9N
	 PycgVPJnGfucA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Hans de Goede <hansg@kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
Subject:
 [PATCH v2.1 4/8] ACPI: bus: Split _OSC error processing out of acpi_run_osc()
Date: Mon, 22 Dec 2025 20:17:29 +0100
Message-ID: <6135328.MhkbZ0Pkbq@rafael.j.wysocki>
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

Split a function for processing _OSC errors called acpi_osc_error_check()
out of acpi_run_osc() to facilitate subsequent changes.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---

v1 -> v2.1:
   * Rebase on the modified first patch.
   * Fix typo in the changelog (Jonathan).
   * Expand the comment regarding ignoring OSC_CAPABILITIES_MASK_ERROR
     when OSC_QUERY_DWORD is set (Jonathan).
   * Add R-by from Jonathan.

---
 drivers/acpi/bus.c |   95 +++++++++++++++++++++++++++++------------------------
 1 file changed, 53 insertions(+), 42 deletions(-)

--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -237,13 +237,60 @@ static int acpi_eval_osc(acpi_handle han
 	return 0;
 }
 
+static bool acpi_osc_error_check(acpi_handle handle, guid_t *guid, int rev,
+				 struct acpi_buffer *cap, u32 *retbuf)
+{
+	/* Only take defined error bits into account. */
+	u32 errors = retbuf[OSC_QUERY_DWORD] & OSC_ERROR_MASK;
+	u32 *capbuf = cap->pointer;
+	bool fail;
+
+	/*
+	 * If OSC_QUERY_ENABLE is set, ignore the "capabilities masked"
+	 * bit because it merely means that some features have not been
+	 * acknowledged which is not unexpected.
+	 */
+	if (capbuf[OSC_QUERY_DWORD] & OSC_QUERY_ENABLE)
+		errors &= ~OSC_CAPABILITIES_MASK_ERROR;
+
+	if (!errors)
+		return false;
+
+	acpi_dump_osc_data(handle, guid, rev, cap);
+	/*
+	 * As a rule, fail only if OSC_QUERY_ENABLE is set because otherwise the
+	 * acknowledged features need to be controlled.
+	 */
+	fail = !!(capbuf[OSC_QUERY_DWORD] & OSC_QUERY_ENABLE);
+
+	if (errors & OSC_REQUEST_ERROR)
+		acpi_handle_debug(handle, "_OSC: request failed\n");
+
+	if (errors & OSC_INVALID_UUID_ERROR) {
+		acpi_handle_debug(handle, "_OSC: invalid UUID\n");
+		/*
+		 * Always fail if this bit is set because it means that the
+		 * request could not be processed.
+		 */
+		fail = true;
+	}
+
+	if (errors & OSC_INVALID_REVISION_ERROR)
+		acpi_handle_debug(handle, "_OSC: invalid revision\n");
+
+	if (errors & OSC_CAPABILITIES_MASK_ERROR)
+		acpi_handle_debug(handle, "_OSC: capability bits masked\n");
+
+	return fail;
+}
+
 acpi_status acpi_run_osc(acpi_handle handle, struct acpi_osc_context *context)
 {
-	u32 errors, *capbuf = context->cap.pointer;
 	union acpi_object in_params[4], *out_obj;
 	struct acpi_buffer output;
 	acpi_status status = AE_OK;
 	guid_t guid;
+	u32 *retbuf;
 	int ret;
 
 	if (!context || !context->cap.pointer ||
@@ -257,51 +304,15 @@ acpi_status acpi_run_osc(acpi_handle han
 		return AE_ERROR;
 
 	out_obj = output.pointer;
-	/* Only take defined error bits into account. */
-	errors = *((u32 *)out_obj->buffer.pointer) & OSC_ERROR_MASK;
-	/*
-	 * If OSC_QUERY_ENABLE is set, ignore the "capabilities masked"
-	 * bit because it merely means that some features have not been
-	 * acknowledged which is not unexpected.
-	 */
-	if (capbuf[OSC_QUERY_DWORD] & OSC_QUERY_ENABLE)
-		errors &= ~OSC_CAPABILITIES_MASK_ERROR;
+	retbuf = (u32 *)out_obj->buffer.pointer;
 
-	if (errors) {
-		/*
-		 * As a rule, fail only if OSC_QUERY_ENABLE is set because
-		 * otherwise the acknowledged features need to be controlled.
-		 */
-		bool fail = !!(capbuf[OSC_QUERY_DWORD] & OSC_QUERY_ENABLE);
-
-		acpi_dump_osc_data(handle, &guid, context->rev, &context->cap);
-		if (errors & OSC_INVALID_UUID_ERROR) {
-			acpi_handle_debug(handle, "_OSC: invalid UUID");
-			/*
-			 * Always fail if this bit is set because it means that
-			 * the request could not be processed.
-			 */
-			fail = true;
-			goto out_kfree;
-		}
-		if (errors & OSC_REQUEST_ERROR)
-			acpi_handle_debug(handle, "_OSC: request failed");
-
-		if (errors & OSC_INVALID_REVISION_ERROR)
-			acpi_handle_debug(handle, "_OSC: invalid revision");
-
-		if (errors & OSC_CAPABILITIES_MASK_ERROR)
-			acpi_handle_debug(handle, "_OSC: capability bits masked");
-
-		if (fail) {
-			status = AE_ERROR;
-			goto out_kfree;
-		}
+	if (acpi_osc_error_check(handle, &guid, context->rev, &context->cap, retbuf)) {
+		status = AE_ERROR;
+		goto out_kfree;
 	}
 
 	context->ret.length = out_obj->buffer.length;
-	context->ret.pointer = kmemdup(out_obj->buffer.pointer,
-				       context->ret.length, GFP_KERNEL);
+	context->ret.pointer = kmemdup(retbuf, context->ret.length, GFP_KERNEL);
 	if (!context->ret.pointer) {
 		status =  AE_NO_MEMORY;
 		goto out_kfree;




