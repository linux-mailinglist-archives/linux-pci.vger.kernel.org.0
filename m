Return-Path: <linux-pci+bounces-13142-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBEDB977893
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2024 08:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0335D1C24809
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2024 06:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B21154BF8;
	Fri, 13 Sep 2024 06:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hIjJfg2x"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7EB224CF;
	Fri, 13 Sep 2024 06:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726207273; cv=none; b=UEhJhQXpldZ3EHg0wDKjzalqKRtRbZfTDbRpicHt5sIqF0sHljL+5PDttDvE+pN1/jrPA+k06IxXXtiHkcSVz+kq+P/B39Ee79V0AaBBEulvPrkkq41oY2PzAz/rgPOMGvk+kgk1eXsay2QVKIR+/R/0LoV7NcnsS8pLJDZR6G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726207273; c=relaxed/simple;
	bh=UKTJL8QJVKUHaXVPprQd8Ccj4r2N8dFuERmRqaTGyWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gu9JjAPcEs+6wQiZKKjRC7+sgFFdMj6oAr/IlNsLV6vsgxevNYIuGlBFC8eQAslOVgMmFiM7P8Fryo3w8bWEp6eoTTf231sfpwlM+e/Tj7rEwTCVGBmseZqb/H/v4X5d4+OitRUAAFCwe7FN6S3GoHDHPf5wLZ7p7GdpuWdkSHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hIjJfg2x; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6dbc75acbfaso8053297b3.3;
        Thu, 12 Sep 2024 23:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726207271; x=1726812071; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZM8Uj8sLaGIlcFJ3VT7iOce+S8zFVD12AwSpx6lG7V8=;
        b=hIjJfg2xHqecmcHk5jey7RBNlIlDpNAX0YEQUchLDuQPv2sYkhyGp0h70XNlkUKL8W
         FDd2IPrShafSgoD/84DGkaGpuNbEiY1ZjYwh+KlnKjDEM25fK074Tzfh5oO7Q2lStQfd
         NlOw1uhmM4CeiQvyCHTM+hKZelBK2fkRG5tsrNjO3HFyZLzieGz2p+p6ie6UIpYVOESd
         f2dDiqcbjS27RFwEKEHTKEct8RzgOaf0HQEmFZvjNLnteXCpQbyyPnwxOKao5z5Lk7/3
         YmIu1QrGCRCJ4e0nltQSgbxuNEurifUWsp15xZ+VSsueObs99b38IYqo5paRHYL1IEPW
         FFxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726207271; x=1726812071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZM8Uj8sLaGIlcFJ3VT7iOce+S8zFVD12AwSpx6lG7V8=;
        b=Fj+ezZXrgxYMEajvKxuZaJtn3LAKN422/RaurH8uI+t8T2TBKA0MC1CJM3Z8Khk69j
         nZnPEHM+ECGQyjaUxNd42anQeA03vJlFBlyAJf9l3dHCv5nZNF+uxHc018IUD+4MVBdQ
         9Z1+AtSD9d0dF0VVIdNEqmumVPGaB2JLAxXI8ih3sfTLCGIerthBNG9CIrH4CY4Gp/it
         sn1ZelfNXifLmXC7bGoowprQR0xWL66LPByPgvqt+rDESaxoIQaw8r413DTa5z3N2+3l
         nmLEasclIJwzbQZwk9syutxtd9OxsLClfwDVp7NDm357xXbV3mQaWZB+279KztSIclco
         lkBg==
X-Forwarded-Encrypted: i=1; AJvYcCW3hFa7104mtfPHjO00bSOOTDCPcS7OEiCe/HafrcJCsFmF+B/Se4kC1yTCLUihafhPTZhiBvjoLO7sYwk=@vger.kernel.org, AJvYcCW7Q7o3xmIygeaXo7oRBxklBwmnq17quDsQei6a9UoS/n4a9nh0FXpNIxCWe7L6pvqlBFDjiN+jock=@vger.kernel.org, AJvYcCWV9OxkXCciW+GahkEDIGiDGJISz3FEV+bTUfFsDQqTCrzs9z1PTUDyWq1pGDtVV/0cZe6MTc/oqJRM@vger.kernel.org
X-Gm-Message-State: AOJu0YwoJhuDM0oLuNbg3Zu66s0lX9225OZ76NNVoqpHkuF45Dz8TwpQ
	C8+d+dQr/h4rj4L+RILptFAz3AARrOCm5WKgmwSLqKwqcI4MvFO5FA/N99d1eZNS7sBLWpaFl/F
	HwqkT0ZEXGGrt/EOzPZeLPHnYqos=
X-Google-Smtp-Source: AGHT+IH4R8hQhMCpHAxmyCvg8ImDuDIw6T2A4eopb6lQ0MEw8NQwhheKNIlYdZRf9WaMZikpGISj2ExMJ35/E9vEtV0=
X-Received: by 2002:a05:690c:6683:b0:6db:d572:aa7d with SMTP id
 00721157ae682-6dbd572ae48mr2131387b3.19.1726207270656; Thu, 12 Sep 2024
 23:01:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAd53p7vP8TcPj=u5TTuPMXFaWW15hwpJdECCprvXGBhigKD6Q@mail.gmail.com>
 <20240912165709.GA674430@bhelgaas>
In-Reply-To: <20240912165709.GA674430@bhelgaas>
From: Kai-Heng Feng <kaihengfeng@gmail.com>
Date: Fri, 13 Sep 2024 14:00:58 +0800
Message-ID: <CAMusMWqxi3s8sb+j0wV251kRj9R9-oqKQUqKscVTk_sktm2m5A@mail.gmail.com>
Subject: Re: [PATCH] PCI/PM: Put devices to low power state on shutdown
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, mario.limonciello@amd.com, 
	mika.westerberg@linux.intel.com, linux-pci@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2024 at 12:57=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org>=
 wrote:
>
> [+cc Rafael]
>
> On Thu, Sep 12, 2024 at 11:00:43AM +0800, Kai-Heng Feng wrote:
> > On Thu, Sep 12, 2024 at 3:05=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.o=
rg> wrote:
> > > On Fri, Jul 12, 2024 at 02:24:11PM +0800, Kai-Heng Feng wrote:
> > > > Some laptops wake up after poweroff when HP Thunderbolt Dock G4 is
> > > > connected.
> > > >
> > > > The following error message can be found during shutdown:
> > > > pcieport 0000:00:1d.0: AER: Correctable error message received from=
 0000:09:04.0
> > > > pcieport 0000:09:04.0: PCIe Bus Error: severity=3DCorrectable, type=
=3DData Link Layer, (Receiver ID)
> > > > pcieport 0000:09:04.0:   device [8086:0b26] error status/mask=3D000=
00080/00002000
> > > > pcieport 0000:09:04.0:    [ 7] BadDLLP
> > > >
> > > > Calling aer_remove() during shutdown can quiesce the error message,
> > > > however the spurious wakeup still happens.
> > > >
> > > > The issue won't happen if the device is in D3 before system shutdow=
n, so
> > > > putting device to low power state before shutdown to solve the issu=
e.
> > > >
> > > > I don't have a sniffer so this is purely guesswork, however I belie=
ve
> > > > putting device to low power state it's the right thing to do.
> > >
> > > My objection here is that we don't have an explanation of why this
> > > should matter or a pointer to any spec language about this situation,
> > > so it feels a little bit random.
> >
> > I have the same feeling too. The PCIe spec doesn't specify what's the
> > correct power state for shutdown.
> > So we can only "logically" think the software should put devices to
> > low power state during shutdown.
> >
> > > I suppose the problem wouldn't happen if AER interrupts were disabled=
?
> > > We already do disable them in aer_suspend(), but maybe that's not use=
d
> > > in the shutdown path?
> >
> > That was my first thought, so I modified pcie_port_shutdown_service()
> > to disable AER interrupt.
> > That approach didn't work though.
> >
> > > My understanding is that .shutdown() should turn off device interrupt=
s
> > > and stop DMA.  So maybe we need an aer_shutdown() that disables
> > > interrupts?
> >
> > Logically we should do that. However that approach doesn't solve this i=
ssue.
>
> I'm not completely clear on the semantics of the .shutdown()
> interface.  The doc at
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/i=
nclude/linux/device/driver.h?id=3Dv6.10#n73
> says "@shutdown: Called at shut-down time to quiesce the device"
>
> Turning off device interrupts and DMA *would* fit within the idea of
> quiescing the device.  Does that also include changing the device
> power state?  I dunno.  The power state isn't *mentioned* in the
> .shutdown() context, while it *is* mentioned for .suspend().

IMO putting a device to low power also qualifies as "quiesce the device".

>
> IIUC, this patch and commit log uses "shutdown" to refer to a
> system-wide *poweroff*, which is a different concept despite using the
> same "shutdown" name.

For ACPI based system, there are .suspend for S3/s2idle, .poweroff for
S4, and .shutdown for S5.
Unless we want to introduce a new callback for S5, I think the concept
is quite similar.

For DT based system, the OS should also perform the same thing, as
there's no firmware to cleanup the power state.

We can also move .shutdown to be part of pm_ops, but I don't think
it's necessary,

>
> So should the system poweroff procedure use .suspend()?  Should it use
> both .shutdown() and .suspend()?  I think it only uses .shutdown()
> today:
>
>   kernel_power_off
>     kernel_shutdown_prepare(SYSTEM_POWER_OFF)
>       device_shutdown
>         while (!list_empty(&devices_kset->list))
>           dev->bus->shutdown(dev)
>             pci_device_shutdown
>
> There are several driver .shutdown() methods that do things like this:
>
>   e1000_shutdown
>     if (system_state =3D=3D SYSTEM_POWER_OFF)
>       pci_set_power_state(pdev, PCI_D3hot)
>
> Maybe that's the right thing and should be done by the PCI core, which
> is similar to what you propose here.  But I think it muddies the
> definition of .shutdown() a bit by mixing in power management stuff.

Do you think adding a new "low power state" callback to be called
after .shutdown a good idea?
That would make the concept of .shutdown different to .suspend and
.poweroff. I personally see .suspend, .poweroff and .shutdown the same
action but target different power states.

Kai-Heng

>
> > > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D219036
> > > > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > > > ---
> > > >  drivers/pci/pci-driver.c | 8 ++++++++
> > > >  1 file changed, 8 insertions(+)
> > > >
> > > > diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> > > > index af2996d0d17f..4c6f66f3eb54 100644
> > > > --- a/drivers/pci/pci-driver.c
> > > > +++ b/drivers/pci/pci-driver.c
> > > > @@ -510,6 +510,14 @@ static void pci_device_shutdown(struct device =
*dev)
> > > >       if (drv && drv->shutdown)
> > > >               drv->shutdown(pci_dev);
> > > >
> > > > +     /*
> > > > +      * If driver already changed device's power state, it can mea=
n the
> > > > +      * wakeup setting is in place, or a workaround is used. Hence=
 keep it
> > > > +      * as is.
> > > > +      */
> > > > +     if (!kexec_in_progress && pci_dev->current_state =3D=3D PCI_D=
0)
> > > > +             pci_prepare_to_sleep(pci_dev);
> > > > +
> > > >       /*
> > > >        * If this is a kexec reboot, turn off Bus Master bit on the
> > > >        * device to tell it to not continue to do DMA. Don't touch
> > > > --
> > > > 2.43.0
> > > >

