Return-Path: <linux-pci+bounces-38229-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 366E1BDEEA8
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 16:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D130A34D8A6
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 14:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0224C25F98E;
	Wed, 15 Oct 2025 14:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M4KhpLdv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C630F25DB1A;
	Wed, 15 Oct 2025 14:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760537125; cv=none; b=YY20PlODQ7ck9rXJmBA/QcKrsCU9W+q34AS/hgILvsDLtDKtZp077jhGO3WKgTutnJBlG6hbSrcuIVXeEFvuFvw40bUO4rOu7f1W3G7EP+rqSZlXxlrx+WucJjidPkEnm6Aj06F0ea6AlrrbSIkTtco+dMNA5gR9HNDTXjKEO6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760537125; c=relaxed/simple;
	bh=NyChlYLMqbPQjk/D8w0SGG3jttZA3y3O+IKzrW8IDMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WBQpFyiJ3edJBZuMMimxR8XXfcqQ0MNLhJ6YTxvjdKvaSHir1Js48TxwukUH1UrNg34mmh7N1zx9wW1N9h2U+GQUgBXuLS7pURzLyGC7pr8wGz/1qvwR8Wm9qT7BEXzoVp8WKrwv6CD8kmS5Cm0zAepREDflqEn8c49vLVps9DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M4KhpLdv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B9C3C4CEFE;
	Wed, 15 Oct 2025 14:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760537125;
	bh=NyChlYLMqbPQjk/D8w0SGG3jttZA3y3O+IKzrW8IDMo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M4KhpLdvgp+npNk2VUaP8c45S0A2jmQOZawwkhg/zxMONXSgVaPMbrExBDm2Ymc8T
	 zpZArdpgb+pv2r/t6EbCc60pD+F54blfcTgQ2xfao2Saa1lrH8osnSwCmOJqNO5MLr
	 HnIUZQlSlrR2hNzE3aC1hDhY8A4jr1uIymXmmtFrYcPgigrxzmq2cRWdkTeUnwNtDz
	 1ger533lWmEM0UE6Y27xdJ/s/7pDJ+00Lh4TF0xNRz32TZy0j3wpCvm5RuzCseRBmS
	 xow2sYh/A33xiCmZ2W1omMEn3xWzaJaf+MG4Cfo/WIZDSsNUQXwaxDUcPikN33lLp5
	 fajdRBnrHCTkg==
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
 [PATCH v1 1/3] PM: runtime: Introduce PM_RUNTIME_ACQUIRE_OR_FAIL() macro
Date: Wed, 15 Oct 2025 16:02:02 +0200
Message-ID: <3324926.5fSG56mABF@rafael.j.wysocki>
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

There appears to be an emerging pattern in which guard
pm_runtime_active_try is used for resuming the given device and
incrementing its runtime PM usage counter if the resume has been
successful, that is followed by an ACQUIRE_ERR() check on the guard
variable and if that triggers, a specific error code is returned, for
example:

	ACQUIRE(pm_runtime_active_try, pm)(dev);
	if (ACQUIRE_ERR(pm_runtime_active_try, &pm))
		return -ENXIO

Introduce a macro called PM_RUNTIME_ACQUIRE_OR_FAIL() representing the
above sequence of statements that can be used to avoid code duplication
wherever that sequence would be used.

Use this macro right away in the PCI sysfs code where the above pattern
is already present.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

Admittedly, the new macro is slightly on the edge, but it really helps
reduce code duplication, so here it goes.

Any feedback (good, bad, ugly) will be appreciated.

Thanks!

---
 drivers/pci/pci-sysfs.c    |    4 +---
 include/linux/pm_runtime.h |    5 +++++
 2 files changed, 6 insertions(+), 3 deletions(-)

--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1517,9 +1517,7 @@ static ssize_t reset_method_store(struct
 		return count;
 	}
 
-	ACQUIRE(pm_runtime_active_try, pm)(dev);
-	if (ACQUIRE_ERR(pm_runtime_active_try, &pm))
-		return -ENXIO;
+	PM_RUNTIME_ACQUIRE_OR_FAIL(dev, -ENXIO);
 
 	if (sysfs_streq(buf, "default")) {
 		pci_init_reset_methods(pdev);
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -637,6 +637,11 @@ DEFINE_GUARD_COND(pm_runtime_active_auto
 DEFINE_GUARD_COND(pm_runtime_active_auto, _try_enabled,
 		  pm_runtime_resume_and_get(_T))
 
+#define PM_RUNTIME_ACQUIRE_OR_FAIL(dev, error)		\
+	ACQUIRE(pm_runtime_active_try, __pm)(dev);	\
+	if (ACQUIRE_ERR(pm_runtime_active_try, &__pm))	\
+		return error
+
 /**
  * pm_runtime_put_sync - Drop device usage counter and run "idle check" if 0.
  * @dev: Target device.




