Return-Path: <linux-pci+bounces-40596-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB41C414F8
	for <lists+linux-pci@lfdr.de>; Fri, 07 Nov 2025 19:42:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7C09189D604
	for <lists+linux-pci@lfdr.de>; Fri,  7 Nov 2025 18:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF3633B6DB;
	Fri,  7 Nov 2025 18:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OIitfB1e"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD3833858E;
	Fri,  7 Nov 2025 18:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762540947; cv=none; b=lDPov2aM46j0KuSDI6wvy3Qmy32zYBvkLNH215e25x11wr0StdX38/bJi5ClvAMmoqLjgRFZ4akRE052FhRyDpgIpASXMOv3O83IYidYY0Jhd41EvTDRwqA2VJiqC64lllzb5PU2G9A0I3WRDF17La0/5rqvK4nPbDSRKaAQVq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762540947; c=relaxed/simple;
	bh=NLY+vU49mgYXDU/EV/9jTaPXw12feX89UPKK1rPzH2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AhO6/zZY/eZIC9PubLwXgY1PLChmgaCLNPpk308ZpFV30P80h2hkWUePHrmRqG3d3/PQ8ArCLrQbFWmlB2r80WOk8OGv/f7hB05V5qe7A6wxQ2uYdA9fvp1L0aRhpdXp+UShy5gGt1n13Bi8slaIzz3UbMiRkTaljKMtGxNkJaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OIitfB1e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BF38C4CEF7;
	Fri,  7 Nov 2025 18:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762540947;
	bh=NLY+vU49mgYXDU/EV/9jTaPXw12feX89UPKK1rPzH2E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OIitfB1emiw9nnyhCXf1HBY5HUWf7joOCVZsnIQQ399y4U7bBfDvJuwo4LTmSXNyB
	 aAB5VrKYdJh2aX/vwuTO5XdzMg9dHUHoXTSUlx9WJR6jzNALtMC+zgkrrxfEI5LIl/
	 1t+7NPnb7uiMtlofmSrQcqDqsB0aRLkRdQlLkt5L49gcuBMfgHfBvVkyCXaN9+GjwU
	 zI77oLartJ+MQlJyCUcmy4t16Gg9eR/fhMSlPPnOJHpASpsUq2ZpfGR7E1M0o6vxKT
	 CRFTiA4bqoioGZhc99x6wu+um+BQKVnF2IL9b0pb0HkMIv+e0RfIARp6aRJjDOJtHZ
	 pd+h68f8vx4hg==
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
 [PATCH v1 1/3] PM: runtime: Wrapper macros for ACQUIRE()/ACQUIRE_ERR()
Date: Fri, 07 Nov 2025 19:39:55 +0100
Message-ID: <10752302.nUPlyArG6x@rafael.j.wysocki>
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

Add several wrapper macros for ACQUIRE()/ACQUIRE_ERR() and runtime PM
usage counter guards introduced recently: pm_runtime_active_try,
pm_runtime_active_auto_try, pm_runtime_active_try_enabled, and
pm_runtime_active_auto_try_enabled.

The new macros are simpler and should be more straightforward to use.
Moreover, they do not expose internal details that are not strictly
related to the code using the macros.

For example, they can be used for rewriting a piece of code like below:

        ACQUIRE(pm_runtime_active_try, pm)(dev);
        if ((ret = ACQUIRE_ERR(pm_runtime_active_try, &pm)))
                return ret;

in the following way:

        PM_RUNTIME_ACQUIRE(dev);
        if ((ret = PM_RUNTIME_ACQUIRE_ERR))
                return ret;

If the original code does not care about the specific error code
returned when attempting to resume the device:

        ACQUIRE(pm_runtime_active_try, pm)(dev);
        if (ACQUIRE_ERR(pm_runtime_active_try, &pm))
                return -ENXIO;

it may be changed like this:

        PM_RUNTIME_ACQUIRE(dev);
        if (PM_RUNTIME_ACQUIRE_ERR)
                return -ENXIO;

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/linux/pm_runtime.h |   55 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -637,6 +637,61 @@ DEFINE_GUARD_COND(pm_runtime_active_auto
 DEFINE_GUARD_COND(pm_runtime_active_auto, _try_enabled,
 		  pm_runtime_resume_and_get(_T), _RET == 0)
 
+/*
+ * ACQUIRE() wrapper macros for the guards defined above.
+ *
+ * The tagged __PM_RUNTIME_ACQUIRE*() variants are for the cases in which two or
+ * more of these macros are used in the same scope and the tags are necessary to
+ * distinguish the internal guard variables from each other. Don't do that
+ * unless you have to. No, really. If they are needed, using simple tags is
+ * recommended (for example, individual digits or letters).
+ *
+ * The simpler PM_RUNTIME_ACQUIRE*() variants are wrappers around the
+ * corresponding __PM_RUNTIME_ACQUIRE*() that use the underline character
+ * as a (special) tag.  They should be suitable for the vast majority of use
+ * cases.
+ *
+ * Don't mix up PM_RUNTIME_ACQUIRE*() with __PM_RUNTIME_ACQUIRE*() even though
+ * that may work.
+ */
+#define __PM_RUNTIME_ACQUIRE(dev, tag)	\
+	ACQUIRE(pm_runtime_active_try, _pm_runtime_guard_var_##tag)(dev)
+
+#define PM_RUNTIME_ACQUIRE(dev)	\
+	__PM_RUNTIME_ACQUIRE(dev, _)
+
+#define __PM_RUNTIME_ACQUIRE_AUTOSUSPEND(dev, tag)	\
+	ACQUIRE(pm_runtime_active_auto_try, _pm_runtime_guard_var_##tag)(dev)
+
+#define PM_RUNTIME_ACQUIRE_AUTOSUSPEND(dev)	\
+	__PM_RUNTIME_ACQUIRE_AUTOSUSPEND(dev, _)
+
+#define __PM_RUNTIME_ACQUIRE_ENABLED(dev, tag)	\
+	ACQUIRE(pm_runtime_active_try_enabled, _pm_runtime_guard_var_##tag)(dev)
+
+#define PM_RUNTIME_ACQUIRE_ENABLED(dev)	\
+	__PM_RUNTIME_ACQUIRE_ENABLED(dev, _)
+
+#define __PM_RUNTIME_ACQUIRE_ENABLED_AUTOSUSPEND(dev, tag)	\
+	ACQUIRE(pm_runtime_active_auto_try_enabled, _pm_runtime_guard_var_##tag)(dev)
+
+#define PM_RUNTIME_ACQUIRE_ENABLED_AUTOSUSPEND(dev)	\
+	__PM_RUNTIME_ACQUIRE_ENABLED_AUTOSUSPEND(dev, _)
+
+/*
+ * ACQUIRE_ERR() wrapper macros for guard pm_runtime_active.
+ *
+ * Always check __PM_RUNTIME_ACQUIRE_ERR() with a matching tag after using one
+ * of the tagged __PM_RUNTIME_ACQUIRE*() macros defined above (yes, it can be
+ * used with any of them) and avoid accessing the given device if it is nonzero.
+ * Analogously, always check PM_RUNTIME_ACQUIRE_ERR after using any of the
+ * simpler PM_RUNTIME_ACQUIRE*() macros.
+ */
+#define __PM_RUNTIME_ACQUIRE_ERR(tag)	\
+	ACQUIRE_ERR(pm_runtime_active, &_pm_runtime_guard_var_##tag)
+
+#define PM_RUNTIME_ACQUIRE_ERR	__PM_RUNTIME_ACQUIRE_ERR(_)
+
 /**
  * pm_runtime_put_sync - Drop device usage counter and run "idle check" if 0.
  * @dev: Target device.




