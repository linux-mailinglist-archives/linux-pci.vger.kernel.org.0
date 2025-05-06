Return-Path: <linux-pci+bounces-27286-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36130AACA20
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 17:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D04C04625E9
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 15:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817E12820DC;
	Tue,  6 May 2025 15:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lkBfG8lt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8392F281508;
	Tue,  6 May 2025 15:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746546844; cv=none; b=n1I2eNgj7yrzvJPW/1EU2qzItxMQeAf3RaXUzTWxjbUYuza7ALkYaIUYp71x2v6pv3WuTD+d3ppWgwI8GzhSHMaJg/gAphbIlroA52uP3Pz/9RfYOf2+f4ZQfXJgRBz0hbsRh7xB4YY/LpChPbkGNPIesYYW1fVZ7Jdzh7p+x7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746546844; c=relaxed/simple;
	bh=mHMZw/O+jl2IvaiNauy7qpYG1fm2THzjWXfjMNV2hyM=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=p6+wamrpgYR/DgubEtVBzKfOya1NmX09EnhKtaO6UMZmlgVlZQR51P50l5TlZ99/ih+wmXqIaeycyLTW0zPdUeVEguS5PBZul/SGcsPFEXT7pwDHPe9qUHXDcScy8vwiu3769D73d2UgGWJXGw7gUG1QmZ9Vxvgw9iW0Vd5Vq74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lkBfG8lt; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746546843; x=1778082843;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=mHMZw/O+jl2IvaiNauy7qpYG1fm2THzjWXfjMNV2hyM=;
  b=lkBfG8ltfNP1F9YYHv005MCNxfcxMh0WhfdVTAm3enAaE6HDmq8BeSTJ
   k23e7DVSEbZ7if5KKOpeBGzTzfpmPcfs2Iru2vROWIL6spgqAtKPNlAj/
   gjlPRNVQw6UToRYhYUIYyGL+ngCjNq4Cmj54foJ02RBzNH+Txrc4Mg9sY
   1gsiJyUnuSEIF7RbmUTJl9pRKTjigBapFlMmH+VODAnslwfpXCojlkydr
   GgQCig8WDFAs1mG9og5htXFAUakvNLwhu3S9PwaqXnPyi5Sm14KeYH5hH
   3a4GFnklt8kmzydJY1WNzWdxGrkg6q5k5Sh68ijAXze6pwUnalbnT6LRA
   g==;
X-CSE-ConnectionGUID: adKhvYBBRfO6JXl0N0M4TQ==
X-CSE-MsgGUID: EwJQcO6FTJ6zobiXYHi7tg==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="48352903"
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; 
   d="scan'208";a="48352903"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 08:54:02 -0700
X-CSE-ConnectionGUID: ncB1lcP8Ti+6wfOs0NwzPw==
X-CSE-MsgGUID: wCkeDJrBSb22w/+wG3Ogsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; 
   d="scan'208";a="135629428"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.207])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 08:53:59 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 6 May 2025 18:53:56 +0300 (EEST)
To: Tudor Ambarus <tudor.ambarus@linaro.org>
cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    =?ISO-8859-2?Q?Micha=B3_Winiarski?= <michal.winiarski@intel.com>, 
    Igor Mammedov <imammedo@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>, 
    William McVicker <willmcvicker@google.com>
Subject: Re: [PATCH 24/25] PCI: Perform reset_resource() and build fail list
 in sync
In-Reply-To: <5f103643-5e1c-43c6-b8fe-9617d3b5447c@linaro.org>
Message-ID: <8f281667-b4ef-9385-868f-93893b9d6611@linux.intel.com>
References: <20241216175632.4175-1-ilpo.jarvinen@linux.intel.com> <20241216175632.4175-25-ilpo.jarvinen@linux.intel.com> <5f103643-5e1c-43c6-b8fe-9617d3b5447c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-165939206-1746545902=:26159"
Content-ID: <7fab6f6c-810c-1b11-3431-78e8200c6da7@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-165939206-1746545902=:26159
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <9b0130d7-9e96-e8ad-50ee-c1d1edf6f76c@linux.intel.com>

On Tue, 6 May 2025, Tudor Ambarus wrote:

> Hi!
>=20
> On 12/16/24 5:56 PM, Ilpo J=E4rvinen wrote:
> > Resetting resource is problematic as it prevent attempting to allocate
> > the resource later, unless something in between restores the resource.
> > Similarly, if fail_head does not contain all resources that were reset,
> > those resource cannot be restored later.
> >=20
> > The entire reset/restore cycle adds complexity and leaving resources
> > into reseted state causes issues to other code such as for checks done
> > in pci_enable_resources(). Take a small step towards not resetting
> > resources by delaying reset until the end of resource assignment and
> > build failure list (fail_head) in sync with the reset to avoid leaving
> > behind resources that cannot be restored (for the case where the caller
> > provides fail_head in the first place to allow restore somewhere in the
> > callchain, as is not all callers pass non-NULL fail_head).
> >=20
> > The Expansion ROM check is temporarily left in place while building the
> > failure list until the upcoming change which reworks optional resource
> > handling.
> >=20
> > Ideally, whole resource reset could be removed but doing that in a big
> > step would make the impact non-tractable due to complexity of all
> > related code.
> >=20
> > Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
>=20
> I'm hitting the BUG_ON(!list_empty(&add_list)); in
> pci_assign_unassigned_bus_resources() [1] with 6.15-rc5 and the the
> pixel6 downstream pcie driver.
>=20
> I saw the thread where "a34d74877c66 PCI: Restore assigned resources
> fully after release" fixes things for some other cases, but it's not the
> case here.
>=20
> Reverting the following patches fixes the problem:
> a34d74877c66 PCI: Restore assigned resources fully after release
> 2499f5348431 PCI: Rework optional resource handling
> 96336ec70264 PCI: Perform reset_resource() and build fail list in sync

So it's confirmed that you needed to revert also this last commit=20
96336ec70264, not just the rework change?

> In the working case the add_list list is empty throughout the entire
> body of pci_assign_unassigned_bus_resources().
>=20
> In the failing case __pci_bus_size_bridges() leaves the add_list not
> empty and __pci_bus_assign_resources() does not consume the list, thus
> the BUG_ON. The failing case contains an extra print that's not shown
> when reverting the blamed commits:
> [   13.951185][ T1101] pcieport 0000:00:00.0: bridge window [mem
> 0x00100000-0x001fffff] to [bus 01-ff] add_size 100000 add_align 100000
>=20
> I've added some prints trying to describe the code path, see
> https://paste.ofcode.org/Aeu2YBpLztc49ZDw3uUJmd#
>=20
> Failing case:
> [   13.944231][ T1101] pci 0000:01:00.0: [144d:a5a5] type 00 class
> 0x000000 PCIe Endpoint
> [   13.944412][ T1101] pci 0000:01:00.0: BAR 0 [mem
> 0x00000000-0x000fffff 64bit]
> [   13.944532][ T1101] pci 0000:01:00.0: ROM [mem 0x00000000-0x0000ffff
> pref]
> [   13.944649][ T1101] pci 0000:01:00.0: enabling Extended Tags
> [   13.944844][ T1101] pci 0000:01:00.0: PME# supported from D0 D3hot D3c=
old
> [   13.945015][ T1101] pci 0000:01:00.0: 15.752 Gb/s available PCIe
> bandwidth, limited by 8.0 GT/s PCIe x2 link at 0000:00:00.0 (capable of
> 31.506 Gb/s with 16.0 GT/s PCIe x2 link)
> [   13.950616][ T1101] __pci_bus_size_bridges: before pbus_size_mem.
> list empty? 1
> [   13.950784][ T1101] pbus_size_mem: 2. list empty? 1
> [   13.950886][ T1101] pbus_size_mem: 1 list empty? 0
> [   13.950982][ T1101] pbus_size_mem: 3. list empty? 0
> [   13.951082][ T1101] pbus_size_mem: 4. list empty? 0
> [   13.951185][ T1101] pcieport 0000:00:00.0: bridge window [mem
> 0x00100000-0x001fffff] to [bus 01-ff] add_size 100000 add_align 100000
> [   13.951448][ T1101] __pci_bus_size_bridges: after pbus_size_mem. list
> empty? 0
> [   13.951643][ T1101] pci_assign_unassigned_bus_resources: before
> __pci_bus_assign_resources -> list empty? 0
> [   13.951924][ T1101] pcieport 0000:00:00.0: bridge window [mem
> 0x40000000-0x401fffff]: assigned
> [   13.952248][ T1101] pci_assign_unassigned_bus_resources: after
> __pci_bus_assign_resources -> list empty? 0
> [   13.952634][ T1101] ------------[ cut here ]------------
> [   13.952818][ T1101] kernel BUG at drivers/pci/setup-bus.c:2514!
> [   13.953045][ T1101] Internal error: Oops - BUG: 00000000f2000800 [#1]
>  SMP
> ...
> [   13.976086][ T1101] Call trace:
> [   13.976206][ T1101]  pci_assign_unassigned_bus_resources+0x110/0x114 (=
P)
> [   13.976462][ T1101]  pci_rescan_bus+0x28/0x48
> [   13.976628][ T1101]  exynos_pcie_rc_poweron
>=20
> Working case:
> [   13.786961][ T1120] pci 0000:01:00.0: [144d:a5a5] type 00 class
> 0x000000 PCIe Endpoint
> [   13.787136][ T1120] pci 0000:01:00.0: BAR 0 [mem
> 0x00000000-0x000fffff 64bit]
> [   13.787280][ T1120] pci 0000:01:00.0: ROM [mem 0x00000000-0x0000ffff
> pref]
> [   13.787541][ T1120] pci 0000:01:00.0: enabling Extended Tags
> [   13.787808][ T1120] pci 0000:01:00.0: PME# supported from D0 D3hot D3c=
old
> [   13.787988][ T1120] pci 0000:01:00.0: 15.752 Gb/s available PCIe
> bandwidth, limited by 8.0 GT/s PCIe x2 link at 0000:00:00.0 (capable of
> 31.506 Gb/s with 16.0 GT/s PCIe x2 link)
> [   13.795279][ T1120] __pci_bus_size_bridges: before pbus_size_mem.
> list empty? 1
> [   13.795408][ T1120] pbus_size_mem: 2. list empty? 1
> [   13.795495][ T1120] pbus_size_mem: 2. list empty? 1
> [   13.795577][ T1120] __pci_bus_size_bridges: after pbus_size_mem. list
> empty? 1
> [   13.795692][ T1120] pci_assign_unassigned_bus_resources: before
> __pci_bus_assign_resources -> list empty? 1
> [   13.795849][ T1120] pcieport 0000:00:00.0: bridge window [mem
> 0x40000000-0x401fffff]: assigned
> [   13.796072][ T1120] pci_assign_unassigned_bus_resources: after
> __pci_bus_assign_resources -> list empty? 1
> [   13.796662][ T1120] cpif: s5100_poweron_pcie: DBG: MSI sfr not set
> up, yet(s5100_pdev is NULL)
> [   13.796666][ T1120] cpif: register_pcie: s51xx_pcie_init start
>=20
>=20
> Any hints are welcomed. Thanks,
> ta

Hi and thanks for the report.

The interesting part occurs inside reassign_resources_sorted() where most=
=20
items are eliminated from realloc_head by the list_del().

My guess is that somehow, the change in 96336ec70264 from !res->flags
to the more complicated check somehow causes this. If the new check=20
doesn't match and subsequently, no match is found from the head list, the=
=20
loop will do continue and not remove the entry from realloc_head.

But it's hard to confirm without knowing what that resources realloc_head=
=20
contains. Perhaps if you print the resources that are processed around=20
that part of the code in reassign_resources_sorted(), comparing the log=20
from the reverted code with the non-working case might help to understand=
=20
what is different there and why. To understand better what is in the head=
=20
list, it would be also useful to know from which device the resources were=
=20
added into the head list in pdev_sort_resources().


In any case, that BUG_ON() seems a bit drastic action for what might be=20
just a single resource allocation failure so it should be downgraded to:

if (WARN_ON(!list_empty(&add_list))
=09free_list(&add_list);
=09
=2E.. or WARN_ON_ONCE().

--=20
 i.
--8323328-165939206-1746545902=:26159--

