Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25B71372BF2
	for <lists+linux-pci@lfdr.de>; Tue,  4 May 2021 16:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbhEDOZB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 May 2021 10:25:01 -0400
Received: from foss.arm.com ([217.140.110.172]:59244 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231580AbhEDOZB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 4 May 2021 10:25:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF76AED1;
        Tue,  4 May 2021 07:24:05 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4EF513F718;
        Tue,  4 May 2021 07:24:03 -0700 (PDT)
Date:   Tue, 4 May 2021 15:23:58 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Greentime Hu <greentime.hu@sifive.com>, paul.walmsley@sifive.com,
        hes@sifive.com, erik.danie@sifive.com, zong.li@sifive.com,
        bhelgaas@google.com, robh+dt@kernel.org, aou@eecs.berkeley.edu,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        alex.dewar90@gmail.com, khilman@baylibre.com,
        hayashi.kunihiko@socionext.com, vidyas@nvidia.com,
        jh80.chung@samsung.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v6 5/6] PCI: fu740: Add SiFive FU740 PCIe host controller
 driver
Message-ID: <20210504142358.GA25477@lpieralisi>
References: <20210504105940.100004-6-greentime.hu@sifive.com>
 <20210504134632.GA1088165@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210504134632.GA1088165@bjorn-Precision-5520>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 04, 2021 at 08:46:32AM -0500, Bjorn Helgaas wrote:
> On Tue, May 04, 2021 at 06:59:39PM +0800, Greentime Hu wrote:
> > From: Paul Walmsley <paul.walmsley@sifive.com>
> > 
> > Add driver for the SiFive FU740 PCIe host controller.
> > This controller is based on the DesignWare PCIe core.
> > 
> > Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> > Co-developed-by: Henry Styles <hes@sifive.com>
> > Signed-off-by: Henry Styles <hes@sifive.com>
> > Co-developed-by: Erik Danie <erik.danie@sifive.com>
> > Signed-off-by: Erik Danie <erik.danie@sifive.com>
> > Co-developed-by: Greentime Hu <greentime.hu@sifive.com>
> > Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> > ---
> >  drivers/pci/controller/dwc/Kconfig      |  10 +
> >  drivers/pci/controller/dwc/Makefile     |   1 +
> >  drivers/pci/controller/dwc/pcie-fu740.c | 309 ++++++++++++++++++++++++
> >  3 files changed, 320 insertions(+)
> >  create mode 100644 drivers/pci/controller/dwc/pcie-fu740.c
> > 
> > diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> > index 22c5529e9a65..255d43b1661b 100644
> > --- a/drivers/pci/controller/dwc/Kconfig
> > +++ b/drivers/pci/controller/dwc/Kconfig
> > @@ -318,4 +318,14 @@ config PCIE_AL
> >  	  required only for DT-based platforms. ACPI platforms with the
> >  	  Annapurna Labs PCIe controller don't need to enable this.
> >  
> > +config PCIE_FU740
> > +	bool "SiFive FU740 PCIe host controller"
> > +	depends on PCI_MSI_IRQ_DOMAIN
> > +	depends on SOC_SIFIVE || COMPILE_TEST
> > +	depends on GPIOLIB
> 
> 1) I'm a little disappointed that I reported the build issue 6 days
>    ago when we were already in the merge window, and it's taken until
>    now to make some progress.
> 
> 2) I would prefer not to depend on GPIOLIB because it reduces
>    compile-test coverage.  For example, the x86_64 defconfig does not
>    enable GPIOLIB, so one must manually enable it to even be able to
>    enable PCIE_FU740.
> 
>    Many other PCI controller drivers use GPIO, but no others depend on
>    GPIOLIB, so I infer that in the !GPIOLIB case, gpio/consumer.h
>    provides the stubs required for compile testing.
> 
>    We could have a conversation about whether it's better to
>    explicitly depend on GPIOLIB here, or whether building a working
>    FU740 driver implicitly depends on GPIOLIB being selected
>    elsewhere.  That implicit dependency *is* a little obscure, but I
>    think that's what other drivers currently do, and I'd like to do
>    this consistently unless there's a good reason otherwise.

I will drop the explicit GPIOLIB dependency and push it out. For (1) I
agree with you - I merged when I received some input - it is reasonable
to avoid adding it to v5.13 material for this reason, apologies.

Thanks,
Lorenzo

>    Here are some examples of other drivers:
> 
>    dwc/pci-dra7xx.c:
>      config PCI_DRA7XX_HOST
>        depends on SOC_DRA7XX || COMPILE_TEST
> 
>      config SOC_DRA7XX
>        select ARCH_OMAP2PLUS
> 
>      config ARCH_OMAP2PLUS
>        select GPIOLIB
> 
>    dwc/pci-meson.c:
>      config PCI_MESON
>        # doesn't, but probably *should* depend on "ARCH_MESON || COMPILE_TEST"
> 
>      menuconfig ARCH_MESON
>        select GPIOLIB
> 
>    dwc/pcie-qcom.c:
>      config PCIE_QCOM
>        depends on OF && (ARCH_QCOM || COMPILE_TEST)
> 
>      config ARCH_QCOM
>        select GPIOLIB
> 
>    pcie-rockchip.c:
>      config PCIE_ROCKCHIP_HOST
>        depends on ARCH_ROCKCHIP || COMPILE_TEST
> 
>      config ARCH_ROCKCHIP
>        select GPIOLIB
> 
> > +	select PCIE_DW_HOST
> > +	help
> > +	  Say Y here if you want PCIe controller support for the SiFive
> > +	  FU740.
> > +
> >  endmenu
