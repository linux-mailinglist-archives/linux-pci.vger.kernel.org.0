Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 739FE5B5734
	for <lists+linux-pci@lfdr.de>; Mon, 12 Sep 2022 11:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiILJa2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Sep 2022 05:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiILJa1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Sep 2022 05:30:27 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E00140F1;
        Mon, 12 Sep 2022 02:30:26 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1278a61bd57so21766939fac.7;
        Mon, 12 Sep 2022 02:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=HiN8KRFlRzPRLsPXZuEZ24dC682+6vrgW3nClRLEgdU=;
        b=h9sbizCEW+T6E7FZTWzcAkitUPBDkYLzhuiNagJtY7HaXyoHn+WbC4qSQI6Lexfo0+
         5JIuKGLJ7sHrP138X252qi1zfhqHzM1lhYMnGBaocjQf1a6U1goX9L61jcEbPJ3dW2PL
         ALBEQGrCb4iDFJRROx6QIlt3eZBs1taLcm1Jrf/CwKHDG+9onS1eguxPUrHECR1U3bxp
         7/s3LqsonY8U85bdmu4NBwL1qlaIY7QacgHr2340AMBQQ1okaXqC1dyrx6uaowacoHlR
         fCxzhSRB0QbLUclIjNJ4AZmdg+FVuTGrrVRNusRpwjCPw7olWItcH1pT1hn4zOXE9/MT
         cVdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=HiN8KRFlRzPRLsPXZuEZ24dC682+6vrgW3nClRLEgdU=;
        b=DFl5nmiFjX/lTtU0f2aoF1wDZZAlQ9PFpsx0Nz++i1ygHTp33/v7BI3VHjO5tBHaqx
         IfkXCFPtRT1R3H6oEzOIiXQjQGnbzWBcrIU67sH0Ee//es+3w8YfpQd/VA2lvHGqCvIp
         iHVX3nXqaT7eiMZj+ioydvxVa3j+RYvlDBUOJwlpdEKJY0hd6gkpTPVardaXX6qCRt3q
         4GaAIaEswflCX/fGDoXtAoJ0qx5qqp4XgpTLzKbdH1gY7z0buOjQ3iuPDpkXbgoGs6zH
         6ulkmLfXCfnIUEjf5urZrdV59kZeIfrrMnV5TfGDgG6EmkYi1+IqLSArK8ZpzAEDh7S5
         B77A==
X-Gm-Message-State: ACgBeo0dDf68lCl7YnSHXH2EDyDEQXkYDMq8dW9p1ixdkFS2jaa8C4zK
        dYibgCOtdH8wb6gHgc5RVLHjhbUB2Mvrfz1LwKlXqIyLNRXvuw==
X-Google-Smtp-Source: AA6agR6DQ/W4OwSzqw+xEO8w0IIFngzoav7mf8+LHom9CmtOrq6l7hOi4BKml/HL9+gljedFJC2w7WmeJtQsXWhfqPE=
X-Received: by 2002:a05:6870:c0c8:b0:101:b3c3:abc3 with SMTP id
 e8-20020a056870c0c800b00101b3c3abc3mr11193578oad.144.1662975025711; Mon, 12
 Sep 2022 02:30:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220911112024.14304-1-pali@kernel.org> <20220911112024.14304-4-pali@kernel.org>
In-Reply-To: <20220911112024.14304-4-pali@kernel.org>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Mon, 12 Sep 2022 11:30:14 +0200
Message-ID: <CAMhs-H9VHekbXg0avHpYP4=2mHoepnkH8rrshU9ZVnbAB=3h-A@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] PCI: mt7621: Use PCI_CONF1_EXT_ADDRESS() macro
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Pali,

On Sun, Sep 11, 2022 at 1:21 PM Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> Simplify pcie-mt7621.c driver code and use new PCI_CONF1_EXT_ADDRESS()
> macro for accessing PCIe config space.
>
> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> ---
>  drivers/pci/controller/pcie-mt7621.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/controller/pcie-mt7621.c b/drivers/pci/controlle=
r/pcie-mt7621.c
> index 33eb37a2225c..28cde116cd27 100644
> --- a/drivers/pci/controller/pcie-mt7621.c
> +++ b/drivers/pci/controller/pcie-mt7621.c
> @@ -25,6 +25,7 @@
>  #include <linux/of_pci.h>
>  #include <linux/of_platform.h>
>  #include <linux/pci.h>
> +#include <linux/pci-conf1.h>
>  #include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
>  #include <linux/reset.h>
> @@ -123,8 +124,7 @@ static inline void pcie_port_write(struct mt7621_pcie=
_port *port,
>  static inline u32 mt7621_pcie_get_cfgaddr(unsigned int bus, unsigned int=
 slot,
>                                          unsigned int func, unsigned int =
where)
>  {
> -       return (((where & 0xf00) >> 8) << 24) | (bus << 16) | (slot << 11=
) |
> -               (func << 8) | (where & 0xfc) | 0x80000000;
> +       return PCI_CONF1_EXT_ADDRESS(bus, slot, func, where);
>  }
>
>  static void __iomem *mt7621_pcie_map_bus(struct pci_bus *bus,
> --
> 2.20.1
>

I have just added you patches in the top of my 5.19 build:

commit 70cb6afe0e2ff1b7854d840978b1849bffb3ed21 (tag: v5.19.8,
stable/linux-5.19.y)

After building them and boot with your changes no regressions seem to
appear, so if this series are finally added to the tree, feel free to
add my:

Acked-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Tested-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Best regards,
    Sergio Paracuellos
