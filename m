Return-Path: <linux-pci+bounces-43539-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC14CD6F20
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 20:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 887DC3001004
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 19:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4DC82F3C1D;
	Mon, 22 Dec 2025 19:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="inAcqpNC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70037A937;
	Mon, 22 Dec 2025 19:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766431612; cv=none; b=jDPSYYCk3QuK/ax3JKQpDK/bDlqtnHomxx9l94ZDKzLuxkeNI5IDjE3Nw3UfAXWB0rk29cNCYWm2SEpYr80Z6yzdolf2yMvhFxVzo4okE0ZRsYOCpxISswUsXETnPf+uK3hpIgGBIZ+zR2ggwq/osDjetjr85/zSKgfWvZYzYiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766431612; c=relaxed/simple;
	bh=rDhkT0HQ1iBq/wrFOriyjXPcNHfLbGX7ByngFKWux/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hRmdmtBvDcXzKAAMZMbwvDLoLDwcyxmRqg4uNxfQZghYo6nXx6z+mqSIblqk/nmHppZ6b58XBlRxn14s1SNOY+vSA2jr33CAkeBdu00UALzu6rrbFyYyXvV1cr9qXT5Ssv9oPClYK408ODned3tRFq5oLgJtTvjunNFTMTVAPb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=inAcqpNC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F8C9C4CEF1;
	Mon, 22 Dec 2025 19:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766431612;
	bh=rDhkT0HQ1iBq/wrFOriyjXPcNHfLbGX7ByngFKWux/M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=inAcqpNCm/K+t2Hl+4TcVHw4z9lEjIAlmXnSxUZ5M8lo8PUQgrYfquhEoDvIQVnMG
	 9KDHaXegb99vmZksLnqIBx0hilDqr491jJOXlUoceETWOAqgJkS8viXNP6VML2dnJf
	 ZkMt/Na9wuJnIe+mhBYXk/ACiBvXyM8a320BufNKRtpK61X7EUC1EXTFEtuU0jq5fm
	 H0Epey7Pia5AzLJFYR+db0ZtI4rRgJp5tJQpDei8JQHQUszsb9ILirmjZP7vGXOPhv
	 oPXBySrjyoYKaGBiXNuhUyecPIi2Ut89cY/x0SPCGtyndhGVqEp4jBmS1cjw6EH0nM
	 UBwkU9s1KQB9w==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Hans de Goede <hansg@kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
Subject:
 [PATCH v2.1 8/8] ACPI: bus: Rework the handling of \_SB._OSC USB4 features
Date: Mon, 22 Dec 2025 20:26:36 +0100
Message-ID: <3879947.MHq7AAxBmi@rafael.j.wysocki>
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

Use acpi_osc_handshake() introduced previously for implementing the
\_SB._OSC USB4 features control negotiation.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---

v1 -> v2.1:
   * Drop a redundant local variable.
   * Add R-by from Jonathan (assuming it still applies).

---
 drivers/acpi/bus.c |   58 +++++++----------------------------------------------
 1 file changed, 8 insertions(+), 50 deletions(-)

--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -528,19 +528,15 @@ static void acpi_bus_decode_usb_osc(cons
 	       (bits & OSC_USB_XDOMAIN) ? '+' : '-');
 }
 
-static u8 sb_usb_uuid_str[] = "23A0D13A-26AB-486C-9C5F-0FFA525A575A";
 static void acpi_bus_osc_negotiate_usb_control(void)
 {
-	u32 capbuf[3], *capbuf_ret;
-	struct acpi_osc_context context = {
-		.uuid_str = sb_usb_uuid_str,
-		.rev = 1,
-		.cap.length = sizeof(capbuf),
-		.cap.pointer = capbuf,
+	static const u8 sb_usb_uuid_str[] = "23A0D13A-26AB-486C-9C5F-0FFA525A575A";
+	u32 capbuf[3], control;
+	struct acpi_buffer cap = {
+		.pointer = capbuf,
+		.length = sizeof(capbuf),
 	};
 	acpi_handle handle;
-	acpi_status status;
-	u32 control;
 
 	if (!osc_sb_native_usb4_support_confirmed)
 		return;
@@ -551,54 +547,16 @@ static void acpi_bus_osc_negotiate_usb_c
 	control = OSC_USB_USB3_TUNNELING | OSC_USB_DP_TUNNELING |
 		  OSC_USB_PCIE_TUNNELING | OSC_USB_XDOMAIN;
 
-	/*
-	 * Run _OSC first with query bit set, trying to get control over
-	 * all tunneling. The platform can then clear out bits in the
-	 * control dword that it does not want to grant to the OS.
-	 */
-	capbuf[OSC_QUERY_DWORD] = OSC_QUERY_ENABLE;
 	capbuf[OSC_SUPPORT_DWORD] = 0;
 	capbuf[OSC_CONTROL_DWORD] = control;
 
-	status = acpi_run_osc(handle, &context);
-	if (ACPI_FAILURE(status))
+	if (acpi_osc_handshake(handle, sb_usb_uuid_str, 1, &cap))
 		return;
 
-	if (context.ret.length != sizeof(capbuf)) {
-		pr_info("USB4 _OSC: returned invalid length buffer\n");
-		goto out_free;
-	}
-
-	/*
-	 * Run _OSC again now with query bit clear and the control dword
-	 * matching what the platform granted (which may not have all
-	 * the control bits set).
-	 */
-	capbuf_ret = context.ret.pointer;
-
-	capbuf[OSC_QUERY_DWORD] = 0;
-	capbuf[OSC_CONTROL_DWORD] = capbuf_ret[OSC_CONTROL_DWORD];
-
-	kfree(context.ret.pointer);
-
-	status = acpi_run_osc(handle, &context);
-	if (ACPI_FAILURE(status))
-		return;
-
-	if (context.ret.length != sizeof(capbuf)) {
-		pr_info("USB4 _OSC: returned invalid length buffer\n");
-		goto out_free;
-	}
-
-	osc_sb_native_usb4_control =
-		control & acpi_osc_ctx_get_pci_control(&context);
+	osc_sb_native_usb4_control = capbuf[OSC_CONTROL_DWORD];
 
 	acpi_bus_decode_usb_osc("USB4 _OSC: OS supports", control);
-	acpi_bus_decode_usb_osc("USB4 _OSC: OS controls",
-				osc_sb_native_usb4_control);
-
-out_free:
-	kfree(context.ret.pointer);
+	acpi_bus_decode_usb_osc("USB4 _OSC: OS controls", osc_sb_native_usb4_control);
 }
 
 /* --------------------------------------------------------------------------




