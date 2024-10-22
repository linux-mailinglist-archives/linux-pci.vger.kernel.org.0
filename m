Return-Path: <linux-pci+bounces-15007-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 930D89AA2C2
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 15:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFA2A1C22107
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 13:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A5219DF98;
	Tue, 22 Oct 2024 13:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="DqO4IO0E"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A106619DF4F
	for <linux-pci@vger.kernel.org>; Tue, 22 Oct 2024 13:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729602366; cv=none; b=bR/D26rUZBfNZ3a4wblJ+aCEJHb2ppCiSDF39KP0agJn4PR3WUNCN7+yvSzBBku+AK2eY6n3RQthaQOOJOk9UDVayTuQJqi/31gohM1fWXNPHE+OUnRCwV2jUf+ImAJV/Z6UPGRWUzePLVDvY+jjjZtlz1YuG+3bWHWDWxAIVl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729602366; c=relaxed/simple;
	bh=eY7mpQBbU1G0VReE9nekoD13SERU82VMupF3O+8zGHQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pyyq3vLpFJpUAlNx6eKOaujwT0wz6cer+VcN1mJc1fhuHvByAN9XuFl+LYxllG6rS97ABiaMSOmKtkqy8yFh5n++QO3UmTgYo8c7JykEfYruDfydiH13T2nxs3BTibLXGSncW8PAMgVsLAMDkb+Q4nkAVmyWMkFtWPGBnsUF+X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=DqO4IO0E; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com [209.85.128.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0DAB33FA4D
	for <linux-pci@vger.kernel.org>; Tue, 22 Oct 2024 13:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1729602355;
	bh=0O0WVESJ/gBslREDRe+kHvdq3pwvvgnmmFBLBmZkHXY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=DqO4IO0EN8TRTx1OoXlMe4XhMhQufTgKOGWJJp0OUpA+KNB9S99nJnYEErUm3jD06
	 qBpENA/xPTXFZW82B5YX5TzBWS7SQDd8vKcAEulbQFl1Mbsk5rI9NrGA6bmL2u5i5A
	 eYyeR2so7j+iifTOkFDGma4xjl78TchuN59wcTbVMPjAVNGthxdiHRhukQnISF0dKV
	 Bp/RzaIvdZnmyPPl8ggpDfsVJC25Wg9/LfY8k0ETiSEJjSWpwl12BQwfdhw9rzOyUx
	 m76xXJ/1u3Uhqfzh0aPQfmu6zkDAC1jPQGwUMZTPTU08x8uQDkhCxVAJRls0FZtW9w
	 ER6TTzOz4zYSw==
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-6e3d6713619so99030427b3.2
        for <linux-pci@vger.kernel.org>; Tue, 22 Oct 2024 06:05:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729602354; x=1730207154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0O0WVESJ/gBslREDRe+kHvdq3pwvvgnmmFBLBmZkHXY=;
        b=qSV6flyi2EuTS/eOlesmH194ppYPs2KBjREWFulUFFsNautZ+O/va1v3n4XUxBtGfi
         nmlg54op4HYrUwCkoXgJ/NUhqEAGx2eA4FWCQM5mLCssE2fTW/BQ0iRrP0kSvUVWVPUJ
         fQeoPGaHRgoU4G1O6vhbxH/5Rz+OP6i3sPTfmv4/aHCiPSSRNfQcvfN5rvgjr/1n5lUc
         Qp/XD5ESkNAxVbzbdKUUKYPAleKimL9vXeh6E99YsN2X/VrQLeKGPGywoJ543vIJa0u+
         ctYeL1ctfVvpUabEVr+1NJsBQMYM1xMYssnCcVwTSO9+irsm25wTn4wgA2mgNramEPMV
         mX7w==
X-Forwarded-Encrypted: i=1; AJvYcCXbsdXYO4/aVIqpTRDa6yE/JbpGUXxhPjQhC7LDNuKTXmLVl3BaOfJ7wZlbzdMpp52HxDf7ZG8LDOk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJZZunCuH0sDqIKC/UIsQTKjXE0EJ/CRy8AGsxnkNagYsAgSO0
	G2swN2XVh4sWUkLkNYfPqailb0ZcEGY1JcEQ++e6InB2smrDBaXtAyCsd96ybYLAVUbCRj2yhgU
	eYg3tEnSkVWYz8ETMT+moZk99mHmL1dhiTXvBa4GVM2WGudf0jzfozLnB9r/eXWN/SD7bdu5GCa
	sq0xV0AZLga9Vb5lIV9JIHze8yPyivTrxzaTgjqg434LUkr6Uu
X-Received: by 2002:a05:690c:6488:b0:6e2:12e5:35a2 with SMTP id 00721157ae682-6e7d3a9d0efmr35481617b3.4.1729602352383;
        Tue, 22 Oct 2024 06:05:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxFH7L0Og3HjEiO0RR0AgMsyb3zr7MHcHrL6a+rQzlQXdmftWvF+5p4i1HxLWocDDzf5rvoAZPVYX7v9rfOlw=
X-Received: by 2002:a05:690c:6488:b0:6e2:12e5:35a2 with SMTP id
 00721157ae682-6e7d3a9d0efmr35479837b3.4.1729602350449; Tue, 22 Oct 2024
 06:05:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926125909.2362244-1-acelan.kao@canonical.com>
 <ZvVgTGVSco0Kg7H5@wunner.de> <CAFv23Q=5KdqDHYxf9PVO=kq=VqP0LwRaHQ-KnY2taDEkZ9Fueg@mail.gmail.com>
 <ZvZ61srt3QAca2AI@wunner.de> <Zvf7xYEA32VgLRJ6@wunner.de> <CAFv23QkwxmT7qrnbfEpJNN+mnevNAor6Dk7efvYNOdjR9tGyrw@mail.gmail.com>
 <ZvvW1ua2UjwHIOEN@wunner.de> <ZvvXDQSBRZMEI2EX@wunner.de> <CAFv23Q=4O5czQaNw2mEnwkb9LQfODfQDeW+qQD14rfdeVEwjwA@mail.gmail.com>
 <CAFv23QmAOAobFC=4tkKBM4NQPR_b3Nsji5xa+TczUbAJ1dxhvg@mail.gmail.com>
In-Reply-To: <CAFv23QmAOAobFC=4tkKBM4NQPR_b3Nsji5xa+TczUbAJ1dxhvg@mail.gmail.com>
From: AceLan Kao <acelan.kao@canonical.com>
Date: Tue, 22 Oct 2024 21:05:39 +0800
Message-ID: <CAFv23Q=HqyL4EGjG0VdsQH9rP0_DbRdpExbeJy6DAoKQ0OMbkA@mail.gmail.com>
Subject: Re: [PATCH] PCI: pciehp: Fix system hang on resume after hot-unplug
 during suspend
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

AceLan Kao <acelan.kao@canonical.com> =E6=96=BC 2024=E5=B9=B410=E6=9C=8817=
=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=8810:40=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> AceLan Kao <acelan.kao@canonical.com> =E6=96=BC 2024=E5=B9=B410=E6=9C=887=
=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=8812:34=E5=AF=AB=E9=81=93=EF=
=BC=9A
> >
> > Lukas Wunner <lukas@wunner.de> =E6=96=BC 2024=E5=B9=B410=E6=9C=881=E6=
=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=887:03=E5=AF=AB=E9=81=93=EF=BC=9A
> > >
> > > On Tue, Oct 01, 2024 at 01:02:46PM +0200, Lukas Wunner wrote:
> > > > On Mon, Sep 30, 2024 at 09:31:53AM +0800, AceLan Kao wrote:
> > > > > Lukas Wunner <lukas@wunner.de> 2024 9 28 8:51:
> > > > > > -       if (pci_get_dsn(pdev) !=3D ctrl->dsn)
> > > > > > +       dsn =3D pci_get_dsn(pdev);
> > > > > > +       if (!PCI_POSSIBLE_ERROR(dsn) &&
> > > > > > +           dsn !=3D ctrl->dsn)
> > > > > >                 return true;
> > > > >
> > > > > In my case, the pciehp_device_replaced() returns true from this f=
inal check.
> > > > > And these are the values I got
> > > > > dsn =3D 0x00000000, ctrl->dsn =3D 0x7800AA00
> > > > > dsn =3D 0x00000000, ctrl->dsn =3D 0x21B7D000
> > > >
> > > > Ah because pci_get_dsn() returns 0 if the device is gone.
> > > > Below is a modified patch which returns false in that case.
> > >
> > > Sorry, forgot to include the patch:
> > >
> > > -- >8 --
> > >
> > > diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/=
pciehp_core.c
> > > index ff458e6..957c320 100644
> > > --- a/drivers/pci/hotplug/pciehp_core.c
> > > +++ b/drivers/pci/hotplug/pciehp_core.c
> > > @@ -287,24 +287,32 @@ static int pciehp_suspend(struct pcie_device *d=
ev)
> > >  static bool pciehp_device_replaced(struct controller *ctrl)
> > >  {
> > >         struct pci_dev *pdev __free(pci_dev_put);
> > > +       u64 dsn;
> > >         u32 reg;
> > >
> > >         pdev =3D pci_get_slot(ctrl->pcie->port->subordinate, PCI_DEVF=
N(0, 0));
> > >         if (!pdev)
> > > +               return false;
> > > +
> > > +       if (pci_read_config_dword(pdev, PCI_VENDOR_ID, &reg) =3D=3D 0=
 &&
> > > +           !PCI_POSSIBLE_ERROR(reg) &&
> > > +           reg !=3D (pdev->vendor | (pdev->device << 16)))
> > >                 return true;
> > >
> > > -       if (pci_read_config_dword(pdev, PCI_VENDOR_ID, &reg) ||
> > > -           reg !=3D (pdev->vendor | (pdev->device << 16)) ||
> > > -           pci_read_config_dword(pdev, PCI_CLASS_REVISION, &reg) ||
> > > +       if (pci_read_config_dword(pdev, PCI_CLASS_REVISION, &reg) =3D=
=3D 0 &&
> > > +           !PCI_POSSIBLE_ERROR(reg) &&
> > >             reg !=3D (pdev->revision | (pdev->class << 8)))
> > >                 return true;
> > >
> > >         if (pdev->hdr_type =3D=3D PCI_HEADER_TYPE_NORMAL &&
> > > -           (pci_read_config_dword(pdev, PCI_SUBSYSTEM_VENDOR_ID, &re=
g) ||
> > > -            reg !=3D (pdev->subsystem_vendor | (pdev->subsystem_devi=
ce << 16))))
> > > +           pci_read_config_dword(pdev, PCI_SUBSYSTEM_VENDOR_ID, &reg=
) =3D=3D 0 &&
> > > +           !PCI_POSSIBLE_ERROR(reg) &&
> > > +           reg !=3D (pdev->subsystem_vendor | (pdev->subsystem_devic=
e << 16)))
> > >                 return true;
> > >
> > > -       if (pci_get_dsn(pdev) !=3D ctrl->dsn)
> > > +       if ((dsn =3D pci_get_dsn(pdev)) &&
> > > +           !PCI_POSSIBLE_ERROR(dsn) &&
> > > +           dsn !=3D ctrl->dsn)
> > >                 return true;
> > >
> > >         return false;
> > Hi Lukas,
> >
> > Sorry for the late reply, just encountered a strong typhoon in my area
> > last week and can't check this in our lab.
> >
> > The patched pciehp_device_replaced() returns false at the end of the
> > function in my case.
> > Unplug the dock which is connected with a tbt storage won't be
> > considered as a replacement.
> >
> > But when I tried to replace the dock with the tbt storage during
> > suspend, it still returned false at the end of the function like
> > unplugged.
> >
> > BTW, it's a new model, so I think the ICM is used. And the reg is
> > 0xffffffff when unplugged.
> Hi Lukas,
>
> PCI_POSSIBLE_ERROR() always returns true no matter the device is
> replaced or unplugged
> It seems difficult to distinguish between when a device is replaced
> and when it's unplugged.
>
> Do you have any ideas to fix the issue?
> This issue is severe to me, because the system hangs almost everytime
> when daisy chain tbt devices are unplugged when suspended.
> Thanks.
Hi Lukas,

I just submitted the v2, please help to review, thanks.
https://lore.kernel.org/linux-kernel/20241022130243.263737-1-acelan.kao@can=
onical.com/T/#u

