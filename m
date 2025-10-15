Return-Path: <linux-pci+bounces-38227-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D96ABDEEB4
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 16:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 597A019C76B7
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 14:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4305A242D91;
	Wed, 15 Oct 2025 14:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="psScjpBb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA2F21ABC9;
	Wed, 15 Oct 2025 14:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760537118; cv=none; b=XBVcPtLrnCDI6OjWp9PeA1/9wJ7x7QFLC51BWq71FYM/+nOqSGYxy/0cro/20UIiputUPfOgtwJpfgbUYTH4hPBXRnK4+ckFxOGQxPlfNIl06aBUSGioDdoo5017i6pyepPGSIX4h21wsqlYnLdTLzafijD5cp9VtFTTlUO4dro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760537118; c=relaxed/simple;
	bh=Imiy/d2gYAYXCcTyQuEFVMYa5XWR048yJFog3UE4+H0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a0oIit4QOU/H04p7a6nOZtXUisWIUoxMM8MWmeYjLgOyPFRtFHlol7GlMifRB2kt7uOsrbr6MtLKRSWfvc3XQNCeyO42PInOLblqwcyeOo8yBHtrM/eTHJXDl9a4LjrWPAyT7u61GchGropR5q+gXr9SJbfOulyRg4GDfCHKyqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=psScjpBb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78819C4CEF8;
	Wed, 15 Oct 2025 14:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760537117;
	bh=Imiy/d2gYAYXCcTyQuEFVMYa5XWR048yJFog3UE4+H0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=psScjpBb3e1kcLI5VrkuiWJV17PKdqUVkH2BY7yFGOlYPK2AgZoyISa+/TzVfYYO3
	 5+PHeN/sB02bv62v11abXuGEqviummglF8j9iGdgD/sq7EPkXC6/QdkRZunsohCIjS
	 +AL3DNF1W+ayaDX4RLSqj50ToOSXdH8eIZCPax0+c1pVe5Pms0PB8E3vqvHBAIMgzO
	 y83rOx6KOlya9DtMyXVRcq7s2DySZMQHBBHF/y4xyqDYSxAzrNVW3wQeIXw7ThtAaL
	 D/ykNx9CJCb2EwFJJnpURIzkACECJNCFP2u4aELprI6L3llqb7s/1qqfoN6RqaheQp
	 A0zHxkLTAJ4dA==
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
Subject: [PATCH v1 3/3] ACPI: TAD: Improve runtime PM using guard macros
Date: Wed, 15 Oct 2025 16:04:39 +0200
Message-ID: <2057157.usQuhbGJ8B@rafael.j.wysocki>
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

Use guard pm_runtime_active_try to simplify runtime PM cleanup and
implement runtime resume error handling in multiple places.

Also use guard pm_runtime_noresume to simplify acpi_tad_remove().

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpi_tad.c |   45 +++++++++++++--------------------------------
 1 file changed, 13 insertions(+), 32 deletions(-)

--- a/drivers/acpi/acpi_tad.c
+++ b/drivers/acpi/acpi_tad.c
@@ -90,12 +90,9 @@ static int acpi_tad_set_real_time(struct
 	args[0].buffer.pointer = (u8 *)rt;
 	args[0].buffer.length = sizeof(*rt);
 
-	pm_runtime_get_sync(dev);
+	PM_RUNTIME_ACQUIRE_OR_FAIL(dev, -ENXIO);
 
 	status = acpi_evaluate_integer(handle, "_SRT", &arg_list, &retval);
-
-	pm_runtime_put_sync(dev);
-
 	if (ACPI_FAILURE(status) || retval)
 		return -EIO;
 
@@ -111,12 +108,9 @@ static int acpi_tad_get_real_time(struct
 	acpi_status status;
 	int ret = -EIO;
 
-	pm_runtime_get_sync(dev);
+	PM_RUNTIME_ACQUIRE_OR_FAIL(dev, -ENXIO);
 
 	status = acpi_evaluate_object(handle, "_GRT", NULL, &output);
-
-	pm_runtime_put_sync(dev);
-
 	if (ACPI_FAILURE(status))
 		goto out_free;
 
@@ -266,12 +260,9 @@ static int acpi_tad_wake_set(struct devi
 	args[0].integer.value = timer_id;
 	args[1].integer.value = value;
 
-	pm_runtime_get_sync(dev);
+	PM_RUNTIME_ACQUIRE_OR_FAIL(dev, -ENXIO);
 
 	status = acpi_evaluate_integer(handle, method, &arg_list, &retval);
-
-	pm_runtime_put_sync(dev);
-
 	if (ACPI_FAILURE(status) || retval)
 		return -EIO;
 
@@ -314,12 +305,9 @@ static ssize_t acpi_tad_wake_read(struct
 
 	args[0].integer.value = timer_id;
 
-	pm_runtime_get_sync(dev);
+	PM_RUNTIME_ACQUIRE_OR_FAIL(dev, -ENXIO);
 
 	status = acpi_evaluate_integer(handle, method, &arg_list, &retval);
-
-	pm_runtime_put_sync(dev);
-
 	if (ACPI_FAILURE(status))
 		return -EIO;
 
@@ -370,12 +358,9 @@ static int acpi_tad_clear_status(struct
 
 	args[0].integer.value = timer_id;
 
-	pm_runtime_get_sync(dev);
+	PM_RUNTIME_ACQUIRE_OR_FAIL(dev, -ENXIO);
 
 	status = acpi_evaluate_integer(handle, "_CWS", &arg_list, &retval);
-
-	pm_runtime_put_sync(dev);
-
 	if (ACPI_FAILURE(status) || retval)
 		return -EIO;
 
@@ -411,12 +396,9 @@ static ssize_t acpi_tad_status_read(stru
 
 	args[0].integer.value = timer_id;
 
-	pm_runtime_get_sync(dev);
+	PM_RUNTIME_ACQUIRE_OR_FAIL(dev, -ENXIO);
 
 	status = acpi_evaluate_integer(handle, "_GWS", &arg_list, &retval);
-
-	pm_runtime_put_sync(dev);
-
 	if (ACPI_FAILURE(status))
 		return -EIO;
 
@@ -571,16 +553,15 @@ static void acpi_tad_remove(struct platf
 
 	sysfs_remove_group(&dev->kobj, &acpi_tad_attr_group);
 
-	pm_runtime_get_noresume(dev);
-
-	acpi_tad_disable_timer(dev, ACPI_TAD_AC_TIMER);
-	acpi_tad_clear_status(dev, ACPI_TAD_AC_TIMER);
-	if (dd->capabilities & ACPI_TAD_DC_WAKE) {
-		acpi_tad_disable_timer(dev, ACPI_TAD_DC_TIMER);
-		acpi_tad_clear_status(dev, ACPI_TAD_DC_TIMER);
+	scoped_guard(pm_runtime_noresume, dev) {
+		acpi_tad_disable_timer(dev, ACPI_TAD_AC_TIMER);
+		acpi_tad_clear_status(dev, ACPI_TAD_AC_TIMER);
+		if (dd->capabilities & ACPI_TAD_DC_WAKE) {
+			acpi_tad_disable_timer(dev, ACPI_TAD_DC_TIMER);
+			acpi_tad_clear_status(dev, ACPI_TAD_DC_TIMER);
+		}
 	}
 
-	pm_runtime_put_noidle(dev);
 	pm_runtime_suspend(dev);
 	pm_runtime_disable(dev);
 	acpi_remove_cmos_rtc_space_handler(handle);




