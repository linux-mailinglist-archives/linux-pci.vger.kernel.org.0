Return-Path: <linux-pci+bounces-43332-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3FFCCD9F3
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 22:02:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9C1D30B4961
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 20:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9427C34A79B;
	Thu, 18 Dec 2025 20:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SIYmySr6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B684347FCC;
	Thu, 18 Dec 2025 20:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766090606; cv=none; b=SrfJ8CmoS6EjSn/4FOu3j8es3bOD+HTIMxRcPhg//WtBjhMjTO0S1O7nzVIUJAKPudIt0W2kzGX2m1VLPELx3BG4DI8c9Pkrw+pHwGRBXCO2Z+5E++bJjZzNs+dX1agCKivw0zzGtMLZfF946jvWAWwTlPnmvoaXUcOQqKjTUXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766090606; c=relaxed/simple;
	bh=KDcZ8uxDIOfUDbYNA2SDG8iz7II4Xv9fVwbhRoPoMBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cHxPXh4ZvXMD2ixIcDDOMJoGJ2NqqEdmJy0XFeA/dmYgo7yyGg60Q1RqRVJU7o9WbfP73MNKqGwq7mif4PUraWN2W7roZfXfqO7Vy0OsxPZSntNHNW3Osk/eIr/4UyfgKcn/iE58LOAh4E4YlzoAuikYepl33BRsJCqmOzvf5RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SIYmySr6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 173CBC4CEFB;
	Thu, 18 Dec 2025 20:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766090606;
	bh=KDcZ8uxDIOfUDbYNA2SDG8iz7II4Xv9fVwbhRoPoMBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SIYmySr6RbEK/8XhM6/xqK0PbdSqpbQncnmIEyFG+X0U5m1GTuDuzxzNHkafu0pFU
	 4VEyEnkIwU0HobFBImlti2jfyDPex+g6TOb4po46InvUcAKTsR6sbcSMLrqlidd091
	 Qke+wYf+DIxOBbpHP2DB6qKjFrT42YGm0Hs8mzNIdBBwGjJ2TjYosFgzk4Mttbt2UK
	 tthazVML0qhXnZGSJBDG4VmVfCDFA7aMuabjaQeb1IEyNIWJGD0BWhaEboxHfZX8B2
	 BjcoPyIdbZ1ZQoYtGm+1FB8dFp/1iCUBoDsXYaZbQkLjV/oM2WZYoh98YYlTWkXDLe
	 FFQmJJX3/qsNQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Hans de Goede <hansg@kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v1 3/8] ACPI: bus: Split _OSC evaluation out of acpi_run_osc()
Date: Thu, 18 Dec 2025 21:36:08 +0100
Message-ID: <3407425.44csPzL39Z@rafael.j.wysocki>
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

Split a function for evaluating _OSL called acpi_eval_osc() out of
acpi_run_osc() to facilitate subsequent changes and add some more
parameters sanity checks to the latter.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/bus.c |   89 ++++++++++++++++++++++++++++++-----------------------
 1 file changed, 52 insertions(+), 37 deletions(-)

--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -195,52 +195,67 @@ static void acpi_dump_osc_data(acpi_hand
 			 OSC_INVALID_REVISION_ERROR | \
 			 OSC_CAPABILITIES_MASK_ERROR)
 
-acpi_status acpi_run_osc(acpi_handle handle, struct acpi_osc_context *context)
+static int acpi_eval_osc(acpi_handle handle, guid_t *guid, int rev,
+			 struct acpi_buffer *cap,
+			 union acpi_object in_params[static 4],
+			 struct acpi_buffer *output)
 {
-	acpi_status status;
 	struct acpi_object_list input;
-	union acpi_object in_params[4];
 	union acpi_object *out_obj;
+	acpi_status status;
+
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
+	input.pointer = in_params;
+	input.count = 4;
+
+	output->length = ACPI_ALLOCATE_BUFFER;
+	output->pointer = NULL;
+
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
+	}
+
+	return 0;
+}
+
+acpi_status acpi_run_osc(acpi_handle handle, struct acpi_osc_context *context)
+{
+	union acpi_object in_params[4], *out_obj;
+	struct acpi_buffer output;
+	acpi_status status = AE_OK;
 	guid_t guid;
 	u32 errors;
-	struct acpi_buffer output = {ACPI_ALLOCATE_BUFFER, NULL};
+	int ret;
 
-	if (!context)
+	if (!context || !context->cap.pointer ||
+	    context->cap.length < 2 * sizeof(32) ||
+	    guid_parse(context->uuid_str, &guid))
+		return AE_BAD_PARAMETER;
+
+	ret = acpi_eval_osc(handle, &guid, context->rev, &context->cap,
+			    in_params, &output);
+	if (ret)
 		return AE_ERROR;
-	if (guid_parse(context->uuid_str, &guid))
-		return AE_ERROR;
-	context->ret.length = ACPI_ALLOCATE_BUFFER;
-	context->ret.pointer = NULL;
-
-	/* Setting up input parameters */
-	input.count = 4;
-	input.pointer = in_params;
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
-
-	if (!output.length)
-		return AE_NULL_OBJECT;
 
 	out_obj = output.pointer;
-	if (out_obj->type != ACPI_TYPE_BUFFER
-		|| out_obj->buffer.length != context->cap.length) {
-		acpi_handle_debug(handle, "_OSC evaluation returned wrong type");
-		acpi_dump_osc_data(handle, &guid, context->rev, &context->cap);
-		status = AE_TYPE;
-		goto out_kfree;
-	}
 	/* Only take defined error bits into account. */
 	errors = *((u32 *)out_obj->buffer.pointer) & OSC_ERROR_MASK;
 	/* If OSC_QUERY_ENABLE is set, ignore the "capabilities masked" bit. */




