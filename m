Return-Path: <linux-pci+bounces-38923-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E64BF7988
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 18:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C70F718A214F
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 16:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE7F3446BB;
	Tue, 21 Oct 2025 16:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QXMXkh7N"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFE215A86D;
	Tue, 21 Oct 2025 16:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761062951; cv=none; b=efBpVz7VfS6Fcg14iV921JhWPfGvgbvrrA1F3b60yPXDVzA53D+PS4HrwPqsFr0yhf6HST0JKCjHSJcwGx2vajQDFa3E8DfuRj1iLX8yYihr5WrX4O8PmZa5Yf05PURl+IPR/mb1N6H7Zo41x3SQNzcVrNoIM/LfKxs/hQeCrjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761062951; c=relaxed/simple;
	bh=lVqQrwLR73VLxhzhfYZr/XwLwv9Q8Qc3d8tpW+zVY50=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=PMsxPHoNztvn1mbok7g8sWHqBOZBQ7QobRPQ+pq9aF5lPvUmvOGtGeDPY7FIoGC9Gu3Fd2uNS+GhNSij2e4PoQgLTuJP42zlxw3Vz5Kel0kNMGdm0sDSgeEDfILvgs7t3WpSj28K/Kobo7aaJPoVP2bamedW7rCcmdSh+JQSkMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QXMXkh7N; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761062949; x=1792598949;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=lVqQrwLR73VLxhzhfYZr/XwLwv9Q8Qc3d8tpW+zVY50=;
  b=QXMXkh7N3nl85fUIlGOuRnJ2Y9zENIfuFsOjYG/ud1yFyx3KQluO2Bim
   Fgcu+y+hmD9Y3IFTVZdzzrzXF2ieFRcnP3BMMBw2YOSH6d6e8oWrRC9fH
   9rxLKQrNJHo4zHcgnVwFrI2JMFGY6EGUBvTjF8Zus96c5LGqjwtUPljeV
   60+IW17EieR37pgqF7bDmS9lwUzesltyKpta4puzkF5TY4WZV9Iy/fMCW
   sVP7j1B+pfGlAh062IkXtuhq3ubRZ4WbzTzV3FFfVamfAmWqpvbAqfBCe
   pN1Vsle1aN/Vklr/h8zg0IsaT6pHQR8NvJ03H8IFv7D7DIzYbwNBhFmja
   Q==;
X-CSE-ConnectionGUID: lnGQVeddQXq5sjvMlfGbEA==
X-CSE-MsgGUID: aGoLW4QFQMqm4k8XVBsowQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="80632879"
X-IronPort-AV: E=Sophos;i="6.19,245,1754982000"; 
   d="scan'208";a="80632879"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 09:09:08 -0700
X-CSE-ConnectionGUID: pZ1Di52HTfKXEn/kKrcMtQ==
X-CSE-MsgGUID: 7xPC94pVSTu43fM4cKQEOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,245,1754982000"; 
   d="scan'208";a="187665402"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.189])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 09:09:04 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 21 Oct 2025 19:09:00 +0300 (EEST)
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-pci@vger.kernel.org, 
    Bjorn Helgaas <bhelgaas@google.com>, Kai-Heng Feng <kaihengf@nvidia.com>, 
    Rob Herring <robh@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH 0/3] PCI & resource: Make coalescing host bridge windows
 safer
In-Reply-To: <aPerdPErjXANiBOl@smile.fi.intel.com>
Message-ID: <6abf371f-b5b0-bdb7-56cf-c012e20ffc73@linux.intel.com>
References: <20251010144231.15773-1-ilpo.jarvinen@linux.intel.com> <CAMuHMdVwAkC0XOU_SZ0HeH0+oT-j5SvKyRcFcJbbes624Yu9uQ@mail.gmail.com> <89a20c14-dd0f-22ae-d998-da511a94664a@linux.intel.com> <CAMuHMdUbseFEY8AGOxm2T8W-64qT9OSvfmvu+hyTJUT+WE2cVw@mail.gmail.com>
 <20844374-d3df-cc39-a265-44a3008a3bcb@linux.intel.com> <aPerdPErjXANiBOl@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-497485051-1761062940=:1018"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-497485051-1761062940=:1018
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 21 Oct 2025, Andy Shevchenko wrote:

> On Tue, Oct 21, 2025 at 02:54:03PM +0300, Ilpo J=E4rvinen wrote:
> > On Tue, 21 Oct 2025, Geert Uytterhoeven wrote:
>=20
> ...
>=20
> > I'm sorry, it's indeed a bit confusing as some of these patches never=
=20
> > have been in Linus' tree.
> >=20
> > So I'm interested on what's the result with these changes/series togeth=
er:
> >=20
> > [PATCH 1/2] PCI: Setup bridge resources earlier=20
> > [PATCH 2/2] PCI: Resources outside their window must set IORESOURCE_UNS=
ET=20
> > [PATCH 1/1] PCI: rcar-gen2: Add BAR0 into host bridge resources
> > [PATCH 1/3] PCI: Refactor host bridge window coalescing loop to use pre=
v=20
> > [PATCH 2/3] PCI: Do not coalesce host bridge resource structs in place
> > [PATCH 3/3] resource, kunit: add test case for resource_coalesce()
> >=20
> > You might also want to change that pci_dbg() in the IORESOURCE_UNSET pa=
tch=20
> > to pci_info() (as otherwise dyndbg is necessary to make it visible).
> >=20
> > Lore links to these series/patches:
> >=20
> > https://lore.kernel.org/linux-pci/20250924134228.1663-1-ilpo.jarvinen@l=
inux.intel.com/
> > https://lore.kernel.org/linux-pci/7640a03e-dfea-db9c-80f5-d80fa2c505b7@=
linux.intel.com/
> > https://lore.kernel.org/linux-pci/20251010144231.15773-1-ilpo.jarvinen@=
linux.intel.com/
> >=20
> > The expected result is that those usb resources are properly parented a=
nd=20
> > the ee080000-ee08ffff and ee090000-ee090bff are not coalesced together =
(as=20
> > that would destroy information). So something along the lines of:
> >=20
> >     ee080000-ee08ffff : pci@ee090000
>=20
> For my pedantic eye, the naming is a bit confusing here. Is this a mistak=
e in
> the code or in the example?
>=20
> >       ee080000-ee080fff : 0000:00:01.0
> >         ee080000-ee080fff : ohci_hcd
> >       ee081000-ee0810ff : 0000:00:02.0
> >         ee081000-ee0810ff : ehci_hcd
> >     ee090000-ee090bff : ee090000.pci pci@ee090000

I tried to copy them from here:

https://lore.kernel.org/linux-pci/CAMuHMdUbaQDXsowZETimLJ-=3DgLCofeP+LnJp_t=
xetuBQ0hmcPQ@mail.gmail.com/

So my answer is, from code.

I'm not trying to change the names here, they are what they are.

Why things work that way in DT platform (ee08 vs @ee09), don't ask me as I=
=20
unfortunately don't know the answers.

--=20
 i.

--8323328-497485051-1761062940=:1018--

