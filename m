Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 277C73EDDF0
	for <lists+linux-pci@lfdr.de>; Mon, 16 Aug 2021 21:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbhHPTep (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Aug 2021 15:34:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:39860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229676AbhHPTep (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 16 Aug 2021 15:34:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 25B7960E76;
        Mon, 16 Aug 2021 19:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629142453;
        bh=YRQj9u9GI1q4ap5E3mewc0gaW+gUGqlP+qhQSTUE1bE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gn4lt2x/3l5UPyWS7M4Cs1jydsIfBIVBSmUfEQtIGKdJEYI69Z0NuhJa4IcT+tnTm
         mkGX0kx6bpB/c4jMM3YX673GGH7ancayRSgvfCqG2YA1Mu9Ho8ZX03j3HQPi17lBDM
         RvBdMnxc7vu0vla5ZeN/u8DccGAy5UHkmb8GLoBk86iYMlSZ34kUOY9JDNbiQqj58b
         83okJ3HeLBl5vcjjg+QT85kqJxYUjFjI++qIgp8t26sGTIn8PyYBFQFyNQt5YuPqk3
         Vp3zhyWAUXPRrqrCXlKLWe2EvTDKqVh5w6VRtmlIzVLbeiezBiB9/yiyB7aG6LPg4Z
         9qpDAHRtiBsEg==
Received: by mail-ej1-f49.google.com with SMTP id bt14so18010609ejb.3;
        Mon, 16 Aug 2021 12:34:13 -0700 (PDT)
X-Gm-Message-State: AOAM533B5L3qJXbSXM4pmbLZt6l35EfeLgWGkkV1mTFh3aYRsQyNY7Bv
        35C7j1SmkCVr635pJH8DhaR/E700Poh02UEMNg==
X-Google-Smtp-Source: ABdhPJyCdYjb9e8fQEVVbIfderD/YQW5ccQdF65I+3D3lgm2dUdHJDw0WIp2CEtNHy+8bDBjJfdcYll9zhFcOm4+0Zw=
X-Received: by 2002:a17:906:8cd:: with SMTP id o13mr61179eje.341.1629142451615;
 Mon, 16 Aug 2021 12:34:11 -0700 (PDT)
MIME-Version: 1.0
References: <m3k0klzl1x.fsf@t19.piap.pl>
In-Reply-To: <m3k0klzl1x.fsf@t19.piap.pl>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 16 Aug 2021 14:34:00 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+M7xdqf8bVhs-isHoGCGjLhi6N2q+tm7msWLBy52OsMw@mail.gmail.com>
Message-ID: <CAL_Jsq+M7xdqf8bVhs-isHoGCGjLhi6N2q+tm7msWLBy52OsMw@mail.gmail.com>
Subject: Re: [PATCH v2] PCIe: limit Max Read Request Size on i.MX to 512 bytes
To:     =?UTF-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        PCI <linux-pci@vger.kernel.org>,
        Artem Lapkin <email2tema@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Huacai Chen <chenhuacai@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 16, 2021 at 6:27 AM Krzysztof Ha=C5=82asa <khalasa@piap.pl> wro=
te:
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
> This version drops CONFIG_NEED_PCIE_MAX_MRRS.
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
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index aacf575c15cf..44815af4ad85 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -112,6 +112,10 @@ enum pcie_bus_config_types pcie_bus_config =3D PCIE_=
BUS_PEER2PEER;
>  enum pcie_bus_config_types pcie_bus_config =3D PCIE_BUS_DEFAULT;
>  #endif
>
> +#ifdef CONFIG_ARM
> +u16 max_pcie_mrrs =3D 4096; // no limit - needed mostly for DWC PCIe
> +#endif
> +
>  /*
>   * The default CLS is used if arch didn't set CLS explicitly and not
>   * all pci devices agree on the same value.  Arch can override either
> @@ -5816,6 +5820,11 @@ int pcie_set_readrq(struct pci_dev *dev, int rq)
>                         rq =3D mps;
>         }
>
> +#ifdef CONFIG_ARM
> +       if (rq > max_pcie_mrrs)
> +               rq =3D max_pcie_mrrs;
> +#endif

My objection wasn't having another kconfig option so much as I don't
think we need one at all here unless Bjorn feels otherwise. It's 2
bytes of data and about 3 instructions (load, cmp, store).

If we do have a config option, using or basing on the arch is wrong.
Has nothing to do with the arch. Are the other platforms needing this
arm32 as well?

Also, when you do use kconfig options, use IS_ENABLED() whenever possible.

Rob
