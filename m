Return-Path: <linux-pci+bounces-13064-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B345D975F84
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2024 05:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00D2AB24ABA
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2024 03:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3700126BEF;
	Thu, 12 Sep 2024 03:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="VOfLx4Vx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96ED37703
	for <linux-pci@vger.kernel.org>; Thu, 12 Sep 2024 03:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726110061; cv=none; b=SxIUBMx5nxqFdu4TMtWpLdcI9GiwldcLrCnPokSVoqNFZ9gQv0zs+d6GqkjdLUhQWksMLW9xMOQC6joA9JzS/D4LujXsi1U0x//ou3Aw8rn9M7+C/uBqGN3+hYzWDmpytTl8o0G8gOZIRNRrWUr2+T6CR0n0jVab41s4ljBq56M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726110061; c=relaxed/simple;
	bh=Vg0odeBMHpgtKhX8NR4LCSnyU5789G2srGCsELN6ZwU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=knfCFhI42gAqRDLSpRhd0Mcq7SFav/eG6R/Qwyc+DrCNfxeES8vXq0TArbXWFRBNfiP3ByiONmgYMo5WB/5pqBkVrnosdrO+RnpGm/pVPM3WGCzX57wBPZOzqECh+zwzbI29suq8qpUFpBqS5a4KPJcfcfcnzwjUoag+YZ5m5g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=VOfLx4Vx; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id F3A0D3F637
	for <linux-pci@vger.kernel.org>; Thu, 12 Sep 2024 03:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1726110057;
	bh=nxAKAHN4ulQFF60B5qp2xJnEkFmB45s9ou21KSZ6DT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=VOfLx4VxXNGRH2uv98JBGI1QKVQ2aPJUFCXqUMzvb0ktaxfEmJm1jf3JE7HsJscB2
	 KJQfeTkCFUxZM0xL6y/ulFPO1z5H4zp+N/wwhohkT3dyIpiYcu24Y5nJGTIPcGWP8D
	 0j2geJ/ySbSCb635Muzhq5gE72mxJ4wOza8cadIiDcvGBGpsKJgkGmbFVXtF/1InPF
	 O0ewEPolyt43rb73skPR7hhBROOEmC3vMPARfWq1yGtiFRXfbvYH5e7GJVncV20Byz
	 j8N+lKXgRe35I0YQL5D4kvu8SPNiW6WR9SaNgcfvtoRFc6GIMNo0U1syP2NNiUZt38
	 WX1dWCENfy2tg==
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5c24b4a57b4so266270a12.2
        for <linux-pci@vger.kernel.org>; Wed, 11 Sep 2024 20:00:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726110056; x=1726714856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nxAKAHN4ulQFF60B5qp2xJnEkFmB45s9ou21KSZ6DT8=;
        b=EmKK37FJZJng3Lo91Kbi47LPcjyj1ZWUI8Yh3MZa//SVkxvyQpNzDXz8iTKPbE36WI
         RnS6K620k+6V7tmYv8DwZZeZOhzdlgU0zxqs9907FgCKh49IgteIR4DuaJggSAwyXhau
         AVkj/qynuGD0HwzAVzVSjnIcngfo4fVn6ukUavGsqdgo9FgO2ydFe7NFvpgCUaD0HMw4
         WZcN0ftDw4JY14gQp7HH2Ujkgsh2/bKxv7LEm9Hg3MFpWzq0qkp1AR8jxIWp3ugq/Wku
         KqyRXGxf8avW74o2GKK1++XDPDGgdjNfxbHJ+6ga7F8dU4zjgXyP/lqigeX+PdrIEdp0
         DWTg==
X-Forwarded-Encrypted: i=1; AJvYcCVaD6bklcLKjl+xYXdcC2p6uyKmhmYLbe6I2rCuCfkdP7cVNB34eWB3IsApowN/0DDhHpnX8yd9+XU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9cSeSS3AN8a35iK1rQy4E3AGVz59LN73IAZHBNbJkwRn9IvsM
	XJQUbBnSwLQjl4eEiNkKISXv3Uv6p6URbuoHv4//cxYf5W7sKd4RUAjgK3JprV5t+xBtqoiAG3W
	HwAtNAxp3qDqcQbXMUNL3i+aXLCwIuzXl8I6T+uMAQ/n/2ApFUcEHqnLnrzgl7jnfBd98pEAtrp
	NYWciX1CmlMtqcqnbYTprUBxq++qWZrLi+ccEVMn5nteeUSkqT
X-Received: by 2002:a05:6402:2551:b0:5c4:1372:c1ee with SMTP id 4fb4d7f45d1cf-5c413e085eamr1054651a12.4.1726110056257;
        Wed, 11 Sep 2024 20:00:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHObdhdH1kylUh+cnsfLE2FnMRLgHzmKi6VYXrNEML58hz+m9YTNmCXyQHMYbrGa2cNfNJrXGeH/I45eJ+lA6g=
X-Received: by 2002:a05:6402:2551:b0:5c4:1372:c1ee with SMTP id
 4fb4d7f45d1cf-5c413e085eamr1054640a12.4.1726110055775; Wed, 11 Sep 2024
 20:00:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240712062411.35732-1-kai.heng.feng@canonical.com> <20240911190516.GA644336@bhelgaas>
In-Reply-To: <20240911190516.GA644336@bhelgaas>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Thu, 12 Sep 2024 11:00:43 +0800
Message-ID: <CAAd53p7vP8TcPj=u5TTuPMXFaWW15hwpJdECCprvXGBhigKD6Q@mail.gmail.com>
Subject: Re: [PATCH] PCI/PM: Put devices to low power state on shutdown
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, mario.limonciello@amd.com, 
	mika.westerberg@linux.intel.com, linux-pci@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, kaihengfeng@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bjorn,

On Thu, Sep 12, 2024 at 3:05=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Fri, Jul 12, 2024 at 02:24:11PM +0800, Kai-Heng Feng wrote:
> > Some laptops wake up after poweroff when HP Thunderbolt Dock G4 is
> > connected.
> >
> > The following error message can be found during shutdown:
> > pcieport 0000:00:1d.0: AER: Correctable error message received from 000=
0:09:04.0
> > pcieport 0000:09:04.0: PCIe Bus Error: severity=3DCorrectable, type=3DD=
ata Link Layer, (Receiver ID)
> > pcieport 0000:09:04.0:   device [8086:0b26] error status/mask=3D0000008=
0/00002000
> > pcieport 0000:09:04.0:    [ 7] BadDLLP
> >
> > Calling aer_remove() during shutdown can quiesce the error message,
> > however the spurious wakeup still happens.
> >
> > The issue won't happen if the device is in D3 before system shutdown, s=
o
> > putting device to low power state before shutdown to solve the issue.
> >
> > I don't have a sniffer so this is purely guesswork, however I believe
> > putting device to low power state it's the right thing to do.
>
> My objection here is that we don't have an explanation of why this
> should matter or a pointer to any spec language about this situation,
> so it feels a little bit random.

I have the same feeling too. The PCIe spec doesn't specify what's the
correct power state for shutdown.
So we can only "logically" think the software should put devices to
low power state during shutdown.

>
> I suppose the problem wouldn't happen if AER interrupts were disabled?
> We already do disable them in aer_suspend(), but maybe that's not used
> in the shutdown path?

That was my first thought, so I modified pcie_port_shutdown_service()
to disable AER interrupt.
That approach didn't work though.

>
> My understanding is that .shutdown() should turn off device interrupts
> and stop DMA.  So maybe we need an aer_shutdown() that disables
> interrupts?

Logically we should do that. However that approach doesn't solve this issue=
.

>
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D219036
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> >  drivers/pci/pci-driver.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> > index af2996d0d17f..4c6f66f3eb54 100644
> > --- a/drivers/pci/pci-driver.c
> > +++ b/drivers/pci/pci-driver.c
> > @@ -510,6 +510,14 @@ static void pci_device_shutdown(struct device *dev=
)
> >       if (drv && drv->shutdown)
> >               drv->shutdown(pci_dev);
> >
> > +     /*
> > +      * If driver already changed device's power state, it can mean th=
e
> > +      * wakeup setting is in place, or a workaround is used. Hence kee=
p it
> > +      * as is.
> > +      */
> > +     if (!kexec_in_progress && pci_dev->current_state =3D=3D PCI_D0)
> > +             pci_prepare_to_sleep(pci_dev);
> > +
> >       /*
> >        * If this is a kexec reboot, turn off Bus Master bit on the
> >        * device to tell it to not continue to do DMA. Don't touch
> > --
> > 2.43.0
> >

