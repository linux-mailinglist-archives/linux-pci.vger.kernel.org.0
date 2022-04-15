Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2210B502F86
	for <lists+linux-pci@lfdr.de>; Fri, 15 Apr 2022 22:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351038AbiDOUKE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Apr 2022 16:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351052AbiDOUKC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Apr 2022 16:10:02 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA54BC1C8E;
        Fri, 15 Apr 2022 13:07:32 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-2ef5380669cso75468177b3.9;
        Fri, 15 Apr 2022 13:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J8BTGfO/r22ZuFlmHg1BcSrVfAWsJp/p0mdMRtAW2t0=;
        b=Gg/4A7a9HwP/ar/3uaMCgV+oFlNDZCp8R/h6URnv7Z99hP+QU4+lhIoFwppXE0g9mX
         CbInlYjvyTwYjzPVV2DZR11oWp9F9D2mWYXB69+1wb3M35isuvpYVKK3onM7I0YcyQLX
         YIW+cyTZhyPqeYzopC/XBnSq2nE6fgr6Snl6VDedtpkRKCuqzo+Rhy0j+cvvDtc231TV
         wJ1eM3G+RSc162wWjleX23uGEZ013Z7iprQcfp2TMOrLQuk+twwgr6Z/mPMWN2r8NaW+
         UXSja4DP5NFhd7Nfa/3NUx24jWJZAZzIx9kfB2FpvRr8lLUQGXD24Fv1tx/P/O/KWMdr
         ZyZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J8BTGfO/r22ZuFlmHg1BcSrVfAWsJp/p0mdMRtAW2t0=;
        b=xlHcHBbjZm55k4O8JhKoELTKhxCJ8yJaCP39rT/EeZY7JDbFkS+wVWyT+0PIdcmpKY
         huznm3Y6KX9adcxMv+OaGDmMb5W+k8BLOznbMxeQVwPpRu+rpx2XkGLW9t2Pmd27uBzB
         jz+7kwxupGUZOOOzBTSKTQO6vLlFXBUuaLDCaQ8Djk9/LqJQpSWIEYs83dQAYGP1Yuqd
         k06q41OF1HMtIPbIW3/QEuwgNnmnofKBL6dNIzkW6tD/uTwgtN640nGG1xL3Qa+0K565
         tA6M7EP75so3SBqO/PyNMgtGWziHpJjg4Xcp6qGNvclyiQKraLQSlByk0PP8wU+nn8qf
         eiuA==
X-Gm-Message-State: AOAM533DHJAu8DXESwDH96+hg/dAl/FSiC0Dh0iyA8Lu80xChJ2SvmY9
        PYrIMsren70bkcRcrhdnO5Oc5O7mUF03qr1DQMI=
X-Google-Smtp-Source: ABdhPJzT8hefuHIJJPpile9NnHRWHLBmVdg8kwGrKyUMRGlQGpxYevU+ZpH2MpWWVpGIDln1FyqM22pW+gyQbLiHI+E=
X-Received: by 2002:a81:578c:0:b0:2e6:2488:7ef8 with SMTP id
 l134-20020a81578c000000b002e624887ef8mr525532ywb.519.1650053251803; Fri, 15
 Apr 2022 13:07:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220413133731.242870-1-pgwipeout@gmail.com> <20220413133731.242870-3-pgwipeout@gmail.com>
 <c493261cef27714181a523545dab6d0e@kernel.org>
In-Reply-To: <c493261cef27714181a523545dab6d0e@kernel.org>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Fri, 15 Apr 2022 16:07:18 -0400
Message-ID: <CAMdYzYoBUMaipHK_ymwhx_y70N0MUN5noDvUFcf3mK5ngM0SmA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] PCI: dwc: rockchip: add legacy interrupt support
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

On Thu, Apr 14, 2022 at 4:36 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On 2022-04-13 14:37, Peter Geis wrote:
> > The legacy interrupts on the rk356x pcie controller are handled by a
> > single muxed interrupt. Add irq domain support to the pcie-dw-rockchip
> > driver to support the virtual domain.
> >
> > Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 123 +++++++++++++++++-
> >  1 file changed, 121 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > index c9b341e55cbb..a8b1dc03d3cc 100644
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
> > @@ -65,6 +73,105 @@ static void rockchip_pcie_writel_apb(struct
> > rockchip_pcie *rockchip,
> >       writel_relaxed(val, rockchip->apb_base + reg);
> >  }
> >
> > +static void rockchip_pcie_legacy_int_handler(struct irq_desc *desc)
> > +{
> > +     struct irq_chip *chip = irq_desc_get_chip(desc);
> > +     struct rockchip_pcie *rockchip = irq_desc_get_handler_data(desc);
> > +     struct device *dev = rockchip->pci.dev;
> > +     u32 reg;
> > +     u32 hwirq;
> > +     u32 virq;
> > +
> > +     chained_irq_enter(chip, desc);
> > +
> > +     reg = rockchip_pcie_readl_apb(rockchip,
> > PCIE_CLIENT_INTR_STATUS_LEGACY);
> > +
> > +     while (reg) {
> > +             hwirq = ffs(reg) - 1;
> > +             reg &= ~BIT(hwirq);
>
> The whole construct would be better served by for_each_set_bit().

Ah, that's much nicer, thanks!

>
> > +
> > +             virq = irq_find_mapping(rockchip->irq_domain, hwirq);
> > +             if (virq)
> > +                     generic_handle_irq(virq);
>
> Please replace this with generic_handle_domain_irq().

I see the bulk conversion was done after I created this patch.
I will make this change.

>
> > +             else
> > +                     dev_err(dev, "unexpected IRQ, INT%d\n", hwirq);
>
> This hardly serves any purpose. At best, this is a debug statement.
> At worse, this is a DoS. In any case, please remove it.

Done!

>
> > +     }
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
> > +};
> > +
> > +static void rockchip_intx_unmask(struct irq_data *data)
> > +{
> > +     struct rockchip_pcie *rockchip = irq_data_get_irq_chip_data(data);
> > +     unsigned long flags;
> > +     u32 val;
> > +
> > +     /* enable legacy interrupts */
> > +     raw_spin_lock_irqsave(&rockchip->irq_lock, flags);
> > +     val = HIWORD_UPDATE_BIT(PCIE_LEGACY_INT_ENABLE);
> > +     val &= ~PCIE_LEGACY_INT_ENABLE;
> > +     rockchip_pcie_writel_apb(rockchip, val,
> > PCIE_CLIENT_INTR_MASK_LEGACY);
> > +     raw_spin_unlock_irqrestore(&rockchip->irq_lock, flags);
> > +};
> > +
> > +static struct irq_chip rockchip_intx_irq_chip = {
> > +     .flags                  = IRQCHIP_SKIP_SET_WAKE | IRQCHIP_MASK_ON_SUSPEND,
> > +     .irq_mask               = rockchip_intx_mask,
> > +     .irq_unmask             = rockchip_intx_unmask,
> > +     .name                   = "INTx",
>
> For consistency, please place 'name' at the top, and 'flags' at the end.

Will do.

>
> > +};
> > +
> > +static int rockchip_pcie_intx_map(struct irq_domain *domain, unsigned
> > int irq,
> > +                               irq_hw_number_t hwirq)
> > +{
> > +     irq_set_chip_and_handler(irq, &rockchip_intx_irq_chip,
> > handle_simple_irq);
>
> Why isn't this a *level* handler, as per the PCI spec?

Fixed.

>
> > +     irq_set_chip_data(irq, domain->host_data);
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct irq_domain_ops intx_domain_ops = {
> > +     .map = rockchip_pcie_intx_map,
> > +};
> > +
> > +static int rockchip_pcie_init_irq_domain(struct rockchip_pcie
> > *rockchip)
> > +{
> > +     struct device *dev = rockchip->pci.dev;
> > +     struct device_node *intc;
> > +
> > +     raw_spin_lock_init(&rockchip->irq_lock);
> > +
> > +     intc = of_get_child_by_name(dev->of_node,
> > "legacy-interrupt-controller");
> > +     if (!intc) {
> > +             dev_err(dev, "missing child interrupt-controller node\n");
> > +             return -EINVAL;
> > +     }
> > +
> > +     rockchip->irq_domain = irq_domain_add_linear(intc, PCI_NUM_INTX,
> > +                                                 &intx_domain_ops, rockchip);
> > +     of_node_put(intc);
> > +     if (!rockchip->irq_domain) {
> > +             dev_err(dev, "failed to get a INTx IRQ domain\n");
> > +             return -EINVAL;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> >  static void rockchip_pcie_enable_ltssm(struct rockchip_pcie *rockchip)
> >  {
> >       rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_ENABLE_LTSSM,
> > @@ -111,7 +218,19 @@ static int rockchip_pcie_host_init(struct
> > pcie_port *pp)
> >  {
> >       struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> >       struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
> > +     struct device *dev = rockchip->pci.dev;
> >       u32 val = HIWORD_UPDATE_BIT(PCIE_LTSSM_ENABLE_ENHANCE);
> > +     int irq, ret;
> > +
> > +     irq = of_irq_get_byname(dev->of_node, "legacy");
> > +     if (irq < 0)
> > +             return irq;
> > +
> > +     irq_set_chained_handler_and_data(irq,
> > rockchip_pcie_legacy_int_handler, rockchip);
> > +
>
> Installing the handler before the domain is instantiated is
> unlikely to end well if you have a pending interrupt...

While the interrupts are masked at this stage, you make a valid point,
I'll move this a little south.

>
> > +     ret = rockchip_pcie_init_irq_domain(rockchip);
> > +     if (ret < 0)
> > +             dev_err(dev, "failed to init irq domain\n");
> >
> >       /* LTSSM enable control mode */
> >       rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_HOT_RESET_CTRL);
>
> Thanks,
>
>          M.
> --
> Jazz is not dead. It just smells funny...

Thank you for your review.
