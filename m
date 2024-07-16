Return-Path: <linux-pci+bounces-10386-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3571493309C
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 20:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D5041C225DA
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 18:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1F11865A;
	Tue, 16 Jul 2024 18:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dgu+pFe9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930641A0721
	for <linux-pci@vger.kernel.org>; Tue, 16 Jul 2024 18:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721155229; cv=none; b=r4QeH1yJQXPfDtuZ9pO39ULXp5pmH5x4xz1d5NniZYYAhbxjRhgPH+ulEb0/B9PVrUCkxKxQh5Ph1gLxyD5NA0A8Axd3VYyV78ic9IWIi39B/VoeO32wkj2+YSbk6B0nuIa175IfC6wRCuNZJ9kERrgmpXLGeSn4T+8JRY2edyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721155229; c=relaxed/simple;
	bh=A87HOUG6+9xwLR23GtMwGJtZ/vVggG6YaUeEtaq7Irw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pl1e+uJTMSldh22wSQPl7vCaulTKzY4kT4lU4TM8K3mVypEV46Ohjc628zzUeM7T35dwz4yM2NnX5nORVtssn28iynZDmAKQbbqUWfYa7WprjonUOEK52NNdcol4W4AmxWX7y5wzKnLd/sUjcImEb/SjntpzLbgexsoeIgT/Obo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=dgu+pFe9; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52e991fb456so49158e87.0
        for <linux-pci@vger.kernel.org>; Tue, 16 Jul 2024 11:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1721155226; x=1721760026; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uxFH1xlCAYogLRhCxFan2jbOMTtLYcue7VwAgUx997c=;
        b=dgu+pFe9598IovWwVzP4hEALMwz3UGbGiVKJGkMmsC7tQO+G/VSh6DIO8H7bSgerET
         Q091iEFGMopc1cilRZuUqx1wXIOtG+vPNPv32mt5q8g7HYWDWn3wXhRilR+gK87I0fL/
         vNIYdg8nq0VLraYRRzVl64aQ3V7w1eZJ4cwyg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721155226; x=1721760026;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uxFH1xlCAYogLRhCxFan2jbOMTtLYcue7VwAgUx997c=;
        b=fQvnNZCRgJlprHnJUG3+Jy9AnEqCNlKFQi07oZAMzwurWexzT0MjpfYqdWqB1x3oJ9
         59sU15EvRg4VwdwPtjJMkyFMkCnk7u8To0cj/NIotZkNMt68VkAO2ABhQkgSVc0eYFvf
         FKzG2NJKL8qjiteXbcHxJ/vrKL25qUJDgr/DOHTaIbVslmmc9EHBFGV+ekbLgIJy5twR
         NxTje4hCZlH+aB5o/u2YUqMPUH0QAKBcQvdI475sFl18pCQKM2VOiWswzaxD/iWMPOMm
         CMs0wipdctSjYbbMB630wgKelfeh9cIi3brww3wSflwFB9xCQG4Rj0iYK5lKNq3GCflS
         zC5w==
X-Gm-Message-State: AOJu0YwKRa2lv29dRByHI98NFGXNk/JnvcvPPEbHAB+hhVwyFhC7wNJx
	Cy5OgQOD3kDiV6uZwXSSukhpeiHEz7rY/H08pG8IW/46Ab+2M/Gz4G8TkEs6CCUjpt/mDNy6A+7
	1wi4yy6NwxrHmJcm9kixtSxhOuBKBRDlhrvEQ
X-Google-Smtp-Source: AGHT+IFQWYhaatNkNcnR4OmPcdynabPJtnbQp06s66aEd+oS8DUbbupnwIQI6XOFwtY8kFkW1DunOz5r5zOzEakNF1M=
X-Received: by 2002:a05:6512:3981:b0:52b:c233:113b with SMTP id
 2adb3069b0e04-52edf8bec51mr810783e87.15.1721155225666; Tue, 16 Jul 2024
 11:40:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710221630.29561-1-james.quinlan@broadcom.com>
 <20240710221630.29561-5-james.quinlan@broadcom.com> <2c539dc6-bfb1-4dbe-8fbd-4dc04984f473@marvell.com>
In-Reply-To: <2c539dc6-bfb1-4dbe-8fbd-4dc04984f473@marvell.com>
From: Jim Quinlan <james.quinlan@broadcom.com>
Date: Tue, 16 Jul 2024 14:40:13 -0400
Message-ID: <CA+-6iNxm0mVDKWAH1P8ZYs5cVf7YEKSeM-r38Re8ST2v8+BKXQ@mail.gmail.com>
Subject: Re: [PATCH v3 04/12] PCI: brcmstb: Use bridge reset if available
To: Amit Singh Tomar <amitsinght@marvell.com>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
	Cyril Brulebois <kibi@debian.org>, Stanimir Varbanov <svarbanov@suse.de>, 
	Krzysztof Kozlowski <krzk@kernel.org>, bcm-kernel-feedback-list@broadcom.com, 
	jim2101024@gmail.com, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000da5c95061d61ad62"

--000000000000da5c95061d61ad62
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 13, 2024 at 3:12=E2=80=AFPM Amit Singh Tomar <amitsinght@marvel=
l.com> wrote:
>
> On 7/11/2024 3:46 AM, Jim Quinlan wrote:
> > The 7712 SOC has a bridge reset which can be described in the device tr=
ee.
> > If it is present, use it. Otherwise, continue to use the legacy method =
to
> > reset the bridge.
> >
> > Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> > ---
> >   drivers/pci/controller/pcie-brcmstb.c | 22 +++++++++++++++++-----
> >   1 file changed, 17 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/contro=
ller/pcie-brcmstb.c
> > index c257434edc08..92816d8d215a 100644
> > --- a/drivers/pci/controller/pcie-brcmstb.c
> > +++ b/drivers/pci/controller/pcie-brcmstb.c
> > @@ -265,6 +265,7 @@ struct brcm_pcie {
> >       enum pcie_type          type;
> >       struct reset_control    *rescal;
> >       struct reset_control    *perst_reset;
> > +     struct reset_control    *bridge;
> >       int                     num_memc;
> >       u64                     memc_size[PCIE_BRCM_MAX_MEMC];
> >       u32                     hw_rev;
> > @@ -732,12 +733,19 @@ static void __iomem *brcm7425_pcie_map_bus(struct=
 pci_bus *bus,
> >
> >   static void brcm_pcie_bridge_sw_init_set_generic(struct brcm_pcie *pc=
ie, u32 val)
> >   {
> > -     u32 tmp, mask =3D  RGR1_SW_INIT_1_INIT_GENERIC_MASK;
> > -     u32 shift =3D RGR1_SW_INIT_1_INIT_GENERIC_SHIFT;
> > +     if (pcie->bridge) {
> > +             if (val)
> > +                     reset_control_assert(pcie->bridge);
> > +             else
> > +                     reset_control_deassert(pcie->bridge);
> > +     } else {
> > +             u32 tmp, mask =3D  RGR1_SW_INIT_1_INIT_GENERIC_MASK;
> > +             u32 shift =3D RGR1_SW_INIT_1_INIT_GENERIC_SHIFT;
> >
> > -     tmp =3D readl(pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
> > -     tmp =3D (tmp & ~mask) | ((val << shift) & mask);
> > -     writel(tmp, pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
> > +             tmp =3D readl(pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
> > +             tmp =3D (tmp & ~mask) | ((val << shift) & mask);
> > +             writel(tmp, pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
> > +     }
> >   }
> >
> >   static void brcm_pcie_bridge_sw_init_set_7278(struct brcm_pcie *pcie,=
 u32 val)
> > @@ -1621,6 +1629,10 @@ static int brcm_pcie_probe(struct platform_devic=
e *pdev)
> >       if (IS_ERR(pcie->perst_reset))
> >               return PTR_ERR(pcie->perst_reset);
> >
> > +     pcie->bridge =3D devm_reset_control_get_optional_exclusive(&pdev-=
>dev, "bridge");
> > +     if (IS_ERR(pcie->bridge))
> > +             return PTR_ERR(pcie->bridge);
> How about using "dev_err_probe," which utilizes "dev_err" for logging
> error messages and recording the deferred probe reason?

Hello Amit,

Someone else brought this up and I want to defer moving to
dev_err_probe() in a future series.  I'd like to get this series out
now as Stan is waiting to apply his commits on top of it.

Regards,
Jim Quinlan
Broadcom STB/CM
> > +
> >       ret =3D clk_prepare_enable(pcie->clk);
> >       if (ret) {
> >               dev_err(&pdev->dev, "could not enable clock\n");
>

--000000000000da5c95061d61ad62
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
mOAplh6h3nMZUZxBguxG3g2p3iD4EgibUYneEzqOQafIQB/naf2uetKb8y9jKgWJxq2Y4y8Jqg2u
uVIO1AyOJjWwqdgN+QhuIlat+qZd03P48Gim9ZPEMDUCAwEAAaOCAdswggHXMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJQYDVR0R
BB4wHIEaamFtZXMucXVpbmxhbkBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYBBQUHAwQwHwYD
VR0jBBgwFoAUljPR5lgXWzR1ioFWZNW+SN6hj88wHQYDVR0OBBYEFGx/E27aeGBP2eJktrILxlhK
z8f6MA0GCSqGSIb3DQEBCwUAA4IBAQBdQQukiELsPfse49X4QNy/UN43dPUw0I1asiQ8wye3nAuD
b3GFmf3SZKlgxBTdWJoaNmmUFW2H3HWOoQBnTeedLtV9M2Tb9vOKMncQD1f9hvWZR6LnZpjBIlKe
+R+v6CLF07qYmBI6olvOY/Rsv9QpW9W8qZYk+2RkWHz/fR5N5YldKlJHP0NDT4Wjc5fEzV+mZC8A
AlT80qiuCVv+IQP08ovEVSLPhUp8i1pwsHT9atbWOfXQjbq1B/ditFIbPzwmwJPuGUc7n7vpmtxB
75sSFMj27j4JXl5W9vORgHR2YzuPBzfzDJU1ul0DIofSWVF6E1dx4tZohRED1Yl/T/ZGMYICbTCC
AmkCAQEwazBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UE
AxMoR2xvYmFsU2lnbiBHQ0MgUjMgUGVyc29uYWxTaWduIDIgQ0EgMjAyMAIMSO43VW7D5NP1X/KD
MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCiujplngl4NNsotEkr8nBGSnWWdjpa
jUsgI0+ZEvzhZTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNDA3
MTYxODQwMjZaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQME
AgEwDQYJKoZIhvcNAQEBBQAEggEAcCo/sWpjO1wf261J3mose5IWDoJIfrOC9JX6m+JPIqz3eQO+
YI1SK2z2Qo8ncnK+UC/3K9URX8M6wL/NvyrL9j0NZ2Kr0rIPdUwBYpML4vE67E8WOARLoUx4MjVi
JykVvbwh+ZljQ/bL3B+d9VkbVyOEgh6XrnVpHI+wMOE7jT++EmWJZJD7wBXve/eiWB725GLIXb8B
91Prd5Z4Fl8IeyCQa922yZ2yUYb6M9jVWbG8A0tvOy8Un86uvVrKlabZZP4kDPO+aMDJaGeBbl4X
r64zrrgmmzGvHyuxNh6I/L/2wM8QivkuS4UDE0igK6p9/C6hv044GwmjH5D03japzw==
--000000000000da5c95061d61ad62--

