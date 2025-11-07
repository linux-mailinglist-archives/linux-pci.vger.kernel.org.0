Return-Path: <linux-pci+bounces-40594-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B23C414D7
	for <lists+linux-pci@lfdr.de>; Fri, 07 Nov 2025 19:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30B193A6CC8
	for <lists+linux-pci@lfdr.de>; Fri,  7 Nov 2025 18:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27686338939;
	Fri,  7 Nov 2025 18:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vQNzbHKt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B5F3385A0;
	Fri,  7 Nov 2025 18:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762540931; cv=none; b=hleYBn21L8r3r2n9I2uazRdJy+7Oz4u2E8thjdV78IbHSuaqRat45EkBlZ2GQzcvZ8/QcRMUepv/aWY3e8au1nFzbRVqwv2djGxeegh2Wa+rmImr+1ARPmxsj0M6Lx8+z2B5jcN3zUNCYKli5Sq0A3c6JtPeB2AVTCbQuLmv60Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762540931; c=relaxed/simple;
	bh=NlugFQaxO5tLMHoPMN31XhYC2vMgdbP47ZSDQKZvL0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W2GPQY51/PLrpIhWGkt9uLL4cg8xp+KtTZyHoofpFuGnE1A46ebZ2sgKKUETOQYp7w2k4WwYM6ZNg/r5gw6OMuVnv5ImdY+8cR0Nynpr+1knwdM1YyGqu0b3+fmllwwuWogrDCKBrLMucCXBEhkybn4XXyOYjMNWjBf9FgTtjqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vQNzbHKt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32B5CC4CEF5;
	Fri,  7 Nov 2025 18:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762540930;
	bh=NlugFQaxO5tLMHoPMN31XhYC2vMgdbP47ZSDQKZvL0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vQNzbHKtKHNWf1dP8O1k9eugI4hPWZcWfut0pzsBj28OxIw2Jq3+zrI+v6kiO2duD
	 XgJdGYuuafIeEFkvZXMo30MSVKnLgeOnQNdYK3azpw2apWByBnd6bCI9HMG2DVjQ4h
	 wSwrMN+TFCbjGcEM+5O/2YEN6V78xlrEb/YHoWj8BdHhfqghDC7Vz3j6o/AhIZO3O2
	 GAbnIQNjI6KLYqRfbdoXmb7ZP/plpEqf1S2DWQWxHxu8kjnn27AILtOla2mUK5DE2t
	 dIjECMvt5LmLl6TN3vIzEMTVeRQBuLjvs5n24iLB4jR0c9JfKzx4q6V/mdXtwNnKgE
	 S2LE5pRiwuujA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Takashi Iwai <tiwai@suse.de>,
 LKML <linux-kernel@vger.kernel.org>, Zhang Qilong <zhangqilong3@huawei.com>,
 Frank Li <Frank.Li@nxp.com>, Dhruva Gole <d-gole@ti.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
 Alex Williamson <alex.williamson@redhat.com>
Subject:
 [PATCH v1 3/3] ACPI: TAD: Use PM_RUNTIME_ACQUIRE()/PM_RUNTIME_ACQUIRE_ERR
Date: Fri, 07 Nov 2025 19:41:54 +0100
Message-ID: <7873589.EvYhyI6sBW@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <13883374.uLZWGnKmhe@rafael.j.wysocki>
References: <13883374.uLZWGnKmhe@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Use new PM_RUNTIME_ACQUIRE() and PM_RUNTIME_ACQUIRE_ERR wrapper macros
to make the code look more straightforward.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
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
+	PM_RUNTIME_ACQUIRE(dev);
+	if (PM_RUNTIME_ACQUIRE_ERR)
 		return -ENXIO;
 
 	status = acpi_evaluate_integer(handle, "_SRT", &arg_list, &retval);
@@ -137,8 +137,8 @@ static int acpi_tad_get_real_time(struct
 {
 	int ret;
 
-	ACQUIRE(pm_runtime_active_try, pm)(dev);
-	if (ACQUIRE_ERR(pm_runtime_active_try, &pm))
+	PM_RUNTIME_ACQUIRE(dev);
+	if (PM_RUNTIME_ACQUIRE_ERR)
 		return -ENXIO;
 
 	ret = acpi_tad_evaluate_grt(dev, rt);
@@ -275,8 +275,8 @@ static int acpi_tad_wake_set(struct devi
 	args[0].integer.value = timer_id;
 	args[1].integer.value = value;
 
-	ACQUIRE(pm_runtime_active_try, pm)(dev);
-	if (ACQUIRE_ERR(pm_runtime_active_try, &pm))
+	PM_RUNTIME_ACQUIRE(dev);
+	if (PM_RUNTIME_ACQUIRE_ERR)
 		return -ENXIO;
 
 	status = acpi_evaluate_integer(handle, method, &arg_list, &retval);
@@ -322,8 +322,8 @@ static ssize_t acpi_tad_wake_read(struct
 
 	args[0].integer.value = timer_id;
 
-	ACQUIRE(pm_runtime_active_try, pm)(dev);
-	if (ACQUIRE_ERR(pm_runtime_active_try, &pm))
+	PM_RUNTIME_ACQUIRE(dev);
+	if (PM_RUNTIME_ACQUIRE_ERR)
 		return -ENXIO;
 
 	status = acpi_evaluate_integer(handle, method, &arg_list, &retval);
@@ -377,8 +377,8 @@ static int acpi_tad_clear_status(struct
 
 	args[0].integer.value = timer_id;
 
-	ACQUIRE(pm_runtime_active_try, pm)(dev);
-	if (ACQUIRE_ERR(pm_runtime_active_try, &pm))
+	PM_RUNTIME_ACQUIRE(dev);
+	if (PM_RUNTIME_ACQUIRE_ERR)
 		return -ENXIO;
 
 	status = acpi_evaluate_integer(handle, "_CWS", &arg_list, &retval);
@@ -417,8 +417,8 @@ static ssize_t acpi_tad_status_read(stru
 
 	args[0].integer.value = timer_id;
 
-	ACQUIRE(pm_runtime_active_try, pm)(dev);
-	if (ACQUIRE_ERR(pm_runtime_active_try, &pm))
+	PM_RUNTIME_ACQUIRE(dev);
+	if (PM_RUNTIME_ACQUIRE_ERR)
 		return -ENXIO;
 
 	status = acpi_evaluate_integer(handle, "_GWS", &arg_list, &retval);




