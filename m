Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEE03373DC3
	for <lists+linux-pci@lfdr.de>; Wed,  5 May 2021 16:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233161AbhEEOiF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 May 2021 10:38:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:54696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229707AbhEEOiC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 May 2021 10:38:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7075961157;
        Wed,  5 May 2021 14:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620225425;
        bh=Ehq7zR5EL010xOPMeZxXULfS9dLTcxOv/Y8XH3TPNrg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=AzPXRTqmdq8Gz1ySQkPfIP+VwZ8kSkK6//JYOAbDkcwfoDIkqxchIywlAiyKINUW/
         swIh3U5xJndPjHMTVXtNVGmEbpZURJADcYop7RZYbbCzqs8UUzopXq0gggYYsoyUEf
         LwHXJDv/SjP21Y7DWJAHJvySXeRqlMJDIL8jnoWwhC87n5FdymnbKGtLLZUhtlJx2V
         vTvyFjkVO4dZGm2fI9HuFRr0eaFdSLvEvH4LA0o+RHPFCCFg2HjNHLqzuU6/d2Co+h
         vbAOkNH4d/Daab1BGohc7xqjj9AdhcCUblGAB/UuScxBK9Q9/asI7LG1ZBTPQlyUu+
         5jqeISgj6Of1g==
Date:   Wed, 5 May 2021 09:37:04 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Greentime Hu <greentime.hu@sifive.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>, hes@sifive.com,
        Erik Danie <erik.danie@sifive.com>,
        Zong Li <zong.li@sifive.com>,
        Bjorn Helgaas <bhelgaas@google.com>, robh+dt@kernel.org,
        Albert Ou <aou@eecs.berkeley.edu>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Philipp Zabel <p.zabel@pengutronix.de>, alex.dewar90@gmail.com,
        khilman@baylibre.com, hayashi.kunihiko@socionext.com,
        vidyas@nvidia.com, jh80.chung@samsung.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v6 5/6] PCI: fu740: Add SiFive FU740 PCIe host controller
 driver
Message-ID: <20210505143704.GA1298791@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHCEehL21cFLp+JWMhKP8rAVtGunMv2fmfo6C6tbTGpgL9q2RA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 05, 2021 at 12:26:31PM +0800, Greentime Hu wrote:
> Bjorn Helgaas <helgaas@kernel.org> 於 2021年5月4日 週二 下午9:46寫道：
> > On Tue, May 04, 2021 at 06:59:39PM +0800, Greentime Hu wrote:
> > > From: Paul Walmsley <paul.walmsley@sifive.com>
> > >
> > > Add driver for the SiFive FU740 PCIe host controller.
> > > This controller is based on the DesignWare PCIe core.
> > >
> > > Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> > > Co-developed-by: Henry Styles <hes@sifive.com>
> > > Signed-off-by: Henry Styles <hes@sifive.com>
> > > Co-developed-by: Erik Danie <erik.danie@sifive.com>
> > > Signed-off-by: Erik Danie <erik.danie@sifive.com>
> > > Co-developed-by: Greentime Hu <greentime.hu@sifive.com>
> > > Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> > > ---
> > >  drivers/pci/controller/dwc/Kconfig      |  10 +
> > >  drivers/pci/controller/dwc/Makefile     |   1 +
> > >  drivers/pci/controller/dwc/pcie-fu740.c | 309 ++++++++++++++++++++++++
> > >  3 files changed, 320 insertions(+)
> > >  create mode 100644 drivers/pci/controller/dwc/pcie-fu740.c
> > >
> > > diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> > > index 22c5529e9a65..255d43b1661b 100644
> > > --- a/drivers/pci/controller/dwc/Kconfig
> > > +++ b/drivers/pci/controller/dwc/Kconfig
> > > @@ -318,4 +318,14 @@ config PCIE_AL
> > >         required only for DT-based platforms. ACPI platforms with the
> > >         Annapurna Labs PCIe controller don't need to enable this.
> > >
> > > +config PCIE_FU740
> > > +     bool "SiFive FU740 PCIe host controller"
> > > +     depends on PCI_MSI_IRQ_DOMAIN
> > > +     depends on SOC_SIFIVE || COMPILE_TEST
> > > +     depends on GPIOLIB
> > ...
> > 2) I would prefer not to depend on GPIOLIB because it reduces
> >    compile-test coverage.  For example, the x86_64 defconfig does not
> >    enable GPIOLIB, so one must manually enable it to even be able to
> >    enable PCIE_FU740.
> > ...

> Sorry for late to debug this case. I was working on other works and
> just missed the email.
> How about this?

We already dropped the "depends on GPIOLIB" for v5.13.

You can add a select later, for v5.14.  Of course, you should post a
complete patch including commit log and signed-off-by.

And please take a look at how other drivers handle this so you do it
the same way.

> diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> index e1b2690b6e45..66f57f2db49d 100644
> --- a/arch/riscv/Kconfig.socs
> +++ b/arch/riscv/Kconfig.socs
> @@ -7,6 +7,7 @@ config SOC_SIFIVE
>         select CLK_SIFIVE
>         select CLK_SIFIVE_PRCI
>         select SIFIVE_PLIC
> +       select GPIOLIB if PCIE_FU740
>         help
>           This enables support for SiFive SoC platform hardware.
> 
> diff --git a/drivers/pci/controller/dwc/Kconfig
> b/drivers/pci/controller/dwc/Kconfig
> index 255d43b1661b..0a37d21ed64e 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -322,7 +322,6 @@ config PCIE_FU740
>         bool "SiFive FU740 PCIe host controller"
>         depends on PCI_MSI_IRQ_DOMAIN
>         depends on SOC_SIFIVE || COMPILE_TEST
> -       depends on GPIOLIB
>         select PCIE_DW_HOST
>         help
>           Say Y here if you want PCIe controller support for the SiFive
