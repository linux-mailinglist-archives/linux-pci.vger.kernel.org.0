Return-Path: <linux-pci+bounces-14719-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1DD9A18B4
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 04:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 116CA1F2655F
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 02:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB34753E15;
	Thu, 17 Oct 2024 02:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="iv13tJc4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADA13B1AC
	for <linux-pci@vger.kernel.org>; Thu, 17 Oct 2024 02:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729132877; cv=none; b=JJ1Vr0yLpZWaij7gkBG+YRFT/g9FloJfTZ46G1P9RN99gkV8hC4jHbaa9HMF6PnvLcLpfkMcKyzUTXDkguSXknFefrq/2N3yoWm5b/RXKifTVwJqghLU4+q9J/0HOHHhQVQGCPkR4s2IVgdTrJftMhisoqxBQN63Te44xXqU/vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729132877; c=relaxed/simple;
	bh=dLAnMTgfHyWEyMiXYcOAXUOFKE+kM6b7O9NeyGqvoVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oA8Psfb45fz1j/lOYTSEudpII3d7yDzbk9a+/l2VEWzbAHZOA0lI2Ox6bYuFbm92gUoJnqtebxIiYNVgwL3SsWk4FLc1CxlRVtCQrnkjJglbwDmSb0o23XjNoB5GHPOPRSoRKTjnEQuBNST3tbrXEvOxgDBboSjmNLK4RCk6jbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=iv13tJc4; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com [209.85.219.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id F0F803FE15
	for <linux-pci@vger.kernel.org>; Thu, 17 Oct 2024 02:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1729132865;
	bh=T24SWxRsUs3FH0Hfu2DAqNwIbPAhsue5M4uaumpInTc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=iv13tJc41pkw8vb4zR1FkzCooBmXcVfEm998BYZi9YNe8LtD+uCDWcCJzBNHf/ke+
	 RcnaFq6uy8kf4xd6TMdeBuCV6udRndbE/z0B8EY+en1K5XKBzpjfng46VIGcBCZzBO
	 0Z5A9C0qfOj/F7Io3mZ/XERCECXyLqW2rHDxZm40/5lLpL0FrR0SFzk9MZ6n2VdObG
	 zIXEYmtGnwO5juu/SJNDpcb1ew8reMHisaOFs9FEr3rPZXGKtPgtrNqlWqBghSH/cN
	 tZA2wobjmg9hMDbu50DboiCjuhjZ4xymnzmeTgockBsot7IJIp4CX+DEgTXu9+IiDF
	 IzeSD9ZtoM8rg==
Received: by mail-yb1-f197.google.com with SMTP id 3f1490d57ef6-e035949cc4eso644916276.1
        for <linux-pci@vger.kernel.org>; Wed, 16 Oct 2024 19:41:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729132862; x=1729737662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T24SWxRsUs3FH0Hfu2DAqNwIbPAhsue5M4uaumpInTc=;
        b=RpkIOl6Ltf4ePjsPHB2v2xAU2KblAXUmy/pxpV4f/5o+g4OTykHbRjU6CW5l4gGEUZ
         0H0uMR0DwyNtCAZJ0ymma0Xf06we9V7IWTkvNZT8A73piB+PyIuGXA3fabeMIfa1JOyf
         vU3DEWJDZP/Bxty51ArQC5Qj5N0LTwYkvDdG8Pw8XK14LNjQLK2+oBvwHhHHpg51SVq8
         NKo8hfJKwOatSc508ZL4+pyrZgjCHUG1eOeKHMsN0xiHyTjpGsCZPTPqKAyYjtjgriWL
         9tjybosUB10Py3CPFWqLjm/7nyJfOYwi1L1bTB3llkVEmlJa5CJk6BgV+nUR7uICny33
         1kSg==
X-Forwarded-Encrypted: i=1; AJvYcCUNr2GDMKeYCiV8McfMhwKTDM3RvkqELCPTZgYQgEHIJJwYSXsUQi8PssnOR3XjZMSI8uZF+vfEi9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA850C0HX1iyo6cIoEJdhWp0+6zXZxLVl9RlSn0052vbKOIQWF
	BaMDkqMrAJYOeLupmxJi1MCEAWxxMBj1zWymederCLXy0wmOwEd0Xvx8EI0Q0BOOEthUf19Qojs
	QCzHLiiFBYXMHghd2D8X6mM2lZsatMgC/Kygc8ffMijqzZUJMsxMmnJwOFIMXCoSu6o0NDeCB5G
	qDyyHjNnuK5EgMVjw5C7okDe48HA9CYMWqVSjwW9kUiXnnbpD9
X-Received: by 2002:a05:6902:124a:b0:e29:629f:8a7f with SMTP id 3f1490d57ef6-e297856bcccmr6141457276.35.1729132862605;
        Wed, 16 Oct 2024 19:41:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVIn6LC4RH+ZuMQpvyr93R7VXfYfB6DsvjjWy90VkucZ4oPJS9YJUKbITF5HdXuBCRiozOb9FMG4dEuo4pjMg=
X-Received: by 2002:a05:6902:124a:b0:e29:629f:8a7f with SMTP id
 3f1490d57ef6-e297856bcccmr6141453276.35.1729132862313; Wed, 16 Oct 2024
 19:41:02 -0700 (PDT)
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
In-Reply-To: <CAFv23Q=4O5czQaNw2mEnwkb9LQfODfQDeW+qQD14rfdeVEwjwA@mail.gmail.com>
From: AceLan Kao <acelan.kao@canonical.com>
Date: Thu, 17 Oct 2024 10:40:51 +0800
Message-ID: <CAFv23QmAOAobFC=4tkKBM4NQPR_b3Nsji5xa+TczUbAJ1dxhvg@mail.gmail.com>
Subject: Re: [PATCH] PCI: pciehp: Fix system hang on resume after hot-unplug
 during suspend
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

AceLan Kao <acelan.kao@canonical.com> =E6=96=BC 2024=E5=B9=B410=E6=9C=887=
=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=8812:34=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Lukas Wunner <lukas@wunner.de> =E6=96=BC 2024=E5=B9=B410=E6=9C=881=E6=97=
=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=887:03=E5=AF=AB=E9=81=93=EF=BC=9A
> >
> > On Tue, Oct 01, 2024 at 01:02:46PM +0200, Lukas Wunner wrote:
> > > On Mon, Sep 30, 2024 at 09:31:53AM +0800, AceLan Kao wrote:
> > > > Lukas Wunner <lukas@wunner.de> 2024 9 28 8:51:
> > > > > -       if (pci_get_dsn(pdev) !=3D ctrl->dsn)
> > > > > +       dsn =3D pci_get_dsn(pdev);
> > > > > +       if (!PCI_POSSIBLE_ERROR(dsn) &&
> > > > > +           dsn !=3D ctrl->dsn)
> > > > >                 return true;
> > > >
> > > > In my case, the pciehp_device_replaced() returns true from this fin=
al check.
> > > > And these are the values I got
> > > > dsn =3D 0x00000000, ctrl->dsn =3D 0x7800AA00
> > > > dsn =3D 0x00000000, ctrl->dsn =3D 0x21B7D000
> > >
> > > Ah because pci_get_dsn() returns 0 if the device is gone.
> > > Below is a modified patch which returns false in that case.
> >
> > Sorry, forgot to include the patch:
> >
> > -- >8 --
> >
> > diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pc=
iehp_core.c
> > index ff458e6..957c320 100644
> > --- a/drivers/pci/hotplug/pciehp_core.c
> > +++ b/drivers/pci/hotplug/pciehp_core.c
> > @@ -287,24 +287,32 @@ static int pciehp_suspend(struct pcie_device *dev=
)
> >  static bool pciehp_device_replaced(struct controller *ctrl)
> >  {
> >         struct pci_dev *pdev __free(pci_dev_put);
> > +       u64 dsn;
> >         u32 reg;
> >
> >         pdev =3D pci_get_slot(ctrl->pcie->port->subordinate, PCI_DEVFN(=
0, 0));
> >         if (!pdev)
> > +               return false;
> > +
> > +       if (pci_read_config_dword(pdev, PCI_VENDOR_ID, &reg) =3D=3D 0 &=
&
> > +           !PCI_POSSIBLE_ERROR(reg) &&
> > +           reg !=3D (pdev->vendor | (pdev->device << 16)))
> >                 return true;
> >
> > -       if (pci_read_config_dword(pdev, PCI_VENDOR_ID, &reg) ||
> > -           reg !=3D (pdev->vendor | (pdev->device << 16)) ||
> > -           pci_read_config_dword(pdev, PCI_CLASS_REVISION, &reg) ||
> > +       if (pci_read_config_dword(pdev, PCI_CLASS_REVISION, &reg) =3D=
=3D 0 &&
> > +           !PCI_POSSIBLE_ERROR(reg) &&
> >             reg !=3D (pdev->revision | (pdev->class << 8)))
> >                 return true;
> >
> >         if (pdev->hdr_type =3D=3D PCI_HEADER_TYPE_NORMAL &&
> > -           (pci_read_config_dword(pdev, PCI_SUBSYSTEM_VENDOR_ID, &reg)=
 ||
> > -            reg !=3D (pdev->subsystem_vendor | (pdev->subsystem_device=
 << 16))))
> > +           pci_read_config_dword(pdev, PCI_SUBSYSTEM_VENDOR_ID, &reg) =
=3D=3D 0 &&
> > +           !PCI_POSSIBLE_ERROR(reg) &&
> > +           reg !=3D (pdev->subsystem_vendor | (pdev->subsystem_device =
<< 16)))
> >                 return true;
> >
> > -       if (pci_get_dsn(pdev) !=3D ctrl->dsn)
> > +       if ((dsn =3D pci_get_dsn(pdev)) &&
> > +           !PCI_POSSIBLE_ERROR(dsn) &&
> > +           dsn !=3D ctrl->dsn)
> >                 return true;
> >
> >         return false;
> Hi Lukas,
>
> Sorry for the late reply, just encountered a strong typhoon in my area
> last week and can't check this in our lab.
>
> The patched pciehp_device_replaced() returns false at the end of the
> function in my case.
> Unplug the dock which is connected with a tbt storage won't be
> considered as a replacement.
>
> But when I tried to replace the dock with the tbt storage during
> suspend, it still returned false at the end of the function like
> unplugged.
>
> BTW, it's a new model, so I think the ICM is used. And the reg is
> 0xffffffff when unplugged.
Hi Lukas,

PCI_POSSIBLE_ERROR() always returns true no matter the device is
replaced or unplugged
It seems difficult to distinguish between when a device is replaced
and when it's unplugged.

Do you have any ideas to fix the issue?
This issue is severe to me, because the system hangs almost everytime
when daisy chain tbt devices are unplugged when suspended.
Thanks.

