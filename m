Return-Path: <linux-pci+bounces-43146-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9B2CC5149
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 21:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7581D30021D7
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 20:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3C225785D;
	Tue, 16 Dec 2025 20:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L/1J/EmA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49891212552;
	Tue, 16 Dec 2025 20:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765916335; cv=none; b=MKW6Uwaw229faqmAot0cQZ92Q3D9TdxwNsKmAQwY+I7PJjyZtCzurb4ds+2/V8mnG5DtxJy+RRqT/gV+mNFZHAYRkZwaR5YcoOdnyhj2Cpy3EdvIc3U2G2/W/aGzenhzBfEfI6KNuQ/jP02HBnqeB5IkXIO94PYzspTJEPRKYEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765916335; c=relaxed/simple;
	bh=2s0sPyBtRnYTM5LGWzEOa2qJbCQASXMLLhvp7EDkT/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mCupkIu4NBrDPCMWyRYeo+RLuWiDal0bnkeeN0uQdIPL0KhzxHAkI3+MAm2EibS0eKGrK509JyNy3CpxDRdqGjevhXdANlpTcLMFoP5cmACjP9B0JYwoH26XE7lf482hZqH8/0RpBV5SE8mwWf9IBg9iCs7Dg3BGpdvS6+eI8j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L/1J/EmA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2D11C4CEF1;
	Tue, 16 Dec 2025 20:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765916334;
	bh=2s0sPyBtRnYTM5LGWzEOa2qJbCQASXMLLhvp7EDkT/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L/1J/EmATRkWtSekpzzpVhCFQIfqFXfNxBEB4LOCK/IToRI5P3sedqM7xGjFNtnrW
	 epUYnaY2eKJgQTEE4SipQMs2j0O//UK6IGl4XeTkOGhq5b+AhJ7iQcbyhDUn0ZH8K3
	 Y5L/gGZoL1EhBIUmvMOKAuxctP+miS6tGqQ0P+mv9eeYooqp90KQWSyJoiFrHgrHe1
	 QTfS2Hq8PO/Q+ee9I+ZO6tnJhISMn+PRrdGQk9OM8gghiw4tZQIgrVH4sWgePHdGwK
	 HCZ7mMT40RKnCOGcRujDwdIlshD7Yh2fSvBEet2SsRCTTceYsq52lprB83G0vzFmrP
	 s4iDb1jp2xUDg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Hans de Goede <hansg@kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
Subject:
 [PATCH v1 2/2] ACPI: bus: Adjust acpi_bus_osc_negotiate_platform_control()
Date: Tue, 16 Dec 2025 21:18:27 +0100
Message-ID: <4703755.LvFx2qVVIh@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <12803663.O9o76ZdvQC@rafael.j.wysocki>
References: <12803663.O9o76ZdvQC@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Remove checks that have become redundant after a previous change from
acpi_bus_osc_negotiate_platform_control(), add a debug statement
regarding the negotiated support bit mask to it and add an empty
code line to it for more clarity.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/bus.c |   28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -319,7 +319,7 @@ bool osc_sb_cppc2_support_acked;
 static u8 sb_uuid_str[] = "0811B06E-4A27-44F9-8D60-3CBBC22E7B48";
 static void acpi_bus_osc_negotiate_platform_control(void)
 {
-	u32 capbuf[2], *capbuf_ret;
+	u32 capbuf[2], *capbuf_ret, ret_support;
 	struct acpi_osc_context context = {
 		.uuid_str = sb_uuid_str,
 		.rev = 1,
@@ -371,6 +371,7 @@ static void acpi_bus_osc_negotiate_platf
 
 	if (!ghes_disable)
 		capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_APEI_SUPPORT;
+
 	if (ACPI_FAILURE(acpi_get_handle(NULL, "\\_SB", &handle)))
 		return;
 
@@ -378,10 +379,9 @@ static void acpi_bus_osc_negotiate_platf
 		return;
 
 	capbuf_ret = context.ret.pointer;
-	if (context.ret.length <= OSC_SUPPORT_DWORD) {
-		kfree(context.ret.pointer);
-		return;
-	}
+
+	acpi_handle_debug(handle, "Negotiated _OSC mask [%04x]\n",
+			  capbuf_ret[OSC_SUPPORT_DWORD]);
 
 	/*
 	 * Now run _OSC again with query flag clear and with the caps
@@ -395,20 +395,14 @@ static void acpi_bus_osc_negotiate_platf
 		return;
 
 	capbuf_ret = context.ret.pointer;
-	if (context.ret.length > OSC_SUPPORT_DWORD) {
+	ret_support = capbuf_ret[OSC_SUPPORT_DWORD];
 #ifdef CONFIG_ACPI_CPPC_LIB
-		osc_sb_cppc2_support_acked = capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_CPCV2_SUPPORT;
+	osc_sb_cppc2_support_acked = ret_support & OSC_SB_CPCV2_SUPPORT;
 #endif
-
-		osc_sb_apei_support_acked =
-			capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_APEI_SUPPORT;
-		osc_pc_lpi_support_confirmed =
-			capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_PCLPI_SUPPORT;
-		osc_sb_native_usb4_support_confirmed =
-			capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_NATIVE_USB4_SUPPORT;
-		osc_cpc_flexible_adr_space_confirmed =
-			capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_CPC_FLEXIBLE_ADR_SPACE;
-	}
+	osc_sb_apei_support_acked = ret_support & OSC_SB_APEI_SUPPORT;
+	osc_pc_lpi_support_confirmed = ret_support & OSC_SB_PCLPI_SUPPORT;
+	osc_sb_native_usb4_support_confirmed = ret_support & OSC_SB_NATIVE_USB4_SUPPORT;
+	osc_cpc_flexible_adr_space_confirmed = ret_support & OSC_SB_CPC_FLEXIBLE_ADR_SPACE;
 
 	kfree(context.ret.pointer);
 }




