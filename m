Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B70D1504F65
	for <lists+linux-pci@lfdr.de>; Mon, 18 Apr 2022 13:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233791AbiDRLjv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Apr 2022 07:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbiDRLju (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Apr 2022 07:39:50 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6311571C;
        Mon, 18 Apr 2022 04:37:12 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id f38so25109667ybi.3;
        Mon, 18 Apr 2022 04:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yxOfQqOYcLl8cOCQEWivZY+/nyIZibatv5HXiF7JBAE=;
        b=AaXteUKTTWeEW2if3hZnkbvnrYbhoxpcbxkS2D80WdHvOFTry2qCM+xF4hf3QS4xWI
         HHl7tZiHr4P1WUz+XtyHyiWBctVBWF6o2UYNfFBk1Z/TDShk0BXeV3LVOrMYHxXfiDQw
         8ULCqTQMSxt7c512du6M+fQhahCuq+B4TPHKp73pzfbJhchgl28qjZF0w4EnD6bfu4vJ
         dSsSWdUEJSCdCjulVsK2pJnUpjowmn4TxE4eEu3V8f9icvedZX8IhgnkEqV/gGdQDm7A
         WE5At6SzV+BfP7MgpVfcJTxhHownscp7QECxZ8kmyB7/XqwQc+CLcUkWws6lIJ4TPZDH
         YtNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yxOfQqOYcLl8cOCQEWivZY+/nyIZibatv5HXiF7JBAE=;
        b=n+87hX5HwwgzIt0RHevnMkYSdyxuSikJ79PCMsjbiYTN+eUP93AoQq8Vv9idoBJgL9
         dSaz7+pTn5ildtYmZcnopQc0MkGYmslsglVa12reBJ8FaVEL0sfAjswZgB8su1S9YUCR
         9gC2PyojAqsabUgnIB17AOLlbhPuY7MsTbGh7OxJL6v3KKkOLSZwBv8Mf4UwnoYIatXI
         F1ZT0I3cR6ZS/Ul3anSLUK9F8AnsqtqIX4nwu3GelXBrmB4vwm2ouInlI4OKAr629iu4
         Mzj0IMtp2a/teI/00svMttqTS/hHlcPxMZN0jPfRn/oE/vDB+CTUXyLXkQnx8yzBwAf4
         bqrw==
X-Gm-Message-State: AOAM532XOfXvOaRD2omHktCwOrxQwqTQ6pf+4cjAk8Tc9MSmbE7F5t1L
        H6N/oeUoHFZeTTm+lENNhbPNHMQ+cpqxKHq0RbA=
X-Google-Smtp-Source: ABdhPJz7XgpmuAliwGrz6dX8K9sf8b6tP4Vmdc++R7UPxjfoDLnRZv/Maa7v/8Wp8HEDHI6F1JHHnZ8NLKE8n4k9IHk=
X-Received: by 2002:a25:720b:0:b0:63c:d640:e292 with SMTP id
 n11-20020a25720b000000b0063cd640e292mr9594876ybc.173.1650281831283; Mon, 18
 Apr 2022 04:37:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220416110507.642398-1-pgwipeout@gmail.com> <20220416110507.642398-3-pgwipeout@gmail.com>
 <308e9c47197d4f7ae5a31cfcb5a10886@kernel.org> <CAMdYzYo+YeAgT92baMOoWpra230wro_WynRcajL-__9RNkeE9Q@mail.gmail.com>
 <87zgkk9gtc.wl-maz@kernel.org>
In-Reply-To: <87zgkk9gtc.wl-maz@kernel.org>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Mon, 18 Apr 2022 07:37:00 -0400
Message-ID: <CAMdYzYo_+7rakc=GCTueEZvH_F4Co6+=eKAUztJaafiDXSKKXQ@mail.gmail.com>
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

On Sun, Apr 17, 2022 at 5:53 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On Sat, 16 Apr 2022 14:24:26 +0100,
> Peter Geis <pgwipeout@gmail.com> wrote:
> >
> > On Sat, Apr 16, 2022 at 8:54 AM Marc Zyngier <maz@kernel.org> wrote:
> > >
> > > Peter,
> > >
> > > May I suggest that you slow down on the number of versions you send?
> > > This is the 7th in 5 days, the 3rd today.
> > >
> > > At this stage, this is entirely counterproductive.
> >
> > Apologies, I'll be sure to be at least one cup of coffee in before
> > doing early morning code.
>
> Even with a steady intake of coffee, there is a pretty clear policy
> around the frequency of patch submission, see [1].
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst#n337
>
> There is no hard enforcement of this process, but that should give you
> an idea of how to deal with it. In any case, 7 series in less than a
> week is a clear sign that this series should be *ignored*, as the
> author is likely to post yet another one in the next few hours.

Understood.

>
> >
> > >
> > > On 2022-04-16 12:05, Peter Geis wrote:
> > > > The legacy interrupts on the rk356x pcie controller are handled by a
> > > > single muxed interrupt. Add irq domain support to the pcie-dw-rockchip
> > > > driver to support the virtual domain.
> > > >
> > > > Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> > > > ---
> > > >  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 112 +++++++++++++++++-
> > > >  1 file changed, 110 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > > > b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > > > index c9b341e55cbb..863374604fb1 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > > > @@ -10,9 +10,12 @@
> > > >
> > > >  #include <linux/clk.h>
> > > >  #include <linux/gpio/consumer.h>
> > > > +#include <linux/irqchip/chained_irq.h>
> > > > +#include <linux/irqdomain.h>
> > > >  #include <linux/mfd/syscon.h>
> > > >  #include <linux/module.h>
> > > >  #include <linux/of_device.h>
> > > > +#include <linux/of_irq.h>
> > > >  #include <linux/phy/phy.h>
> > > >  #include <linux/platform_device.h>
> > > >  #include <linux/regmap.h>
> > > > @@ -36,10 +39,13 @@
> > > >  #define PCIE_LINKUP                  (PCIE_SMLH_LINKUP | PCIE_RDLH_LINKUP)
> > > >  #define PCIE_L0S_ENTRY                       0x11
> > > >  #define PCIE_CLIENT_GENERAL_CONTROL  0x0
> > > > +#define PCIE_CLIENT_INTR_STATUS_LEGACY       0x8
> > > > +#define PCIE_CLIENT_INTR_MASK_LEGACY 0x1c
> > > >  #define PCIE_CLIENT_GENERAL_DEBUG    0x104
> > > > -#define PCIE_CLIENT_HOT_RESET_CTRL      0x180
> > > > +#define PCIE_CLIENT_HOT_RESET_CTRL   0x180
> > > >  #define PCIE_CLIENT_LTSSM_STATUS     0x300
> > > > -#define PCIE_LTSSM_ENABLE_ENHANCE       BIT(4)
> > > > +#define PCIE_LEGACY_INT_ENABLE               GENMASK(3, 0)
> > > > +#define PCIE_LTSSM_ENABLE_ENHANCE    BIT(4)
> > > >  #define PCIE_LTSSM_STATUS_MASK               GENMASK(5, 0)
> > > >
> > > >  struct rockchip_pcie {
> > > > @@ -51,6 +57,8 @@ struct rockchip_pcie {
> > > >       struct reset_control            *rst;
> > > >       struct gpio_desc                *rst_gpio;
> > > >       struct regulator                *vpcie3v3;
> > > > +     struct irq_domain               *irq_domain;
> > > > +     raw_spinlock_t                  irq_lock;
> > > >  };
> > > >
> > > >  static int rockchip_pcie_readl_apb(struct rockchip_pcie *rockchip,
> > > > @@ -65,6 +73,94 @@ static void rockchip_pcie_writel_apb(struct
> > > > rockchip_pcie *rockchip,
> > > >       writel_relaxed(val, rockchip->apb_base + reg);
> > > >  }
> > > >
> > > > +static void rockchip_pcie_legacy_int_handler(struct irq_desc *desc)
> > > > +{
> > > > +     struct irq_chip *chip = irq_desc_get_chip(desc);
> > > > +     struct rockchip_pcie *rockchip = irq_desc_get_handler_data(desc);
> > > > +     unsigned long reg, hwirq;
> > > > +
> > > > +     chained_irq_enter(chip, desc);
> > > > +
> > > > +     reg = rockchip_pcie_readl_apb(rockchip,
> > > > PCIE_CLIENT_INTR_STATUS_LEGACY);
> > > > +
> > > > +     for_each_set_bit(hwirq, &reg, 8)
> > >
> > > 8? And yet:
> > >
> > > #define PCI_NUM_INTX        4
> > >
> > > So whatever bits are set above bit 3, you are feeding garbage
> > > to the irqdomain code.
> >
> > There are 8 bits in total, the top four are for the TX interrupts, for
> > which EP mode is not yet supported by the driver.
>
> So why aren't they excluded from the set of bits that you look at?
>
> > I can constrain this further and let it be expanded when that support
> > is added, if that works for you?
>
> Well, you can't have INTx interrupts in EP mode (that's a TLP going
> out of the device, and not something that is signalled *to* the
> CPU). So the two should be mutually exclusive.

Thank you for the explanation, I haven't messed about with EP mode, so
my experience is solely with RC mode.

>
> >
> > >
> > > > +             generic_handle_domain_irq(rockchip->irq_domain, hwirq);
> > > > +
> > > > +     chained_irq_exit(chip, desc);
> > > > +}
> > > > +
> > > > +static void rockchip_intx_mask(struct irq_data *data)
> > > > +{
> > > > +     struct rockchip_pcie *rockchip = irq_data_get_irq_chip_data(data);
> > > > +     unsigned long flags;
> > > > +     u32 val;
> > > > +
> > > > +     /* disable legacy interrupts */
> > > > +     raw_spin_lock_irqsave(&rockchip->irq_lock, flags);
> > > > +     val = HIWORD_UPDATE_BIT(PCIE_LEGACY_INT_ENABLE);
> > > > +     val |= PCIE_LEGACY_INT_ENABLE;
> > > > +     rockchip_pcie_writel_apb(rockchip, val,
> > > > PCIE_CLIENT_INTR_MASK_LEGACY);
> > > > +     raw_spin_unlock_irqrestore(&rockchip->irq_lock, flags);
> > >
> > > This is completely busted. INTx lines must be controlled individually.
> > > If I disable one device's INTx output, I don't want to see the
> > > interrupt firing because another one has had its own enabled.
> >
> > Okay, that makes sense. I'm hitting the entire block when it should be
> > the individual IRQ.
> > I also notice some drivers protect this with a spinlock while others
> > do not, how should this be handled?
>
> It obviously depends on how the HW. works. If this is a shared
> register using a RMW sequence, then you need some form of mutual
> exclusion in order to preserve the atomicity of the update.
>
> If the HW supports updating the masks using a set of hot bits (with
> separate clear/set registers), than there is no need for locking.  In
> your case PCIE_CLIENT_INTR_MASK_LEGACY seems to support this odd
> "write-enable" feature which can probably be used to implement a
> lockless access, something like:
>
>         void mask(struct irq_data *d)
>         {
>                 u32 val = BIT(d->hwirq + 16) | BIT(d->hwirq);

This is what HIWORD_UPDATE_BIT does, it's rather common in Rockchip code.
I believe I can safely drop the spinlock when enabling/disabling
individual interrupts.

>                 writel_relaxed(val, ...);
>         }
>
>         void mask(struct irq_data *d)
>         {
>                 u32 val = BIT(d->hwirq + 16);
>                 writel_relaxed(val, ...);
>         }
>
> Another thing is that it is completely unclear to me what initialises
> these interrupts the first place (INTR_MASK_LEGACY, INTR_EN_LEGACY).
> Are you relying on the firmware to do that for you?

There is no dedicated mask or enable/disable for the legacy interrupt
line (unless it's undocumented).
It appears to be enabled via an "or" function with the emulated interrupts.
As far as I can tell this is common for dw-pcie, looking at the other drivers.

>
> Thanks,
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.

Thank you for your insight!
Peter
