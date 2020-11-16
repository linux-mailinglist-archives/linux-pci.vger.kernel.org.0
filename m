Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE1F82B4024
	for <lists+linux-pci@lfdr.de>; Mon, 16 Nov 2020 10:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbgKPJrg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Nov 2020 04:47:36 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45907 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbgKPJrf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Nov 2020 04:47:35 -0500
Received: by mail-oi1-f193.google.com with SMTP id k19so9504714oic.12;
        Mon, 16 Nov 2020 01:47:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z+F5r+A2Ydy3g6regFzy4mPZxcGaSWa5FXZJrRUitmk=;
        b=kIT5nfB1ZdslkbPXvstIPtol8scy4M/y1cVemcobxGuAW4cj1ZqhDCwRBY0Njfoqvx
         mNCtJHCLfEyXDH/83ymg5HXlwqC7hx1bTqSs+1ESMhSGLA+xJhsvaEEzNHGUAdXkPcXJ
         4MMzIK84NsgmA1lqP+8qg4etuRfE243bRyezbwVzKHtvkGwX7AV+wa47GeGNySeH+3uA
         w4Bv/0Cm5sm01oLHEZYD3jSQwHuqGu+mmvzjk0dums97yWXzN+CF5SEux+qGUtXd+1UL
         EYBDyxO6pspI0606de4HREsHV1zy7AJit8ygjf9/Z4okL+bXyg3FajEfGncJVZX6RHKi
         FlEQ==
X-Gm-Message-State: AOAM533kLXmMpK1Xft8fPBiBncQBSlpblqYaGU0NG0BHrZJT3sg3Y+uD
        uBXIsWhWUUBL3FmfiSy+kbjoy1vnq1pZrsBpj1E=
X-Google-Smtp-Source: ABdhPJywjKJgEoVdofvrrxMy7A30vVriKI1tM5Mq/PI9qja7lbnht9Sd63/thbMiAKpLUQgfaV6TpBEM7w2Aq4WrXdM=
X-Received: by 2002:aca:c3c4:: with SMTP id t187mr8708087oif.148.1605520054848;
 Mon, 16 Nov 2020 01:47:34 -0800 (PST)
MIME-Version: 1.0
References: <20200826111628.794979401@linutronix.de> <20201112125531.GA873287@nvidia.com>
 <87mtzmmzk6.fsf@nanos.tec.linutronix.de> <87k0uqmwn4.fsf@nanos.tec.linutronix.de>
 <87d00imlop.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87d00imlop.fsf@nanos.tec.linutronix.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 16 Nov 2020 10:47:23 +0100
Message-ID: <CAMuHMdXA7wfJovmfSH2nbAhN0cPyCiFHodTvg4a8Hm9rx5Dj-w@mail.gmail.com>
Subject: Re: iommu/vt-d: Cure VF irqdomain hickup
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Ziyad Atiyyeh <ziyadat@nvidia.com>,
        Itay Aveksis <itayav@nvidia.com>,
        Moshe Shemesh <moshe@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marc Zyngier <maz@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Thomas,

On Thu, Nov 12, 2020 at 8:16 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> The recent changes to store the MSI irqdomain pointer in struct device
> missed that Intel DMAR does not register virtual function devices.  Due to
> that a VF device gets the plain PCI-MSI domain assigned and then issues
> compat MSI messages which get caught by the interrupt remapping unit.
>
> Cure that by inheriting the irq domain from the physical function
> device.
>
> That's a temporary workaround. The correct fix is to inherit the irq domain
> from the bus, but that's a larger effort which needs quite some other
> changes to the way how x86 manages PCI and MSI domains.
>
> Fixes: 85a8dfc57a0b ("iommm/vt-d: Store irq domain in struct device")
> Reported-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  drivers/iommu/intel/dmar.c |   19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
>
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -333,6 +333,11 @@ static void  dmar_pci_bus_del_dev(struct
>         dmar_iommu_notify_scope_dev(info);
>  }
>
> +static inline void vf_inherit_msi_domain(struct pci_dev *pdev)
> +{
> +       dev_set_msi_domain(&pdev->dev, dev_get_msi_domain(&pdev->physfn->dev));

If CONFIG_PCI_ATS is not set:

    error: 'struct pci_dev' has no member named 'physfn'

http://kisskb.ellerman.id.au/kisskb/buildresult/14400927/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
