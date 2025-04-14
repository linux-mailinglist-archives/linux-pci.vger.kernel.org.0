Return-Path: <linux-pci+bounces-25803-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F960A87C64
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 11:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C7AF173C2A
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 09:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C25259C89;
	Mon, 14 Apr 2025 09:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aFRfUS0I"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70ED3257AFA;
	Mon, 14 Apr 2025 09:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744624344; cv=none; b=UlNnUnmCYlB2hpQkG9+3CoISjbiAJOxU0vXNa71vugyEytIOuFqXJRiplorfH8iKQKERcq9JR6LpuNGUW3bdSTv6+T6G7wV35sL44lI8ZhY3oui7k7BufxuYC5uu7KQStEq2+WHUw1ZB1SmvZBBYXoC4PWvU/OvbqQHTp5tIckI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744624344; c=relaxed/simple;
	bh=SD4T2PQYUr6HxZLSNmYnN35g3/tSps4A6TF2B0BkyaU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=NDzU4xfKzjmpJ8jxV2Xx4NzdJR/qANN5uQt9mR6KIv0jZ8CIJRNMOkx0D+Eut820ybAo93t/YDabgQLgkgJlrrTezSKP3hw13sGd21Vwy/VZGisKuSfeeKj45c1kPnjDmVjlawUHV/ACZPOVWHYVjt5i4uLvZLN8w6gvO3HKJNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aFRfUS0I; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744624343; x=1776160343;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=SD4T2PQYUr6HxZLSNmYnN35g3/tSps4A6TF2B0BkyaU=;
  b=aFRfUS0IdzngmEXrNCiparYw6g50mnsgtCPwohS99p0U3lFuOihsa0I5
   eDI/HCrlC/Na+b4OaSHl2RSkl3IJ8uEZraMUynQKTuM8aK7nogOjzTM96
   NrZxiIcf7nq5yX/dLep0A1A20Ee/REEiPH100qx0z9ASEuCHXQ/YjnZ3R
   r48xKEglVBb9QxOsgzAcOpSgaX9guJg/e7WEH5XrrrtWUAb+BjXKjrXC5
   uJqfy7zEzoQ+JEhCRYX9bCcB2l/8MDDWAWnp/uhl166mAaUYSszVx6GHM
   9110eLUr2UmcYSyKLfrsCpeFg+pt0VaYZZZHL74poV7Y25B9ghx7Uhvkr
   w==;
X-CSE-ConnectionGUID: H6THgTOxRtiRFCkp259doA==
X-CSE-MsgGUID: +9vSmf23QEyXgkZiH5T6Rg==
X-IronPort-AV: E=McAfee;i="6700,10204,11402"; a="57075082"
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; 
   d="scan'208";a="57075082"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 02:52:22 -0700
X-CSE-ConnectionGUID: TTxEBTXhSfiU+vBy/WsnaQ==
X-CSE-MsgGUID: 7UcdVtzxTkGYWnaur86VFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; 
   d="scan'208";a="129707278"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.8])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 02:52:18 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 14 Apr 2025 12:52:15 +0300 (EEST)
To: =?ISO-8859-2?Q?Ond=F8ej_Jirman?= <megi@xff.cz>
cc: Guenter Roeck <linux@roeck-us.net>, Bjorn Helgaas <bhelgaas@google.com>, 
    linux-pci@vger.kernel.org, 
    =?ISO-8859-2?Q?Micha=B3_Winiarski?= <michal.winiarski@intel.com>, 
    Igor Mammedov <imammedo@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 24/25] PCI: Perform reset_resource() and build fail list
 in sync
In-Reply-To: <nb4knp52jylojmj3jsvvgq2dsbn3srruxmkqfuto2k3hv3fnqs@6rkqgdved6gi>
Message-ID: <9c9d5aed-ae10-f590-3e59-34234d4d8f7d@linux.intel.com>
References: <20241216175632.4175-1-ilpo.jarvinen@linux.intel.com> <20241216175632.4175-25-ilpo.jarvinen@linux.intel.com> <01eb7d40-f5b5-4ec5-b390-a5c042c30aff@roeck-us.net> <75f74b48-edd8-7d1c-d303-1222d12e3812@linux.intel.com> <6612c4d2-2533-98ef-7c89-f61d80c3e3e2@linux.intel.com>
 <5eb8fd42-b288-4ecb-ae0e-177904cc0a14@roeck-us.net> <c34c6dc2-5ab2-1a81-3ba4-b3bc2c016945@linux.intel.com> <nb4knp52jylojmj3jsvvgq2dsbn3srruxmkqfuto2k3hv3fnqs@6rkqgdved6gi>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1179349992-1744624335=:7362"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1179349992-1744624335=:7362
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 11 Apr 2025, Ond=F8ej Jirman wrote:

> Hello Ilpo,
>=20
> On Tue, Apr 01, 2025 at 08:38:48PM +0300, Ilpo J=E4rvinen wrote:
> > That log wasn't taken from a bad case but it doesn't matter anymore as =
I=20
> > could test this with qemu myself, thanks for providing enough to make i=
t=20
> > easy to reproduce & test it locally :-).
> >=20
> > The problem is caused by assign+release cycle being destructive on star=
t=20
> > aligned resources because successful assigment overwrites the start fie=
ld.=20
> > I'll send a patch to fix the problem once I've given it a bit more thou=
ght
> > as this resource fitting code is somewhat complex.
>=20
> BTW, same thing here on a different SoC:
>=20
> https://lore.kernel.org/lkml/hrcsm2bo4ysqj2ggejndlou32cdc7yiknnm5nrlcoz4d=
64wall@7te4dfqsoe3y/T/#u
>=20
> There are kernel logs there, too, although I don't have dynamic debug ena=
bled
> in the kernel.
>=20
> Interestingly, bisect pointed me initially to a different commit. Reverti=
ng
> it helped, but just on one board (QuartzPro64).

Hi,

Since you didn't mention it, I guess you haven't tried the fix:

https://patchwork.kernel.org/project/linux-pci/patch/20250403093137.1481-1-=
ilpo.jarvinen@linux.intel.com/

--=20
 i.

> And this is iomem:
>=20
> 0010f000-0010f0ff : 10f000.sram sram@10f000
> 00200000-e2bbffff : System RAM
>   02010000-0474ffff : Kernel code
>   04750000-0498ffff : reserved
>   04990000-0508ffff : Kernel data
>   daa00000-e29fffff : reserved
> e2bc0000-ecbbffff : reserved
>   e2bc0000-ecbbffff : reserved
> ecbc0000-efffffff : System RAM
>   ecbc7000-ecbdffff : reserved
> f0000000-f00fffff : a40000000.pcie config
> f0200000-f0ffffff : pcie@fe150000
>   f0200000-f020ffff : 0000:00:00.0
>   f0300000-f03fffff : PCI Bus 0000:01
>     f0300000-f0303fff : 0000:01:00.0
>       f0300000-f0303fff : nvme
>     f0304000-f03040ff : 0000:01:00.0
>       f0304000-f03040ff : nvme
> f2000000-f20fffff : a40800000.pcie config
> f2200000-f2ffffff : pcie@fe170000
>   f2200000-f27fffff : PCI Bus 0002:21
>     f2200000-f220ffff : 0002:21:00.0
>     f2400000-f27fffff : 0002:21:00.0
>   f2800000-f280ffff : 0002:20:00.0
> f3000000-f30fffff : a40c00000.pcie config
> f3200000-f3ffffff : pcie@fe180000
>   f3200000-f320ffff : 0003:30:00.0
>   f3300000-f33fffff : PCI Bus 0003:31
>     f3300000-f3303fff : 0003:31:00.0
>     f3304000-f3304fff : 0003:31:00.0
>       f3304000-f3304fff : r8169
> fb000000-fb1fffff : fb000000.gpu gpu@fb000000
> fc00c100-fc3fffff : fc000000.usb usb@fc000000
> fc400000-fc407fff : usb@fc400000
>   fc400000-fc407fff : xhci-hcd.10.auto usb@fc400000
> fc40c100-fc7fffff : fc400000.usb usb@fc400000
> fc800000-fc83ffff : fc800000.usb usb@fc800000
> fc840000-fc87ffff : fc840000.usb usb@fc840000
> fc880000-fc8bffff : fc880000.usb usb@fc880000
> fc8c0000-fc8fffff : fc8c0000.usb usb@fc8c0000
> fc900000-fc900dff : fc900000.iommu
> fc910000-fc910dff : fc900000.iommu
> fd600000-fd6fffff : fd600000.sram sram@fd600000
> fd8a0000-fd8a00ff : fd8a0000.gpio gpio@fd8a0000
> fdb50000-fdb507ff : fdb50000.video-codec video-codec@fdb50000
> fdb50800-fdb5083f : fdb50800.iommu iommu@fdb50800
> fdb80000-fdb8017f : fdb80000.rga rga@fdb80000
> fdba0000-fdba07ff : fdba0000.video-codec video-codec@fdba0000
> fdba0800-fdba083f : fdba0800.iommu iommu@fdba0800
> fdba4800-fdba483f : fdba4800.iommu iommu@fdba4800
> fdba8800-fdba883f : fdba8800.iommu iommu@fdba8800
> fdbac800-fdbac83f : fdbac800.iommu iommu@fdbac800
> fdc70000-fdc707ff : fdc70000.video-codec video-codec@fdc70000
> fdd90000-fdd941ff : fdd90000.vop vop
> fdd95000-fdd95fff : fdd90000.vop gamma-lut
> fdd97e00-fdd97eff : fdd97e00.iommu iommu@fdd97e00
> fdd97f00-fdd97fff : fdd97e00.iommu iommu@fdd97e00
> fddf0000-fddf0fff : fddf0000.i2s i2s@fddf0000
> fddf4000-fddf4fff : fddf4000.i2s i2s@fddf4000
> fde80000-fde9ffff : fde80000.hdmi hdmi@fde80000
> fdea0000-fdebffff : fdea0000.hdmi hdmi@fdea0000
> fdee0000-fdee5fff : fdee0000.hdmi_receiver hdmi_receiver@fdee0000
> fe060000-fe06ffff : fe060000.dfi dfi@fe060000
> fe150000-fe15ffff : a40000000.pcie apb
> fe170000-fe17ffff : a40800000.pcie apb
> fe180000-fe18ffff : a40c00000.pcie apb
> fe1b0000-fe1bffff : fe1b0000.ethernet ethernet@fe1b0000
> fe210000-fe210fff : fe210000.sata sata@fe210000
> fe2c0000-fe2c3fff : fe2c0000.mmc mmc@fe2c0000
> fe2e0000-fe2effff : fe2e0000.mmc mmc@fe2e0000
> fe470000-fe470fff : fe470000.i2s i2s@fe470000
> fe600000-fe60ffff : GICD
> fe680000-fe77ffff : GICR
> fea10000-fea13fff : dma-controller@fea10000
>   fea10000-fea13fff : fea10000.dma-controller dma-controller@fea10000
> fea30000-fea33fff : dma-controller@fea30000
>   fea30000-fea33fff : fea30000.dma-controller dma-controller@fea30000
> feaa0000-feaa0fff : feaa0000.i2c i2c@feaa0000
> feaf0000-feaf00ff : feaf0000.watchdog watchdog@feaf0000
> feb20000-feb20fff : feb20000.spi spi@feb20000
> feb50000-feb500ff : serial
> fec00000-fec003ff : fec00000.tsadc tsadc@fec00000
> fec10000-fec1ffff : fec10000.adc adc@fec10000
> fec20000-fec200ff : fec20000.gpio gpio@fec20000
> fec30000-fec300ff : fec30000.gpio gpio@fec30000
> fec40000-fec400ff : fec40000.gpio gpio@fec40000
> fec50000-fec500ff : fec50000.gpio gpio@fec50000
> fec90000-fec90fff : fec90000.i2c i2c@fec90000
> fed10000-fed13fff : dma-controller@fed10000
>   fed10000-fed13fff : fed10000.dma-controller dma-controller@fed10000
> fed60000-fed61fff : fed60000.phy phy@fed60000
> fed70000-fed71fff : fed70000.phy phy@fed70000
> fed80000-fed8ffff : fed80000.phy phy@fed80000
> fed90000-fed9ffff : fed90000.phy phy@fed90000
> fee00000-fee000ff : fee00000.phy phy@fee00000
> fee10000-fee100ff : fee10000.phy phy@fee10000
> fee20000-fee200ff : fee20000.phy phy@fee20000
> fee80000-fee9ffff : fee80000.phy phy@fee80000
> ff001000-ff0effff : ff001000.sram sram@ff001000
> 100000000-3fbffffff : System RAM
>   3ec000000-3fbffffff : reserved
> 3fc500000-3ffefffff : System RAM
> 4f0000000-4ffffffff : System RAM
>   4fc611000-4fc6d0fff : reserved
>   4fc6d1000-4fded1fff : reserved
>   4fded2000-4fdf91fff : reserved
>   4fdf93000-4fdf96fff : reserved
>   4fdf97000-4fdfabfff : reserved
>   4fdfac000-4fe051fff : reserved
>   4fe052000-4ffffffff : reserved
> 900000000-93fffffff : pcie@fe150000
>   900000000-93fffffff : 0000:00:00.0
> 980000000-9bfffffff : pcie@fe170000
> 9c0000000-9ffffffff : pcie@fe180000
> a40000000-a403fffff : a40000000.pcie dbi
> a40800000-a40bfffff : a40800000.pcie dbi
> a40c00000-a40ffffff : a40c00000.pcie dbi
>=20
> Thank you,
> =09o.
>=20
> > --=20
> >  i.
>=20
--8323328-1179349992-1744624335=:7362--

