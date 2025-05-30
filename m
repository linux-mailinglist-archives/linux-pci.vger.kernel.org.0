Return-Path: <linux-pci+bounces-28698-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98800AC886E
	for <lists+linux-pci@lfdr.de>; Fri, 30 May 2025 08:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C08653A7B38
	for <lists+linux-pci@lfdr.de>; Fri, 30 May 2025 06:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60C819B5B4;
	Fri, 30 May 2025 06:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KI18tp4D"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0E6182BC;
	Fri, 30 May 2025 06:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748588137; cv=none; b=L91vpJ3/oakWBhb3DyRlU0c/VfbeYxHCgI9rWJ0uq+nG2IEk25Jkl4Mfm1GtSCQTCGBUEakrqXk12JwQ1XzOGhDL6g2N/hnF3Kv43pGSbErefRDINdfmCkdf9Kn931qiSyltMFYb1NFPpi3DHBO000Ocp/bnVC0mJ+HTPAI/ZNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748588137; c=relaxed/simple;
	bh=vAuQLRO2BYe826Jd0ZKmg9p2AKZpmICR4FajSM2ltak=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=uGpSM5T/qPFUSaYiAHlCNX20+dR8oRdEoZT6N+R22GRbch4bNdpyom4Ou+Jgq74eCKqyzU+kOA175SJZdAsrFVDCyA5dHb9YN5hwhBMWwganCeI/xV75w5NWlu9TmK1/2Nmo8ICKntxKaoSARWfCJLEXggh4td7NIBjVdA7Wr9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KI18tp4D; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748588135; x=1780124135;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=vAuQLRO2BYe826Jd0ZKmg9p2AKZpmICR4FajSM2ltak=;
  b=KI18tp4DvEmlmT7u7QRUxWIft/SO6XS7g2/PLCgbLT5GlAODV/myGIlE
   snJQ2Vnxc9ni6wDi1HFVqkITphoX51/541y6weBomoMAvPKF2slduGq6r
   7fuJznqNnc/cJhMKhlqTwtAA4RMD6S/gA3w3SeldudJmvLVWADSlf+YOy
   fNKQmfgpMSxl/z9mcGWtzYwVt8WctGfJUV719/Mo+zt5vnBulaDcCzqaz
   p+IY0OjUMEx0RNprfLlGCwlXJTyQY+EAVV9R2UkkGekOqIbc5TsfgLJFi
   czugjeynEjU4Aeb4jFj06aZSu1EGNMrg3WB6iRrclis1/BZ/BfGAXJcX4
   Q==;
X-CSE-ConnectionGUID: CtaE6DgoShGuOAH5fickxw==
X-CSE-MsgGUID: WbRv+zMoSQGHV6dn3nzxww==
X-IronPort-AV: E=McAfee;i="6700,10204,11448"; a="54467874"
X-IronPort-AV: E=Sophos;i="6.16,195,1744095600"; 
   d="scan'208";a="54467874"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2025 23:55:34 -0700
X-CSE-ConnectionGUID: kY4PrTl6Ql6AfFisMmjqUw==
X-CSE-MsgGUID: SRr7SYDMSeeQaRckZiD6Sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,195,1744095600"; 
   d="scan'208";a="174790715"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.183])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2025 23:55:31 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 30 May 2025 09:55:27 +0300 (EEST)
To: Tudor Ambarus <tudor.ambarus@linaro.org>
cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    =?ISO-8859-2?Q?Micha=B3_Winiarski?= <michal.winiarski@intel.com>, 
    Igor Mammedov <imammedo@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>, 
    William McVicker <willmcvicker@google.com>
Subject: Re: [PATCH 24/25] PCI: Perform reset_resource() and build fail list
 in sync
In-Reply-To: <30da0c82-ef21-4089-b71c-8444314035e0@linaro.org>
Message-ID: <2c361e7d-0ee6-cad7-a3d3-a49cd6db3f20@linux.intel.com>
References: <20241216175632.4175-1-ilpo.jarvinen@linux.intel.com> <20241216175632.4175-25-ilpo.jarvinen@linux.intel.com> <5f103643-5e1c-43c6-b8fe-9617d3b5447c@linaro.org> <8f281667-b4ef-9385-868f-93893b9d6611@linux.intel.com> <3a47fc82-dc21-46c3-873d-68e713304af3@linaro.org>
 <6e4b340b-a239-4550-b091-139c3724a54c@linaro.org> <30da0c82-ef21-4089-b71c-8444314035e0@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-328149068-1748588127=:1000"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-328149068-1748588127=:1000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 28 May 2025, Tudor Ambarus wrote:
> On 5/28/25 12:39 PM, Tudor Ambarus wrote:
> > On 5/28/25 12:22 PM, Tudor Ambarus wrote:
> >> On 5/6/25 4:53 PM, Ilpo J=C3=A4rvinen wrote:
> >>> On Tue, 6 May 2025, Tudor Ambarus wrote:
> >>>
> >>>> Hi!
> >>>>
> >>>> On 12/16/24 5:56 PM, Ilpo J=C3=A4rvinen wrote:
> >>>>> Resetting resource is problematic as it prevent attempting to alloc=
ate
> >>>>> the resource later, unless something in between restores the resour=
ce.
> >>>>> Similarly, if fail_head does not contain all resources that were re=
set,
> >>>>> those resource cannot be restored later.
> >>>>>
> >>>>> The entire reset/restore cycle adds complexity and leaving resource=
s
> >>>>> into reseted state causes issues to other code such as for checks d=
one
> >>>>> in pci_enable_resources(). Take a small step towards not resetting
> >>>>> resources by delaying reset until the end of resource assignment an=
d
> >>>>> build failure list (fail_head) in sync with the reset to avoid leav=
ing
> >>>>> behind resources that cannot be restored (for the case where the ca=
ller
> >>>>> provides fail_head in the first place to allow restore somewhere in=
 the
> >>>>> callchain, as is not all callers pass non-NULL fail_head).
> >>>>>
> >>>>> The Expansion ROM check is temporarily left in place while building=
 the
> >>>>> failure list until the upcoming change which reworks optional resou=
rce
> >>>>> handling.
> >>>>>
> >>>>> Ideally, whole resource reset could be removed but doing that in a =
big
> >>>>> step would make the impact non-tractable due to complexity of all
> >>>>> related code.
> >>>>>
> >>>>> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> >>>> I'm hitting the BUG_ON(!list_empty(&add_list)); in
> >>>> pci_assign_unassigned_bus_resources() [1] with 6.15-rc5 and the the
> >>>> pixel6 downstream pcie driver.
> >>>>
> >>>> I saw the thread where "a34d74877c66 PCI: Restore assigned resources
> >>>> fully after release" fixes things for some other cases, but it's not=
 the
> >>>> case here.
> >>>>
> >>>> Reverting the following patches fixes the problem:
> >>>> a34d74877c66 PCI: Restore assigned resources fully after release
> >>>> 2499f5348431 PCI: Rework optional resource handling
> >>>> 96336ec70264 PCI: Perform reset_resource() and build fail list in sy=
nc
> >>> So it's confirmed that you needed to revert also this last commit=20
> >>> 96336ec70264, not just the rework change?
> >> I needed to revert 96336ec70264 as well otherwise the build fails.
> >>>> In the working case the add_list list is empty throughout the entire
> >>>> body of pci_assign_unassigned_bus_resources().
> >>>>
> >>>> In the failing case __pci_bus_size_bridges() leaves the add_list not
> >>>> empty and __pci_bus_assign_resources() does not consume the list, th=
us
> >>>> the BUG_ON. The failing case contains an extra print that's not show=
n
> >>>> when reverting the blamed commits:
> >>>> [   13.951185][ T1101] pcieport 0000:00:00.0: bridge window [mem
> >>>> 0x00100000-0x001fffff] to [bus 01-ff] add_size 100000 add_align 1000=
00
> >>>>
> >>>> I've added some prints trying to describe the code path, see
> >>>> https://paste.ofcode.org/Aeu2YBpLztc49ZDw3uUJmd#
> >>>>
> >>>> Failing case:
> >>>> [   13.944231][ T1101] pci 0000:01:00.0: [144d:a5a5] type 00 class
> >>>> 0x000000 PCIe Endpoint
> >>>> [   13.944412][ T1101] pci 0000:01:00.0: BAR 0 [mem
> >>>> 0x00000000-0x000fffff 64bit]
> >>>> [   13.944532][ T1101] pci 0000:01:00.0: ROM [mem 0x00000000-0x0000f=
fff
> >>>> pref]
> >>>> [   13.944649][ T1101] pci 0000:01:00.0: enabling Extended Tags
> >>>> [   13.944844][ T1101] pci 0000:01:00.0: PME# supported from D0 D3ho=
t D3cold
> >>>> [   13.945015][ T1101] pci 0000:01:00.0: 15.752 Gb/s available PCIe
> >>>> bandwidth, limited by 8.0 GT/s PCIe x2 link at 0000:00:00.0 (capable=
 of
> >>>> 31.506 Gb/s with 16.0 GT/s PCIe x2 link)
> >>>> [   13.950616][ T1101] __pci_bus_size_bridges: before pbus_size_mem.
> >>>> list empty? 1
> >>>> [   13.950784][ T1101] pbus_size_mem: 2. list empty? 1
> >>>> [   13.950886][ T1101] pbus_size_mem: 1 list empty? 0
> >>>> [   13.950982][ T1101] pbus_size_mem: 3. list empty? 0
> >>>> [   13.951082][ T1101] pbus_size_mem: 4. list empty? 0
> >>>> [   13.951185][ T1101] pcieport 0000:00:00.0: bridge window [mem
> >>>> 0x00100000-0x001fffff] to [bus 01-ff] add_size 100000 add_align 1000=
00
> >>>> [   13.951448][ T1101] __pci_bus_size_bridges: after pbus_size_mem. =
list
> >>>> empty? 0
> >>>> [   13.951643][ T1101] pci_assign_unassigned_bus_resources: before
> >>>> __pci_bus_assign_resources -> list empty? 0
> >>>> [   13.951924][ T1101] pcieport 0000:00:00.0: bridge window [mem
> >>>> 0x40000000-0x401fffff]: assigned
> >>>> [   13.952248][ T1101] pci_assign_unassigned_bus_resources: after
> >>>> __pci_bus_assign_resources -> list empty? 0
> >>>> [   13.952634][ T1101] ------------[ cut here ]------------
> >>>> [   13.952818][ T1101] kernel BUG at drivers/pci/setup-bus.c:2514!
> >>>> [   13.953045][ T1101] Internal error: Oops - BUG: 00000000f2000800 =
[#1]
> >>>>  SMP
> >>>> ...
> >>>> [   13.976086][ T1101] Call trace:
> >>>> [   13.976206][ T1101]  pci_assign_unassigned_bus_resources+0x110/0x=
114 (P)
> >>>> [   13.976462][ T1101]  pci_rescan_bus+0x28/0x48
> >>>> [   13.976628][ T1101]  exynos_pcie_rc_poweron
> >>>>
> >>>> Working case:
> >>>> [   13.786961][ T1120] pci 0000:01:00.0: [144d:a5a5] type 00 class
> >>>> 0x000000 PCIe Endpoint
> >>>> [   13.787136][ T1120] pci 0000:01:00.0: BAR 0 [mem
> >>>> 0x00000000-0x000fffff 64bit]
> >>>> [   13.787280][ T1120] pci 0000:01:00.0: ROM [mem 0x00000000-0x0000f=
fff
> >>>> pref]
> >>>> [   13.787541][ T1120] pci 0000:01:00.0: enabling Extended Tags
> >>>> [   13.787808][ T1120] pci 0000:01:00.0: PME# supported from D0 D3ho=
t D3cold
> >>>> [   13.787988][ T1120] pci 0000:01:00.0: 15.752 Gb/s available PCIe
> >>>> bandwidth, limited by 8.0 GT/s PCIe x2 link at 0000:00:00.0 (capable=
 of
> >>>> 31.506 Gb/s with 16.0 GT/s PCIe x2 link)
> >>>> [   13.795279][ T1120] __pci_bus_size_bridges: before pbus_size_mem.
> >>>> list empty? 1
> >>>> [   13.795408][ T1120] pbus_size_mem: 2. list empty? 1
> >>>> [   13.795495][ T1120] pbus_size_mem: 2. list empty? 1
> >>>> [   13.795577][ T1120] __pci_bus_size_bridges: after pbus_size_mem. =
list
> >>>> empty? 1
> >>>> [   13.795692][ T1120] pci_assign_unassigned_bus_resources: before
> >>>> __pci_bus_assign_resources -> list empty? 1
> >>>> [   13.795849][ T1120] pcieport 0000:00:00.0: bridge window [mem
> >>>> 0x40000000-0x401fffff]: assigned
> >>>> [   13.796072][ T1120] pci_assign_unassigned_bus_resources: after
> >>>> __pci_bus_assign_resources -> list empty? 1
> >>>> [   13.796662][ T1120] cpif: s5100_poweron_pcie: DBG: MSI sfr not se=
t
> >>>> up, yet(s5100_pdev is NULL)
> >>>> [   13.796666][ T1120] cpif: register_pcie: s51xx_pcie_init start
> >>>>
> >>>>
> >>>> Any hints are welcomed. Thanks,
> >>>> ta
> >>> Hi and thanks for the report.
> >> Hi! Thanks for the help. I've been out of office for the last 2 weeks,
> >> sorry for the delayed reply.
> >>
> >>> The interesting part occurs inside reassign_resources_sorted() where =
most=20
> >>> items are eliminated from realloc_head by the list_del().
> >>>
> >>> My guess is that somehow, the change in 96336ec70264 from !res->flags
> >>> to the more complicated check somehow causes this. If the new check=
=20
> >>> doesn't match and subsequently, no match is found from the head list,=
 the=20
> >>> loop will do continue and not remove the entry from realloc_head.
> >> I added a print right there and it seems it's something else. See belo=
w.
> >>> But it's hard to confirm without knowing what that resources realloc_=
head=20
> >>> contains. Perhaps if you print the resources that are processed aroun=
d=20
> >>> that part of the code in reassign_resources_sorted(), comparing the l=
og=20
> >>> from the reverted code with the non-working case might help to unders=
tand=20
> >>> what is different there and why. To understand better what is in the =
head=20
> >>> list, it would be also useful to know from which device the resources=
 were=20
> >>> added into the head list in pdev_sort_resources().
> >>>
> >> I added the suggested prints
> >> (https://paste.ofcode.org/DgmZGGgS6D36nWEzmfCqMm) on top of v6.15 with
> >> the downstream PCIe pixel driver and I obtain the following. Note that
> >> all added prints contain "tudor" for differentiation.
> >>
> >> [   15.211179][ T1107] pci 0001:01:00.0: [144d:a5a5] type 00 class
> >> 0x000000 PCIe Endpoint
> >> [   15.212248][ T1107] pci 0001:01:00.0: BAR 0 [mem
> >> 0x00000000-0x000fffff 64bit]
> >> [   15.212775][ T1107] pci 0001:01:00.0: ROM [mem 0x00000000-0x0000fff=
f
> >> pref]
> >> [   15.213195][ T1107] pci 0001:01:00.0: enabling Extended Tags
> >> [   15.213720][ T1107] pci 0001:01:00.0: PME# supported from D0 D3hot
> >> D3cold
> >> [   15.214035][ T1107] pci 0001:01:00.0: 15.752 Gb/s available PCIe
> >> bandwidth, limited by 8.0 GT/s PCIe x2 link at 0001:00:00.0 (capable o=
f
> >> 31.506 Gb/s with 16.0 GT/s PCIe x2 link)
> >> [   15.222286][ T1107] pci 0001:01:00.0: tudor: 1: pbus_size_mem: BAR =
0
> >> [mem 0x00000000-0x000fffff 64bit] list empty? 1
> >> [   15.222813][ T1107] pci 0001:01:00.0: tudor: 1: pbus_size_mem: ROM
> >> [mem 0x00000000-0x0000ffff pref] list empty? 1
> >> [   15.224429][ T1107] pci 0001:01:00.0: tudor: 2: pbus_size_mem: ROM
> >> [mem 0x00000000-0x0000ffff pref] list empty? 0
> >> [   15.224750][ T1107] pcieport 0001:00:00.0: bridge window [mem
> >> 0x00100000-0x001fffff] to [bus 01-ff] add_size 100000 add_align 100000
> >>
> >> [   15.225393][ T1107] tudor : pci_assign_unassigned_bus_resources:
> >> before __pci_bus_assign_resources -> list empty? 0
> >> [   15.225594][ T1107] pcieport 0001:00:00.0: tudor:
> >> pdev_sort_resources: bridge window [mem 0x00100000-0x001fffff] resourc=
e
> >> added in head list
> >> [   15.226078][ T1107] pcieport 0001:00:00.0: bridge window [mem
> >> 0x40000000-0x401fffff]: assigned
> >> [   15.226419][ T1107] tudor : pci_assign_unassigned_bus_resources:
> >> after __pci_bus_assign_resources -> list empty? 0
> >> [   15.226442][ T1107] ------------[ cut here ]------------
> >> [   15.227587][ T1107] kernel BUG at drivers/pci/setup-bus.c:2522!
> >> [   15.227813][ T1107] Internal error: Oops - BUG: 00000000f2000800 [#=
1]
> >>  SMP
> >> ...
> >> [   15.251570][ T1107] Call trace:
> >> [   15.251690][ T1107]  pci_assign_unassigned_bus_resources+0x110/0x11=
4 (P)
> >> [   15.251945][ T1107]  pci_rescan_bus+0x28/0x48
> >>
> >> I obtain the following output when using the same prints adapted
> >> (https://paste.ofcode.org/37w7RnKkPaCxyNhi5yhZPbZ) and with the blamed
> >> commits reverted:
> >> a34d74877c66 PCI: Restore assigned resources fully after release
> >> 2499f5348431 PCI: Rework optional resource handling
> >> 96336ec70264 PCI: Perform reset_resource() and build fail list in sync
> >>
> >> [   15.200456][ T1102] pci 0000:01:00.0: [144d:a5a5] type 00 class
> >> 0x000000 PCIe Endpoint
> >> [   15.200632][ T1102] pci 0000:01:00.0: BAR 0 [mem
> >> 0x00000000-0x000fffff 64bit]
> >> [   15.200755][ T1102] pci 0000:01:00.0: ROM [mem 0x00000000-0x0000fff=
f
> >> pref]
> >> [   15.200876][ T1102] pci 0000:01:00.0: enabling Extended Tags
> >> [   15.201075][ T1102] pci 0000:01:00.0: PME# supported from D0 D3hot =
D3cold
> >> [   15.201254][ T1102] pci 0000:01:00.0: 15.752 Gb/s available PCIe
> >> bandwidth, limited by 8.0 GT/s PCIe x2 link at 0000:00:00.0 (capable o=
f
> >> 31.506 Gb/s with 16.0 GT/s PCIe x2 link)
> >> [   15.206555][ T1102] pci 0000:01:00.0: tudor: 1: pbus_size_mem: BAR =
0
> >> [mem 0x00000000-0x000fffff 64bit] list empty? 1
> >> [   15.206737][ T1102] pci 0000:01:00.0: tudor: 1: pbus_size_mem: ROM
> >> [mem 0x00000000-0x0000ffff pref] list empty? 1
> >> [   15.206901][ T1102] tudor : pci_assign_unassigned_bus_resources:
> >> before __pci_bus_assign_resources -> list empty? 1
> >> [   15.207072][ T1102] pcieport 0000:00:00.0: tudor:
> >> pdev_sort_resources: bridge window [mem 0x00100000-0x002fffff] resourc=
e
> >> added in head list
> >> [   15.207396][ T1102] pcieport 0000:00:00.0: bridge window [mem
> >> 0x40000000-0x401fffff]: assigned
> >> [   15.208165][ T1102] tudor : pci_assign_unassigned_bus_resources:
> >> after __pci_bus_assign_resources -> list empty? 1
> >> [   15.208783][ T1102] cpif: s5100_poweron_pcie: DBG: MSI sfr not set
> >> up, yet(s5100_pdev is NULL)
> >> [   15.208786][ T1102] cpif: register_pcie: s51xx_pcie_init start
> >=20
> > I see my email client split the lines for the prints making the output
> > very hard to read. Added the output here too:
> > https://paste.ofcode.org/AEfjASQW8Z2jbMak5VkmpJ
>=20
> With the following change things get back to how they were before
> 2499f5348431:
>=20
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 5247370010aa..1589dd8afa69 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -1214,9 +1214,10 @@ static int pbus_size_mem(struct pci_bus *bus,
> unsigned long mask,
>  =09=09=09=09__func__, r_name, r, list_empty(realloc_head));
>=20
>  =09=09=09/* Put SRIOV requested res to the optional list */
> -=09=09=09if (realloc_head && pci_resource_is_optional(dev, i)) {
> +=09=09=09if (realloc_head && pci_resource_is_iov(i)) {
>  =09=09=09=09add_align =3D max(pci_resource_alignment(dev, r), add_align)=
;
> -=09=09=09=09add_to_list(realloc_head, dev, r, 0, 0 /* Don't care */);
> +=09=09=09=09resource_set_size(r, 0);
> +=09=09=09=09add_to_list(realloc_head, dev, r, r_size, 0 /* Don't care */=
);
>  =09=09=09=09children_add_size +=3D r_size;
>  =09=09=09=09pci_info(dev, "tudor: 2: %s: %s %pR list empty? %d\n",
>  =09=09=09=09=09__func__, r_name, r, list_empty(realloc_head));

Okay, thanks for the additional data point, but I don't think the problem=
=20
is at this site. That removal of that resource_set_size(r, 0) is crucial=20
piece in my changes (and as is, it even doesn't extend far enough and we=20
can end up lose resources in some situations when their sizes are reset=20
like that).

This entire resource fitting and assignment code as whole is very complex=
=20
spanning many functions. The steps are roughly these:

1) calculate sizing in advance (which the above code relates to)
2) collect all resources we want to assign in a PCI bus subtree
3) opportunistically assign with the optional sizes
4) if everything was assigned, skip steps 5-7.
5) release some/all from step 2 assignments
6) assign only required resources
7) reassign optional parts (enlargen to include the optional sizes) what=20
   we can
8) As a final sanity check, realloc_head is checked to have been fully
   consumed by the earlier steps (~ no unchecked work todo remains)

In some cases, kernel iterates the entire process a few times (but=20
that mostly occurs when pci=3Drealloc is given on the kernel cmdline).

Now, as discussed in my other replay, it looks at some point the algorithm=
=20
assigned the bridge window resource successfully, but it still remained in=
=20
the realloc_head for some reason if I parsed all the information from your=
=20
debug patch right. The resource should have been removed from realloc_head=
=20
before __assign_resources_sorted() exits if it got assigned, if it=20
wasn't, that's the bug we're looking for. (Alternatively, it could have=20
been that the assignment was never tried for the particular resource,=20
but it now looks that might not be the case here).

--=20
 i.

--8323328-328149068-1748588127=:1000--

