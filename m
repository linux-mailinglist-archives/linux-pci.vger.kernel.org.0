Return-Path: <linux-pci+bounces-34594-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A77ECB31E05
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 17:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 823B6AA01B6
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 15:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC911F4180;
	Fri, 22 Aug 2025 15:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YXakziac"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24ABA19C558;
	Fri, 22 Aug 2025 15:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755875106; cv=none; b=MhGn84Ils+GZHQUjMRNCvFta7vdcBfP9beBfAF/bfAX6XyMJmqrHj9ZzmNrre3qGGld65+Wp0/7XW/8Qu8dl6neKkqB1MgkD7jwrIfQ/O1SPshu547DNtVMdE2VJgN4S6MLW3PGfIs+db8l78nhLyxyyRZZec9EjtuomHxA7/1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755875106; c=relaxed/simple;
	bh=dLsTZSYRVyxqxTXUWeEgGAw9LE4Neawdtev2hwiX5qk=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=TK/Q1D9g0fZryqyd1ltDZYv5iBGfk4uupdfu69GxJC4/u0efUAEifoAD6EvcyWS1yCVI5hC8BLJ5qGzk6d67NtnTktRG+5exWST2APZbKoQ0mosxfmhblaDfkWYHKWLoZwCgmtEfl8C0yFrUUEYE7GF9vMT3eiEpYSqfYdtL7QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YXakziac; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755875105; x=1787411105;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=dLsTZSYRVyxqxTXUWeEgGAw9LE4Neawdtev2hwiX5qk=;
  b=YXakziacXlRydnB92pdqu7toTnCfqZjJOjhxdxWyg6DTlbk/DrCygFJd
   uXyB848v1D07bFddwujUsvZpRDrDlvgJRgjDOQE44qqUGjVMcKUVNl0Bh
   eHD54fmVc4ulJIpuEjI+ga1mhB+Wz7LAdRGoQ/FVQ1mgtdnC4iPbs3v24
   awijsCWEI3OKbMgQz1LLW6dBTwxjrI+eTyA4qSaVzt1juajw/iQHhfcDT
   qQQJXtqEqBkxNOyjy6UW86juwD85wcCK/eia1z9C4k2IzPtAmyLaMVTFP
   UGMzQ7CvoyFIt8qliGhw3X1+3b7tqFG35qsZ98YsHKo8QiCKEwMpb5k8M
   g==;
X-CSE-ConnectionGUID: RL/kW1KHQfS3+PVehXtCoQ==
X-CSE-MsgGUID: rGB/jLZ8RE6RDMTBB6rh5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="75641767"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="75641767"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 08:05:04 -0700
X-CSE-ConnectionGUID: 4jAY6QjsTeKQlzSdx7kcaw==
X-CSE-MsgGUID: sNqH4E0FRAOEg+EUiy1s7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="172988946"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.115])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 08:04:57 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 22 Aug 2025 18:04:54 +0300 (EEST)
To: linux-pci@vger.kernel.org
cc: Andreas Larsson <andreas@gaisler.com>, Bjorn Helgaas <bhelgaas@google.com>, 
    "David S. Miller" <davem@davemloft.net>, 
    Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org, 
    linux-mips@vger.kernel.org, sparclinux@vger.kernel.org, 
    Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
    =?ISO-8859-15?Q?Christian_K=F6nig?= <christian.koenig@amd.com>, 
    Yinghai Lu <yinghai@kernel.org>, Igor Mammedov <imammedo@redhat.com>, 
    "Rafael J . Wysocki" <rafael@kernel.org>, 
    Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
    Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    LKML <linux-kernel@vger.kernel.org>, 
    =?ISO-8859-2?Q?Micha=B3_Winiarski?= <michal.winiarski@intel.com>, 
    linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 00/24] PCI: Bridge window selection improvements
In-Reply-To: <20250822145605.18172-1-ilpo.jarvinen@linux.intel.com>
Message-ID: <e256f7c5-d096-de28-3148-22b44d45f9fa@linux.intel.com>
References: <20250822145605.18172-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1455586025-1755875094=:937"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1455586025-1755875094=:937
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 22 Aug 2025, Ilpo J=C3=A4rvinen wrote:

> This series is based on top of the three resource fitting and
> assignment algorithm fixes (v3).

I realized I didn't include a link to those patches. It's this series:=20

https://lore.kernel.org/linux-pci/20250822123359.16305-1-ilpo.jarvinen@linu=
x.intel.com/

I'm sorry about the extra hassle.

--=20
 i.

> PCI resource fitting and assignment code needs to find the bridge
> window a resource belongs to in multiple places, yet, no common
> function for that exists. Thus, each site has its own version of
> the decision, each with their own corner cases, misbehaviors, and
> some resulting in complex interfaces between internal functions.
>=20
> This series tries to rectify the situation by adding two new functions
> to select the bridge window. To support these functions, bridge windows
> must always contain their type information in flags which requires
> modifying the flags behavior for bridge window resources.
>=20
> I've hit problems related to zeroed resource flags so many times by now
> that I've already lost count which has highlighted over and over again
> that clearing type information is not a good idea. As also proven by
> some changes of this series, retaining the flags for bridge windows
> ended up fixing existing issues (although kernel ended up recovering
> from the worst problem graciously and the other just results in dormant
> code).
>=20
> This series only changes resource flags behavior for bridge windows.
> The sensible direction is to make a similar change for the other
> resources as well eventually but making that change involves more
> uncertainty and is not strictly necessary yet. Driver code outside of
> PCI core could have assumptions about the flags, whereas bridge windows
> are mostly internal to PCI core code (or should be, sane endpoint
> drivers shouldn't be messing with the bridge windows). Thus, limiting
> the flags behavior changes to bridge windows for now is safer than
> attempting full behavioral change in a single step.
>=20
>=20
> I've tried to look out for any trouble that code under arch/ could
> cause after the flags start to behave differently and therefore ended
> up consolidating arch/ code to use pci_enable_resources(). My
> impression is that strictly speaking only the MIPS code would break
> similar to PCI core's copy of pci_enable_resources(), the others were
> much more lax in checking so they'd likely keep working but
> consolidation seemed still the best approach there as the enable checks
> seemed diverging for no apparent reason.
>=20
> Most sites are converted by this change. There are three known places
> that are not yet converted:
>=20
>   - fail_type based logic in __assign_resources_sorted():
>     I'm expecting to cover this along with the resizable BAR
>     changes as I need to change the fallback logic anyway (one
>     of the motivators what got me started with this series,
>     I need an easy way to acquire the bridge window during
>     retries/fallbacks if maximum sized BARs do not fit, which
>     is what this series provides).
>=20
>   - Failure detection after BAR resize: Keeps using the type
>     based heuristic for failure detection. It isn't very clear how
>     to decide which assignment failures should be counted and which
>     not. There could be pre-existing failures that keep happening
>     that end up blocking BAR resize but that's no worse than behavior
>     before this series. How to identify the relevant failures does
>     not look straightforward given the current structures. This
>     clearly needs more thought before coding any solution.
>=20
>   - resource assignment itself: This is a very complex change
>     due to bus and kernel resources abstractions and might not be
>     realistic any time soon.
>=20
> I'd have wanted to also get rid of pci_bridge_check_ranges() that
> (re)adds type information which seemed now unnecessary. It turns out,
> however, that root windows still require so it will have to wait for
> now.
>=20
> This change has been tested on a large number of machine I've access to
> which come with heterogeneous PCI configurations. Some resources
> retained their original addresses now also with pci=3Drealloc because
> this series fixed the unnecessary release(+assign) of those resources.
> Other than that, nothing worth of note from that testing.
>=20
>=20
> My test coverage is x86 centric unfortunately so I'd appreciate if
> somebody with access to non-x86 archs takes the effort to test this
> series.
>=20
> Info for potential testers:
>=20
> Usually, it's enough to gather lspci -vvv pre and post the series, and
> use diff to see whether the resources remained the same and also check
> that the same drivers are still bound to the devices to confirm that
> devices got properly enabled (also shown by lspci -vvv). I normally
> test both with and without pci=3Drealloc. In case of a trouble, besides
> lspci -vvv output, providing pre and post dmesg and /proc/iomem
> contents would be helpful, please take the dmesg with dyndbg=3D"file
> drivers/pci/*.c +p" on the kernel cmdline.
>=20
> Ilpo J=C3=A4rvinen (24):
>   m68k/PCI: Use pci_enable_resources() in pcibios_enable_device()
>   sparc/PCI: Remove pcibios_enable_device() as they do nothing extra
>   MIPS: PCI: Use pci_enable_resources()
>   PCI: Move find_bus_resource_of_type() earlier
>   PCI: Refactor find_bus_resource_of_type() logic checks
>   PCI: Always claim bridge window before its setup
>   PCI: Disable non-claimed bridge window
>   PCI: Use pci_release_resource() instead of release_resource()
>   PCI: Enable bridge even if bridge window fails to assign
>   PCI: Preserve bridge window resource type flags
>   PCI: Add defines for bridge window indexing
>   PCI: Add bridge window selection functions
>   PCI: Fix finding bridge window in pci_reassign_bridge_resources()
>   PCI: Warn if bridge window cannot be released when resizing BAR
>   PCI: Use pbus_select_window() during BAR resize
>   PCI: Use pbus_select_window_for_type() during IO window sizing
>   PCI: Rename resource variable from r to res
>   PCI: Use pbus_select_window() in space available checker
>   PCI: Use pbus_select_window_for_type() during mem window sizing
>   PCI: Refactor distributing available memory to use loops
>   PCI: Refactor remove_dev_resources() to use pbus_select_window()
>   PCI: Add pci_setup_one_bridge_window()
>   PCI: Pass bridge window to pci_bus_release_bridge_resources()
>   PCI: Alter misleading recursion to pci_bus_release_bridge_resources()
>=20
>  arch/m68k/kernel/pcibios.c   |  39 +-
>  arch/mips/pci/pci-legacy.c   |  38 +-
>  arch/sparc/kernel/leon_pci.c |  27 --
>  arch/sparc/kernel/pci.c      |  27 --
>  arch/sparc/kernel/pcic.c     |  27 --
>  drivers/pci/bus.c            |   3 +
>  drivers/pci/pci-sysfs.c      |  27 +-
>  drivers/pci/pci.h            |   8 +-
>  drivers/pci/probe.c          |  35 +-
>  drivers/pci/setup-bus.c      | 798 ++++++++++++++++++-----------------
>  drivers/pci/setup-res.c      |  46 +-
>  include/linux/pci.h          |   5 +-
>  12 files changed, 504 insertions(+), 576 deletions(-)
>=20
>=20
> base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
> prerequisite-patch-id: 801e8dd3aa9847d4945cb7d8958574a6006004ab
> prerequisite-patch-id: 0233311f04e3ea013676b6cc00626410bbe11e41
> prerequisite-patch-id: 9841faf37d56c1acf1167559613e862ef62e509d
>=20
--8323328-1455586025-1755875094=:937--

