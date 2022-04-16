Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8956F5036C2
	for <lists+linux-pci@lfdr.de>; Sat, 16 Apr 2022 15:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbiDPN1K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 16 Apr 2022 09:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbiDPN1J (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Apr 2022 09:27:09 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2271C4EDCD;
        Sat, 16 Apr 2022 06:24:38 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-2f16645872fso3881917b3.4;
        Sat, 16 Apr 2022 06:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ksyY81buYHpBvFd7vVUwYBF2PVx3FJm7Czy6ELpPmDI=;
        b=GghB9GPS+QOJ/7hViErvgFw3KSyG8IIwgdRWCfXWqkO/cBbHxLgav4XQ/SGEo9BV9M
         Xij1Z6SCwrOwJuDah6XoCqUe8FAPZTSZGR6OaqeQsjd/DsrbKrl41GkWEkphVDNDj17b
         3AyiKVsURXFp7UfuKAsS9q9UM97q5vrQw6HVa1T+ywAsKwUW5O0oNkArXqAYKrkBi2fV
         yUjudMnB1jljICD/9LKWlUXsCRR0KRJ6Oo4Ue+htkiK/COIVjbi8zzOZ7fU1Te6vqwxG
         gowc8SX8s/uT7239+jSshvrsvpEt4SDQae9u2JAI08+ybX8qpehl5c5kiZlcSwOQm72H
         kLkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ksyY81buYHpBvFd7vVUwYBF2PVx3FJm7Czy6ELpPmDI=;
        b=AkWOgsOHg4cTh3L7ePpmSHLMnSPbIX1r1kdo2Y0URGiNwy3emr86t3P1tFZP/B8HGV
         hIseeX77DkKHDwzSwgrWAUfAQZA8zMDvpCFTXikNGHoLE9tpo6Ch/Zo5RkA/Z3Op6Een
         zw+Pw5HP3AFcfBTyv4NNr68RJnDokO/5GyfgjazLpFsxoH8XRDU8nAUeWjw/MZDHKz1a
         8vJZilgLJmjeqCyU6VmVWRi1uzPLKmx/WPJSqYgEHs5uj81aw8Wsf3Uj8/Oi8uam1kLk
         GYFAozfZvBEgIzsOHQdggCpuI6aCviUmJsoLJRxvuM2o7iubfBDLwhUOChO0arF5wy7m
         uyIQ==
X-Gm-Message-State: AOAM530Yl/36F2EHcQ2tSL/3KAKhHFvc1ukHCqTN4cELXldFLMSAzhhn
        HeqzDkZcBa0FBmS21185yEXP/BpR0izeMA8wUfYib3PbVTrStQ==
X-Google-Smtp-Source: ABdhPJzRiAH0Lb3U5NrzhR0qbfInlHhWJodaqh/gT56hwT9EhgREzShsHdqZoybZhrSr393VwSSP0k9FTcr+cKIlAHs=
X-Received: by 2002:a81:5904:0:b0:2eb:f900:882e with SMTP id
 n4-20020a815904000000b002ebf900882emr2888532ywb.281.1650115477295; Sat, 16
 Apr 2022 06:24:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220416110507.642398-1-pgwipeout@gmail.com> <20220416110507.642398-3-pgwipeout@gmail.com>
 <308e9c47197d4f7ae5a31cfcb5a10886@kernel.org>
In-Reply-To: <308e9c47197d4f7ae5a31cfcb5a10886@kernel.org>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Sat, 16 Apr 2022 09:24:26 -0400
Message-ID: <CAMdYzYo+YeAgT92baMOoWpra230wro_WynRcajL-__9RNkeE9Q@mail.gmail.com>
Subject: Re: [PATCH v7 2/4] PCI: dwc: rockchip: add legacy interrupt support
To:     Marc Zyngier <maz@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        PCI <linux-pci@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Apr 16, 2022 at 8:54 AM Marc Zyngier <maz@kernel.org> wrote:
>
> Peter,
>
> May I suggest that you slow down on the number of versions you send?
> This is the 7th in 5 days, the 3rd today.
>
> At this stage, this is entirely counterproductive.

Apologies, I'll be sure to be at least one cup of coffee in before
doing early morning code.

>
> On 2022-04-16 12:05, Peter Geis wrote:
> > The legacy interrupts on the rk356x pcie controller are handled by a
> > single muxed interrupt. Add irq domain support to the pcie-dw-rockchip
> > driver to support the virtual domain.
> >
> > Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 112 +++++++++++++++++-
> >  1 file changed, 110 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > index c9b341e55cbb..863374604fb1 100644
> > --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > @@ -10,9 +10,12 @@
> >
> >  #include <linux/clk.h>
> >  #include <linux/gpio/consumer.h>
> > +#include <linux/irqchip/chained_irq.h>
> > +#include <linux/irqdomain.h>
> >  #include <linux/mfd/syscon.h>
> >  #include <linux/module.h>
> >  #include <linux/of_device.h>
> > +#include <linux/of_irq.h>
> >  #include <linux/phy/phy.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/regmap.h>
> > @@ -36,10 +39,13 @@
> >  #define PCIE_LINKUP                  (PCIE_SMLH_LINKUP | PCIE_RDLH_LINKUP)
> >  #define PCIE_L0S_ENTRY                       0x11
> >  #define PCIE_CLIENT_GENERAL_CONTROL  0x0
> > +#define PCIE_CLIENT_INTR_STATUS_LEGACY       0x8
> > +#define PCIE_CLIENT_INTR_MASK_LEGACY 0x1c
> >  #define PCIE_CLIENT_GENERAL_DEBUG    0x104
> > -#define PCIE_CLIENT_HOT_RESET_CTRL      0x180
> > +#define PCIE_CLIENT_HOT_RESET_CTRL   0x180
> >  #define PCIE_CLIENT_LTSSM_STATUS     0x300
> > -#define PCIE_LTSSM_ENABLE_ENHANCE       BIT(4)
> > +#define PCIE_LEGACY_INT_ENABLE               GENMASK(3, 0)
> > +#define PCIE_LTSSM_ENABLE_ENHANCE    BIT(4)
> >  #define PCIE_LTSSM_STATUS_MASK               GENMASK(5, 0)
> >
> >  struct rockchip_pcie {
> > @@ -51,6 +57,8 @@ struct rockchip_pcie {
> >       struct reset_control            *rst;
> >       struct gpio_desc                *rst_gpio;
> >       struct regulator                *vpcie3v3;
> > +     struct irq_domain               *irq_domain;
> > +     raw_spinlock_t                  irq_lock;
> >  };
> >
> >  static int rockchip_pcie_readl_apb(struct rockchip_pcie *rockchip,
> > @@ -65,6 +73,94 @@ static void rockchip_pcie_writel_apb(struct
> > rockchip_pcie *rockchip,
> >       writel_relaxed(val, rockchip->apb_base + reg);
> >  }
> >
> > +static void rockchip_pcie_legacy_int_handler(struct irq_desc *desc)
> > +{
> > +     struct irq_chip *chip = irq_desc_get_chip(desc);
> > +     struct rockchip_pcie *rockchip = irq_desc_get_handler_data(desc);
> > +     unsigned long reg, hwirq;
> > +
> > +     chained_irq_enter(chip, desc);
> > +
> > +     reg = rockchip_pcie_readl_apb(rockchip,
> > PCIE_CLIENT_INTR_STATUS_LEGACY);
> > +
> > +     for_each_set_bit(hwirq, &reg, 8)
>
> 8? And yet:
>
> #define PCI_NUM_INTX        4
>
> So whatever bits are set above bit 3, you are feeding garbage
> to the irqdomain code.

There are 8 bits in total, the top four are for the TX interrupts, for
which EP mode is not yet supported by the driver.
I can constrain this further and let it be expanded when that support
is added, if that works for you?

>
> > +             generic_handle_domain_irq(rockchip->irq_domain, hwirq);
> > +
> > +     chained_irq_exit(chip, desc);
> > +}
> > +
> > +static void rockchip_intx_mask(struct irq_data *data)
> > +{
> > +     struct rockchip_pcie *rockchip = irq_data_get_irq_chip_data(data);
> > +     unsigned long flags;
> > +     u32 val;
> > +
> > +     /* disable legacy interrupts */
> > +     raw_spin_lock_irqsave(&rockchip->irq_lock, flags);
> > +     val = HIWORD_UPDATE_BIT(PCIE_LEGACY_INT_ENABLE);
> > +     val |= PCIE_LEGACY_INT_ENABLE;
> > +     rockchip_pcie_writel_apb(rockchip, val,
> > PCIE_CLIENT_INTR_MASK_LEGACY);
> > +     raw_spin_unlock_irqrestore(&rockchip->irq_lock, flags);
>
> This is completely busted. INTx lines must be controlled individually.
> If I disable one device's INTx output, I don't want to see the
> interrupt firing because another one has had its own enabled.

Okay, that makes sense. I'm hitting the entire block when it should be
the individual IRQ.
I also notice some drivers protect this with a spinlock while others
do not, how should this be handled?

>
>          M.
> --
> Jazz is not dead. It just smells funny...

Thanks Again!
