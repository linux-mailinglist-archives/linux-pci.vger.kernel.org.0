Return-Path: <linux-pci+bounces-14773-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA379A22D5
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 14:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B70921F2419C
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 12:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5434D1DD875;
	Thu, 17 Oct 2024 12:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wbukw1on"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254EA1DCB0F;
	Thu, 17 Oct 2024 12:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729169913; cv=none; b=tLd3oMFloPPxh4P+kBx89fCfYUspvSnBtuiK4njrnPvw8FTtwBA+QQmghQWvIM+9MNW/lhpNmyPNtmH3IlIvCm/jqa6Pqz/WynezsPJ/3y9vY+jxUMB9FJJFGRc23gcNgyAvU4iAodAMbed18fVGjJfAMtRNA7y1Iquh6Kjeh+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729169913; c=relaxed/simple;
	bh=gdynTxNANi2KNxHKv2MHHr9xLwfTrrBA8Udodpuyqhg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LMsg9kpcYq/1s9RqLV6XkbPn23F3J3mB3IIdAMKavC8zf3EmwbNj3aEg7MiA7UvbmvGWo4qINLISjBTG9bplDueTxE51Xs1wmT+xUQv6ei+wJfEWJQ8VyuINezG56x9GAyxWO31W72s0aB5V/EqZoN78tfdC6oaFYAgBb/FL7iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wbukw1on; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D92A4C4CED3;
	Thu, 17 Oct 2024 12:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729169912;
	bh=gdynTxNANi2KNxHKv2MHHr9xLwfTrrBA8Udodpuyqhg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Wbukw1onyQHirWmPimfD1118dA3UwDswpz0oB768gaUOKR+jWTvieSNp9w7NgH0QK
	 8VOMRgRUU0rLZIIgk8V4tzYSeowUizZQlBOdmPrbOg0eO5RNLmWasTFsgk7ZpbU/dZ
	 O7UTMj0Dk/wNIqA8lql75A9Qf2JZqcu4xtPqqFdEegFBIUbMQGepbP4+IpBQ99HgjM
	 ZRTWBRPr0rJU8y59NZcAlqUXwiivNsgaW0yfISDmT8Ff/e7FWM9EOo7GjNsYGkDEqY
	 cYLWcZVY55M1Np9WFt7Ql8Rx78iOnXJ1qe7zIMVoDAMTxhWQkcPikWZgLpw0HzV9XW
	 bi8z4oth0z6/g==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-277e6002b7dso266412fac.1;
        Thu, 17 Oct 2024 05:58:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXH3A0ExBCLgs5qgiSsCNXVWarobz0FRw2Bt7hrwtH0MKAEzexjLhWuRPAGgf+9i3RgWD5cleB8wsj1m2A=@vger.kernel.org, AJvYcCXbNbJUtpd5940qFuLZ0vy+yck+BsSpaFd5Jv7TVIEpvMhZ1xNZ6kGsurCLDYN/ooWdNjHW8ZeCBerb@vger.kernel.org, AJvYcCXmdvUQ15Iv20f7k+HwI4cj6HkuZbQ8xZ2JYgGMxhvCazUuhzhd59tWjB6pPjaK9+PuqMTob2POAd0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOtk5HVFlXrCiSrREJcWYb83wyFBaS/DDTaXmTnuaKSbHeoKD9
	SsWkMdNVZp6tbQ4cDytb6GOlkrJV+ci/HqUCAXHvs311xkrbUOLGEgOgy+IaaHDYlXpBWWmlsjv
	/TMdMnVZver0eG/2VkzjXGZFdc+0=
X-Google-Smtp-Source: AGHT+IEoiRWlSghMxMNbPvvqj2OGNuaMKjUnltHxhpb3As8Sl93/qFI0tyB6ATi/OZqfImlB3jiBQK9gOAjuQpfi+r0=
X-Received: by 2002:a05:6870:71c6:b0:286:f74a:93cc with SMTP id
 586e51a60fabf-288872d3234mr11019440fac.2.1729169912149; Thu, 17 Oct 2024
 05:58:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009095223.7093-1-ilpo.jarvinen@linux.intel.com>
 <20241009095223.7093-8-ilpo.jarvinen@linux.intel.com> <20241017120456.00006023@Huawei.com>
 <70507175-dc7d-d334-4a2a-988239f380a6@linux.intel.com>
In-Reply-To: <70507175-dc7d-d334-4a2a-988239f380a6@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 17 Oct 2024 14:58:19 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g+4ZorOVrC_Pr8BvhDUXckqg5WqREw2Wz+8_WzL_d52g@mail.gmail.com>
Message-ID: <CAJZ5v0g+4ZorOVrC_Pr8BvhDUXckqg5WqREw2Wz+8_WzL_d52g@mail.gmail.com>
Subject: Re: [PATCH v8 7/8] thermal: Add PCIe cooling driver
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-pci@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
	Rob Herring <robh@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	"Maciej W. Rozycki" <macro@orcam.me.uk>, Lukas Wunner <lukas@wunner.de>, 
	Alexandru Gagniuc <mr.nuke.me@gmail.com>, Krishna chaitanya chundru <quic_krichai@quicinc.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, LKML <linux-kernel@vger.kernel.org>, 
	Amit Kucheria <amitk@kernel.org>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 2:16=E2=80=AFPM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Thu, 17 Oct 2024, Jonathan Cameron wrote:
>
> > On Wed,  9 Oct 2024 12:52:22 +0300
> > Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com> wrote:
> >
> > > Add a thermal cooling driver to provide path to access PCIe bandwidth
> > > controller using the usual thermal interfaces.
> > >
> > > A cooling device is instantiated for controllable PCIe Ports from the
> > > bwctrl service driver.
> > >
> > > If registering the cooling device fails, allow bwctrl's probe to
> > > succeed regardless. As cdev in that case contains IS_ERR() pseudo
> > > "pointer", clean that up inside the probe function so the remove side
> > > doesn't need to suddenly make an odd looking IS_ERR() check.
> > >
> > > The thermal side state 0 means no throttling, i.e., maximum supported
> > > PCIe Link Speed.
> > >
> > > Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Acked-by: Rafael J. Wysocki <rafael@kernel.org> # From the cooling de=
vice interface perspective
> >
> > Trivial thing noticed on a reread.
> >
> >
> > > diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> > > index 61e7ae524b1f..d3f9686e26e7 100644
> > > --- a/drivers/thermal/Kconfig
> > > +++ b/drivers/thermal/Kconfig
> > > @@ -220,6 +220,15 @@ config DEVFREQ_THERMAL
> > >
> > >       If you want this support, you should say Y here.
> > >
> > > +config PCIE_THERMAL
> > > +   bool "PCIe cooling support"
> > > +   depends on PCIEPORTBUS
> > > +   help
> > > +     This implements PCIe cooling mechanism through bandwidth reduct=
ion
> > > +     for PCIe devices.
> >
> > Technically links not devices, but don't think that matters much
>
> That distinction would be splitting hairs beyond what seems useful from
> ordinary user's point of view. If there's no device attached, BW
> controller cannot do anything since the link is not going to train.
> The link speed reduction is going to impact the speed the device
> can communicate with even if it technically occurs on the link.

From the Kconfig description perspective I think it's better to say
"devices" even though technically it is about links, because device
performance is what users will measure and notice any changes of.

