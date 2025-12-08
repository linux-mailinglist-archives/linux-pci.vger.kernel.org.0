Return-Path: <linux-pci+bounces-42754-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B59CAD1A8
	for <lists+linux-pci@lfdr.de>; Mon, 08 Dec 2025 13:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ECF94300960E
	for <lists+linux-pci@lfdr.de>; Mon,  8 Dec 2025 12:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A101313271;
	Mon,  8 Dec 2025 12:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i5RNLntV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0690A31283F;
	Mon,  8 Dec 2025 12:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765195999; cv=none; b=j2HJYnz1eQmOFY+jgy1ls3lU9+4e8ixjpzk7I6YkFFPcs+T+wGt2QtFhnsRW9q78wRiOxKQcgRhQ3cAu9f46TpUf8sU6onRqdWcwR9RizWbEFQRq65JRncvl45ki126Tpata+SobIkAl2+nCYsNKLBqOMdwvMjsGeEJdTDWwWkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765195999; c=relaxed/simple;
	bh=/Z0hGBldSIp0RNPQfFKQcDun+u8smCEcE6s1NtsTlgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iuY8+bsDdXTm4kbEGeGICJPeKN95z27X1o/oHa5XoJV3rMtf4ITZaVD00e+G8JxJM3vpV9cTwlByedsy9OPw9IxSNa0G0zUjeYAnzs+p+Hj61ifIrRg3O/+l4jvSeM+3es9nRfL0Wjd1yIeMtgjJjYYLSdgRemCxWnr8A1OvVvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i5RNLntV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12431C4CEF1;
	Mon,  8 Dec 2025 12:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765195998;
	bh=/Z0hGBldSIp0RNPQfFKQcDun+u8smCEcE6s1NtsTlgQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i5RNLntVx+d4TxAGfgy44zXFNRWNAiuNzRl/Cxz/Flz+T3qKomGRU7RyyByP1pu0g
	 X6YtIr69mEFZmkLkvOM8Fa16g1Y2Pdl9fu1zKw5mcLn0wwaNwNBOmcJSi+SbfmfMyZ
	 hdaNFVXR1QJuUcfdREDFTwaMXdV29GwVtUFDouclqGvSeMJLEjaUwOjhEnjN41sUHt
	 pgXJeYGFZyJudh3nFhZ1zEEFYGxDDTSNqIJ3gX40PTm4N8ITQULd3vMY6Zwvtv7y1B
	 zR6w/i/9FNemwvaQdw1o6LB9QUcjh7NTFrAxMOrcJesAJ50tNk2t9g7cXh+szvnBs+
	 tRkTYLnxALFPA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Bjorn Helgaas <helgaas@kernel.org>, Armin Wolf <w_armin@gmx.de>
Subject:
 [PATCH v1 2/2] ACPI: PM: Register wakeup sources under physical devices
Date: Mon, 08 Dec 2025 13:13:01 +0100
Message-ID: <3024338.e9J7NaK4W3@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <2395536.ElGaqSPkdT@rafael.j.wysocki>
References: <2395536.ElGaqSPkdT@rafael.j.wysocki>
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




