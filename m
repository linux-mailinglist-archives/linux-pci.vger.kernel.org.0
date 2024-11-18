Return-Path: <linux-pci+bounces-17047-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 763439D11A4
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2024 14:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1FD51F234D1
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2024 13:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961FA19994F;
	Mon, 18 Nov 2024 13:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q7ANUSdy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF7BBA4A;
	Mon, 18 Nov 2024 13:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731935891; cv=none; b=Ycm+XgwqmFWS1vquTxVXuGPHntPYXsaubwARz0RilCzZlY5CuHKLcMV/P6SdW0TjJXHiGKYRTKX1Pw5JGju+uxyecK1NB+rpUuSjWz28ofSxzD2duSCvRP5cSa4ejLgdXZ+PD6uH1NORrYZmCO1imOiAUhano/iHc6lvzaG8JNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731935891; c=relaxed/simple;
	bh=WjoXz6Hdg7gR5wTf7YBUU1QvFM7nkg9RIzAHuE8Wgzs=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=l4BlVUAcgqQbOpdTn+zbpuOEChKo9lwVgYkripm70DFkYyOzZmmZ3G3tySp/vGvsVyYFxxz7FC9bXcytsqAMZ2jpqVrQ3QIldLLEhnklB+/VWWbJ0tSMyXl8hQckVtKxdwxR/GXNmQARjUDYcsoQFp5bpEyieh8+yXTIfxC1WSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q7ANUSdy; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731935889; x=1763471889;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=WjoXz6Hdg7gR5wTf7YBUU1QvFM7nkg9RIzAHuE8Wgzs=;
  b=Q7ANUSdy0+XvmfYTdiFDTioQLPxD7oMnumR6dV+ux+c+H6NXEzFqyXQX
   OOk3QINHhjBH5QNJx9/+/6A9u3L+cl2yjplUodHcvckllr0cSSAz86EmD
   tp84NschUNDFF+VJbbwmNANztGfSgFR9F1Tc0WPo26Rfr17H/cprn2QL2
   Ahz1+7/j8XmDYU3qH2hjJRQzRhqnBXiBuz4pWWGysUxlAQvqQKLg+bqf3
   TmBKxH58Wo9iOT2hsINqIqMAYdivcqZ+vAnIMa9PofO0P7Gsez7FP/L1t
   6t5tZXSbN3/WjMdVXBd4OJElp1B8LqGVGr/Gg7fJ8yVt5Mx6PSsyEbPyr
   w==;
X-CSE-ConnectionGUID: 63KpQSb2Rri5wQ/I2vd1mg==
X-CSE-MsgGUID: 2KiyKIi5TU6X/wpqTqo95Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11260"; a="35800882"
X-IronPort-AV: E=Sophos;i="6.12,164,1728975600"; 
   d="scan'208";a="35800882"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 05:18:08 -0800
X-CSE-ConnectionGUID: TvMCNan6QpWHfObtxyVbcg==
X-CSE-MsgGUID: V1koocIrSwG0cZuVyk3JFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,164,1728975600"; 
   d="scan'208";a="89621252"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.193])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 05:17:57 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 18 Nov 2024 15:17:53 +0200 (EET)
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
cc: Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org, 
    Bjorn Helgaas <bhelgaas@google.com>, 
    Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
    Rob Herring <robh@kernel.org>, Krzysztof Wilczy??ski <kw@linux.com>, 
    "Maciej W . Rozycki" <macro@orcam.me.uk>, 
    Alexandru Gagniuc <mr.nuke.me@gmail.com>, 
    Krishna chaitanya chundru <quic_krichai@quicinc.com>, 
    Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
    "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
    Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>, 
    LKML <linux-kernel@vger.kernel.org>, 
    Daniel Lezcano <daniel.lezcano@linaro.org>, 
    Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
    Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v9 7/9] PCI/bwctrl: Add API to set PCIe Link Speed
In-Reply-To: <20241118130332.00006da8@huawei.com>
Message-ID: <997f2c25-8a45-8dfd-cd94-bc37f2555e89@linux.intel.com>
References: <20241018144755.7875-1-ilpo.jarvinen@linux.intel.com> <20241018144755.7875-8-ilpo.jarvinen@linux.intel.com> <ZzN4pO0lJDTSySaz@wunner.de> <4f4ee107-1b25-f866-832e-6a35c8c7c35a@linux.intel.com> <20241118130332.00006da8@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-838757642-1731935873=:933"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-838757642-1731935873=:933
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 18 Nov 2024, Jonathan Cameron wrote:

> On Tue, 12 Nov 2024 18:01:50 +0200 (EET)
> Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com> wrote:
>=20
> > On Tue, 12 Nov 2024, Lukas Wunner wrote:
> >=20
> > > On Fri, Oct 18, 2024 at 05:47:53PM +0300, Ilpo J=E4rvinen wrote: =20
> > > > +EXPORT_SYMBOL_GPL(pcie_set_target_speed); =20
> > >=20
> > > My apologies for another belated comment on this series.
> > > This patch is now a688ab21eb72 on pci/bwctrl:
> > >=20
> > > I note that pcie_set_target_speed() is not called my a modular user
> > > (CONFIG_PCIE_THERMAL is bool, not tristate), so the above-quoted expo=
rt
> > > isn't really necessary right now.  I don't know if it was added
> > > intentionally because some modular user is expected to show up
> > > in the near future. =20
> >=20
> > Its probably a thinko to add it at all but then there have been talk ab=
out=20
> > other users interested in the API too so it's not far fetched we could =
see=20
> > a user. No idea about timelines though.
> >=20
> > There are some AMD GPU drivers tweaking the TLS field on their own but=
=20
> > they also touch some HW specific registers (although, IIRC, they only=
=20
> > touch Endpoint'sTLS). I was thinking of converting them but I'm unsure =
if=20
> > that yields something very straightforward and ends up producing a work=
ing=20
> > conversion or not (without ability to test with the HW). But TBH, not o=
n=20
> > my highest priority item.
> >=20
> > > > @@ -135,6 +296,7 @@ static int pcie_bwnotif_probe(struct pcie_devic=
e *srv)
> > > >  =09if (!data)
> > > >  =09=09return -ENOMEM;
> > > > =20
> > > > +=09devm_mutex_init(&srv->device, &data->set_speed_mutex);
> > > >  =09ret =3D devm_request_threaded_irq(&srv->device, srv->irq, NULL,
> > > >  =09=09=09=09=09pcie_bwnotif_irq_thread,
> > > >  =09=09=09=09=09IRQF_SHARED | IRQF_ONESHOT, =20
> > >=20
> > > We generally try to avoid devm_*() functions in port service drivers
> > > because if we later on move them into the PCI core (which is the plan=
),
> > > we'll have to unroll them.  Not the end of the world that they're use=
d
> > > here, just not ideal. =20
> >=20
> > I think Jonathan disagrees with you on that:
> >=20
> > https://lore.kernel.org/linux-pci/20241017114812.00005e67@Huawei.com/
>=20
> Indeed - you beat me to it ;)
>=20
> There is no practical way to move most of the port driver code into the P=
CI
> core and definitely not interrupts. It is a shame though as I'd much pref=
er
> if we could do so.  At LPC other issues some as power management were cal=
led
> out as being very hard to handle, but to me the interrupt bit is a single
> relatively easy to understand blocker.
>=20
> I've been very slow on getting back to this, but my current plan would
>=20
> 1) Split up the bits of portdrv subdrivers that are actually core code
>    (things like the AER counters etc) The current mix in the same files
>    makes it hard to reason about lifetimes etc.
>=20
> 2) Squash all the portdrv sub drivers into simple library style calls so
>    no pretend devices, everything registered directly.  That cleans up
>    a lot of the layering and still provides reusable code if it makes
>    sense to have multiple drivers for ports or to reuse this code for
>    something else. Note that along the way I'll check we can build the
>    portdrv as a module - I don't plan to actually do that, but it shows
>    the layering / abstractions all work if it is possible.  That will
>    probably make use of devm_ where appropriate as it simplifies a lot
>    of paths.

I'm sorry to be a bit of a spoilsport here but quirks make calls to ASPM=20
code and now also to bwctrl set Link Speed API so I'm not entire sure if=20
you can actual succeed in that module test.

(It's just something that again indicates both would belong to PCI core
but sadly that direction is out of options).

--=20
 i.

> 3) Add the MSIX stuff to support 'new' child drivers but only where
>    dynamic MSIX is supported.
>=20
> 4) Register new child devices where the layering does make sense.  So
>    where we are actually binding drivers that can be unbound etc.
>    Only for cases where dynamic MSI-X is available.=20
>=20
> I hope to get back to this in a week or so.
>=20
> Jonathan
>=20
> >=20
> > :-)
> >=20
>=20
--8323328-838757642-1731935873=:933--

