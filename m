Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74B484550B2
	for <lists+linux-pci@lfdr.de>; Wed, 17 Nov 2021 23:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241411AbhKQWt4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Nov 2021 17:49:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:49482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241317AbhKQWty (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 17 Nov 2021 17:49:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A7F0761BD4;
        Wed, 17 Nov 2021 22:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637189215;
        bh=o873rE9e1QuD81xkSB+mD5gzqmQzgM1i0CnzNUpRM2U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nlO6j6YBhZmcLmKFf5lapNc/k+60YGYeRqi6z1Hv49QPhQxRax+vo/8za45kiHxUW
         us5CEw9dqyWzkUFV/BcnCs9sJQUOV86Tq6uUP2jw2Lb4fUEuIfteLlQrV3XArvR0UM
         HOtHv+138KzYzUVncprqiUWVYd6H6bMUG9r/Rh5MqVQRdp6Dg8AcD5nqVHVtj/Fuz5
         JvO4BEEv6xO7Alh+aWhHaIVz95C7TShR/5EhHrrOlA1r1NFJ7e5Z7L7XAZOA4RBBB1
         nUHVIWZcveIUbsjFHWiT6Dd/m7+QQUKA0UDWOVf//o0+rVsYJeoPTFpO8xrcp6uium
         ZJx8e1/QWj+TQ==
Received: by mail-qt1-f175.google.com with SMTP id l8so4241539qtk.6;
        Wed, 17 Nov 2021 14:46:55 -0800 (PST)
X-Gm-Message-State: AOAM532FtJNjAxiIZLenDcGT0ZaMWAE17NLXv+0NONdfbbl1h4xBy87z
        b79rN8q1w+RWzDX10bFD9bW/kyqPNcjWYJa2kw==
X-Google-Smtp-Source: ABdhPJz92a0xTUBFxafDyj3yeyzY2HyiybbHf4pcSglmICdS3ozN3VsNu0bM6dYbR37MoFyKKdtVhN0KHBEfMxAFIyE=
X-Received: by 2002:a05:622a:44a:: with SMTP id o10mr20531125qtx.212.1637189214741;
 Wed, 17 Nov 2021 14:46:54 -0800 (PST)
MIME-Version: 1.0
References: <20211115112000.23693-1-andriy.shevchenko@linux.intel.com>
 <94d3f4e5-a698-134c-8264-55d31d3eafa6@arm.com> <CAHp75VeJ8ZiD=qQVfeahUjGZduFRJJ5683hn8f4810JYEzsCyw@mail.gmail.com>
 <YZJxG7JFAfIqr1/f@smile.fi.intel.com> <CAL_JsqJndi-gmenSpPtMVfsb3SrA=w+YBsSh3GigfgXC3rYDeQ@mail.gmail.com>
 <71a90592-99bb-13e1-a671-eb19c2dad3da@broadcom.com> <351fa3ec-52fa-58f5-cc57-e92498647d5c@gmail.com>
In-Reply-To: <351fa3ec-52fa-58f5-cc57-e92498647d5c@gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 17 Nov 2021 16:46:42 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJHBv9LrYH51iw_Quwub2qnZiv86ikd=ZMxGurxWrKHPw@mail.gmail.com>
Message-ID: <CAL_JsqJHBv9LrYH51iw_Quwub2qnZiv86ikd=ZMxGurxWrKHPw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] PCI: brcmstb: Use BIT() as __GENMASK() is for
 internal use only
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Marc Zyngier <maz@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jim Quinlan <jim2101024@gmail.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 16, 2021 at 2:56 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> On 11/16/21 12:41 PM, Florian Fainelli wrote:
> > On 11/16/21 10:20 AM, Rob Herring wrote:
> >> +Marc Z
> >>
> >> On Mon, Nov 15, 2021 at 8:39 AM Andy Shevchenko
> >> <andriy.shevchenko@linux.intel.com> wrote:
> >>>
> >>> On Mon, Nov 15, 2021 at 04:14:21PM +0200, Andy Shevchenko wrote:
> >>>> On Mon, Nov 15, 2021 at 4:01 PM Robin Murphy <robin.murphy@arm.com> wrote:
> >>>>> On 2021-11-15 11:20, Andy Shevchenko wrote:
> >>>>>> Use BIT() as __GENMASK() is for internal use only. The rationale
> >>>>>> of switching to BIT() is to provide better generated code. The
> >>>>>> GENMASK() against non-constant numbers may produce an ugly assembler
> >>>>>> code. On contrary the BIT() is simply converted to corresponding shift
> >>>>>> operation.
> >>>>>
> >>>>> FWIW, If you care about code quality and want the compiler to do the
> >>>>> obvious thing, why not specify it as the obvious thing:
> >>>>>
> >>>>>         u32 val = ~0 << msi->legacy_shift;
> >>>>
> >>>> Obvious and buggy (from the C standard point of view)? :-)
> >>>
> >>> Forgot to mention that BIT() is also makes it easy to avoid such mistake.
> >>>
> >>>>> Personally I don't think that abusing BIT() in the context of setting
> >>>>> multiple bits is any better than abusing __GENMASK()...
> >>>>
> >>>> No, BIT() is not abused here, but __GENMASK().
> >>>>
> >>>> After all it's up to you, folks, consider that as a bug report.
> >>
> >> Couldn't we get rid of legacy_shift entirely if the legacy case sets
> >> up 'hwirq' as 24-31 rather than 0-7? Though the data for the MSI msg
> >> uses the hwirq.
> >
> > I personally find it clearer and easier to reason about with the current
> > code though I suppose that with an appropriate xlate method we could
> > sort of set up the hwirq the way we want them to be to avoid any
> > shifting in brcm_pcie_msi_isr().
>
> Something like the following maybe? Completely untested as I don't
> believe I have a device with that legacy controller available at the moment:
>
> diff --git a/drivers/pci/controller/pcie-brcmstb.c
> b/drivers/pci/controller/pcie-brcmstb.c
> index 1fc7bd49a7ad..41404b268fa3 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -144,6 +144,8 @@
>  #define BRCM_INT_PCI_MSI_NR            32
>  #define BRCM_INT_PCI_MSI_LEGACY_NR     8
>  #define BRCM_INT_PCI_MSI_SHIFT         0
> +#define BRCM_INT_PCI_MSI_MASK          GENMASK(BRCM_INT_PCI_MSI_NR - 1, 0)
> +#define BRCM_INT_PCI_MSI_LEGACY_MASK   GENMASK(31, 32 -
> BRCM_INT_PCI_MSI_LEGACY_NR)
>
>  /* MSI target addresses */
>  #define BRCM_MSI_TARGET_ADDR_LT_4GB    0x0fffffffcULL
> @@ -269,8 +271,6 @@ struct brcm_msi {
>         /* used indicates which MSI interrupts have been alloc'd */
>         unsigned long           used;
>         bool                    legacy;
> -       /* Some chips have MSIs in bits [31..24] of a shared register. */
> -       int                     legacy_shift;
>         int                     nr; /* No. of MSI available, depends on chip */

Can get rid of this too I think.

>         /* This is the base pointer for interrupt status/set/clr regs */
>         void __iomem            *intr_base;
> @@ -486,7 +486,6 @@ static void brcm_pcie_msi_isr(struct irq_desc *desc)
>         dev = msi->dev;
>
>         status = readl(msi->intr_base + MSI_INT_STATUS);
> -       status >>= msi->legacy_shift;
>
>         for_each_set_bit(bit, &status, msi->nr) {

'nr' needs to be 32 here.

>                 int ret;
> @@ -516,9 +515,8 @@ static int brcm_msi_set_affinity(struct irq_data
> *irq_data,
>  static void brcm_msi_ack_irq(struct irq_data *data)
>  {
>         struct brcm_msi *msi = irq_data_get_irq_chip_data(data);
> -       const int shift_amt = data->hwirq + msi->legacy_shift;
>
> -       writel(1 << shift_amt, msi->intr_base + MSI_INT_CLR);
> +       writel(BIT(data->hwirq), msi->intr_base + MSI_INT_CLR);
>  }
>
>
> @@ -573,9 +571,31 @@ static void brcm_irq_domain_free(struct irq_domain
> *domain,
>         brcm_msi_free(msi, d->hwirq);
>  }
>
> +static int brcm_irq_domain_xlate(struct irq_domain *d,
> +                                struct device_node *node,
> +                                const u32 *intspec, unsigned int intsize,
> +                                unsigned long *out_hwirq,
> +                                unsigned int *out_type)
> +{
> +       struct brcm_msi *msi = d->host_data;
> +
> +       if (WARN_ON(intsize < 1))
> +               return -EINVAL;
> +
> +       if (msi->legacy) {
> +               *out_hwirq = intspec[0] + BRCM_INT_PCI_MSI_SHIFT;
> +               *out_type = IRQ_TYPE_NONE;
> +               return 0;
> +       }
> +
> +       return irq_domain_xlate_onecell(d, node, intspec, intsize,
> +                                       out_hwirq, out_type);

When would xlate get called? You don't have an intspec from DT.
Wouldn't it be enough to set bits 0-23 in 'used' bitmap so that only
24-31 can be allocated?

I'm not really sure though with how all the MSI stuff works.

> +}
> +
>  static const struct irq_domain_ops msi_domain_ops = {
>         .alloc  = brcm_irq_domain_alloc,
>         .free   = brcm_irq_domain_free,
> +       .xlate  = brcm_irq_domain_xlate,
>  };
>
>  static int brcm_allocate_domains(struct brcm_msi *msi)
> @@ -619,7 +639,8 @@ static void brcm_msi_remove(struct brcm_pcie *pcie)
>
>  static void brcm_msi_set_regs(struct brcm_msi *msi)
>  {
> -       u32 val = __GENMASK(31, msi->legacy_shift);
> +       u32 val = msi->legacy ? BRCM_INT_PCI_MSI_MASK :
> +                               BRCM_INT_PCI_MSI_LEGACY_MASK;

Perhaps just change legacy to a mask.

>
>         writel(val, msi->intr_base + MSI_INT_MASK_CLR);
>         writel(val, msi->intr_base + MSI_INT_CLR);
> @@ -664,11 +685,9 @@ static int brcm_pcie_enable_msi(struct brcm_pcie *pcie)
>         if (msi->legacy) {
>                 msi->intr_base = msi->base + PCIE_INTR2_CPU_BASE;
>                 msi->nr = BRCM_INT_PCI_MSI_LEGACY_NR;
> -               msi->legacy_shift = 24;
>         } else {
>                 msi->intr_base = msi->base + PCIE_MSI_INTR2_BASE;
>                 msi->nr = BRCM_INT_PCI_MSI_NR;
> -               msi->legacy_shift = 0;
>         }
>
>         ret = brcm_allocate_domains(msi);
>
> --
> Florian
