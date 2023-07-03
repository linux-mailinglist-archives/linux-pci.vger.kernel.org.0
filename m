Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C96EF7457C4
	for <lists+linux-pci@lfdr.de>; Mon,  3 Jul 2023 10:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbjGCIyu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Jul 2023 04:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjGCIyu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Jul 2023 04:54:50 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D525194;
        Mon,  3 Jul 2023 01:54:48 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-c2cf29195f8so4881260276.1;
        Mon, 03 Jul 2023 01:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688374488; x=1690966488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2P1+8Vl4nN04UtbHWZzTAFlwj7juUIzaPe884hrImxc=;
        b=D+UL71vejPPkfFEC9QjT/anRmhQj61MJn/T2Wuz+8Lq9eHWp4ip0SdPMZs9EUKUIt5
         Cxgf9gvnF8ypVhtCllM9F5xQSw7K8AgUXi9jXjFhomZ/2czKvKkwVwFeJ3X6oV4HJpeM
         hGNXsycE3U76fRJZFugirljo8Z5TiUrMLbiHJphFUwa20F7FWOHSJv96zn0PR31Oz7Kc
         fCXsdzmknD2RSc7eyNnrXZxqmoDdEB6JbDHUoG+YXW4aU/EZWQTc/1XBLV8ejFAImisZ
         rgXQ+RwC9K71wNvMf+9XD2UG7Jg9IC+16z5cSW/0f8R1JACJmlo3n+TKSWwYWE7w9+2F
         Xkgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688374488; x=1690966488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2P1+8Vl4nN04UtbHWZzTAFlwj7juUIzaPe884hrImxc=;
        b=c+KGyXfcRv5ryEWeMl1MChqgauCGE52LD2uhdmatClB+9+sVuBxLgcLhhYeP8CU0K9
         78C8lUVVucrRmpMHdfOkRZQKANodF5P00m8NEoqTC/2+ds0rWWd1ffjq96hOSS1svz91
         c1OfYUuQH0D+CGu/gaVu6XAxDUjQHWIuNDUW4NDaAk1W1NCIDh0wj8yicEoiLnfqKvzH
         Tz5L0Jj8Fyl2thpwM4v+LoM9k1n4qYWDpJiYNj/pCukuF/CB0z8YL80yWH7QBFpmQXf3
         r4k7mjsPH4l9bn9kyw9FDHLFGQ61Ex+R95evCuhKGTFyAFlbNmX6SohT2ATZZaIFVW93
         3tlg==
X-Gm-Message-State: ABy/qLYFEP9esThCyLygKzmw+N+vaqTWrI3OG5hgG/sYlr11Hsxu8qDY
        JXJ97OWA4psJlSAeWc4ZoQ1uFAexiJpClCSUffo=
X-Google-Smtp-Source: APBJJlG75z1nfpbVvYw7Z+wJ+Z2EHygE7EH09Min96xS+Npy3j+/Xbha47DlKPIzV5Nx9YPV6reVdaNSfZKF7oEAnOs=
X-Received: by 2002:a25:3754:0:b0:c4e:24d:ae7f with SMTP id
 e81-20020a253754000000b00c4e024dae7fmr3689710yba.58.1688374487895; Mon, 03
 Jul 2023 01:54:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230630131753.1549685-1-rick.wertenbroek@gmail.com> <3e49476e-ee18-bfb8-ae1a-3a55a3d13f88@kernel.org>
In-Reply-To: <3e49476e-ee18-bfb8-ae1a-3a55a3d13f88@kernel.org>
From:   Rick Wertenbroek <rick.wertenbroek@gmail.com>
Date:   Mon, 3 Jul 2023 10:54:11 +0200
Message-ID: <CAAEEuhrCHQBi89G2hzJjDZmG3zR=ErbtGQTGuVbiPUOCYh=S5Q@mail.gmail.com>
Subject: Re: [PATCH] PCI: rockchip: Use 64-bit mask on MSI 64-bit PCI address
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>, stable@vger.kernel.org,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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

On Mon, Jul 3, 2023 at 4:05=E2=80=AFAM Damien Le Moal <dlemoal@kernel.org> =
wrote:
>
> On 6/30/23 22:17, Rick Wertenbroek wrote:
> > A 32-bit mask was used on the 64-bit PCI address used for mapping MSIs.
> > This would result in the upper 32 bits being unintentionally zeroed and
> > MSIs getting mapped to incorrect PCI addresses if the address had any
> > of the upper bits set.
> >
> > Replace 32-bit mask by appropriate 64-bit mask and rename 32-bit mask
> > for clarity.
> >
> > Fixes: dc73ed0f1b8b ("PCI: rockchip: Fix window mapping and address tra=
nslation for endpoint")
> > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > Closes: https://lore.kernel.org/linux-pci/8d19e5b7-8fa0-44a4-90e2-9bb06=
f5eb694@moroto.mountain/
> > Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
> > Cc: stable@vger.kernel.org
> > ---
> >  drivers/pci/controller/pcie-rockchip-ep.c | 12 ++++++------
> >  drivers/pci/controller/pcie-rockchip.h    |  6 +++---
> >  2 files changed, 9 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/co=
ntroller/pcie-rockchip-ep.c
> > index 0af0e965fb57..313face6a87f 100644
> > --- a/drivers/pci/controller/pcie-rockchip-ep.c
> > +++ b/drivers/pci/controller/pcie-rockchip-ep.c
> > @@ -354,7 +354,7 @@ static int rockchip_pcie_ep_send_msi_irq(struct roc=
kchip_pcie_ep *ep, u8 fn,
> >       struct rockchip_pcie *rockchip =3D &ep->rockchip;
> >       u32 flags, mme, data, data_mask;
> >       u8 msi_count;
> > -     u64 pci_addr;
> > +     u64 pci_addr, pci_addr_mask =3D GENMASK(63, 8);
>
> I think you can simplify all this with only the change to the definition =
of
> PCIE_ADDR_MASK macro. Applying a 64 bits mask for low bits to a 32-bits v=
ariable
> is OK and should not generate any complaints from the compiler.
> Also, that "8" in the GENMASK can be replaced by MIN_AXI_ADDR_BITS_PASSED=
.
> So:
>
> #define PCIE_ADDR_MASK  GENMASK(63, MIN_AXI_ADDR_BITS_PASSED)
>
> Would fix everything I think.
>
> If it does not, I would prefer you define a macro for that GENMASK(63, 8)=
 mask
> instead of using a variable on stack. That would be more efficient code w=
ise,
> removing a memory access.

Indeed this would make the patch much simpler.
I will prepare and send the v2. Thank you for the suggestions

Regards,
Rick

>
> >       u32 r;
> >
> >       /* Check MSI enable bit */
> > @@ -391,18 +391,18 @@ static int rockchip_pcie_ep_send_msi_irq(struct r=
ockchip_pcie_ep *ep, u8 fn,
> >                                      PCI_MSI_ADDRESS_LO);
> >
> >       /* Set the outbound region if needed. */
> > -     if (unlikely(ep->irq_pci_addr !=3D (pci_addr & PCIE_ADDR_MASK) ||
> > +     if (unlikely(ep->irq_pci_addr !=3D (pci_addr & pci_addr_mask) ||
> >                    ep->irq_pci_fn !=3D fn)) {
> >               r =3D rockchip_ob_region(ep->irq_phys_addr);
> >               rockchip_pcie_prog_ep_ob_atu(rockchip, fn, r,
> >                                            ep->irq_phys_addr,
> > -                                          pci_addr & PCIE_ADDR_MASK,
> > -                                          ~PCIE_ADDR_MASK + 1);
> > -             ep->irq_pci_addr =3D (pci_addr & PCIE_ADDR_MASK);
> > +                                          pci_addr & pci_addr_mask,
> > +                                          ~pci_addr_mask + 1);
> > +             ep->irq_pci_addr =3D (pci_addr & pci_addr_mask);
> >               ep->irq_pci_fn =3D fn;
> >       }
> >
> > -     writew(data, ep->irq_cpu_addr + (pci_addr & ~PCIE_ADDR_MASK));
> > +     writew(data, ep->irq_cpu_addr + (pci_addr & ~pci_addr_mask));
> >       return 0;
> >  }
> >
> > diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/contr=
oller/pcie-rockchip.h
> > index fe0333778fd9..2d7b05f07b7e 100644
> > --- a/drivers/pci/controller/pcie-rockchip.h
> > +++ b/drivers/pci/controller/pcie-rockchip.h
> > @@ -158,11 +158,11 @@
> >  #define PCIE_RC_CONFIG_THP_CAP               (PCIE_RC_CONFIG_BASE + 0x=
274)
> >  #define   PCIE_RC_CONFIG_THP_CAP_NEXT_MASK   GENMASK(31, 20)
> >
> > -#define PCIE_ADDR_MASK                       0xffffff00
> > +#define PCIE_LO_ADDR_MASK            GENMASK(31, 8)
> >  #define PCIE_CORE_AXI_CONF_BASE              0xc00000
> >  #define PCIE_CORE_OB_REGION_ADDR0    (PCIE_CORE_AXI_CONF_BASE + 0x0)
> >  #define   PCIE_CORE_OB_REGION_ADDR0_NUM_BITS 0x3f
> > -#define   PCIE_CORE_OB_REGION_ADDR0_LO_ADDR  PCIE_ADDR_MASK
> > +#define   PCIE_CORE_OB_REGION_ADDR0_LO_ADDR  PCIE_LO_ADDR_MASK
> >  #define PCIE_CORE_OB_REGION_ADDR1    (PCIE_CORE_AXI_CONF_BASE + 0x4)
> >  #define PCIE_CORE_OB_REGION_DESC0    (PCIE_CORE_AXI_CONF_BASE + 0x8)
> >  #define PCIE_CORE_OB_REGION_DESC1    (PCIE_CORE_AXI_CONF_BASE + 0xc)
> > @@ -170,7 +170,7 @@
> >  #define PCIE_CORE_AXI_INBOUND_BASE   0xc00800
> >  #define PCIE_RP_IB_ADDR0             (PCIE_CORE_AXI_INBOUND_BASE + 0x0=
)
> >  #define   PCIE_CORE_IB_REGION_ADDR0_NUM_BITS 0x3f
> > -#define   PCIE_CORE_IB_REGION_ADDR0_LO_ADDR  PCIE_ADDR_MASK
> > +#define   PCIE_CORE_IB_REGION_ADDR0_LO_ADDR  PCIE_LO_ADDR_MASK
> >  #define PCIE_RP_IB_ADDR1             (PCIE_CORE_AXI_INBOUND_BASE + 0x4=
)
> >
> >  /* Size of one AXI Region (not Region 0) */
>
> --
> Damien Le Moal
> Western Digital Research
>
