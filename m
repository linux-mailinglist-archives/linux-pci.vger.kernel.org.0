Return-Path: <linux-pci+bounces-14780-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B949A23C9
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 15:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 428C41F21F31
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 13:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5CF1DDC24;
	Thu, 17 Oct 2024 13:28:17 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224091DDC25;
	Thu, 17 Oct 2024 13:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729171697; cv=none; b=XaW7JJAJ5u5/f2b5cbwzMGocYZliiEJbDq6uIhCi6+AIhIti9+MBJ+Q5ZbMmIaLY7yY9JgmBCh27+G1wED+U2Wv1CvK0RkWw5a9zvgHDdSzMYvm1cz/PYJqGy2Wxv2u3M1fLSIak5CQNXvA/7XlWtOBqa39LnZTQkLhwnmLQEOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729171697; c=relaxed/simple;
	bh=zYhE2M7L8Lw8h3EAphOpaSFmhlTvXBX+xaFVMgPsbY8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CSvXZp1ql/uIxQljpus/tRUk1H5794SVGoF5jwzb1BcK24gk9BP4fNSDgJGx2kT3YgZ6BpjZUw+vdoIM6pFw3qDRBN6lsN/vnci5AdwddbAVz6W/65Lt5l1JQ8tIeCOjj9aE/q69WmPa9fLaF5PYckBoAPwuGQ8ReLf2vIUlleY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XTpXz1vGVz6HJV3;
	Thu, 17 Oct 2024 21:27:31 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 961B51400C9;
	Thu, 17 Oct 2024 21:28:11 +0800 (CST)
Received: from localhost (10.126.174.164) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 17 Oct
 2024 15:28:10 +0200
Date: Thu, 17 Oct 2024 14:28:08 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi
	<lorenzo.pieralisi@arm.com>, Rob Herring <robh@kernel.org>, Krzysztof
 =?UTF-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, "Maciej W. Rozycki"
	<macro@orcam.me.uk>, Lukas Wunner <lukas@wunner.de>, Alexandru Gagniuc
	<mr.nuke.me@gmail.com>, Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	<linux-pm@vger.kernel.org>, "Smita Koralahalli"
	<Smita.KoralahalliChannabasappa@amd.com>, Daniel Lezcano
	<daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
	<lukasz.luba@arm.com>, LKML <linux-kernel@vger.kernel.org>, Amit Kucheria
	<amitk@kernel.org>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v8 7/8] thermal: Add PCIe cooling driver
Message-ID: <20241017142808.00002753@Huawei.com>
In-Reply-To: <47da33ac-4959-b30e-5ca6-52d30650b353@linux.intel.com>
References: <20241009095223.7093-1-ilpo.jarvinen@linux.intel.com>
	<20241009095223.7093-8-ilpo.jarvinen@linux.intel.com>
	<20241017120456.00006023@Huawei.com>
	<70507175-dc7d-d334-4a2a-988239f380a6@linux.intel.com>
	<CAJZ5v0g+4ZorOVrC_Pr8BvhDUXckqg5WqREw2Wz+8_WzL_d52g@mail.gmail.com>
	<47da33ac-4959-b30e-5ca6-52d30650b353@linux.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 17 Oct 2024 16:02:34 +0300 (EEST)
Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com> wrote:

> On Thu, 17 Oct 2024, Rafael J. Wysocki wrote:
>=20
> > On Thu, Oct 17, 2024 at 2:16=E2=80=AFPM Ilpo J=C3=A4rvinen
> > <ilpo.jarvinen@linux.intel.com> wrote: =20
> > >
> > > On Thu, 17 Oct 2024, Jonathan Cameron wrote:
> > > =20
> > > > On Wed,  9 Oct 2024 12:52:22 +0300
> > > > Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com> wrote:
> > > > =20
> > > > > Add a thermal cooling driver to provide path to access PCIe bandw=
idth
> > > > > controller using the usual thermal interfaces.
> > > > >
> > > > > A cooling device is instantiated for controllable PCIe Ports from=
 the
> > > > > bwctrl service driver.
> > > > >
> > > > > If registering the cooling device fails, allow bwctrl's probe to
> > > > > succeed regardless. As cdev in that case contains IS_ERR() pseudo
> > > > > "pointer", clean that up inside the probe function so the remove =
side
> > > > > doesn't need to suddenly make an odd looking IS_ERR() check.
> > > > >
> > > > > The thermal side state 0 means no throttling, i.e., maximum suppo=
rted
> > > > > PCIe Link Speed.
> > > > >
> > > > > Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> > > > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > > Acked-by: Rafael J. Wysocki <rafael@kernel.org> # From the coolin=
g device interface perspective =20
> > > >
> > > > Trivial thing noticed on a reread.
> > > >
> > > > =20
> > > > > diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> > > > > index 61e7ae524b1f..d3f9686e26e7 100644
> > > > > --- a/drivers/thermal/Kconfig
> > > > > +++ b/drivers/thermal/Kconfig
> > > > > @@ -220,6 +220,15 @@ config DEVFREQ_THERMAL
> > > > >
> > > > >       If you want this support, you should say Y here.
> > > > >
> > > > > +config PCIE_THERMAL
> > > > > +   bool "PCIe cooling support"
> > > > > +   depends on PCIEPORTBUS
> > > > > +   help
> > > > > +     This implements PCIe cooling mechanism through bandwidth re=
duction
> > > > > +     for PCIe devices. =20
> > > >
> > > > Technically links not devices, but don't think that matters much =20
> > >
> > > That distinction would be splitting hairs beyond what seems useful fr=
om
> > > ordinary user's point of view. If there's no device attached, BW
> > > controller cannot do anything since the link is not going to train.
> > > The link speed reduction is going to impact the speed the device
> > > can communicate with even if it technically occurs on the link. =20
> >=20
> > From the Kconfig description perspective I think it's better to say
> > "devices" even though technically it is about links, because device
> > performance is what users will measure and notice any changes of. =20
>=20
> Yes, that's what I tried to explain above. I intend to keep it as=20
> "devices" for this very reason.
>=20
Fine by me to keep it as things stand. Been reading too many specs
recently so my immediate thought was why is there a bandwidth control
for the engines / memory in the EP :)

Jonathan


