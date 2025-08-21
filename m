Return-Path: <linux-pci+bounces-34466-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE11DB2FE37
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 17:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DF05AC230C
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 15:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF30A26E175;
	Thu, 21 Aug 2025 15:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PTnf0H/V"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB6B26C391;
	Thu, 21 Aug 2025 15:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755789346; cv=none; b=Skw3ceR4F5ktNjJTaYFyqqI5haw5OT0F4XGRUbydLDglwWoB/21HACDxaNTZkuTxB5Opr7GvfRa+M29UvTNbcNDImIIpy++vU/SDZMy4ySuq6RaVwLg50waWOptpV8bAJBHPNqROSxCSEuhL2U/y8fafxWl1JURR0Zw9X3qKiiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755789346; c=relaxed/simple;
	bh=wYqiWLhph2bI9kfGV6H0/88YqF7XMMDDfjFYgRt69XE=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=tTfX0lO+kWZ1EkUCiYAP3wmGAcAy+2fwbdjkx8HfnMpNtBSpE23A5+qjPOviJo8NPX4gwpAA7dKXhc7p23pxaEXiRZIIMGPPhrqCENc8DrkwL36+1WZ4U6JBRPi3VuMjmaDyJg9MTkj6DJjdxvgxPAhPKUgThB96/u5nOWzJTU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PTnf0H/V; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755789345; x=1787325345;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=wYqiWLhph2bI9kfGV6H0/88YqF7XMMDDfjFYgRt69XE=;
  b=PTnf0H/VTO7yiO6CD9kIvDrXYPQdi/yc1P35aTDWYooyvSlb4F19Om9M
   DTOrSQ4N79ENF25c7exq5nmynk3mknQ+y3X9JZvhVYMifO2NfLxEfn/Kr
   pWn4H4Pi/Sr8WyPxMS48XrzldrT2DDOMfTzPGv35TjiqqHrNot0/o800x
   fSqaSBDfnhKY8lqKoxyZjQmksaJD6mPvwjj4yg9lGEq53YDkl56rKjHG2
   +uSNG0ZLYxajaa1dSFJXS6DqP2sl9gXoijoxNguSxmSMaK0A/peaMT9QA
   3cPy1pF6AjC5GNE5i+57E0WxEqsq+tZaMjzDw2w06YQFaKP25g+Pl9lnE
   Q==;
X-CSE-ConnectionGUID: AOSgR6E2RIKE0g4QXFH1nA==
X-CSE-MsgGUID: wpLYWqFdTd69vBULJG7JRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="83500229"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="83500229"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 08:15:44 -0700
X-CSE-ConnectionGUID: OJaWStnNSoCSVjC5Z2TfOA==
X-CSE-MsgGUID: xC/GsnXNQ0yLnWhpfJvYCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="173774844"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.192])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 08:15:39 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 21 Aug 2025 18:15:35 +0300 (EEST)
To: Bjorn Helgaas <helgaas@kernel.org>
cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    Tudor Ambarus <tudor.ambarus@linaro.org>, Rio <rio@r26.me>, 
    D Scott Phillips <scott@os.amperecomputing.com>, 
    LKML <linux-kernel@vger.kernel.org>, 
    =?ISO-8859-15?Q?Christian_K=F6nig?= <christian.koenig@amd.com>, 
    stable@vger.kernel.org
Subject: Re: [PATCH v2 1/3] PCI: Relaxed tail alignment should never increase
 min_align
In-Reply-To: <20250821151035.GA674429@bhelgaas>
Message-ID: <3ded51ff-6265-da0a-d8a1-ecf788e99d31@linux.intel.com>
References: <20250821151035.GA674429@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-976963371-1755789335=:933"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-976963371-1755789335=:933
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 21 Aug 2025, Bjorn Helgaas wrote:

> On Mon, Jun 30, 2025 at 05:26:39PM +0300, Ilpo J=C3=A4rvinen wrote:
> > When using relaxed tail alignment for the bridge window,
> > pbus_size_mem() also tries to minimize min_align, which can under
> > certain scenarios end up increasing min_align from that found by
> > calculate_mem_align().
> >=20
> > Ensure min_align is not increased by the relaxed tail alignment.
> >=20
> > Eventually, it would be better to add calculate_relaxed_head_align()
> > similar to calculate_mem_align() which finds out what alignment can be
> > used for the head without introducing any gaps into the bridge window
> > to give flexibility on head address too. But that looks relatively
> > complex algorithm so it requires much more testing than fixing the
> > immediate problem causing a regression.
> >=20
> > Fixes: 67f9085596ee ("PCI: Allow relaxed bridge window tail sizing for =
optional resources")
> > Reported-by: Rio <rio@r26.me>
>=20
> Was there a regression report URL we could include here?

There's the Lore thread only:

https://lore.kernel.org/all/o2bL8MtD_40-lf8GlslTw-AZpUPzm8nmfCnJKvS8RQ3NOzO=
W1uq1dVCEfRpUjJ2i7G2WjfQhk2IWZ7oGp-7G-jXN4qOdtnyOcjRR0PZWK5I=3D@r26.me/

(It's so far back that if there was something else, I've forgotten them=20
by now but looking at the exchanges in the thread, it doesn't look like=20
bugzilla entry or so made out of it.)

--=20
 i.

> > Tested-by: Rio <rio@r26.me>
> > Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> > Cc: <stable@vger.kernel.org>
> > ---
> >  drivers/pci/setup-bus.c | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> > index 07c3d021a47e..f90d49cd07da 100644
> > --- a/drivers/pci/setup-bus.c
> > +++ b/drivers/pci/setup-bus.c
> > @@ -1169,6 +1169,7 @@ static int pbus_size_mem(struct pci_bus *bus, uns=
igned long mask,
> >  =09resource_size_t children_add_size =3D 0;
> >  =09resource_size_t children_add_align =3D 0;
> >  =09resource_size_t add_align =3D 0;
> > +=09resource_size_t relaxed_align;
> > =20
> >  =09if (!b_res)
> >  =09=09return -ENOSPC;
> > @@ -1246,8 +1247,9 @@ static int pbus_size_mem(struct pci_bus *bus, uns=
igned long mask,
> >  =09if (bus->self && size0 &&
> >  =09    !pbus_upstream_space_available(bus, mask | IORESOURCE_PREFETCH,=
 type,
> >  =09=09=09=09=09   size0, min_align)) {
> > -=09=09min_align =3D 1ULL << (max_order + __ffs(SZ_1M));
> > -=09=09min_align =3D max(min_align, win_align);
> > +=09=09relaxed_align =3D 1ULL << (max_order + __ffs(SZ_1M));
> > +=09=09relaxed_align =3D max(relaxed_align, win_align);
> > +=09=09min_align =3D min(min_align, relaxed_align);
> >  =09=09size0 =3D calculate_memsize(size, min_size, 0, 0, resource_size(=
b_res), win_align);
> >  =09=09pci_info(bus->self, "bridge window %pR to %pR requires relaxed a=
lignment rules\n",
> >  =09=09=09 b_res, &bus->busn_res);
> > @@ -1261,8 +1263,9 @@ static int pbus_size_mem(struct pci_bus *bus, uns=
igned long mask,
> >  =09=09if (bus->self && size1 &&
> >  =09=09    !pbus_upstream_space_available(bus, mask | IORESOURCE_PREFET=
CH, type,
> >  =09=09=09=09=09=09   size1, add_align)) {
> > -=09=09=09min_align =3D 1ULL << (max_order + __ffs(SZ_1M));
> > -=09=09=09min_align =3D max(min_align, win_align);
> > +=09=09=09relaxed_align =3D 1ULL << (max_order + __ffs(SZ_1M));
> > +=09=09=09relaxed_align =3D max(min_align, win_align);
> > +=09=09=09min_align =3D min(min_align, relaxed_align);
> >  =09=09=09size1 =3D calculate_memsize(size, min_size, add_size, childre=
n_add_size,
> >  =09=09=09=09=09=09  resource_size(b_res), win_align);
> >  =09=09=09pci_info(bus->self,
> > --=20
> > 2.39.5
> >=20
>=20
--8323328-976963371-1755789335=:933--

