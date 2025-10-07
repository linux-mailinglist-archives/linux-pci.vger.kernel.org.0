Return-Path: <linux-pci+bounces-37677-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC08CBC1F77
	for <lists+linux-pci@lfdr.de>; Tue, 07 Oct 2025 17:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A43553BA4DE
	for <lists+linux-pci@lfdr.de>; Tue,  7 Oct 2025 15:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B48214228;
	Tue,  7 Oct 2025 15:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R7CgbLwU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18A11898E9;
	Tue,  7 Oct 2025 15:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759851792; cv=none; b=fbVV1WLjvfPcjgYamaECHFt6pygFx89nEimcU2Wn7V6MXBdT5Vm4DzCRurRNWYrAJRUt+kvmDUfn3R4MBzl/zS0uL6VjKqTdbhlX1FFzYMq5tkZFptDWvoGKShefxXl8ikVo2ajxLcUqOxYGqnesq+hXkSxd80pGxzgXLAhkcfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759851792; c=relaxed/simple;
	bh=B22kK6iXw6PJpuZqtUC85FHPEUYJnzOzwYqYr07+9CU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=algUbNO1+N/J1V86/Mg/INazcbGdKGY/BuTv2987vxEGZtU8CkL473H8a3XRQtZ+IvsaH7AvI6qP7uBcIy4OzjB5E6zcNlfEA3NLhfK49n46rZrTmdcacVV4ZQ0DYj7fYiZw/M3kRjfopxjzemc8t4lNNH4axG310j2VBYt5Bpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R7CgbLwU; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759851790; x=1791387790;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=B22kK6iXw6PJpuZqtUC85FHPEUYJnzOzwYqYr07+9CU=;
  b=R7CgbLwUQaGYABxuGITIrjQ22z7VKn0Mfpdje4QDbBd8ukR2s8WyLatr
   XlgkiMphMytQIoBbakXEDE/ZotiQfSdzSXuWCCvLn5fBXhfrU6DmV2OPK
   P9UNQkCVlHgAyI8hEThqzdEO4S1H/C0KF+In5tYE9vy4UV/UpGJHCvWQb
   Fx0gOU2NkgzAGQhXpmqzzUP/pnYFZPFZKFs7ud6WRCH/qlbvFcbc8Ikx9
   sVa/eKeDH17nw/os8bx0G+BwSJbFM51cZfuGf72+K4d+tnZJuY0gzaCQC
   8Kcq4Ls6mS9upsNgSChZUKKW+63+YJk4qsH/PlA/naF6z2VIeBDxlqzUM
   w==;
X-CSE-ConnectionGUID: dYp4AOv4S9ub2WgK/gZG+w==
X-CSE-MsgGUID: /3td3BCfRHWlKRgE/cXv9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11575"; a="61071386"
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="61071386"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2025 08:43:09 -0700
X-CSE-ConnectionGUID: BJ2vbYGeTjyYUWFgIZt3RQ==
X-CSE-MsgGUID: wfEeWKyrRiymhvzN4DaCVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="184555274"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.20])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2025 08:43:06 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 7 Oct 2025 18:43:03 +0300 (EEST)
To: Val Packett <val@packett.cool>
cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
    LKML <linux-kernel@vger.kernel.org>, 
    Lucas De Marchi <lucas.demarchi@intel.com>
Subject: Re: [PATCH 1/2] PCI: Setup bridge resources earlier
In-Reply-To: <cd8a1d3c-1386-476b-a93d-1259b81c04e9@packett.cool>
Message-ID: <8f9c9950-1612-6e2d-388a-ce69cf3aae1a@linux.intel.com>
References: <20250924134228.1663-1-ilpo.jarvinen@linux.intel.com> <20250924134228.1663-2-ilpo.jarvinen@linux.intel.com> <017ff8df-511c-4da8-b3cf-edf2cb7f1a67@packett.cool> <f5eb0360-55bd-723c-eca2-b0f7d8971848@linux.intel.com>
 <cd8a1d3c-1386-476b-a93d-1259b81c04e9@packett.cool>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-810113116-1759848332=:951"
Content-ID: <daf56f2c-8efe-c828-4fde-3abd0b7247da@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-810113116-1759848332=:951
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <db161489-31b7-8d8d-eded-6d62b361d78d@linux.intel.com>

On Mon, 6 Oct 2025, Val Packett wrote:
> On 10/6/25 7:46 AM, Ilpo J=C3=A4rvinen wrote:
> > On Mon, 6 Oct 2025, Val Packett wrote:
> > > On 9/24/25 10:42 AM, Ilpo J=C3=A4rvinen wrote:
> > > > Bridge windows are read twice from PCI Config Space, the first read=
 is
> > > > made from pci_read_bridge_windows() which does not setup the device=
's
> > > > resources. It causes problems down the road as child resources of t=
he
> > > > bridge cannot check whether they reside within the bridge window or
> > > > not.
> > > >=20
> > > > Setup the bridge windows already in pci_read_bridge_windows().
> > > >=20
> > > > Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> > > Looks like this change has broken the WiFi (but not NVMe) on my Snapd=
ragon
> > > X1E
> > > laptop (Latitude 7455):
> > Thanks for the report.
> >=20
> > > qcom-pcie 1c08000.pci: PCI host bridge to bus 0004:00
> > > pci_bus 0004:00: root bus resource [bus 00-ff]
> > > pci_bus 0004:00: root bus resource [io=C2=A0 0x100000-0x1fffff] (bus =
address
> > > [0x0000-0xfffff])
> > So this looks the first change visible in the fragment you've taken fro=
m
> > the dmesg...
> >=20
> > > pci_bus 0004:00: root bus resource [mem 0x7c300000-0x7dffffff]
> > > pci 0004:00:00.0: [17cb:0111] type 01 class 0x060400 PCIe Root Port
> > > pci 0004:00:00.0: BAR 0 [mem 0x00000000-0x00000fff]
> > > pci 0004:00:00.0: PCI bridge to [bus 01-ff]
> > ...What I don't understand in these logs is how can the code changed in
> > pci_read_bridge_windows() affect the lines before this line as it is be=
ing
> > printed from pci_read_bridge_windows(). Maybe there are more 'PCI bridg=
e
> > to' lines above the quoted part of the dmesg?
>=20
> Sorry for the confusion, the 0x100000 shift was caused by unrelated chang=
es
> (Qcom/DWC ECAM support) and I wasn't diligent enough with which exact log=
 I
> picked as the working one.

Okay, I certainly couldn't figure out how that could have happened, no=20
wonder then. :-)

> Here's the actual difference. Good:
>=20
> =E2=9D=AF dmesg | rg 0004: | rg brid
> [=C2=A0 =C2=A0 1.780172] qcom-pcie 1c08000.pci: PCI host bridge to bus 00=
04:00
> [=C2=A0 =C2=A0 1.781930] pci 0004:00:00.0: PCI bridge to [bus 01-ff]
> [=C2=A0 =C2=A0 1.781972] pci 0004:00:00.0:=C2=A0 =C2=A0bridge window [io =
0x100000-0x100fff]
> [=C2=A0 =C2=A0 1.781998] pci 0004:00:00.0:=C2=A0 =C2=A0bridge window [mem=
 0x00000000-0x000fffff]
> [=C2=A0 =C2=A0 1.782043] pci 0004:00:00.0:=C2=A0 =C2=A0bridge window [mem=
 0x00000000-0x000fffff
> 64bit pref]
> [=C2=A0 =C2=A0 1.800769] pci 0004:00:00.0: PCI bridge to [bus 01-ff]
> [=C2=A0 =C2=A0 1.976893] pcieport 0004:00:00.0: bridge window [mem
> 0x7c400000-0x7c5fffff]: assigned
>
> Bad:
>=20
> =E2=9D=AF dmesg | rg 0004: | rg brid
> [=C2=A0 =C2=A0 1.380369] qcom-pcie 1c08000.pci: PCI host bridge to bus 00=
04:00
> [=C2=A0 =C2=A0 1.442881] pci 0004:00:00.0: PCI bridge to [bus 01-ff]
> [=C2=A0 =C2=A0 1.449496] pci 0004:00:00.0:=C2=A0 =C2=A0bridge window [io =
0x100000-0x100fff]
> [=C2=A0 =C2=A0 1.462988] pci 0004:00:00.0:=C2=A0 =C2=A0bridge window [mem=
 0x00000000-0x000fffff]
> [=C2=A0 =C2=A0 1.476661] pci 0004:00:00.0:=C2=A0 =C2=A0bridge window [mem=
 0x00000000-0x000fffff
> 64bit pref]
> [=C2=A0 =C2=A0 1.502299] pci 0004:00:00.0: bridge window [mem 0x7c300000-=
0x7c3fffff]:
> assigned
> [=C2=A0 =C2=A0 1.509028] pci 0004:00:00.0: bridge window [mem 0x7c400000-=
0x7c4fffff
> 64bit pref]: assigned
> [=C2=A0 =C2=A0 1.509057] pci 0004:00:00.0: bridge window [io 0x100000-0x1=
00fff]:
> assigned
> [=C2=A0 =C2=A0 1.509085] pci 0004:00:00.0: PCI bridge to [bus 01-ff]
> [=C2=A0 =C2=A0 1.509099] pci 0004:00:00.0:=C2=A0 =C2=A0bridge window [io =
0x100000-0x100fff]
> [=C2=A0 =C2=A0 1.509124] pci 0004:00:00.0:=C2=A0 =C2=A0bridge window [mem=
 0x7c300000-0x7c3fffff]
> [=C2=A0 =C2=A0 1.509133] pci 0004:00:00.0:=C2=A0 =C2=A0bridge window [mem=
 0x7c400000-0x7c4fffff
> 64bit pref]

Interpreting these logs is usually hard even when given the whole log, it=
=20
becomes even harder when they're filtered so that many lines of interest=20
are not shown (I tried to correlate the working case to the previous=20
"wrong" "correct" log but I've no guarantee the rest would remain same).

> I've also added log lines to pci_read_bridge_bases where the other calls =
to
> the same pci_read_bridge_* functions are called, and turns out they did *=
not*
> happen.
>=20
> So it seems to me that the good reason you were wondering about for why t=
he
> resources were not set up in pci_read_bridge_windows, is that they must n=
ot be
> set up unconditionally!
>
> I think it's that early check in=C2=A0pci_read_bridge_bases=C2=A0that avo=
ids the setup
> here:
>=20
> =C2=A0 =C2=A0 if (pci_is_root_bus(child)) /* It's a host bus, nothing to =
read */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;

If there's a PCI device as is the case in pci_read_bridge_windows()=20
which inputs non-NULL pci_dev, the config space of that device can be read=
=20
normally (or should be readable normally, AFAIK). The case where bus->self=
=20
is NULL is different, we can't read from a non-existing PCI device, but=20
it doesn't apply to pci_read_bridge_windows().

I don't think reading the window is the real issue here but how the=20
resource fitting algorithm corners itself by reserving space for bridge=20
windows before it knows their sizes, so basically these lines from the=20
earlier email:

pci 0004:00:00.0: bridge window [mem 0x7c300000-0x7c3fffff]: assigned
pci 0004:00:00.0: bridge window [mem 0x7c400000-0x7c4fffff 64bit pref]: ass=
igned
pci 0004:00:00.0: BAR 0 [mem 0x7c500000-0x7c500fff]: assigned

=2E..which seem to occur before the child buses have been scanned so that=
=20
space reserved is either hotplug reservation or due to "old_size" lower=20
bounding. That non-prefetchable bridge window is too small to fit the=20
child resources.

Could you try passing pci=3Dhpmemsize=3D0M to kernel command line if that=
=20
helps?

The other case is the "old_size" in calculate_memsize() which too can=20
cause the same effect preventing sizing bridge window truly to zero when=20
it's not needed (=3D=3D disable it =3D=3D not assign it at all at that poin=
t).
Forcing it to zero would perhaps be worth a test (or removing the max()=20
related to old_size)

I've no idea why the old_size should decide anything, I hate that black=20
magic but I've just not dared to remove it (it's hard to know why some=20
things were made in the past, there could have been some HW issue worked=20
around by such odd feature but it's so old code that there isn't any real=
=20
information about whys anymore to find).

pci=3Drealloc on command line might help too, but I'm not sure. There seems=
=20
to be some extra space within the root bus resource so it might work.

I'm not sure what call chain is causing the assignment of those 3 bridge=20
windows. One easy way to find out where it comes from would be to put=20
WARN_ON(res->start =3D=3D 0x7c400000); into pci_assign_resource() next to t=
he=20
line which prints "...: assigned".

--=20
 i.
--8323328-810113116-1759848332=:951--

