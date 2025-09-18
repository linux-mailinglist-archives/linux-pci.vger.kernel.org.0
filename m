Return-Path: <linux-pci+bounces-36402-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A10B82E0A
	for <lists+linux-pci@lfdr.de>; Thu, 18 Sep 2025 06:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F17A587754
	for <lists+linux-pci@lfdr.de>; Thu, 18 Sep 2025 04:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C802571BE;
	Thu, 18 Sep 2025 04:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dPeKbOw4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F38257427
	for <linux-pci@vger.kernel.org>; Thu, 18 Sep 2025 04:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758169272; cv=none; b=SwYW9C4++6mBJu8qL8rozBNXmA2CCjUDh35kHNxkcYCoRln4c3Qxs1g3o+Ud4jZJTotL8iRzfzvm8/nu+zLD8o75wljsnbeEhng1oroG7mIXkH1g1j1iqBpGfLAnE3EQwQX8NrVuqsKzpllM4PJPnv5/2OmpYJTw/qiA9d+Sya0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758169272; c=relaxed/simple;
	bh=wwUTfpgFTTFeVIeA3HvEyt8lD+0NCAt6/nZZX43t/zY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iYZ5YMBYwf85gCQmi0Cf90gQLfC7qNr6pyV+g4Ge5kcF0kNcfbgK3P+kJ5QVXeQHTbKz/UC/NshvhOC5ikjbDS4Ep+ctUvWIo9fLSBeQN+Ul3Fy9r0AQxVsneGdEDIBU8zgSpI5FimhCHSbXoZqZhDSAVPom53O4gcol/aqUGWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dPeKbOw4; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-62f28b8e12cso874103a12.1
        for <linux-pci@vger.kernel.org>; Wed, 17 Sep 2025 21:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758169269; x=1758774069; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ny1HQiEcENCOtkJNg0PG0b5MvsVRzcAHMWDep89VyTg=;
        b=dPeKbOw4nb/x+mRdiCWPZnh6mE3UOHRvuzYcKvvnWoBBJNg9V5NZMXuT4ItMT9ajLN
         VJKDzCq7AQUwK10AmWiE3fWOiBZWxd5Pagfz+rorzmDZvH9rhEg41RGf2t/SHNlFIMMC
         3Oq+34ntBAtycqZhNj3BwJZWLw0nTuoK8SpkAHhTpL0hclaHaCi+4m8iFCa6Wy1c6+St
         SOtPdGT1ogivGLWWM2xJkcEC5Hqf/ytAklQ5C4Z+1Ug/U0vaIYQGMwGOkQvwA2bE5aN2
         nICcdkgyAGkogPkWyH6W7HHq2f0dOSd3UpaBJ2C3AsKBAHBrRBJ4Vzk/Ymn1JKvRt122
         Q6VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758169269; x=1758774069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ny1HQiEcENCOtkJNg0PG0b5MvsVRzcAHMWDep89VyTg=;
        b=xDAxrhPLYqj3n6bpwC4ibcMDxyoVderOAm+K2TPEX6k9NzXp3IF2vM/LOsRSCbCAVQ
         Qco5evPIcJ58BYS/IIMr4vTA2YxH/wQFy3Uv9cZqt4CTuWGZ14/q86JHAq+Q1RzKX6ot
         J+QfeBI7msy7PGVIHV0HkKc7eOmt+KLHoNFPmEfSQokyeEQHszyUs0TrHo9y7HzHXXbV
         sWlNLFgC5R+5ltxu57HYk3fw915I9ZaLLu2wm9MnaucP1JQmbrWA2y3UiZLpNyNuEKPM
         HLunurK3tNyMsqLcjvDrMPeO5SK07zvbF46VuzW/ZYz8lj4sdPAdPj4nI0j31jLxhws2
         8n4w==
X-Forwarded-Encrypted: i=1; AJvYcCWh7XHLoYM+bFObCh3aoFix/3TNBBqi9X7B023osLLjkS2hMKGFmG4EmIyueYa49OGCouEQZ5A4lyk=@vger.kernel.org
X-Gm-Message-State: AOJu0YygE5QHqJFboWotGXFCBEi46Bh+2VABlN43pe3FzGKbf1O4XY2k
	ml37iyPZ3N3hjjqRwSw0b0V8LiQtYJVvSGChJlpIzU5r0KTipzUmM0WpUHUMbHxqh/p0IHtBHMT
	H00Wtw795GzrDGjQoJp43EYSodBYBV9w=
X-Gm-Gg: ASbGncvhNYQFGIPp+lq8Ydvz2WXtT9iADjVrRnnyrWCgXhxJlHhxQOEVRoldxYN4Ajc
	liQ4Te3+g9nLRBkhtAhl/M3IdcjBZ/MUmTOpdaJDnJ/wK+5IfpHtMw9M1VjGV8H+f4Iz5a9TFdJ
	SeElRIFP4I4KT82uGsrhg0JH0DRVxPeRFR5Ji3Fs+37s3iQrPk+GnYiwE91B6RhYM1JdNExfQQx
	kKV5uwbcWVOTHo1FuhxKf/J
X-Google-Smtp-Source: AGHT+IHQkCwsXuX6L9zBPwExMzHBNUPpNvQAlnsEUMHzaCH2oi/nwoPCs6EiLF4N20Ttx3AjieyFlYIGee1WBT0Kfeg=
X-Received: by 2002:a05:6402:1e8f:b0:62f:4be5:2286 with SMTP id
 4fb4d7f45d1cf-62f83a0ee2amr4490852a12.8.1758169268839; Wed, 17 Sep 2025
 21:21:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250831190055.7952-1-linux.amoon@gmail.com> <23013855.EfDdHjke4D@senjougahara>
 <CANAwSgT615R32WTBzi2-8FYntmaxbmVRLmA3yi+=4ryH43aaWQ@mail.gmail.com> <5148887.LvFx2qVVIh@senjougahara>
In-Reply-To: <5148887.LvFx2qVVIh@senjougahara>
From: Anand Moon <linux.amoon@gmail.com>
Date: Thu, 18 Sep 2025 09:50:52 +0530
X-Gm-Features: AS18NWDn3DS2rKSBHVVo3X9YV3RO_V2fpVtiVzKrKiqe1kYi7AKprfTDJ4_0Zls
Message-ID: <CANAwSgS38WRRFPoYoBfzOXZDp3inCJNLGPfbkSWTXTpW7V2tcg@mail.gmail.com>
Subject: Re: [RFC v1 2/2] PCI: tegra: Use readl_poll_timeout() for link status polling
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, 
	"open list:PCI DRIVER FOR NVIDIA TEGRA" <linux-tegra@vger.kernel.org>, 
	"open list:PCI DRIVER FOR NVIDIA TEGRA" <linux-pci@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mikko,

On Thu, 18 Sept 2025 at 06:56, Mikko Perttunen <mperttunen@nvidia.com> wrot=
e:
>
> On Wednesday, September 17, 2025 4:45=E2=80=AFPM Anand Moon wrote:
> > Hi Mikko,
> >
> > Thanks for your review comments.
> >
> > On Wed, 17 Sept 2025 at 08:51, Mikko Perttunen <mperttunen@nvidia.com> =
wrote:
> > >
> > > On Monday, September 1, 2025 4:00=E2=80=AFAM Anand Moon wrote:
> > > > Replace the manual `do-while` polling loops with the readl_poll_tim=
eout()
> > > > helper when checking the link DL_UP and DL_LINK_ACTIVE status bits
> > > > during link bring-up. This simplifies the code by removing the open=
-coded
> > > > timeout logic in favor of the standard, more robust iopoll framewor=
k.
> > > > The change improves readability and reduces code duplication.
> > > >
> > > > Cc: Thierry Reding <thierry.reding@gmail.com>
> > > > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > > > ---
> > > >  drivers/pci/controller/pci-tegra.c | 38 ++++++++++++--------------=
----
> > > >  1 file changed, 15 insertions(+), 23 deletions(-)
> > > >
> > > > diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/contr=
oller/pci-tegra.c
> > > > index 3841489198b64..8e850f7c84e40 100644
> > > > --- a/drivers/pci/controller/pci-tegra.c
> > > > +++ b/drivers/pci/controller/pci-tegra.c
> > > > @@ -24,6 +24,7 @@
> > > >  #include <linux/irqchip/chained_irq.h>
> > > >  #include <linux/irqchip/irq-msi-lib.h>
> > > >  #include <linux/irqdomain.h>
> > > > +#include <linux/iopoll.h>
> > >
> > > There is already an iopoll.h include in this file, so this adds a dup=
licate.
> > >
> > Opps, I missed this in rebasing my code.
> >
> > > >  #include <linux/kernel.h>
> > > >  #include <linux/init.h>
> > > >  #include <linux/module.h>
> > > > @@ -2157,37 +2158,28 @@ static bool tegra_pcie_port_check_link(stru=
ct tegra_pcie_port *port)
> > > >       value |=3D RP_PRIV_MISC_PRSNT_MAP_EP_PRSNT;
> > > >       writel(value, port->base + RP_PRIV_MISC);
> > > >
> > > > -     do {
> > > > -             unsigned int timeout =3D TEGRA_PCIE_LINKUP_TIMEOUT;
> > > > -
> > > > -             do {
> > > > -                     value =3D readl(port->base + RP_VEND_XP);
> > > > -
> > > > -                     if (value & RP_VEND_XP_DL_UP)
> > > > -                             break;
> > > > -
> > > > -                     usleep_range(1000, 2000);
> > > > -             } while (--timeout);
> > > > +     while (retries--) {
> > > > +             int err;
> > > >
> > > > -             if (!timeout) {
> > > > +             err =3D readl_poll_timeout(port->base + RP_VEND_XP, v=
alue,
> > > > +                                      value & RP_VEND_XP_DL_UP,
> > > > +                                      1000,
> > > > +                                      TEGRA_PCIE_LINKUP_TIMEOUT * =
1000);
> > >
> > > The logic change here looks OK to me. This makes the timeout 200ms (T=
EGRA_PCIE_LINKUP_TIMEOUT is 200). Previously, the code looped 200 times wit=
h a 1 to 2ms sleep on each iteration. So the timeout could have been longer=
 than 200ms previously, but not in a way that could be relied on.
> >
> > You're right; the original usleep_range(1000, 2000) had a variable slee=
p time.
> > To replicate the worst-case behavior of the old loop, the
> > readl_poll_timeout should
> > use a delay_us of 1000 and a timeout_us that matches the original
> > maximum duration.
> > Since the previous code looped 200 times with a maximum 2ms sleep,
> > the correct timeout is 400ms, so update (TEGRA_PCIE_LINKUP_TIMEOUT * 20=
00).
> > or increase TEGRA_PCIE_LINKUP_TIMEOUT to 400.
> >
> > Are these changes ok with you?
>
> I think the code is fine as is. Before, the shortest the timeout could be=
 was 200ms, i.e. there should be no situation where we need a timeout longe=
r than that, or otherwise that would fail randomly depending on the sleep d=
uration. So I think the 200ms is correct here and the only change necessary=
 is the removal of the second iopoll.h
>
Thanks for your input. I'll remove the header in the next version.
> Cheers,
> Mikko
>
Thanks
-Anand

