Return-Path: <linux-pci+bounces-43045-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2F1CBDE40
	for <lists+linux-pci@lfdr.de>; Mon, 15 Dec 2025 13:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D57B8300418B
	for <lists+linux-pci@lfdr.de>; Mon, 15 Dec 2025 12:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652493375C3;
	Mon, 15 Dec 2025 12:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EtHwWrkD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AFD219E8D;
	Mon, 15 Dec 2025 12:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765802990; cv=none; b=MvIsMc5K4IhmuHo3EdSLe8oXhtgBOBcnKQ+wbVXE/ImkgVecN164QZeMk4jxH0YbX9lLiTbHpYv6KP8v+HDST1TLR7pL/9WL1HkXTNC81M7kOX8mYDT7dGnDhBabHvPFPCbEwOLjBos/omW6dY8lvRMntwQRblv2ow8IsJWn/Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765802990; c=relaxed/simple;
	bh=y34gDNX/NijF8ANw4zzTE9qWZWEQPLOvCFS7nEjqPIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bSJ+L9aEpqE5U9rJz5r0lHkTsRzCOPwqW/uut8i+dR1du+I4kVdgpIbOXamOQeq40P/74OXWujWrIHra5iViD+eUP0DHyd2tvb8PEQlIm9FgUYWvZfauX29sHxhq6bNSsfesTP/kLVrRPbYKZ7c+L2RzsKcJ0PTSsu79DNYqMeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EtHwWrkD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5A29C4CEF5;
	Mon, 15 Dec 2025 12:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765802990;
	bh=y34gDNX/NijF8ANw4zzTE9qWZWEQPLOvCFS7nEjqPIY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EtHwWrkDqHKh7BwsV5Sz4LGpu98ncZrqOL8zoXlXXsmNELNMceG9UktNOsdJaci5T
	 DaxcQKyaPiNydKCuzzhfv/TWPi8V6NqBJHLx2+tvdlcKAzn9y82pZWd7uKImU05HPy
	 b4eadZEEl8l06ltPAdPI5Fa65eT87M3Q7G8/aTu279pLxOtzbXn67i+fRajqfcf1Ui
	 2mf3F31KVUC+MnquuiQo9ObQQSAq4IkdjCtmWaCUOX9cM/1SiQ6M3FXxOmyO9d6Jmh
	 5ZVraf/t39Ru17XxM1fHxEqfn1c+UNh5RYrW28Iim82MBKZzvInFCJ4MkJEnY39Sfq
	 dkaZZ2w2N+Qyw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Bjorn Helgaas <helgaas@kernel.org>, Armin Wolf <w_armin@gmx.de>
Subject:
 [RESEND][PATCH v1 2/2] ACPI: PM: Register wakeup sources under physical
 devices
Date: Mon, 15 Dec 2025 13:49:17 +0100
Message-ID: <1944126.tdWV9SEqCh@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <6223429.lOV4Wx5bFT@rafael.j.wysocki>
References: <6223429.lOV4Wx5bFT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Currently, acpi_add_pm_notifier() registers wakeup sources under
ACPI companions of the devices affected by the handling of wakeup
events which goes against the rule that a struct acpi_device
can only be a parent of another struct acpi_device.

Moreover, it would be more logically consistent to register wakeup
sources under the devices affected by wakeup events handling which
would cause them to appear in more suitable places in sysfs and would
help to identify the devices they are associated with more easily.

Accordingly, update acpi_add_pm_notifier() to register wakeup sources
under the "target" devices directly instead of registering them under
the ACPI companions of those devices.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Armin Wolf <W_Armin@gmx.de>
---
 drivers/acpi/device_pm.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -586,8 +586,7 @@ acpi_status acpi_add_pm_notifier(struct
 		goto out;
 
 	mutex_lock(&acpi_pm_notifier_lock);
-	adev->wakeup.ws = wakeup_source_register(&adev->dev,
-						 dev_name(&adev->dev));
+	adev->wakeup.ws = wakeup_source_register(dev, dev_name(&adev->dev));
 	adev->wakeup.context.dev = dev;
 	adev->wakeup.context.func = func;
 	adev->wakeup.flags.notifier_present = true;




