Return-Path: <linux-pci+bounces-38228-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E95BDEE9E
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 16:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 144814EB62E
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 14:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D57242D91;
	Wed, 15 Oct 2025 14:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OXR3H5aD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A791DF748;
	Wed, 15 Oct 2025 14:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760537123; cv=none; b=Pm1Zg655t+N54YyZvLzAqXuac/D565Bk2ph2uttaTnf4iaZ7eNpluWKnjb03LHzlFsykIBF02d2JTsrEJ/dkRpH/NFpQ7xQ6iqnKtv/TNqj8ujp3tEMkKt3LR0/twyzZLWecot3u8euNOSEhRMLtlkcCZJjBBosk8G31/Zu6yDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760537123; c=relaxed/simple;
	bh=5Ojmj4sxlrJnfMaPuiqa45Z5k6CAnRPeizijVc+oRQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ATcpqTmB61sng1kA6mXXpNT9Du8q6+s+dfq29UGZPwGo0weGZMMiv9OWeGH3wdp9hAcBe2rrt3jKVZmoAm0hJ/TMzEdfpSXPKsqiPW/4gcZPpjlforGEshTQybewQdpM39AF7jooP+AVtX4kfV3DI8ntzmQJlod/wyMexhFarOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OXR3H5aD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FD79C4CEF8;
	Wed, 15 Oct 2025 14:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760537121;
	bh=5Ojmj4sxlrJnfMaPuiqa45Z5k6CAnRPeizijVc+oRQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OXR3H5aDW8cLKRyPvDoxWkXwZC0Pszr/y3LH/8YjeJvTxmUrKXtUgXVT1USQLW8aY
	 dTgdpC0c9vkCVldu0f6bAcoBDgE75N2Yr5guJSQkPy4VII7Iv6IyC5zGPsYh6M71NZ
	 p016Auuk/DXa7vXf4xAfpcttY70eSePUBfOgIptzKwtbDMn0CrPO+Zi84tvFWCUZME
	 ewPBtIe+y8if5AeZZI2s9kRFu/oH4fIZZKtW5jik0jk950M/b0cGU9AU4PK//fUgLD
	 PwjVnyi6nMXi0YwRYSJJ75b9/hy7ieEcObIWuBd92ayHF7YJ4pAm276i8LQ8IIqi42
	 alu5pn8gsY+tw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
 Takashi Iwai <tiwai@suse.de>, LKML <linux-kernel@vger.kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Zhang Qilong <zhangqilong3@huawei.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Frank Li <Frank.Li@nxp.com>,
 Dhruva Gole <d-gole@ti.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Linux ACPI <linux-acpi@vger.kernel.org>
Subject:
 [PATCH v1 2/3] ACPI: TAD: Rearrange runtime PM operations in
 acpi_tad_remove()
Date: Wed, 15 Oct 2025 16:03:25 +0200
Message-ID: <1857660.VLH7GnMWUR@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <3925484.kQq0lBPeGt@rafael.j.wysocki>
References: <3925484.kQq0lBPeGt@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

It is not necessary to resume the device upfront in acpi_tad_remove()
because both acpi_tad_disable_timer() and acpi_tad_clear_status()
attempt to resume it, but it is better to prevent it from suspending
between these calls by incrementing its runtime PM usage counter.

Accordingly, replace the pm_runtime_get_sync() call in acpi_tad_remove()
with a pm_runtime_get_noresume() one and put the latter right before the
first invocation of acpi_tad_disable_timer().

In addition, use pm_runtime_put_noidle() to drop the device's runtime
PM usage counter after using pm_runtime_get_noresume() to bump it up
to follow a common pattern and use pm_runtime_suspend() for suspending
the device afterward.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpi_tad.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/drivers/acpi/acpi_tad.c
+++ b/drivers/acpi/acpi_tad.c
@@ -563,8 +563,6 @@ static void acpi_tad_remove(struct platf
 
 	device_init_wakeup(dev, false);
 
-	pm_runtime_get_sync(dev);
-
 	if (dd->capabilities & ACPI_TAD_RT)
 		sysfs_remove_group(&dev->kobj, &acpi_tad_time_attr_group);
 
@@ -573,6 +571,8 @@ static void acpi_tad_remove(struct platf
 
 	sysfs_remove_group(&dev->kobj, &acpi_tad_attr_group);
 
+	pm_runtime_get_noresume(dev);
+
 	acpi_tad_disable_timer(dev, ACPI_TAD_AC_TIMER);
 	acpi_tad_clear_status(dev, ACPI_TAD_AC_TIMER);
 	if (dd->capabilities & ACPI_TAD_DC_WAKE) {
@@ -580,7 +580,8 @@ static void acpi_tad_remove(struct platf
 		acpi_tad_clear_status(dev, ACPI_TAD_DC_TIMER);
 	}
 
-	pm_runtime_put_sync(dev);
+	pm_runtime_put_noidle(dev);
+	pm_runtime_suspend(dev);
 	pm_runtime_disable(dev);
 	acpi_remove_cmos_rtc_space_handler(handle);
 }




