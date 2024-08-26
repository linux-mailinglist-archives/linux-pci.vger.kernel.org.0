Return-Path: <linux-pci+bounces-12206-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E8095F562
	for <lists+linux-pci@lfdr.de>; Mon, 26 Aug 2024 17:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF23CB21C9D
	for <lists+linux-pci@lfdr.de>; Mon, 26 Aug 2024 15:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351A919412A;
	Mon, 26 Aug 2024 15:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EdjS9CZa"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A94D19306C;
	Mon, 26 Aug 2024 15:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724686937; cv=none; b=PqiENNsrCI/Iquu4kbfC43dz8sSqIa9utJmK+lagtaYx1aitKLsL5MoXRufpJfn+XAFn3a+8wNLSnCmV9qBYl3WPHufgCS6oW5o42ElV/wReHo92t+3lDNfkRACc+xrRi1HhvU7LVfTDEzmbptAH7XXq23plaJLBZpHuqerFXqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724686937; c=relaxed/simple;
	bh=xM8pXW+HgjT0erxnOsIGtoopuFkOjZ2IcKxNFrbxs24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WCZrOFK+2hXKBDQAUS40EMbewcaWyu1MUrgWV9+P2/V97lwdYGNOXpxnHNiz3bBBVCgwueURk6fFsIesudDF8A4Dnm4eXzr4rbv9SSHowIobN34NKL8NziYwtDqQV/DZtB1olu5D6kaLZvX0L2MfePcVoYtM/oBMJHNy8l0ajI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EdjS9CZa; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5343eeb4973so3703342e87.2;
        Mon, 26 Aug 2024 08:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724686933; x=1725291733; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FH/rM9r8vy15gTO0SvqG09ShUwI8MYLfcApXi3x19VU=;
        b=EdjS9CZavbm/qHjdqAVWAMe51uCR7TIdmv8bxidfh6CYSFEDINpoD9bnNZw/44NEd2
         bwBi7FKlKtyMt0aRH9pV5PVxbBLin9ef5NWVI29BzbN/ecmH7ybQvBjssgCuZxe2N6ZU
         7ix90zpw2jETILZoFi3jgRNr5r8Uc+0KPKg8uDr8uTXolk0iCXovdJcMfQ0COUo0Fagf
         aIVHXK2pNYoUTKjnCizNHQ2GnNb3Ssg1jeZQVF2hHit1AtRoMmTpfyj80pjyAYaVa3SL
         190xbe2zVRO5EoXJuoymLYZLXgIt0VN5KzhSc99Ki7QVuE4o/Lg4evW1RfKxHAV1p1jZ
         VsIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724686933; x=1725291733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FH/rM9r8vy15gTO0SvqG09ShUwI8MYLfcApXi3x19VU=;
        b=OfchqeexupTnQ70b/gPvTSp4ysO6+DSuBIzlVLqODF84aw3sTALHkfvT3hvcmmbuya
         4jdOLh7DNXR6+k7hm2oNSxBm3H2CQfRZWZE7bWobKs/vPIxCsAiGqTpka2JtNw8h2h0M
         tLhJHtB0tHKzsPT7/FU1qvbvg98315bSVMfOzetEC15qRrr+WnJnPLR0X0Qx86CwU+1a
         W1BdoruNDwHJ5zgXUzCjAEG24whjNZKyBfHfG2yX5yi9AmR1n50/Kk21b1qiiqUgkNGh
         ezOuRQyCdPURdLohfIk8677CHVQAbELVp3rFyzRr92YeTlx2ZbCKOX1+2Zknuk9VpwNe
         Nbgw==
X-Forwarded-Encrypted: i=1; AJvYcCV82Yc0GfBiVscdpNiH8Cn1HQ0lYpvuSjt7qaJLOwA7h3aPdyAHtosYXKiZvRpibbuebyhAPTvn4CLKbA==@vger.kernel.org, AJvYcCVI/piB7xYhp2AHSPIQF5Hk0tDk577LglGcyylXlTgtoaXrXEq5Or9FY6RXK39IQ1kDpOadZyZA@vger.kernel.org, AJvYcCVl833agkMpi5UadWwaCyPL5YHvENsRbuJ13BnzKYdY2hoDUHJWqcFtyzBCVD09LtQY5JO3vrYhJ4kWxoLx@vger.kernel.org, AJvYcCWGRmTCqwn/PSfdfXgT1AAVmlZnnskaFi6uXQdehnW9n2MQpRoJ309ZJ8OyGu9Xxrunu3Q4JthwcARz@vger.kernel.org, AJvYcCWKN89Y418s69KCCpnQbddorcfo/8aSC5MMwvtKd6cH2ZMrUFAzAQZLEcFa+Vyj8fI0w/GCaDawDRsC@vger.kernel.org, AJvYcCWWlpsZ8jctj9IxWb8rtQvxQs1vqqrexaHjZ7YNhuNAIvLxnZVw1sDiWp0IDgkBYvY5QtQkIyzyf/6dsQ==@vger.kernel.org, AJvYcCXuzaFrSIuR/W/rSaj86l3u9rw6GOtN9wKq/KJS32EAWj8zas0gTCJXrxwiKUVmX53q8dLcX/97D4pXXg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwkmXMIVUA9sKDzyL8jEy9n3kr4Qxovw8z1bM2cGDcWxbyAG//6
	AFqhaHBjbrFkL/rqOTtRTb203J3BDnzRje5y1MGPsPxrMEN9PSxU7766//v/ZH7mr11JzDSMnh3
	AME9aKOsRvcxxnkE4TnqlG5qJnig=
X-Google-Smtp-Source: AGHT+IEO+gUPPoFWhnVIZyFPIRMKkPjZZ1g7sFSpxYSDeKMazFoujBp34K9I3yoSDp0PEZ365NhxrirOyyk84oqJOVc=
X-Received: by 2002:ac2:4e06:0:b0:52e:936e:a237 with SMTP id
 2adb3069b0e04-53438846debmr7930724e87.16.1724686932982; Mon, 26 Aug 2024
 08:42:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822134744.44919-1-pstanner@redhat.com> <20240822134744.44919-6-pstanner@redhat.com>
 <ZsdO2q8uD829hP-X@smile.fi.intel.com> <ad6af1c4194873e803df65dc4d595f8e4b26cb33.camel@redhat.com>
In-Reply-To: <ad6af1c4194873e803df65dc4d595f8e4b26cb33.camel@redhat.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 26 Aug 2024 18:41:36 +0300
Message-ID: <CAHp75VfKS_PWer2hEH8x0qgBUEPx05p8BA=c0UirAWjg0SaLeA@mail.gmail.com>
Subject: Re: [PATCH v3 5/9] ethernet: cavium: Replace deprecated PCI functions
To: Philipp Stanner <pstanner@redhat.com>
Cc: Andy Shevchenko <andy@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>, 
	Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>, 
	Xu Yilun <yilun.xu@intel.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Alvaro Karsz <alvaro.karsz@solid-run.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Richard Cochran <richardcochran@gmail.com>, Mark Brown <broonie@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Damien Le Moal <dlemoal@kernel.org>, Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-fpga@vger.kernel.org, 
	linux-gpio@vger.kernel.org, netdev@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 5:51=E2=80=AFPM Philipp Stanner <pstanner@redhat.co=
m> wrote:
> On Thu, 2024-08-22 at 17:44 +0300, Andy Shevchenko wrote:
> > On Thu, Aug 22, 2024 at 03:47:37PM +0200, Philipp Stanner wrote:

...

> > > -   err =3D pcim_iomap_regions(pdev, 1 << PCI_PTP_BAR_NO,
> > > pci_name(pdev));
> > > -   if (err)
> > > +   clock->reg_base =3D pcim_iomap_region(pdev, PCI_PTP_BAR_NO,
> > > pci_name(pdev));
> > > +   if (IS_ERR(clock->reg_base)) {
> > > +           err =3D PTR_ERR(clock->reg_base);
> > >             goto error_free;
> > > -
> > > -   clock->reg_base =3D pcim_iomap_table(pdev)[PCI_PTP_BAR_NO];
> > > +   }
> >
> > Perhaps
> >
> >       clock->reg_base =3D pcim_iomap_region(pdev, PCI_PTP_BAR_NO,
> > pci_name(pdev));
> >       err =3D PTR_ERR_OR_ZERO(clock->reg_base);
> >       if (err)
> >               goto error_free;
> >
> > This will make your patch smaller and neater.
> >
> > P.S. Do you use --histogram diff algo when preparing patches?
>
> So far not.
> Should one do that?

Id doesn't alter your code, it's in addition to what I suggested, but
as Linus shared that there is no reason to avoid using --histogram not
only in Linux kernel, but in general as it produces more
human-readable diff:s.

--=20
With Best Regards,
Andy Shevchenko

