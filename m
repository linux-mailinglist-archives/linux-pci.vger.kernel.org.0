Return-Path: <linux-pci+bounces-9879-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE239294DA
	for <lists+linux-pci@lfdr.de>; Sat,  6 Jul 2024 19:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D918B21CC3
	for <lists+linux-pci@lfdr.de>; Sat,  6 Jul 2024 17:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A20213C3CF;
	Sat,  6 Jul 2024 17:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="FhkiUXjD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAA0132464
	for <linux-pci@vger.kernel.org>; Sat,  6 Jul 2024 17:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720285983; cv=none; b=Zc6iT4ErfaYGGLdwf7+lklZ+ZwDAwyHTBegwbhssmQWkFjWIrzV7z5umDMcCagH7VBeaLHJTfoviQJbIjy6w5kdOIrTJ8rfo3y7e8DKfDkPNLUz5l0FQqXbX+rXnPDcclQiNNAF9ryHFqvJk7YdoIsN3ep0LOAxE6LKmlm27OBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720285983; c=relaxed/simple;
	bh=FdzhW8jckQ9Gfs/TGcGvimbU0+jBM8TysWBJmSELGmU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K7E1CMasV7gjRkmDQe8sxNiqiyMMuZl0CxGHn3jacSyjPOmO+aTxo6PWKz7DNcsEBNlIBhmwbLxL5KnFxk4M0FoOThzvRXaq9QYsKEdz/fmPQYxbnGquq3z8COyHUwwPFD99/kLql6Fd7xs/nn8ELhEhx/Xp5uHd3AnjYPoZJLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=FhkiUXjD; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52e9f788e7bso2725515e87.0
        for <linux-pci@vger.kernel.org>; Sat, 06 Jul 2024 10:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1720285979; x=1720890779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WIHDkPjH3WVeZvlg0BnUYWSb8SNl5wUtj3icTP0TxI0=;
        b=FhkiUXjDQZC7b9B2WQSjZNl42nJ+1beh8umM7xDUslWrF+DH+h5ld+vIYGtK7xfzPP
         gRMfLYFtaHpQh0owRY95RaPGC4rFF9tmz2U1l8qDCwcMhQvcIpAWh0bHB7XX9T01gLTi
         FD37E6c3//8mW3c+3ajl4rjxEeGierdk/KZOKY0mlITnTXRwcc+3S6yML6Ff+BX2CXbh
         WTFrPe5RcKHInUZuyjEA4qbAUHQa4tJ2lzsLqtbVsYQM7ZlSjp/0wQCqAJN9hc/H7BHx
         9J259wZSNE4eKjJY+fj2SrvYPR4WUy5QIMHjOb5v1wLY1EE173y/kp2dcsRhltCBx2pL
         eLIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720285979; x=1720890779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WIHDkPjH3WVeZvlg0BnUYWSb8SNl5wUtj3icTP0TxI0=;
        b=M8JwwYWFxC8CGMfRtAT+Ee0IzgEymNCW42GXuttPN2Rluvc+Ns7A1zyH4RITuNuext
         wxN6MDeqnlFCHwdhYLcxdcv/ru7+SwBpgbcM2ksOiPmKc3mJVqA3siZWxIBm2JslKfpB
         8fjrR2s48wscW304hvT6FMCnTWiotsNiLItb0VdvX6bkC6LmEKXBYR39kxTxBKykBo9x
         JhCNd6BxD6GbNp8sx+kgbIpm+NigHQGgPbJhZrjVyuvTbrMHnHUj2a8SfkhkknsF1/4j
         1nawbXVQoZ01XF9Sm5rj2m9NV4YFn3ickhA34BlI0foz7C+Q1VtxOrUoDsXlac9Vkqez
         wUpw==
X-Forwarded-Encrypted: i=1; AJvYcCVvUWL8y3vT3sv0eP2hvKZ81BOEPF0sshKxjMSyvF4orXnDbJF86BSA4xwCnz8YtjDJi+XiGBeX/sMlW89eKtcGXuSUNEudJ9nD
X-Gm-Message-State: AOJu0YznzLtalwlR2YfaOKN4syoWS5lUubM3Y8BcSDCXO3BxJW6upFJ/
	k25d+05XcHSs/MP5W3MKmf9B+pw+OzNofJu3txkNAEWQk6vCAW2eslociGeUhS6ug3XRS62pn7y
	csZFJToJLl4tqOZkJClTTZyVrz5+rSmWa5SGDOw==
X-Google-Smtp-Source: AGHT+IHr8D+f+x90g+9LqHGNVFw5Ew01Hdekxrn8HMMGKFPoL76ifPylZFsoFm8kiPgvrQKiKpfSbCcCqu0cm2Km+Cc=
X-Received: by 2002:ac2:5dcc:0:b0:52e:9c26:5c0c with SMTP id
 2adb3069b0e04-52ea0639ae9mr5147645e87.37.1720285979207; Sat, 06 Jul 2024
 10:12:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240703091535.3531-1-spasswolf@web.de> <CAMRc=Md=PnpHVGGO6Nb_efVZ0a3cMxWbLvYmkka5Wznks70drw@mail.gmail.com>
 <ZokDkyfn2Xt2Ki-i@wunner.de>
In-Reply-To: <ZokDkyfn2Xt2Ki-i@wunner.de>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Sat, 6 Jul 2024 19:12:48 +0200
Message-ID: <CAMRc=McBpqP=qSbxDGcreTcktq_0vQH_PrtQS0V=Mw3w-_Zmwg@mail.gmail.com>
Subject: Re: [PATCH] pci: bus: only call of_platform_populate() if CONFIG_OF
 is defined
To: Lukas Wunner <lukas@wunner.de>
Cc: Bert Karwatzki <spasswolf@web.de>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	caleb.connolly@linaro.org, bhelgaas@google.com, amit.pundir@linaro.org, 
	neil.armstrong@linaro.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 6, 2024 at 10:43=E2=80=AFAM Lukas Wunner <lukas@wunner.de> wrot=
e:
>
> On Wed, Jul 03, 2024 at 11:32:05AM +0200, Bartosz Golaszewski wrote:
> > On Wed, Jul 3, 2024 at 11:15 AM Bert Karwatzki <spasswolf@web.de> wrote=
:
> > > If of_platform_populate() is called when CONFIG_OF is not defined thi=
s
> > > leads to spurious error messages of the following type:
> > >  pci 0000:00:01.1: failed to populate child OF nodes (-19)
> > >  pci 0000:00:02.1: failed to populate child OF nodes (-19)
> > >
> > > Fixes: 8fb18619d910 ("PCI/pwrctl: Create platform devices for child O=
F nodes of the port node")
> > > Signed-off-by: Bert Karwatzki <spasswolf@web.de>
> > > ---
> > >  drivers/pci/bus.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> > > index e4735428814d..b363010664cd 100644
> > > --- a/drivers/pci/bus.c
> > > +++ b/drivers/pci/bus.c
> > > @@ -350,6 +350,7 @@ void pci_bus_add_device(struct pci_dev *dev)
> > >
> > >         pci_dev_assign_added(dev, true);
> > >
> > > +#ifdef CONFIG_OF
> > >         if (pci_is_bridge(dev)) {
>
> Per section 21 of Documentation/process/coding-style.rst,
> IS_ENABLED() is strongly preferred to #ifdef.
>
>
> > There's a better (less ifdeffery) fix on the list that I'll pick up
> > later today[1].
> >
> > [1] https://lore.kernel.org/lkml/20240702180839.71491-1-superm1@kernel.=
org/T/
>
> That other fix doesn't feel very robust as it depends on
> of_platform_populate() never returning -ENODEV in the
> CONFIG_OF=3Dy case.
>

If we even have to play these ifdef games then the stubs for
of_platform_populate() are broken and should probably return 0 with
!OF as otherwise the stubs themselves are useless.

Bart

