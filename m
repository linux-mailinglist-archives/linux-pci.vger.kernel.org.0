Return-Path: <linux-pci+bounces-5945-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC9189DD53
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 16:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F04091C21125
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 14:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7278C50260;
	Tue,  9 Apr 2024 14:53:18 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBB0AD4E;
	Tue,  9 Apr 2024 14:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712674398; cv=none; b=FxnhNpepXOvrMFiP3PV6JEyvM8fdg7lEMYjNNZWfsZKuS8BeiwBMSij3v1vX2VLDj2QaMtYnHW8qyBckD0kz+0sQb2FgYPnZSytpG8bIo/NGiwN8Z+0n9WwbdQdGROPsd6WjZOvl0kXO9mZ6C5tQPp91UBNvos2OF0W67/WA+Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712674398; c=relaxed/simple;
	bh=svs9DCNZaOYa6kk+3ZgfjbqEaN7RKngKqMaKlQKfm3M=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PH5/uerAWX0tbEfATJQCYiMeeafbbOMsklCEYcFqLm2SW8jIo+5PitqS8jbaEWL4DBjq787R9C29Jhwm2JPjJbr+p7dBMaTnwvdKu5aPluMzzz6cQApXrnV0PJSno1pl9abov00Byv0jMIadKHo5l2di4qD8FH81SuivDTVKsoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VDTS373bNz6K603;
	Tue,  9 Apr 2024 22:51:31 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id CABCE1400CA;
	Tue,  9 Apr 2024 22:53:06 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 9 Apr
 2024 15:53:06 +0100
Date: Tue, 9 Apr 2024 15:53:05 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "Lorenzo
 Pieralisi" <lorenzo.pieralisi@arm.com>, Rob Herring <robh@kernel.org>,
	Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Igor Mammedov
	<imammedo@redhat.com>, Lukas Wunner <lukas@wunner.de>, Mika Westerberg
	<mika.westerberg@linux.intel.com>, Andy Shevchenko
	<andriy.shevchenko@intel.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 0/7] PCI: Solve two bridge window sizing issues
Message-ID: <20240409155305.00003022@huawei.com>
In-Reply-To: <20231228165707.3447-1-ilpo.jarvinen@linux.intel.com>
References: <20231228165707.3447-1-ilpo.jarvinen@linux.intel.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 28 Dec 2023 18:57:00 +0200
Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com> wrote:

> Hi all,
>=20
> Here's a series that contains two fixes to PCI bridge window sizing
> algorithm. Together, they should enable remove & rescan cycle to work
> for a PCI bus that has PCI devices with optional resources and/or
> disparity in BAR sizes.
>=20
> For the second fix, I chose to expose find_empty_resource_slot() from
> kernel/resource.c because it should increase accuracy of the cannot-fit
> decision (currently that function is called find_resource()). In order
> to do that sensibly, a few improvements seemed in order to make its
> interface and name of the function sane before exposing it. Thus, the
> few extra patches on resource side.
>=20
> Unfortunately I don't have a reason to suspect these would help with
> the issues related to the currently ongoing resource regression
> thread [1].
>=20
> [1] https://lore.kernel.org/linux-pci/ZXpaNCLiDM+Kv38H@marvin.atrad.com.a=
u/
>=20

Hi Ilpo

I've hit what looks to be a similar issue to this (not fixed by this series=
 :()

QEMU setup with a CXL PCI Expander bridge a single RP and a 4 port
port switch with CXL Type 3 devices below ports 0 and 1. (2 and 3 are empty=
 but
each has a single BAR).  RP and DSP on the switch all hotplug capable bridg=
es.

Note that if I touch almost anything about the configuration it all works, =
but
this particular combination doesn't. I can add a 3rd empty port or remove 1
or add or remove an EP below the switch and it all succeeds.

arm64 setup and I'd rather not set the DSM to not reenumerate (because
there should be no problem doing so.
Note that arm64 support in general isn't upstream in qemu yet (at least par=
tly
because we haven't figure out how to do PXB bus enumeration on DT) but can
be found at gitlab.com/jic23/qemu (not including the vsec additions to expa=
nd
the available CRS entries for the root bridge)

I've added EDK2 support and the vsec structures to expand the windows massi=
vely
so there 'should' be no issue with tight fits.  However, the large CRS
entries for the root bridge don't seem to get picked up.
I did some digging and the 0c bus has those windows, but not the 0c:00.0
(the root port).  I can't work out how extra space is supposed to get distr=
ibuted
to root ports.

Problem chunk with the kernel enumeration is that the first CXL type3 device
has 3 bars, but the range has been shrunken to the point where only one of =
them
fits. =20

pci 0000:0f:00.0: BAR 2 [mem 0x20000000-0x2003ffff 64bit]: assigned
pci 0000:0f:00.0: BAR 0 [mem size 0x00010000 64bit]: can't assign; no space
pci 0000:0f:00.0: BAR 0 [mem size 0x00010000 64bit]: failed to assign
pci 0000:0f:00.0: BAR 4 [mem size 0x00001000]: can't assign; no space
pci 0000:0f:00.0: BAR 4 [mem size 0x00001000]: failed to assign
pci 0000:0e:00.0: PCI bridge to [bus 0f]
pci 0000:0e:00.0:   bridge window [mem 0x20000000-0x2003ffff]
pci 0000:0e:00.0:   bridge window [mem 0x20c00000-0x20cfffff 64bit pref]
pci 0000:10:00.0: BAR 2 [mem 0x20100000-0x2013ffff 64bit]: assigned
pci 0000:10:00.0: BAR 0 [mem 0x20140000-0x2014ffff 64bit]: assigned
pci 0000:10:00.0: BAR 4 [mem 0x20150000-0x20150fff]: assigned
pci 0000:0e:01.0: PCI bridge to [bus 10]
pci 0000:0e:01.0:   bridge window [mem 0x20100000-0x2017ffff]
pci 0000:0e:01.0:   bridge window [mem 0x20d00000-0x20dfffff 64bit pref]

AS you can see the window for that first device is simply too small.

EDK2 ends up with a /proc/iomap of
(kernel hacked as if the DSM was there to prevent reenumeration.

0b000080-0b0000ff : PRP0001:00
10000000-1fffffff : PCI Bus 0000:00
  10000000-101fffff : PCI Bus 0000:0p1
  10200000-1023ffff : 0000:00:03.0
  10240000-10240fff : 0000:00:03.0
  10241000-10241fff : 0000:00:02.0
  10242000-10242fff : 0000:00:01.0
20000000-381fffff : PCI Bus 0000:0c
  20000000-2fffffff : PCI Bus 0000:0d
    20000000-2fffffff : PCI Bus 0000:0e
      20000000-23ffffff : PCI Bus 0000:12
      24000000-27ffffff : PCI Bus 0000:11
      28000000-2bffffff : PCI Bus 0000:10
      2c000000-2fffffff : PCI Bus 0000:0f
  30000000-381fffff : PCI Bus 0000:0d
    30000000-380fffff : PCI Bus 0000:0e
      30000000-31ffffff : PCI Bus 0000:12
      32000000-33ffffff : PCI Bus 0000:11
      34000000-35ffffff : PCI Bus 0000:10
        34000000-3403ffff : 0000:10:00.0
          34000080-34000087 : 0000:10:00.0
          34000088-340008a7 : 0000:10:00.0
          340008a8-340008af : 0000:10:00.0
          34010000-34010dff : 0000:10:00.0
          34020000-34020dff : 0000:10:00.0
        34040000-3404ffff : 0000:10:00.0
          34041080-340410d7 : 0000:10:00.0
          34041128-340411b7 : endpoint4
        34050000-34050fff : 0000:10:00.0
      36000000-37ffffff : PCI Bus 0000:0f
        36000000-3603ffff : 0000:0f:00.0
          36000080-36000087 : 0000:0f:00.0
          36000088-360008a7 : 0000:0f:00.0
          360008a8-360008af : 0000:0f:00.0
          36010000-36010dff : 0000:0f:00.0
          36020000-36020dff : 0000:0f:00.0
        36040000-3604ffff : 0000:0f:00.0
          36041080-360410d7 : 0000:0f:00.0
          36041128-360411b7 : endpoint3
        36050000-36050fff : 0000:0f:00.0
      38000000-3801ffff : 0000:0e:00.0
        38001080-380010d7 : mem0
      38020000-3803ffff : 0000:0e:01.0
        38021080-380210d7 : mem1
      38040000-3805ffff : 0000:0e:02.0
      38060000-3807ffff : 0000:0e:03.0
    38100000-3811ffff : 0000:0d:00.0
      38101128-381011b7 : port2
38200000-3efeffff : PCI Bus 0000:00
40000000-b9d7ffff : System RAM

With the kernel rerunning.

10000000-1fffffff : PCI Bus 0000:00
  10000000-101fffff : PCI Bus 0000:01
  10200000-1023ffff : 0000:00:03.0
  10240000-10240fff : 0000:00:01.0
  10241000-10241fff : 0000:00:02.0
  10242000-10242fff : 0000:00:03.0
20000000-381fffff : PCI Bus 0000:0c
  20000000-20bfffff : PCI Bus 0000:0d
    20000000-20afffff : PCI Bus 0000:0e
      20000000-2003ffff : PCI Bus 0000:0f
        20000000-2003ffff : 0000:0f:00.0
          20000080-20000087 : 0000:0f:00.0
          20000088-200008a7 : 0000:0f:00.0
          200008a8-200008af : 0000:0f:00.0
          20010000-20010dff : 0000:0f:00.0
          20020000-20020dff : 0000:0f:00.0
      20040000-2005ffff : 0000:0e:00.0
      20060000-2007ffff : 0000:0e:01.0
        20061080-200610d7 : mem1
      20080000-2009ffff : 0000:0e:02.0
      200a0000-200bffff : 0000:0e:03.0
      20100000-2017ffff : PCI Bus 0000:10
        20100000-2013ffff : 0000:10:00.0
          20100080-20100087 : 0000:10:00.0
          20100088-201008a7 : 0000:10:00.0
          201008a8-201008af : 0000:10:00.0
          20110000-20110dff : 0000:10:00.0
          20120000-20120dff : 0000:10:00.0
        20140000-2014ffff : 0000:10:00.0
          20141080-201410d7 : 0000:10:00.0
          20141128-201411b7 : endpoint3
        20150000-20150fff : 0000:10:00.0
      20200000-203fffff : PCI Bus 0000:11
      20400000-205fffff : PCI Bus 0000:12
    20b00000-20b1ffff : 0000:0d:00.0
      20b01128-20b011b7 : port2
  20c00000-217fffff : PCI Bus 0000:0d
    20c00000-217fffff : PCI Bus 0000:0e
      20c00000-20cfffff : PCI Bus 0000:0f
      20d00000-20dfffff : PCI Bus 0000:10
      20e00000-20efffff : PCI Bus 0000:11
      20f00000-20ffffff : PCI Bus 0000:12

All suggestions welcome.  I've tried to figure out what is going on but
beyond thinking that the=20
20000000-381fffff : PCI Bus 0000:0c
entry isn't being distributed, I'm drawing a blank.

Simpler case (no extra padding from QEMU / EDK2)

EDK2 gives:
10000000-103fffff : PCI Bus 0000:00
  10000000-101fffff : PCI Bus 0000:01
  10200000-1023ffff : 0000:00:03.0
  10240000-10240fff : 0000:00:03.0
  10241000-10241fff : 0000:00:02.0
  10242000-10242fff : 0000:00:01.0
10400000-10dfffff : PCI Bus 0000:0c
  10400000-10dfffff : PCI Bus 0000:0d
    10400000-10cfffff : PCI Bus 0000:0e
      10400000-105fffff : PCI Bus 0000:12
      10600000-107fffff : PCI Bus 0000:11
      10800000-109fffff : PCI Bus 0000:10
        10800000-1083ffff : 0000:10:00.0
          10800080-10800087 : 0000:10:00.0
          10800088-108008a7 : 0000:10:00.0
          108008a8-108008af : 0000:10:00.0
          10810000-10810dff : 0000:10:00.0
          10820000-10820dff : 0000:10:00.0
        10840000-1084ffff : 0000:10:00.0
          10841080-108410d7 : 0000:10:00.0
          10841128-108411b7 : endpoint4
        10850000-10850fff : 0000:10:00.0
      10a00000-10bfffff : PCI Bus 0000:0f
        10a00000-10a3ffff : 0000:0f:00.0
          10a00080-10a00087 : 0000:0f:00.0
          10a00088-10a008a7 : 0000:0f:00.0
          10a008a8-10a008af : 0000:0f:00.0
          10a10000-10a10dff : 0000:0f:00.0
          10a20000-10a20dff : 0000:0f:00.0
        10a40000-10a4ffff : 0000:0f:00.0
          10a41080-10a410d7 : 0000:0f:00.0
          10a41128-10a411b7 : endpoint3
        10a50000-10a50fff : 0000:0f:00.0
      10c00000-10c1ffff : 0000:0e:00.0
        10c01080-10c010d7 : mem1
      10c20000-10c3ffff : 0000:0e:01.0
        10c21080-10c210d7 : mem0
      10c40000-10c5ffff : 0000:0e:02.0
      10c60000-10c7ffff : 0000:0e:03.0
    10d00000-10d1ffff : 0000:0d:00.0
      10d01128-10d011b7 : port2
10e00000-3efeffff : PCI Bus 0000:00

And the kernel enumeration (resulting in missing BARS on 0f:00.0)

10000000-103fffff : PCI Bus 0000:00
  10000000-101fffff : PCI Bus 0000:01
  10200000-1023ffff : 0000:00:03.0
  10240000-10240fff : 0000:00:01.0
  10241000-10241fff : 0000:00:02.0
  10242000-10242fff : 0000:00:03.0
10400000-10dfffff : PCI Bus 0000:0c
  10400000-109fffff : PCI Bus 0000:0d
    10400000-108fffff : PCI Bus 0000:0e
      10400000-1043ffff : PCI Bus 0000:0f
        10400000-1043ffff : 0000:0f:00.0
          10400080-10400087 : 0000:0f:00.0
          10400088-104008a7 : 0000:0f:00.0
          104008a8-104008af : 0000:0f:00.0
          10410000-10410dff : 0000:0f:00.0
          10420000-10420dff : 0000:0f:00.0
      10440000-1045ffff : 0000:0e:00.0
      10460000-1047ffff : 0000:0e:01.0
        10461080-104610d7 : mem1
      10480000-1049ffff : 0000:0e:02.0
      104a0000-104bffff : 0000:0e:03.0
      10500000-1057ffff : PCI Bus 0000:10
        10500000-1053ffff : 0000:10:00.0
          10500080-10500087 : 0000:10:00.0
          10500088-105008a7 : 0000:10:00.0
          105008a8-105008af : 0000:10:00.0
          10510000-10510dff : 0000:10:00.0
          10520000-10520dff : 0000:10:00.0
        10540000-1054ffff : 0000:10:00.0
          10541080-105410d7 : 0000:10:00.0
          10541128-105411b7 : endpoint3
        10550000-10550fff : 0000:10:00.0
      10600000-107fffff : PCI Bus 0000:12
    10900000-1091ffff : 0000:0d:00.0
      10901128-109011b7 : port2
  10a00000-10dfffff : PCI Bus 0000:0d
    10a00000-10dfffff : PCI Bus 0000:0e
      10a00000-10afffff : PCI Bus 0000:0f
      10b00000-10bfffff : PCI Bus 0000:10
      10c00000-10cfffff : PCI Bus 0000:11
      10d00000-10dfffff : PCI Bus 0000:12
10e00000-3efeffff : PCI Bus 0000:00

Thanks,

Jonathan

> v2:
> - Add "typedef" to kerneldoc to get correct formatting
> - Use RESOURCE_SIZE_MAX instead of literal
> - Remove unnecessary checks for io{port/mem}_resource
> - Apply a few style tweaks from Andy
>=20
> Ilpo J=E4rvinen (7):
>   PCI: Fix resource double counting on remove & rescan
>   resource: Rename find_resource() to find_empty_resource_slot()
>   resource: Document find_empty_resource_slot() and resource_constraint
>   resource: Use typedef for alignf callback
>   resource: Handle simple alignment inside __find_empty_resource_slot()
>   resource: Export find_empty_resource_slot()
>   PCI: Relax bridge window tail sizing rules
>=20
>  drivers/pci/bus.c       | 10 ++----
>  drivers/pci/setup-bus.c | 80 +++++++++++++++++++++++++++++++++++++----
>  include/linux/ioport.h  | 44 ++++++++++++++++++++---
>  include/linux/pci.h     |  5 +--
>  kernel/resource.c       | 68 ++++++++++++++++-------------------
>  5 files changed, 148 insertions(+), 59 deletions(-)
>=20


