Return-Path: <linux-pci+bounces-614-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A836808976
	for <lists+linux-pci@lfdr.de>; Thu,  7 Dec 2023 14:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68D37B21546
	for <lists+linux-pci@lfdr.de>; Thu,  7 Dec 2023 13:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61DB40BFF;
	Thu,  7 Dec 2023 13:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dk7nQZsC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D36D5E;
	Thu,  7 Dec 2023 05:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701956914; x=1733492914;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=Q+K+mOkZgJ2vnwUP2+YChC8y5M7yerg4z6n5wLVleeU=;
  b=Dk7nQZsCKeI/UNCRu0g536KXAioaIGZHmmptUX/5q/kNJ5KnVCiBkK45
   2/Nw6vbcvJ57/0io/k9EemZEzUBgStLM4cLJ94MOlLUsZNwNYRYmB4u31
   ufgsnCjbr6L2NAbMw9QMHOm6ayuOLmo9JNyS/dPF0fLBGgOM1exiVbWIv
   HwwuDNgFlhPlFa0GNEhnFBYgzXswW/ha0YVFqA7nOP4Fi7qaGS/VTiPfg
   923OljEhyy6zhOLGz7z1NfyPVIXUU+5WqaYMqmi0tfNWM5knQtcJQ0qZp
   y4uQ1rnW1+g6wu0lojQ9FH6EnTzmaXAe3J9ZPzumSzeeRva79nR7H2eRW
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="7540873"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="7540873"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 05:48:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="895152612"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="895152612"
Received: from yzhan76-mobl1.amr.corp.intel.com (HELO [10.212.19.153]) ([10.212.19.153])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 05:48:31 -0800
Message-ID: <925fd50bd609f99f0eabf93d1163106f6118f139.camel@linux.intel.com>
Subject: Re: [PATCH v2] HID: intel-ish-hid: ipc: Rework EHL OOB wakeup
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: jikos@kernel.org, benjamin.tissoires@redhat.com,
 linux-pm@vger.kernel.org,  linux-pci@vger.kernel.org, Jian Hui Lee
 <jianhui.lee@canonical.com>, Even Xu <even.xu@intel.com>,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 07 Dec 2023 08:48:30 -0500
In-Reply-To: <CAAd53p7do2rrB=qbpWKbNCWB_qfZ2YZPtB_55VcfGjDYXgLfzA@mail.gmail.com>
References: <20231108121940.288005-1-kai.heng.feng@canonical.com>
	 <cc6c162407c69c53ec256bf887a0384361dd0516.camel@linux.intel.com>
	 <CAAd53p7do2rrB=qbpWKbNCWB_qfZ2YZPtB_55VcfGjDYXgLfzA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2023-12-07 at 10:44 +0800, Kai-Heng Feng wrote:
> On Tue, Dec 5, 2023 at 1:50=E2=80=AFAM srinivas pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> >=20
> > Hi Kai,
> >=20
> > Sorry for he delay in getting back on this. I have a question
> > below:
> >=20
> > On Wed, 2023-11-08 at 14:19 +0200, Kai-Heng Feng wrote:
> > > Since PCI core and ACPI core already handles PCI PME wake and GPE
> > > wake
> > > when the device has wakeup capability, use device_init_wakeup()
> > > to
> > > let
> > > them do the wakeup setting work.
> > >=20
> > > Also add a shutdown callback which uses pci_prepare_to_sleep() to
> > > let
> > > PCI and ACPI set OOB wakeup for S5.
> > >=20
> > > Cc: Jian Hui Lee <jianhui.lee@canonical.com>
> > > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > > ---
> > > v2:
> > > =C2=A0Rebase on ("HID: intel-ish-hid: ipc: Disable and reenable ACPI
> > > GPE
> > > bit")
> > >=20
> > > =C2=A0drivers/hid/intel-ish-hid/ipc/pci-ish.c | 67 ++++++------------=
-
> > > ----
> > > --
> > >=20
...
...

> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 device_init_wakeup(dev, true);
> >=20
> > For apple to apple comparison, which path will call
> > https://elixir.bootlin.com/linux/latest/C/ident/__pci_enable_wake
> > which will call pci_pme_active()?
>=20
> Here's the flow:
> device_shutdown()
> =C2=A0 pci_device_shutdown()
> =C2=A0=C2=A0=C2=A0 ish_shutdown()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_prepare_to_sleep()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __pci_enable_wake()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_pme_active()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __pci_=
pme_active()

Thanks. I will send my ACK to the original patch.

Thanks,
Srinivas

>=20
> Kai-Heng
>=20
> >=20
> > Thanks,
> > Srinivas
> >=20
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D ish_init(ishtp);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> > > @@ -256,6 +212,19 @@ static void ish_remove(struct pci_dev *pdev)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ish_device_disable(ishtp_d=
ev);
> > > =C2=A0}
> > >=20
> > > +
> > > +/**
> > > + * ish_shutdown() - PCI driver shutdown callback
> > > + * @pdev:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci device
> > > + *
> > > + * This function sets up wakeup for S5
> > > + */
> > > +static void ish_shutdown(struct pci_dev *pdev)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (pdev->device =3D=3D EHL_Ax_=
DEVICE_ID)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 pci_prepare_to_sleep(pdev);
> > > +}
> > > +
> > > =C2=A0static struct device __maybe_unused *ish_resume_device;
> > >=20
> > > =C2=A0/* 50ms to get resume response */
> > > @@ -378,13 +347,6 @@ static int __maybe_unused ish_resume(struct
> > > device *device)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct pci_dev *pdev =3D t=
o_pci_dev(device);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ishtp_device *dev =
=3D pci_get_drvdata(pdev);
> > >=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* add this to finish power flo=
w for EHL */
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (dev->pdev->device =3D=3D EH=
L_Ax_DEVICE_ID) {
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 pci_set_power_state(pdev, PCI_D0);
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 enable_pme_wake(pdev);
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 dev_dbg(dev->devc, "set power state to D0 for
> > > ehl\n");
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > -
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ish_resume_device =3D devi=
ce;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev->resume_flag =3D 1;
> > >=20
> > > @@ -400,6 +362,7 @@ static struct pci_driver ish_driver =3D {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .id_table =3D ish_pci_tbl,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .probe =3D ish_probe,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .remove =3D ish_remove,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .shutdown =3D ish_shutdown,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .driver.pm =3D &ish_pm_ops=
,
> > > =C2=A0};
> > >=20
> >=20


