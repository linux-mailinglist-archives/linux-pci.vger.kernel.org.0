Return-Path: <linux-pci+bounces-3200-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C03784C9D8
	for <lists+linux-pci@lfdr.de>; Wed,  7 Feb 2024 12:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF6411F21C02
	for <lists+linux-pci@lfdr.de>; Wed,  7 Feb 2024 11:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A961B7E3;
	Wed,  7 Feb 2024 11:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="Y3sikfb0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52DF2562F
	for <linux-pci@vger.kernel.org>; Wed,  7 Feb 2024 11:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707306210; cv=none; b=UiKf7ZN528By6mcnbVPs3xfrewfFESG//g7b/PAQwFYxZPoJgTVLsuJQ4AmKBOu4d9V+Spukei319iuSGgH8s52nQxWrCCk+szapn6s3JEM3qNhcMf/+zmiWtUqDu0TNf0ygk1BKcFnywrSGZwg7nloa6/+sf62uT4zUQfe7L70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707306210; c=relaxed/simple;
	bh=nZWkH4rVzW8TgkmWTIqL4bL803zy1sSUN3lJAXo3+bg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EOplla18omK3x1GlOvfe71ErHUHHoFIYK80R8txfGX38EsIYtXSju8k4jTOqAZgJ5txE/pw+QL0Tb5YjivUKi0yJGtXmluyyd3gMd2fC2gbaqoWZkR83dHN7z5RtVFYcqGyroRHwm2WQLkL+Z9QLMhB9+59Ar6u9PSbXsdBUIt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=Y3sikfb0; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dc730e5d8bdso487163276.0
        for <linux-pci@vger.kernel.org>; Wed, 07 Feb 2024 03:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1707306208; x=1707911008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LSDT7dq2xZu7tLI0PgHHMilDKxVNEJS24TDaVUc7vdo=;
        b=Y3sikfb00amg3tcvTH2eZUzsg8oF9KEBB76lQv3o8+z78ZXGOnwmBCg8txKQYuJbF3
         G6sUwSKHVZrlheG8IdzxzAn2krymgmcaUlqSmRiGpV3roAdj0CMm6L+N5i2zKQHRhxtH
         5i2ozAV3nKgbMNN44QNxHmI8+yHFO2mndu4BzASoe+B1bQZPGU5d/gqWdk/6i/EhJd5A
         ROvC+8tJWMBE9bd5Kx5u0HgJt+NpTeetij+xeku+CrlPhpUZit2oNLuMEutrJWerQMB9
         Q7LKwKOcev4mWgTOmIV5fE/j9Ukd6hvxineXrNlFt6vr5k7EldfexZ1nhiTsKaO1BV49
         LgmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707306208; x=1707911008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LSDT7dq2xZu7tLI0PgHHMilDKxVNEJS24TDaVUc7vdo=;
        b=Y1a3orOOzxYwclTAaNyR/vcPUuii6tzAwIMIK4SgqPvPM/paVynU6V9v2YKolNq1IT
         UZyOWD622Bl1bSKFyhsDKyRNTz/tzeMkPtoZmbDwrAFgURjcCFT13B0CJXDVjhs7WDiG
         Lm4nPnDxjP0UPOuanrol4iRW0V+FDj57TTiABELO9zag7lSXwSZ1os+X+x+KqqWBhqSk
         Q8SM+q3fdptQMaBMubj1luW0irDmCA8/yA/wfWnPkAsQePEvur1ca2Tmc/lZmd7Az00s
         K/C5rtHVfQcq8IENvYqNE+A/8OaIhveBjqONIiRWbIjJG0rnyoP4AwWDWAUq+ldye/hr
         TIzg==
X-Forwarded-Encrypted: i=1; AJvYcCUXrMJbVklfj4L9a0QSgyWEEBcgcIk5ao3Opjx0Tu+D9lPy1CZdZK3BaSaoosWFfTMeMbtE9K1NYKAanUFAHqBkOUNPbUG04HGo
X-Gm-Message-State: AOJu0YzAZj41a1b+Xu0bYT7bQkmUhhBoMSTg352tRgbPALXcyWAl0LS9
	KDlsKL9bMZ34QBwZR6pCXS36IYqqMcXUMcqVFpm8EEjeiISuJi/f8f1wYA4JwYVqMhFa0FSGO7l
	mn/dBzMG/kN3TxuEF/B0Mup/+Jg4znpi9sFLU3w==
X-Google-Smtp-Source: AGHT+IFn+HVjlgt+YrKr/JzEvw+25I76EhKBvMZgbvcCxOvK5+eHr45jglTRp4lAQ22t4Oqg6fRzfzWknmLl9Th3uic=
X-Received: by 2002:a25:ad68:0:b0:dc2:25d4:11ae with SMTP id
 l40-20020a25ad68000000b00dc225d411aemr4253678ybe.2.1707306207713; Wed, 07 Feb
 2024 03:43:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207084452.9597-1-drake@endlessos.org> <20240207084452.9597-2-drake@endlessos.org>
 <CAPpJ_edoG0dD4aHZiZShcFMoD2JLQhbh7nuUPzgMT_ZMySJ=VQ@mail.gmail.com> <CAJZ5v0ikxjoJz7FDQ4dpCuY70w3LvAT5Tjitfzm9MDLdNyPF1g@mail.gmail.com>
In-Reply-To: <CAJZ5v0ikxjoJz7FDQ4dpCuY70w3LvAT5Tjitfzm9MDLdNyPF1g@mail.gmail.com>
From: Jian-Hong Pan <jhp@endlessos.org>
Date: Wed, 7 Feb 2024 19:42:51 +0800
Message-ID: <CAPpJ_eceu=ByLCJ=afhq_CV=UZorX2DqE6qiy0+xp0-RXHhtHw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] Revert "ACPI: PM: Block ASUS B1400CEAE from
 suspend to idle by default"
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Drake <drake@endlessos.org>, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, bhelgaas@google.com, 
	david.e.box@linux.intel.com, mario.limonciello@amd.com, lenb@kernel.org, 
	linux-acpi@vger.kernel.org, linux@endlessos.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Rafael J. Wysocki <rafael@kernel.org> =E6=96=BC 2024=E5=B9=B42=E6=9C=887=E6=
=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=886:30=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Wed, Feb 7, 2024 at 10:09=E2=80=AFAM Jian-Hong Pan <jhp@endlessos.org>=
 wrote:
> >
> > Daniel Drake <drake@endlessos.org> =E6=96=BC 2024=E5=B9=B42=E6=9C=887=
=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=884:45=E5=AF=AB=E9=81=93=EF=BC=
=9A
> > >
> > > This reverts commit d52848620de00cde4a3a5df908e231b8c8868250, which
> > > was originally put in place to work around a s2idle failure on this
> > > platform where the NVMe device was inaccessible upon resume.
> > >
> > > After extended testing, we found that the firmware's implementation o=
f
> > > S3 is buggy and intermittently fails to wake up the system. We need
> > > to revert to s2idle mode.
> > >
> > > The NVMe issue has now been solved more precisely in the commit title=
d
> > > "PCI: Disable D3cold on Asus B1400 PCI-NVMe bridge"
> > >
> > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D215742
> > > Signed-off-by: Daniel Drake <drake@endlessos.org>
> >
> > Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
>
> What is this tag supposed to mean?
>
> In a reply to a patch, you can give Acked-by, Reviewed-by or
> Tested-by.  Which one do you mean?

Ok!  Then, Acked-by: Jian-Hong Pan <jhp@endlessos.org>

> > > ---
> > >  drivers/acpi/sleep.c | 12 ------------
> > >  1 file changed, 12 deletions(-)
> > >
> > > diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> > > index 808484d112097..728acfeb774d8 100644
> > > --- a/drivers/acpi/sleep.c
> > > +++ b/drivers/acpi/sleep.c
> > > @@ -385,18 +385,6 @@ static const struct dmi_system_id acpisleep_dmi_=
table[] __initconst =3D {
> > >                 DMI_MATCH(DMI_PRODUCT_NAME, "20GGA00L00"),
> > >                 },
> > >         },
> > > -       /*
> > > -        * ASUS B1400CEAE hangs on resume from suspend (see
> > > -        * https://bugzilla.kernel.org/show_bug.cgi?id=3D215742).
> > > -        */
> > > -       {
> > > -       .callback =3D init_default_s3,
> > > -       .ident =3D "ASUS B1400CEAE",
> > > -       .matches =3D {
> > > -               DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> > > -               DMI_MATCH(DMI_PRODUCT_NAME, "ASUS EXPERTBOOK B1400CEA=
E"),
> > > -               },
> > > -       },
> > >         {},
> > >  };
> > >
> > > --

