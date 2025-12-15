Return-Path: <linux-pci+bounces-43050-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6DFCBE216
	for <lists+linux-pci@lfdr.de>; Mon, 15 Dec 2025 14:49:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0CAAA305114A
	for <lists+linux-pci@lfdr.de>; Mon, 15 Dec 2025 13:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69EA132ED3F;
	Mon, 15 Dec 2025 13:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XSj1NYem"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47E732D45C;
	Mon, 15 Dec 2025 13:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765805827; cv=none; b=tE7epLr4bHnx/3fWg8pGIw24zD/Dp8pGc1Nio4awH5z2LNZfV37UzNlZlZ0tYvwLD8GiiqjQZcZWG90y//ndRNk66zYFoLK/uJvDtptI3GWVUzpORtHM1hiZgqni6ehJO09Q1J7PPzI9qbSpO5qHzghGi8MWzzBEKXvGSvOVTS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765805827; c=relaxed/simple;
	bh=ESWItFErJjVB3S0WTRPFMd+y/OS75/Vk7cSeXbAP39k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OavVCap7MLO0g/WEYIze+jtHtfHI0y+AebT9CV6i5mkpKTUoPugRIRRYMVZO/D83Fc3DCFMttP1NX5Vm3/8HM0cKz36ymfn37XfQKKBdixtLHOF1ASj8da94UvbolqMRqrUOCEuxInmFlh6qaCTxDQu6jmaDvSryIBNAwB81VCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XSj1NYem; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4719EC4CEF5;
	Mon, 15 Dec 2025 13:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765805826;
	bh=ESWItFErJjVB3S0WTRPFMd+y/OS75/Vk7cSeXbAP39k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XSj1NYemPvGIE61tO/hOcufWRcvCOk7HhAKaDLxu4QVWlhZyrnCpXuwz16lAF49VL
	 hO7u+0xWMkPSL1jXnMmaC6UaZ2WhXRb/6Bh3ctm3gRvgIfn91CYyY69QRS4151toYW
	 2DpQbAtQm7+icY6lS8CEJ9JbrA3i9+OgtXhZ7cSkMcI/vJoXiGcw2UBgMjJeUSkHQK
	 T3ozMxQE7reQWoZvdK2NIW1f1b8TB9sLki+rx6VgjJZNfHDrDgJoRip337xPQhyjvb
	 wiD/x2/AxtgCj3lcpeVIki8/SLmMRYDEQI1+T5zPSsA6t1sXzcJSV89ux++FTH+nwo
	 OwQDj+5JL9RAQ==
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
Subject:
 [PATCH v1 2/4] platform/x86/intel/hid: Stop creating a platform device
Date: Mon, 15 Dec 2025 14:35:05 +0100
Message-ID: <6115868.MhkbZ0Pkbq@rafael.j.wysocki>
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
are not claimed by the PNP ACPI scan handler any more and the Intel
HID platform devices should be created by the ACPI core, so the
driver does not need to attempt to create a platform device by
itself.

Accordingly, make it stop doing so.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/platform/x86/intel/hid.c |   41 ---------------------------------------
 1 file changed, 1 insertion(+), 40 deletions(-)

--- a/drivers/platform/x86/intel/hid.c
+++ b/drivers/platform/x86/intel/hid.c
@@ -767,43 +767,4 @@ static struct platform_driver intel_hid_
 	.remove = intel_hid_remove,
 };
 
-/*
- * Unfortunately, some laptops provide a _HID="INT33D5" device with
- * _CID="PNP0C02".  This causes the pnpacpi scan driver to claim the
- * ACPI node, so no platform device will be created.  The pnpacpi
- * driver rejects this device in subsequent processing, so no physical
- * node is created at all.
- *
- * As a workaround until the ACPI core figures out how to handle
- * this corner case, manually ask the ACPI platform device code to
- * claim the ACPI node.
- */
-static acpi_status __init
-check_acpi_dev(acpi_handle handle, u32 lvl, void *context, void **rv)
-{
-	const struct acpi_device_id *ids = context;
-	struct acpi_device *dev = acpi_fetch_acpi_dev(handle);
-
-	if (dev && acpi_match_device_ids(dev, ids) == 0)
-		if (!IS_ERR_OR_NULL(acpi_create_platform_device(dev, NULL)))
-			dev_info(&dev->dev,
-				 "intel-hid: created platform device\n");
-
-	return AE_OK;
-}
-
-static int __init intel_hid_init(void)
-{
-	acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
-			    ACPI_UINT32_MAX, check_acpi_dev, NULL,
-			    (void *)intel_hid_ids, NULL);
-
-	return platform_driver_register(&intel_hid_pl_driver);
-}
-module_init(intel_hid_init);
-
-static void __exit intel_hid_exit(void)
-{
-	platform_driver_unregister(&intel_hid_pl_driver);
-}
-module_exit(intel_hid_exit);
+module_platform_driver(intel_hid_pl_driver);




