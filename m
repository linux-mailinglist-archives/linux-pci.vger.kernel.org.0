Return-Path: <linux-pci+bounces-4493-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7CB8716A6
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 08:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59D891F21660
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 07:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E217D41D;
	Tue,  5 Mar 2024 07:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="gUvpE67s"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316BE7E10D
	for <linux-pci@vger.kernel.org>; Tue,  5 Mar 2024 07:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709623207; cv=none; b=ETDT1KUB8tH0ZPgrk1nbRx5dJazZvu31NSWLJVFBCzH/pcy7YcbRKT8C5impFQcb/fXa7+Me9JVmGqCni9aYMELuqF2Lg0Tev+U4kA1ucT4CybapT8rKu4XXH2bRW41KI+Y5pZWsvrd+SRLKdaxuD1CYOzvzNWZ758U00hghzHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709623207; c=relaxed/simple;
	bh=zjRVqQ3MKLC2BuD5Q1xI+k8vnbV92CXcW95Tg8GFIOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Db0ABnE2eS+ENBxekKrWlqhwu8tOyTls5So8c8JOqZoEv4zdnzJcpEtFNn+rRnyL2EflbxPedT4QRwGsOjNFx0GJsN+1yMTgDL8XANyI5C3LoXxFV4AE2dNix2m409ZvUR1SLXJPEGHmyhi0eiMZcgmRUZzzy9UXuGpRI2rIkH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=gUvpE67s; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 2B19B3F0F8
	for <linux-pci@vger.kernel.org>; Tue,  5 Mar 2024 07:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1709623203;
	bh=D6usFkdRzvkX3msLdSSaO/8gvWBvV/3rw0fRdwxUjj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=gUvpE67sS4UKZu0xR3BaLeBaGIa6IBuVb5SjI+RtIM8XNcAz7PiTSM/agMTCWTMC8
	 GKbIcja6ZcaPRszm+3UCIQy1yFZZPNlR1UsFv/Jovp/VtbK6QfDDcr/doZn06svQb3
	 J13XVlbIHKaTQsRMLm2lnDDz4in+KRnq1TlfCyL12OUZaWx77JLXjEyO7nN/Y0t6ku
	 xXrd/y/7jcvgIFHR96oqvXrvpY2MgfkxSXJemK7GDe3zQ8AK3oRSBBFW/aEE5Rm6yC
	 UVyP3r9nt14c3DQNnwA57jnki/Xr+vns05/LvOUURVIvNt9ypcWOXI4ez6BNOilfoL
	 Zfwgvbm0AQmig==
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1dcaf82d9cfso4130285ad.1
        for <linux-pci@vger.kernel.org>; Mon, 04 Mar 2024 23:20:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709623201; x=1710228001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D6usFkdRzvkX3msLdSSaO/8gvWBvV/3rw0fRdwxUjj4=;
        b=kizKLFo5yJhm/NHCBkm6knCEu1jN6vV/EVhoMGL2413rOy6alaNCySkkwv/JFJu7cW
         3U7nH8YSjewL6tmxwyLXB4Le1baXM2vaRQnme3hDtlVXulTpNqcF2NRGgazKGIxZLGiz
         Q9NQz+4MJ3mLS+dtXEYa9JBxz9V48yT8/LUsMFmyC2Rq/rL8aZ1MDlKDeNS6XYoIEUch
         yKyRQ6UrGifukzsJPNFWLNd93P72pL5S0UsXM5DRyPRalQOzRv15eTMhi43yMdZivVyk
         IbFrs6iCU9ae3ycRWdCH5g/e0SRejumT/844hNOqz/3heglvUZACW/AmNbwPqMZttDXs
         IeSw==
X-Forwarded-Encrypted: i=1; AJvYcCVf2/iOiev1dkg8rz85CwYz/GoF9JfPmqGqR3kE78p2uzWphfEADsfjpvHxMznKYJNvEmj2dlIy+5Ecme61+Dwbw23JP07nS/ud
X-Gm-Message-State: AOJu0YzFAFmGn8fNilAigLfljHqw98lo5WPM3/tk4n/Ru5TxIXR9Dq9y
	vkCyPplsaRkpFHb17KH8aZJJ63yLMFSejqcCltkd5Q/+Kk0S377McQXP+yYx18BBEeB33zqAsFG
	JhqZneXX8BUxaEJUnvKhStopdLWA7TJYSliZPbDF9HLLqFw0cBO2d1Qhl73b76xikyvPWbmVZms
	BXiANhNdL6+fV1W6mGEI5KybetxZLmh3BIWSxGDiOKRMXrkyaM
X-Received: by 2002:a17:903:4281:b0:1dc:db95:fd24 with SMTP id ju1-20020a170903428100b001dcdb95fd24mr829114plb.55.1709623201631;
        Mon, 04 Mar 2024 23:20:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGxKgO1I9zqZ3sJIIcIT9prMwSV+RjXIc/zb4fI2VQ0+Uk6wMYaxqkHcDqF+MXjubPRbRMsXIG6WGTdsfpXw6M=
X-Received: by 2002:a17:903:4281:b0:1dc:db95:fd24 with SMTP id
 ju1-20020a170903428100b001dcdb95fd24mr829100plb.55.1709623201268; Mon, 04 Mar
 2024 23:20:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJZ5v0grDNJkEcgw+34SBmNFL7qhSTz8ydC7BSkM7DiCatkKSA@mail.gmail.com>
 <20240304155138.GA482969@bhelgaas> <CAJZ5v0jS_x7=joXkHuuqQhO-FqkhGi44o-Nq-1FGhPQ5-1VhnQ@mail.gmail.com>
 <CAJZ5v0idOkeod9-RmnNGCwMGG+9nYi8eJSBpQYWJnv=N+eVoWg@mail.gmail.com> <CAJZ5v0jJEo5p4Wr_bZjHHOfQG4WomX9pFtBwFnU6eMJRoCctOA@mail.gmail.com>
In-Reply-To: <CAJZ5v0jJEo5p4Wr_bZjHHOfQG4WomX9pFtBwFnU6eMJRoCctOA@mail.gmail.com>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Tue, 5 Mar 2024 15:19:49 +0800
Message-ID: <CAAd53p45R93wwK0BpX1c0j7gFH3puv8AJWCxK60-wQZ6SjNhcA@mail.gmail.com>
Subject: Re: [PATCH v3] driver core: Cancel scheduled pm_runtime_idle() on
 device removal
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, gregkh@linuxfoundation.org, bhelgaas@google.com, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ricky Wu <ricky_wu@realtek.com>, Kees Cook <keescook@chromium.org>, 
	Tony Luck <tony.luck@intel.com>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
	linux-hardening@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 2:10=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.org=
> wrote:
>
> On Mon, Mar 4, 2024 at 6:00=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.o=
rg> wrote:
> >
> > On Mon, Mar 4, 2024 at 5:41=E2=80=AFPM Rafael J. Wysocki <rafael@kernel=
.org> wrote:
> > >
> > > On Mon, Mar 4, 2024 at 4:51=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.=
org> wrote:
> > > >
> > > > On Mon, Mar 04, 2024 at 03:38:38PM +0100, Rafael J. Wysocki wrote:
> > > > > On Thu, Feb 29, 2024 at 7:23=E2=80=AFAM Kai-Heng Feng
> > > > > <kai.heng.feng@canonical.com> wrote:
> > > > > >
> > > > > > When inserting an SD7.0 card to Realtek card reader, the card r=
eader
> > > > > > unplugs itself and morph into a NVMe device. The slot Link down=
 on hot
> > > > > > unplugged can cause the following error:
> > > > > >
> > > > > > pcieport 0000:00:1c.0: pciehp: Slot(8): Link Down
> > > > > > BUG: unable to handle page fault for address: ffffb24d403e5010
> > > > > > PGD 100000067 P4D 100000067 PUD 1001fe067 PMD 100d97067 PTE 0
> > > > > > Oops: 0000 [#1] PREEMPT SMP PTI
> > > > > > CPU: 3 PID: 534 Comm: kworker/3:10 Not tainted 6.4.0 #6
> > > > > > Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./H3=
70M Pro4, BIOS P3.40 10/25/2018
> > > > > > Workqueue: pm pm_runtime_work
> > > > > > RIP: 0010:ioread32+0x2e/0x70
> > > > > ...
> > > > > > Call Trace:
> > > > > >  <TASK>
> > > > > >  ? show_regs+0x68/0x70
> > > > > >  ? __die_body+0x20/0x70
> > > > > >  ? __die+0x2b/0x40
> > > > > >  ? page_fault_oops+0x160/0x480
> > > > > >  ? search_bpf_extables+0x63/0x90
> > > > > >  ? ioread32+0x2e/0x70
> > > > > >  ? search_exception_tables+0x5f/0x70
> > > > > >  ? kernelmode_fixup_or_oops+0xa2/0x120
> > > > > >  ? __bad_area_nosemaphore+0x179/0x230
> > > > > >  ? bad_area_nosemaphore+0x16/0x20
> > > > > >  ? do_kern_addr_fault+0x8b/0xa0
> > > > > >  ? exc_page_fault+0xe5/0x180
> > > > > >  ? asm_exc_page_fault+0x27/0x30
> > > > > >  ? ioread32+0x2e/0x70
> > > > > >  ? rtsx_pci_write_register+0x5b/0x90 [rtsx_pci]
> > > > > >  rtsx_set_l1off_sub+0x1c/0x30 [rtsx_pci]
> > > > > >  rts5261_set_l1off_cfg_sub_d0+0x36/0x40 [rtsx_pci]
> > > > > >  rtsx_pci_runtime_idle+0xc7/0x160 [rtsx_pci]
> > > > > >  ? __pfx_pci_pm_runtime_idle+0x10/0x10
> > > > > >  pci_pm_runtime_idle+0x34/0x70
> > > > > >  rpm_idle+0xc4/0x2b0
> > > > > >  pm_runtime_work+0x93/0xc0
> > > > > >  process_one_work+0x21a/0x430
> > > > > >  worker_thread+0x4a/0x3c0
> > > > > ...
> > > >
> > > > > > This happens because scheduled pm_runtime_idle() is not cancell=
ed.
> > > > >
> > > > > But rpm_resume() changes dev->power.request to RPM_REQ_NONE and i=
f
> > > > > pm_runtime_work() sees this, it will not run rpm_idle().
> > > > >
> > > > > However, rpm_resume() doesn't deactivate the autosuspend timer if=
 it
> > > > > is running (see the comment in rpm_resume() regarding this), so i=
t may
> > > > > queue up a runtime PM work later.
> > > > >
> > > > > If this is not desirable, you need to stop the autosuspend timer
> > > > > explicitly in addition to calling pm_runtime_get_sync().
> > > >
> > > > I don't quite follow all this.  I think the race is between
> > > > rtsx_pci_remove() (not resume) and rtsx_pci_runtime_idle().
> > >
> > > I think so too and the latter is not expected to run.
> > >
> > > >   rtsx_pci_remove()
> > > >   {
> > > >     pm_runtime_get_sync()
> > > >     pm_runtime_forbid()
> > > >     ...
> > > >
> > > > If this is an rtsx bug, what exactly should be added to
> > > > rtsx_pci_remove()?
> > > >
> > > > Is there ever a case where we want any runtime PM work to happen
> > > > during or after a driver .remove()?  If not, maybe the driver core
> > > > should prevent that, which I think is basically what this patch doe=
s.
> > >
> > > No, it is not, because it doesn't actually prevent the race from
> > > occurring, it just narrows the window quite a bit.
> > >
> > > It would be better to call pm_runtime_dont_use_autosuspend() instead
> > > of pm_runtime_barrier().
> > >
> > > > If this is an rtsx driver bug, I'm concerned there may be many othe=
r
> > > > drivers with a similar issue.  rtsx exercises this path more than m=
ost
> > > > because the device switches between card reader and NVMe SSD using
> > > > hotplug add/remove based on whether an SD card is inserted (see [1]=
).
> > >
> > > This is a valid concern, so it is mostly a matter of where to disable
> > > autosuspend.
> > >
> > > It may be the driver core in principle, but note that it calls
> > > ->remove() after invoking pm_runtime_put_sync(), so why would it
> > > disable autosuspend when it allows runtime PM to race with device
> > > removal in general?
> > >
> > > Another way might be to add a pm_runtime_dont_use_autosuspend() call
> > > at the beginning of pci_device_remove().
> > >
> > > Or just remove the optimization in question from rpm_resume() which i=
s
> > > quite confusing and causes people to make assumptions that lead to
> > > incorrect behavior in this particular case.
> >
> > Well, scratch this.
> >
> > If rpm_idle() is already running at the time rpm_resume() is called,
> > the latter may return right away without waiting, which is incorrect.
> >
> > rpm_resume() needs to wait for the "idle" callback to complete, so
> > this (again, modulo GMail-induced whitespace mangling) should help:
> >
> > ---
> >  drivers/base/power/runtime.c |    6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > Index: linux-pm/drivers/base/power/runtime.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/drivers/base/power/runtime.c
> > +++ linux-pm/drivers/base/power/runtime.c
> > @@ -798,7 +798,8 @@ static int rpm_resume(struct device *dev
> >      }
> >
> >      if (dev->power.runtime_status =3D=3D RPM_RESUMING ||
> > -        dev->power.runtime_status =3D=3D RPM_SUSPENDING) {
> > +        dev->power.runtime_status =3D=3D RPM_SUSPENDING ||
> > +        dev->power.idle_notification) {
> >          DEFINE_WAIT(wait);
> >
> >          if (rpmflags & (RPM_ASYNC | RPM_NOWAIT)) {
> > @@ -826,7 +827,8 @@ static int rpm_resume(struct device *dev
> >              prepare_to_wait(&dev->power.wait_queue, &wait,
> >                      TASK_UNINTERRUPTIBLE);
> >              if (dev->power.runtime_status !=3D RPM_RESUMING &&
> > -                dev->power.runtime_status !=3D RPM_SUSPENDING)
> > +                dev->power.runtime_status !=3D RPM_SUSPENDING &&
> > +                !dev->power.idle_notification)
> >                  break;
> >
> >              spin_unlock_irq(&dev->power.lock);
>
> Well, not really.
>
> The problem is that rtsx_pci_runtime_idle() is not expected to be
> running after pm_runtime_get_sync(), but the latter doesn't really
> guarantee that.  It only guarantees that the suspend/resume callbacks
> will not be running after it returns.
>
> As I said above, if the ->runtime_idle() callback is already running
> when pm_runtime_get_sync() runs, the latter will notice that the
> status is RPM_ACTIVE and will return right away without waiting for
> the former to complete.  In fact, it cannot wait for it to complete,
> because it may be called from a ->runtime_idle() callback itself (it
> arguably does not make much sense to do that, but it is not strictly
> forbidden).
>
> So whoever is providing a ->runtime_idle() callback, they need to
> protect it from running in parallel with whatever code runs after
> pm_runtime_get_sync().  Note that ->runtime_idle() will not start
> after pm_runtime_get_sync(), but it may continue running then if it
> has started earlier already.
>
> Calling pm_runtime_barrier() after pm_runtime_get_sync() (not before
> it) should suffice, but once the runtime PM usage counter is dropped,
> rpm_idle() may run again, so this is only effective until the usage
> counter is greater than 1.  This means that
> __device_release_driver(() is not the right place to call it, because
> the usage counter is dropped before calling device_remove() in that
> case.
>
> The PCI bus type can prevent the race between driver-provided
> ->runtime_idle() and ->remove() from occurring by adding a
> pm_runtime_probe() call in the following way:

Thanks for the detailed explanation. Does this mean only PCI bus needs
this fix because other subsystems are not affected, or this needs to
be implemented for each different bus types?

Kai-Heng

>
> ---
>  drivers/pci/pci-driver.c |    7 +++++++
>  1 file changed, 7 insertions(+)
>
> Index: linux-pm/drivers/pci/pci-driver.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/pci/pci-driver.c
> +++ linux-pm/drivers/pci/pci-driver.c
> @@ -473,6 +473,13 @@ static void pci_device_remove(struct dev
>
>      if (drv->remove) {
>          pm_runtime_get_sync(dev);
> +        /*
> +         * If the driver provides a .runtime_idle() callback and it has
> +         * started to run already, it may continue to run in parallel
> +         * with the code below, so wait until all of the runtime PM
> +         * activity has completed.
> +         */
> +        pm_runtime_barrier(dev);
>          drv->remove(pci_dev);
>          pm_runtime_put_noidle(dev);
>      }

