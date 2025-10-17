Return-Path: <linux-pci+bounces-38460-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6329EBE8736
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 13:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 518F34F84FC
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 11:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E5127B34D;
	Fri, 17 Oct 2025 11:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L1l6ixhd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85D9255E34;
	Fri, 17 Oct 2025 11:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760701785; cv=none; b=LFXHIAzdMhomenOLrYLJedVbF/8NaOo1CqGd6OwUXKGJLcLMzigolnjlgTuVAYN504J9OYVA1ktLJ5a9KSv9p8+VXbUkvU1JFO54P1uM5CHFyWUXbC839mF7DA0pVo2NFAyVqIdsAt5M7UzLgO8kf1gkq6oMHnK0VfPWemCKwfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760701785; c=relaxed/simple;
	bh=7X+TwXU2ynW1Z24EycOtDV2oDOgsg5UZIpUiNMNGeus=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=RWS02axUQox4HmPII/3fIHUfYgXIqVUXMhlNKF/lzd+s9BjUS7+odcqyCTTKBMYv3Tl8OwzP+FL6mK/ogVclBl8M9R9PgH7dQrpJKjhSZDyGaoCm/Q6FdhxrjXvXggpN05ylYaz8psnX86Wng/xhbuD5RBOp16KtEBV5neKTeCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L1l6ixhd; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760701783; x=1792237783;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=7X+TwXU2ynW1Z24EycOtDV2oDOgsg5UZIpUiNMNGeus=;
  b=L1l6ixhdGpkTx8Alrc6suugDrgXWUfzKXBkLwpA3/5vIPmbvVtGPa5dN
   I5auL7kZwWazMIfkaa50H2+1+Bhj8Ls5tpFV3rg0hH2L1KSZAaykIz+Of
   mgwraG3zIn8q2IlxWgBMwXC7/XyeRLDba4XfHY5YmWltDSoKeg2KqIysD
   Qs+JpgK0L9IgWVo8C8P8cWnBmiwBdjpnWLvtUWy89McVX3gjih65xUMix
   Qgci5IKesdzvPPaW7LaGayHbRuMT5PZnjEZsWN/71MKWiyvDzpEwUOpX7
   3I+nOxK4l+25znyv6tkOIWcgmdRtgvEfuM49P6kq9GCSsb4ytQAHYzcZW
   g==;
X-CSE-ConnectionGUID: tqVsXhboTEy2TxSVnbcEuw==
X-CSE-MsgGUID: qJSwP3X9RZeMATcMJhfjCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="62949401"
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; 
   d="scan'208";a="62949401"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 04:49:42 -0700
X-CSE-ConnectionGUID: ORisMe/SQre3CJp+jUcM/Q==
X-CSE-MsgGUID: Xe8nPa+eRraf/cY8Jvslyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; 
   d="scan'208";a="182719104"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.123])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 04:49:39 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 17 Oct 2025 14:49:35 +0300 (EEST)
To: Lukas Wunner <lukas@wunner.de>
cc: Brian Norris <briannorris@chromium.org>, 
    Bjorn Helgaas <bhelgaas@google.com>, LKML <linux-kernel@vger.kernel.org>, 
    linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>, 
    linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/PM: Prevent runtime suspend before devices are fully
 initialized
In-Reply-To: <aPH_B7SiJ8KnIAwJ@wunner.de>
Message-ID: <67381f3b-4aee-a314-b5dd-2b7d987a7794@linux.intel.com>
References: <20251016155335.1.I60a53c170a8596661883bd2b4ef475155c7aa72b@changeid> <aPH_B7SiJ8KnIAwJ@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 17 Oct 2025, Lukas Wunner wrote:

> [cc += Ilpo]
> 
> On Thu, Oct 16, 2025 at 03:53:35PM -0700, Brian Norris wrote:
> > PCI devices are created via pci_scan_slot() and similar, and are
> > promptly configured for runtime PM (pci_pm_init()). They are initially
> > prevented from suspending by way of pm_runtime_forbid(); however, it's
> > expected that user space may override this via sysfs [1].

Is this true as pm_runtime_forbid() also increases PM usage count?

"void pm_runtime_forbid(struct device *dev);

unset the power.runtime_auto flag for the device and increase its 
usage counter (used by the /sys/devices/.../power/control interface to 
effectively prevent the device from being power managed at run time)"

> > Now, sometime after initial scan, a PCI device receives its BAR
> > configuration (pci_assign_unassigned_bus_resources(), etc.).
> > 
> > If a PCI device is allowed to suspend between pci_scan_slot() and
> > pci_assign_unassigned_bus_resources(), then pci-driver.c will
> > save/restore incorrect BAR configuration for the device, and the device
> > may cease to function.
> > 
> > This behavior races with user space, since user space may enable runtime
> > PM [1] as soon as it sees the device, which may be before BAR
> > configuration.
> > 
> > Prevent suspending in this intermediate state by holding a runtime PM
> > reference until the device is fully initialized and ready for probe().
>
> Not sure if that is comprehensible by everybody.  The point is that
> unbound devices are left in D0 but are nevertheless allowed to
> (logically) runtime suspend.  And pci_pm_runtime_suspend() may call
> pci_save_state() while config space isn't fully initialized yet,
> or pci_pm_runtime_resume() may call pci_restore_state() (via
> pci_pm_default_resume_early()) and overwrite initialized config space
> with uninitialized data.
> 
> Have you actually seen this happen in practice?  Normally enumeration
> happens during subsys_initcall time, when user space isn't running yet.
> Hotplug may be an exception though.

Adding that pm_runtime_get_noresume() doesn't look useful given 
pm_runtime_forbid() already increases PM usage count. If this problem is 
actually seen in practice, there could a bug elsewhere where something 
decrements usage count too early so this change "helps" by double 
incrementing the usage count.

To find more information what's going on, one could try to trace events 
for the PM usage count (though last time I looked not all paths that 
change PM usage count were covered by the event and adding the 
trace_event() calls into the header turned out too much magic for me to 
figure out so I couldn't solve the problem).

> Patch LGTM in principle, but adding Ilpo to cc who is refactoring PCI
> resource allocation and may judge whether this can actually happen.

I can see there could be other failure modes besides just saving wrong 
config if devices get suspended underneath the resource assignment 
algorithm.

Besides hotplug, also BAR resize does changes the resources and BARs.
This case is not helped by this patch.

I also recently learned some DT platforms do the "actual" scan for the bus 
later on Link Up event through irq which could perhaps occur late enough, 
I dunno for sure.

> I think the code comments you're adding are a little verbose and a simple
> /* acquired in pci_pm_init() */ in pci_bus_add_device() may be sufficient.

I'm also not entirely convinced these always pair or if the pci_dev may 
get removed before pci_bus_add_device(), see e.g., enable_slot() in 
hotplug/acpiphp_glue.c that does acpiphp_sanitize_bus() before 
pci_bus_add_devices() (which could have other bugs too as is).

> Also, I think it is neither necessary nor useful to actually cc the e-mail
> to stable@vger.kernel.org if you include a stable designation in the
> patch.  I believe stable maintainers only pick up backports from that list,
> not patches intended for upstream.

Probably some tool will auto-insert the Cc: tags as receipients so it 
might be non-trivial to get rid of it.

-- 
 i.


