Return-Path: <linux-pci+bounces-38789-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5837EBF2E46
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 20:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D1A4334E551
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 18:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12FA332EB6;
	Mon, 20 Oct 2025 18:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ARnEci84"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C537E29A326;
	Mon, 20 Oct 2025 18:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760984119; cv=none; b=o9dcPPQ37A3QhuCAqswq7uur1yKleiWXi708gcQ223xkC0ru2ZLgDrSGDW8WjmBGvDr1saW1zQh2Zpf7pLyLYe7uc4Cov1+pS+kwAjqircD21NzlRBSB6UBYyqzPdJUpQrddZsZYMG9SccnLRqxvqeosW5oD3d4vzLYuu0H9q+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760984119; c=relaxed/simple;
	bh=E/fgf1dqbLBph0Xv5986+OlBJAI2J+9JbYK1ixdN8cQ=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=rS+Rb4IHp0Nl4HwRoVD4JYSDgaoPYuMZz7B/127iZkdb9qfOYoZ55MAa1/OZkBidwDiNBGaBEDYhAtwytpe6PKoY1q3LKAP8gIvJYcS1WGn5jYPH3UZlJU1+RQIMnpvgLM4azOgulE96wKJ05KDy3fvwvwTJsEtKa22Jzg0w6Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ARnEci84; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760984117; x=1792520117;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=E/fgf1dqbLBph0Xv5986+OlBJAI2J+9JbYK1ixdN8cQ=;
  b=ARnEci8495dKQBBHNiEv7ypZkwN+FTkQc3CAdqHPRA2aRjHUsAfH/gbA
   DMo7uiiFHIeookS2Rhdcd/FfkxG3grEO0+JVscYsnUIwJHDS6q5sdP5eZ
   B0FXo0pSYUDM5QGEbq0UdzvRH9YbfeKLliG8KkN1f3Lvudyx24teTqPJ3
   SJ4FMUBUwwVlwVW/CFg02WDBt/uvf69KyZ3+aoM/67NmUGneCiHZmQGmf
   ZsY3AmPT8DiuBV4ZQs7d8/UtnDJ2XZAWiGD9HNPxaAfMCX2Rmy5A9f6KR
   oC/FJUX/1NZ/MgoGbyFg42W4Czge5mVu0ivzGBi9cee1BdPLJ+rR0vWXr
   A==;
X-CSE-ConnectionGUID: BuFE9txxT/ytIg6iZtkRTg==
X-CSE-MsgGUID: PScta0pRRIOJ8uBOXvEpOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63145221"
X-IronPort-AV: E=Sophos;i="6.19,243,1754982000"; 
   d="scan'208";a="63145221"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 11:15:16 -0700
X-CSE-ConnectionGUID: /D3SR9BxSNeCqSUBQuyNQw==
X-CSE-MsgGUID: noz/WAhiQGerA9msjaudTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,243,1754982000"; 
   d="scan'208";a="214007076"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.76])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 11:15:12 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 20 Oct 2025 21:15:08 +0300 (EEST)
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
    Geert Uytterhoeven <geert@linux-m68k.org>, 
    Kai-Heng Feng <kaihengf@nvidia.com>, Rob Herring <robh@kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH 2/3] PCI: Do not coalesce host bridge resource structs
 in place
In-Reply-To: <aPZ09UZMfKhYSUZE@smile.fi.intel.com>
Message-ID: <9d56e776-731a-7e25-60f0-44485cfbf12c@linux.intel.com>
References: <20251010144231.15773-1-ilpo.jarvinen@linux.intel.com> <20251010144231.15773-3-ilpo.jarvinen@linux.intel.com> <aO-vtdECWNpYpo6f@smile.fi.intel.com> <8401388b-2957-0853-d80b-4479e02c47f0@linux.intel.com> <aPZ09UZMfKhYSUZE@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-33266822-1760982831=:976"
Content-ID: <cbde40da-41dd-3028-53a3-42d1c9a3c10d@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-33266822-1760982831=:976
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <eb1e09dc-4afa-d9d0-bacc-45f736382b02@linux.intel.com>

On Mon, 20 Oct 2025, Andy Shevchenko wrote:

> On Mon, Oct 20, 2025 at 08:21:50PM +0300, Ilpo J=E4rvinen wrote:
> > On Wed, 15 Oct 2025, Andy Shevchenko wrote:
> > > On Fri, Oct 10, 2025 at 05:42:30PM +0300, Ilpo J=E4rvinen wrote:
>=20
> ...
>=20
> > > > +/**
> > > > + * resource_mergeable - Test if resources are contiguous and can b=
e merged
> > > > + * @r1: first resource
> > > > + * @r2: second resource
> > > > + *
> > > > + * Tests @r1 is followed by @r2 contiguously and share the metadat=
a.
> > >=20
> > > This needs an additional explanation about name equivalence that's no=
t only by
> > > pointers, but by a content.
> >=20
> > Okay. The point was to check names are the same, the pointer check was=
=20
> > just an optimization as these resources are expected to carry the same=
=20
> > name even on the pointer level.
> >=20
> > > > + * Return: %true if resources are mergeable non-destructively.
> > > > + */
> > > > +static bool resource_mergeable(struct resource *r1, struct resourc=
e *r2)
> > > > +{
> > > > +=09if ((r1->flags !=3D r2->flags) ||
> > > > +=09    (r1->desc !=3D r2->desc) ||
> > > > +=09    (r1->parent !=3D r2->parent) ||
> > > > +=09    (r1->end + 1 !=3D r2->start))
> > > > +=09=09return false;
> > >=20
> > > > +=09if (r1->name =3D=3D r2->name)
> > > > +=09=09return true;
> > > > +
> > > > +=09if (r1->name && r2->name && !strcmp(r1->name, r2->name))
> > > > +=09=09return true;
> > > > +
> > > > +=09return false;
> > >=20
> > > Hmm... Can we keep the logic more straight as in returning false case=
s as soon
> > > as possible?
> > >=20
> > > I think of something like this:
> > >=20
> > > =09if (r1->name && r2->name)
> > > =09=09return strcmp(r1->name, r2->name) =3D=3D 0;
> > >=20
> > > =09return r1->name =3D=3D r2->name;
> >=20
> > But the point the order above was to avoid strcmp() when the pointer=20
> > itself is same which I think is quite common case. I don't think strcmp=
()=20
> > itself checks whether the pointer is the same.
>=20
> On the second thought I think comparing by the content is quite a behavio=
ural
> change here.

Compared to what?

This code was previously only used for merging contiguous "System RAM"=20
resources (AFAICT, I don't have way to check what the names in all those
resources truly were but in any case, the check was even stricter earlier,=
=20
comparing pointer equality only so definitely the names were not different=
=20
before this).

> Perhaps we may start without doing that first? Theoretically it
> might be the case when the content of names is different, but resources a=
re
> the same.

Resources are NOT same, they're two contiguous memory regions and may=20
originate from different source, and thus have different names.

Not caring about the names will lose one of them from /proc/iomem.

> The case when name is the same (by content, but pointers) with the
> idea of having different resources sounds to me quite an awkward case. TL=
;
> DR: What are the cases that we have in practice now?

In the original thread [1], PCI side resource coalescing did break the=20
resources by merging without caring what the resource internals were. That=
=20
problem was found after trying to fix another problem, thus it might not=20
happen in practice except after fixing the other problem with root bus=20
resources.

In the common case when merging PCI root bus resources, the resources=20
typically have the same name - this happens all the time (e.g. io port=20
ranges are split to many small ranges which form a contiguous region=20
when coalesced). But that's not always the case, why do you think these=20
two names should be merged losing some information:

     ee080000-ee08ffff : pci@ee090000
       ...
     ee090000-ee090bff : ee090000.pci pci@ee090000

?

(Also, the careless change in the underlying resource by the code this=20
series tries to fix would have likely broken also devres release of the=20
mangled resource, which admittedly, is not related to name at all).

[1] https://lore.kernel.org/linux-pci/CAMuHMdVgCHU80mRm1Vwo6GFgNAtQcf50yHBz=
_oAk4TrtjcMpYg@mail.gmail.com/


--=20
 i.
--8323328-33266822-1760982831=:976--

