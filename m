Return-Path: <linux-pci+bounces-43544-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E506DCD6F3E
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 20:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E87DA30088CC
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 19:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801CD238D52;
	Mon, 22 Dec 2025 19:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p5ahgI4V"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7752C1595;
	Mon, 22 Dec 2025 19:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766431629; cv=none; b=Q5YgLTHrEKn6bOYi6QBEV94LNoxo+bCtMSOOxKwbBGaREcRKZBjHiAEKWp+cxU2Z1M3731011lSmacNWigleit+pEpDg3UIunEKzKPrMUiwp7sdsXMRf1Sp5RJSxahTTj+4A236GbiNAiOXlRZpNbl1JSHIX3KR2KJ4b5vhZY9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766431629; c=relaxed/simple;
	bh=pGsKDf8YDescZXuwmZggn0FtRk3WWnzONYgjmGlS42E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kB1HPDb7qyG3B2ncII9zDgEPvEpDjWmaXzF8VyUZX7jx2W2RmbWUfURImQ3ZDktS8HbY5tVnqq3C4WsQMRE+58/mafuiSWzTSmHd122LbhT9cwZaFGMVS9HGoegcDzUgp3Zc2RH/Gn24zefiz0OodBj9QwGVvEmJ0CVQZtM7UTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p5ahgI4V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A86EC4CEF1;
	Mon, 22 Dec 2025 19:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766431628;
	bh=pGsKDf8YDescZXuwmZggn0FtRk3WWnzONYgjmGlS42E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p5ahgI4VwXU+nKiqqg2NAVJBhr7tk0PhJ+JOoCZIZcmxe/1lBmHX9sZ8rC+zy8Ug5
	 omVdad6HyjkXxh+i0aR60qpGZYzNxAo/7n3IJIoDowuJ3qKcSJOMh9WzSw5ATFJD93
	 bXwnS6LR7qDF4AAjk8+490Ml7EEpTzrz8zPnwrrH7od3hdnKo4jLTDvN/r1VSNjsSI
	 ZYab1hVz1w2K6kSsm0C7/tAKKTBz3Yv7G1aSzmd1Cggv5EYSUh9RHhmGyuAyWwYoFV
	 e/Ov+4iirjH8FzEycrARHedAUMMxbrndzkDqUUmKReUFo94/+shnLeYZux4zIjhlLu
	 P+6fHDkHQ6QLQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Hans de Goede <hansg@kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
Subject:
 [PATCH v2.1 3/8] ACPI: bus: Split _OSC evaluation out of acpi_run_osc()
Date: Mon, 22 Dec 2025 20:14:16 +0100
Message-ID: <22963770.EfDdHjke4D@rafael.j.wysocki>
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

Split a function for evaluating _OSC called acpi_eval_osc() out of
acpi_run_osc() to facilitate subsequent changes and add some more
parameters sanity checks to the latter.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2.1:
   * Fix typo in the changelog (Jonathan).
   * Use at_least to enforce compiler checking of in_params[] size instead of
     using "static" directly (Jonathan).

---
 drivers/acpi/bus.c |   91 ++++++++++++++++++++++++++++++-----------------------
 1 file changed, 53 insertions(+), 38 deletions(-)

--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -196,52 +196,67 @@ static void acpi_dump_osc_data(acpi_hand
 			 OSC_INVALID_REVISION_ERROR | \
 			 OSC_CAPABILITIES_MASK_ERROR)
 
-acpi_status acpi_run_osc(acpi_handle handle, struct acpi_osc_context *context)
+static int acpi_eval_osc(acpi_handle handle, guid_t *guid, int rev,
+			 struct acpi_buffer *cap,
+			 union acpi_object in_params[at_least 4],
+			 struct acpi_buffer *output)
 {
-	u32 errors, *capbuf = context->cap.pointer;
-	acpi_status status;
 	struct acpi_object_list input;
-	union acpi_object in_params[4];
 	union acpi_object *out_obj;
-	guid_t guid;
-	struct acpi_buffer output = {ACPI_ALLOCATE_BUFFER, NULL};
-
-	if (!context)
-		return AE_ERROR;
-	if (guid_parse(context->uuid_str, &guid))
-		return AE_ERROR;
-	context->ret.length = ACPI_ALLOCATE_BUFFER;
-	context->ret.pointer = NULL;
+	acpi_status status;
 
-	/* Setting up input parameters */
-	input.count = 4;
+	in_params[0].type = ACPI_TYPE_BUFFER;
+	in_params[0].buffer.length = sizeof(*guid);
+	in_params[0].buffer.pointer = (u8 *)guid;
+	in_params[1].type = ACPI_TYPE_INTEGER;
+	in_params[1].integer.value = rev;
+	in_params[2].type = ACPI_TYPE_INTEGER;
+	in_params[2].integer.value = cap->length / sizeof(u32);
+	in_params[3].type = ACPI_TYPE_BUFFER;
+	in_params[3].buffer.length = cap->length;
+	in_params[3].buffer.pointer = cap->pointer;
 	input.pointer = in_params;
-	in_params[0].type 		= ACPI_TYPE_BUFFER;
-	in_params[0].buffer.length 	= 16;
-	in_params[0].buffer.pointer	= (u8 *)&guid;
-	in_params[1].type 		= ACPI_TYPE_INTEGER;
-	in_params[1].integer.value 	= context->rev;
-	in_params[2].type 		= ACPI_TYPE_INTEGER;
-	in_params[2].integer.value	= context->cap.length/sizeof(u32);
-	in_params[3].type		= ACPI_TYPE_BUFFER;
-	in_params[3].buffer.length 	= context->cap.length;
-	in_params[3].buffer.pointer 	= context->cap.pointer;
-
-	status = acpi_evaluate_object(handle, "_OSC", &input, &output);
-	if (ACPI_FAILURE(status))
-		return status;
+	input.count = 4;
 
-	if (!output.length)
-		return AE_NULL_OBJECT;
+	output->length = ACPI_ALLOCATE_BUFFER;
+	output->pointer = NULL;
 
-	out_obj = output.pointer;
-	if (out_obj->type != ACPI_TYPE_BUFFER
-		|| out_obj->buffer.length != context->cap.length) {
-		acpi_dump_osc_data(handle, &guid, context->rev, &context->cap);
-		acpi_handle_debug(handle, "_OSC: evaluation returned wrong type");
-		status = AE_TYPE;
-		goto out_kfree;
+	status = acpi_evaluate_object(handle, "_OSC", &input, output);
+	if (ACPI_FAILURE(status) || !output->length)
+		return -ENODATA;
+
+	out_obj = output->pointer;
+	if (out_obj->type != ACPI_TYPE_BUFFER ||
+	    out_obj->buffer.length != cap->length) {
+		acpi_handle_debug(handle, "Invalid _OSC return buffer\n");
+		acpi_dump_osc_data(handle, guid, rev, cap);
+		ACPI_FREE(out_obj);
+		return -ENODATA;
 	}
+
+	return 0;
+}
+
+acpi_status acpi_run_osc(acpi_handle handle, struct acpi_osc_context *context)
+{
+	u32 errors, *capbuf = context->cap.pointer;
+	union acpi_object in_params[4], *out_obj;
+	struct acpi_buffer output;
+	acpi_status status = AE_OK;
+	guid_t guid;
+	int ret;
+
+	if (!context || !context->cap.pointer ||
+	    context->cap.length < 2 * sizeof(32) ||
+	    guid_parse(context->uuid_str, &guid))
+		return AE_BAD_PARAMETER;
+
+	ret = acpi_eval_osc(handle, &guid, context->rev, &context->cap,
+			    in_params, &output);
+	if (ret)
+		return AE_ERROR;
+
+	out_obj = output.pointer;
 	/* Only take defined error bits into account. */
 	errors = *((u32 *)out_obj->buffer.pointer) & OSC_ERROR_MASK;
 	/*




