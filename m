Return-Path: <linux-pci+bounces-43333-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB8DCCD9B5
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 21:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7AC9830572CB
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 20:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07EAE34AB1D;
	Thu, 18 Dec 2025 20:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OSaPX/Zv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBAC34AB14;
	Thu, 18 Dec 2025 20:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766090609; cv=none; b=Av7k8mqPCrBXE9q+yiUjdsGMGujqYatf3yWViG+ZSdYE27711kWHeHVFMPOVlcW1rKcCBYTTW6w7zWzvPEDNz6eWlHuvLclQRJq7EsFbLIx7Jgz1ffeLrLSj4GiYnNwU3aoA0PRukGgridWW8DU5xFqvLrBsABA72eBkYoHWhYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766090609; c=relaxed/simple;
	bh=F83hFCO2otBSiK8w3nqcSd+WXOlzEZ7ZQ5/sUZMF5Pk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uwi69N2QDr+xubI59IB2hvCHhV/92aT1VzZcp/YCNrcxDhv+TGLBFyRd1qiMPHYALY4wod7QaMRayP0ezOlY0Lm6Luwok045+Pf4JUEgkANGeOOaY93O01cS0Yq/Qs86zA9/wO6zmZ4GVxaxpl9XBkff5pvX3L1FcK3POQiixtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OSaPX/Zv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 379FAC4CEFB;
	Thu, 18 Dec 2025 20:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766090609;
	bh=F83hFCO2otBSiK8w3nqcSd+WXOlzEZ7ZQ5/sUZMF5Pk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OSaPX/Zvt7QNQe9v+pxojVJ3KzplvaxBj3SKsbRHEQHi/Ie9uqfPbyOxPNhX8snZv
	 StCvMHQeQR9pF2O7SNupHMQ90F3n/z21vbZ0WUJKkgMNDdqXcHSpIdPVFBabXyRZb/
	 6btbzI8apdPqBh7ofPdCzQ+Sfv2N8DJkBRUiskG821ulmfc3JCOoKJRarAM7AXECSX
	 qjf5J1WupcPKQ89/gMk54oZf33p2lNzXP7aJgDBsmlwrqNHvqkpSxriOkQtWqZ2zgd
	 7TqYyGJWw21Z8BQU1Se2a87KzWUQW0jLKj2htSwwOlXpVlp3iwLwXghUXZtT09v+vx
	 WOosOiyRSEwkg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Hans de Goede <hansg@kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
Subject:
 [PATCH v1 2/8] ACPI: bus: Rework printing debug messages on _OSC errors
Date: Thu, 18 Dec 2025 21:35:27 +0100
Message-ID: <3036574.e9J7NaK4W3@rafael.j.wysocki>
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

Instead of using one function, acpi_print_osc_error(), for printing a
debug message and dumping the _OSC request data in one go, use
acpi_handle_debug() directly for printing messages and a separate
function called acpi_dump_osc_data() for dumping the _OSC request data
after printing one or more of them.

This allows the message printing in the _OSC handling code to be
organized so that the messages printed by it are easier to parse.

Also, use %pUL for UUID printing instead of printing UUIDs as strings
and include the revision number into the dumped _OSC request data.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/bus.c |   35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -180,18 +180,15 @@ void acpi_bus_detach_private_data(acpi_h
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
+	for (i = 0; i < cap->length / sizeof(u32); i++)
+		acpi_handle_debug(handle, "(%pUL, %d): capabilities DWORD %i: [%08x]\n",
+				  guid, rev, i, capbuf[i]);
 }
 
 #define OSC_ERROR_MASK 	(OSC_REQUEST_ERROR | OSC_INVALID_UUID_ERROR | \
@@ -239,8 +236,8 @@ acpi_status acpi_run_osc(acpi_handle han
 	out_obj = output.pointer;
 	if (out_obj->type != ACPI_TYPE_BUFFER
 		|| out_obj->buffer.length != context->cap.length) {
-		acpi_print_osc_error(handle, context,
-			"_OSC evaluation returned wrong type");
+		acpi_handle_debug(handle, "_OSC evaluation returned wrong type");
+		acpi_dump_osc_data(handle, &guid, context->rev, &context->cap);
 		status = AE_TYPE;
 		goto out_kfree;
 	}
@@ -252,18 +249,18 @@ acpi_status acpi_run_osc(acpi_handle han
 
 	if (errors) {
 		if (errors & OSC_REQUEST_ERROR)
-			acpi_print_osc_error(handle, context,
-				"_OSC request failed");
+			acpi_handle_debug(handle, "_OSC request failed");
+
 		if (errors & OSC_INVALID_UUID_ERROR)
-			acpi_print_osc_error(handle, context,
-				"_OSC invalid UUID");
+			acpi_handle_debug(handle, "_OSC invalid UUID");
+
 		if (errors & OSC_INVALID_REVISION_ERROR)
-			acpi_print_osc_error(handle, context,
-				"_OSC invalid revision");
+			acpi_handle_debug(handle, "_OSC invalid revision");
+
 		if (errors & OSC_CAPABILITIES_MASK_ERROR)
-			acpi_print_osc_error(handle, context,
-				"_OSC capability bits masked");
+			acpi_handle_debug(handle, "_OSC capability bits masked");
 
+		acpi_dump_osc_data(handle, &guid, context->rev, &context->cap);
 		status = AE_ERROR;
 		goto out_kfree;
 	}




