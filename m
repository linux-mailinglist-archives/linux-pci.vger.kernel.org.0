Return-Path: <linux-pci+bounces-13923-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 367249923A4
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 06:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 587AC1C20BD4
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 04:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C4A61FCE;
	Mon,  7 Oct 2024 04:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="NCoARZm4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A103910A1C
	for <linux-pci@vger.kernel.org>; Mon,  7 Oct 2024 04:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728275672; cv=none; b=DIEjah7H/8ow7fVgzakPgtT+S0VBaizSe2GkwUz7EoLWIMdjdlXP9DnqiZz0CjUNejxKfAd6tIjHe5KsMKVEys/L6IRhq0s9oMwlP2QUAlDmcCzKKIM8MiMQnL76IJNzMPn6hy/L04gz0rVOtq2IBqOI/erpMpEGKo1R9sitkn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728275672; c=relaxed/simple;
	bh=xtVT0IFCi2Qto8kpSQiCGlBpvaMpt3JFkS6nS7bOX5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m+ROxLUZjO/fuzsFNmBPm+BQZIuAI+mNwpVjakl+f/313SHK0Iqvu4D/LvFCbyHOPvPAWUiJj1Te9ASLo+ooq1UvtO9PRynVTs12bvlS24RMehG8VF4JAaUh/07KVAUASLVzkZK8EED3oESUmjeFFSH/fDAiI1gVx6OpEFqBdPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=NCoARZm4; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com [209.85.219.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C3EA33F1BD
	for <linux-pci@vger.kernel.org>; Mon,  7 Oct 2024 04:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1728275661;
	bh=RKS/f2MF9K/DRHRfB0v5ZmIcK+e+Ci2Bwh5D2AMKYp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=NCoARZm4YObPF2EsJ5tKPaNNxW2XDvdETMAB1/B8zTiBbu1HrsOuzMksk1j+G/nB2
	 hMfRMQYjk95NVLBDFHpjhwso0pAJA0AHJje8qRQAt+SL6jdPwPNkYoac9m1GxZq25u
	 qe7nVrUCpw5PkSMCChi3KmHjEgc6oBEQjEWfag+L7tXX9Vx4mTi8cn/NCJNv14ubfO
	 ZQVhKgMaKF+Q1LhvzzUjJG5apymS0IplC0rLbOjurOFBj9FoIx9iWcdtHXciS72YGK
	 tUcD5Sy2PTkZFyKmhVUZpUAzyQHoQX6xR5/VEe92tH5nlIVdDShIZ74FZ79F0MKr+A
	 oR6aCrHgo7P2w==
Received: by mail-yb1-f199.google.com with SMTP id 3f1490d57ef6-e165fc5d94fso6139366276.2
        for <linux-pci@vger.kernel.org>; Sun, 06 Oct 2024 21:34:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728275660; x=1728880460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RKS/f2MF9K/DRHRfB0v5ZmIcK+e+Ci2Bwh5D2AMKYp8=;
        b=iwMSIZ2GaqKU+Alb88HCa3S04fo6oITbchhXhPZ+E7w92vyBfTtPxDoO49gdJkts0p
         qAdZ99BfnKZTePgRVkPQxlhrLDJPDP3UOpGDPeu3jyNbwCNSAbO6NaDL8nuR4FbRokCa
         3jEetjV7mbjpFs0g181r5fq6WH44uLUTm7YMBM91e8yEyXpaeddfnuDftbaATq2JQbcN
         KlIDnuxnM++VPel8etbuDAWXAybHZEigEulEEUz2Kz8uwFcpTaMWZFNq7chuEUbcey0s
         4YKAQOqfuJm2hEgnqZlqVoTTq7vVuyDF9O9tR1jVlu0rTfVpYJdVn3VWfS+W22dxhVd9
         ZyKg==
X-Forwarded-Encrypted: i=1; AJvYcCXOFsCWmViioGxwKPxUTjcMrMCn7T4Kl1uIvxGM3JWGzk3GRL+ym4L/kWFOuZeeFKlWD5LRO53L6lM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfVzDPTS1fAVBmt3BTfC5i6TmPzfmBZgkSELM4AFSRFeKpso1T
	3i/xxIcJTW5SW00YydLLO6O6b3WsGekqbxKfM/UFPq9sMfiovUN/dne9agKGVcwU0tQFAWQc6lz
	vAONUDG/Ql8Iq7rYCIs6aZJrXUIPwS5YgC2qskx3ZV9VFpTzJc5sf0V8xYKGTMjEgKq+jRqx8jW
	KTpw1ZhMHMiUo22YATDHSvBYC2oPEEnyIh1P4nOGiu3EX01akg
X-Received: by 2002:a05:6902:2388:b0:e22:5b1b:f1f1 with SMTP id 3f1490d57ef6-e28936d681cmr7110372276.22.1728275660431;
        Sun, 06 Oct 2024 21:34:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHi3j06zDsu+UMiFSC0YAaoU5Gwv3GT9ajM093Bdzuvg/07VdqPhd1wdUbzIXoRnTEH9VD+2v/cf2IOe3HLgE=
X-Received: by 2002:a05:6902:2388:b0:e22:5b1b:f1f1 with SMTP id
 3f1490d57ef6-e28936d681cmr7110367276.22.1728275660149; Sun, 06 Oct 2024
 21:34:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926125909.2362244-1-acelan.kao@canonical.com>
 <ZvVgTGVSco0Kg7H5@wunner.de> <CAFv23Q=5KdqDHYxf9PVO=kq=VqP0LwRaHQ-KnY2taDEkZ9Fueg@mail.gmail.com>
 <ZvZ61srt3QAca2AI@wunner.de> <Zvf7xYEA32VgLRJ6@wunner.de> <CAFv23QkwxmT7qrnbfEpJNN+mnevNAor6Dk7efvYNOdjR9tGyrw@mail.gmail.com>
 <ZvvW1ua2UjwHIOEN@wunner.de> <ZvvXDQSBRZMEI2EX@wunner.de>
In-Reply-To: <ZvvXDQSBRZMEI2EX@wunner.de>
From: AceLan Kao <acelan.kao@canonical.com>
Date: Mon, 7 Oct 2024 12:34:09 +0800
Message-ID: <CAFv23Q=4O5czQaNw2mEnwkb9LQfODfQDeW+qQD14rfdeVEwjwA@mail.gmail.com>
Subject: Re: [PATCH] PCI: pciehp: Fix system hang on resume after hot-unplug
 during suspend
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Lukas Wunner <lukas@wunner.de> =E6=96=BC 2024=E5=B9=B410=E6=9C=881=E6=97=A5=
 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=887:03=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Tue, Oct 01, 2024 at 01:02:46PM +0200, Lukas Wunner wrote:
> > On Mon, Sep 30, 2024 at 09:31:53AM +0800, AceLan Kao wrote:
> > > Lukas Wunner <lukas@wunner.de> 2024 9 28 8:51:
> > > > -       if (pci_get_dsn(pdev) !=3D ctrl->dsn)
> > > > +       dsn =3D pci_get_dsn(pdev);
> > > > +       if (!PCI_POSSIBLE_ERROR(dsn) &&
> > > > +           dsn !=3D ctrl->dsn)
> > > >                 return true;
> > >
> > > In my case, the pciehp_device_replaced() returns true from this final=
 check.
> > > And these are the values I got
> > > dsn =3D 0x00000000, ctrl->dsn =3D 0x7800AA00
> > > dsn =3D 0x00000000, ctrl->dsn =3D 0x21B7D000
> >
> > Ah because pci_get_dsn() returns 0 if the device is gone.
> > Below is a modified patch which returns false in that case.
>
> Sorry, forgot to include the patch:
>
> -- >8 --
>
> diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pcie=
hp_core.c
> index ff458e6..957c320 100644
> --- a/drivers/pci/hotplug/pciehp_core.c
> +++ b/drivers/pci/hotplug/pciehp_core.c
> @@ -287,24 +287,32 @@ static int pciehp_suspend(struct pcie_device *dev)
>  static bool pciehp_device_replaced(struct controller *ctrl)
>  {
>         struct pci_dev *pdev __free(pci_dev_put);
> +       u64 dsn;
>         u32 reg;
>
>         pdev =3D pci_get_slot(ctrl->pcie->port->subordinate, PCI_DEVFN(0,=
 0));
>         if (!pdev)
> +               return false;
> +
> +       if (pci_read_config_dword(pdev, PCI_VENDOR_ID, &reg) =3D=3D 0 &&
> +           !PCI_POSSIBLE_ERROR(reg) &&
> +           reg !=3D (pdev->vendor | (pdev->device << 16)))
>                 return true;
>
> -       if (pci_read_config_dword(pdev, PCI_VENDOR_ID, &reg) ||
> -           reg !=3D (pdev->vendor | (pdev->device << 16)) ||
> -           pci_read_config_dword(pdev, PCI_CLASS_REVISION, &reg) ||
> +       if (pci_read_config_dword(pdev, PCI_CLASS_REVISION, &reg) =3D=3D =
0 &&
> +           !PCI_POSSIBLE_ERROR(reg) &&
>             reg !=3D (pdev->revision | (pdev->class << 8)))
>                 return true;
>
>         if (pdev->hdr_type =3D=3D PCI_HEADER_TYPE_NORMAL &&
> -           (pci_read_config_dword(pdev, PCI_SUBSYSTEM_VENDOR_ID, &reg) |=
|
> -            reg !=3D (pdev->subsystem_vendor | (pdev->subsystem_device <=
< 16))))
> +           pci_read_config_dword(pdev, PCI_SUBSYSTEM_VENDOR_ID, &reg) =
=3D=3D 0 &&
> +           !PCI_POSSIBLE_ERROR(reg) &&
> +           reg !=3D (pdev->subsystem_vendor | (pdev->subsystem_device <<=
 16)))
>                 return true;
>
> -       if (pci_get_dsn(pdev) !=3D ctrl->dsn)
> +       if ((dsn =3D pci_get_dsn(pdev)) &&
> +           !PCI_POSSIBLE_ERROR(dsn) &&
> +           dsn !=3D ctrl->dsn)
>                 return true;
>
>         return false;
Hi Lukas,

Sorry for the late reply, just encountered a strong typhoon in my area
last week and can't check this in our lab.

The patched pciehp_device_replaced() returns false at the end of the
function in my case.
Unplug the dock which is connected with a tbt storage won't be
considered as a replacement.

But when I tried to replace the dock with the tbt storage during
suspend, it still returned false at the end of the function like
unplugged.

BTW, it's a new model, so I think the ICM is used. And the reg is
0xffffffff when unplugged.

