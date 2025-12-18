Return-Path: <linux-pci+bounces-43327-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB08CCD99A
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 21:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C12130BD9C3
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 20:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5FD342509;
	Thu, 18 Dec 2025 20:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DYKq2jzd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C125434214C;
	Thu, 18 Dec 2025 20:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766090590; cv=none; b=NKj6pQ+XlniQIyQbvHQkgJ8xN6oRxMGGrGRbhi2U9DOAM9WWjFuUZoRbMJPMIA4Lf27TfAxOawsGFqdsFlSNzy0I3FEsJR1e9igHChL6RfZ6eZORfeyFdVTVphz0VVeQxKNXEgfE4a46fxT82tqvUZ8mNTACIEuSmrmji7BZ9x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766090590; c=relaxed/simple;
	bh=8zV4UXnuDywnt6A+/vpo61138ZySdS6R2nB/1xd4DpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=em/d8xhMc2R48sclrkKDeSQsK1/q0kesbF+S5uul+5gyOlCMC4rLb4C3KMDmUueszUIDkqQiQ8lidVJtJOx26oIbriIsCWdYYAX00/KYUGxYq6GrjpmzDMi3iHhGQNYi6V7GJ0+US+734+SZs+79cCFFnSAJ6ldc6BKQdefqEPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DYKq2jzd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63401C113D0;
	Thu, 18 Dec 2025 20:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766090590;
	bh=8zV4UXnuDywnt6A+/vpo61138ZySdS6R2nB/1xd4DpM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DYKq2jzdvbf6CvyJRpB7ttvEqP2MaDv7AdWjuCurmqrd06TxfyfOvf9hDIIRRqHwA
	 D39cnT+DZRC4DIeMyjBi4zE72/RF8rOOHZooVrdlLsr8linN+qlbXucCViO7Ywhbyt
	 9jv/5xXQMwaEAyKhraz5UlEH0AFkfahqDLjj/HwBVWQkysvvbMeAK9KlxFsxP7ZQtD
	 1edGx6AvcSpazThIigNG8VMmi9j+2a5gMQ39230bwqySTbOrxEav0/JFl1LejKLUzX
	 29qL11p70M0coC2d006TrdQqq0WjI9BosjXHHf0f34Purx4Yor0gV91FGOmsNa1I2V
	 21W5zHNiH7K8A==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Hans de Goede <hansg@kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
Subject:
 [PATCH v1 8/8] ACPI: bus: Rework the handling of \_SB._OSC USB4 features
Date: Thu, 18 Dec 2025 21:42:32 +0100
Message-ID: <6128656.MhkbZ0Pkbq@rafael.j.wysocki>
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

Use acpi_osc_handshake() introduced previously for implementing the
\_SB._OSC USB4 features control negotiation.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/bus.c |   58 ++++++++---------------------------------------------
 1 file changed, 9 insertions(+), 49 deletions(-)

--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -499,19 +499,15 @@ static void acpi_bus_decode_usb_osc(cons
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
+	u32 capbuf[3], control, granted;
+	struct acpi_buffer cap = {
+		.pointer = capbuf,
+		.length = sizeof(capbuf),
 	};
 	acpi_handle handle;
-	acpi_status status;
-	u32 control;
 
 	if (!osc_sb_native_usb4_support_confirmed)
 		return;
@@ -522,54 +518,18 @@ static void acpi_bus_osc_negotiate_usb_c
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
+	granted = capbuf[OSC_CONTROL_DWORD];
 
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
+	osc_sb_native_usb4_control = control & granted;
 
 	acpi_bus_decode_usb_osc("USB4 _OSC: OS supports", control);
-	acpi_bus_decode_usb_osc("USB4 _OSC: OS controls",
-				osc_sb_native_usb4_control);
-
-out_free:
-	kfree(context.ret.pointer);
+	acpi_bus_decode_usb_osc("USB4 _OSC: OS controls", granted);
 }
 
 /* --------------------------------------------------------------------------




