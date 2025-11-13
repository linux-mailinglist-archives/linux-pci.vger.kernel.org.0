Return-Path: <linux-pci+bounces-41178-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6D8C59C80
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 20:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6E94F4E42C5
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 19:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9278F31BCBD;
	Thu, 13 Nov 2025 19:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NmoNO0bC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8943164D4;
	Thu, 13 Nov 2025 19:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763062571; cv=none; b=rpiDX1WNxGmj/vtjO3Jzn/F8RNpynsE23+lNVNrwPDqWlwaU0ATUdQkL3+HN5XpxTNgUEb5APQiAlnio4ypvLRIVBtbw8FjsBSSijPSsmJrfxsNupFTDYEq+ryf3EI5qBV8saw6Fn/hpNRQtIupEks7XPovnlqkOZC+35k6+lFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763062571; c=relaxed/simple;
	bh=3UWo0LV4XjuUqmmBcw4h+UDN+0V86GO2l32GjXB4RjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gz14WLEeScV/i8T7WpvE6AciLhbTUtc+edycbewHemVGq3FxbK6q333h0iFnvZ1JRI4UD8D1G8xgw/08mE1MyTG25Binm/bvxepgcoFpzSLEjUjEVHj+AHESMubC6WbKVr4bi4Sn94W0PyydAdvsolgS5Aid2YltrFEaBPvpOF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NmoNO0bC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EA24C4CEFB;
	Thu, 13 Nov 2025 19:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763062571;
	bh=3UWo0LV4XjuUqmmBcw4h+UDN+0V86GO2l32GjXB4RjU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NmoNO0bCcim5CbVyYLwV7yb9beDc4BBdM+5ORo83TW2AX861rYxCo4Wn9IBJDRQ3q
	 l6L69X1iPe8tVUg7zNbO00yAsMFlOzCj4s+HeSJAPgL8VVX+1aPWRwKwi8Zqm3R0Ba
	 uo4m9Kd+QfAOtPZmqXDPINKZ+/QDyiZHJOddMrTkgGhlTBxRhF118Vkv5NRTlvAwnw
	 Eao1eq9VbMc7CHpVtaIHWSMj/kOzEl4vKMaeWgrN/Ms1Vrl0NZGH896qc6K2stC7FH
	 L6S+OOpUjJLONWGx2rrP1WeEF3uiUo8Ke+ndk3jXgAYUBueqHIvc+5+b+xY6/JfjXb
	 706QM4DTD8chg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Takashi Iwai <tiwai@suse.de>,
 LKML <linux-kernel@vger.kernel.org>, Zhang Qilong <zhangqilong3@huawei.com>,
 Frank Li <Frank.Li@nxp.com>, Dhruva Gole <d-gole@ti.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>
Subject:
 [PATCH v2 2/3] ACPI: TAD: Use PM_RUNTIME_ACQUIRE()/PM_RUNTIME_ACQUIRE_ERR()
Date: Thu, 13 Nov 2025 20:34:53 +0100
Message-ID: <2040585.PYKUYFuaPT@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <5959587.DvuYhMxLoT@rafael.j.wysocki>
References: <5959587.DvuYhMxLoT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Use new PM_RUNTIME_ACQUIRE() and PM_RUNTIME_ACQUIRE_ERR() wrapper macros
to make the code look more straightforward.

No intentional funtional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: Adjust to the changes in patch [1/3].

---
 drivers/acpi/acpi_tad.c |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

--- a/drivers/acpi/acpi_tad.c
+++ b/drivers/acpi/acpi_tad.c
@@ -90,8 +90,8 @@ static int acpi_tad_set_real_time(struct
 	args[0].buffer.pointer = (u8 *)rt;
 	args[0].buffer.length = sizeof(*rt);
 
-	ACQUIRE(pm_runtime_active_try, pm)(dev);
-	if (ACQUIRE_ERR(pm_runtime_active_try, &pm))
+	PM_RUNTIME_ACQUIRE(dev, pm);
+	if (PM_RUNTIME_ACQUIRE_ERR(&pm))
 		return -ENXIO;
 
 	status = acpi_evaluate_integer(handle, "_SRT", &arg_list, &retval);
@@ -137,8 +137,8 @@ static int acpi_tad_get_real_time(struct
 {
 	int ret;
 
-	ACQUIRE(pm_runtime_active_try, pm)(dev);
-	if (ACQUIRE_ERR(pm_runtime_active_try, &pm))
+	PM_RUNTIME_ACQUIRE(dev, pm);
+	if (PM_RUNTIME_ACQUIRE_ERR(&pm))
 		return -ENXIO;
 
 	ret = acpi_tad_evaluate_grt(dev, rt);
@@ -275,8 +275,8 @@ static int acpi_tad_wake_set(struct devi
 	args[0].integer.value = timer_id;
 	args[1].integer.value = value;
 
-	ACQUIRE(pm_runtime_active_try, pm)(dev);
-	if (ACQUIRE_ERR(pm_runtime_active_try, &pm))
+	PM_RUNTIME_ACQUIRE(dev, pm);
+	if (PM_RUNTIME_ACQUIRE_ERR(&pm))
 		return -ENXIO;
 
 	status = acpi_evaluate_integer(handle, method, &arg_list, &retval);
@@ -322,8 +322,8 @@ static ssize_t acpi_tad_wake_read(struct
 
 	args[0].integer.value = timer_id;
 
-	ACQUIRE(pm_runtime_active_try, pm)(dev);
-	if (ACQUIRE_ERR(pm_runtime_active_try, &pm))
+	PM_RUNTIME_ACQUIRE(dev, pm);
+	if (PM_RUNTIME_ACQUIRE_ERR(&pm))
 		return -ENXIO;
 
 	status = acpi_evaluate_integer(handle, method, &arg_list, &retval);
@@ -377,8 +377,8 @@ static int acpi_tad_clear_status(struct
 
 	args[0].integer.value = timer_id;
 
-	ACQUIRE(pm_runtime_active_try, pm)(dev);
-	if (ACQUIRE_ERR(pm_runtime_active_try, &pm))
+	PM_RUNTIME_ACQUIRE(dev, pm);
+	if (PM_RUNTIME_ACQUIRE_ERR(&pm))
 		return -ENXIO;
 
 	status = acpi_evaluate_integer(handle, "_CWS", &arg_list, &retval);
@@ -417,8 +417,8 @@ static ssize_t acpi_tad_status_read(stru
 
 	args[0].integer.value = timer_id;
 
-	ACQUIRE(pm_runtime_active_try, pm)(dev);
-	if (ACQUIRE_ERR(pm_runtime_active_try, &pm))
+	PM_RUNTIME_ACQUIRE(dev, pm);
+	if (PM_RUNTIME_ACQUIRE_ERR(&pm))
 		return -ENXIO;
 
 	status = acpi_evaluate_integer(handle, "_GWS", &arg_list, &retval);




