Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5DEC7A15C9
	for <lists+linux-pci@lfdr.de>; Fri, 15 Sep 2023 07:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbjIOF6O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Sep 2023 01:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbjIOF6N (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Sep 2023 01:58:13 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F9619A6
        for <linux-pci@vger.kernel.org>; Thu, 14 Sep 2023 22:58:06 -0700 (PDT)
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 56A683F656
        for <linux-pci@vger.kernel.org>; Fri, 15 Sep 2023 05:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1694757485;
        bh=G7gSDZoI4sEqH2VruW2vcuYSTgnnacSUGs/AzU3emLo=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=u9KaS3UiOPi2GaVQQG3FXo4z/5cacdXDdzqZjivoYHdujxLgRSrlJrh9cZUgmpkJ8
         d8wQlA4ebxx42bmIxqdqyxAa5jExL9Ut0VURErTzQ46gsaCcda5BvCTE9rg3VNZDXV
         azAEs4SCy5LQdnOYnH8LA+7HaKE1cqtnlU7O0GO8sFeGJtPYtdUWNxW6ShH6PeQzKZ
         K9a6lbUsnykruTT1TkZnahP1MJV1lkaheMcAFvO9e9KJ8hwIMHEYRvA+rHwxuz07Gi
         SGWTZ56ZQuqV8X9ZXcooCVi2c7+6CEhvLjnbB5OUj9Z8gzwnFoSwreo5OI3OFTKOhv
         E8ZbzcRLcEqpw==
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-273983789adso1521942a91.0
        for <linux-pci@vger.kernel.org>; Thu, 14 Sep 2023 22:58:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694757483; x=1695362283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G7gSDZoI4sEqH2VruW2vcuYSTgnnacSUGs/AzU3emLo=;
        b=IGSJ/eU18WhqMR4ikT90qy6XHFLtS1+GmS2m3AotuGv6//CvQYeJ4DddqgSPGOoJHA
         k57WQhJprpqZryjXYB29Q2rZCButX+7OSnQiWgrsBFrM+lgZK5kZBn1nF7JjglIILG9M
         AiJRFQcN16O8AJv2SfQ2DkVzPMhUXWgpwy23jfA8sfdvJjP+CTNQzqV4dN54bpd5sH3l
         al/S7Il35V96HZZHBKtDoZZ6uB2dWiLCVDmkQX5EMlZgHkE1UoGmLtR/rOn8DEPp67qR
         q/X1akyurzcXr9EF3yrTF/uNiW81vd7/5pVD01CXbTZSwb+vX/kcK0+ysCbvkmrLtAth
         sj8Q==
X-Gm-Message-State: AOJu0YwlmFu9hdhY8MQPV2/gbSNo14+muoroQre8K4AO/wk4r7MPJZKX
        o4e0xncEJzAoFZpes7wxcgARvacMg0r6WtyHFGakwMOvXSJ0LqkgCLQdJjgUM/OtYe9xKh8kIeg
        ULDuqzbXKucJqMSvlWQuHW8TcbJx/z0pxi+eQzSlpgsjRppc7un6wtw==
X-Received: by 2002:a17:90a:fc89:b0:268:b0b:a084 with SMTP id ci9-20020a17090afc8900b002680b0ba084mr521085pjb.46.1694757483489;
        Thu, 14 Sep 2023 22:58:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXAyS32h8VDw2UAqI2lPwt1s3JNBSwGSKvt79p6I3Se6AjB/ygKexGUaXsMp2W5pWSlawyXZF1gagjRK9nKpg=
X-Received: by 2002:a17:90a:fc89:b0:268:b0b:a084 with SMTP id
 ci9-20020a17090afc8900b002680b0ba084mr521077pjb.46.1694757483114; Thu, 14 Sep
 2023 22:58:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230914041806.816741-1-kai.heng.feng@canonical.com> <20230914184249.GA74069@bhelgaas>
In-Reply-To: <20230914184249.GA74069@bhelgaas>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Fri, 15 Sep 2023 13:57:50 +0800
Message-ID: <CAAd53p4=oLYiH2YbVSmrPNj1zpMcfp=Wxbasb5vhMXOWCArLCg@mail.gmail.com>
Subject: Re: [PATCH] HID: intel-ish-hid: ipc: Rework EHL OOB wakeup
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     srinivas.pandruvada@linux.intel.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com, linux-pm@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Jian Hui Lee <jianhui.lee@canonical.com>,
        Even Xu <even.xu@intel.com>, Zhang Lixu <lixu.zhang@intel.com>,
        Najumon Ba <najumon.ba@intel.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 15, 2023 at 2:42=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Thu, Sep 14, 2023 at 12:18:05PM +0800, Kai-Heng Feng wrote:
> > System cannot suspend more than 255 times because the driver doesn't
> > have corresponding acpi_disable_gpe() for acpi_enable_gpe(), so the GPE
> > refcount overflows.
>
> How can a user know they are seeing this problem?  Is there a public
> bug report for it?

Here's the error when it happens:
[46307.532037] intel_ish_ipc 0000:00:1d.0: enable ose_gpe failed

The ticket was filed privately.

>
> > Since PCI core and ACPI core already handles PCI PME wake and GPE wake
> > when the device has wakeup capability, use device_init_wakeup() to let
> > them do the wakeup setting work.
> >
> > Also add a shutdown callback which uses pci_prepare_to_sleep() to let
> > PCI and ACPI set OOB wakeup for S5.
>
> Is this logically required to be part of this patch, or could it be a
> separate patch?

Because that's what 2e23a70edabe ("HID: intel-ish-hid: ipc: finish
power flow for EHL OOB") intended to do, to enable wakeup from S5.

>
> > Fixes: 2e23a70edabe ("HID: intel-ish-hid: ipc: finish power flow for EH=
L OOB")
> > Cc: Jian Hui Lee <jianhui.lee@canonical.com>
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> >  drivers/hid/intel-ish-hid/ipc/pci-ish.c | 59 +++++++------------------
> >  1 file changed, 15 insertions(+), 44 deletions(-)
> >
> > diff --git a/drivers/hid/intel-ish-hid/ipc/pci-ish.c b/drivers/hid/inte=
l-ish-hid/ipc/pci-ish.c
> > index 55cb25038e63..65e7eeb2fa64 100644
> > --- a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> > +++ b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> > @@ -119,42 +119,6 @@ static inline bool ish_should_leave_d0i3(struct pc=
i_dev *pdev)
> >       return !pm_resume_via_firmware() || pdev->device =3D=3D CHV_DEVIC=
E_ID;
> >  }
> >
> > -static int enable_gpe(struct device *dev)
> > -{
> > -#ifdef CONFIG_ACPI
> > -     acpi_status acpi_sts;
> > -     struct acpi_device *adev;
> > -     struct acpi_device_wakeup *wakeup;
> > -
> > -     adev =3D ACPI_COMPANION(dev);
> > -     if (!adev) {
> > -             dev_err(dev, "get acpi handle failed\n");
> > -             return -ENODEV;
> > -     }
> > -     wakeup =3D &adev->wakeup;
> > -
> > -     acpi_sts =3D acpi_enable_gpe(wakeup->gpe_device, wakeup->gpe_numb=
er);
> > -     if (ACPI_FAILURE(acpi_sts)) {
> > -             dev_err(dev, "enable ose_gpe failed\n");
> > -             return -EIO;
> > -     }
> > -
> > -     return 0;
> > -#else
> > -     return -ENODEV;
> > -#endif
> > -}
> > -
> > -static void enable_pme_wake(struct pci_dev *pdev)
> > -{
> > -     if ((pci_pme_capable(pdev, PCI_D0) ||
> > -          pci_pme_capable(pdev, PCI_D3hot) ||
> > -          pci_pme_capable(pdev, PCI_D3cold)) && !enable_gpe(&pdev->dev=
)) {
> > -             pci_pme_active(pdev, true);
> > -             dev_dbg(&pdev->dev, "ish ipc driver pme wake enabled\n");
> > -     }
> > -}
>
> I LOVE the removal of all this code.  Thanks for doing it!

Thanks :)

>
> >  /**
> >   * ish_probe() - PCI driver probe callback
> >   * @pdev:    pci device
> > @@ -225,7 +189,7 @@ static int ish_probe(struct pci_dev *pdev, const st=
ruct pci_device_id *ent)
> >
> >       /* Enable PME for EHL */
> >       if (pdev->device =3D=3D EHL_Ax_DEVICE_ID)
> > -             enable_pme_wake(pdev);
> > +             device_init_wakeup(dev, true);
> >
> >       ret =3D ish_init(ishtp);
> >       if (ret)
> > @@ -248,6 +212,19 @@ static void ish_remove(struct pci_dev *pdev)
> >       ish_device_disable(ishtp_dev);
> >  }
> >
> > +
> > +/**
> > + * ish_shutdown() - PCI driver shutdown callback
> > + * @pdev:    pci device
> > + *
> > + * This function sets up wakeup for S5
> > + */
> > +static void ish_shutdown(struct pci_dev *pdev)
> > +{
> > +     if (pdev->device =3D=3D EHL_Ax_DEVICE_ID)
> > +             pci_prepare_to_sleep(pdev);
>
> There are only five drivers that use pci_prepare_to_sleep(), so I have
> to ask what is special about this device that makes it necessary here?

The idea is that use pci_enable_wake() and pci_set_power_state() in
pci_prepare_to_sleep() to support S5 wakeup, by replacing the original
enable_pme_wake().

>
> It doesn't seem to match any of the scenarios mentioned in
> Documentation/power/pci.rst for using pci_prepare_to_sleep().
>
> Previously EHL_Ax_DEVICE_ID was used only in ish_probe(),
> ish_resume(), and _dma_no_cache_snooping().  None of those look like
> this, so this *looks* like new functionality that could/should be in a
> separate patch.

Because it's for S5 wakeup, so it's not a new functionality.

Kai-Heng

>
> > +}
> > +
> >  static struct device __maybe_unused *ish_resume_device;
> >
> >  /* 50ms to get resume response */
> > @@ -370,13 +347,6 @@ static int __maybe_unused ish_resume(struct device=
 *device)
> >       struct pci_dev *pdev =3D to_pci_dev(device);
> >       struct ishtp_device *dev =3D pci_get_drvdata(pdev);
> >
> > -     /* add this to finish power flow for EHL */
> > -     if (dev->pdev->device =3D=3D EHL_Ax_DEVICE_ID) {
> > -             pci_set_power_state(pdev, PCI_D0);
> > -             enable_pme_wake(pdev);
> > -             dev_dbg(dev->devc, "set power state to D0 for ehl\n");
> > -     }
> > -
> >       ish_resume_device =3D device;
> >       dev->resume_flag =3D 1;
> >
> > @@ -392,6 +362,7 @@ static struct pci_driver ish_driver =3D {
> >       .id_table =3D ish_pci_tbl,
> >       .probe =3D ish_probe,
> >       .remove =3D ish_remove,
> > +     .shutdown =3D ish_shutdown,
> >       .driver.pm =3D &ish_pm_ops,
> >  };
> >
> > --
> > 2.34.1
> >
