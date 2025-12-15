Return-Path: <linux-pci+bounces-43049-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 010EACBE1EC
	for <lists+linux-pci@lfdr.de>; Mon, 15 Dec 2025 14:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E0470300BA3B
	for <lists+linux-pci@lfdr.de>; Mon, 15 Dec 2025 13:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27614329C7D;
	Mon, 15 Dec 2025 13:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B3fjOKr+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44C13271F8;
	Mon, 15 Dec 2025 13:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765805823; cv=none; b=JpmSadeqfmLk+N2FP5E/gSjAortlppnTwkz003+upUnhZjHbCbSBDIG6bCXZ1yJpkYHglrDWGjUBNfoWlc/i3dOdyOhVbW8WuXdNYyWXn73eEyeiRLrGGmXI6nGqkrVIqGkXOQiZgj2EPIraoBd2JbJctguu30A7ROuJrcn9W70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765805823; c=relaxed/simple;
	bh=dw7kto88kFWurDgt8zAtj6vTPTeG4AVtsVhqvtc+6bE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mxFHL/uuYEQtgzGRM0bcuVQfajLMLqz1T1COMHxUuA7U7NGMIPnZDo4vVIskqUPOWSnxYSsI+gRpGj/pgEiVeEU6BxQ9UQ9s6Lk1HGiARcfqK5jKIOvZMgQ4XS5Yy25eVKOMPTmtnW3ESl+fwuKvLppKwcMrIe05WXGXz6U230U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B3fjOKr+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28979C4CEFB;
	Mon, 15 Dec 2025 13:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765805822;
	bh=dw7kto88kFWurDgt8zAtj6vTPTeG4AVtsVhqvtc+6bE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B3fjOKr+413agK/7nJKJHCXlkGOwmTVGV/Vpp7B6tGenNu5PU4yOCeq3KP8xd9XP4
	 yWlkOukRqmv2wL1MtbX5Gp6OazvywqSsOERjFmRSi0UeFxr6MTNLGj9xjmkAjbjY9h
	 L0oKi6fCDSStXg75Fv558+kbAh5HpdXtk2lXVL4nesAz2Kfxu6TnW86OViOUusAwnj
	 rtE2LhST0D0mMmx+l/rGEOZfCCNoo9VEdBqLbsLuuhF9xFz8xCmdgu32Pvm/ugWXzM
	 0l9QaqwZxVrMsA4ejsRejh9Z8KDKyLOn1I25flq9PKqVSx1MDrsT75+eO+U2tW6Pet
	 cObMku/6JM/zg==
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
 [PATCH v1 3/4] platform/x86/intel/vbtn: Stop creating a platform device
Date: Mon, 15 Dec 2025 14:35:44 +0100
Message-ID: <8661724.NyiUUSuA9g@rafael.j.wysocki>
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
virtual button array platform devices should be created by the ACPI
core, so the driver does not need to attempt to create a platform
device by itself.

Accordingly, make it stop doing so.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/platform/x86/intel/vbtn.c |   30 +-----------------------------
 1 file changed, 1 insertion(+), 29 deletions(-)

--- a/drivers/platform/x86/intel/vbtn.c
+++ b/drivers/platform/x86/intel/vbtn.c
@@ -390,32 +390,4 @@ static struct platform_driver intel_vbtn
 	.remove = intel_vbtn_remove,
 };
 
-static acpi_status __init
-check_acpi_dev(acpi_handle handle, u32 lvl, void *context, void **rv)
-{
-	const struct acpi_device_id *ids = context;
-	struct acpi_device *dev = acpi_fetch_acpi_dev(handle);
-
-	if (dev && acpi_match_device_ids(dev, ids) == 0)
-		if (!IS_ERR_OR_NULL(acpi_create_platform_device(dev, NULL)))
-			dev_info(&dev->dev,
-				 "intel-vbtn: created platform device\n");
-
-	return AE_OK;
-}
-
-static int __init intel_vbtn_init(void)
-{
-	acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
-			    ACPI_UINT32_MAX, check_acpi_dev, NULL,
-			    (void *)intel_vbtn_ids, NULL);
-
-	return platform_driver_register(&intel_vbtn_pl_driver);
-}
-module_init(intel_vbtn_init);
-
-static void __exit intel_vbtn_exit(void)
-{
-	platform_driver_unregister(&intel_vbtn_pl_driver);
-}
-module_exit(intel_vbtn_exit);
+module_platform_driver(intel_vbtn_pl_driver);




