Return-Path: <linux-pci+bounces-601-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC07807EDB
	for <lists+linux-pci@lfdr.de>; Thu,  7 Dec 2023 03:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE2241C211D4
	for <lists+linux-pci@lfdr.de>; Thu,  7 Dec 2023 02:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E650A62D;
	Thu,  7 Dec 2023 02:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="IX96ERYa"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FDB6D4B
	for <linux-pci@vger.kernel.org>; Wed,  6 Dec 2023 18:45:04 -0800 (PST)
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 85D343FA54
	for <linux-pci@vger.kernel.org>; Thu,  7 Dec 2023 02:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1701917100;
	bh=a0FiCBQ5zRlPvqo0KD1dys1aMCjFnIg1vx4iclYQmRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=IX96ERYa5NqOch6Isax4xPnh1vPTM1mpRReV8I+1krmeTdT+ToQRqeiQzUAsrRSfh
	 x924clIOf4uYzNa3+lnDOBmvZexh5vZGDCDr1+3M/s/aSag9cSN7Q0yabNVx4QL2sf
	 qfLePSS1HV9wj9r+STE1V3NwhAhTmHpN55P6eZPEVAOfseEmySPdkyt7yEM+O2Th7e
	 J4/HX3sUOamOjT9A5YIRd0B9Aa1IW2wQ/yp5S8FXoUZb6cmAwIYfi9yMNye1AAW2Ol
	 iKDzzKzFjkJMi4QbKtvMzbr48JbENGe31kec95LuHdiqA7EIlZc41K4Hf/sm/8bB1W
	 TMCSibyFJjqSg==
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5c627dd2accso232393a12.0
        for <linux-pci@vger.kernel.org>; Wed, 06 Dec 2023 18:45:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701917099; x=1702521899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a0FiCBQ5zRlPvqo0KD1dys1aMCjFnIg1vx4iclYQmRk=;
        b=wRkgrvpMmCjkBjpdH5tvNUyz8Ekf0OHzjCnhujAX5p6X6th3is8l3ROvZ5A1gmx6sZ
         j09nNEvkPDBOvV2qjNLuDHgdOWTb2E2PZEpMyst3dPTwHNjB706wwR71vxdBJsFW1BEG
         x3kh8NlT6IjtJe62zH1gkXQy19QffqcBO4RGzd1Et5wb5SZJRRRgbdotxaOTNM2DZuq2
         2rUNNq5CO1KppMoxmW+fPekzJgH1A/OkM/+1y+z2LTNMT6ThtXzn2TkDxbvP+JNPW4D9
         vy6jen3mTtdZ+4SYvm/SV7oC9NzVeJ4ZLtloiSNyD2UBNqL4WSJR+NnNjk8QOiaT35I0
         M/sQ==
X-Gm-Message-State: AOJu0Yw9ATd4m5kGMyEGwq6HB/SzYRVt1MsjzOsWWsG8N99icPm8K4l8
	XPYBkM83Qz8Ep/WdJbrcgda3YcXqYDSK39tRQ5eonhlfZGiDsQsFUQDzQHYWHKhm3c1JCMzVuc2
	wdrcX44MyAbuSJbbgZ8ljo7dR0JT5m/n3WQph5gsoMRVkVgL0VxKvgQ==
X-Received: by 2002:a05:6a21:188:b0:187:a581:cc4e with SMTP id le8-20020a056a21018800b00187a581cc4emr1937413pzb.29.1701917099022;
        Wed, 06 Dec 2023 18:44:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGJuq6Px8ETG4vq115qTLsAI+oHErFQds0ZcKptoR6sQ0x3lkYVrsYu9YAZ9p9nPIFyjh313U5hVSE+M4UX2Q8=
X-Received: by 2002:a05:6a21:188:b0:187:a581:cc4e with SMTP id
 le8-20020a056a21018800b00187a581cc4emr1937404pzb.29.1701917098657; Wed, 06
 Dec 2023 18:44:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231108121940.288005-1-kai.heng.feng@canonical.com> <cc6c162407c69c53ec256bf887a0384361dd0516.camel@linux.intel.com>
In-Reply-To: <cc6c162407c69c53ec256bf887a0384361dd0516.camel@linux.intel.com>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Thu, 7 Dec 2023 10:44:47 +0800
Message-ID: <CAAd53p7do2rrB=qbpWKbNCWB_qfZ2YZPtB_55VcfGjDYXgLfzA@mail.gmail.com>
Subject: Re: [PATCH v2] HID: intel-ish-hid: ipc: Rework EHL OOB wakeup
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: jikos@kernel.org, benjamin.tissoires@redhat.com, linux-pm@vger.kernel.org, 
	linux-pci@vger.kernel.org, Jian Hui Lee <jianhui.lee@canonical.com>, 
	Even Xu <even.xu@intel.com>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023 at 1:50=E2=80=AFAM srinivas pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> Hi Kai,
>
> Sorry for he delay in getting back on this. I have a question below:
>
> On Wed, 2023-11-08 at 14:19 +0200, Kai-Heng Feng wrote:
> > Since PCI core and ACPI core already handles PCI PME wake and GPE
> > wake
> > when the device has wakeup capability, use device_init_wakeup() to
> > let
> > them do the wakeup setting work.
> >
> > Also add a shutdown callback which uses pci_prepare_to_sleep() to let
> > PCI and ACPI set OOB wakeup for S5.
> >
> > Cc: Jian Hui Lee <jianhui.lee@canonical.com>
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> > v2:
> >  Rebase on ("HID: intel-ish-hid: ipc: Disable and reenable ACPI GPE
> > bit")
> >
> >  drivers/hid/intel-ish-hid/ipc/pci-ish.c | 67 ++++++-----------------
> > --
> >  1 file changed, 15 insertions(+), 52 deletions(-)
> >
> > diff --git a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> > b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> > index 710fda5f19e1..65e7eeb2fa64 100644
> > --- a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> > +++ b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> > @@ -119,50 +119,6 @@ static inline bool ish_should_leave_d0i3(struct
> > pci_dev *pdev)
> >         return !pm_resume_via_firmware() || pdev->device =3D=3D
> > CHV_DEVICE_ID;
> >  }
> >
> > -static int enable_gpe(struct device *dev)
> > -{
> > -#ifdef CONFIG_ACPI
> > -       acpi_status acpi_sts;
> > -       struct acpi_device *adev;
> > -       struct acpi_device_wakeup *wakeup;
> > -
> > -       adev =3D ACPI_COMPANION(dev);
> > -       if (!adev) {
> > -               dev_err(dev, "get acpi handle failed\n");
> > -               return -ENODEV;
> > -       }
> > -       wakeup =3D &adev->wakeup;
> > -
> > -       /*
> > -        * Call acpi_disable_gpe(), so that reference count
> > -        * gpe_event_info->runtime_count doesn't overflow.
> > -        * When gpe_event_info->runtime_count =3D 0, the call
> > -        * to acpi_disable_gpe() simply return.
> > -        */
> > -       acpi_disable_gpe(wakeup->gpe_device, wakeup->gpe_number);
> > -
> > -       acpi_sts =3D acpi_enable_gpe(wakeup->gpe_device, wakeup-
> > >gpe_number);
> > -       if (ACPI_FAILURE(acpi_sts)) {
> > -               dev_err(dev, "enable ose_gpe failed\n");
> > -               return -EIO;
> > -       }
> > -
> > -       return 0;
> > -#else
> > -       return -ENODEV;
> > -#endif
> > -}
> > -
> > -static void enable_pme_wake(struct pci_dev *pdev)
> > -{
> > -       if ((pci_pme_capable(pdev, PCI_D0) ||
> > -            pci_pme_capable(pdev, PCI_D3hot) ||
> > -            pci_pme_capable(pdev, PCI_D3cold)) && !enable_gpe(&pdev-
> > >dev)) {
> > -               pci_pme_active(pdev, true);
> > -               dev_dbg(&pdev->dev, "ish ipc driver pme wake
> > enabled\n");
> > -       }
> > -}
> > -
> >  /**
> >   * ish_probe() - PCI driver probe callback
> >   * @pdev:      pci device
> > @@ -233,7 +189,7 @@ static int ish_probe(struct pci_dev *pdev, const
> > struct pci_device_id *ent)
> >
> >         /* Enable PME for EHL */
> >         if (pdev->device =3D=3D EHL_Ax_DEVICE_ID)
> > -               enable_pme_wake(pdev);
> > +               device_init_wakeup(dev, true);
>
> For apple to apple comparison, which path will call
> https://elixir.bootlin.com/linux/latest/C/ident/__pci_enable_wake
> which will call pci_pme_active()?

Here's the flow:
device_shutdown()
  pci_device_shutdown()
    ish_shutdown()
      pci_prepare_to_sleep()
        __pci_enable_wake()
          pci_pme_active()
            __pci_pme_active()

Kai-Heng

>
> Thanks,
> Srinivas
>
> >
> >         ret =3D ish_init(ishtp);
> >         if (ret)
> > @@ -256,6 +212,19 @@ static void ish_remove(struct pci_dev *pdev)
> >         ish_device_disable(ishtp_dev);
> >  }
> >
> > +
> > +/**
> > + * ish_shutdown() - PCI driver shutdown callback
> > + * @pdev:      pci device
> > + *
> > + * This function sets up wakeup for S5
> > + */
> > +static void ish_shutdown(struct pci_dev *pdev)
> > +{
> > +       if (pdev->device =3D=3D EHL_Ax_DEVICE_ID)
> > +               pci_prepare_to_sleep(pdev);
> > +}
> > +
> >  static struct device __maybe_unused *ish_resume_device;
> >
> >  /* 50ms to get resume response */
> > @@ -378,13 +347,6 @@ static int __maybe_unused ish_resume(struct
> > device *device)
> >         struct pci_dev *pdev =3D to_pci_dev(device);
> >         struct ishtp_device *dev =3D pci_get_drvdata(pdev);
> >
> > -       /* add this to finish power flow for EHL */
> > -       if (dev->pdev->device =3D=3D EHL_Ax_DEVICE_ID) {
> > -               pci_set_power_state(pdev, PCI_D0);
> > -               enable_pme_wake(pdev);
> > -               dev_dbg(dev->devc, "set power state to D0 for
> > ehl\n");
> > -       }
> > -
> >         ish_resume_device =3D device;
> >         dev->resume_flag =3D 1;
> >
> > @@ -400,6 +362,7 @@ static struct pci_driver ish_driver =3D {
> >         .id_table =3D ish_pci_tbl,
> >         .probe =3D ish_probe,
> >         .remove =3D ish_remove,
> > +       .shutdown =3D ish_shutdown,
> >         .driver.pm =3D &ish_pm_ops,
> >  };
> >
>

