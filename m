Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E66F47A3F25
	for <lists+linux-pci@lfdr.de>; Mon, 18 Sep 2023 03:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbjIRBR0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 17 Sep 2023 21:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235169AbjIRBR0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 17 Sep 2023 21:17:26 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10FD1128
        for <linux-pci@vger.kernel.org>; Sun, 17 Sep 2023 18:17:18 -0700 (PDT)
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0FBD43F13B
        for <linux-pci@vger.kernel.org>; Mon, 18 Sep 2023 01:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1694999836;
        bh=eaTKx3J1vilBDf/S3SS7BBAAYhcj6+Y8iTvJpOcU5qQ=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=uZav1LKfzMuIYyW9zmBs5rx1GHnWjTItYxeZt/XgaN4r7qIH6/ZlUV5T1ciTJ+pwS
         2tJowHUfZN5o3M8GBV0zh31WtRGGULjU4egg4DA4aeWrrbuSOom3g73mtaPWkYf0Gr
         06yDzWaZufAGxpSOoNItFC2kNUHuByhlh7IwPHzRo2V+RLRqXR/xNKf0lxEgduTVRm
         q9UwB7uXAfS0MhsBVncwaBCQwQq1Ts7h0IwwLnVM0R5jhOITHCVZ4f6RwKeqj4UNaC
         ww7qsxwjq5/O+1yE7i1FnvQYhnHWrZK5/0L2lUtFgGg6rFPXYLPAGmqI2Jiqs1yJdc
         Ig4LEfM7iyyEA==
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-577af72294bso2868862a12.2
        for <linux-pci@vger.kernel.org>; Sun, 17 Sep 2023 18:17:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694999834; x=1695604634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eaTKx3J1vilBDf/S3SS7BBAAYhcj6+Y8iTvJpOcU5qQ=;
        b=dkUTgkE/AKk+xQ/zfFq6+cbSIlwgY3jbUk1qQtZ5Bq+Mw+d7d/QW9GNRS22+6YucQX
         AX2HJhu0zmbShIQGLjq/mRs6fzD4HJBMaRb5HE5n6MTbtFENz3atN8nW4Xl4Hjh1L6sD
         MN1PRO30koW9hIn4U21OfKQrg/k4bXnfooy6snAlbqKwwdPaIYqE05mXbhxKmMFjOqiB
         pteu+Wk+FWtSNUJMi7DQCs/kZ0MD5YBoyyyE7bnrWYYyanuAzbKSPd4Ntl2eoyNZfE+2
         tR2I8r9Pn490FMWC+eg8Y+a94EQl5cdNyEDGl0Wi6/vw92opr9+GkshQcQw0vJdN7nl+
         2ihg==
X-Gm-Message-State: AOJu0Yxek6NTeLmF38cQycvYv/HLq9hqNQZrHOCyZzbRCEYoZM8X4OjQ
        dikcAVXfxrY1q+LMM7Z5D4OGx6OdU6QDfZuAQQ1Y761+LP7ma8bZwq9zkmG3OgOObfcQFG72+Nn
        L8aELbVO8zVqVCxaYm8BzApK8fv7CxEjORa+g4xCJfGoVcbQXV9XvZQ==
X-Received: by 2002:a05:6a20:7f99:b0:14e:3daf:bef9 with SMTP id d25-20020a056a207f9900b0014e3dafbef9mr8305787pzj.16.1694999834048;
        Sun, 17 Sep 2023 18:17:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9XdnkKx4bRdB+wJ/4jlxrMVittz8T67e6iHCVYSUjzE7q+Us1NpG9ZIlMtjSLihoG46Ki9C3MWeIx/gSTNQA=
X-Received: by 2002:a05:6a20:7f99:b0:14e:3daf:bef9 with SMTP id
 d25-20020a056a207f9900b0014e3dafbef9mr8305771pzj.16.1694999833732; Sun, 17
 Sep 2023 18:17:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230914041806.816741-1-kai.heng.feng@canonical.com>
 <7b45ac2ed091497b4e21a6a5c19956161175ba16.camel@linux.intel.com>
 <SN6PR11MB26245C44E84C37C1B551260EF4F6A@SN6PR11MB2624.namprd11.prod.outlook.com>
 <CAAd53p5ywMVKWzhn0nYzvBnW_Bc=sntgBttJdcVUuf_a4AnX5w@mail.gmail.com>
 <SN6PR11MB262473E2BF4057F4D285A613F4F6A@SN6PR11MB2624.namprd11.prod.outlook.com>
 <DM6PR11MB26184A8A3F955589F5FC6836F4FBA@DM6PR11MB2618.namprd11.prod.outlook.com>
In-Reply-To: <DM6PR11MB26184A8A3F955589F5FC6836F4FBA@DM6PR11MB2618.namprd11.prod.outlook.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Mon, 18 Sep 2023 09:17:00 +0800
Message-ID: <CAAd53p4o1pB-yzpvUCYsvuYEvQQK0my=u-ogrByRCx_Lvns=hw@mail.gmail.com>
Subject: Re: [PATCH] HID: intel-ish-hid: ipc: Rework EHL OOB wakeup
To:     "Xu, Even" <even.xu@intel.com>
Cc:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
        "jikos@kernel.org" <jikos@kernel.org>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Lee, Jian Hui" <jianhui.lee@canonical.com>,
        "Zhang, Lixu" <lixu.zhang@intel.com>,
        "Ba, Najumon" <najumon.ba@intel.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Even,

On Mon, Sep 18, 2023 at 8:33=E2=80=AFAM Xu, Even <even.xu@intel.com> wrote:
>
> Hi, Kai-Heng,
>
> I just got feedback, for testing EHL S5 wakeup feature, you need several =
steps to setup and access  "https://portal.devicewise.com/things/browse" to=
 trigger wake.
> But currently, our test account of this website are all out of data.
> So maybe you need double check with the team who required you preparing t=
he patch for the verification.

The patch is to solve the GPE refcount overflow, while maintaining S5
wakeup. I don't have any mean to test S5 wake.

So if you also don't have ways to verify S5 wake functionality, maybe
we can simply revert 2e23a70edabe  ("HID: intel-ish-hid: ipc: finish
power flow for EHL OOB") as alternative?

Kai-Heng

> Thanks!
>
> Best Regards,
> Even Xu
>
> -----Original Message-----
> From: Xu, Even
> Sent: Friday, September 15, 2023 3:27 PM
> To: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Cc: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>; jikos@kern=
el.org; benjamin.tissoires@redhat.com; linux-pm@vger.kernel.org; linux-pci@=
vger.kernel.org; Lee, Jian Hui <jianhui.lee@canonical.com>; Zhang, Lixu <Li=
xu.Zhang@intel.com>; Ba, Najumon <najumon.ba@intel.com>; linux-input@vger.k=
ernel.org; linux-kernel@vger.kernel.org
> Subject: RE: [PATCH] HID: intel-ish-hid: ipc: Rework EHL OOB wakeup
>
> Hi, Kai-Heng,
>
> I am also not familiar with this S5 wakeup test case.
> I already sent out mails to ask for help on it.
> Will come back to you once I get feedback.
> Thanks!
>
> Best Regards,
> Even Xu
>
> -----Original Message-----
> From: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Sent: Friday, September 15, 2023 2:01 PM
> To: Xu, Even <even.xu@intel.com>
> Cc: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>; jikos@kern=
el.org; benjamin.tissoires@redhat.com; linux-pm@vger.kernel.org; linux-pci@=
vger.kernel.org; Lee, Jian Hui <jianhui.lee@canonical.com>; Zhang, Lixu <li=
xu.zhang@intel.com>; Ba, Najumon <najumon.ba@intel.com>; linux-input@vger.k=
ernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] HID: intel-ish-hid: ipc: Rework EHL OOB wakeup
>
> Hi Even,
>
> On Fri, Sep 15, 2023 at 1:31=E2=80=AFPM Xu, Even <even.xu@intel.com> wrot=
e:
> >
> > Hi, Srinivas,
> >
> > Sure, I will test it.
> > As long term not working on EHL, I doesn't have EHL board on hand right=
 now, I can test this patch on other ISH related platforms.
> > From the patch, it's focus on EHL platform, I assume Kai-Heng already v=
erified the function on EHL board.
>
> I only made sure the GPE overflow issue is fixed by the patch, but I didn=
't test the S5 wakeup.
> That's because I don't know how to test it on the EHL system I have.
> I'll test it if you can let me know how to test the S5 wakeup.
>
> Kai-Heng
>
> > I don't think it will take effect on other platforms, anyway, I will te=
st it on the platforms I have to provide cross platform verification.
> >
> > Thanks!
> >
> > Best Regards,
> > Even Xu
> >
> > -----Original Message-----
> > From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
> > Sent: Friday, September 15, 2023 12:11 AM
> > To: Kai-Heng Feng <kai.heng.feng@canonical.com>; jikos@kernel.org;
> > benjamin.tissoires@redhat.com
> > Cc: linux-pm@vger.kernel.org; linux-pci@vger.kernel.org; Lee, Jian Hui
> > <jianhui.lee@canonical.com>; Xu, Even <even.xu@intel.com>; Zhang, Lixu
> > <lixu.zhang@intel.com>; Ba, Najumon <najumon.ba@intel.com>;
> > linux-input@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH] HID: intel-ish-hid: ipc: Rework EHL OOB wakeup
> >
> > Hi Even,
> >
> > On Thu, 2023-09-14 at 12:18 +0800, Kai-Heng Feng wrote:
> > > System cannot suspend more than 255 times because the driver doesn't
> > > have corresponding acpi_disable_gpe() for acpi_enable_gpe(), so the
> > > GPE refcount overflows.
> > >
> > > Since PCI core and ACPI core already handles PCI PME wake and GPE
> > > wake when the device has wakeup capability, use device_init_wakeup()
> > > to let them do the wakeup setting work.
> > >
> > > Also add a shutdown callback which uses pci_prepare_to_sleep() to
> > > let PCI and ACPI set OOB wakeup for S5.
> > >
> > Please test this change.
> >
> > Thanks,
> > Srinivas
> >
> > > Fixes: 2e23a70edabe ("HID: intel-ish-hid: ipc: finish power flow for
> > > EHL OOB")
> > > Cc: Jian Hui Lee <jianhui.lee@canonical.com>
> > > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > > ---
> > >  drivers/hid/intel-ish-hid/ipc/pci-ish.c | 59
> > > +++++++----------------
> > > --
> > >  1 file changed, 15 insertions(+), 44 deletions(-)
> > >
> > > diff --git a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> > > b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> > > index 55cb25038e63..65e7eeb2fa64 100644
> > > --- a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> > > +++ b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> > > @@ -119,42 +119,6 @@ static inline bool ish_should_leave_d0i3(struct
> > > pci_dev *pdev)
> > >         return !pm_resume_via_firmware() || pdev->device =3D=3D
> > > CHV_DEVICE_ID;  }
> > >
> > > -static int enable_gpe(struct device *dev) -{ -#ifdef CONFIG_ACPI
> > > -       acpi_status acpi_sts;
> > > -       struct acpi_device *adev;
> > > -       struct acpi_device_wakeup *wakeup;
> > > -
> > > -       adev =3D ACPI_COMPANION(dev);
> > > -       if (!adev) {
> > > -               dev_err(dev, "get acpi handle failed\n");
> > > -               return -ENODEV;
> > > -       }
> > > -       wakeup =3D &adev->wakeup;
> > > -
> > > -       acpi_sts =3D acpi_enable_gpe(wakeup->gpe_device, wakeup-
> > > >gpe_number);
> > > -       if (ACPI_FAILURE(acpi_sts)) {
> > > -               dev_err(dev, "enable ose_gpe failed\n");
> > > -               return -EIO;
> > > -       }
> > > -
> > > -       return 0;
> > > -#else
> > > -       return -ENODEV;
> > > -#endif
> > > -}
> > > -
> > > -static void enable_pme_wake(struct pci_dev *pdev) -{
> > > -       if ((pci_pme_capable(pdev, PCI_D0) ||
> > > -            pci_pme_capable(pdev, PCI_D3hot) ||
> > > -            pci_pme_capable(pdev, PCI_D3cold)) && !enable_gpe(&pdev-
> > > >dev)) {
> > > -               pci_pme_active(pdev, true);
> > > -               dev_dbg(&pdev->dev, "ish ipc driver pme wake
> > > enabled\n");
> > > -       }
> > > -}
> > > -
> > >  /**
> > >   * ish_probe() - PCI driver probe callback
> > >   * @pdev:      pci device
> > > @@ -225,7 +189,7 @@ static int ish_probe(struct pci_dev *pdev, const
> > > struct pci_device_id *ent)
> > >
> > >         /* Enable PME for EHL */
> > >         if (pdev->device =3D=3D EHL_Ax_DEVICE_ID)
> > > -               enable_pme_wake(pdev);
> > > +               device_init_wakeup(dev, true);
> > >
> > >         ret =3D ish_init(ishtp);
> > >         if (ret)
> > > @@ -248,6 +212,19 @@ static void ish_remove(struct pci_dev *pdev)
> > >         ish_device_disable(ishtp_dev);  }
> > >
> > > +
> > > +/**
> > > + * ish_shutdown() - PCI driver shutdown callback
> > > + * @pdev:      pci device
> > > + *
> > > + * This function sets up wakeup for S5  */ static void
> > > +ish_shutdown(struct pci_dev *pdev) {
> > > +       if (pdev->device =3D=3D EHL_Ax_DEVICE_ID)
> > > +               pci_prepare_to_sleep(pdev); }
> > > +
> > >  static struct device __maybe_unused *ish_resume_device;
> > >
> > >  /* 50ms to get resume response */
> > > @@ -370,13 +347,6 @@ static int __maybe_unused ish_resume(struct
> > > device *device)
> > >         struct pci_dev *pdev =3D to_pci_dev(device);
> > >         struct ishtp_device *dev =3D pci_get_drvdata(pdev);
> > >
> > > -       /* add this to finish power flow for EHL */
> > > -       if (dev->pdev->device =3D=3D EHL_Ax_DEVICE_ID) {
> > > -               pci_set_power_state(pdev, PCI_D0);
> > > -               enable_pme_wake(pdev);
> > > -               dev_dbg(dev->devc, "set power state to D0 for ehl\n")=
;
> > > -       }
> > > -
> > >         ish_resume_device =3D device;
> > >         dev->resume_flag =3D 1;
> > >
> > > @@ -392,6 +362,7 @@ static struct pci_driver ish_driver =3D {
> > >         .id_table =3D ish_pci_tbl,
> > >         .probe =3D ish_probe,
> > >         .remove =3D ish_remove,
> > > +       .shutdown =3D ish_shutdown,
> > >         .driver.pm =3D &ish_pm_ops,
> > >  };
> > >
> >
