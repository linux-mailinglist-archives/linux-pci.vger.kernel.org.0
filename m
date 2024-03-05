Return-Path: <linux-pci+bounces-4509-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 680EA87197C
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 10:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CABD1C20A8D
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 09:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE7051C5F;
	Tue,  5 Mar 2024 09:22:46 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406F650272;
	Tue,  5 Mar 2024 09:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709630565; cv=none; b=mw5aJzwEH7+Hs8ete/BGPbnha9byvF6k8DFdO55FDv2BuyxEenxeRjhEeA6P2OIoTU2CMyGzQ3X/n6paCt6NDrj+iFOruWBKnIGqpzQ3sEtsvInHPOZQywshqEX8Aj01+JvuqaKB56jLNA/kxZ9xrtSPkjo0vtEA5cs0Ma/S2rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709630565; c=relaxed/simple;
	bh=hc/37DdibL/vqhHl9qTpKwdLBKjVDGnmsfHyWs464Jw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ch37po0u5S1FLCxC1HlOns16RB3mj7BBR8oEXWxJCJFQLpj3MJL9TiaaXoDRPQDN02HI8tZvc/xur0Fv/0RN6lNbBtKDzrmabZcCIgPiZ430gs7Uw9C6Wo9ZzWzjbL1LVZ7HwoTBbf7XJaam3o2d53biF2Z2TY377o5e8lFC5ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3bc23738beaso1106348b6e.1;
        Tue, 05 Mar 2024 01:22:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709630563; x=1710235363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4jO8I6TtA5z0cr0pLM2zlEg0Y2wrWVyaMditQ1Gdins=;
        b=DKw8d0nB2g/ahuVEZWvuUjgpdYWYfGjY+nJUcqRHRyq5sWoNG9DmKllETFktpF06r4
         fMmdaMn09HGSsiaN7ZMHtPHxcc1Pin4vYPLqsiliDHvRQoK40WbgFoZ+yTgJP2a4ydjl
         1y51quUbePzhmpij1olmYIwRV1Je46fWgyIHVSNaDlA6OsiW6Ks7S/z84OPIvQwRfC6m
         cT9YtfVncFZa8Eq/AVPG4OWg5LBTNV37MSl0zjACg+eF+axUjh+Okl8ii44RKf1kNQQH
         Tszr+IJGBIoIJRMsQhxmJ1YD756brMG+Rp+CGfY6wUEdyukuajghcXYn+AcNiKvHO5gc
         acFg==
X-Forwarded-Encrypted: i=1; AJvYcCURI9tncbUEv9UgOc2J+fI1Erg+/FuTBz7azN58wD+z0iL102do7AzbsSxrR0mABla011JWyQP+1aIwVP1K8q8j1S5FnZRYnJchwSAr94qO5QRKZOnP/+ige5Porfmv5I6seFlWGn4qbNxY8e8UOZSs+tqZh9KFhMA92LAKsl8jy6A7dUfiN4SZcQGp9NjZhutxGRWo0F9J0FWgaAWk
X-Gm-Message-State: AOJu0YyzImaPsA7vdh4qh6lXauJTJzzlMVUxOIy3gpLEf+KAWhM+AEoz
	vEiUg33/ujq2gWJDYV3OKzBDiVzPWDOVwS60PbjA7kSV2cXuVHeWTbjBq1eMceJSjKc/NFuEFzy
	0iUrXduljcqwPpWUtDYF43HkqrgTdd9RONPU=
X-Google-Smtp-Source: AGHT+IHEOQITlvMF95xVhhyNQVyN6UkZfb5yttIYLMN9gSmjq8KHBB3fSoC7aDSsQz0DNKrVsJ6Nob5t/4hqksw7Ozo=
X-Received: by 2002:a05:6870:638d:b0:21f:d337:4219 with SMTP id
 t13-20020a056870638d00b0021fd3374219mr1437435oap.1.1709630563250; Tue, 05 Mar
 2024 01:22:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJZ5v0grDNJkEcgw+34SBmNFL7qhSTz8ydC7BSkM7DiCatkKSA@mail.gmail.com>
 <20240304155138.GA482969@bhelgaas> <CAJZ5v0jS_x7=joXkHuuqQhO-FqkhGi44o-Nq-1FGhPQ5-1VhnQ@mail.gmail.com>
 <CAJZ5v0idOkeod9-RmnNGCwMGG+9nYi8eJSBpQYWJnv=N+eVoWg@mail.gmail.com>
 <CAJZ5v0jJEo5p4Wr_bZjHHOfQG4WomX9pFtBwFnU6eMJRoCctOA@mail.gmail.com> <CAAd53p45R93wwK0BpX1c0j7gFH3puv8AJWCxK60-wQZ6SjNhcA@mail.gmail.com>
In-Reply-To: <CAAd53p45R93wwK0BpX1c0j7gFH3puv8AJWCxK60-wQZ6SjNhcA@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 5 Mar 2024 10:22:31 +0100
Message-ID: <CAJZ5v0gXAOQVuXNMGizh-4y4=CnbMoPZDXzCyj_zUQ8sMezTuQ@mail.gmail.com>
Subject: Re: [PATCH v3] driver core: Cancel scheduled pm_runtime_idle() on
 device removal
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, gregkh@linuxfoundation.org, 
	bhelgaas@google.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ricky Wu <ricky_wu@realtek.com>, Kees Cook <keescook@chromium.org>, 
	Tony Luck <tony.luck@intel.com>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
	linux-hardening@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 8:20=E2=80=AFAM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> On Tue, Mar 5, 2024 at 2:10=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.o=
rg> wrote:
> >
> > On Mon, Mar 4, 2024 at 6:00=E2=80=AFPM Rafael J. Wysocki <rafael@kernel=
.org> wrote:
> > >
> > > On Mon, Mar 4, 2024 at 5:41=E2=80=AFPM Rafael J. Wysocki <rafael@kern=
el.org> wrote:
> > > >
> > > > On Mon, Mar 4, 2024 at 4:51=E2=80=AFPM Bjorn Helgaas <helgaas@kerne=
l.org> wrote:
> > > > >
> > > > > On Mon, Mar 04, 2024 at 03:38:38PM +0100, Rafael J. Wysocki wrote=
:
> > > > > > On Thu, Feb 29, 2024 at 7:23=E2=80=AFAM Kai-Heng Feng
> > > > > > <kai.heng.feng@canonical.com> wrote:
> > > > > > >
> > > > > > > When inserting an SD7.0 card to Realtek card reader, the card=
 reader
> > > > > > > unplugs itself and morph into a NVMe device. The slot Link do=
wn on hot
> > > > > > > unplugged can cause the following error:
> > > > > > >
> > > > > > > pcieport 0000:00:1c.0: pciehp: Slot(8): Link Down
> > > > > > > BUG: unable to handle page fault for address: ffffb24d403e501=
0
> > > > > > > PGD 100000067 P4D 100000067 PUD 1001fe067 PMD 100d97067 PTE 0
> > > > > > > Oops: 0000 [#1] PREEMPT SMP PTI
> > > > > > > CPU: 3 PID: 534 Comm: kworker/3:10 Not tainted 6.4.0 #6
> > > > > > > Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./=
H370M Pro4, BIOS P3.40 10/25/2018
> > > > > > > Workqueue: pm pm_runtime_work
> > > > > > > RIP: 0010:ioread32+0x2e/0x70
> > > > > > ...
> > > > > > > Call Trace:
> > > > > > >  <TASK>
> > > > > > >  ? show_regs+0x68/0x70
> > > > > > >  ? __die_body+0x20/0x70
> > > > > > >  ? __die+0x2b/0x40
> > > > > > >  ? page_fault_oops+0x160/0x480
> > > > > > >  ? search_bpf_extables+0x63/0x90
> > > > > > >  ? ioread32+0x2e/0x70
> > > > > > >  ? search_exception_tables+0x5f/0x70
> > > > > > >  ? kernelmode_fixup_or_oops+0xa2/0x120
> > > > > > >  ? __bad_area_nosemaphore+0x179/0x230
> > > > > > >  ? bad_area_nosemaphore+0x16/0x20
> > > > > > >  ? do_kern_addr_fault+0x8b/0xa0
> > > > > > >  ? exc_page_fault+0xe5/0x180
> > > > > > >  ? asm_exc_page_fault+0x27/0x30
> > > > > > >  ? ioread32+0x2e/0x70
> > > > > > >  ? rtsx_pci_write_register+0x5b/0x90 [rtsx_pci]
> > > > > > >  rtsx_set_l1off_sub+0x1c/0x30 [rtsx_pci]
> > > > > > >  rts5261_set_l1off_cfg_sub_d0+0x36/0x40 [rtsx_pci]
> > > > > > >  rtsx_pci_runtime_idle+0xc7/0x160 [rtsx_pci]
> > > > > > >  ? __pfx_pci_pm_runtime_idle+0x10/0x10
> > > > > > >  pci_pm_runtime_idle+0x34/0x70
> > > > > > >  rpm_idle+0xc4/0x2b0
> > > > > > >  pm_runtime_work+0x93/0xc0
> > > > > > >  process_one_work+0x21a/0x430
> > > > > > >  worker_thread+0x4a/0x3c0
> > > > > > ...
> > > > >
> > > > > > > This happens because scheduled pm_runtime_idle() is not cance=
lled.
> > > > > >
> > > > > > But rpm_resume() changes dev->power.request to RPM_REQ_NONE and=
 if
> > > > > > pm_runtime_work() sees this, it will not run rpm_idle().
> > > > > >
> > > > > > However, rpm_resume() doesn't deactivate the autosuspend timer =
if it
> > > > > > is running (see the comment in rpm_resume() regarding this), so=
 it may
> > > > > > queue up a runtime PM work later.
> > > > > >
> > > > > > If this is not desirable, you need to stop the autosuspend time=
r
> > > > > > explicitly in addition to calling pm_runtime_get_sync().
> > > > >
> > > > > I don't quite follow all this.  I think the race is between
> > > > > rtsx_pci_remove() (not resume) and rtsx_pci_runtime_idle().
> > > >
> > > > I think so too and the latter is not expected to run.
> > > >
> > > > >   rtsx_pci_remove()
> > > > >   {
> > > > >     pm_runtime_get_sync()
> > > > >     pm_runtime_forbid()
> > > > >     ...
> > > > >
> > > > > If this is an rtsx bug, what exactly should be added to
> > > > > rtsx_pci_remove()?
> > > > >
> > > > > Is there ever a case where we want any runtime PM work to happen
> > > > > during or after a driver .remove()?  If not, maybe the driver cor=
e
> > > > > should prevent that, which I think is basically what this patch d=
oes.
> > > >
> > > > No, it is not, because it doesn't actually prevent the race from
> > > > occurring, it just narrows the window quite a bit.
> > > >
> > > > It would be better to call pm_runtime_dont_use_autosuspend() instea=
d
> > > > of pm_runtime_barrier().
> > > >
> > > > > If this is an rtsx driver bug, I'm concerned there may be many ot=
her
> > > > > drivers with a similar issue.  rtsx exercises this path more than=
 most
> > > > > because the device switches between card reader and NVMe SSD usin=
g
> > > > > hotplug add/remove based on whether an SD card is inserted (see [=
1]).
> > > >
> > > > This is a valid concern, so it is mostly a matter of where to disab=
le
> > > > autosuspend.
> > > >
> > > > It may be the driver core in principle, but note that it calls
> > > > ->remove() after invoking pm_runtime_put_sync(), so why would it
> > > > disable autosuspend when it allows runtime PM to race with device
> > > > removal in general?
> > > >
> > > > Another way might be to add a pm_runtime_dont_use_autosuspend() cal=
l
> > > > at the beginning of pci_device_remove().
> > > >
> > > > Or just remove the optimization in question from rpm_resume() which=
 is
> > > > quite confusing and causes people to make assumptions that lead to
> > > > incorrect behavior in this particular case.
> > >
> > > Well, scratch this.
> > >
> > > If rpm_idle() is already running at the time rpm_resume() is called,
> > > the latter may return right away without waiting, which is incorrect.
> > >
> > > rpm_resume() needs to wait for the "idle" callback to complete, so
> > > this (again, modulo GMail-induced whitespace mangling) should help:
> > >
> > > ---
> > >  drivers/base/power/runtime.c |    6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > >
> > > Index: linux-pm/drivers/base/power/runtime.c
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > --- linux-pm.orig/drivers/base/power/runtime.c
> > > +++ linux-pm/drivers/base/power/runtime.c
> > > @@ -798,7 +798,8 @@ static int rpm_resume(struct device *dev
> > >      }
> > >
> > >      if (dev->power.runtime_status =3D=3D RPM_RESUMING ||
> > > -        dev->power.runtime_status =3D=3D RPM_SUSPENDING) {
> > > +        dev->power.runtime_status =3D=3D RPM_SUSPENDING ||
> > > +        dev->power.idle_notification) {
> > >          DEFINE_WAIT(wait);
> > >
> > >          if (rpmflags & (RPM_ASYNC | RPM_NOWAIT)) {
> > > @@ -826,7 +827,8 @@ static int rpm_resume(struct device *dev
> > >              prepare_to_wait(&dev->power.wait_queue, &wait,
> > >                      TASK_UNINTERRUPTIBLE);
> > >              if (dev->power.runtime_status !=3D RPM_RESUMING &&
> > > -                dev->power.runtime_status !=3D RPM_SUSPENDING)
> > > +                dev->power.runtime_status !=3D RPM_SUSPENDING &&
> > > +                !dev->power.idle_notification)
> > >                  break;
> > >
> > >              spin_unlock_irq(&dev->power.lock);
> >
> > Well, not really.
> >
> > The problem is that rtsx_pci_runtime_idle() is not expected to be
> > running after pm_runtime_get_sync(), but the latter doesn't really
> > guarantee that.  It only guarantees that the suspend/resume callbacks
> > will not be running after it returns.
> >
> > As I said above, if the ->runtime_idle() callback is already running
> > when pm_runtime_get_sync() runs, the latter will notice that the
> > status is RPM_ACTIVE and will return right away without waiting for
> > the former to complete.  In fact, it cannot wait for it to complete,
> > because it may be called from a ->runtime_idle() callback itself (it
> > arguably does not make much sense to do that, but it is not strictly
> > forbidden).
> >
> > So whoever is providing a ->runtime_idle() callback, they need to
> > protect it from running in parallel with whatever code runs after
> > pm_runtime_get_sync().  Note that ->runtime_idle() will not start
> > after pm_runtime_get_sync(), but it may continue running then if it
> > has started earlier already.
> >
> > Calling pm_runtime_barrier() after pm_runtime_get_sync() (not before
> > it) should suffice, but once the runtime PM usage counter is dropped,
> > rpm_idle() may run again, so this is only effective until the usage
> > counter is greater than 1.  This means that
> > __device_release_driver(() is not the right place to call it, because
> > the usage counter is dropped before calling device_remove() in that
> > case.
> >
> > The PCI bus type can prevent the race between driver-provided
> > ->runtime_idle() and ->remove() from occurring by adding a
> > pm_runtime_probe() call in the following way:
>
> Thanks for the detailed explanation. Does this mean only PCI bus needs
> this fix because other subsystems are not affected, or this needs to
> be implemented for each different bus types?

I don't think that it needs to be implemented in this form for any
other bus types.

There are not many cases in which non-trivial .runtime_idle()
callbacks are used and the majority of them are PCI drivers anyway
AFAICS.

Also the drivers using .runtime_idle() can prevent it from racing with
other code paths by themselves, this way or another (for example, with
the help of locking), and it is generally better to address the races
in question on a per-driver basis IMV.

The PCI bus type is kind of exceptional, because it forces devices to
resume and prevents them from suspending before removing drivers,
which is necessary for the fix to be really effective.

