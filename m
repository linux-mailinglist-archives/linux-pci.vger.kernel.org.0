Return-Path: <linux-pci+bounces-38439-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C05EBE7DBD
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 11:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC9751887347
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 09:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696EC2D640F;
	Fri, 17 Oct 2025 09:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XnbLDmKG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43476253B40
	for <linux-pci@vger.kernel.org>; Fri, 17 Oct 2025 09:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760694210; cv=none; b=aabEGLLzAjVo6X3ZPriCQ/BMhNTd3xfWeF0dw6YUeEY2zJzXRG5g9B4WWPlE/yCwYlbwDkLRXoCH3FuZ4YGTI4ZPQyoFXyxb0qej523U76CVjekCpH1UoZia3nYoNZjNTl7y7DnDnwStwttoPA8VTHgjFlAKCce/DrBcNfaGI8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760694210; c=relaxed/simple;
	bh=pkCI6HFfiRn0R2kWZVx7o4rc4bqqMnfKrsb36bHEddo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mcbLTm2/joO/FCMUr5XtTNb6rlLTQfNYMOXqKCHp+G4Mwe1gNoANLpqtTMyIq7BtNxQ+r3wxM8wT3yu7dJNyEUWcSsJjG+yRlbV1AYhm0yj25HM3Qo03DYxCl2nVBZq9S0vxHa413xNHW7EC1CANb4GK1uZhXs88HRSyLpEZkNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XnbLDmKG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E66C2C19424
	for <linux-pci@vger.kernel.org>; Fri, 17 Oct 2025 09:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760694209;
	bh=pkCI6HFfiRn0R2kWZVx7o4rc4bqqMnfKrsb36bHEddo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XnbLDmKG5RnudC+UiGXKohr0V7QpfNa7T2B4ezxb4q260dbsT6Xl71FesMdApZXpw
	 3zeuJIK6CCywFxO6xcPL8xjtuNzUWAQizCxvq0V92bjnZFcO5rh9E7yuhKzX89c/aX
	 AqVMiwszMWwL5TqVGio0E2YV8PO4+mlWOMfgbwJiPhVfc1qaTTcQ1QF0DkZzPWdkih
	 PhwSLq4BFTILe1lcmxhuxdLmZRoSzlkZP41kTpyUTgbGB6T+rYhtERafkf32GwMiN8
	 xVhxBa31J5pL+YEE0EiqpRZFcCvO79vfl2iuOOX3atZSFVK+R6Xsq2bNMnRp/Ud8IM
	 MJGl0o2dfzb2g==
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7c27e5ca2beso240499a34.3
        for <linux-pci@vger.kernel.org>; Fri, 17 Oct 2025 02:43:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWK3u0G+EMxv3aFEPoft+WsoI3SD7/8gmOlQviQ2e/OV+3CgE18XOqxK/kEDRZYGLld9DciWidlr3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRLx70NPPW6vSLkT3dqttHlVrGvqscsfrMpnhzbGkO85r+9AWF
	DEoEyG5N60KanrPV1syHOxQ8iOZTkAnfBnot8UcqRg85sV5pWTWF116hypYeehVOWB3PmAEOYpx
	fzWzgm+x4Q5h8oOHp1n72tfFg0waCWVo=
X-Google-Smtp-Source: AGHT+IFb30NmOSO8om+QY7wjx78VOOzA/XC5BsA2TqliME5xYcdEEBmD6YG/6U29lXl8c1d2Hrs83yjqQRrYaDsT33k=
X-Received: by 2002:a05:6808:1a16:b0:442:20cb:8d18 with SMTP id
 5614622812f47-443a2fb2b9dmr1312211b6e.42.1760694209205; Fri, 17 Oct 2025
 02:43:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3925484.kQq0lBPeGt@rafael.j.wysocki> <cc21a74c-905f-4223-95a8-d747ef763081@baylibre.com>
 <875xce7m11.wl-tiwai@suse.de> <12765144.O9o76ZdvQC@rafael.j.wysocki>
 <68f14b5b6a92_2a2b10018@dwillia2-mobl4.notmuch> <CAJZ5v0iZJFQeBhA7tM-sWuJDtisvrHGjPPdQHrC-eXXF1xJpbA@mail.gmail.com>
 <68f15c85b1781_2a2010086@dwillia2-mobl4.notmuch>
In-Reply-To: <68f15c85b1781_2a2010086@dwillia2-mobl4.notmuch>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 17 Oct 2025 11:43:15 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gKWSdVeT-eKobSe+BedPKZq25adZKdxOgV0z+iOCAyNw@mail.gmail.com>
X-Gm-Features: AS18NWDmW9zSSD8Q9CCy7XVXUmgMtdJ9aAZX1cxaF4-5gfPljWhkljZlWax6ZH8
Message-ID: <CAJZ5v0gKWSdVeT-eKobSe+BedPKZq25adZKdxOgV0z+iOCAyNw@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] PM: runtime: Introduce PM_RUNTIME_ACQUIRE_OR_FAIL()
 macro
To: dan.j.williams@intel.com
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Takashi Iwai <tiwai@suse.de>, 
	David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux PCI <linux-pci@vger.kernel.org>, Alex Williamson <alex.williamson@redhat.com>, 
	Bjorn Helgaas <helgaas@kernel.org>, Zhang Qilong <zhangqilong3@huawei.com>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Frank Li <Frank.Li@nxp.com>, Dhruva Gole <d-gole@ti.com>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	"Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 10:59=E2=80=AFPM <dan.j.williams@intel.com> wrote:
>
> Rafael J. Wysocki wrote:
> > On Thu, Oct 16, 2025 at 9:45=E2=80=AFPM <dan.j.williams@intel.com> wrot=
e:
> > >
> > > Rafael J. Wysocki wrote:
> > > [..]
> > > > > > [1]: https://lore.kernel.org/all/CAHk-=3Dwhn07tnDosPfn+UcAtWHBc=
Lg=3DKqA16SHVv0GV4t8P1fHw@mail.gmail.com/
> > > > >
> > > > > Yeah, I myself also find it suboptimal, hence it wasn't really
> > > > > proposed...  It's a limit of macro, unfortunately.
> > > >
> > > > The macro from the $subject patch can be split along the lines of t=
he appended
> > > > patch to avoid the "disgusting syntax" issue, although it then beco=
mes less
> > > > attractive as far as I'm concerned.  It still allows the details un=
related to
> > > > the rest of the code to be hidden though.
> > > >
> > > > ---
> > > >  drivers/acpi/acpi_tad.c |   10 ++++++++--
> > > >  1 file changed, 8 insertions(+), 2 deletions(-)
> > > >
> > > > --- a/drivers/acpi/acpi_tad.c
> > > > +++ b/drivers/acpi/acpi_tad.c
> > > > @@ -31,6 +31,12 @@ MODULE_DESCRIPTION("ACPI Time and Alarm
> > > >  MODULE_LICENSE("GPL v2");
> > > >  MODULE_AUTHOR("Rafael J. Wysocki");
> > > >
> > > > +#define PM_RUNTIME_ACQUIRE_ACTIVE(dev)       \
> > > > +     ACQUIRE(pm_runtime_active_try, pm_runtime_active_guard_var)(d=
ev)
> > > > +
> > > > +#define PM_RUNTIME_ACQUIRE_ACTIVE_ERR        \
> > > > +     ACQUIRE_ERR(pm_runtime_active_try, &pm_runtime_active_guard_v=
ar)
> > > > +
> > > >  /* ACPI TAD capability flags (ACPI 6.2, Section 9.18.2) */
> > > >  #define ACPI_TAD_AC_WAKE     BIT(0)
> > > >  #define ACPI_TAD_DC_WAKE     BIT(1)
> > > > @@ -264,8 +270,8 @@ static int acpi_tad_wake_set(struct devi
> > > >       args[0].integer.value =3D timer_id;
> > > >       args[1].integer.value =3D value;
> > > >
> > > > -     ACQUIRE(pm_runtime_active_try, pm)(dev);
> > > > -     if (ACQUIRE_ERR(pm_runtime_active_try, &pm))
> > > > +     PM_RUNTIME_ACQUIRE_ACTIVE(dev);
> > > > +     if (PM_RUNTIME_ACQUIRE_ACTIVE_ERR)
> > > >               return -ENXIO;
> > >
> > > This defeats one of the other motivations for ACQUIRE() vs
> > > scoped_cond_guard() in that it drops the error code from
> > > pm_runtime_active_try.
> >
> > No, it doesn't.  PM_RUNTIME_ACQUIRE_ACTIVE_ERR is that error code.  Or
> > did I misunderstand what you said?
>
> Oh, what I am saying is that pm_runtime_get_active() returns a distinct
> error code like -EACCES or -EINPROGRESS etc. The
> PM_RUNTIME_ACQUIRE_ACTIVE_ERR proposal ignores that value and open codes
> returning -ENXIO.

No, it doesn't.

You can still do

ret =3D PM_RUNTIME_ACQUIRE_ACTIVE_ERR;
if (ret)
        return ret;

if the caller needs to know the original resume error code.

The code being updated in the example patch returns -ENXIO, but it
does so before the change either.

