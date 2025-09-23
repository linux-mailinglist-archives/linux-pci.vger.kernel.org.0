Return-Path: <linux-pci+bounces-36753-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B57B95786
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 12:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A5FF189178C
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 10:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A84931A062;
	Tue, 23 Sep 2025 10:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQ2F43NW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6448E2BEC3F
	for <linux-pci@vger.kernel.org>; Tue, 23 Sep 2025 10:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758624215; cv=none; b=jxYxfWPyL1Ank32pAdAdQWi84qhelNeemvR5bspHJl1g7xzKvdCt7oSrzN5gKDXF1aPBfWgUBEy/FjWD9zwhEk5698vRNUaCRJqFbMkiHLyIKHM9UasWjKfKv6zv1ZjMLzL98n8mlN2g3DCSQBWd9jxdBcL5Ku62iykzzhDzbHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758624215; c=relaxed/simple;
	bh=PhQpgWYmL6Ae77aouOTVMF6UGjtRp/UBfJ/i4TcIbd0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=non7lEiJj9N25hSoItfmDZCRec8RPM6AG31bXrKv16Yiwxt2YmNz0z/v/adqNJL+pUwph49Giv/o1wRXHN44rYrwZWsJCZ4Z/hXw+DHwJ+25EUvh7VFspQ696lxsvQqQwfoxDuZio+U+c0Cpr55X/gbaaAESyAyBeon8kzxGNtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQ2F43NW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12853C16AAE
	for <linux-pci@vger.kernel.org>; Tue, 23 Sep 2025 10:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758624215;
	bh=PhQpgWYmL6Ae77aouOTVMF6UGjtRp/UBfJ/i4TcIbd0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YQ2F43NWbByqrPCdddc/rVVBmCEvRgTnluFwtJEZv5CaSpjqrTAjdVNMbyYw9O35k
	 RpeaHf6wbFOfUXNiwmVVJnBvkqdz5RcwN6cxbXrKjblVI9EEA0kazVejxEjDSyRiAT
	 nAcEwvOeHXtufkX7PZcjBxqxqIlk9TzKhXYL6axRZTFyHwknZ0IVS85slDmFpcj6bB
	 +8ZF/gxw1Y3Sq4LCAYUluLG4ryAM3o5OkxZjMjGx65GduWRB/omMa4uwxM+O+wGOGS
	 AJgVNdMIFDP7HOYAhO6OJzUKnCrnVUUh0sY3SNuhGFpnxXA9jXiLU3PWHU6+84fkRC
	 Xqp3+23OdyYPg==
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-786e9b51248so657290a34.0
        for <linux-pci@vger.kernel.org>; Tue, 23 Sep 2025 03:43:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUN5zi+9rb4vRG9k71NzgJxGtgHrFU1yTWi9bXueUiOjQ8rl+ccPyUiAZDMHxghugmb8HGqXFuGV/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxGMJa0DeDhKNBbyg/yugQ1OhQ7igJEowDGaW88XQb917nqaZ2
	rB5M0dpc9MGTKX0CxbzAVWiBK0glPGU2CpN0rxkUZrp/iO6XFdzQkKkCrE/lhkLJq89bkvy7R7M
	m3lptQbqJWDzfDnEbjS8lUOcO1DLdcmc=
X-Google-Smtp-Source: AGHT+IFyv5x60tWKoEAiSRwgxwhv9eam3iNHMg3iUvzjO4YHNL7dKEIF4G8fxRLk2ZGca7oSTQprEjlgDvrig+jusGk=
X-Received: by 2002:a05:6808:2f0d:b0:439:27db:51cb with SMTP id
 5614622812f47-43f2d11320emr1095633b6e.0.1758624214306; Tue, 23 Sep 2025
 03:43:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12763087.O9o76ZdvQC@rafael.j.wysocki> <2399578.ElGaqSPkdT@rafael.j.wysocki>
 <20250923085323.sbetukdirhppecz5@lcpd911>
In-Reply-To: <20250923085323.sbetukdirhppecz5@lcpd911>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 23 Sep 2025 12:43:21 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gF93Qm0_0jGQjAAo6qBJHmEEzByE243nZAyEccsvj=Bw@mail.gmail.com>
X-Gm-Features: AS18NWDk9lzGqwPKuYxUK1IyDKA3OtAPmmtEchpQcRPiibkxHOk0SbKyhUU2I38
Message-ID: <CAJZ5v0gF93Qm0_0jGQjAAo6qBJHmEEzByE243nZAyEccsvj=Bw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] PM: runtime: Add auto-cleanup macros for "resume
 and get" operations
To: Dhruva Gole <d-gole@ti.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Takashi Iwai <tiwai@suse.de>, LKML <linux-kernel@vger.kernel.org>, 
	Linux PCI <linux-pci@vger.kernel.org>, Alex Williamson <alex.williamson@redhat.com>, 
	Bjorn Helgaas <helgaas@kernel.org>, Zhang Qilong <zhangqilong3@huawei.com>, 
	Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 10:53=E2=80=AFAM Dhruva Gole <d-gole@ti.com> wrote:
>
> On Sep 22, 2025 at 17:30:43 +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > It is generally useful to be able to automatically drop a device's
> > runtime PM usage counter incremented by runtime PM operations that
> > resume a device and bump up its usage counter [1].
> >
> > To that end, add DEFINE_CLASS() macros allowing pm_runtime_put()
> > and pm_runtime_put_autosuspend() to be used for the auto-cleanup in
> > those cases.
> >
> > Simply put, a piece of code like below:
> >
> >       pm_runtime_get_sync(dev);
> >       .....
> >       pm_runtime_put(dev);
> >       return 0;
> >
> > can be transformed with CLASS(pm_runtime_get_sync) like:
> >
> >       guard(pm_runtime_get_sync)(dev);
> >       .....
> >       return 0;
> >
> > (see pm_runtime_put() call is gone).
> >
> > However, it is better to do proper error handling in the majority of
> > cases, so doing something like this instead of the above is recommended=
:
> >
> >       CLASS(pm_runtime_get_active, pm)(dev);
> >       if (IS_ERR(pm))
> >               return PTR_ERR(pm);
> >       .....
> >       return 0;
> >
> > In all of the cases in which runtime PM is known to be enabled for the
> > given device or the device can be regarded as operational (and so it ca=
n
> > be accessed) with runtime PM disabled, a piece of code like:
> >
> >       ret =3D pm_runtime_resume_and_get(dev);
> >       if (ret < 0)
> >               return ret;
> >       .....
> >       pm_runtime_put(dev);
> >       return 0;
> >
> > can be simplified with CLASS() like:
> >
> >       CLASS(pm_runtime_get_active, pm)(dev);
> >       if (IS_ERR(pm))
> >               return PTR_ERR(pm);
> >       .....
> >       return 0;
> >
> > (again, see pm_runtime_put() call is gone).
> >
> > Still, if the device cannot be accessed unless runtime PM has been
> > enabled for it, the CLASS(pm_runtime_get_active_enabled) variant
> > needs to be used, that is (in the context of the example above):
> >
> >       CLASS(pm_runtime_get_active_enabled, pm)(dev);
> >       if (IS_ERR(pm))
> >               return PTR_ERR(pm);
> >       .....
> >       return 0;
> >
> > When the original code calls pm_runtime_put_autosuspend(), use one
> > of the "auto" class variants, CLASS(pm_runtime_get_active_auto) or
> > CLASS(pm_runtime_get_active_enabled_auto), so for example, a piece
> > of code like:
> >
> >       ret =3D pm_runtime_resume_and_get(dev);
> >       if (ret < 0)
> >               return ret;
> >       .....
> >       pm_runtime_put_autosuspend(dev);
> >       return 0;
> >
> > will become:
> >
> >       CLASS(pm_runtime_get_active_enabled_auto, pm)(dev);
> >       if (IS_ERR(pm))
> >               return PTR_ERR(pm);
> >       .....
> >       return 0;
> >
> > Note that the cases in which the return value of pm_runtime_get_sync()
> > is checked can also be handled with the help of the new class macros.
> > For example, a piece of code like:
> >
> >       ret =3D pm_runtime_get_sync(dev);
> >       if (ret < 0) {
> >               pm_runtime_put(dev);
> >               return ret;
> >       }
> >       .....
> >       pm_runtime_put(dev);
> >       return 0;
> >
> > can be rewritten as:
> >
> >       CLASS(pm_runtime_get_active_enabled, pm)(dev);
> >       if (IS_ERR(pm))
> >               return PTR_ERR(pm);
> >       .....
> >       return 0;
> >
> > or CLASS(pm_runtime_get_active) can be used if transparent handling of
> > disabled runtime PM is desirable.
> >
>
> Firstly, please can we add all this documentation in runtime_pm [1]
> Otherwise there's just far less developers aware of the new APIs getting
> introduced other than people directly involved. Not everyone is going to
> come down here to look at git log for API docs (even though we proud
> ourselves in having git log as our main source of Documentation in
> kernel ;) )
>
> [1] https://docs.kernel.org/power/runtime_pm.html

That will happen when the early adopters tell me that it works for them.

> > Link: https://lore.kernel.org/linux-pm/878qimv24u.wl-tiwai@suse.de/ [1]
> > Co-developed-by: Takashi Iwai <tiwai@suse.de>
> > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > v2 -> v3:
> >    * Two more class definitions for the case in which resume errors can=
 be
> >      neglected.
> >    * Update of new code comments (for more clarity).
> >    * Changelog update.
> >
> > v1 -> v2:
> >    * Rename the new classes and the new static inline helper.
> >    * Add two classes for handling disabled runtime PM.
> >    * Expand the changelog.
> >    * Adjust the subject.
> >
> > ---
> >  drivers/base/power/runtime.c |    2 +
> >  include/linux/pm_runtime.h   |   82 ++++++++++++++++++++++++++++++++++=
+++++++++
> >  2 files changed, 84 insertions(+)
>
> >
> > --- a/drivers/base/power/runtime.c
> > +++ b/drivers/base/power/runtime.c
> > @@ -796,6 +796,8 @@ static int rpm_resume(struct device *dev
> >               if (dev->power.runtime_status =3D=3D RPM_ACTIVE &&
> >                   dev->power.last_status =3D=3D RPM_ACTIVE)
> >                       retval =3D 1;
> > +             else if (rpmflags & RPM_TRANSPARENT)
> > +                     goto out;
>
> "TRANSPARENT" doesn't tell you exactly what happens. It should be somethi=
ng like
> RPM_IGNORE_DISABLED or RPM_ALLOW_DISABLED IMO.

There is a description in the header file and TRANSPARENT is shorter
than the alternatives.  Besides, this is mostly for internal use.

> >               else
> >                       retval =3D -EACCES;
> >       }
> > --- a/include/linux/pm_runtime.h
> > +++ b/include/linux/pm_runtime.h
> > @@ -21,6 +21,7 @@
> >  #define RPM_GET_PUT          0x04    /* Increment/decrement the
> >                                           usage_count */
> >  #define RPM_AUTO             0x08    /* Use autosuspend_delay */
> > +#define RPM_TRANSPARENT      0x10    /* Succeed if runtime PM is disab=
led */
> >
> >  /*
> >   * Use this for defining a set of PM operations to be used in all situ=
ations
> > @@ -533,6 +534,32 @@ static inline int pm_runtime_resume_and_
> >  }
> >
> >  /**
> > + * pm_runtime_get_active_dev - Resume a device and bump up its usage c=
ounter.
>
> I am getting no clue as to why this is different than regular
> pm_runtime_get_sync then? Can we describe this API better?

Again, this is for internal use.

I may as well drop the kerneldoc for this function altogether, but I'm
not going to send a v4 just for this purpose.

