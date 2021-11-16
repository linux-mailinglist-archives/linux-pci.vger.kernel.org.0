Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E414F4529DB
	for <lists+linux-pci@lfdr.de>; Tue, 16 Nov 2021 06:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235292AbhKPFkx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Nov 2021 00:40:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235244AbhKPFkg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Nov 2021 00:40:36 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4643CC02554F;
        Mon, 15 Nov 2021 18:57:17 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id w15so18807967ill.2;
        Mon, 15 Nov 2021 18:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=No4z7La4bhkcQbca89PlomBUUI0KAnWXKTm6YdxA2AA=;
        b=BsL7Od/o7dLYe0c5YTQGOegr1XgaZrH2zdjLdnSg6Na4+gKwHpPXqAtdZ1rl2RKh6C
         8z8qAjQCeVU8YlQHtOysvSThNDc5xa7ZQ+DefoFKlmGGeMgVxu06lGfHZpq6CsAcMWDW
         3ZebIT8sHRW3ATUdrmlM3/ACVKS7F1ujik7tnkcKIl6b6At/dzR3hEUn41U2EMNaItCu
         JDquG2uBVumxo3y/YFxWhX7NeJBzVwutrINAZPYbvCH4XVoHr3GIHUEDhaaG0tAKhJhC
         QA+v2ac6/dYz7WvOeUHf1WDVEqh2sQ5B4SH0ckFoIstv9cHlEoVlAvWhr1HNrKsN/+q/
         CfWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=No4z7La4bhkcQbca89PlomBUUI0KAnWXKTm6YdxA2AA=;
        b=IK+Pb60A6Jpf7UWRIpdMJFKoCSoaRqg1Drs43yzuy6Ka+suU+Y9NBsTElu/DsT5/hQ
         o0lYe8yPO/mmVqrfdcxjSNjokdO2weNmrW70rjT3WR7bA869y0LTxcdY+skLsE1u96cA
         Hq+dalKA70mK/nmggYP+sZfGeySftu7TEZkYnIHa8x9VXOQG8ApjUhP+KAnbZstk5c8v
         U2ao2tdR6sCjReonFxemxEM1sOKTIqCE+ICsAd2/atcgXoBg+e+d1tNBGa9tgiIYtXeh
         z57C/HeHzQ557Nk/nqLD3qw+msTFdOemhj0lNsb2uxnQDHiHc5pi0Y73JnzA+W6YOlDi
         Zx6Q==
X-Gm-Message-State: AOAM530IedR7z3uCZ24FJrvoDExLsQzphX/EO6A1TxHQJsuqq6HD4inf
        5xLJJxaeJbsMz53nqcyCXdLr4zwMrKUYNzkYipA=
X-Google-Smtp-Source: ABdhPJxbAdYM4R1iQcPHlocus9bYOMmiEF/k+qo4v15iARy7FRDWBlBX+2aDInBc9SdiIiMvm/Psp/os9Wv1kiFSQRM=
X-Received: by 2002:a05:6e02:1608:: with SMTP id t8mr2417192ilu.25.1637031436743;
 Mon, 15 Nov 2021 18:57:16 -0800 (PST)
MIME-Version: 1.0
References: <m3lf36n0d8.fsf@t19.piap.pl>
In-Reply-To: <m3lf36n0d8.fsf@t19.piap.pl>
From:   Art Nikpal <email2tema@gmail.com>
Date:   Tue, 16 Nov 2021 10:57:05 +0800
Message-ID: <CAKaHn9+OZ7hKf5cMYsp28UFZ_79G5=ksgNjukg2GO2NLj_Un=A@mail.gmail.com>
Subject: Re: [PATCH v3 REPOST] PCIe: limit Max Read Request Size on i.MX to
 512 bytes
To:     =?UTF-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        PCI <linux-pci@vger.kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Huacai Chen <chenhuacai@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Still not merged any solution for solve this problem
same as our solution https://lkml.org/lkml/2021/7/28/1237

May be we can accept any one  ?

On Wed, Oct 6, 2021 at 2:17 PM Krzysztof Ha=C5=82asa <khalasa@piap.pl> wrot=
e:
>
> DWC PCIe controller imposes limits on the Read Request Size that it can
> handle. For i.MX6 family it's fixed at 512 bytes by default.
>
> If a memory read larger than the limit is requested, the CPU responds
> with Completer Abort (CA) (on i.MX6 Unsupported Request (UR) is returned
> instead due to a design error).
>
> The i.MX6 documentation states that the limit can be changed by writing
> to the PCIE_PL_MRCCR0 register, however there is a fixed (and
> undocumented) maximum (CX_REMOTE_RD_REQ_SIZE constant). Tests indicate
> that values larger than 512 bytes don't work, though.
>
> This patch makes the RTL8111 work on i.MX6.
>
> Signed-off-by: Krzysztof Ha=C5=82asa <khalasa@piap.pl>
> ---
> While ATM needed only on ARM, this version is compiled in on all
> archs.
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controll=
er/dwc/pci-imx6.c
> index 80fc98acf097..225380e75fff 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1148,6 +1148,7 @@ static int imx6_pcie_probe(struct platform_device *=
pdev)
>                 imx6_pcie->vph =3D NULL;
>         }
>
> +       max_pcie_mrrs =3D 512;
>         platform_set_drvdata(pdev, imx6_pcie);
>
>         ret =3D imx6_pcie_attach_pd(dev);

I think next simple patch will be fine for all our cases

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index aacf575c15cf..abeb48a64ee3 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -112,6 +112,8 @@ enum pcie_bus_config_types pcie_bus_config =3D PCIE_B=
US_PEER2PEER;
>  enum pcie_bus_config_types pcie_bus_config =3D PCIE_BUS_DEFAULT;
>  #endif
>
> +u16 max_pcie_mrrs =3D 4096; // no limit

max_pcie_mrrs
> +
>  /*
>   * The default CLS is used if arch didn't set CLS explicitly and not
>   * all pci devices agree on the same value.  Arch can override either
> @@ -5816,6 +5818,9 @@ int pcie_set_readrq(struct pci_dev *dev, int rq)
>                         rq =3D mps;
>         }
>
> +       if (rq > max_pcie_mrrs)
> +               rq =3D max_pcie_mrrs;
> +
>         v =3D (ffs(rq) - 8) << 12;
>
>         ret =3D pcie_capability_clear_and_set_word(dev, PCI_EXP_DEVCTL,
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 06ff1186c1ef..2b95a8204819 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -996,6 +996,7 @@ enum pcie_bus_config_types {
>  };
>
>  extern enum pcie_bus_config_types pcie_bus_config;
> +extern u16 max_pcie_mrrs;
>
>  extern struct bus_type pci_bus_type;
>
>
> --
> Krzysztof "Chris" Ha=C5=82asa
>
> Sie=C4=87 Badawcza =C5=81ukasiewicz
> Przemys=C5=82owy Instytut Automatyki i Pomiar=C3=B3w PIAP
> Al. Jerozolimskie 202, 02-486 Warszawa
