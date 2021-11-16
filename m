Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B679B4529E8
	for <lists+linux-pci@lfdr.de>; Tue, 16 Nov 2021 06:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235518AbhKPFly (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Nov 2021 00:41:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235426AbhKPFlf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Nov 2021 00:41:35 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63EAEC0EC8F7;
        Mon, 15 Nov 2021 18:59:52 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id x10so24139888ioj.9;
        Mon, 15 Nov 2021 18:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MjDTtA6DTI6xzB5x2nBzzPrcPt5OZM3EBixaaL8qpWI=;
        b=N6FKSQHI+zQdfdfVISllSNmjgLMXXkJHY/TiKMgsMt8oYRWnon0pPWUazM3Xs1gY/n
         BeSt23MOkEdzvltuzyjhA2W1AwzfWBzNLP8JYGN2Eh9yojOQq6HKLPlQqGKz1j9wQTIJ
         EEQmUVZutLBo6Pl/eGgjo3PlIezigsnF5+A3PLISrBQyklp3/eox9ecKgFYmQtC6PmGi
         AYEtN9iZHZjdjB7RGdguUDIDHrx6RMtFS4OaPQ8E77JH/UUPMge5otDS0eG7Q2WqW9VH
         kkMs3moEZNFZe4U2oOqdMxCxdCWf6BZacaafN3t/26AyCh3wwQeDBoVBfiWdkdViIahG
         1bdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MjDTtA6DTI6xzB5x2nBzzPrcPt5OZM3EBixaaL8qpWI=;
        b=LK+J/DyQKqzsYT2de7kkmskhNvKsoykCJN3hhjRgm9Lq0NHtJrUhREcuNx6fvUuAQ7
         U2uBuF7vm4p6UXJoLRvrPC5on/0mgFWeHq/SlZoLFY6WLpC8ipbwOYBzpzx/B20c1oCy
         T1Ob6gEJwXR8TpcExApFTklMU3fJEAt3tBvNc9JSe/3RUlTGn429g3Yo0gurOTsAKn3t
         kqNCDVV0cbwOlGQSzp7r9mje31mvNMCwvjkxWbnJ/i7oHYPBwHq+m50RVpgBBBvpNHCe
         tNX8NNJ07S+tLDNL3S+S3d7kIMgpKYM00K/ax+4BZWSlGjSUqW2wB4STmLsBu+g6d24m
         VP3g==
X-Gm-Message-State: AOAM530DoAMF75KBC9tx05pML4rpsXkJN28Q6CBzUrHkhicmOd9gcfVz
        bcko5rE+khVx1qzexhyrg4ck9E4oBqPTB7mVfhE=
X-Google-Smtp-Source: ABdhPJxGpDo22JWP+St++nExricZPROGw5bLAgB0waYE2v6yK5NuFCtHkI7fS9pVeii7gurWxgpSXYliFkDT2TmDNeE=
X-Received: by 2002:a05:6638:13d5:: with SMTP id i21mr2746797jaj.79.1637031591902;
 Mon, 15 Nov 2021 18:59:51 -0800 (PST)
MIME-Version: 1.0
References: <m3lf36n0d8.fsf@t19.piap.pl> <AS8PR04MB86766EED807B963F4D9931E68CB29@AS8PR04MB8676.eurprd04.prod.outlook.com>
In-Reply-To: <AS8PR04MB86766EED807B963F4D9931E68CB29@AS8PR04MB8676.eurprd04.prod.outlook.com>
From:   Art Nikpal <email2tema@gmail.com>
Date:   Tue, 16 Nov 2021 10:59:40 +0800
Message-ID: <CAKaHn9+Mm7ijodyhsGS5FQO+yWnCUL46QtBjcu40TD3K7=U_zg@mail.gmail.com>
Subject: Re: [PATCH v3 REPOST] PCIe: limit Max Read Request Size on i.MX to
 512 bytes
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     =?UTF-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Huacai Chen <chenhuacai@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 8, 2021 at 3:19 PM Richard Zhu <hongxing.zhu@nxp.com> wrote:
>
> > -----Original Message-----
> > From: Krzysztof Ha=C5=82asa <khalasa@piap.pl>
> > Sent: Wednesday, October 6, 2021 2:17 PM
> > To: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: linux-pci@vger.kernel.org; Artem Lapkin <email2tema@gmail.com>; Nei=
l
> > Armstrong <narmstrong@baylibre.com>; Huacai Chen
> > <chenhuacai@gmail.com>; Rob Herring <robh@kernel.org>; Lorenzo Pieralis=
i
> > <lorenzo.pieralisi@arm.com>; Krzysztof Wilczy=C5=84ski <kw@linux.com>; =
Richard
> > Zhu <hongxing.zhu@nxp.com>; Lucas Stach <l.stach@pengutronix.de>;
> > linux-kernel@vger.kernel.org
> > Subject: [PATCH v3 REPOST] PCIe: limit Max Read Request Size on i.MX to=
 512
> > bytes
> >
> > DWC PCIe controller imposes limits on the Read Request Size that it can
> > handle. For i.MX6 family it's fixed at 512 bytes by default.
> >
> > If a memory read larger than the limit is requested, the CPU responds w=
ith
> > Completer Abort (CA) (on i.MX6 Unsupported Request (UR) is returned
> > instead due to a design error).
> >
> > The i.MX6 documentation states that the limit can be changed by writing=
 to
> > the PCIE_PL_MRCCR0 register, however there is a fixed (and
> > undocumented) maximum (CX_REMOTE_RD_REQ_SIZE constant). Tests
> > indicate that values larger than 512 bytes don't work, though.
> >
> > This patch makes the RTL8111 work on i.MX6.
> >
> > Signed-off-by: Krzysztof Ha=C5=82asa <khalasa@piap.pl>
> [Richard Zhu] I'm fine with this patch. Acked-by: Richard Zhu <hongxing.z=
hu@nxp.com>. Thanks.

Same will be fine for us

>
> Best Regards
> Richard Zhu
>
> > ---
> > While ATM needed only on ARM, this version is compiled in on all archs.
> >
> > diff --git a/drivers/pci/controller/dwc/pci-imx6.c
> > b/drivers/pci/controller/dwc/pci-imx6.c
> > index 80fc98acf097..225380e75fff 100644
> > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > @@ -1148,6 +1148,7 @@ static int imx6_pcie_probe(struct platform_device
> > *pdev)
> >               imx6_pcie->vph =3D NULL;
> >       }
> >
> > +     max_pcie_mrrs =3D 512;
> >       platform_set_drvdata(pdev, imx6_pcie);
> >
> >       ret =3D imx6_pcie_attach_pd(dev);
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c index
> > aacf575c15cf..abeb48a64ee3 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -112,6 +112,8 @@ enum pcie_bus_config_types pcie_bus_config =3D
> > PCIE_BUS_PEER2PEER;  enum pcie_bus_config_types pcie_bus_config =3D
> > PCIE_BUS_DEFAULT;  #endif
> >
> > +u16 max_pcie_mrrs =3D 4096; // no limit
> > +
> >  /*
> >   * The default CLS is used if arch didn't set CLS explicitly and not
> >   * all pci devices agree on the same value.  Arch can override either =
@@
> > -5816,6 +5818,9 @@ int pcie_set_readrq(struct pci_dev *dev, int rq)
> >                       rq =3D mps;
> >       }
> >
> > +     if (rq > max_pcie_mrrs)
> > +             rq =3D max_pcie_mrrs;
> > +
> >       v =3D (ffs(rq) - 8) << 12;
> >
> >       ret =3D pcie_capability_clear_and_set_word(dev, PCI_EXP_DEVCTL, d=
iff
> > --git a/include/linux/pci.h b/include/linux/pci.h index
> > 06ff1186c1ef..2b95a8204819 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -996,6 +996,7 @@ enum pcie_bus_config_types {  };
> >
> >  extern enum pcie_bus_config_types pcie_bus_config;
> > +extern u16 max_pcie_mrrs;
> >
> >  extern struct bus_type pci_bus_type;
> >
> >
> > --
> > Krzysztof "Chris" Ha=C5=82asa
> >
> > Sie=C4=87 Badawcza =C5=81ukasiewicz
> > Przemys=C5=82owy Instytut Automatyki i Pomiar=C3=B3w PIAP Al. Jerozolim=
skie 202,
> > 02-486 Warszawa
