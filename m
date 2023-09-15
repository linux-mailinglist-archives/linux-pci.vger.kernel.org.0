Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96A447A15D2
	for <lists+linux-pci@lfdr.de>; Fri, 15 Sep 2023 08:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbjIOGBS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Sep 2023 02:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbjIOGBR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Sep 2023 02:01:17 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C09270B
        for <linux-pci@vger.kernel.org>; Thu, 14 Sep 2023 23:01:11 -0700 (PDT)
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 37EB23F66A
        for <linux-pci@vger.kernel.org>; Fri, 15 Sep 2023 06:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1694757670;
        bh=13SYOno9PzBAELprvqBKW3TKbtgqHXvDNkYZ3UiLqu0=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=NOlYLm+RMZB3pxLl3mWLFQfpUCNqWRUFIQLftnb9X3+SkcL5jnxfwNH6ylHlDNsLv
         wU3QwIkQfVTMeEgmK9eAz0HZ+grnnnzn8CjE/yua3IBFQc1R8eExMaPQTe5jvNvrpl
         AgBVD0PmtcharLqX6DT4IPA5S8QrzihDXjsHIsczc/1bGx7MOrPsYCpmPOcGTBSwte
         baH79q35N6ZY1NEK8US+WpI/NlIIdE1XGC3RHoRI7HV+tCyqWEoZb1NkPOQ7mww8IO
         sdwTa2nZPPl8HE5W/o+HLZqj7nyBlaSiyyx7rJCCi1ySuGEWRrGVQzslazJrHgwzoT
         uakwKxI5OEhcw==
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-26d269dc983so1497476a91.2
        for <linux-pci@vger.kernel.org>; Thu, 14 Sep 2023 23:01:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694757669; x=1695362469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=13SYOno9PzBAELprvqBKW3TKbtgqHXvDNkYZ3UiLqu0=;
        b=fV92OG69C77t/2yCEBiLSDnBuO4TirZmz1v8IKnnnvLGq94bj/mvij6TTKJ4Bl1+OA
         /cGWi9odSQrMUxRgJF6josgGZIjx18G8hvUDcE69QAZB6NHxgFJdMDNMGG/qDo3a5vxl
         uBpukkRhzUYYqERi0k0WdRoEbScZ9fRWLmnOAFxwGw17XWiukNXoGyKegAEaLIG2IFLK
         pMu+b0u9RDu4LhLFRtIf1O5loSvtM7Jk3J5BJf/bNJ3KVItWYMNw0o7oc/KW9EneLugD
         EDCNbIOGN9h8SZ6Z9Ow9SFSzShcDWtuLyaQtH3+SUJGdgS14LJmr3k1MYX1ayQLBrxKD
         C9Fw==
X-Gm-Message-State: AOJu0YxELQx+mP9fJYitj6a8r/5WcOZRRa+vMtsSOJ92O4IfM/fwO0RC
        q+fMDt6VjWkjwXHJiiQqUnvk5ElPj4psdEobKttiH45peDqbFY3aUPLdWuj3CEEEDcELkKpuLp/
        RGuo6+2QaNhf8f8MqpFIS/p5hl/21VWum55Gbw/G77W8kPBRVLS9sdA==
X-Received: by 2002:a17:90a:e547:b0:268:1355:b03e with SMTP id ei7-20020a17090ae54700b002681355b03emr567213pjb.38.1694757668634;
        Thu, 14 Sep 2023 23:01:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAq+/5LEdCLWxdD1EU0j+5Av5J9yFGdkfAPOoPNnvIyzOpELjR4hcXx0l8DTydFJmnwgJchzeHUUsIJgvLWf8=
X-Received: by 2002:a17:90a:e547:b0:268:1355:b03e with SMTP id
 ei7-20020a17090ae54700b002681355b03emr567190pjb.38.1694757668286; Thu, 14 Sep
 2023 23:01:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230914041806.816741-1-kai.heng.feng@canonical.com>
 <7b45ac2ed091497b4e21a6a5c19956161175ba16.camel@linux.intel.com> <SN6PR11MB26245C44E84C37C1B551260EF4F6A@SN6PR11MB2624.namprd11.prod.outlook.com>
In-Reply-To: <SN6PR11MB26245C44E84C37C1B551260EF4F6A@SN6PR11MB2624.namprd11.prod.outlook.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Fri, 15 Sep 2023 14:00:55 +0800
Message-ID: <CAAd53p5ywMVKWzhn0nYzvBnW_Bc=sntgBttJdcVUuf_a4AnX5w@mail.gmail.com>
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

On Fri, Sep 15, 2023 at 1:31=E2=80=AFPM Xu, Even <even.xu@intel.com> wrote:
>
> Hi, Srinivas,
>
> Sure, I will test it.
> As long term not working on EHL, I doesn't have EHL board on hand right n=
ow, I can test this patch on other ISH related platforms.
> From the patch, it's focus on EHL platform, I assume Kai-Heng already ver=
ified the function on EHL board.

I only made sure the GPE overflow issue is fixed by the patch, but I
didn't test the S5 wakeup.
That's because I don't know how to test it on the EHL system I have.
I'll test it if you can let me know how to test the S5 wakeup.

Kai-Heng

> I don't think it will take effect on other platforms, anyway, I will test=
 it on the platforms I have to provide cross platform verification.
>
> Thanks!
>
> Best Regards,
> Even Xu
>
> -----Original Message-----
> From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
> Sent: Friday, September 15, 2023 12:11 AM
> To: Kai-Heng Feng <kai.heng.feng@canonical.com>; jikos@kernel.org; benjam=
in.tissoires@redhat.com
> Cc: linux-pm@vger.kernel.org; linux-pci@vger.kernel.org; Lee, Jian Hui <j=
ianhui.lee@canonical.com>; Xu, Even <even.xu@intel.com>; Zhang, Lixu <lixu.=
zhang@intel.com>; Ba, Najumon <najumon.ba@intel.com>; linux-input@vger.kern=
el.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] HID: intel-ish-hid: ipc: Rework EHL OOB wakeup
>
> Hi Even,
>
> On Thu, 2023-09-14 at 12:18 +0800, Kai-Heng Feng wrote:
> > System cannot suspend more than 255 times because the driver doesn't
> > have corresponding acpi_disable_gpe() for acpi_enable_gpe(), so the
> > GPE refcount overflows.
> >
> > Since PCI core and ACPI core already handles PCI PME wake and GPE wake
> > when the device has wakeup capability, use device_init_wakeup() to let
> > them do the wakeup setting work.
> >
> > Also add a shutdown callback which uses pci_prepare_to_sleep() to let
> > PCI and ACPI set OOB wakeup for S5.
> >
> Please test this change.
>
> Thanks,
> Srinivas
>
> > Fixes: 2e23a70edabe ("HID: intel-ish-hid: ipc: finish power flow for
> > EHL OOB")
> > Cc: Jian Hui Lee <jianhui.lee@canonical.com>
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> >  drivers/hid/intel-ish-hid/ipc/pci-ish.c | 59 +++++++----------------
> > --
> >  1 file changed, 15 insertions(+), 44 deletions(-)
> >
> > diff --git a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> > b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> > index 55cb25038e63..65e7eeb2fa64 100644
> > --- a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> > +++ b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> > @@ -119,42 +119,6 @@ static inline bool ish_should_leave_d0i3(struct
> > pci_dev *pdev)
> >         return !pm_resume_via_firmware() || pdev->device =3D=3D
> > CHV_DEVICE_ID;
> >  }
> >
> > -static int enable_gpe(struct device *dev) -{ -#ifdef CONFIG_ACPI
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
> > -static void enable_pme_wake(struct pci_dev *pdev) -{
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
> > @@ -225,7 +189,7 @@ static int ish_probe(struct pci_dev *pdev, const
> > struct pci_device_id *ent)
> >
> >         /* Enable PME for EHL */
> >         if (pdev->device =3D=3D EHL_Ax_DEVICE_ID)
> > -               enable_pme_wake(pdev);
> > +               device_init_wakeup(dev, true);
> >
> >         ret =3D ish_init(ishtp);
> >         if (ret)
> > @@ -248,6 +212,19 @@ static void ish_remove(struct pci_dev *pdev)
> >         ish_device_disable(ishtp_dev);
> >  }
> >
> > +
> > +/**
> > + * ish_shutdown() - PCI driver shutdown callback
> > + * @pdev:      pci device
> > + *
> > + * This function sets up wakeup for S5  */ static void
> > +ish_shutdown(struct pci_dev *pdev) {
> > +       if (pdev->device =3D=3D EHL_Ax_DEVICE_ID)
> > +               pci_prepare_to_sleep(pdev); }
> > +
> >  static struct device __maybe_unused *ish_resume_device;
> >
> >  /* 50ms to get resume response */
> > @@ -370,13 +347,6 @@ static int __maybe_unused ish_resume(struct
> > device *device)
> >         struct pci_dev *pdev =3D to_pci_dev(device);
> >         struct ishtp_device *dev =3D pci_get_drvdata(pdev);
> >
> > -       /* add this to finish power flow for EHL */
> > -       if (dev->pdev->device =3D=3D EHL_Ax_DEVICE_ID) {
> > -               pci_set_power_state(pdev, PCI_D0);
> > -               enable_pme_wake(pdev);
> > -               dev_dbg(dev->devc, "set power state to D0 for ehl\n");
> > -       }
> > -
> >         ish_resume_device =3D device;
> >         dev->resume_flag =3D 1;
> >
> > @@ -392,6 +362,7 @@ static struct pci_driver ish_driver =3D {
> >         .id_table =3D ish_pci_tbl,
> >         .probe =3D ish_probe,
> >         .remove =3D ish_remove,
> > +       .shutdown =3D ish_shutdown,
> >         .driver.pm =3D &ish_pm_ops,
> >  };
> >
>
