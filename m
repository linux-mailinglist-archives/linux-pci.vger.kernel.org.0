Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 191FB37288B
	for <lists+linux-pci@lfdr.de>; Tue,  4 May 2021 12:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbhEDKNF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 May 2021 06:13:05 -0400
Received: from foss.arm.com ([217.140.110.172]:56502 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229947AbhEDKNE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 4 May 2021 06:13:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8CBB1D6E;
        Tue,  4 May 2021 03:12:09 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E2D803F73B;
        Tue,  4 May 2021 03:12:06 -0700 (PDT)
Date:   Tue, 4 May 2021 11:12:01 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Greentime Hu <greentime.hu@sifive.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>, hes@sifive.com,
        Erik Danie <erik.danie@sifive.com>,
        Zong Li <zong.li@sifive.com>,
        Bjorn Helgaas <bhelgaas@google.com>, robh+dt@kernel.org,
        Albert Ou <aou@eecs.berkeley.edu>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>, alex.dewar90@gmail.com,
        khilman@baylibre.com, hayashi.kunihiko@socionext.com,
        vidyas@nvidia.com, jh80.chung@samsung.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v5 0/6] Add SiFive FU740 PCIe host controller driver
 support
Message-ID: <20210504101201.GA20729@lpieralisi>
References: <20210406092634.50465-1-greentime.hu@sifive.com>
 <20210503164023.GA919777@bjorn-Precision-5520>
 <CAHCEeh+cMrEnHNG3W3ZNzdgT-m7BMorDawF6D8qkFYGg=RJMOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHCEeh+cMrEnHNG3W3ZNzdgT-m7BMorDawF6D8qkFYGg=RJMOw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 04, 2021 at 03:20:00PM +0800, Greentime Hu wrote:
> Bjorn Helgaas <helgaas@kernel.org> 於 2021年5月4日 週二 上午12:40寫道：
> >
> > On Tue, Apr 06, 2021 at 05:26:28PM +0800, Greentime Hu wrote:
> > > This patchset includes SiFive FU740 PCIe host controller driver. We also
> > > add pcie_aux clock and pcie_power_on_reset controller to prci driver for
> > > PCIe driver to use it.
> >
> > I dropped this series because of the build problem I mentioned [1].
> > It will not be included in v5.13 unless the build problem is fixed
> > ASAP.
> >
> > [1] https://lore.kernel.org/r/20210428194713.GA314975@bjorn-Precision-5520
> >
> 
> Hi all,
> 
> This build failed in x86_64 is because CONFIG_GPIOLIB is disabled in
> the testing config.
> 
> diff --git a/drivers/pci/controller/dwc/Kconfig
> b/drivers/pci/controller/dwc/Kconfig
> index 0a37d21ed64e..56b66e1fed53 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -323,6 +323,7 @@ config PCIE_FU740
>         depends on PCI_MSI_IRQ_DOMAIN
>         depends on SOC_SIFIVE || COMPILE_TEST
>         select PCIE_DW_HOST
> +       select GPIOLIB

I think that an include:

#include <linux/gpio/consumer.h>

in the driver would do. Still, I believe we should also add a
"depends on" in the Kconfig entry rather than a "select".

Please let me know as soon as possible.

Lorenzo

>         help
>           Say Y here if you want PCIe controller support for the SiFive
>           FU740.
> 
> After applying this change, it can build pass.
> 
> > > This is tested with e1000e: Intel(R) PRO/1000 Network Card, AMD Radeon R5
> > > 230 graphics card and SP M.2 PCIe Gen 3 SSD in SiFive Unmatched based on
> > > v5.11 Linux kernel.
> > >
> > > Changes in v5:
> > >  - Fix typo in comments
> > >  - Keep comments style consistent
> > >  - Refine some error handling codes
> > >  - Remove unneeded header file including
> > >  - Merge fu740_pcie_ltssm_enable implementation to fu740_pcie_start_link
> > >
> > > Changes in v4:
> > >  - Fix Wunused-but-set-variable warning in prci driver
> > >
> > > Changes in v3:
> > >  - Remove items that has been defined
> > >  - Refine format of sifive,fu740-pcie.yaml
> > >  - Replace perstn-gpios with the common one
> > >  - Change DBI mapping space to 2GB from 4GB
> > >  - Refine drivers/reset/Kconfig
> > >
> > > Changes in v2:
> > >  - Refine codes based on reviewers' feedback
> > >  - Remove define and use the common one
> > >  - Replace __raw_writel with writel_relaxed
> > >  - Split fu740_phyregreadwrite to write function
> > >  - Use readl_poll_timeout in stead of while loop checking
> > >  - Use dwc common codes
> > >  - Use gpio descriptors and the gpiod_* api.
> > >  - Replace devm_ioremap_resource with devm_platform_ioremap_resource_byname
> > >  - Replace devm_reset_control_get with devm_reset_control_get_exclusive
> > >  - Add more comments for delay and sleep
> > >  - Remove "phy ? x : y" expressions
> > >  - Refine code logic to remove possible infinite loop
> > >  - Replace magic number with meaningful define
> > >  - Remove fu740_pcie_pm_ops
> > >  - Use builtin_platform_driver
> > >
> > > Greentime Hu (5):
> > >   clk: sifive: Add pcie_aux clock in prci driver for PCIe driver
> > >   clk: sifive: Use reset-simple in prci driver for PCIe driver
> > >   MAINTAINERS: Add maintainers for SiFive FU740 PCIe driver
> > >   dt-bindings: PCI: Add SiFive FU740 PCIe host controller
> > >   riscv: dts: Add PCIe support for the SiFive FU740-C000 SoC
> > >
> > > Paul Walmsley (1):
> > >   PCI: fu740: Add SiFive FU740 PCIe host controller driver
> > >
> > >  .../bindings/pci/sifive,fu740-pcie.yaml       | 113 +++++++
> > >  MAINTAINERS                                   |   8 +
> > >  arch/riscv/boot/dts/sifive/fu740-c000.dtsi    |  33 ++
> > >  drivers/clk/sifive/Kconfig                    |   2 +
> > >  drivers/clk/sifive/fu740-prci.c               |  11 +
> > >  drivers/clk/sifive/fu740-prci.h               |   2 +-
> > >  drivers/clk/sifive/sifive-prci.c              |  54 +++
> > >  drivers/clk/sifive/sifive-prci.h              |  13 +
> > >  drivers/pci/controller/dwc/Kconfig            |   9 +
> > >  drivers/pci/controller/dwc/Makefile           |   1 +
> > >  drivers/pci/controller/dwc/pcie-fu740.c       | 308 ++++++++++++++++++
> > >  drivers/reset/Kconfig                         |   1 +
> > >  include/dt-bindings/clock/sifive-fu740-prci.h |   1 +
> > >  13 files changed, 555 insertions(+), 1 deletion(-)
> > >  create mode 100644 Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml
> > >  create mode 100644 drivers/pci/controller/dwc/pcie-fu740.c
> > >
> > > --
> > > 2.30.2
> > >
