Return-Path: <linux-pci+bounces-16213-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F849C010B
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 10:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B8041C217CD
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 09:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D611E766F;
	Thu,  7 Nov 2024 09:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="q2MaKTSw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB0C1E5714
	for <linux-pci@vger.kernel.org>; Thu,  7 Nov 2024 09:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730971230; cv=none; b=KjKlx85pS9BH2C6tvPNobGcXEe5ROwsBpFExKsAT93kM9xO6HqXHg3PeDC+7AfZxmg0CtlrdNaL7asz7/JkKeN9SlNkowPRn8s4BqP3F1I8N1+wgTCBFHV6LHbBG9OXSiXisfBcl4SmrREhxq9C6z2va7TWWofDU6RokiRUGPzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730971230; c=relaxed/simple;
	bh=Z2djiIZh7ooFVrDJ8v7SqRHokkYt/FaY+xJq5xVJ5XU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B8wZv07SQlinB2z1ETN5YrA8iotPViZVQlmQQBqNW0o5qWYQJhuoQ6P9bW/Sk2Jx/qpFO+VxelN190MJADd7Iat/0tldf3M4iwJyzqQf0QFYZNZQ5sU0H81tTSxc2oKmw4HgKCZ79tq3v76qaaBk15coqUr/Ln9d2CIfy4rHAqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=q2MaKTSw; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6e35bf59cf6so17867307b3.0
        for <linux-pci@vger.kernel.org>; Thu, 07 Nov 2024 01:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1730971226; x=1731576026; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OsN0cWpGJ/MTLc7cqR68dQh7dqD09nHv7J2IUfD27PU=;
        b=q2MaKTSwRbIkjSb1AU05rQ+wKMc/E2ZOwI8MQUmab7nvUDbbMhoQ/SxrtgAOvcKOPg
         kA1hBLQAdFGAP/W8PiCRCkROGMANBDVz7xagSQo3sRWhc8Bzj4gHPp1mJLWJsm7L4BsP
         6hXOw3E/n1H6FgVu/wwKKElR2schoURO8ghTbuNAbRkDGaIb2NjFXVXhbWM/Mvgud2LV
         06gKNz/1UizGyFIo3CLh0P3cZN10FFUX6Q6pfafanAeUyf50KfDJbCwbKarHPBGDRbC8
         ih4wQiWhXCRVAurAFv3Q8D14L1dieo+l1iv6DJ647RQCpu8G1rMmmBopt9FY5GroRviE
         tYqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730971226; x=1731576026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OsN0cWpGJ/MTLc7cqR68dQh7dqD09nHv7J2IUfD27PU=;
        b=ZT+KGaI8k8Y66NzYj0JYyCPkAIl5hkSpcpQIvLEDYk2l3df5GAcnW5E/Ix+3bh6bWf
         6vDOlw6ulquWeGU0Oagz6YO5kEZ2AmDDBhrL/sJsYXrVg43MOCnE4bdvy81bLypP4Uwf
         OzBRCke7/QCAE9ekrwYCCHhCCkvbfsUFNBjaRNinaUZFPF5hevWbmDp5lJ0PwLRAR2Ln
         Jo56naKwsc12OwzExfetzn0Ke9FXPmfQ80LCTxh8u+xCpmqXMnaWiqikiUqqqOW2AYy5
         0gM92CK4kyR9dH5062zTuirpApkOduljjX34127hSF/aCd4aPyUo1bnM6T91B58pgYV5
         Z6vg==
X-Forwarded-Encrypted: i=1; AJvYcCWgWWQgZ55hpIOT6Uw1pG+dO+6bd3l6gwnOoTEgpmZxXREEnuTJ2aFIojDXIEHHRjwXrdcqpwZooiM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwysfnJbVOWY4LFT8s0PoKa419yUwaP7EbVCj4h6qeibx81Na52
	CRjR5X/0sNGdLSG0DXJISffO4bPV4mQsvSKc1G92D9K94kMU8LcgFGyHozwL+Cum4l4wfYEqBmP
	ZhcmH/E+Xb9NrPnLHe4gs1eAGaNwqzNW/ytdGgQ==
X-Google-Smtp-Source: AGHT+IGcAc3lXtICcPQa8jdnTyc2K3zO4Cuz/nWrZDB2qFhi9B3f8JUVHHqnfaebukAFlvHjNNz3PtabAC7EHVZ/XpU=
X-Received: by 2002:a05:690c:6709:b0:652:e900:550a with SMTP id
 00721157ae682-6ead6432f2bmr2252897b3.19.1730971225660; Thu, 07 Nov 2024
 01:20:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001083438.10070-8-jhp@endlessos.org> <20241105225949.GA1493775@bhelgaas>
In-Reply-To: <20241105225949.GA1493775@bhelgaas>
From: Jian-Hong Pan <jhp@endlessos.org>
Date: Thu, 7 Nov 2024 17:19:49 +0800
Message-ID: <CAPpJ_ecu077+7G=J4w_9LMqw4ZX5qt4H9EirOL-O3nN-peqtfg@mail.gmail.com>
Subject: Re: [PATCH v12 3/3] PCI/ASPM: Make pci_save_aspm_l1ss_state save both
 child and parent's L1SS configuration
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Johan Hovold <johan@kernel.org>, David Box <david.e.box@linux.intel.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	Nirmal Patel <nirmal.patel@linux.intel.com>, 
	Jonathan Derrick <jonathan.derrick@linux.dev>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux@endlessos.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Bjorn Helgaas <helgaas@kernel.org> =E6=96=BC 2024=E5=B9=B411=E6=9C=886=E6=
=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=886:59=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Tue, Oct 01, 2024 at 04:34:42PM +0800, Jian-Hong Pan wrote:
> > PCI devices' parameters on the VMD bus have been programmed properly
> > originally. But, cleared after pci_reset_bus() and have not been restor=
ed
> > correctly. This leads the link's L1.2 between PCIe Root Port and child
> > device gets wrong configs.
> >
> > Here is a failed example on ASUS B1400CEAE with enabled VMD. Both PCIe
> > bridge and NVMe device should have the same LTR1.2_Threshold value.
> > However, they are configured as different values in this case:
> >
> > 10000:e0:06.0 PCI bridge [0604]: Intel Corporation 11th Gen Core Proces=
sor PCIe Controller [8086:9a09] (rev 01) (prog-if 00 [Normal decode])
> >   ...
> >   Capabilities: [200 v1] L1 PM Substates
> >     L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Sub=
states+
> >       PortCommonModeRestoreTime=3D45us PortTPowerOnTime=3D50us
> >     L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
> >       T_CommonMode=3D0us LTR1.2_Threshold=3D0ns
> >     L1SubCtl2: T_PwrOn=3D0us
> >
> > 10000:e1:00.0 Non-Volatile memory controller [0108]: Sandisk Corp WD Bl=
ue SN550 NVMe SSD [15b7:5009] (rev 01) (prog-if 02 [NVM Express])
> >   ...
> >   Capabilities: [900 v1] L1 PM Substates
> >     L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1- L1_PM_Sub=
states+
> >       PortCommonModeRestoreTime=3D32us PortTPowerOnTime=3D10us
> >     L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
> >       T_CommonMode=3D0us LTR1.2_Threshold=3D101376ns
> >     L1SubCtl2: T_PwrOn=3D50us
> >
> > Here is VMD mapped PCI device tree:
> >
> > -+-[0000:00]-+-00.0  Intel Corporation Device 9a04
> >  | ...
> >  \-[10000:e0]-+-06.0-[e1]----00.0  Sandisk Corp WD Blue SN550 NVMe SSD
> >               \-17.0  Intel Corporation Tiger Lake-LP SATA Controller
> >
> > When pci_reset_bus() resets the bus [e1] of the NVMe, it only saves and
> > restores NVMe's state before and after reset. Then, when it restores th=
e
> > NVMe's state, ASPM code restores L1SS for both the parent bridge and th=
e
> > NVMe in pci_restore_aspm_l1ss_state(). The NVMe's L1SS is restored
> > correctly. But, the parent bridge's L1SS is restored with a wrong value=
 0x0
> > because the parent bridge's L1SS wasn't saved by pci_save_aspm_l1ss_sta=
te()
> > before reset.
>
> There's nothing specific to VMD here, is there?  This whole log looks
> like it should be made generic.  The VMD *example* is OK, but the
> justification should not be VMD-specific.  This last paragraph seems
> to be the kernel of the whole thing, and I don't think it's specific
> to either VMD or NVMe.

It is a generic fix. Lets see how to modify the wording here.

> > So, if the PCI device has a parent, make pci_save_aspm_l1ss_state() sav=
e
> > the parent's L1SS configuration, too. This is symmetric on
> > pci_restore_aspm_l1ss_state().
> >
> > Link: https://lore.kernel.org/linux-pci/CAPpJ_eexU0gCHMbXw_z924WxXw0+B6=
SdS4eG9oGpEX1wmnMLkQ@mail.gmail.com/
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D218394
> > Fixes: 17423360a27a ("PCI/ASPM: Save L1 PM Substates Capability for sus=
pend/resume")
> > Suggested-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> > Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
> > ---
> > v9:
> > - Drop the v8 fix about drivers/pci/pcie/aspm.c. Use this in VMD instea=
d.
> >
> > v10:
> > - Drop the v9 fix about drivers/pci/controller/vmd.c
> > - Fix in PCIe ASPM to make it symmetric between pci_save_aspm_l1ss_stat=
e()
> >   and pci_restore_aspm_l1ss_state()
> >
> > v11:
> > - Introduce __pci_save_aspm_l1ss_state as a resusable helper function
> >   which is same as the original pci_configure_aspm_l1ss
> > - Make pci_save_aspm_l1ss_state invoke __pci_save_aspm_l1ss_state for
> >   both child and parent devices
> > - Smooth the commit message
> >
> > v12:
> > - Update the commit message
> >
> >  drivers/pci/pcie/aspm.c | 20 +++++++++++++++++++-
> >  1 file changed, 19 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > index bd0a8a05647e..17cdf372f7e0 100644
> > --- a/drivers/pci/pcie/aspm.c
> > +++ b/drivers/pci/pcie/aspm.c
> > @@ -79,7 +79,7 @@ void pci_configure_aspm_l1ss(struct pci_dev *pdev)
> >                       ERR_PTR(rc));
> >  }
> >
> > -void pci_save_aspm_l1ss_state(struct pci_dev *pdev)
> > +static void __pci_save_aspm_l1ss_state(struct pci_dev *pdev)
> >  {
> >       struct pci_cap_saved_state *save_state;
> >       u16 l1ss =3D pdev->l1ss;
> > @@ -101,6 +101,24 @@ void pci_save_aspm_l1ss_state(struct pci_dev *pdev=
)
> >       pci_read_config_dword(pdev, l1ss + PCI_L1SS_CTL1, cap++);
> >  }
> >
> > +void pci_save_aspm_l1ss_state(struct pci_dev *pdev)
> > +{
> > +     struct pci_dev *parent;
> > +
> > +     __pci_save_aspm_l1ss_state(pdev);
>
> Is there any point in saving the "pdev" state if there's no parent?

This is a tricky part.  If the code path comes from:
pci_save_state()
    pci_save_pcie_state()
        pci_save_aspm_l1ss_state()

and the pci device is a PCIe bridge, then should the device save ASPM
L1SS state?

1. This code tries to save its ASPM L1SS state directly. Then, when
the child device saves ASPM L1SS state, it does not need to save the
PCIe bridge's ASPM L1SS state again.

2 .However, if we shift this "__pci_save_aspm_l1ss_state(pdev);" after
"if (!pdev->bus || !pdev->bus->self)" condition check, then it should
save both the device and parent's ASPM L1SS state. Because, PCIe
bridge does not have a parent device and will not save its ASPM L1SS
state by itself.

Following the 2nd scenario, is it possible to only save & restore a
PCIe bridge, and not touch children devices?  In this condition,
pci_restore_aspm_l1ss_state() will not restore the PCIe bridge's ASPM
L1SS state itself, because it does not have a parent. Only the child
device can restore the PCIe bridge's ASPM L1SS state via
pci_restore_aspm_l1ss_state(). So, lets trace who invoke
pci_restore_aspm_l1ss_state():
pci_restore_state()
    "dev->state_saved" condition check
    dev->state_saved()
        pci_restore_aspm_l1ss_state()

The "dev->state_saved" condition check guards it. If the child device
has not been saved, then it will not go to restoration. So, the parent
device's ASPM L1SS state will not be restored by 0. =3D> Okay

Consider that ASPM L1SS only works when both the link's parent and
child devices are configured and powered correctly. The 2nd scenario
seems to make more sense.

> > +     /*
> > +      * To be symmetric on pci_restore_aspm_l1ss_state(), save parent'=
s L1
> > +      * substate configuration, if the parent has not saved state.
> > +      */
> > +     if (!pdev->bus || !pdev->bus->self)
> > +             return;
>
> Is "pdev->bus =3D=3D NULL" possible here even though it doesn't seem
> possible in pci_restore_aspm_l1ss_state()?

After boot & test again and again, it seems the devices already have
their bus at this point.

However, after I traced the code, I found two possible paths:
1. pcie_config_aspm_link() -> pci_save_aspm_l1ss_state():  Here is
already the link.  So, has the bus.
2. pci_save_state() -> pci_save_pcie_state() ->
pci_save_aspm_l1ss_state(): pci_save_state() is an exported function
which can be invoked at any point. So, I am not sure about this part.
And, that is why I make it check "pdev->bus =3D=3D NULL" here.

Jian-Hong Pan

> > +     parent =3D pdev->bus->self;
> > +     if (!parent->state_saved)
> > +             __pci_save_aspm_l1ss_state(parent);
> > +}
>
> I see the suggestion for a helper here, but I'm not convinced.
> pci_save_aspm_l1ss_state() and pci_restore_aspm_l1ss_state() should
> *look* similar, and a helper makes them less similar.
>
> I think you should go to some effort to follow the
> pci_restore_aspm_l1ss_state() structure, as much as possible doing the
> same declarations, checks, and lookups in the same order, e.g.:
>
>   struct pci_cap_saved_state *pl_save_state, *cl_save_state;
>   struct pci_dev *parent =3D pdev->bus->self;
>
>   if (pcie_downstream_port(pdev) || !parent)
>           return;
>
>   if (!pdev->l1ss || !parent->l1ss)
>           return;
>
>   cl_save_state =3D pci_find_saved_ext_cap(pdev, PCI_EXT_CAP_ID_L1SS);
>   pl_save_state =3D pci_find_saved_ext_cap(parent, PCI_EXT_CAP_ID_L1SS);
>   if (!cl_save_state || !pl_save_state)
>           return;
>
> Bjorn

