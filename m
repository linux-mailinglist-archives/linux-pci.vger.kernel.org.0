Return-Path: <linux-pci+bounces-43048-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 834E5CBE23A
	for <lists+linux-pci@lfdr.de>; Mon, 15 Dec 2025 14:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 57BBA3077CDA
	for <lists+linux-pci@lfdr.de>; Mon, 15 Dec 2025 13:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F216F327BF2;
	Mon, 15 Dec 2025 13:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZNAKkxA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D27327202;
	Mon, 15 Dec 2025 13:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765805818; cv=none; b=mNq3U8dllQK9ofHnnUVZzrpQw4aApKlp1zndOwdJ2Iu/rReTfF0t0TRxGnrTT+RvZFoblV3MUBfTgTZJXHT7Exucfs0RaLjNnbU/7F5dP3ipJYXMzWUwwLcMTzAUqx0R3Jcxx9x4TxYcJU56zOBrOWUvfDhiDZsfA5Sn0ixCFnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765805818; c=relaxed/simple;
	bh=SxFIlck54wFFH4N7Ix/Ab4hh95qP/TLreCxLHycXs9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bvRuHf01WB1nEa8qbE6d+RZX2ymJ2R0G7/+lSphXv0ZvV176RJKc87eVe353yyRH79EjUiwLo+VLnq7XX0ZZD/F76ATf89zxiNyQYmXiQTBXXbqgESWyESFHdZFUD/ksWYF/EBXH9MEoFs2AEzfJEoVz8r2y2Tn5BaslJpCDDBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QZNAKkxA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28FC2C4CEF5;
	Mon, 15 Dec 2025 13:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765805818;
	bh=SxFIlck54wFFH4N7Ix/Ab4hh95qP/TLreCxLHycXs9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QZNAKkxAZpy40Lt0lmDglR67L6V96McwexlJfrn5lktJtbJPBDRFsYCwwsJt0PKw0
	 tUZcjqlGrNvclAu8FtU8NHXjQW1LQyjyo554Js2Va1+00v8RKMc0Ae/56+jpdOeEso
	 zk9nlHQNfVvBdwh6tYVPV2oQ13wo3wKhmk1WWedhpFCcqXjmDvfSiqpYojcHOFJd3i
	 +oB70nQdaagJP7787lo3VI6JrZQuMHgZ/HfynWUqqdbxvuRPXXqk+pYRB19TCgHkkj
	 cbZOfNranble9b8JRUgBUa/9tV7UHJyguPLOdr/5w8NOdV6xweI+d3lzCIkptX0v9f
	 4GQXuN4kss42Q==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
 Zhang Rui <rui.zhang@intel.com>, Chen Yu <yu.c.chen@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Linux PCI <linux-pci@vger.kernel.org>, Alex Hung <alexhung@gmail.com>,
 Hans de Goede <hansg@kernel.org>,
 Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 platform-driver-x86@vger.kernel.org, AceLan Kao <acelan.kao@canonical.com>
Subject: [PATCH v1 4/4] ACPI: PNP: Drop acpi_nonpnp_device_ids[]
Date: Mon, 15 Dec 2025 14:36:49 +0100
Message-ID: <3587570.QJadu78ljV@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <7888874.EvYhyI6sBW@rafael.j.wysocki>
References: <7888874.EvYhyI6sBW@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Now that "system" devices are represented as platform devices, they
are not claimed by the PNP ACPI scan handler any more and platform
devices can be created for ACPI device objects listing "system"
device IDs as their compatible device IDs.

Accordingly, it should not be necessary any more to add device IDs
to acpi_nonpnp_device_ids[], so drop it.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpi_pnp.c |   16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

--- a/drivers/acpi/acpi_pnp.c
+++ b/drivers/acpi/acpi_pnp.c
@@ -344,24 +344,10 @@ static bool acpi_pnp_match(const char *i
 	return false;
 }
 
-/*
- * If one of the device IDs below is present in the list of device IDs of a
- * given ACPI device object, the PNP scan handler will not attach to that
- * object, because there is a proper non-PNP driver in the kernel for the
- * device represented by it.
- */
-static const struct acpi_device_id acpi_nonpnp_device_ids[] = {
-	{"INT3F0D"},
-	{"INTC1080"},
-	{"INTC1081"},
-	{"INTC1099"},
-	{""},
-};
-
 static int acpi_pnp_attach(struct acpi_device *adev,
 			   const struct acpi_device_id *id)
 {
-	return !!acpi_match_device_ids(adev, acpi_nonpnp_device_ids);
+	return true;
 }
 
 static struct acpi_scan_handler acpi_pnp_handler = {




