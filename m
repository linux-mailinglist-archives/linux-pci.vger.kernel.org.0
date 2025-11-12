Return-Path: <linux-pci+bounces-41015-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 70DFFC544EF
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 20:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C58ED4E2088
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 19:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD853255F5E;
	Wed, 12 Nov 2025 19:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uVZujVAK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E35E21CFF7;
	Wed, 12 Nov 2025 19:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762976652; cv=none; b=ZiQyCwU90akUOrTre1wUSfzZHWcYKVkd8eEYaxusc8IPdALEJePx+HrallUZTIYU+eCk9m6XtWcjzx0Vqcor/srZt5OvFvyAZIPW9ca4fjQNSvrZdv+mHGA1gnp3IqmA94XJAcQ5J3A74RAT2ZkRum6+H1WWXoYrNeYI8Fivnss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762976652; c=relaxed/simple;
	bh=/dRWxlVyhkYKzoog2JBkvAoSjenzJSwBsUBiVIGwso0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rfoy03sLS4IEmlmC1NVqsiVwDqk6wT66jR1ZhFjWBsa+CsPqpFc6OUbiMGiueS/KedgBuAB7awS56JBSdog8j4g3FYYRT+5aDtoVnHN1Pc299/HPGCE9erwsYci1fWzfHmnKtkwJal2MUfD7b6DTScp8JGov/8cdD+FqkdH+Nwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uVZujVAK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C89A4C19421;
	Wed, 12 Nov 2025 19:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762976652;
	bh=/dRWxlVyhkYKzoog2JBkvAoSjenzJSwBsUBiVIGwso0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uVZujVAKNnz+10xT2WKSWwjsKqRh7b02FuY5yd76XUeOKrFERi3xzXHLonG071UVp
	 3zv1HxljQpROafsrhxwdXwzuJcCNboIUjJwOHaU+gLaPnjLG08KOvthr4nXlr0YLIv
	 Eu7kh1tElQgY/vnaYg4Y/x8mEJInKOZ84QcdjNkJxdkrADHCvNbH8jbHo2drfCYR7f
	 dMNBK89Fi+vZ3cy4+dQXUEbBK33u1Qc7X05MyUuwy5kWobA5O810t92iQOl/yuWlS2
	 2ScGoJXkbgcBF0xpHDKBq1xmKkjjgrtOFtKGivUsHbUywodjApn7jnkK+MSuSZsoyt
	 +WvRKfj51X/Eg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Dhruva Gole <d-gole@ti.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Frank Li <Frank.Li@nxp.com>
Cc: Linux PM <linux-pm@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>,
 LKML <linux-kernel@vger.kernel.org>, Zhang Qilong <zhangqilong3@huawei.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
 Alex Williamson <alex.williamson@redhat.com>
Subject:
 Re: [PATCH v1 0/3] PM: runtime: Wrapper macros for usage counter guards
Date: Wed, 12 Nov 2025 20:44:06 +0100
Message-ID: <5068916.31r3eYUQgx@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <20251112063941.kbg44srt5f7rfkjb@lcpd911>
References:
 <13883374.uLZWGnKmhe@rafael.j.wysocki>
 <20251112063941.kbg44srt5f7rfkjb@lcpd911>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

On Wednesday, November 12, 2025 7:39:41 AM CET Dhruva Gole wrote:
> On Nov 07, 2025 at 19:35:09 +0100, Rafael J. Wysocki wrote:
> > Hi All,
> > 
> > The runtime PM usage counter guards introduced recently:
> > 
> > https://lore.kernel.org/linux-pm/6196611.lOV4Wx5bFT@rafael.j.wysocki/
> > 
> > and then fixed:
> > 
> > https://lore.kernel.org/linux-pm/5943878.DvuYhMxLoT@rafael.j.wysocki/
> > 
> > should generally work, but using them feels sort of arcane and cryptic
> > even though the underlying concept is relatively straightforward.
> > 
> > For this reason, runtime PM wrapper macros around ACQUIRE() and
> > ACQUIRE_ERR() involving the new guards are introduced in this series
> > (patch [1/3]) and then used in the code already using the guards (patches
> > [2/3] and [3/3]) to make it look more straightforward.
> 
> The patches look okay to me,
> Reviewed-by: Dhruva Gole <d-gole@ti.com>

Thank you and Jonathan for the tags, but since Frank is not convinced, let me
bounce one more idea off all of you.

Namely, I think that Frank has a point when he wonders if PM_RUNTIME_ACQUIRE_ERR
hides too much information and I agree with Jonathan that may be misunderstood,
so what about defining the wrapper macros so they don't hide the guard variable
name, like in the patch below?

---
From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH v2] PM: runtime: Wrapper macros for ACQUIRE()/ACQUIRE_ERR()

Add several wrapper macros for ACQUIRE()/ACQUIRE_ERR() and runtime PM
usage counter guards introduced recently: pm_runtime_active_try,
pm_runtime_active_auto_try, pm_runtime_active_try_enabled, and
pm_runtime_active_auto_try_enabled.

The new macros are simpler and should be more straightforward to use.

For example, they can be used for rewriting a piece of code like below:

        ACQUIRE(pm_runtime_active_try, pm)(dev);
        if ((ret = ACQUIRE_ERR(pm_runtime_active_try, &pm)))
                return ret;

in the following way:

        PM_RUNTIME_ACQUIRE(dev, pm);
        if ((ret = PM_RUNTIME_ACQUIRE_ERR(pm)))
                return ret;

If the original code does not care about the specific error code
returned when attempting to resume the device:

        ACQUIRE(pm_runtime_active_try, pm)(dev);
        if (ACQUIRE_ERR(pm_runtime_active_try, &pm))
                return -ENXIO;

it may be changed like this:

        PM_RUNTIME_ACQUIRE(dev, pm);
        if (PM_RUNTIME_ACQUIRE_ERR(pm))
                return -ENXIO;

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/linux/pm_runtime.h |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -637,6 +637,31 @@ DEFINE_GUARD_COND(pm_runtime_active_auto
 DEFINE_GUARD_COND(pm_runtime_active_auto, _try_enabled,
 		  pm_runtime_resume_and_get(_T), _RET == 0)
 
+/* ACQUIRE() wrapper macros for the guards defined above. */
+
+#define PM_RUNTIME_ACQUIRE(dev, var_name)	\
+	ACQUIRE(pm_runtime_active_try, var_name)(dev)
+
+#define PM_RUNTIME_ACQUIRE_AUTOSUSPEND(dev, var_name)	\
+	ACQUIRE(pm_runtime_active_auto_try, var_name)(dev)
+
+#define PM_RUNTIME_ACQUIRE_IF_ENABLED(dev, var_name)	\
+	ACQUIRE(pm_runtime_active_try_enabled, var_name)(dev)
+
+#define PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(dev, var_name)	\
+	ACQUIRE(pm_runtime_active_auto_try_enabled, var_name)(dev)
+
+/*
+ * ACQUIRE_ERR() wrapper macro for guard pm_runtime_active.
+ *
+ * Always check PM_RUNTIME_ACQUIRE_ERR() after using one of the
+ * PM_RUNTIME_ACQUIRE*() macros defined above (yes, it can be used
+ * with any of them) and avoid accessing the given device if it is
+ * nonzero.
+ */
+#define PM_RUNTIME_ACQUIRE_ERR(var_name)	\
+	ACQUIRE_ERR(pm_runtime_active, &var_name)
+
 /**
  * pm_runtime_put_sync - Drop device usage counter and run "idle check" if 0.
  * @dev: Target device.




