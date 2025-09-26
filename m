Return-Path: <linux-pci+bounces-37120-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3B8BA4E22
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 20:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7FFF1C04D5E
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 18:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070CC2FFDD3;
	Fri, 26 Sep 2025 18:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQFPgJpx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A3F2BD5AF
	for <linux-pci@vger.kernel.org>; Fri, 26 Sep 2025 18:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758911044; cv=none; b=oACb7hVmr50Ysgw51AjO3pfuKjd6p3JULrdB6JYfEkRpzDWyUOmh9IWAuikcePAjDnM/BQiOlzGch4KB57+tuWPT4R9ozY9zVXMaO6R6PfwJypF63V+M+DobC+2r4WqN7xk/SO9P/tDgY7dxml+znuXdvmSE89n/cMEXfg0kcuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758911044; c=relaxed/simple;
	bh=9j6mK8FZFeUuRCm5ZOvz1DgkZxPq6hvgFrBjNRNB14E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KnidVDwbz9vrEe7VntTTyFerJc/5WZjZ6nRgmp9aQuuoMGHP4mY9lktQ4LoVV/iM1gv8L6A8pAKaT/rlbmDD8s9QTp7chshvC7Us8fale9mxGjtG69STW3wZerJTXjjFIW1PH3/v9ItqRu1aCvOduZFhOpZ2UgE05116KoVM/jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQFPgJpx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7839DC4CEF7
	for <linux-pci@vger.kernel.org>; Fri, 26 Sep 2025 18:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758911044;
	bh=9j6mK8FZFeUuRCm5ZOvz1DgkZxPq6hvgFrBjNRNB14E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BQFPgJpxPOJODv3Xee+xT7Rs3u0PfBsqnWbEumb5zZ3xdwANczkd4FExzh75C/1dG
	 zoTTclimXzkL2MNb+3q1QbkhaAOk2kQiRP7es/Diodek60uBnM43aoNqNyAxT9T3gr
	 smRqUJmZb4ciokuTXmvGfKB7BwNVZYMs2ryXikTOA3EqHllnlF9TbmNssrgNavzAUf
	 d1bC385YSV8k73OF8TeYsPwiReGyVdmM6+3viYceuAZOry3GSdnqs532xhvziO6VLK
	 xDtE+MOc9aNcfGrhJ5ZfV8kTLIZ9F3Z8IkgRlWK6jzPFcJ4S+sl2fEA8/nHa6drq5b
	 OmyPZQNKVof4g==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-364bd7cce53so1591776fac.3
        for <linux-pci@vger.kernel.org>; Fri, 26 Sep 2025 11:24:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUM9FIWXeGwSxpira1MgGDU01kRr/KV07sxnsskFkBAZplwEmsKb5/wTaG3nlCUS0ZK5Yb+aflF4C0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4ytJjHk0nYLyy2jUIIQ+i8LxHAgmxqpl8Ip0oT77eQo+7uUtZ
	AH1D6kT4Q0H2e7gnZDv1LmBx3BlcSLUf5JsOkVyjJyplfDLADyyhPG+YGA8OzJr7eVYHCTxZs9H
	fNa7qzAaNrhYPu9QaDAYhuU7jNCCMh6Y=
X-Google-Smtp-Source: AGHT+IFHmZiOIDgSSMHpIB312kAThjnMD4yPG9dBopbbEpQcDVj+Z5hduxWMlKK1Krru7E7A5can3wvIOP+MsO+XVq0=
X-Received: by 2002:a05:6870:819c:b0:36e:f8c2:7454 with SMTP id
 586e51a60fabf-36ef90ecd76mr1757096fac.37.1758911043746; Fri, 26 Sep 2025
 11:24:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5049058.31r3eYUQgx@rafael.j.wysocki> <2245131.irdbgypaU6@rafael.j.wysocki>
 <20250926144947.00002f75@huawei.com> <CAJZ5v0gnqoJ8bALZT61ZvTA=chp8y5QBiA7ZpNQ6fFJuQzZUnA@mail.gmail.com>
 <68d6d7dbd18b4_10520100c8@dwillia2-mobl4.notmuch>
In-Reply-To: <68d6d7dbd18b4_10520100c8@dwillia2-mobl4.notmuch>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 26 Sep 2025 20:23:51 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gcr1z_J=b7z-Z22aSOUfubgHpTcYtag778CUQUO8H6OQ@mail.gmail.com>
X-Gm-Features: AS18NWCQg1vTq06aFYsgxKOY8Nlswy9iDNeDFTht59FbvEtD8udM9-TMj4SOtz4
Message-ID: <CAJZ5v0gcr1z_J=b7z-Z22aSOUfubgHpTcYtag778CUQUO8H6OQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] PCI/sysfs: Use PM runtime class macro for auto
 cleanup in reset_method_store()
To: dan.j.williams@intel.com
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux PCI <linux-pci@vger.kernel.org>, Alex Williamson <alex.williamson@redhat.com>, 
	Bjorn Helgaas <helgaas@kernel.org>, Takashi Iwai <tiwai@suse.de>, 
	Zhang Qilong <zhangqilong3@huawei.com>, Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 8:13=E2=80=AFPM <dan.j.williams@intel.com> wrote:
>
> Rafael J. Wysocki wrote:
> > On Fri, Sep 26, 2025 at 3:49=E2=80=AFPM Jonathan Cameron
> > <jonathan.cameron@huawei.com> wrote:
> > >
> > > On Fri, 19 Sep 2025 18:38:42 +0200
> > > "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> > >
> > > > From: Takashi Iwai <tiwai@suse.de>
> > > >
> > > > The newly introduced class macro can simplify the code.
> > > >
> > > > Also, add the proper error handling for the PM runtime get.
> > > >
> > > > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > > > [ rjw: Adjust subject and error handling ]
> > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > ---
> > > >  drivers/pci/pci-sysfs.c |    5 +++--
> > > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > > >
> > > > --- a/drivers/pci/pci-sysfs.c
> > > > +++ b/drivers/pci/pci-sysfs.c
> > > > @@ -1475,8 +1475,9 @@ static ssize_t reset_method_store(struct
> > > >               return count;
> > > >       }
> > > >
> > > > -     pm_runtime_get_sync(dev);
> > > > -     struct device *pmdev __free(pm_runtime_put) =3D dev;
> > > > +     CLASS(pm_runtime_resume_and_get, pmdev)(dev);
> > > > +     if (IS_ERR(pmdev))
> > > > +             return -ENXIO;
> > > Hi Rafael,
> > >
> > > Why this approach rather than treating runtime pm state like a condit=
ional
> > > lock (we use it much like one) and using ACQUIRE() / ACQUIRE_ERR()?
> >
> > Mostly because devices are not locks.
> >
> > > Ultimately that's a wrapper around the same infrastructure but
> > > perhaps neater as it removes need to have that explicit magic pmdev.
> >
> > You'll need to have a magic pmdev or similar regardless IIUC.
> >
> > Say there is
> >
> > DEFINE_GUARD(pm_runtime_active, struct device *,
> > pm_runtime_get_sync(_T), pm_runtime_put(_T))
> > DEFINE_GUARD_COND(pm_runtime_active, _try, pm_runtime_resume_and_get(_T=
))
> >
> > so the user of this will do
> >
> > ACQUIRE(pm_runtime_active_try, pm)(dev);
> > if (ACQUIRE_ERR(pm_runtime_active_try, &pm))
> >         return -ENXIO;
>
> FWIW this looks better to me than the open-coded CLASS(). The pattern,
> admittedly coding-style bending, we are using in drivers/cxl/ for
> compactness and error code fidelity is:
>
>    ACQUIRE(pm_runtime_active_try, pm)(dev);
>    if ((ret =3D ACQUIRE_ERR(pm_runtime_active_try, &pm)))
>            return ret;

I prefer somewhat more traditional

ret =3D ACQUIRE_ERR(pm_runtime_active_try, &pm);
if (ret < 0)
        return ret;

It would be nice to be able to hide the pm variable somehow, but this
is not too bad the way it looks now.

> > and there's a "magic" pm though pm is not a struct device pointer.
> >
> > Maybe it's nicer.  I guess people may be more used to dealing with int
> > error variables.
> >
> > Let me try this and see how far I can get with this.
> >
> > > +CC Dan as he can probably remember the discussions around ACQUIRE()
> > > vs the way you have here better than I can.
>
> Yes, effectively a new open-coded CLASS() prompted the ACQUIRE()
> proposal [1]. This pm-active-state reference management indeed looks
> more like a guard() of the active state than an object constructor
> auto-unwind-on-error case.
>
> [1]: http://lore.kernel.org/20250507072145.3614298-1-dan.j.williams@intel=
.com

OK, so please see
https://lore.kernel.org/linux-pm/6196611.lOV4Wx5bFT@rafael.j.wysocki/

