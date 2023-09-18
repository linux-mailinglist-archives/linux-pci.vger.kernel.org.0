Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7712E7A4F17
	for <lists+linux-pci@lfdr.de>; Mon, 18 Sep 2023 18:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbjIRQeB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Sep 2023 12:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjIRQdf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Sep 2023 12:33:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF7327BA9;
        Mon, 18 Sep 2023 09:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695053753; x=1726589753;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version;
  bh=Y5Qy1xq2FLp9lLJPaXJu9Xq5JiTKhd0beDoTIPfg6uk=;
  b=fENF5UD9ZH42BVlUIsO5Z/LfNy9JJgw7AKpWaSOUA3wz1w7pC7Q7KCgh
   XJB95FWN6+lpGERehI2J0gDJdyPb6mqFOITS9ISq0dNv1rixTOoPk/nbF
   eXl2EQrjzieb88OJiHh02gYr1rX6ab2LxZ77A5GT7kkZ5prSbZdM8j/D+
   m1AwkYpdo9IrgkeDxpZx59IHOh8BZMilYSvAsFX9zE06JGTes93Wx/ru/
   V1g+v6ZssFWFSNo7ouliKEbhrqPGpO/JSi3CIYbw2Qbcj1tBtGN92mSbX
   UkyQ+4O8yqXJ2WGMoHwrUZ1d+vn7I0a8eu/p1rdCTW9Xv88b2ZCERo8xb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="359949175"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="diff'?scan'208";a="359949175"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 08:57:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="722509078"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="diff'?scan'208";a="722509078"
Received: from spandruv-desk1.amr.corp.intel.com ([10.209.0.131])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 08:57:26 -0700
Message-ID: <bbbf36724d63f7532696a960a9d56d7ccd5a5bee.camel@linux.intel.com>
Subject: Re: [PATCH] HID: intel-ish-hid: ipc: Rework EHL OOB wakeup
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "Xu, Even" <even.xu@intel.com>
Cc:     "jikos@kernel.org" <jikos@kernel.org>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Lee, Jian Hui" <jianhui.lee@canonical.com>,
        "Zhang, Lixu" <lixu.zhang@intel.com>,
        "Ba, Najumon" <najumon.ba@intel.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Mon, 18 Sep 2023 08:57:26 -0700
In-Reply-To: <CAAd53p4o1pB-yzpvUCYsvuYEvQQK0my=u-ogrByRCx_Lvns=hw@mail.gmail.com>
References: <20230914041806.816741-1-kai.heng.feng@canonical.com>
         <7b45ac2ed091497b4e21a6a5c19956161175ba16.camel@linux.intel.com>
         <SN6PR11MB26245C44E84C37C1B551260EF4F6A@SN6PR11MB2624.namprd11.prod.outlook.com>
         <CAAd53p5ywMVKWzhn0nYzvBnW_Bc=sntgBttJdcVUuf_a4AnX5w@mail.gmail.com>
         <SN6PR11MB262473E2BF4057F4D285A613F4F6A@SN6PR11MB2624.namprd11.prod.outlook.com>
         <DM6PR11MB26184A8A3F955589F5FC6836F4FBA@DM6PR11MB2618.namprd11.prod.outlook.com>
         <CAAd53p4o1pB-yzpvUCYsvuYEvQQK0my=u-ogrByRCx_Lvns=hw@mail.gmail.com>
Content-Type: multipart/mixed; boundary="=-1j69hCpt+mC+iWRBI882"
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--=-1j69hCpt+mC+iWRBI882
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kai-Heng,
On Mon, 2023-09-18 at 09:17 +0800, Kai-Heng Feng wrote:
> Hi Even,
>=20
> On Mon, Sep 18, 2023 at 8:33=E2=80=AFAM Xu, Even <even.xu@intel.com> wrot=
e:
> >=20
> > Hi, Kai-Heng,
> >=20
> > I just got feedback, for testing EHL S5 wakeup feature, you need
> > several steps to setup and access=C2=A0
> > "https://portal.devicewise.com/things/browse" to trigger wake.
> > But currently, our test account of this website are all out of
> > data.
> > So maybe you need double check with the team who required you
> > preparing the patch for the verification.
>=20
> The patch is to solve the GPE refcount overflow, while maintaining S5
> wakeup. I don't have any mean to test S5 wake.
>=20
The issue is not calling acpi_disable_gpe(). To reduce the scope of
change can we just add that instead of a adding new callbacks. This way
scope is reduced.

Something like the attached

Thanks,
Srinivas






> So if you also don't have ways to verify S5 wake functionality, maybe
> we can simply revert 2e23a70edabe=C2=A0 ("HID: intel-ish-hid: ipc: finish
> power flow for EHL OOB") as alternative?
>=20
> Kai-Heng
>=20
> > Thanks!
> >=20
> > Best Regards,
> > Even Xu
> >=20
> > -----Original Message-----
> > From: Xu, Even
> > Sent: Friday, September 15, 2023 3:27 PM
> > To: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > Cc: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>;
> > jikos@kernel.org; benjamin.tissoires@redhat.com;
> > linux-pm@vger.kernel.org; linux-pci@vger.kernel.org; Lee, Jian Hui
> > <jianhui.lee@canonical.com>; Zhang, Lixu <Lixu.Zhang@intel.com>;
> > Ba, Najumon <najumon.ba@intel.com>; linux-input@vger.kernel.org;
> > linux-kernel@vger.kernel.org
> > Subject: RE: [PATCH] HID: intel-ish-hid: ipc: Rework EHL OOB wakeup
> >=20
> > Hi, Kai-Heng,
> >=20
> > I am also not familiar with this S5 wakeup test case.
> > I already sent out mails to ask for help on it.
> > Will come back to you once I get feedback.
> > Thanks!
> >=20
> > Best Regards,
> > Even Xu
> >=20
> > -----Original Message-----
> > From: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > Sent: Friday, September 15, 2023 2:01 PM
> > To: Xu, Even <even.xu@intel.com>
> > Cc: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>;
> > jikos@kernel.org; benjamin.tissoires@redhat.com;
> > linux-pm@vger.kernel.org; linux-pci@vger.kernel.org; Lee, Jian Hui
> > <jianhui.lee@canonical.com>; Zhang, Lixu <lixu.zhang@intel.com>;
> > Ba, Najumon <najumon.ba@intel.com>; linux-input@vger.kernel.org;
> > linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH] HID: intel-ish-hid: ipc: Rework EHL OOB wakeup
> >=20
> > Hi Even,
> >=20
> > On Fri, Sep 15, 2023 at 1:31=E2=80=AFPM Xu, Even <even.xu@intel.com> wr=
ote:
> > >=20
> > > Hi, Srinivas,
> > >=20
> > > Sure, I will test it.
> > > As long term not working on EHL, I doesn't have EHL board on hand
> > > right now, I can test this patch on other ISH related platforms.
> > > From the patch, it's focus on EHL platform, I assume Kai-Heng
> > > already verified the function on EHL board.
> >=20
> > I only made sure the GPE overflow issue is fixed by the patch, but
> > I didn't test the S5 wakeup.
> > That's because I don't know how to test it on the EHL system I
> > have.
> > I'll test it if you can let me know how to test the S5 wakeup.
> >=20
> > Kai-Heng
> >=20
> > > I don't think it will take effect on other platforms, anyway, I
> > > will test it on the platforms I have to provide cross platform
> > > verification.
> > >=20
> > > Thanks!
> > >=20
> > > Best Regards,
> > > Even Xu
> > >=20
> > > -----Original Message-----
> > > From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
> > > Sent: Friday, September 15, 2023 12:11 AM
> > > To: Kai-Heng Feng <kai.heng.feng@canonical.com>;
> > > jikos@kernel.org;
> > > benjamin.tissoires@redhat.com
> > > Cc: linux-pm@vger.kernel.org; linux-pci@vger.kernel.org; Lee,
> > > Jian Hui
> > > <jianhui.lee@canonical.com>; Xu, Even <even.xu@intel.com>; Zhang,
> > > Lixu
> > > <lixu.zhang@intel.com>; Ba, Najumon <najumon.ba@intel.com>;
> > > linux-input@vger.kernel.org; linux-kernel@vger.kernel.org
> > > Subject: Re: [PATCH] HID: intel-ish-hid: ipc: Rework EHL OOB
> > > wakeup
> > >=20
> > > Hi Even,
> > >=20
> > > On Thu, 2023-09-14 at 12:18 +0800, Kai-Heng Feng wrote:
> > > > System cannot suspend more than 255 times because the driver
> > > > doesn't
> > > > have corresponding acpi_disable_gpe() for acpi_enable_gpe(), so
> > > > the
> > > > GPE refcount overflows.
> > > >=20
> > > > Since PCI core and ACPI core already handles PCI PME wake and
> > > > GPE
> > > > wake when the device has wakeup capability, use
> > > > device_init_wakeup()
> > > > to let them do the wakeup setting work.
> > > >=20
> > > > Also add a shutdown callback which uses pci_prepare_to_sleep()
> > > > to
> > > > let PCI and ACPI set OOB wakeup for S5.
> > > >=20
> > > Please test this change.
> > >=20
> > > Thanks,
> > > Srinivas
> > >=20
> > > > Fixes: 2e23a70edabe ("HID: intel-ish-hid: ipc: finish power
> > > > flow for
> > > > EHL OOB")
> > > > Cc: Jian Hui Lee <jianhui.lee@canonical.com>
> > > > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > > > ---
> > > > =C2=A0drivers/hid/intel-ish-hid/ipc/pci-ish.c | 59
> > > > +++++++----------------
> > > > --
> > > > =C2=A01 file changed, 15 insertions(+), 44 deletions(-)
> > > >=20
> > > > diff --git a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> > > > b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> > > > index 55cb25038e63..65e7eeb2fa64 100644
> > > > --- a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> > > > +++ b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> > > > @@ -119,42 +119,6 @@ static inline bool
> > > > ish_should_leave_d0i3(struct
> > > > pci_dev *pdev)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return !pm_resume_via_fi=
rmware() || pdev->device =3D=3D
> > > > CHV_DEVICE_ID;=C2=A0 }
> > > >=20
> > > > -static int enable_gpe(struct device *dev) -{ -#ifdef
> > > > CONFIG_ACPI
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 acpi_status acpi_sts;
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct acpi_device *adev;
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct acpi_device_wakeup *wa=
keup;
> > > > -
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 adev =3D ACPI_COMPANION(dev);
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!adev) {
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 dev_err(dev, "get acpi handle failed\n");
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return -ENODEV;
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wakeup =3D &adev->wakeup;
> > > > -
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 acpi_sts =3D acpi_enable_gpe(=
wakeup->gpe_device, wakeup-
> > > > > gpe_number);
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ACPI_FAILURE(acpi_sts)) {
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 dev_err(dev, "enable ose_gpe failed\n");
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return -EIO;
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > -
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> > > > -#else
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENODEV;
> > > > -#endif
> > > > -}
> > > > -
> > > > -static void enable_pme_wake(struct pci_dev *pdev) -{
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ((pci_pme_capable(pdev, PC=
I_D0) ||
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 pci_pme_capable(pdev, PCI_D3hot) ||
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 pci_pme_capable(pdev, PCI_D3cold)) &&
> > > > !enable_gpe(&pdev-
> > > > > dev)) {
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 pci_pme_active(pdev, true);
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 dev_dbg(&pdev->dev, "ish ipc driver pme wake
> > > > enabled\n");
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > -}
> > > > -
> > > > =C2=A0/**
> > > > =C2=A0 * ish_probe() - PCI driver probe callback
> > > > =C2=A0 * @pdev:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci device
> > > > @@ -225,7 +189,7 @@ static int ish_probe(struct pci_dev *pdev,
> > > > const
> > > > struct pci_device_id *ent)
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Enable PME for EHL */
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (pdev->device =3D=3D =
EHL_Ax_DEVICE_ID)
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 enable_pme_wake(pdev);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 device_init_wakeup(dev, true);
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D ish_init(ishtp);
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> > > > @@ -248,6 +212,19 @@ static void ish_remove(struct pci_dev
> > > > *pdev)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ish_device_disable(ishtp=
_dev);=C2=A0 }
> > > >=20
> > > > +
> > > > +/**
> > > > + * ish_shutdown() - PCI driver shutdown callback
> > > > + * @pdev:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci device
> > > > + *
> > > > + * This function sets up wakeup for S5=C2=A0 */ static void
> > > > +ish_shutdown(struct pci_dev *pdev) {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (pdev->device =3D=3D EHL_A=
x_DEVICE_ID)
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 pci_prepare_to_sleep(pdev); }
> > > > +
> > > > =C2=A0static struct device __maybe_unused *ish_resume_device;
> > > >=20
> > > > =C2=A0/* 50ms to get resume response */
> > > > @@ -370,13 +347,6 @@ static int __maybe_unused
> > > > ish_resume(struct
> > > > device *device)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct pci_dev *pdev =3D=
 to_pci_dev(device);
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ishtp_device *dev=
 =3D pci_get_drvdata(pdev);
> > > >=20
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* add this to finish power f=
low for EHL */
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (dev->pdev->device =3D=3D =
EHL_Ax_DEVICE_ID) {
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 pci_set_power_state(pdev, PCI_D0);
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 enable_pme_wake(pdev);
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 dev_dbg(dev->devc, "set power state to D0 for
> > > > ehl\n");
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > -
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ish_resume_device =3D de=
vice;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev->resume_flag =3D 1;
> > > >=20
> > > > @@ -392,6 +362,7 @@ static struct pci_driver ish_driver =3D {
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .id_table =3D ish_pci_tb=
l,
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .probe =3D ish_probe,
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .remove =3D ish_remove,
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .shutdown =3D ish_shutdown,
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .driver.pm =3D &ish_pm_o=
ps,
> > > > =C2=A0};
> > > >=20
> > >=20


--=-1j69hCpt+mC+iWRBI882
Content-Disposition: attachment; filename="ehl_gpe.diff"
Content-Transfer-Encoding: base64
Content-Type: text/x-patch; name="ehl_gpe.diff"; charset="UTF-8"

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvaGlkL2ludGVsLWlzaC1oaWQvaXBjL3BjaS1pc2guYyBiL2Ry
aXZlcnMvaGlkL2ludGVsLWlzaC1oaWQvaXBjL3BjaS1pc2guYwppbmRleCA1NWNiMjUwMzhlNjMu
LjBkODU0ZTRmMWY3YyAxMDA2NDQKLS0tIGEvZHJpdmVycy9oaWQvaW50ZWwtaXNoLWhpZC9pcGMv
cGNpLWlzaC5jCisrKyBiL2RyaXZlcnMvaGlkL2ludGVsLWlzaC1oaWQvaXBjL3BjaS1pc2guYwpA
QCAtMTE5LDcgKzExOSw3IEBAIHN0YXRpYyBpbmxpbmUgYm9vbCBpc2hfc2hvdWxkX2xlYXZlX2Qw
aTMoc3RydWN0IHBjaV9kZXYgKnBkZXYpCiAJcmV0dXJuICFwbV9yZXN1bWVfdmlhX2Zpcm13YXJl
KCkgfHwgcGRldi0+ZGV2aWNlID09IENIVl9ERVZJQ0VfSUQ7CiB9CiAKLXN0YXRpYyBpbnQgZW5h
YmxlX2dwZShzdHJ1Y3QgZGV2aWNlICpkZXYpCitzdGF0aWMgaW50IGVuYWJsZV9ncGUoc3RydWN0
IGRldmljZSAqZGV2LCBib29sIHN0YXR1cykKIHsKICNpZmRlZiBDT05GSUdfQUNQSQogCWFjcGlf
c3RhdHVzIGFjcGlfc3RzOwpAQCAtMTMzLDcgKzEzMywxMSBAQCBzdGF0aWMgaW50IGVuYWJsZV9n
cGUoc3RydWN0IGRldmljZSAqZGV2KQogCX0KIAl3YWtldXAgPSAmYWRldi0+d2FrZXVwOwogCi0J
YWNwaV9zdHMgPSBhY3BpX2VuYWJsZV9ncGUod2FrZXVwLT5ncGVfZGV2aWNlLCB3YWtldXAtPmdw
ZV9udW1iZXIpOworCWlmIChzdGF0dXMpCisJCWFjcGlfc3RzID0gYWNwaV9lbmFibGVfZ3BlKHdh
a2V1cC0+Z3BlX2RldmljZSwgd2FrZXVwLT5ncGVfbnVtYmVyKTsKKwllbHNlCisJCWFjcGlfc3Rz
ID0gYWNwaV9kaXNhYmxlX2dwZSh3YWtldXAtPmdwZV9kZXZpY2UsIHdha2V1cC0+Z3BlX251bWJl
cik7CisKIAlpZiAoQUNQSV9GQUlMVVJFKGFjcGlfc3RzKSkgewogCQlkZXZfZXJyKGRldiwgImVu
YWJsZSBvc2VfZ3BlIGZhaWxlZFxuIik7CiAJCXJldHVybiAtRUlPOwpAQCAtMTQ1LDEzICsxNDks
MTMgQEAgc3RhdGljIGludCBlbmFibGVfZ3BlKHN0cnVjdCBkZXZpY2UgKmRldikKICNlbmRpZgog
fQogCi1zdGF0aWMgdm9pZCBlbmFibGVfcG1lX3dha2Uoc3RydWN0IHBjaV9kZXYgKnBkZXYpCitz
dGF0aWMgdm9pZCBlbmFibGVfcG1lX3dha2Uoc3RydWN0IHBjaV9kZXYgKnBkZXYsIHN0YXR1cykK
IHsKIAlpZiAoKHBjaV9wbWVfY2FwYWJsZShwZGV2LCBQQ0lfRDApIHx8CiAJICAgICBwY2lfcG1l
X2NhcGFibGUocGRldiwgUENJX0QzaG90KSB8fAotCSAgICAgcGNpX3BtZV9jYXBhYmxlKHBkZXYs
IFBDSV9EM2NvbGQpKSAmJiAhZW5hYmxlX2dwZSgmcGRldi0+ZGV2KSkgewotCQlwY2lfcG1lX2Fj
dGl2ZShwZGV2LCB0cnVlKTsKLQkJZGV2X2RiZygmcGRldi0+ZGV2LCAiaXNoIGlwYyBkcml2ZXIg
cG1lIHdha2UgZW5hYmxlZFxuIik7CisJICAgICBwY2lfcG1lX2NhcGFibGUocGRldiwgUENJX0Qz
Y29sZCkpICYmICFlbmFibGVfZ3BlKCZwZGV2LT5kZXYpLCBzdGF0dXMpIHsKKwkJcGNpX3BtZV9h
Y3RpdmUocGRldiwgc3RhdHVzKTsKKwkJZGV2X2RiZygmcGRldi0+ZGV2LCAiaXNoIGlwYyBkcml2
ZXIgcG1lIHdha2UgZW5hYmxlZCBzdGF0ZSAlZFxuIiwgc3RhdHVzKTsKIAl9CiB9CiAKQEAgLTIy
NSw3ICsyMjksNyBAQCBzdGF0aWMgaW50IGlzaF9wcm9iZShzdHJ1Y3QgcGNpX2RldiAqcGRldiwg
Y29uc3Qgc3RydWN0IHBjaV9kZXZpY2VfaWQgKmVudCkKIAogCS8qIEVuYWJsZSBQTUUgZm9yIEVI
TCAqLwogCWlmIChwZGV2LT5kZXZpY2UgPT0gRUhMX0F4X0RFVklDRV9JRCkKLQkJZW5hYmxlX3Bt
ZV93YWtlKHBkZXYpOworCQllbmFibGVfcG1lX3dha2UocGRldiwgdHJ1ZSk7CiAKIAlyZXQgPSBp
c2hfaW5pdChpc2h0cCk7CiAJaWYgKHJldCkKQEAgLTM1Myw2ICszNTcsOSBAQCBzdGF0aWMgaW50
IF9fbWF5YmVfdW51c2VkIGlzaF9zdXNwZW5kKHN0cnVjdCBkZXZpY2UgKmRldmljZSkKIAkJaXNo
X2Rpc2FibGVfZG1hKGRldik7CiAJfQogCisJaWYgKGRldi0+cGRldi0+ZGV2aWNlID09IEVITF9B
eF9ERVZJQ0VfSUQpCisJCWVuYWJsZV9wbWVfd2FrZShwZGV2LCBmYWxzZSk7CisKIAlyZXR1cm4g
MDsKIH0KIApAQCAtMzczLDcgKzM4MCw3IEBAIHN0YXRpYyBpbnQgX19tYXliZV91bnVzZWQgaXNo
X3Jlc3VtZShzdHJ1Y3QgZGV2aWNlICpkZXZpY2UpCiAJLyogYWRkIHRoaXMgdG8gZmluaXNoIHBv
d2VyIGZsb3cgZm9yIEVITCAqLwogCWlmIChkZXYtPnBkZXYtPmRldmljZSA9PSBFSExfQXhfREVW
SUNFX0lEKSB7CiAJCXBjaV9zZXRfcG93ZXJfc3RhdGUocGRldiwgUENJX0QwKTsKLQkJZW5hYmxl
X3BtZV93YWtlKHBkZXYpOworCQllbmFibGVfcG1lX3dha2UocGRldiwgdHJ1ZSk7CiAJCWRldl9k
YmcoZGV2LT5kZXZjLCAic2V0IHBvd2VyIHN0YXRlIHRvIEQwIGZvciBlaGxcbiIpOwogCX0KIAo=


--=-1j69hCpt+mC+iWRBI882--
