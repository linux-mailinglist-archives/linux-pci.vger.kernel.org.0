Return-Path: <linux-pci+bounces-34469-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A246CB2FE66
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 17:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99EACAC279F
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 15:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4146E2D4803;
	Thu, 21 Aug 2025 15:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JlHq1wRh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2319C29BD81;
	Thu, 21 Aug 2025 15:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755789695; cv=none; b=MPzPP5dz30Ld2NQB2Fjk5Wa1PVU1g5fqXpkOi40OaYiD9UUkI2eh2lK6vNFlYlv7f5ROo7I4/cYggoGTzXyp4wksjJkyPWuqap0rWHQFG6VMPVst5c0lTcj7aOO4F/Exlcw0reU9CrstfxRV7qk+wU7Mb3P3ZU/41oXAFph+v7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755789695; c=relaxed/simple;
	bh=KRJpPaNYZhuGdhMZHfEbshMmS3KzIhWRjBm1+wRJIDQ=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=myYyTsKLurjSwpLVxm7SlV4bEQQtEkC2g/sxB5OEU9ndcrckaNM/wnpBTLx+tPrHjThSIFgG1SdTGbEyg0xaYap4exLjtPFIojhSpIo3HfzfqTRUR+XlAWnXIgUtQMTFpKrP5ReP9sFtNJZRHbKwAPtAKn7LA6acReqdmScyKYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JlHq1wRh; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755789690; x=1787325690;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=KRJpPaNYZhuGdhMZHfEbshMmS3KzIhWRjBm1+wRJIDQ=;
  b=JlHq1wRh7xS1Ex5rt8l0zI17FNwStLoCca1qHd+nQKmq1wG1F8GQ+CNK
   YcmiQ16Eweuyl6xIQz9goQTDNJWJX7CLfl8ZOD9cGMvnEmPNwqwYc/ac7
   idWOeRYSrIq796nHP3sv93w91EFWtd8bM7j2A9VlSe0VARWFC9NVsDmBd
   vwfdXKGGXwPNEqrfPJkNJQ6ODp/HF4OpM8vwnI/DIjLV6TkTHfojIsWlH
   879jcH4oXYcVG6fmFg+39BqdmL2MI37Dd6k0b0qUzoKtmQN/owCfPp4Ro
   nc+xH09bd5HQ81bcUfnGEJ2VnEKzKCJE4IHdg1A7Z2HCI2oAyQ80oMpuq
   Q==;
X-CSE-ConnectionGUID: N20LMCStRmC/lDxBe4dG6w==
X-CSE-MsgGUID: HoG4C70wSAag/++gwLWPsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="61894117"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="61894117"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 08:21:29 -0700
X-CSE-ConnectionGUID: G9CIAg6ySKqgmvSiYsmibA==
X-CSE-MsgGUID: JclRp2AdS2WCMxuKEWk/JA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="168056557"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.192])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 08:21:25 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 21 Aug 2025 18:21:22 +0300 (EEST)
To: Bjorn Helgaas <helgaas@kernel.org>
cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    Tudor Ambarus <tudor.ambarus@linaro.org>, Rio <rio@r26.me>, 
    D Scott Phillips <scott@os.amperecomputing.com>, 
    LKML <linux-kernel@vger.kernel.org>, 
    =?ISO-8859-15?Q?Christian_K=F6nig?= <christian.koenig@amd.com>, 
    stable@vger.kernel.org
Subject: Re: [PATCH v2 2/3] PCI: Fix pdev_resources_assignable() disparity
In-Reply-To: <20250821151132.GA674480@bhelgaas>
Message-ID: <b873e7dc-8cbe-3370-4b47-8c1cb2e6da6e@linux.intel.com>
References: <20250821151132.GA674480@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1567600272-1755789682=:933"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1567600272-1755789682=:933
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 21 Aug 2025, Bjorn Helgaas wrote:

> On Mon, Jun 30, 2025 at 05:26:40PM +0300, Ilpo J=C3=A4rvinen wrote:
> > pdev_sort_resources() uses pdev_resources_assignable() helper to decide
> > if device's resources cannot be assigned. pbus_size_mem(), on the other
> > hand, does not do the same check. This could lead into a situation
> > where a resource ends up on realloc_head list but is not on the head
> > list, which is turn prevents emptying the resource from the
> > realloc_head list in __assign_resources_sorted().
> >=20
> > A non-empty realloc_head is unacceptable because it triggers an
> > internal sanity check as show in this log with a device that has class
> > 0 (PCI_CLASS_NOT_DEFINED):
>=20
> Is the class relevant here?

It actually is, because pdev_resources_assignable() checks for it. In case=
=20
of this particular device there was 0 there causing leading eventually to=
=20
this internal sanity check problem.

> > pci 0001:01:00.0: [144d:a5a5] type 00 class 0x000000 PCIe Endpoint
> > pci 0001:01:00.0: BAR 0 [mem 0x00000000-0x000fffff 64bit]
> > pci 0001:01:00.0: ROM [mem 0x00000000-0x0000ffff pref]
> > pci 0001:01:00.0: enabling Extended Tags
> > pci 0001:01:00.0: PME# supported from D0 D3hot D3cold
> > pci 0001:01:00.0: 15.752 Gb/s available PCIe bandwidth, limited by 8.0 =
GT/s PCIe x2 link at 0001:00:00.0 (capable of 31.506 Gb/s with 16.0 GT/s PC=
Ie x2 link)
> > pcieport 0001:00:00.0: bridge window [mem 0x00100000-0x001fffff] to [bu=
s 01-ff] add_size 100000 add_align 100000
> > pcieport 0001:00:00.0: bridge window [mem 0x40000000-0x401fffff]: assig=
ned
> > ------------[ cut here ]------------
> > kernel BUG at drivers/pci/setup-bus.c:2532!
> > Internal error: Oops - BUG: 00000000f2000800 [#1]  SMP
> > ...
> > Call trace:
> >  pci_assign_unassigned_bus_resources+0x110/0x114 (P)
> >  pci_rescan_bus+0x28/0x48
> >=20
> > Use pdev_resources_assignable() also within pbus_size_mem() to skip
> > processing of non-assignable resources which removes the disparity in
> > between what resources pdev_sort_resources() and pbus_size_mem()
> > consider. As non-assignable resources are no longer processed, they are
> > not added to the realloc_head list, thus the sanity check no longer
> > triggers.
> >=20
> > This disparity problem is very old but only now became apparent after
> > the commit 2499f5348431 ("PCI: Rework optional resource handling") that
> > made the ROM resources optional when calculating bridge window sizes
> > which required adding the resource to the realloc_head list.
> > Previously, bridge windows were just sized larger than necessary.
> >=20
> > Fixes: 2499f5348431 ("PCI: Rework optional resource handling")
> > Reported-by: Tudor Ambarus <tudor.ambarus@linaro.org>
>=20
> Any URL we can include here for the report?

This was discussed in the thread of the original patch/series:

Link: https://lore.kernel.org/all/5f103643-5e1c-43c6-b8fe-9617d3b5447c@lina=
ro.org/

> > Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> > Cc: <stable@vger.kernel.org>
> > ---
> >  drivers/pci/setup-bus.c | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> > index f90d49cd07da..24863d8d0053 100644
> > --- a/drivers/pci/setup-bus.c
> > +++ b/drivers/pci/setup-bus.c
> > @@ -1191,6 +1191,7 @@ static int pbus_size_mem(struct pci_bus *bus, uns=
igned long mask,
> >  =09=09=09resource_size_t r_size;
> > =20
> >  =09=09=09if (r->parent || (r->flags & IORESOURCE_PCI_FIXED) ||
> > +=09=09=09    !pdev_resources_assignable(dev) ||
> >  =09=09=09    ((r->flags & mask) !=3D type &&
> >  =09=09=09     (r->flags & mask) !=3D type2 &&
> >  =09=09=09     (r->flags & mask) !=3D type3))
> > --=20
> > 2.39.5
> >=20
>=20

--=20
 i.

--8323328-1567600272-1755789682=:933--

