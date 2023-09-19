Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C94DA7A6936
	for <lists+linux-pci@lfdr.de>; Tue, 19 Sep 2023 18:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbjISQyv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Sep 2023 12:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjISQyu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Sep 2023 12:54:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73315AD;
        Tue, 19 Sep 2023 09:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695142484; x=1726678484;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=+6xtP9UUM0huUnkoQoVqG+rtYNumzsl1UjCqCjUrlDk=;
  b=MYEYx/bAwOPS0pvhWRje1uy5/l6tUvbYMqNq0GPxAfoLS7n7kfibEWkL
   o+QKiW7tZB+k0Z42xlunrKrbhd2DPnGJ3coq3LvlyxbYX0x3/i5TokElJ
   pbUthDIHoJ4ab0Gtqx6ULckAqUFZvBXkdH/Kz68yF6+OaPz8YqVDOEINY
   aa/9bTbiKhnDo0F55qPtFGFss9i3+qgBhnzGHZLxL6VsjvIOD2hD6D5IN
   Uk3ubDj6d/VBYeKgPfflOBlEtuiuPSsVBeZd8xWbWCKHHw+YqCFaBdZR9
   dVU6XJuLrPRNQAuGBZBTN03DmSStnVLgIhhCW3d6oUmM+/7ZQ4wOfcZaU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="382752435"
X-IronPort-AV: E=Sophos;i="6.02,160,1688454000"; 
   d="scan'208";a="382752435"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 09:54:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="816516422"
X-IronPort-AV: E=Sophos;i="6.02,160,1688454000"; 
   d="scan'208";a="816516422"
Received: from spandruv-desk1.amr.corp.intel.com ([10.209.80.116])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 09:54:42 -0700
Message-ID: <67c85f083201ed2cda2cab198b40141ad21912a2.camel@linux.intel.com>
Subject: Re: [PATCH] HID: intel-ish-hid: ipc: Rework EHL OOB wakeup
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     "Xu, Even" <even.xu@intel.com>,
        "jikos@kernel.org" <jikos@kernel.org>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Lee, Jian Hui" <jianhui.lee@canonical.com>,
        "Zhang, Lixu" <lixu.zhang@intel.com>,
        "Ba, Najumon" <najumon.ba@intel.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Tue, 19 Sep 2023 09:54:41 -0700
In-Reply-To: <CAAd53p6MA9YLbcXxpC8=YEtbO6frFJk1LQ1BNUgPk=r1_uR8iw@mail.gmail.com>
References: <20230914041806.816741-1-kai.heng.feng@canonical.com>
         <7b45ac2ed091497b4e21a6a5c19956161175ba16.camel@linux.intel.com>
         <SN6PR11MB26245C44E84C37C1B551260EF4F6A@SN6PR11MB2624.namprd11.prod.outlook.com>
         <CAAd53p5ywMVKWzhn0nYzvBnW_Bc=sntgBttJdcVUuf_a4AnX5w@mail.gmail.com>
         <SN6PR11MB262473E2BF4057F4D285A613F4F6A@SN6PR11MB2624.namprd11.prod.outlook.com>
         <DM6PR11MB26184A8A3F955589F5FC6836F4FBA@DM6PR11MB2618.namprd11.prod.outlook.com>
         <CAAd53p4o1pB-yzpvUCYsvuYEvQQK0my=u-ogrByRCx_Lvns=hw@mail.gmail.com>
         <bbbf36724d63f7532696a960a9d56d7ccd5a5bee.camel@linux.intel.com>
         <CAAd53p6MA9YLbcXxpC8=YEtbO6frFJk1LQ1BNUgPk=r1_uR8iw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 2023-09-19 at 15:36 +0800, Kai-Heng Feng wrote:
> On Mon, Sep 18, 2023 at 11:57=E2=80=AFPM srinivas pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> >=20
> > Hi Kai-Heng,
> > On Mon, 2023-09-18 at 09:17 +0800, Kai-Heng Feng wrote:
> > > Hi Even,
> > >=20
> > > On Mon, Sep 18, 2023 at 8:33=E2=80=AFAM Xu, Even <even.xu@intel.com>
> > > wrote:
> > > >=20
> > > > Hi, Kai-Heng,
> > > >=20
> > > > I just got feedback, for testing EHL S5 wakeup feature, you
> > > > need
> > > > several steps to setup and access
> > > > "https://portal.devicewise.com/things/browse" to trigger wake.
> > > > But currently, our test account of this website are all out of
> > > > data.
> > > > So maybe you need double check with the team who required you
> > > > preparing the patch for the verification.
> > >=20
> > > The patch is to solve the GPE refcount overflow, while
> > > maintaining S5
> > > wakeup. I don't have any mean to test S5 wake.
> > >=20
> > The issue is not calling acpi_disable_gpe(). To reduce the scope of
> > change can we just add that instead of a adding new callbacks. This
> > way
> > scope is reduced.
>=20
> This patch does exactly the same thing by letting PCI and ACPI handle
> the PME and GPE.
> Though the change seems to be bigger, it actually reduces the duped
> code, while keep the S5 wakeup ability intact.
It may be doing the same. But with long chain of calls without
verification, I am not comfortable.
This can be another patch by itself to use the framework.=20

But you are targeting a fix for overflow issue, which is separate from
the use of PCI/ACPI framework.

Thanks,
Srinivas

>=20
> Kai-Heng
>=20
> >=20
> > Something like the attached
> >=20
> > Thanks,
> > Srinivas
> >=20
> >=20
> >=20
> >=20
> >=20
> >=20
> > > So if you also don't have ways to verify S5 wake functionality,
> > > maybe
> > > we can simply revert 2e23a70edabe=C2=A0 ("HID: intel-ish-hid: ipc:
> > > finish
> > > power flow for EHL OOB") as alternative?
> > >=20
> > > Kai-Heng
> > >=20
> > > > Thanks!
> > > >=20
> > > > Best Regards,
> > > > Even Xu
> > > >=20
> > > > -----Original Message-----
> > > > From: Xu, Even
> > > > Sent: Friday, September 15, 2023 3:27 PM
> > > > To: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > > > Cc: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>;
> > > > jikos@kernel.org; benjamin.tissoires@redhat.com;
> > > > linux-pm@vger.kernel.org; linux-pci@vger.kernel.org; Lee, Jian
> > > > Hui
> > > > <jianhui.lee@canonical.com>; Zhang, Lixu
> > > > <Lixu.Zhang@intel.com>;
> > > > Ba, Najumon <najumon.ba@intel.com>;
> > > > linux-input@vger.kernel.org;
> > > > linux-kernel@vger.kernel.org
> > > > Subject: RE: [PATCH] HID: intel-ish-hid: ipc: Rework EHL OOB
> > > > wakeup
> > > >=20
> > > > Hi, Kai-Heng,
> > > >=20
> > > > I am also not familiar with this S5 wakeup test case.
> > > > I already sent out mails to ask for help on it.
> > > > Will come back to you once I get feedback.
> > > > Thanks!
> > > >=20
> > > > Best Regards,
> > > > Even Xu
> > > >=20
> > > > -----Original Message-----
> > > > From: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > > > Sent: Friday, September 15, 2023 2:01 PM
> > > > To: Xu, Even <even.xu@intel.com>
> > > > Cc: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>;
> > > > jikos@kernel.org; benjamin.tissoires@redhat.com;
> > > > linux-pm@vger.kernel.org; linux-pci@vger.kernel.org; Lee, Jian
> > > > Hui
> > > > <jianhui.lee@canonical.com>; Zhang, Lixu
> > > > <lixu.zhang@intel.com>;
> > > > Ba, Najumon <najumon.ba@intel.com>;
> > > > linux-input@vger.kernel.org;
> > > > linux-kernel@vger.kernel.org
> > > > Subject: Re: [PATCH] HID: intel-ish-hid: ipc: Rework EHL OOB
> > > > wakeup
> > > >=20
> > > > Hi Even,
> > > >=20
> > > > On Fri, Sep 15, 2023 at 1:31=E2=80=AFPM Xu, Even <even.xu@intel.com=
>
> > > > wrote:
> > > > >=20
> > > > > Hi, Srinivas,
> > > > >=20
> > > > > Sure, I will test it.
> > > > > As long term not working on EHL, I doesn't have EHL board on
> > > > > hand
> > > > > right now, I can test this patch on other ISH related
> > > > > platforms.
> > > > > From the patch, it's focus on EHL platform, I assume Kai-Heng
> > > > > already verified the function on EHL board.
> > > >=20
> > > > I only made sure the GPE overflow issue is fixed by the patch,
> > > > but
> > > > I didn't test the S5 wakeup.
> > > > That's because I don't know how to test it on the EHL system I
> > > > have.
> > > > I'll test it if you can let me know how to test the S5 wakeup.
> > > >=20
> > > > Kai-Heng
> > > >=20
> > > > > I don't think it will take effect on other platforms, anyway,
> > > > > I
> > > > > will test it on the platforms I have to provide cross
> > > > > platform
> > > > > verification.
> > > > >=20
> > > > > Thanks!
> > > > >=20
> > > > > Best Regards,
> > > > > Even Xu
> > > > >=20
> > > > > -----Original Message-----
> > > > > From: srinivas pandruvada
> > > > > <srinivas.pandruvada@linux.intel.com>
> > > > > Sent: Friday, September 15, 2023 12:11 AM
> > > > > To: Kai-Heng Feng <kai.heng.feng@canonical.com>;
> > > > > jikos@kernel.org;
> > > > > benjamin.tissoires@redhat.com
> > > > > Cc: linux-pm@vger.kernel.org; linux-pci@vger.kernel.org; Lee,
> > > > > Jian Hui
> > > > > <jianhui.lee@canonical.com>; Xu, Even <even.xu@intel.com>;
> > > > > Zhang,
> > > > > Lixu
> > > > > <lixu.zhang@intel.com>; Ba, Najumon <najumon.ba@intel.com>;
> > > > > linux-input@vger.kernel.org; linux-kernel@vger.kernel.org
> > > > > Subject: Re: [PATCH] HID: intel-ish-hid: ipc: Rework EHL OOB
> > > > > wakeup
> > > > >=20
> > > > > Hi Even,
> > > > >=20
> > > > > On Thu, 2023-09-14 at 12:18 +0800, Kai-Heng Feng wrote:
> > > > > > System cannot suspend more than 255 times because the
> > > > > > driver
> > > > > > doesn't
> > > > > > have corresponding acpi_disable_gpe() for
> > > > > > acpi_enable_gpe(), so
> > > > > > the
> > > > > > GPE refcount overflows.
> > > > > >=20
> > > > > > Since PCI core and ACPI core already handles PCI PME wake
> > > > > > and
> > > > > > GPE
> > > > > > wake when the device has wakeup capability, use
> > > > > > device_init_wakeup()
> > > > > > to let them do the wakeup setting work.
> > > > > >=20
> > > > > > Also add a shutdown callback which uses
> > > > > > pci_prepare_to_sleep()
> > > > > > to
> > > > > > let PCI and ACPI set OOB wakeup for S5.
> > > > > >=20
> > > > > Please test this change.
> > > > >=20
> > > > > Thanks,
> > > > > Srinivas
> > > > >=20
> > > > > > Fixes: 2e23a70edabe ("HID: intel-ish-hid: ipc: finish power
> > > > > > flow for
> > > > > > EHL OOB")
> > > > > > Cc: Jian Hui Lee <jianhui.lee@canonical.com>
> > > > > > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > > > > > ---
> > > > > > =C2=A0drivers/hid/intel-ish-hid/ipc/pci-ish.c | 59
> > > > > > +++++++----------------
> > > > > > --
> > > > > > =C2=A01 file changed, 15 insertions(+), 44 deletions(-)
> > > > > >=20
> > > > > > diff --git a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> > > > > > b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> > > > > > index 55cb25038e63..65e7eeb2fa64 100644
> > > > > > --- a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> > > > > > +++ b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> > > > > > @@ -119,42 +119,6 @@ static inline bool
> > > > > > ish_should_leave_d0i3(struct
> > > > > > pci_dev *pdev)
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return !pm_resume_vi=
a_firmware() || pdev->device =3D=3D
> > > > > > CHV_DEVICE_ID;=C2=A0 }
> > > > > >=20
> > > > > > -static int enable_gpe(struct device *dev) -{ -#ifdef
> > > > > > CONFIG_ACPI
> > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 acpi_status acpi_sts;
> > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct acpi_device *adev;
> > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct acpi_device_wakeup=
 *wakeup;
> > > > > > -
> > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 adev =3D ACPI_COMPANION(d=
ev);
> > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!adev) {
> > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 dev_err(dev, "get acpi handle failed\n");
> > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 return -ENODEV;
> > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wakeup =3D &adev->wakeup;
> > > > > > -
> > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 acpi_sts =3D acpi_enable_=
gpe(wakeup->gpe_device,
> > > > > > wakeup-
> > > > > > > gpe_number);
> > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ACPI_FAILURE(acpi_sts=
)) {
> > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 dev_err(dev, "enable ose_gpe failed\n");
> > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 return -EIO;
> > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > > > -
> > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> > > > > > -#else
> > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENODEV;
> > > > > > -#endif
> > > > > > -}
> > > > > > -
> > > > > > -static void enable_pme_wake(struct pci_dev *pdev) -{
> > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ((pci_pme_capable(pdev=
, PCI_D0) ||
> > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 pci_pme_capable(pdev, PCI_D3hot) ||
> > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 pci_pme_capable(pdev, PCI_D3cold)) &&
> > > > > > !enable_gpe(&pdev-
> > > > > > > dev)) {
> > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 pci_pme_active(pdev, true);
> > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 dev_dbg(&pdev->dev, "ish ipc driver pme
> > > > > > wake
> > > > > > enabled\n");
> > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > > > -}
> > > > > > -
> > > > > > =C2=A0/**
> > > > > > =C2=A0 * ish_probe() - PCI driver probe callback
> > > > > > =C2=A0 * @pdev:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci device
> > > > > > @@ -225,7 +189,7 @@ static int ish_probe(struct pci_dev
> > > > > > *pdev,
> > > > > > const
> > > > > > struct pci_device_id *ent)
> > > > > >=20
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Enable PME for EH=
L */
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (pdev->device =3D=
=3D EHL_Ax_DEVICE_ID)
> > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 enable_pme_wake(pdev);
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 device_init_wakeup(dev, true);
> > > > > >=20
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D ish_init(ish=
tp);
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> > > > > > @@ -248,6 +212,19 @@ static void ish_remove(struct pci_dev
> > > > > > *pdev)
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ish_device_disable(i=
shtp_dev);=C2=A0 }
> > > > > >=20
> > > > > > +
> > > > > > +/**
> > > > > > + * ish_shutdown() - PCI driver shutdown callback
> > > > > > + * @pdev:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci device
> > > > > > + *
> > > > > > + * This function sets up wakeup for S5=C2=A0 */ static void
> > > > > > +ish_shutdown(struct pci_dev *pdev) {
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (pdev->device =3D=3D E=
HL_Ax_DEVICE_ID)
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 pci_prepare_to_sleep(pdev); }
> > > > > > +
> > > > > > =C2=A0static struct device __maybe_unused *ish_resume_device;
> > > > > >=20
> > > > > > =C2=A0/* 50ms to get resume response */
> > > > > > @@ -370,13 +347,6 @@ static int __maybe_unused
> > > > > > ish_resume(struct
> > > > > > device *device)
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct pci_dev *pdev=
 =3D to_pci_dev(device);
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ishtp_device =
*dev =3D pci_get_drvdata(pdev);
> > > > > >=20
> > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* add this to finish pow=
er flow for EHL */
> > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (dev->pdev->device =3D=
=3D EHL_Ax_DEVICE_ID) {
> > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 pci_set_power_state(pdev, PCI_D0);
> > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 enable_pme_wake(pdev);
> > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 dev_dbg(dev->devc, "set power state to D0
> > > > > > for
> > > > > > ehl\n");
> > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > > > -
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ish_resume_device =
=3D device;
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev->resume_flag =3D=
 1;
> > > > > >=20
> > > > > > @@ -392,6 +362,7 @@ static struct pci_driver ish_driver =3D {
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .id_table =3D ish_pc=
i_tbl,
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .probe =3D ish_probe=
,
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .remove =3D ish_remo=
ve,
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .shutdown =3D ish_shutdow=
n,
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .driver.pm =3D &ish_=
pm_ops,
> > > > > > =C2=A0};
> > > > > >=20
> > > > >=20
> >=20

