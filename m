Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 019C238B0FF
	for <lists+linux-pci@lfdr.de>; Thu, 20 May 2021 16:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235069AbhETOIc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 May 2021 10:08:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:39686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236494AbhETOGy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 May 2021 10:06:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BE39B6109F;
        Thu, 20 May 2021 14:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621519533;
        bh=jdo1Eh8m/liGd7cXoNawISzRkt+xVPjLMvGAq33h6fk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tZmOwklZrnAez5fSefENa/zyVwCYwW5cfwQqOoFKs0K3g82kll9KqFR7b6syQMRVR
         FcVzLuoJ3EItb7V2oyg+BlqTv95GGCCLWyxmv2rfdZVbTGreoNNWT9xkY4nYYqc3az
         c4/AipxylDwHlp02TDBdR9ZuPT65nH0DLiJDqFBk8zX5meu4b2qPbm9pGhzTEZRs0C
         TT0YyBHEGyanibEYBAF815V3F+SLpdY58Rged4789CRgmJbk6ntoSAh5kHt65mIx0F
         HVS1b6nZTmaPIQCpB79n7uQdBQTUzq1McBekm2KGetv2UXB1saI/msYKikueM0iEPp
         hjAK1IfaS8DDQ==
Received: by pali.im (Postfix)
        id 1AE649D1; Thu, 20 May 2021 16:05:30 +0200 (CEST)
Date:   Thu, 20 May 2021 16:05:29 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Sandor Bodo-Merle <sbodomerle@gmail.com>
Cc:     linux-pci@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
Subject: Re: pcie-iproc-msi.c: Bug in Multi-MSI support?
Message-ID: <20210520140529.rczoz3npjoadzfqc@pali>
References: <20210520120055.jl7vkqanv7wzeipq@pali>
 <CABLWAfQbKy=fpaY6J=gqtJy5L+pqNeqwU6qkVswYaWnVjiwAHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABLWAfQbKy=fpaY6J=gqtJy5L+pqNeqwU6qkVswYaWnVjiwAHw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello!

On Thursday 20 May 2021 15:47:46 Sandor Bodo-Merle wrote:
> Hi Pali,
> 
> thanks for catching this - i dig up the followup fixup commit we have
> for the iproc multi MSI (it was sent to Broadcom - but unfortunately
> we missed upstreaming it).
> 
> Commit fc54bae28818 ("PCI: iproc: Allow allocation of multiple MSIs")
> failed to reserve the proper number of bits from the inner domain.
> We need to allocate the proper amount of bits otherwise the domains for
> multiple PCIe endpoints may overlap and freeing one of them will result
> in freeing unrelated MSI vectors.
> 
> Fixes: fc54bae28818 ("PCI: iproc: Allow allocation of multiple MSIs")
> ---
>  drivers/pci/host/pcie-iproc-msi.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git drivers/pci/host/pcie-iproc-msi.c drivers/pci/host/pcie-iproc-msi.c
> index 708fdb1065f8..a00492dccb74 100644
> --- drivers/pci/host/pcie-iproc-msi.c
> +++ drivers/pci/host/pcie-iproc-msi.c
> @@ -260,11 +260,11 @@ static int iproc_msi_irq_domain_alloc(struct
> irq_domain *domain,
> 
>         mutex_lock(&msi->bitmap_lock);
> 
> -       /* Allocate 'nr_cpus' number of MSI vectors each time */
> +       /* Allocate 'nr_irqs' multiplied by 'nr_cpus' number of MSI
> vectors each time */
>         hwirq = bitmap_find_next_zero_area(msi->bitmap, msi->nr_msi_vecs, 0,
> -                                          msi->nr_cpus, 0);
> +                                          msi->nr_cpus * nr_irqs, 0);

I'm not sure if this construction is correct. Multi-MSI interrupts needs
to be aligned to number of requested interrupts. So if wifi driver asks
for 32 Multi-MSI interrupts then first allocated interrupt number must
be dividable by 32.

>         if (hwirq < msi->nr_msi_vecs) {
> -               bitmap_set(msi->bitmap, hwirq, msi->nr_cpus);
> +               bitmap_set(msi->bitmap, hwirq, msi->nr_cpus * nr_irqs);

And another issue is that only power of 2 interrupts for Multi-MSI can
be allocated. Otherwise one number may be allocated to more devices.

But I'm not sure how number of CPUs affects it as other PCIe controller
drivers do not use number of CPUs.

Other drivers are using bitmap_find_free_region() function with
order_base_2(nr_irqs) as argument.

I hope that somebody else more skilled with MSI interrupts look at these
constructions if are correct or needs more rework.

>         } else {
>                 mutex_unlock(&msi->bitmap_lock);
>                 return -ENOSPC;
> @@ -292,7 +292,7 @@ static void iproc_msi_irq_domain_free(struct
> irq_domain *domain,
>         mutex_lock(&msi->bitmap_lock);
> 
>         hwirq = hwirq_to_canonical_hwirq(msi, data->hwirq);
> -       bitmap_clear(msi->bitmap, hwirq, msi->nr_cpus);
> +       bitmap_clear(msi->bitmap, hwirq, msi->nr_cpus * nr_irqs);
> 
>         mutex_unlock(&msi->bitmap_lock);
> 
> 
> On Thu, May 20, 2021 at 2:04 PM Pali Rohár <pali@kernel.org> wrote:
> >
> > Hello!
> >
> > I think there is a bug in pcie-iproc-msi.c driver. It declares
> > Multi MSI support via MSI_FLAG_MULTI_PCI_MSI flag, see:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/pcie-iproc-msi.c?h=v5.12#n174
> >
> > but its iproc_msi_irq_domain_alloc() function completely ignores nr_irqs
> > argument when allocating interrupt numbers from bitmap, see:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/pcie-iproc-msi.c?h=v5.12#n246
> >
> > I think this this is incorrect as alloc callback should allocate nr_irqs
> > multi interrupts as caller requested. All other drivers with Multi MSI
> > support are doing it.
> >
> > Could you look at it?
