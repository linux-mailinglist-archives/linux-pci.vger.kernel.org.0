Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB28A5EB8CA
	for <lists+linux-pci@lfdr.de>; Tue, 27 Sep 2022 05:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiI0DbG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Sep 2022 23:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiI0Dar (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Sep 2022 23:30:47 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF8B10DB;
        Mon, 26 Sep 2022 20:30:46 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id g130so10521467oia.13;
        Mon, 26 Sep 2022 20:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=LSCNzAhxlmruTBHQ2iRTrDz1OR9oet5kL0A/y7IA/YI=;
        b=SeDIQ/z1UZmJyHwmZSV0SeNcWsVMp/LWhKZTnzh85w6c0T0X3piYpRLL57LpceuDUw
         y530DsNBBL9MGCt4bQiFIebYylr3AEiOJBuFShIZ1LU9LYSzt1/zH6T2YRZoi2b+/Qzk
         k+SnogAR/gsjTFT6AXcHRLfKhhlNGT7+/y5L6gtS+/M4jyvpoUMrQOD6e9h7GwMxUYR/
         SJDSjZIPFN+cYrDRUorp29LODI37dJlOEo05XEeRgFMr4qvK7HCWtdeRnnYTi3Chngol
         YMRPrkzlE8JAdvqR5ObPr2+nqKcZlIb3SRFmGhqIYCni/DzEPmGGJ8TwOxlLqSSoU+CH
         UKVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=LSCNzAhxlmruTBHQ2iRTrDz1OR9oet5kL0A/y7IA/YI=;
        b=iZsci+rFzmC5IcgsgkY0IsyK2ELyQmVs9UqHl84jxCgoMOwnblBx0Oc7IGMJ9WG6tb
         DML36JrRAwlnxngEuMzhE0ot3Hdddxaj1AKLYydLQwwqtRUjN9oiZcvPpoNrNjE3V4QN
         U9KGlymsUxu1WwAtJdgaXxwjvjCeb3JghFm2I+MGasuZKCcZu0gIiLTwk1QgdVH0E0ZF
         VSxdReMTpHMey5eI5PxUygjJHKHVPwkeSGIxaGRpeeWsfjRRlh6AnqHidqo4NFE6E7QV
         MPTnX9cA+VIvbxp3Wf+ruGWWBzUig5iFlLRo37ZS0smh1jDAOOhWtUsmtM2rzyx8VlsB
         hY8Q==
X-Gm-Message-State: ACrzQf1j27ep3EzQIGThisJg0QadYUZoweh3Ygi2ultqpB/19Vqy7UJR
        BRA8FytMK7F98nVmRJnD95DvGrLO05jLs22ot8IYvOKAj4aNkA==
X-Google-Smtp-Source: AMsMyM5NDhJ6wDJW7zp8xB4KBTGYo/kKqrONOSml/sR+ybF79aM5a/MakQgQF7DeoRLilWiPYpFLy0GQUG/9AAo2Uuc=
X-Received: by 2002:a05:6808:23ca:b0:350:92c4:3422 with SMTP id
 bq10-20020a05680823ca00b0035092c43422mr901378oib.144.1664249446096; Mon, 26
 Sep 2022 20:30:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220924092404.31776-1-pali@kernel.org> <20220924092404.31776-4-pali@kernel.org>
In-Reply-To: <20220924092404.31776-4-pali@kernel.org>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Tue, 27 Sep 2022 05:30:36 +0200
Message-ID: <CAMhs-H-mmx2TcfEkgkmzWOz3k2U+nPokBBaPN7XY=DpPbVvpHQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] PCI: mt7621: Use PCI_CONF1_EXT_ADDRESS() macro
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Pali,

On Sat, Sep 24, 2022 at 11:24 AM Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> Simplify pcie-mt7621.c driver code and use new PCI_CONF1_EXT_ADDRESS()
> macro for accessing PCIe config space.
>
> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> ---
>  drivers/pci/controller/pcie-mt7621.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)

I think I have already given my Acked-by and Tested-by for this series
in its RFC version [0]. I don't know if because that was a RFC my tags
are not added to this patch. Anyway:

Acked-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Thanks,
    Sergio Paracuellos

[0]: https://lore.kernel.org/all/CAMhs-H9VHekbXg0avHpYP4=3D2mHoepnkH8rrshU9=
ZVnbAB=3D3h-A@mail.gmail.com/

>
> diff --git a/drivers/pci/controller/pcie-mt7621.c b/drivers/pci/controlle=
r/pcie-mt7621.c
> index 33eb37a2225c..4bd1abf26008 100644
> --- a/drivers/pci/controller/pcie-mt7621.c
> +++ b/drivers/pci/controller/pcie-mt7621.c
> @@ -30,6 +30,8 @@
>  #include <linux/reset.h>
>  #include <linux/sys_soc.h>
>
> +#include "../pci.h"
> +
>  /* MediaTek-specific configuration registers */
>  #define PCIE_FTS_NUM                   0x70c
>  #define PCIE_FTS_NUM_MASK              GENMASK(15, 8)
> @@ -120,19 +122,12 @@ static inline void pcie_port_write(struct mt7621_pc=
ie_port *port,
>         writel_relaxed(val, port->base + reg);
>  }
>
> -static inline u32 mt7621_pcie_get_cfgaddr(unsigned int bus, unsigned int=
 slot,
> -                                        unsigned int func, unsigned int =
where)
> -{
> -       return (((where & 0xf00) >> 8) << 24) | (bus << 16) | (slot << 11=
) |
> -               (func << 8) | (where & 0xfc) | 0x80000000;
> -}
> -
>  static void __iomem *mt7621_pcie_map_bus(struct pci_bus *bus,
>                                          unsigned int devfn, int where)
>  {
>         struct mt7621_pcie *pcie =3D bus->sysdata;
> -       u32 address =3D mt7621_pcie_get_cfgaddr(bus->number, PCI_SLOT(dev=
fn),
> -                                            PCI_FUNC(devfn), where);
> +       u32 address =3D PCI_CONF1_EXT_ADDRESS(bus->number, PCI_SLOT(devfn=
),
> +                                           PCI_FUNC(devfn), where);
>
>         writel_relaxed(address, pcie->base + RALINK_PCI_CONFIG_ADDR);
>
> @@ -147,7 +142,7 @@ static struct pci_ops mt7621_pcie_ops =3D {
>
>  static u32 read_config(struct mt7621_pcie *pcie, unsigned int dev, u32 r=
eg)
>  {
> -       u32 address =3D mt7621_pcie_get_cfgaddr(0, dev, 0, reg);
> +       u32 address =3D PCI_CONF1_EXT_ADDRESS(0, dev, 0, reg);
>
>         pcie_write(pcie, address, RALINK_PCI_CONFIG_ADDR);
>         return pcie_read(pcie, RALINK_PCI_CONFIG_DATA);
> @@ -156,7 +151,7 @@ static u32 read_config(struct mt7621_pcie *pcie, unsi=
gned int dev, u32 reg)
>  static void write_config(struct mt7621_pcie *pcie, unsigned int dev,
>                          u32 reg, u32 val)
>  {
> -       u32 address =3D mt7621_pcie_get_cfgaddr(0, dev, 0, reg);
> +       u32 address =3D PCI_CONF1_EXT_ADDRESS(0, dev, 0, reg);
>
>         pcie_write(pcie, address, RALINK_PCI_CONFIG_ADDR);
>         pcie_write(pcie, val, RALINK_PCI_CONFIG_DATA);
> --
> 2.20.1
>
