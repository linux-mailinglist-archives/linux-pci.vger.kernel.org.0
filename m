Return-Path: <linux-pci+bounces-43727-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7930BCDEBEE
	for <lists+linux-pci@lfdr.de>; Fri, 26 Dec 2025 14:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6967230084D6
	for <lists+linux-pci@lfdr.de>; Fri, 26 Dec 2025 13:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867D628D83E;
	Fri, 26 Dec 2025 13:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k27WT8NC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591577081A;
	Fri, 26 Dec 2025 13:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766756930; cv=none; b=RVGb1CsbeRicGN9x40F87JVcjbdLVbR8ldr10rOx3m9ME03ycO/EG6/KKxyFOCI0NZoXoEWnKQgtDQcC2w5fDVZOupkU5aZeM78wZSQgMGgNsZlxLR1vCGrcoFzL19r9kavwJbrLbCAp+2ULA0Ofq5i38cXDBY/afkal7GVrEZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766756930; c=relaxed/simple;
	bh=8zJCHvhYtm9SFFBd33jKfljlQCKJ2vh9TxB+oxR4ZU8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=I0BQ1QzKhk/JxtzCBdMraFIV4xc1Y9vegjU6JmhC9pqbhlaJhSrK/AcDqWCUwcu1HQlOku487JZFNmHbvClGvKuLjQ5SnP/x/A+lHWSdxjqKYt8u78RSIq2jdUoE0RIrClLNZ7AE69/dhkl5kDDFLeaxu0VXUB81ddCsQjAAAs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k27WT8NC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41A69C4CEF7;
	Fri, 26 Dec 2025 13:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766756929;
	bh=8zJCHvhYtm9SFFBd33jKfljlQCKJ2vh9TxB+oxR4ZU8=;
	h=From:To:Cc:Subject:Date:From;
	b=k27WT8NCVYj8NcLmJMbp0ij1jGyZY52t4Z5KKAC6ERfKMwmDO5F/kJIseAoXXIlBn
	 aBmrQL9nJabg6KKhc2cgkXYGQPycxHwIQJUaSYtLkZGzsrgUCpoQHhtY2dL21xwL6o
	 PWu6Dd09iqB/omSjYY0/cjN5+XEaRiyI5ZMBDgHcUl/+6As8c5l+vR06J45eCBBHZE
	 VBwB5NOJkugMTfunPo91EOSeT5Vsh71hWYH/7IP0McF/+VSENSA+h414VXIBQHujgA
	 1SU6Fle1rUsYic1yB6CR2ln75xL1fsKNupHWC9oYQ/lBkV8GgplxB+hdU3mG3eTru8
	 Z7IgboaTXvXnw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>,
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
 LKML <linux-kernel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>,
 Bjorn Helgaas <helgaas@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Hans de Goede <hansg@kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v1] ACPI: bus: Adjust acpi_osc_handshake() parameter list
Date: Fri, 26 Dec 2025 14:48:45 +0100
Message-ID: <12833187.O9o76ZdvQC@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

For the sake of interface cleanliness, it is better to avoid using
ACPICA data types in the parameter lists of helper functions that
don't belong to ACPICA, so adjust the parameter list of recently
introduced acpi_osc_handshake() to take a capabilities buffer pointer
and the size of the buffer (in u32 size units) as parameters directly
instead of a struct acpi_buffer pointer.

This is also somewhat more straightforward on the caller side because
they won't need to create struct acpi_buffer objects themselves to pass
them to the helper function and it guarantees that the size of the
buffer in bytes will always be a multiple of 4 (the size of u32).

Moreover, it addresses a premature cap pointer dereference and
eliminates a sizeof(32) that should have been sizeof(u32) [1].

Fixes: e5322888e6bf ("ACPI: bus: Rework the handling of \_SB._OSC platform features")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/linux-acpi/202512242052.W4GhDauV-lkp@intel.com/
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/bus.c |   30 ++++++++++++------------------
 1 file changed, 12 insertions(+), 18 deletions(-)

--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -326,31 +326,33 @@ out:
 EXPORT_SYMBOL(acpi_run_osc);
 
 static int acpi_osc_handshake(acpi_handle handle, const char *uuid_str,
-			      int rev, struct acpi_buffer *cap)
+			      int rev, u32 *capbuf, size_t bufsize)
 {
 	union acpi_object in_params[4], *out_obj;
-	size_t bufsize = cap->length / sizeof(u32);
 	struct acpi_object_list input;
+	struct acpi_buffer cap = {
+		.pointer = capbuf,
+		.length = bufsize * sizeof(32),
+	};
 	struct acpi_buffer output;
-	u32 *capbuf, *retbuf, test;
+	u32 *retbuf, test;
 	guid_t guid;
 	int ret, i;
 
-	if (!cap || cap->length < 2 * sizeof(32) || guid_parse(uuid_str, &guid))
+	if (!capbuf || bufsize < 2 || guid_parse(uuid_str, &guid))
 		return -EINVAL;
 
 	/* First evaluate _OSC with OSC_QUERY_ENABLE set. */
-	capbuf = cap->pointer;
 	capbuf[OSC_QUERY_DWORD] = OSC_QUERY_ENABLE;
 
-	ret = acpi_eval_osc(handle, &guid, rev, cap, in_params, &output);
+	ret = acpi_eval_osc(handle, &guid, rev, &cap, in_params, &output);
 	if (ret)
 		return ret;
 
 	out_obj = output.pointer;
 	retbuf = (u32 *)out_obj->buffer.pointer;
 
-	if (acpi_osc_error_check(handle, &guid, rev, cap, retbuf)) {
+	if (acpi_osc_error_check(handle, &guid, rev, &cap, retbuf)) {
 		ret = -ENODATA;
 		goto out;
 	}
@@ -403,7 +405,7 @@ static int acpi_osc_handshake(acpi_handl
 		 */
 		acpi_handle_err(handle, "_OSC: errors while processing control request\n");
 		acpi_handle_err(handle, "_OSC: some features may be missing\n");
-		acpi_osc_error_check(handle, &guid, rev, cap, retbuf);
+		acpi_osc_error_check(handle, &guid, rev, &cap, retbuf);
 	}
 
 out:
@@ -446,10 +448,6 @@ static void acpi_bus_osc_negotiate_platf
 {
 	static const u8 sb_uuid_str[] = "0811B06E-4A27-44F9-8D60-3CBBC22E7B48";
 	u32 capbuf[2], feature_mask;
-	struct acpi_buffer cap = {
-		.pointer = capbuf,
-		.length = sizeof(capbuf),
-	};
 	acpi_handle handle;
 
 	feature_mask = OSC_SB_PR3_SUPPORT | OSC_SB_HOTPLUG_OST_SUPPORT |
@@ -497,7 +495,7 @@ static void acpi_bus_osc_negotiate_platf
 
 	acpi_handle_info(handle, "platform _OSC: OS support mask [%08x]\n", feature_mask);
 
-	if (acpi_osc_handshake(handle, sb_uuid_str, 1, &cap))
+	if (acpi_osc_handshake(handle, sb_uuid_str, 1, capbuf, 2))
 		return;
 
 	feature_mask = capbuf[OSC_SUPPORT_DWORD];
@@ -532,10 +530,6 @@ static void acpi_bus_osc_negotiate_usb_c
 {
 	static const u8 sb_usb_uuid_str[] = "23A0D13A-26AB-486C-9C5F-0FFA525A575A";
 	u32 capbuf[3], control;
-	struct acpi_buffer cap = {
-		.pointer = capbuf,
-		.length = sizeof(capbuf),
-	};
 	acpi_handle handle;
 
 	if (!osc_sb_native_usb4_support_confirmed)
@@ -550,7 +544,7 @@ static void acpi_bus_osc_negotiate_usb_c
 	capbuf[OSC_SUPPORT_DWORD] = 0;
 	capbuf[OSC_CONTROL_DWORD] = control;
 
-	if (acpi_osc_handshake(handle, sb_usb_uuid_str, 1, &cap))
+	if (acpi_osc_handshake(handle, sb_usb_uuid_str, 1, capbuf, 3))
 		return;
 
 	osc_sb_native_usb4_control = capbuf[OSC_CONTROL_DWORD];




