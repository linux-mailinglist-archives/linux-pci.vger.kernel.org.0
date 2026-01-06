Return-Path: <linux-pci+bounces-44105-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A3CBCF8746
	for <lists+linux-pci@lfdr.de>; Tue, 06 Jan 2026 14:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3E7D63054C13
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jan 2026 13:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6455324B1E;
	Tue,  6 Jan 2026 13:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ePep8Pxs"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C735F30B53D;
	Tue,  6 Jan 2026 13:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767705387; cv=none; b=NM7JNYcsHLhU3dhus0u6li1wt14bKZfpI+78TQvFnnEFC14ouS+ztmUODUg8v1/giVvhCbf8k39FdVWGPmttRzaLdqAeVyan9cx7t96bOG+7/9eVe5X5rzQNh+s2CQPDF1H8Txg7brIa8r3hJqNo0aPfh7DztJL9viCAlpz0Pus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767705387; c=relaxed/simple;
	bh=9MxuVCcj7YLjBQwvIW48dSzL8CNL+DLkDjYTYETRCQk=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=kHMI3eKA3Db2a+A023S5KYaR9Ud3i8rCYzfP7DU65ZKHEaMCLofdAnVAj5+nGhuE915EWKeG9FkaxVgqUnjAlkR2kHD0W/AxvaHFl2Op6Ybqo5U6Fi6IS5PONO+UgM8hNTZx45w+y7sWBT44pQfxq2LCxH1zEeP3lKJbeV2Oa50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ePep8Pxs; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767705383; x=1799241383;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=9MxuVCcj7YLjBQwvIW48dSzL8CNL+DLkDjYTYETRCQk=;
  b=ePep8PxsZUS4KcjUDyXZEmMjB7RjtLd+4ipYlxUEbsxPQqSTXRSvy9Tq
   ACGQqFgJG9R0CPW6sVwLe9sYAZbavv26Y35QZm8jea98LTXuh7k7TIse2
   jMFiPHCbPhsiK8iN0TTe+v1S2Bppc/ugEZLuQmGXmgMeL4I1h08OlMJRg
   YZABmQF39bUsSzY5dZpr6VWwb9LGvVivPgK9bV8g77JEz/0RBnug/Q37r
   LB6sWEMK8aQvmpSZNOkMNbhviKVOGTfxqCsCErYvPtfxD6MpDmZUO5O0J
   YAktB4bQCHoxJmyAQSlD8ylZ0wcKIs5zIv48JzRDr/8o9Y/lUUfU0Lus8
   Q==;
X-CSE-ConnectionGUID: zWB0l/YRQ9eZcUgZbSRE1g==
X-CSE-MsgGUID: fj1Pw0HJS22zhRbiY3C0Ow==
X-IronPort-AV: E=McAfee;i="6800,10657,11663"; a="69142268"
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; 
   d="scan'208";a="69142268"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2026 05:16:22 -0800
X-CSE-ConnectionGUID: 21qYsJG7TOiPuaEzvFRk0A==
X-CSE-MsgGUID: dPudM4RlQXirZE88u7g92g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; 
   d="scan'208";a="207207097"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.6])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2026 05:16:19 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 6 Jan 2026 15:16:15 +0200 (EET)
To: Linux regressions mailing list <regressions@lists.linux.dev>
cc: Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org, 
    "David S. Miller" <davem@davemloft.net>, 
    Andreas Larsson <andreas@gaisler.com>, Bjorn Helgaas <bhelgaas@google.com>, 
    sparclinux@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    Nathaniel Roach <nroach44@gmail.com>
Subject: Re: [PATCH RESEND 1/1] SPARC/PCI: Correct 64-bit non-pref -> pref
 BAR resources
In-Reply-To: <6d788abe-3176-426a-a640-e30c03d25972@leemhuis.info>
Message-ID: <7d1d0133-da17-9ba6-e34f-f09b85393e92@linux.intel.com>
References: <20251124170411.3709-1-ilpo.jarvinen@linux.intel.com> <6d788abe-3176-426a-a640-e30c03d25972@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-395248168-1767705304=:1051"
Content-ID: <e46bda39-d881-0955-9f0a-887921232004@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-395248168-1767705304=:1051
Content-Type: text/plain; CHARSET=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <72109ff8-49de-8a0a-26b2-2d97b798f59b@linux.intel.com>

On Tue, 6 Jan 2026, Linux regression tracking (Thorsten Leemhuis) wrote:

> [top-posting to facilitate processing]
>=20
> The issue fixed by below patch is still on my list of tracked
> regression, which got me wondering what's up here. Did it fall through
> the cracks? Is there some good reason why this approach was dropped? Or
> Was the regression maybe fixed already and I just missed it?

Hi Thorsten,

There isn't other solution to this AFAIK so you've not missed anything.

I'm used to PCI related changes often taking long time to handle so I'm=20
just patiently waiting. :-)

--
 i.

> Ciao, Thorsten
>=20
> On 11/24/25 18:04, Ilpo J=C3=A4rvinen wrote:
> > SPARC T5-2 dts describes some PCI BARs as 64-bit resources without
> > pref(etchable) bit (0x83... vs 0xc3... in assigned-addresses) for
> > address ranges above the 4G threshold. Such resources cannot be placed
> > into a non-prefetchable PCI bridge window that is capable only to
> > 32-bit addressing. As such, it looks the platform is improperly
> > describe by dts.
> >=20
> > Kernel detect this problem (see the IORESOURCE_PREFETCH check in
> > pci_find_parent_resource()) and fails to assign these BAR resources to
> > the resource tree due to lack of a compatible bridge window.
> >=20
> > Prior to the commit 754babaaf333 ("sparc/PCI: Remove
> > pcibios_enable_device() as they do nothing extra") SPARC arch code did
> > not test whether device resources were successfully in the resource
> > tree when enabling a device, effectively hiding the problem. After
> > removing the arch specific enable code, PCI core's
> > pci_enable_resources() refuses to enable the device when it finds not
> > all mem resources are assigned, and therefore mpt3sas can't be enabled:
> >=20
> > pci 0001:04:00.0: reg 0x14: [mem 0x801110000000-0x80111000ffff 64bit]
> > pci 0001:04:00.0: reg 0x1c: [mem 0x801110040000-0x80111007ffff 64bit]
> > pci 0001:04:00.0: BAR 1 [mem 0x801110000000-0x80111000ffff 64bit]: can'=
t claim; no compatible bridge window
> > pci 0001:04:00.0: BAR 3 [mem 0x801110040000-0x80111007ffff 64bit]: can'=
t claim; no compatible bridge window
> > mpt3sas 0001:04:00.0: BAR 1 [mem size 0x00010000 64bit]: not assigned; =
can't enable device
> >=20
> > For clarity, this filtered log only shows failures for one mpt3sas
> > device but other devices fail similarly. In the reported case, the end
> > result with all the failures is an unbootable system.
> >=20
> > Things appeared to "work" before the commit 754babaaf333 ("sparc/PCI:
> > Remove pcibios_enable_device() as they do nothing extra") because the
> > resource tree is agnostic to whether PCI BAR resources are properly in
> > the tree or not. So as long as there was a parent resource (e.g. a root
> > bus resource) that contains the address range, the resource tree code
> > just places resource request underneath it without any consideration to
> > the intermediate BAR resource. While it worked, it's incorrect setup
> > still.
> >=20
> > Add of fixup to set IORESOURCE_PREFETCH flag for a 64-bit PCI resource
> > that has the end address above 4G requiring placement into the
> > prefetchable window. Also log the issue.
> >=20
> > Fixes: 754babaaf333 ("sparc/PCI: Remove pcibios_enable_device() as they=
 do nothing extra")
> > Reported-by: Nathaniel Roach <nroach44@gmail.com>
> > Tested-by: Nathaniel Roach <nroach44@gmail.com>
> > Closes: https://github.com/sparclinux/issues/issues/22
> > Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> >=20
> > Resending with linux-pci@ ML.
> >=20
> > Any comments on the approach are welcome. E.g., is the fixup done at a
> > correct level? Should it be targeted specifically to the known failures
> > (how?) to avoid hiding more platform description problems?
> >=20
> > It seems VF BARs still have 64-bit non-pref despite this change, AFAICT=
,
> > those are read directly from the device's config space so would require
> > ordinary quirks. None of them result in device enable failing though so=
 the
> > issue is orthogonal to the one being fixed here.
> >=20
> > If suggesting a different approach, please do realize my knowledge
> > about OF code is generally very limited (and I'm not sure how directly
> > the fixup code in other archs, mainly ppc, can be used as an example
> > how to do fixups with sparc).
> > ---
> >  arch/sparc/kernel/pci.c | 23 +++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> >=20
> > diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
> > index a9448088e762..b290107170e9 100644
> > --- a/arch/sparc/kernel/pci.c
> > +++ b/arch/sparc/kernel/pci.c
> > @@ -181,6 +181,28 @@ static int __init ofpci_debug(char *str)
> > =20
> >  __setup("ofpci_debug=3D", ofpci_debug);
> > =20
> > +static void of_fixup_pci_pref(struct pci_dev *dev, int index,
> > +=09=09=09      struct resource *res)
> > +{
> > +=09struct pci_bus_region region;
> > +
> > +=09if (!(res->flags & IORESOURCE_MEM_64))
> > +=09=09return;
> > +
> > +=09if (!resource_size(res))
> > +=09=09return;
> > +
> > +=09pcibios_resource_to_bus(dev->bus, &region, res);
> > +=09if (region.end <=3D ~((u32)0))
> > +=09=09return;
> > +
> > +=09if (!(res->flags & IORESOURCE_PREFETCH)) {
> > +=09=09res->flags |=3D IORESOURCE_PREFETCH;
> > +=09=09pci_info(dev, "reg 0x%x: fixup: pref added to 64-bit resource\n"=
,
> > +=09=09=09 index);
> > +=09}
> > +}
> > +
> >  static unsigned long pci_parse_of_flags(u32 addr0)
> >  {
> >  =09unsigned long flags =3D 0;
> > @@ -244,6 +266,7 @@ static void pci_parse_of_addrs(struct platform_devi=
ce *op,
> >  =09=09res->end =3D op_res->end;
> >  =09=09res->flags =3D flags;
> >  =09=09res->name =3D pci_name(dev);
> > +=09=09of_fixup_pci_pref(dev, i, res);
> > =20
> >  =09=09pci_info(dev, "reg 0x%x: %pR\n", i, res);
> >  =09}
> >=20
> > base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
>=20
--8323328-395248168-1767705304=:1051--

