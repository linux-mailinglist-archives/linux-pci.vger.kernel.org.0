Return-Path: <linux-pci+bounces-4510-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 459B8871980
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 10:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB17B280E3A
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 09:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7B1524BC;
	Tue,  5 Mar 2024 09:23:26 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EA44F1F5;
	Tue,  5 Mar 2024 09:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709630605; cv=none; b=On7JpI5YVpNKc1IDw/izFd6bqpQPuzFBwBZXhynUHVHK1fwzfU/1EuXxZ/1qZJfyTQ/sEi2cQC4MHEg2vUTlMdDS21qkLe3i+OIqmyCGMlaEUeQrTjinD77wdq6+FFOe1xl/iAR9IxaNvoOVXr+49vxKybdtzBjc/1Sr5ZXS/Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709630605; c=relaxed/simple;
	bh=l8xILxIP+aGWbSeHaqRzcIu8VgcP1j0Q7WU+Qn8aVUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UdygT9t5oiY7oQHrnBl1PMb9dUMBr/avHKzXnGOAytJpd9BRi5etYl+73p8uwwqvAv9RfQ7sP9P69haXcCWod4I4uLlC/JztuvxpH95DphWXDezYzsJXwJ5kAzHDGeumgeTD1CTZMDcQ9JGdWfOJUMe9CtsXYUg73JaYSxzWzWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-21eab2bd67bso267641fac.0;
        Tue, 05 Mar 2024 01:23:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709630603; x=1710235403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gQCTBTW7IfJ5vlMZrr2LXR2j09n4mGKlX0Dyj4r0c1E=;
        b=gh8nS5dxTmqamU6NsDIXMkaAiIoUCTfQR9MY9FoArVJ2YyUwlxEmknjLlUWz034jD5
         TVV4ylTswxdKQTDQrRy6YHcqykkDsQCHRsDsQ6ttNbxDUGgnaQy0xrDafVvVdhIU9x5O
         +2iv7ZD4lbmqwrq4ZQDNq49Irjgd8YnaaaCXW8J2wfPsZgKh7I7iX4v51+zSLURkGMNA
         q9NQPVwuh9CI+cDZa4h89piUNTNA3r29I5sIAPEafXWdCStW9rF5yjvzYvt2pEfQxZ3d
         lcn/XivFV4VufYywPS3sKDYys6zZg2eBnxCPILRCCKJQlXeqg+Ms5VoouPYALWeonh8J
         sutA==
X-Forwarded-Encrypted: i=1; AJvYcCWIbMqO3Wz9wo9xsOhIV4BP7HZ+VSVJMXUEzcu13m4Y9BY7+eaLCNUOWe0ah1e9P9FG1H12xGtcgZ2X8c75DQ04voQx8WUR1/WXLKVXbx/SMvPESXYL2n8yZzZUwJnuKsRgBDxnGl375Z4smn/SG9bSkGAXaqEWGmXcbaEfQh8MeJTl3k5j4Htec9acR4731hmN4Vd2lMzrLYUxzDcs
X-Gm-Message-State: AOJu0Yz2IpIKMV1vELF5vyxU9kODftYz7V0xo88L7/fFOO4neTxBCRj4
	g0tZXQH8+LhgmXXox155dUV1GxAdz/Xprpv3JmXQLrkQvaaF/tF3UyDhogNJ/+EoIQTus7uhTEC
	Qx0TjMATM2kc3w+hH9USFUmA1mQs=
X-Google-Smtp-Source: AGHT+IHqGzKm27BRW4GE3MVzZnFqIdO0adC084tGWtqBCO3c4qtsqa2XTbAyQOgt4xCT+eAL7GOz3wowkjku+qGIf6g=
X-Received: by 2002:a05:6871:4393:b0:220:873d:db8b with SMTP id
 lv19-20020a056871439300b00220873ddb8bmr13217962oab.4.1709630603153; Tue, 05
 Mar 2024 01:23:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJZ5v0grDNJkEcgw+34SBmNFL7qhSTz8ydC7BSkM7DiCatkKSA@mail.gmail.com>
 <20240304155138.GA482969@bhelgaas> <CAJZ5v0jS_x7=joXkHuuqQhO-FqkhGi44o-Nq-1FGhPQ5-1VhnQ@mail.gmail.com>
 <CAJZ5v0idOkeod9-RmnNGCwMGG+9nYi8eJSBpQYWJnv=N+eVoWg@mail.gmail.com>
 <CAJZ5v0jJEo5p4Wr_bZjHHOfQG4WomX9pFtBwFnU6eMJRoCctOA@mail.gmail.com>
 <CAJZ5v0izNQ=2oaFff3WBQUm2AHZ5XnrYHq3pz0_Yx685QUUfMA@mail.gmail.com> <a03039a96bed43568564cfc2832d61bf@realtek.com>
In-Reply-To: <a03039a96bed43568564cfc2832d61bf@realtek.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 5 Mar 2024 10:23:11 +0100
Message-ID: <CAJZ5v0iNdSo7B-1jHBO9dFmmjH=oG4G=V-pDeqL6+qrtLzatqw@mail.gmail.com>
Subject: Re: [PATCH v3] driver core: Cancel scheduled pm_runtime_idle() on
 device removal
To: Ricky WU <ricky_wu@realtek.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, 
	Kai-Heng Feng <kai.heng.feng@canonical.com>, 
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "bhelgaas@google.com" <bhelgaas@google.com>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Kees Cook <keescook@chromium.org>, 
	Tony Luck <tony.luck@intel.com>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 10:20=E2=80=AFAM Ricky WU <ricky_wu@realtek.com> wro=
te:
>
> > On Mon, Mar 4, 2024 at 7:10=E2=80=AFPM Rafael J. Wysocki <rafael@kernel=
.org>
> > wrote:
> > >
> > > On Mon, Mar 4, 2024 at 6:00=E2=80=AFPM Rafael J. Wysocki <rafael@kern=
el.org>
> > wrote:
> > > >
> > > > On Mon, Mar 4, 2024 at 5:41=E2=80=AFPM Rafael J. Wysocki <rafael@ke=
rnel.org>
> > wrote:
> > > > >
> > > > > On Mon, Mar 4, 2024 at 4:51=E2=80=AFPM Bjorn Helgaas <helgaas@ker=
nel.org>
> > wrote:
> > > > > >
> > > > > > On Mon, Mar 04, 2024 at 03:38:38PM +0100, Rafael J. Wysocki wro=
te:
> > > > > > > On Thu, Feb 29, 2024 at 7:23=E2=80=AFAM Kai-Heng Feng
> > > > > > > <kai.heng.feng@canonical.com> wrote:
> > > > > > > >
> > > > > > > > When inserting an SD7.0 card to Realtek card reader, the ca=
rd
> > reader
> > > > > > > > unplugs itself and morph into a NVMe device. The slot Link =
down on
> > hot
> > > > > > > > unplugged can cause the following error:
> > > > > > > >
> > > > > > > > pcieport 0000:00:1c.0: pciehp: Slot(8): Link Down
> > > > > > > > BUG: unable to handle page fault for address: ffffb24d403e5=
010
> > > > > > > > PGD 100000067 P4D 100000067 PUD 1001fe067 PMD 100d97067
> > PTE 0
> > > > > > > > Oops: 0000 [#1] PREEMPT SMP PTI
> > > > > > > > CPU: 3 PID: 534 Comm: kworker/3:10 Not tainted 6.4.0 #6
> > > > > > > > Hardware name: To Be Filled By O.E.M. To Be Filled By
> > O.E.M./H370M Pro4, BIOS P3.40 10/25/2018
> > > > > > > > Workqueue: pm pm_runtime_work
> > > > > > > > RIP: 0010:ioread32+0x2e/0x70
> > > > > > > ...
> > > > > > > > Call Trace:
> > > > > > > >  <TASK>
> > > > > > > >  ? show_regs+0x68/0x70
> > > > > > > >  ? __die_body+0x20/0x70
> > > > > > > >  ? __die+0x2b/0x40
> > > > > > > >  ? page_fault_oops+0x160/0x480
> > > > > > > >  ? search_bpf_extables+0x63/0x90
> > > > > > > >  ? ioread32+0x2e/0x70
> > > > > > > >  ? search_exception_tables+0x5f/0x70
> > > > > > > >  ? kernelmode_fixup_or_oops+0xa2/0x120
> > > > > > > >  ? __bad_area_nosemaphore+0x179/0x230
> > > > > > > >  ? bad_area_nosemaphore+0x16/0x20
> > > > > > > >  ? do_kern_addr_fault+0x8b/0xa0
> > > > > > > >  ? exc_page_fault+0xe5/0x180
> > > > > > > >  ? asm_exc_page_fault+0x27/0x30
> > > > > > > >  ? ioread32+0x2e/0x70
> > > > > > > >  ? rtsx_pci_write_register+0x5b/0x90 [rtsx_pci]
> > > > > > > >  rtsx_set_l1off_sub+0x1c/0x30 [rtsx_pci]
> > > > > > > >  rts5261_set_l1off_cfg_sub_d0+0x36/0x40 [rtsx_pci]
> > > > > > > >  rtsx_pci_runtime_idle+0xc7/0x160 [rtsx_pci]
> > > > > > > >  ? __pfx_pci_pm_runtime_idle+0x10/0x10
> > > > > > > >  pci_pm_runtime_idle+0x34/0x70
> > > > > > > >  rpm_idle+0xc4/0x2b0
> > > > > > > >  pm_runtime_work+0x93/0xc0
> > > > > > > >  process_one_work+0x21a/0x430
> > > > > > > >  worker_thread+0x4a/0x3c0
> > > > > > > ...
> > > > > >
> > > > > > > > This happens because scheduled pm_runtime_idle() is not
> > cancelled.
> > > > > > >
> > > > > > > But rpm_resume() changes dev->power.request to RPM_REQ_NONE
> > and if
> > > > > > > pm_runtime_work() sees this, it will not run rpm_idle().
> > > > > > >
> > > > > > > However, rpm_resume() doesn't deactivate the autosuspend time=
r if
> > it
> > > > > > > is running (see the comment in rpm_resume() regarding this), =
so it
> > may
> > > > > > > queue up a runtime PM work later.
> > > > > > >
> > > > > > > If this is not desirable, you need to stop the autosuspend ti=
mer
> > > > > > > explicitly in addition to calling pm_runtime_get_sync().
> > > > > >
> > > > > > I don't quite follow all this.  I think the race is between
> > > > > > rtsx_pci_remove() (not resume) and rtsx_pci_runtime_idle().
> > > > >
> > > > > I think so too and the latter is not expected to run.
> > > > >
> > > > > >   rtsx_pci_remove()
> > > > > >   {
> > > > > >     pm_runtime_get_sync()
> > > > > >     pm_runtime_forbid()
> > > > > >     ...
> > > > > >
> > > > > > If this is an rtsx bug, what exactly should be added to
> > > > > > rtsx_pci_remove()?
> > > > > >
> > > > > > Is there ever a case where we want any runtime PM work to happe=
n
> > > > > > during or after a driver .remove()?  If not, maybe the driver c=
ore
> > > > > > should prevent that, which I think is basically what this patch=
 does.
> > > > >
> > > > > No, it is not, because it doesn't actually prevent the race from
> > > > > occurring, it just narrows the window quite a bit.
> > > > >
> > > > > It would be better to call pm_runtime_dont_use_autosuspend() inst=
ead
> > > > > of pm_runtime_barrier().
> > > > >
> > > > > > If this is an rtsx driver bug, I'm concerned there may be many =
other
> > > > > > drivers with a similar issue.  rtsx exercises this path more th=
an most
> > > > > > because the device switches between card reader and NVMe SSD us=
ing
> > > > > > hotplug add/remove based on whether an SD card is inserted (see=
 [1]).
> > > > >
> > > > > This is a valid concern, so it is mostly a matter of where to dis=
able
> > > > > autosuspend.
> > > > >
> > > > > It may be the driver core in principle, but note that it calls
> > > > > ->remove() after invoking pm_runtime_put_sync(), so why would it
> > > > > disable autosuspend when it allows runtime PM to race with device
> > > > > removal in general?
> > > > >
> > > > > Another way might be to add a pm_runtime_dont_use_autosuspend()
> > call
> > > > > at the beginning of pci_device_remove().
> > > > >
> > > > > Or just remove the optimization in question from rpm_resume() whi=
ch is
> > > > > quite confusing and causes people to make assumptions that lead t=
o
> > > > > incorrect behavior in this particular case.
> > > >
> > > > Well, scratch this.
> > > >
> > > > If rpm_idle() is already running at the time rpm_resume() is called=
,
> > > > the latter may return right away without waiting, which is incorrec=
t.
> > > >
> > > > rpm_resume() needs to wait for the "idle" callback to complete, so
> > > > this (again, modulo GMail-induced whitespace mangling) should help:
> > > >
> > > > ---
> > > >  drivers/base/power/runtime.c |    6 ++++--
> > > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > >
> > > > Index: linux-pm/drivers/base/power/runtime.c
> > > >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =3D=3D=3D
> > > > --- linux-pm.orig/drivers/base/power/runtime.c
> > > > +++ linux-pm/drivers/base/power/runtime.c
> > > > @@ -798,7 +798,8 @@ static int rpm_resume(struct device *dev
> > > >      }
> > > >
> > > >      if (dev->power.runtime_status =3D=3D RPM_RESUMING ||
> > > > -        dev->power.runtime_status =3D=3D RPM_SUSPENDING) {
> > > > +        dev->power.runtime_status =3D=3D RPM_SUSPENDING ||
> > > > +        dev->power.idle_notification) {
> > > >          DEFINE_WAIT(wait);
> > > >
> > > >          if (rpmflags & (RPM_ASYNC | RPM_NOWAIT)) {
> > > > @@ -826,7 +827,8 @@ static int rpm_resume(struct device *dev
> > > >              prepare_to_wait(&dev->power.wait_queue, &wait,
> > > >                      TASK_UNINTERRUPTIBLE);
> > > >              if (dev->power.runtime_status !=3D RPM_RESUMING &&
> > > > -                dev->power.runtime_status !=3D RPM_SUSPENDING)
> > > > +                dev->power.runtime_status !=3D RPM_SUSPENDING &&
> > > > +                !dev->power.idle_notification)
> > > >                  break;
> > > >
> > > >              spin_unlock_irq(&dev->power.lock);
> > >
> > > Well, not really.
> > >
> > > The problem is that rtsx_pci_runtime_idle() is not expected to be
> > > running after pm_runtime_get_sync(), but the latter doesn't really
> > > guarantee that.  It only guarantees that the suspend/resume callbacks
> > > will not be running after it returns.
> > >
> > > As I said above, if the ->runtime_idle() callback is already running
> > > when pm_runtime_get_sync() runs, the latter will notice that the
> > > status is RPM_ACTIVE and will return right away without waiting for
> > > the former to complete.  In fact, it cannot wait for it to complete,
> > > because it may be called from a ->runtime_idle() callback itself (it
> > > arguably does not make much sense to do that, but it is not strictly
> > > forbidden).
> > >
> > > So whoever is providing a ->runtime_idle() callback, they need to
> > > protect it from running in parallel with whatever code runs after
> > > pm_runtime_get_sync().  Note that ->runtime_idle() will not start
> > > after pm_runtime_get_sync(), but it may continue running then if it
> > > has started earlier already.
> > >
> > > Calling pm_runtime_barrier() after pm_runtime_get_sync() (not before
> > > it) should suffice, but once the runtime PM usage counter is dropped,
> > > rpm_idle() may run again, so this is only effective until the usage
> > > counter is greater than 1.  This means that
> > > __device_release_driver(() is not the right place to call it, because
> > > the usage counter is dropped before calling device_remove() in that
> > > case.
> > >
> > > The PCI bus type can prevent the race between driver-provided
> > > ->runtime_idle() and ->remove() from occurring by adding a
> > > pm_runtime_probe() call in the following way:
> >
> > s/pm_runtime_probe/pm_runtime_barrier/ (sorry)
> >
> > The patchlet below is correct, though.
> >
>
> I tested this patch it work and well...
> Tested-by: Ricky Wu <ricky_wu@realtek.com>

Thank you!

I will resend it with a proper changelog.

