Return-Path: <linux-pci+bounces-17046-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 594FF9D115E
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2024 14:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4B53B27E6D
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2024 13:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0FB01AF0D4;
	Mon, 18 Nov 2024 13:03:45 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9931AF0A5;
	Mon, 18 Nov 2024 13:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731935025; cv=none; b=YqZbY4+W1jZoAtETLGiRxWv1ptA9emBW7A+md5AWai3T50poCdZPdmNSyAtr4tm645iaM5rj/E7uwy2CED/sZhBO+CnBI1bqytZkIy2xaeDsS1/BIgE36jsY/7xdF9bzi1B1xPRJG1BV4/bpb/QearjDpL9ldOiaOXSG4tbhf7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731935025; c=relaxed/simple;
	bh=jin0uwC430LvFZ6vxHYYnP+fq+bWVrBAEUD8o3eSREo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r8jq4mIn0u3UfFn2Tst7NdLCKXiw+bT9dXaut9wrZNjPCDCnvKC1RhsWNiYqEmBVcASLi6OsTvOumAC9Q6xPd95klNGKatIYIUaeuxEH6Fca+vfa8xWpXG5bxzeIKBHvnUWkKc/MERXjWVJhA4zZ/dsQIO3an6e6FnWJyc2W9ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XsSS35H1bz6K9PJ;
	Mon, 18 Nov 2024 21:01:23 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 1789F1409EA;
	Mon, 18 Nov 2024 21:03:35 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 18 Nov
 2024 14:03:34 +0100
Date: Mon, 18 Nov 2024 13:03:32 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: Lukas Wunner <lukas@wunner.de>, <linux-pci@vger.kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "Rob
 Herring" <robh@kernel.org>, Krzysztof Wilczy??ski <kw@linux.com>, "Maciej W .
 Rozycki" <macro@orcam.me.uk>, Alexandru Gagniuc <mr.nuke.me@gmail.com>,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>, Srinivas Pandruvada
	<srinivas.pandruvada@linux.intel.com>, "Rafael J . Wysocki"
	<rafael@kernel.org>, <linux-pm@vger.kernel.org>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, LKML
	<linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
	Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Christophe
 JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v9 7/9] PCI/bwctrl: Add API to set PCIe Link Speed
Message-ID: <20241118130332.00006da8@huawei.com>
In-Reply-To: <4f4ee107-1b25-f866-832e-6a35c8c7c35a@linux.intel.com>
References: <20241018144755.7875-1-ilpo.jarvinen@linux.intel.com>
	<20241018144755.7875-8-ilpo.jarvinen@linux.intel.com>
	<ZzN4pO0lJDTSySaz@wunner.de>
	<4f4ee107-1b25-f866-832e-6a35c8c7c35a@linux.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 12 Nov 2024 18:01:50 +0200 (EET)
Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com> wrote:

> On Tue, 12 Nov 2024, Lukas Wunner wrote:
>=20
> > On Fri, Oct 18, 2024 at 05:47:53PM +0300, Ilpo J=E4rvinen wrote: =20
> > > +EXPORT_SYMBOL_GPL(pcie_set_target_speed); =20
> >=20
> > My apologies for another belated comment on this series.
> > This patch is now a688ab21eb72 on pci/bwctrl:
> >=20
> > I note that pcie_set_target_speed() is not called my a modular user
> > (CONFIG_PCIE_THERMAL is bool, not tristate), so the above-quoted export
> > isn't really necessary right now.  I don't know if it was added
> > intentionally because some modular user is expected to show up
> > in the near future. =20
>=20
> Its probably a thinko to add it at all but then there have been talk abou=
t=20
> other users interested in the API too so it's not far fetched we could se=
e=20
> a user. No idea about timelines though.
>=20
> There are some AMD GPU drivers tweaking the TLS field on their own but=20
> they also touch some HW specific registers (although, IIRC, they only=20
> touch Endpoint'sTLS). I was thinking of converting them but I'm unsure if=
=20
> that yields something very straightforward and ends up producing a workin=
g=20
> conversion or not (without ability to test with the HW). But TBH, not on=
=20
> my highest priority item.
>=20
> > > @@ -135,6 +296,7 @@ static int pcie_bwnotif_probe(struct pcie_device =
*srv)
> > >  	if (!data)
> > >  		return -ENOMEM;
> > > =20
> > > +	devm_mutex_init(&srv->device, &data->set_speed_mutex);
> > >  	ret =3D devm_request_threaded_irq(&srv->device, srv->irq, NULL,
> > >  					pcie_bwnotif_irq_thread,
> > >  					IRQF_SHARED | IRQF_ONESHOT, =20
> >=20
> > We generally try to avoid devm_*() functions in port service drivers
> > because if we later on move them into the PCI core (which is the plan),
> > we'll have to unroll them.  Not the end of the world that they're used
> > here, just not ideal. =20
>=20
> I think Jonathan disagrees with you on that:
>=20
> https://lore.kernel.org/linux-pci/20241017114812.00005e67@Huawei.com/

Indeed - you beat me to it ;)

There is no practical way to move most of the port driver code into the PCI
core and definitely not interrupts. It is a shame though as I'd much prefer
if we could do so.  At LPC other issues some as power management were called
out as being very hard to handle, but to me the interrupt bit is a single
relatively easy to understand blocker.

I've been very slow on getting back to this, but my current plan would

1) Split up the bits of portdrv subdrivers that are actually core code
   (things like the AER counters etc) The current mix in the same files
   makes it hard to reason about lifetimes etc.

2) Squash all the portdrv sub drivers into simple library style calls so
   no pretend devices, everything registered directly.  That cleans up
   a lot of the layering and still provides reusable code if it makes
   sense to have multiple drivers for ports or to reuse this code for
   something else. Note that along the way I'll check we can build the
   portdrv as a module - I don't plan to actually do that, but it shows
   the layering / abstractions all work if it is possible.  That will
   probably make use of devm_ where appropriate as it simplifies a lot
   of paths.

3) Add the MSIX stuff to support 'new' child drivers but only where
   dynamic MSIX is supported.

4) Register new child devices where the layering does make sense.  So
   where we are actually binding drivers that can be unbound etc.
   Only for cases where dynamic MSI-X is available.=20

I hope to get back to this in a week or so.

Jonathan

>=20
> :-)
>=20


