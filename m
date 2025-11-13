Return-Path: <linux-pci+bounces-41179-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72684C59C71
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 20:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA59C3A5411
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 19:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0176A311941;
	Thu, 13 Nov 2025 19:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U2a2lK0B"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5837A31BC80;
	Thu, 13 Nov 2025 19:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763062577; cv=none; b=foE5UlJ/i3+FBM+ZYiVPRUgpqA9HFHnUQaCSFCmZM+oZ/SOWmN7UHJ1MBR7OtB+9EByuegnYu+EF6e6FzH911nwkMYOIdw3V5zRNC//GfpnXPRAE6+POfXAq5koey9DkhF6AqK+rbmO6Uop24q+e5wq0b6gEigCg84tA0JveeYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763062577; c=relaxed/simple;
	bh=sagOaYDjyVvzsojdmLO+gAmY1Q+H9QU8+vQui12rRhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YOKHylDN630b/npaRxzzEitdB0iaMOKFxb+t5eL7cWfayCTuVtoI5BDJwapslaeqn355qrHrsGmMCGNQUvvaPE3ak0XrxgZg9PWYugB5gvG5Allj6sihn9njehVegPP5p2qzpu/NPop6IVcXLUqztA6MAYdIACPcxgkvPZvf2jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U2a2lK0B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FB64C4CEF7;
	Thu, 13 Nov 2025 19:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763062576;
	bh=sagOaYDjyVvzsojdmLO+gAmY1Q+H9QU8+vQui12rRhs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U2a2lK0BLteqJz2v31yT48LwZCioe7FUOQKMs2rkuCiWHs9r16OUMvOiiv7irbcBj
	 lsyEhizsKpHSoEMvrtEeo7f0Q9vHZq2LFBrFyBRPE5ziMfqzTJ7pqTJxonWjJGpcxG
	 0YsZhL17QXGpvb/KQxSHKGBTgy/mzudNv5ESc7YCIs/4LqeHtXM7m7+YJ7wIKRtt3C
	 vv36wMiybHHSOXPxv8nitOh0rFIHj5qqHtLuGFF8Gt+sqp1QbmYzvKiqQ9BBO0udsg
	 5q+mm1SqAEfV206eFjpcHUACPTNSdLLjU3kE/NuGlljulZqy2Y/U9Qtb1AglypSc7B
	 FM27bABNSsutg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Takashi Iwai <tiwai@suse.de>,
 LKML <linux-kernel@vger.kernel.org>, Zhang Qilong <zhangqilong3@huawei.com>,
 Frank Li <Frank.Li@nxp.com>, Dhruva Gole <d-gole@ti.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>
Subject:
 [PATCH v2 1/3] PM: runtime: Wrapper macros for ACQUIRE()/ACQUIRE_ERR()
Date: Thu, 13 Nov 2025 20:33:33 +0100
Message-ID: <3400866.aeNJFYEL58@rafael.j.wysocki>
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

Add wrapper macros for ACQUIRE()/ACQUIRE_ERR() and runtime PM
usage counter guards introduced recently: pm_runtime_active_try,
pm_runtime_active_auto_try, pm_runtime_active_try_enabled, and
pm_runtime_active_auto_try_enabled.

The new macros should be more straightforward to use.

For example, they can be used for rewriting a piece of code like below:

        ACQUIRE(pm_runtime_active_try, pm)(dev);
        if ((ret = ACQUIRE_ERR(pm_runtime_active_try, &pm)))
                return ret;

in the following way:

        PM_RUNTIME_ACQUIRE(dev, pm);
        if ((ret = PM_RUNTIME_ACQUIRE_ERR(&pm)))
                return ret;

If the original code does not care about the specific error code
returned when attepmting to resume the device:

        ACQUIRE(pm_runtime_active_try, pm)(dev);
        if (ACQUIRE_ERR(pm_runtime_active_try, &pm))
                return -ENXIO;

it may be changed like this:

        PM_RUNTIME_ACQUIRE(dev, pm);
        if (PM_RUNTIME_ACQUIRE_ERR(&pm))
                return -ENXIO;

Link: https://lore.kernel.org/linux-pm/5068916.31r3eYUQgx@rafael.j.wysocki/
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---

v1 -> v2:
   * The new macros take the guard variable name as a parameter.
   * The new ERR macro takes a guard variable pointer as a parameter (Dan).
   * Added underscore prefix to the macro parameter names.

---
 include/linux/pm_runtime.h |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -637,6 +637,30 @@ DEFINE_GUARD_COND(pm_runtime_active_auto
 DEFINE_GUARD_COND(pm_runtime_active_auto, _try_enabled,
 		  pm_runtime_resume_and_get(_T), _RET == 0)
 
+/* ACQUIRE() wrapper macros for the guards defined above. */
+
+#define PM_RUNTIME_ACQUIRE(_dev, _var)			\
+	ACQUIRE(pm_runtime_active_try, _var)(_dev)
+
+#define PM_RUNTIME_ACQUIRE_AUTOSUSPEND(_dev, _var)	\
+	ACQUIRE(pm_runtime_active_auto_try, _var)(_dev)
+
+#define PM_RUNTIME_ACQUIRE_IF_ENABLED(_dev, _var)	\
+	ACQUIRE(pm_runtime_active_try_enabled, _var)(_dev)
+
+#define PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(_dev, _var)	\
+	ACQUIRE(pm_runtime_active_auto_try_enabled, _var)(_dev)
+
+/*
+ * ACQUIRE_ERR() wrapper macro for guard pm_runtime_active.
+ *
+ * Always check PM_RUNTIME_ACQUIRE_ERR() after using one of the
+ * PM_RUNTIME_ACQUIRE*() macros defined above (yes, it can be used with
+ * any of them) and if it is nonzero, avoid accessing the given device.
+ */
+#define PM_RUNTIME_ACQUIRE_ERR(_var_ptr)	\
+	ACQUIRE_ERR(pm_runtime_active, _var_ptr)
+
 /**
  * pm_runtime_put_sync - Drop device usage counter and run "idle check" if 0.
  * @dev: Target device.




