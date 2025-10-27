Return-Path: <linux-pci+bounces-39431-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D05B4C0E24E
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 14:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8895D3BABAB
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 13:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3062F7AD1;
	Mon, 27 Oct 2025 13:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UE5/EYbe"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DAA2F39C4;
	Mon, 27 Oct 2025 13:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761571788; cv=none; b=c5vS5EXoCYvWn46GXhdC3sw38JBb6HYuA9twD4/EMCvBg7mP11Jay87axIoOJS31pFPyL3LzI4yxQQOWkwCWM0KIUTnBINFR/sytxGhlnt2BR+rTJg5me7Cw3D3V7gwSpwNXqXf+j2crG7WkST8IbM/mYIfeVWX8nT6s/Eqab/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761571788; c=relaxed/simple;
	bh=0d6aCU3IN4hfNs4sKlqR551oawozInlye3Ny0w9aJag=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=i/8B1ki+XJg0JTuPPdAXizqH10jjl/3kkbqBWiscbOJ2nLmOxAdVZ6VjAMHinOKGz0cd5wHAcRaLW+w8ZyA6G/xFkYLSbGj/xLXQA1n12ZEg07PyKJbRckImBgN+faj0BghV+9CKx78Zo/D8eduIQgziarB7x81swsynQWSLHWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UE5/EYbe; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761571787; x=1793107787;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=0d6aCU3IN4hfNs4sKlqR551oawozInlye3Ny0w9aJag=;
  b=UE5/EYbe37ir+hFQcsSgeo4qbKutlppsNu+2m/fdkXToaT+FxkcC73/Z
   hzkvnXA1VUPQtBsUpqT9VY5cyF51Pz7IX9A5Vmvl5mJQTuxWqsNjMxaLo
   VjoGgE8Sel2ldGd8d1NFWlOPJ5bRzA7GnY/UlrqaQNDTPxVZsRvnXPDLT
   QFL1ovz8qE/8UJuXrPxwYZxrDZEyenQPVeFrGzPG92WX1Wc7svd5CuwAz
   L2aJpLLUWDfm6lYINthPBAXvZEpZ9d4bUeiTt70IUBK+lD/IhRmdFRKLm
   x2BTITe3jNyfh8wTvgIl8AWsJZIuz/8avMsIFo0jB330yCJ/tfRJjk6AI
   Q==;
X-CSE-ConnectionGUID: EgzwRHnlR9mu297cTbJE0w==
X-CSE-MsgGUID: I+ye5PJiTgOF1/mqXaRQxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74766699"
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="74766699"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 06:29:46 -0700
X-CSE-ConnectionGUID: w7tfZ0+ZSOixykI/VXQMJQ==
X-CSE-MsgGUID: MfHKbxnjTuqN1B8GJ07gkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="184269075"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.41])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 06:29:43 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 27 Oct 2025 15:29:39 +0200 (EET)
To: Klaus Kudielka <klaus.kudielka@gmail.com>
cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, regressions@lists.linux.dev
Subject: Re: WARNING at drivers/pci/setup-bus.c:2373, bisected to "PCI: Use
 pbus_select_window_for_type() during mem window sizing"
In-Reply-To: <af6f0f2e1dec9053c6984139b8582fc6ceab6813.camel@gmail.com>
Message-ID: <ba71af2d-c484-9de2-2a7d-b1ac254eeaea@linux.intel.com>
References: <20250829131113.36754-1-ilpo.jarvinen@linux.intel.com>    <20250829131113.36754-20-ilpo.jarvinen@linux.intel.com>   <51e8cf1c62b8318882257d6b5a9de7fdaaecc343.camel@gmail.com>  <990fe39da66ad23df4c85ef247b274a0fc6c2336.camel@gmail.com>
 <af6f0f2e1dec9053c6984139b8582fc6ceab6813.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-56115584-1761570020=:970"
Content-ID: <47fd933f-e509-f956-b926-1a3dc4fd6841@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-56115584-1761570020=:970
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <ae1466fc-fe50-8c70-d0c5-5e851b625862@linux.intel.com>

On Sat, 25 Oct 2025, Klaus Kudielka wrote:

> On Sat, 2025-10-25 at 12:11 +0200, Klaus Kudielka wrote:
> >=20
> > > [=A0=A0=A0 0.027107] pci 0000:00:03.0: bridge window [mem 0x00200000-=
0x003fffff] to [bus 02] add_size 200000 add_align 200000
> > > [=A0=A0=A0 0.027115] pci 0000:00:03.0: bridge window [mem 0x00200000-=
0x003fffff] to [bus 02] add_size 200000 add_align 200000
> >=20
> > So, this part of=A0 pbus_size_mem() now seems to be called *TWICE* for =
the same bridge window:
> >=20
> > =09=09add_to_list(realloc_head, bus->self, b_res, size1-size0, add_alig=
n);
> > =09=09pci_info(bus->self, "bridge window %pR to %pR add_size %llx add_a=
lign %llx\n",
> > =09=09=09=A0=A0 b_res, &bus->busn_res,
> > =09=09=09=A0=A0 (unsigned long long) (size1 - size0),
> > =09=09=09=A0=A0 (unsigned long long) add_align);
> >=20
> >=20
> >=20
> > WITHOUT the offending commit, I see only one line, and no WARNING.
> > > [=A0=A0=A0 0.027405] pci 0000:00:03.0: bridge window [mem 0x00200000-=
0x003fffff] to [bus 02] add_size 200000 add_align 200000
> >=20
> >=20
>=20
>=20
> After some more testing, I think I know what is going on.
>=20
> - My device seems to have only non-prefetchable IO resources.
> - In pci_bus_size_bridges(), pbus_size_mem() is called twice, once with I=
ORESOURCE_PREFETCH, once without.
> - This seems to be the intended behaviour (with or without the offending =
commit).
>=20
> - What DOES make the difference, is the use of pbus_select_window_for_typ=
e() inside pbus_size_mem().
> - On my device, that function returns the ***non-prefetchable*** resource=
, even if being asked for a prefetchable one.
> - End result: b_res is valid (and identical) in both calls to pbus_size_m=
em().
> - Honestly, that does not look right to me.
>=20
>=20
> Indeed, my device goes back to the original behaviour (without WARNING), =
if I go back to the original use of
> find_bus_resource_of_type():
>=20
>=20
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -1312,7 +1312,9 @@ static void pbus_size_mem(struct pci_bus *bus, unsi=
gned long type,
>         resource_size_t min_align, win_align, align, size, size0, size1 =
=3D 0;
>         resource_size_t aligns[28]; /* Alignments from 1MB to 128TB */
>         int order, max_order;
> -       struct resource *b_res =3D pbus_select_window_for_type(bus, type)=
;
> +       struct resource *b_res =3D find_bus_resource_of_type(bus,
> +                       IORESOURCE_MEM | IORESOURCE_PREFETCH | IORESOURCE=
_MEM_64,
> +                       type);
>         resource_size_t children_add_size =3D 0;
>         resource_size_t children_add_align =3D 0;
>         resource_size_t add_align =3D 0;
>=20
>=20
>=20
> Comments?

Hi Klaus,

I'm sorry this ended up falling through cracks until now (this is far from=
=20
the only regression I've on my table at the moment).

Big kudos for you from figuring out what went wrong! For a bridge which=20
doesn't have a prefetchable window, pbus_size_mem() should not be called fo=
r it.

I've sent a fix patch separately. Please test it.

--=20
 i.
--8323328-56115584-1761570020=:970--

