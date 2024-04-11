Return-Path: <linux-pci+bounces-6119-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2618A1132
	for <lists+linux-pci@lfdr.de>; Thu, 11 Apr 2024 12:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23A701F2D0DF
	for <lists+linux-pci@lfdr.de>; Thu, 11 Apr 2024 10:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6BF148319;
	Thu, 11 Apr 2024 10:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S8AAvu16"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685811474CB;
	Thu, 11 Apr 2024 10:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712832082; cv=none; b=KsPzysUla4JyhXnbZKmEpjh2tMREK0QRqAZnjdPJQA2PJu/2UN03iebtQREGRJScIPUshKnUpzdI42R052zW6K+FCoTd0Lzp+DO6r0nB6B3TNuEwQM8F6Iu21+zwVlsVOfc0SD2w3qffumwt4gTUlb36G46VEv9u1i5SdWH7b38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712832082; c=relaxed/simple;
	bh=kKOMlL4Ce2E8SgVfe3TBjs0PNQV/u4pxilRQcRFtEgY=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=qUv38yQ8b+jk6+6nu6HHMj2HdeWnWa9HC7hUCGoKF7UB8HZ1dVmg2OnZHKUjtyOPra/90yhAQX/EQwWUAIaiRLf3MSgFknQ1+9chU9QR5PIEhfFwcRwPRG7yPLYwaoL4DPP/FKnkqlrLk1ahtXt7WX8wZa0UdclezDlZNP+XiY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S8AAvu16; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712832080; x=1744368080;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=kKOMlL4Ce2E8SgVfe3TBjs0PNQV/u4pxilRQcRFtEgY=;
  b=S8AAvu165f/A2ZTgIDoUOSKcUiIncy6NcTu/jA/jLGcbl9efSxZ93BNm
   L6c+8UxHBaEHqcUmA4E9bxMlmczMbhIbBnBIJSuwaQ+FETB/M8/aDEIZJ
   b8a9sS8z2USSq68zF2FN738rB34t9GSXGDT5maPJ2OSmSgOy/hWGuKJK4
   mc0TdtuS6Z09gfQvne2z9tnQk5RkSUoiILp6foj6p1DRmV8HLtdYcRBJ8
   uTnStTuwe4y6/vhmlRXqcZ+8Cqx7yLbNo4zU8bjdN8p5qHII18vJAoNOm
   UCBF5qVNwctHHHl16Q05ThrMpzxdpmrnSsQ9xM5GjN4UHJ+SZnB0DPa5z
   A==;
X-CSE-ConnectionGUID: RkKI3tlZQbONVh9pLl/Rxg==
X-CSE-MsgGUID: IsGDF1yVRtW+MWxGlrHltw==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8109682"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="8109682"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 03:41:20 -0700
X-CSE-ConnectionGUID: GiKRgXeGQxybdXigjod49g==
X-CSE-MsgGUID: pvvhgQTMTDiXF4V6LcxoOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="44150914"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.30])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 03:41:14 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 11 Apr 2024 13:41:10 +0300 (EEST)
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
    Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
    Rob Herring <robh@kernel.org>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    Igor Mammedov <imammedo@redhat.com>, Lukas Wunner <lukas@wunner.de>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>, 
    Andy Shevchenko <andriy.shevchenko@intel.com>, 
    "Rafael J . Wysocki" <rafael@kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>, linuxarm@huawei.com, 
    linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2 0/7] PCI: Solve two bridge window sizing issues
In-Reply-To: <20240409155305.00003022@huawei.com>
Message-ID: <76a2504d-f68b-4d39-8aa5-92c5ef3f2ae3@linux.intel.com>
References: <20231228165707.3447-1-ilpo.jarvinen@linux.intel.com> <20240409155305.00003022@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-659572215-1712826047=:1017"
Content-ID: <dd379a59-1768-d18d-0a22-da00ad273a38@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-659572215-1712826047=:1017
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <cdccfdbc-0c27-a0e2-5f97-cd0868b89945@linux.intel.com>

On Tue, 9 Apr 2024, Jonathan Cameron wrote:
> On Thu, 28 Dec 2023 18:57:00 +0200
> Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com> wrote:
>=20
> > Here's a series that contains two fixes to PCI bridge window sizing
> > algorithm. Together, they should enable remove & rescan cycle to work
> > for a PCI bus that has PCI devices with optional resources and/or
> > disparity in BAR sizes.
> >=20
> > For the second fix, I chose to expose find_empty_resource_slot() from
> > kernel/resource.c because it should increase accuracy of the cannot-fit
> > decision (currently that function is called find_resource()). In order
> > to do that sensibly, a few improvements seemed in order to make its
> > interface and name of the function sane before exposing it. Thus, the
> > few extra patches on resource side.
> >=20
> > Unfortunately I don't have a reason to suspect these would help with
> > the issues related to the currently ongoing resource regression
> > thread [1].
> >=20
> > [1] https://lore.kernel.org/linux-pci/ZXpaNCLiDM+Kv38H@marvin.atrad.com=
=2Eau/
> >=20
>=20
> Hi Ilpo
>=20
> I've hit what looks to be a similar issue to this (not fixed by this seri=
es :()
>=20
> QEMU setup with a CXL PCI Expander bridge a single RP and a 4 port
> port switch with CXL Type 3 devices below ports 0 and 1. (2 and 3 are emp=
ty but
> each has a single BAR).  RP and DSP on the switch all hotplug capable bri=
dges.
>=20
> Note that if I touch almost anything about the configuration it all works=
, but
> this particular combination doesn't. I can add a 3rd empty port or remove=
 1
> or add or remove an EP below the switch and it all succeeds.
>=20
> arm64 setup and I'd rather not set the DSM to not reenumerate (because
> there should be no problem doing so.
> Note that arm64 support in general isn't upstream in qemu yet (at least p=
artly
> because we haven't figure out how to do PXB bus enumeration on DT) but ca=
n
> be found at gitlab.com/jic23/qemu (not including the vsec additions to ex=
pand
> the available CRS entries for the root bridge)
>=20
> I've added EDK2 support and the vsec structures to expand the windows mas=
sively
> so there 'should' be no issue with tight fits.  However, the large CRS
> entries for the root bridge don't seem to get picked up.
> I did some digging and the 0c bus has those windows, but not the 0c:00.0
> (the root port).  I can't work out how extra space is supposed to get dis=
tributed
> to root ports.
>=20
> Problem chunk with the kernel enumeration is that the first CXL type3 dev=
ice
> has 3 bars, but the range has been shrunken to the point where only one o=
f them
> fits. =20

Hi Jonathan,

I'm not entirely sure about the scenario here, because you didn't exactly=
=20
explain which steps you used before you the no space for BAR problem=20
triggers.

The main goal of this patchset is to help in cases where something is=20
first working as expected, then removed and rescanned, it is not expected=
=20
to help on initial enumeration/cases where there is no "first working"=20
condition (it might help even there, under some scenarios but that's just=
=20
"bonus", not the original goal I had in mind).=20

That being said, there is still caveats even when rescanning. In=20
multiple children/multilevel cases, the allocation still greedily follows=
=20
the current policy and only tries to use the minimal strategy when the=20
resource can no longer fit. Because the greedy strategy is the default,=20
the first allocations can consume the space that would be needed later and=
=20
all allocations should have been done with minimal strategy but due to=20
online nature of the resource allocation algorithm it's not able to=20
correct its mistake at that point.

(The above by no means implies I wouldn't have interest in looking into=20
and addressing other problems besides what this patchset tries to solve.)

> pci 0000:0f:00.0: BAR 2 [mem 0x20000000-0x2003ffff 64bit]: assigned
> pci 0000:0f:00.0: BAR 0 [mem size 0x00010000 64bit]: can't assign; no spa=
ce
> pci 0000:0f:00.0: BAR 0 [mem size 0x00010000 64bit]: failed to assign
> pci 0000:0f:00.0: BAR 4 [mem size 0x00001000]: can't assign; no space
> pci 0000:0f:00.0: BAR 4 [mem size 0x00001000]: failed to assign
> pci 0000:0e:00.0: PCI bridge to [bus 0f]
> pci 0000:0e:00.0:   bridge window [mem 0x20000000-0x2003ffff]
> pci 0000:0e:00.0:   bridge window [mem 0x20c00000-0x20cfffff 64bit pref]
> pci 0000:10:00.0: BAR 2 [mem 0x20100000-0x2013ffff 64bit]: assigned
> pci 0000:10:00.0: BAR 0 [mem 0x20140000-0x2014ffff 64bit]: assigned
> pci 0000:10:00.0: BAR 4 [mem 0x20150000-0x20150fff]: assigned
> pci 0000:0e:01.0: PCI bridge to [bus 10]
> pci 0000:0e:01.0:   bridge window [mem 0x20100000-0x2017ffff]
> pci 0000:0e:01.0:   bridge window [mem 0x20d00000-0x20dfffff 64bit pref]
>=20
> AS you can see the window for that first device is simply too small.

The challenge in tracking the allocations is that the sizes are calculated=
=20
long before the allocations occurs so it's pretty hard to track things=20
back into the root cause. And there's also the intermediate step too which=
=20
tries to fit the optional (add) sizes.

> EDK2 ends up with a /proc/iomap of
> (kernel hacked as if the DSM was there to prevent reenumeration.
>=20
> 0b000080-0b0000ff : PRP0001:00
> 10000000-1fffffff : PCI Bus 0000:00
>   10000000-101fffff : PCI Bus 0000:0p1
>   10200000-1023ffff : 0000:00:03.0
>   10240000-10240fff : 0000:00:03.0
>   10241000-10241fff : 0000:00:02.0
>   10242000-10242fff : 0000:00:01.0
> 20000000-381fffff : PCI Bus 0000:0c
>   20000000-2fffffff : PCI Bus 0000:0d
>     20000000-2fffffff : PCI Bus 0000:0e
>       20000000-23ffffff : PCI Bus 0000:12
>       24000000-27ffffff : PCI Bus 0000:11
>       28000000-2bffffff : PCI Bus 0000:10
>       2c000000-2fffffff : PCI Bus 0000:0f
>   30000000-381fffff : PCI Bus 0000:0d
>     30000000-380fffff : PCI Bus 0000:0e
>       30000000-31ffffff : PCI Bus 0000:12
>       32000000-33ffffff : PCI Bus 0000:11
>       34000000-35ffffff : PCI Bus 0000:10
>         34000000-3403ffff : 0000:10:00.0
>           34000080-34000087 : 0000:10:00.0
>           34000088-340008a7 : 0000:10:00.0
>           340008a8-340008af : 0000:10:00.0
>           34010000-34010dff : 0000:10:00.0
>           34020000-34020dff : 0000:10:00.0
>         34040000-3404ffff : 0000:10:00.0
>           34041080-340410d7 : 0000:10:00.0
>           34041128-340411b7 : endpoint4
>         34050000-34050fff : 0000:10:00.0
>       36000000-37ffffff : PCI Bus 0000:0f
>         36000000-3603ffff : 0000:0f:00.0
>           36000080-36000087 : 0000:0f:00.0
>           36000088-360008a7 : 0000:0f:00.0
>           360008a8-360008af : 0000:0f:00.0
>           36010000-36010dff : 0000:0f:00.0
>           36020000-36020dff : 0000:0f:00.0
>         36040000-3604ffff : 0000:0f:00.0
>           36041080-360410d7 : 0000:0f:00.0
>           36041128-360411b7 : endpoint3
>         36050000-36050fff : 0000:0f:00.0
>       38000000-3801ffff : 0000:0e:00.0
>         38001080-380010d7 : mem0
>       38020000-3803ffff : 0000:0e:01.0
>         38021080-380210d7 : mem1
>       38040000-3805ffff : 0000:0e:02.0
>       38060000-3807ffff : 0000:0e:03.0
>     38100000-3811ffff : 0000:0d:00.0
>       38101128-381011b7 : port2
> 38200000-3efeffff : PCI Bus 0000:00
> 40000000-b9d7ffff : System RAM
>=20
> With the kernel rerunning.
>=20
> 10000000-1fffffff : PCI Bus 0000:00
>   10000000-101fffff : PCI Bus 0000:01
>   10200000-1023ffff : 0000:00:03.0
>   10240000-10240fff : 0000:00:01.0
>   10241000-10241fff : 0000:00:02.0
>   10242000-10242fff : 0000:00:03.0
> 20000000-381fffff : PCI Bus 0000:0c
>   20000000-20bfffff : PCI Bus 0000:0d
>     20000000-20afffff : PCI Bus 0000:0e
>       20000000-2003ffff : PCI Bus 0000:0f
>         20000000-2003ffff : 0000:0f:00.0
>           20000080-20000087 : 0000:0f:00.0
>           20000088-200008a7 : 0000:0f:00.0
>           200008a8-200008af : 0000:0f:00.0
>           20010000-20010dff : 0000:0f:00.0
>           20020000-20020dff : 0000:0f:00.0
>       20040000-2005ffff : 0000:0e:00.0
>       20060000-2007ffff : 0000:0e:01.0
>         20061080-200610d7 : mem1
>       20080000-2009ffff : 0000:0e:02.0
>       200a0000-200bffff : 0000:0e:03.0
>       20100000-2017ffff : PCI Bus 0000:10
>         20100000-2013ffff : 0000:10:00.0
>           20100080-20100087 : 0000:10:00.0
>           20100088-201008a7 : 0000:10:00.0
>           201008a8-201008af : 0000:10:00.0
>           20110000-20110dff : 0000:10:00.0
>           20120000-20120dff : 0000:10:00.0
>         20140000-2014ffff : 0000:10:00.0
>           20141080-201410d7 : 0000:10:00.0
>           20141128-201411b7 : endpoint3
>         20150000-20150fff : 0000:10:00.0
>       20200000-203fffff : PCI Bus 0000:11
>       20400000-205fffff : PCI Bus 0000:12
>     20b00000-20b1ffff : 0000:0d:00.0
>       20b01128-20b011b7 : port2
>   20c00000-217fffff : PCI Bus 0000:0d
>     20c00000-217fffff : PCI Bus 0000:0e
>       20c00000-20cfffff : PCI Bus 0000:0f
>       20d00000-20dfffff : PCI Bus 0000:10
>       20e00000-20efffff : PCI Bus 0000:11
>       20f00000-20ffffff : PCI Bus 0000:12
>=20
> All suggestions welcome.  I've tried to figure out what is going on but
> beyond thinking that the=20
> 20000000-381fffff : PCI Bus 0000:0c
> entry isn't being distributed, I'm drawing a blank.

I think it would be generally useful in tracking these problems to have=20
something actually logged about these resource decisions. E.g., there are=
=20
zero pci_dbg()s in pci_bus_distribute_available_resources(). So unless the=
=20
window is adjusted, we have zero information on what's going on so no=20
surprise why everyone is "drawing a blank". :-(

What often comes into play in some scenarios is that once a bridge=20
window is assigned (res->parent is non-zero), it won't be changed. This=20
leads to some code not working as per what likely was the original intent.=
=20
Also adjust_bridge_window() seems to check for res->parent as the first=20
thing, maybe check if that prevents distributing the window?

Below is a patch which adds a bit of logging into=20
pci_bus_distribute_available_resources().

--=20
 i.

From: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH] PCI: Log bridge window distribute value

pci_bus_distribute_available_resources() is currently very silent, add
debugging print about the distribute decision.

Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

---
 drivers/pci/setup-bus.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 909e6a7c3cc3..7a455d75e657 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1917,6 +1917,11 @@ static void pci_bus_distribute_available_resources(s=
truct pci_bus *bus,
 =09=09=09=09=09   normal_bridges);
 =09}
=20
+=09pci_dbg(bridge, "distribute to bridges: %u (hp) + %u, io: %llx mem: %ll=
x mem pref: %llx\n",
+=09=09hotplug_bridges, normal_bridges,
+=09=09(unsigned long long)io_per_b, (unsigned long long)mmio_per_b,
+=09=09(unsigned long long)mmio_pref_per_b);
+
 =09for_each_pci_bridge(dev, bus) {
 =09=09struct resource *res;
 =09=09struct pci_bus *b;

--=20
tg: (4cece7649650..) log/distribute (depends on: main)
--8323328-659572215-1712826047=:1017--

