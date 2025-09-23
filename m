Return-Path: <linux-pci+bounces-36754-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A36EEB9587F
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 12:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5958F3A4B34
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 10:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFCFE32144A;
	Tue, 23 Sep 2025 10:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pwvBO46h"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8E71D63F5;
	Tue, 23 Sep 2025 10:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758625028; cv=none; b=GWvZG8l8vwG7+aAP+xQuDMPEW7qt1VTp7dnAAN7IRwqxmsFRsDEdQs49aBIxUgtthoCjbYH8/1j/Eg//SYyLG8o1Fg/YwQdlJR7uN94Ow41WBG+oqy1WluUfwiRRBB+urE4XYcaxovsYMBpmHflLLv9I+h5dokuKdqduN4I9ias=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758625028; c=relaxed/simple;
	bh=JEyAZyjBMtjVd81h2fLv5J4ZbUDLUdUImJ/IJ+JyxaQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FZGu4CgYwPZvS2v26TICpYV+Fbr9IJQF8s5uAuVje3JnugPSI4UG+kL6rKrHssfcBXDUkLgkqC0A24vKmXRc/6C6UYlniMKs7itwGmtGdm1NPnXIAaDahwm18jg9QHsiIJwFphnAspo2L5bqKl5vs3yeZGXjyqFaSWQB+SxmqH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=pwvBO46h; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58NAumeW989353;
	Tue, 23 Sep 2025 05:56:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1758625008;
	bh=KqPg3M1ZYxR0uQTJr9vLW66adtBuRQoBgJx1D1fciD4=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=pwvBO46hIf6IzY2H8NFHLCu552JzHkrUO76+IKpB6OBs/7zJz/FbKvbLogJu+lRUt
	 Ta/girxyhpUnm9iiGAkLiwuuyNq359SrM1AcmnZqnTdF9rC672XAIZSxg88vwtWBsY
	 mMwYiK50IHaV58OcBgc5x5+/Tmtc53aKwkKg63dE=
Received: from DLEE214.ent.ti.com (dlee214.ent.ti.com [157.170.170.117])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58NAumZZ1917165
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Sep 2025 05:56:48 -0500
Received: from lewvowa02.ent.ti.com (10.180.75.80) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.20; Tue, 23 Sep
 2025 05:56:47 -0500
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvowa02.ent.ti.com
 (10.180.75.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.55; Tue, 23 Sep
 2025 05:56:47 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 23 Sep 2025 05:56:47 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58NAukOK4129010;
	Tue, 23 Sep 2025 05:56:47 -0500
Date: Tue, 23 Sep 2025 16:26:46 +0530
From: Dhruva Gole <d-gole@ti.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Linux PM <linux-pm@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>,
        LKML
	<linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "Alex
 Williamson" <alex.williamson@redhat.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Zhang Qilong <zhangqilong3@huawei.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 1/3] PM: runtime: Add auto-cleanup macros for "resume
 and get" operations
Message-ID: <20250923105646.abrbuf4xblctjl4c@lcpd911>
References: <12763087.O9o76ZdvQC@rafael.j.wysocki>
 <2399578.ElGaqSPkdT@rafael.j.wysocki>
 <20250923085323.sbetukdirhppecz5@lcpd911>
 <CAJZ5v0gF93Qm0_0jGQjAAo6qBJHmEEzByE243nZAyEccsvj=Bw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gF93Qm0_0jGQjAAo6qBJHmEEzByE243nZAyEccsvj=Bw@mail.gmail.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Sep 23, 2025 at 12:43:21 +0200, Rafael J. Wysocki wrote:
> On Tue, Sep 23, 2025 at 10:53 AM Dhruva Gole <d-gole@ti.com> wrote:
> >
> > On Sep 22, 2025 at 17:30:43 +0200, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > It is generally useful to be able to automatically drop a device's
> > > runtime PM usage counter incremented by runtime PM operations that
> > > resume a device and bump up its usage counter [1].
> > >
> > > To that end, add DEFINE_CLASS() macros allowing pm_runtime_put()
> > > and pm_runtime_put_autosuspend() to be used for the auto-cleanup in
> > > those cases.
> > >
> > > Simply put, a piece of code like below:
> > >
> > >       pm_runtime_get_sync(dev);
> > >       .....
> > >       pm_runtime_put(dev);
> > >       return 0;
> > >
> > > can be transformed with CLASS(pm_runtime_get_sync) like:
> > >
> > >       guard(pm_runtime_get_sync)(dev);
> > >       .....
> > >       return 0;
> > >
> > > (see pm_runtime_put() call is gone).
> > >
> > > However, it is better to do proper error handling in the majority of
> > > cases, so doing something like this instead of the above is recommended:
> > >
> > >       CLASS(pm_runtime_get_active, pm)(dev);
> > >       if (IS_ERR(pm))
> > >               return PTR_ERR(pm);
> > >       .....
> > >       return 0;
> > >
> > > In all of the cases in which runtime PM is known to be enabled for the
> > > given device or the device can be regarded as operational (and so it can
> > > be accessed) with runtime PM disabled, a piece of code like:
> > >
> > >       ret = pm_runtime_resume_and_get(dev);
> > >       if (ret < 0)
> > >               return ret;
> > >       .....
> > >       pm_runtime_put(dev);
> > >       return 0;
> > >
> > > can be simplified with CLASS() like:
> > >
> > >       CLASS(pm_runtime_get_active, pm)(dev);
> > >       if (IS_ERR(pm))
> > >               return PTR_ERR(pm);
> > >       .....
> > >       return 0;
> > >
> > > (again, see pm_runtime_put() call is gone).
> > >
> > > Still, if the device cannot be accessed unless runtime PM has been
> > > enabled for it, the CLASS(pm_runtime_get_active_enabled) variant
> > > needs to be used, that is (in the context of the example above):
> > >
> > >       CLASS(pm_runtime_get_active_enabled, pm)(dev);
> > >       if (IS_ERR(pm))
> > >               return PTR_ERR(pm);
> > >       .....
> > >       return 0;
> > >
> > > When the original code calls pm_runtime_put_autosuspend(), use one
> > > of the "auto" class variants, CLASS(pm_runtime_get_active_auto) or
> > > CLASS(pm_runtime_get_active_enabled_auto), so for example, a piece
> > > of code like:
> > >
> > >       ret = pm_runtime_resume_and_get(dev);
> > >       if (ret < 0)
> > >               return ret;
> > >       .....
> > >       pm_runtime_put_autosuspend(dev);
> > >       return 0;
> > >
> > > will become:
> > >
> > >       CLASS(pm_runtime_get_active_enabled_auto, pm)(dev);
> > >       if (IS_ERR(pm))
> > >               return PTR_ERR(pm);
> > >       .....
> > >       return 0;
> > >
> > > Note that the cases in which the return value of pm_runtime_get_sync()
> > > is checked can also be handled with the help of the new class macros.
> > > For example, a piece of code like:
> > >
> > >       ret = pm_runtime_get_sync(dev);
> > >       if (ret < 0) {
> > >               pm_runtime_put(dev);
> > >               return ret;
> > >       }
> > >       .....
> > >       pm_runtime_put(dev);
> > >       return 0;
> > >
> > > can be rewritten as:
> > >
> > >       CLASS(pm_runtime_get_active_enabled, pm)(dev);
> > >       if (IS_ERR(pm))
> > >               return PTR_ERR(pm);
> > >       .....
> > >       return 0;
> > >
> > > or CLASS(pm_runtime_get_active) can be used if transparent handling of
> > > disabled runtime PM is desirable.
> > >
> >
> > Firstly, please can we add all this documentation in runtime_pm [1]
> > Otherwise there's just far less developers aware of the new APIs getting
> > introduced other than people directly involved. Not everyone is going to
> > come down here to look at git log for API docs (even though we proud
> > ourselves in having git log as our main source of Documentation in
> > kernel ;) )
> >
> > [1] https://docs.kernel.org/power/runtime_pm.html
> 
> That will happen when the early adopters tell me that it works for them.

Okay..

> 
> > > Link: https://lore.kernel.org/linux-pm/878qimv24u.wl-tiwai@suse.de/ [1]
> > > Co-developed-by: Takashi Iwai <tiwai@suse.de>
> > > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > ---
> > >
> > > v2 -> v3:
> > >    * Two more class definitions for the case in which resume errors can be
> > >      neglected.
> > >    * Update of new code comments (for more clarity).
> > >    * Changelog update.
> > >
> > > v1 -> v2:
> > >    * Rename the new classes and the new static inline helper.
> > >    * Add two classes for handling disabled runtime PM.
> > >    * Expand the changelog.
> > >    * Adjust the subject.
> > >
> > > ---
> > >  drivers/base/power/runtime.c |    2 +
> > >  include/linux/pm_runtime.h   |   82 +++++++++++++++++++++++++++++++++++++++++++
> > >  2 files changed, 84 insertions(+)
> >
> > >
> > > --- a/drivers/base/power/runtime.c
> > > +++ b/drivers/base/power/runtime.c
> > > @@ -796,6 +796,8 @@ static int rpm_resume(struct device *dev
> > >               if (dev->power.runtime_status == RPM_ACTIVE &&
> > >                   dev->power.last_status == RPM_ACTIVE)
> > >                       retval = 1;
> > > +             else if (rpmflags & RPM_TRANSPARENT)
> > > +                     goto out;
> >
> > "TRANSPARENT" doesn't tell you exactly what happens. It should be something like
> > RPM_IGNORE_DISABLED or RPM_ALLOW_DISABLED IMO.
> 
> There is a description in the header file and TRANSPARENT is shorter
> than the alternatives.  Besides, this is mostly for internal use.

OK.

> 
> > >               else
> > >                       retval = -EACCES;
> > >       }
> > > --- a/include/linux/pm_runtime.h
> > > +++ b/include/linux/pm_runtime.h
> > > @@ -21,6 +21,7 @@
> > >  #define RPM_GET_PUT          0x04    /* Increment/decrement the
> > >                                           usage_count */
> > >  #define RPM_AUTO             0x08    /* Use autosuspend_delay */
> > > +#define RPM_TRANSPARENT      0x10    /* Succeed if runtime PM is disabled */
> > >
> > >  /*
> > >   * Use this for defining a set of PM operations to be used in all situations
> > > @@ -533,6 +534,32 @@ static inline int pm_runtime_resume_and_
> > >  }
> > >
> > >  /**
> > > + * pm_runtime_get_active_dev - Resume a device and bump up its usage counter.
> >
> > I am getting no clue as to why this is different than regular
> > pm_runtime_get_sync then? Can we describe this API better?
> 
> Again, this is for internal use.
> 
> I may as well drop the kerneldoc for this function altogether, but I'm
> not going to send a v4 just for this purpose.

Alright then, fine by me since most comments were nits, and I am ok with
the general idea here...

Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

