Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E41B8318BAC
	for <lists+linux-pci@lfdr.de>; Thu, 11 Feb 2021 14:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbhBKNLo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Feb 2021 08:11:44 -0500
Received: from mail-ot1-f54.google.com ([209.85.210.54]:43869 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbhBKNIZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Feb 2021 08:08:25 -0500
Received: by mail-ot1-f54.google.com with SMTP id l23so5032581otn.10;
        Thu, 11 Feb 2021 05:08:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hrYiHZwn2efD/4OUplpcI4tbR7mMPSrjnmc77Wk47SM=;
        b=GDImj6Feo2+LASjYhUOPPlBUbkTrpCiIGzIWsAh/WlfQDtHJW87ZHZ/YUZ3WaVhL8q
         trMyfhDQ6LAMoH8lvo2OyXW8Ldx/Q3fjDBZumGu/JkvmTVl8z6G/jsMhwmN4xwmem4P3
         I1eFGbizUY47C9vHotIuHRlsn5WfIECc2WjPSptEVvXkBLza6rMQ2+MMdkiYBMWuxpH0
         m5b2n12+pqC3iAfBtBaXIolA1ptPbTOEatuZuej6V+or0RZQTqdQ5s/uvGXkthjI/Kdh
         qmQG/G8ag7jl/Cp/gulDOogXokmf0Bnv2NjAlYMF2aOLCKG1hFpel/MOWCU3XVZQEdYW
         kBHg==
X-Gm-Message-State: AOAM530GK0ct9wDq7JPKjrZsrGCjfZ1olyLEsKL6bW+lLx2Q9ZEhZSz+
        J9eApMSBPrBjV8PpomM0pDAl8bqmsv9qsbQtWgE=
X-Google-Smtp-Source: ABdhPJwKgH5jgWs0XUJGT18qx9ESakb1Ou1OwU1Hv1anMHLpNlmoCV/MIo4NfHrfX5uC9XtiUTiaGfqeVe+r3kvmzKw=
X-Received: by 2002:a05:6830:119:: with SMTP id i25mr2764517otp.107.1613048856670;
 Thu, 11 Feb 2021 05:07:36 -0800 (PST)
MIME-Version: 1.0
References: <20210125162934.5335-1-daire.mcnamara@microchip.com>
 <20210125162934.5335-4-daire.mcnamara@microchip.com> <CAMuHMdXJQF3c1b6SXyHnuyA_huO7ZiKJ-_xm1r1h7VcGsv=n9A@mail.gmail.com>
 <d47ee0a2-7d9c-5c53-2977-09fa054e856b@codethink.co.uk>
In-Reply-To: <d47ee0a2-7d9c-5c53-2977-09fa054e856b@codethink.co.uk>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 11 Feb 2021 14:07:25 +0100
Message-ID: <CAMuHMdWZj5=vjno05F4hX6TGx0bvugBu53dhJ5L5wge2ezZuPQ@mail.gmail.com>
Subject: Re: [PATCH v21 3/4] PCI: microchip: Add host driver for Microchip
 PCIe controller
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     daire.mcnamara@microchip.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, david.abdurachmanov@gmail.com,
        cyril.jean@microchip.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Ben,

On Thu, Feb 11, 2021 at 2:03 PM Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> On 10/02/2021 13:07, Geert Uytterhoeven wrote:
> > On Mon, Jan 25, 2021 at 5:33 PM <daire.mcnamara@microchip.com> wrote:
> >> From: Daire McNamara <daire.mcnamara@microchip.com>
> >>
> >> Add support for the Microchip PolarFire PCIe controller when
> >> configured in host (Root Complex) mode.
> >>
> >> Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
> >> Reviewed-by: Rob Herring <robh@kernel.org>
> >
> > Thanks for your patch!
> >
> >> --- a/drivers/pci/controller/Kconfig
> >> +++ b/drivers/pci/controller/Kconfig
> >> @@ -298,6 +298,16 @@ config PCI_LOONGSON
> >>            Say Y here if you want to enable PCI controller support on
> >>            Loongson systems.
> >>
> >> +config PCIE_MICROCHIP_HOST
> >> +       bool "Microchip AXI PCIe host bridge support"
> >> +       depends on PCI_MSI && OF
> >> +       select PCI_MSI_IRQ_DOMAIN
> >> +       select GENERIC_MSI_IRQ_DOMAIN
> >> +       select PCI_HOST_COMMON
> >> +       help
> >> +         Say Y here if you want kernel to support the Microchip AXI PCIe
> >> +         Host Bridge driver.
> >
> > Is this PCIe host bridge accessible only from the PolarFire RISC-V
> > CPU cores, or also from softcores implemented in the PolarFire FPGA?
> >
> > In case of the former, we want to add a
> >
> >      depends on CONFIG_SOC_MICROCHIP_POLARFIRE || COMPILE_TEST
>
>
> I'd say having it on COMPILE_TEST if there's no polarfire includes
> would be useful to allow compile testing of the driver by the build
> robots.

As currently there is no platform dependency at all, it will be
compile-tested by allmodconfig on every config that has PCI_MSI && OF.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
