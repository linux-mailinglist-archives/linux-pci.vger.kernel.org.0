Return-Path: <linux-pci+bounces-38363-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC45BE451C
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 17:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F8C03BDD90
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 15:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238541A5BB4;
	Thu, 16 Oct 2025 15:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bMKiDSz4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4C94316E
	for <linux-pci@vger.kernel.org>; Thu, 16 Oct 2025 15:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760629534; cv=none; b=J1BW0CiqhWhQ7fD0pd345rfA3P8lKQRXREv7mS6UW0cSJpBN2aTbBjQoI+WwV7gZNTRlf1BcLnsmOmRHey+47wQ9tBjdxyR6aLWeOb6PDF5EOqhFvYj+7z/9dPdhqzIUc/F1LiYx96MQHL5k+Zrij+t+Jcxu7OGWxSlUI/umbl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760629534; c=relaxed/simple;
	bh=3eOI9uM1XlRZ682Ly82NYwd5MJ5evMnS/SdjAfcAYjo=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=HOKt1i38Dg2QrVxLG/0j4heAO7R3/mcq6nTW6OPeaYPZkCoJ0r7HlAtYTB0ZO1kweZ4soFfVWJ1USG4aNxNP0/ljCjAbaDv0u8kINMDFXE2cd8PnMsIEvaRAd1sgU7tK6IFp5dx35yilgkx3b+7ZBdbKitJnzvsaPUQCKhsEVug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bMKiDSz4; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760629532; x=1792165532;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=3eOI9uM1XlRZ682Ly82NYwd5MJ5evMnS/SdjAfcAYjo=;
  b=bMKiDSz4I62YbnBn80lchaPyB7vXKzIT7mLtwxSonaO/djaFJS0PSIOt
   EfL2EopchSeot3PhhPtABhA1ZPuYkBOqCnOM0CkwOASQP/2A/MqpD0hOu
   StAVEBUbAyMr9BIvWcmTX11mi+vWx9d1cPnHC5Toeysnj1xwtPKbRPgJD
   7kaemC0rSrXIdl6vQyvg5NOQVjLCz/pHZov6YGD4ikxp2yXaXFn8/G2RY
   G9Pt4lUAXBGbfTXOGXZKVTB7ZqcPokbjVduSNQjoMXu03dAAfx4a8+GxO
   2cRE8Rh0yv5AadlnCt6NJOxU4BtI5LhYC/JMiok9975wKW63LLffST6bf
   Q==;
X-CSE-ConnectionGUID: ZQku1i/RRiqvcoR1taiFCQ==
X-CSE-MsgGUID: MYOgH9d9Tk2x/utWAdxdiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="73110748"
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="73110748"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 08:45:31 -0700
X-CSE-ConnectionGUID: pFdS7zj+SFKBXhdW1hd/DA==
X-CSE-MsgGUID: TjTbW3uARTesWtubFOS25w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="182047066"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.242])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 08:45:28 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 16 Oct 2025 18:45:25 +0300 (EEST)
To: Simon Richter <Simon.Richter@hogyros.de>, 
    Lucas De Marchi <lucas.demarchi@intel.com>
cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
Subject: Re: BAR resizing broken in 6.18 (PPC only?)
In-Reply-To: <f9a8c975-f5d3-4dd2-988e-4371a1433a60@hogyros.de>
Message-ID: <a5e7a118-ba70-000e-bab4-8d56b3404325@linux.intel.com>
References: <f9a8c975-f5d3-4dd2-988e-4371a1433a60@hogyros.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 16 Oct 2025, Simon Richter wrote:

> since switching to 6.18rc1, I get
> 
> xe 0030:03:00.0: enabling device (0140 -> 0142)
> xe 0030:03:00.0: [drm] unbounded parent pci bridge, device won't support any
> PM support.
> xe 0030:03:00.0: [drm] Attempting to resize bar from 256MiB -> 16384MiB
> xe 0030:03:00.0: BAR 0 [mem 0x620c000000000-0x620c000ffffff 64bit]: releasing

Is this stock 6.18-rc1?

If yes, I'm wondering who releases BAR0 resource as I don't think Lucas' 
xe resize BAR series [1] is in 6.18-rc1. xe's _resize_bar() only releases 
BAR2 in 6.18-rc1. Neither pci_resize_resource() nor 
pbus_reassign_bridge_resources() should release the device resources which 
will then lead to pbus_reassign_bridge_resources() finding res->child and 
failing with -ENOENT because no bridge windows could be released (the 
saved list is left empty).

Was this resize attempted automatically by the xe driver during boot, not 
triggered manually through sysfs, right? (Inferring that's likely the case 
given the proximity of the "enabling device" message.)

> xe 0030:03:00.0: BAR 2 [mem 0x6200000000000-0x620000fffffff 64bit pref]:
> releasing
> pci 0030:02:01.0: bridge window [mem 0x6200000000000-0x620001fffffff 64bit
> pref]: releasing
> pci 0030:01:00.0: bridge window [mem 0x6200000000000-0x6203fbff0ffff 64bit
> pref]: releasing
> pci 0030:00:00.0: bridge window [mem 0x6200000000000-0x6203fbff0ffff 64bit
> pref]: was not released (still contains assigned resources)
> pci 0030:02:01.0: disabling bridge window [io  0x0000-0xffffffffffffffff
> disabled] to [bus 03] (unused)
> pci 0030:02:02.0: disabling bridge window [io  0x0000-0xffffffffffffffff
> disabled] to [bus 04] (unused)
> pci 0030:02:02.0: disabling bridge window [mem 0x00000000-0xffffffffffffffff
> 64bit pref disabled] to [bus 04] (unused)
> pci 0030:01:00.0: disabling bridge window [io  0x0000-0xffffffffffffffff
> disabled] to [bus 02-04] (unused)
> pci 0030:00:00.0: Assigned bridge window [mem 0x6200000000000-0x6203fbff0ffff
> 64bit pref] to [bus 01-04] cannot fit 0x4000000000 required for 0030:01:00.0
> bridging to [bus 02-04]
> pci 0030:01:00.0: bridge window [mem size 0x3fc0000000 64bit pref] to [bus
> 02-04] requires relaxed alignment rules
> pci 0030:00:00.0: disabling bridge window [io  0x0000-0xffffffffffffffff
> disabled] to [bus 01-04] (unused)
> pci 0030:01:00.0: bridge window [mem size 0x3fc0000000 64bit pref]: can't
> assign; no space
> pci 0030:01:00.0: bridge window [mem size 0x3fc0000000 64bit pref]: failed to
> assign
> pci 0030:01:00.0: bridge window [mem size 0x3fc0000000 64bit pref]: can't
> assign; no space
> pci 0030:01:00.0: bridge window [mem size 0x3fc0000000 64bit pref]: failed to
> assign
> pci 0030:02:01.0: bridge window [mem size 0x400000000 64bit pref]: can't
> assign; no space
> pci 0030:02:01.0: bridge window [mem size 0x400000000 64bit pref]: failed to
> assign
> pci 0030:02:01.0: bridge window [mem size 0x400000000 64bit pref]: can't
> assign; no space
> pci 0030:02:01.0: bridge window [mem size 0x400000000 64bit pref]: failed to
> assign
> xe 0030:03:00.0: BAR 2 [mem size 0x400000000 64bit pref]: can't assign; no
> space
> xe 0030:03:00.0: BAR 2 [mem size 0x400000000 64bit pref]: failed to assign
> xe 0030:03:00.0: BAR 0 [mem 0x620c000000000-0x620c000ffffff 64bit]: assigned
> xe 0030:03:00.0: BAR 0 [mem 0x620c000000000-0x620c000ffffff 64bit]: releasing
> xe 0030:03:00.0: BAR 2 [mem size 0x400000000 64bit pref]: can't assign; no
> space
> xe 0030:03:00.0: BAR 2 [mem size 0x400000000 64bit pref]: failed to assign
> xe 0030:03:00.0: BAR 0 [mem 0x620c000000000-0x620c000ffffff 64bit]: assigned
> pci 0030:00:00.0: PCI bridge to [bus 01-04]
> pci 0030:00:00.0:   bridge window [mem 0x620c000000000-0x620c07fefffff]
> pci 0030:00:00.0:   bridge window [mem 0x6200000000000-0x6203fbff0ffff 64bit
> pref]
> pci 0030:01:00.0: bridge window [mem 0x6200000000000-0x6203fbff0ffff 64bit
> pref]: can't claim; address conflict with 0030:01:00.0 [mem
> 0x6200020000000-0x62000207fffff 64bit pref]
> pci 0030:01:00.0: PCI bridge to [bus 02-04]
> pci 0030:01:00.0:   bridge window [mem 0x620c000000000-0x620c07fefffff]
> pci 0030:02:01.0: bridge window [mem 0x6200000000000-0x620001fffffff 64bit
> pref]: can't claim; no compatible bridge window
> pci 0030:02:01.0: PCI bridge to [bus 03]
> pci 0030:02:01.0:   bridge window [mem 0x620c000000000-0x620c0013fffff]
> xe 0030:03:00.0: [drm] Failed to resize BAR2 to 16384M (-ENOSPC). Consider
> enabling 'Resizable BAR' support in your BIOS
> xe 0030:03:00.0: BAR 2 [mem size 0x10000000 64bit pref]: can't assign; no
> space
> xe 0030:03:00.0: BAR 2 [mem size 0x10000000 64bit pref]: failed to assign
> xe 0030:03:00.0: BAR 2 [mem size 0x10000000 64bit pref]: can't assign; no
> space
> xe 0030:03:00.0: BAR 2 [mem size 0x10000000 64bit pref]: failed to assign
> xe 0030:03:00.0: [drm] Found battlemage (device ID e20b) discrete display
> version 14.01 stepping B0
> xe 0030:03:00.0: [drm] *ERROR* pci resource is not valid

I need to know PCI resource allocations of the parents too. Preferrably 
dmesg and /proc/iomem from both working and broken cases so it's easier 
to find the differences.

Please take the dmesgs with dyndbg="file drivers/pci/*.c +p" on the 
kernel's cmdline.

> There's also a bug report[1] on the freedesktop GitLab, but this may be a more
> generic problem.
> 
> I'm unsure what other "assigned resources" would be below the root that are
> not covered by the bridge window of equal size on the upstream port of the GPU

The resize now logs the usual culprit for the failure (it didn't earlier):

pci 0030:00:00.0: bridge window [mem 0x6200000000000-0x6203fbff0ffff 64bit pref]: was not released (still contains assigned resources)

It means the resize would have wanted to release this bridge window to 
ensure it can be resized (if necessary) but the bridge window has other 
children pinning the bridge window in place. You can find out what those 
other children are from the /proc/iomem.

These Intel GPUs have a BAR0 on the built-in PCI switch (likely this one 
as well but I cannot confirm it with the limited information given) which 
causes this pinning problem. Can you try if this series from Lucas helps:

[1] https://lore.kernel.org/linux-pci/20250918-xe-pci-rebar-2-v1-1-6c094702a074@intel.com/

(Please check the device ID that has the BAR0 is among the quirked IDs.)


If it doesn't help, the commit 3ab10f83e277 ("PCI: Fix finding bridge 
window in pci_reassign_bridge_resources()") is directly related to BAR 
resizing. To revert it cleanly, also the commit 85796d20a690 ("PCI: Warn 
if bridge window cannot be released when resizing BAR") has to be 
reverted but that's only informational change.


If none of those help, it's hard to know which out of the other resource 
assignment changes caused the regression, at least not until I see more 
logs.


> -- also it would be really cool if it reverted to the old state on failure
> instead of creating an invalid configuration.

It would, but unfortunately the current PCI core code is mis-structured 
and would require refactoring so that the resize can restore also the 
dev's resources as they were.

Curnently, only bridge windows are set as they were by 
pbus_reassign_bridge_resources() and that may not always result in 
same, or worse yet, successful assignment of the device BARs. Device 
resources are currently released by the driver or sysfs interface 
function, not the core's resize function and that should be to core side 
to let core to deal with the restore.

Effectively,pci_resize_resource() should be replaced with 
pci_release_and_resize_resource() that releases relevant dev's resources
and deals with the restore if rollback is required. This requires moving 
the resource save/restore from pbus_reassign_bridge_resources() to 
pci_release_and_resize_resource().

I'd very much want to do this too but I've higher priority items on my 
list, one of which attempts to resolve these resizable BARs using other 
way, that is, size the bridge windows considering the maximum size of the 
BAR right from the start. That would remove the need to try to enlarge 
BARs afterwards as there won't be more room for them anyway.

> Also, why do we change the BAR assignment while mem decoding is active?

pci_resize_resource() does check for 
pci_resize_is_memory_decoding_enabled(), do you think that is not enough?

> [1] https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/6356

-- 
 i.


