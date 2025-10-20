Return-Path: <linux-pci+bounces-38775-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A91BBF25CF
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 18:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 019A618A647E
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 16:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D24283682;
	Mon, 20 Oct 2025 16:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DpW983TR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C931A00CE;
	Mon, 20 Oct 2025 16:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760977220; cv=none; b=LMwYP5YLBalU+8+V3MTpG3srHctgfjXxJ/lBkfhPOWsExSWUCo+pghZApkoWPDqis+DnHdQ4346qp6JPpvLQwyaQklaoBYguu27hrZkoTIuDEGwtjTJn64OI+gG5btR5Cp+094YE7mupcbbF9+iY9gaEOac69nEMEgocZv/D8dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760977220; c=relaxed/simple;
	bh=KyW2o+Tj9sebaDNyh1EThKqKgscZxyrq2W+eHFrQOgk=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=uBkaWHTwIbRuLSymQK/n4Er21mwIsRlYLP02Qv8LXJoDG1OL2Hgu5ry8638FwCyr28X5uJRBcVO5dS+iPDS5Gcfy4NPL9uVNo6Kkfs8vcQAomZm6WMnGHPrD3n+mPOgjjhuCGRtFMgkqjs/8UaJpHJrqUVri08StufQDAa3p1h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DpW983TR; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760977219; x=1792513219;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=KyW2o+Tj9sebaDNyh1EThKqKgscZxyrq2W+eHFrQOgk=;
  b=DpW983TR6ueUVqwIFxSQqoCpPhLUDhmXCgn3XhgX5o3GlIp0IXD9egGH
   VvTEG1Ya42L1ho4+d6KlxDvGHvE8h2q7fCQtwvbTA3omyy97CLaEaPBCR
   zw4hWGmqnDzNleUgfl2JVtRRXRe4BUef5b69wepBTS5RtveDVFtEIwiuJ
   bd+GsP1ULuNIEIpolnkkmdUEvndpD9w4Npr3beNWvd1Zj4Jssyyfwgsxy
   4/gDe8L9aQ0gbHykXhBO1+7K0U14FKGKSpfeqwTJfKxwvRbLAMeEQGUlx
   OVi/Ilfpfx2Wt6Dhz50izYnJjrJNJ/0sAhhzFa6+EHULgrBtQcC0O9jkN
   Q==;
X-CSE-ConnectionGUID: 778CSw9zQkmuuofMCmTajQ==
X-CSE-MsgGUID: FAhrmyhmQ7eoUO2gWIpsbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63134988"
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; 
   d="scan'208";a="63134988"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 09:20:19 -0700
X-CSE-ConnectionGUID: Jjc3xpeZQduSfzcVUyMMzA==
X-CSE-MsgGUID: pJOdJr1JRNq9XsLDFww+Fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; 
   d="scan'208";a="213982188"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.76])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 09:20:14 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 20 Oct 2025 19:20:10 +0300 (EEST)
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
    Kai-Heng Feng <kaihengf@nvidia.com>, Rob Herring <robh@kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    Linux-Renesas <linux-renesas-soc@vger.kernel.org>, 
    Linux-Renesas <linux-renesas-soc@vger.kernel.or>
Subject: Re: [PATCH 0/3] PCI & resource: Make coalescing host bridge windows
 safer
In-Reply-To: <CAMuHMdVwAkC0XOU_SZ0HeH0+oT-j5SvKyRcFcJbbes624Yu9uQ@mail.gmail.com>
Message-ID: <89a20c14-dd0f-22ae-d998-da511a94664a@linux.intel.com>
References: <20251010144231.15773-1-ilpo.jarvinen@linux.intel.com> <CAMuHMdVwAkC0XOU_SZ0HeH0+oT-j5SvKyRcFcJbbes624Yu9uQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-499737811-1760977210=:976"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-499737811-1760977210=:976
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 20 Oct 2025, Geert Uytterhoeven wrote:
> On Fri, 10 Oct 2025 at 16:42, Ilpo J=C3=A4rvinen
> <ilpo.jarvinen@linux.intel.com> wrote:
> > Here's a series for Geert to test if this fixes the improper coalescing
> > of resources as was experienced with the pci_add_resource() change (I
> > know the breaking change was pulled before 6.18 main PR but I'd want to
> > retry it later once the known issues have been addressed). The expected
> > result is there'll be two adjacent host bridge resources in the
> > resource tree as the different name should disallow coalescing them
> > together, and therefore BAR0 has a window into which it belongs to.
> >
> > Generic info for the series:
> >
> > PCI host bridge windows were coalesced in place into one of the structs
> > on the resources list. The host bridge window coalescing code does not
> > know who holds references and still needs the struct resource it's
> > coalescing from/to so it is safer to perform coalescing into entirely
> > a new struct resource instead and leave the old resource addresses as
> > they were.
> >
> > The checks when coalescing is allowed are also made stricter so that
> > only resources that have identical the metadata can be coalesced.
> >
> > As a bonus, there's also a bit of framework to easily create kunit
> > tests for resource tree functions (beyond just resource_coalesce()).
> >
> > Ilpo J=C3=A4rvinen (3):
> >   PCI: Refactor host bridge window coalescing loop to use prev
> >   PCI: Do not coalesce host bridge resource structs in place
> >   resource, kunit: add test case for resource_coalesce()
>=20
> Thanks for your series!
>=20
> I have applied this on top of commit 06b77d5647a4d6a7 ("PCI:
> Mark resources IORESOURCE_UNSET when outside bridge windows"), and
> gave it a a try on Koelsch (R-Car M2-W).

So the pci_bus_add_resource() patch to rcar_pci_probe() was not included?
No coalescing would be attempted without that change.

With the pci_bus_add_resource() patch, the resource name is different, I=20
think, so even then it should abort coalescing the ranges with this=20
series.

> Impact on dmesg (for the first PCI/USB) instance:
>=20
>      pci-rcar-gen2 ee090000.pci: host bridge /soc/pci@ee090000 ranges:
>      pci-rcar-gen2 ee090000.pci:      MEM 0x00ee080000..0x00ee08ffff
> -> 0x00ee080000
>      pci-rcar-gen2 ee090000.pci: PCI: revision 11
>      pci-rcar-gen2 ee090000.pci: PCI host bridge to bus 0000:00
>      pci_bus 0000:00: root bus resource [bus 00]
>      pci_bus 0000:00: root bus resource [mem 0xee080000-0xee08ffff]
>      pci 0000:00:00.0: [1033:0000] type 00 class 0x060000 conventional
> PCI endpoint
>     -pci 0000:00:00.0: BAR 0 [mem 0xee090800-0xee090bff]: no initial
> claim (no window)
>      pci 0000:00:00.0: BAR 0 [mem size 0x00000400]
>     -pci 0000:00:00.0: BAR 1 [mem 0x40000000-0x7fffffff pref]: no
> initial claim (no window)
>      pci 0000:00:00.0: BAR 1 [mem size 0x40000000 pref]
>      pci 0000:00:01.0: [1033:0035] type 00 class 0x0c0310 conventional
> PCI endpoint
>     -pci 0000:00:01.0: BAR 0 [mem 0x00000000-0x00000fff]: no initial
> claim (no window)
>      pci 0000:00:01.0: BAR 0 [mem size 0x00001000]
>      pci 0000:00:01.0: supports D1 D2
>      pci 0000:00:01.0: PME# supported from D0 D1 D2 D3hot
>      pci 0000:00:02.0: [1033:00e0] type 00 class 0x0c0320 conventional
> PCI endpoint
>     -pci 0000:00:02.0: BAR 0 [mem 0x00000000-0x000000ff]: no initial
> claim (no window)
>      pci 0000:00:02.0: BAR 0 [mem size 0x00000100]
>      pci 0000:00:02.0: supports D1 D2
>      pci 0000:00:02.0: PME# supported from D0 D1 D2 D3hot
>      PCI: bus0: Fast back to back transfers disabled
>      pci 0000:00:01.0: BAR 0 [mem 0xee080000-0xee080fff]: assigned
>      pci 0000:00:02.0: BAR 0 [mem 0xee081000-0xee0810ff]: assigned
>      pci_bus 0000:00: resource 4 [mem 0xee080000-0xee08ffff]
>      pci 0000:00:01.0: enabling device (0140 -> 0142)
>      pci 0000:00:02.0: enabling device (0140 -> 0142)
>=20
> I.e. the "no initial claim (no window)" messages introduced by commit
> 06b77d5647a4d6a7 are no longer seen.

Is that perhaps again because of pci_dbg() vs pci_info()?

> The BARs still show "mem size <n>" instead of the "mem <start>-<end>"
> before commit 06b77d5647a4d6a7, though.

To me this looks like UNSET was still set for these resources. Missing the=
=20
pci_bus_add_resource() patch would explain that and if the pci_dbg()=20
wasn't printed, it would explain both symptoms.

Once these questions are resolved, I'll ask Rob what is the preferred=20
solution here, a) driver doing pci_bus_add_resource() or b) including it=20
into the DT ranges (if we could fix the ranges).

We likely need to go with a) to preserve backwards compatibility but I=20
also want to understand how those ranges are supposed to be used if we=20
wouldn't have historical baggage.


(I appreciate following through even if the original series is now=20
reverted!)

> This series has not impact on /proc/iomem, or on the output of
> "lspci -v" (commit 06b77d5647a4d6a7 also had no impact here).
> I.e. the part of /proc/iomem related to the first PCI/USB instance
> still looks like:
>=20
>     ee080000-ee08ffff : pci@ee090000
>       ee080000-ee080fff : 0000:00:01.0
>         ee080000-ee080fff : ohci_hcd
>       ee081000-ee0810ff : 0000:00:02.0
>         ee081000-ee0810ff : ehci_hcd
>     ee090000-ee090bff : ee090000.pci pci@ee090000
>
> I hope this matches your expectation.s
>=20
> Gr{oetje,eeting}s,
>=20
>                         Geert
>=20
>=20

--=20
 i.

--8323328-499737811-1760977210=:976--

