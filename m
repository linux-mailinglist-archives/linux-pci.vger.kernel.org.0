Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7F63371C60
	for <lists+linux-pci@lfdr.de>; Mon,  3 May 2021 18:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232876AbhECQwG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 May 2021 12:52:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:32838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233843AbhECQtc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 3 May 2021 12:49:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F1AD06191F;
        Mon,  3 May 2021 16:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620060025;
        bh=tHYHD0jT1jG1itD5UPajDk4y8ocfKR79gQ2CjG/pTbE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=JLcFn19J2apAX5K6ef/KUYrOmvgNsunQdt63eKOmDkGhDnGLgDFdRB28ot7D5pyH1
         h7FjPDwLxcv/lBZoRCqschRbNQJyuaUlQEvu6LAdC3EPK6IB3XuPpz/haaWUPJoqRA
         178OmpJBsTkGhHwdI7FrX7de02BLp77vbKCE4zWBQBHUaTZ0T+UfPOnhSEXca2f50h
         VFgjuxVEQafjC+uGCmls8vfTGrwMsu4HVWLvww0OzwbF4wsLh4+NBwIIg+WMwqGw9r
         Ao/8VK+gu4mPYmjitl2EcyaxWahhfbK+p7wOpx881wxfeiSp1TOv+tMN1sGNYOhwxj
         JWfD4/WsFmLiQ==
Date:   Mon, 3 May 2021 11:40:23 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Greentime Hu <greentime.hu@sifive.com>
Cc:     paul.walmsley@sifive.com, hes@sifive.com, erik.danie@sifive.com,
        zong.li@sifive.com, bhelgaas@google.com, robh+dt@kernel.org,
        aou@eecs.berkeley.edu, mturquette@baylibre.com, sboyd@kernel.org,
        lorenzo.pieralisi@arm.com, p.zabel@pengutronix.de,
        alex.dewar90@gmail.com, khilman@baylibre.com,
        hayashi.kunihiko@socionext.com, vidyas@nvidia.com,
        jh80.chung@samsung.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v5 0/6] Add SiFive FU740 PCIe host controller driver
 support
Message-ID: <20210503164023.GA919777@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210406092634.50465-1-greentime.hu@sifive.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 06, 2021 at 05:26:28PM +0800, Greentime Hu wrote:
> This patchset includes SiFive FU740 PCIe host controller driver. We also
> add pcie_aux clock and pcie_power_on_reset controller to prci driver for
> PCIe driver to use it.

I dropped this series because of the build problem I mentioned [1].
It will not be included in v5.13 unless the build problem is fixed
ASAP.

[1] https://lore.kernel.org/r/20210428194713.GA314975@bjorn-Precision-5520

> This is tested with e1000e: Intel(R) PRO/1000 Network Card, AMD Radeon R5
> 230 graphics card and SP M.2 PCIe Gen 3 SSD in SiFive Unmatched based on
> v5.11 Linux kernel.
> 
> Changes in v5:
>  - Fix typo in comments
>  - Keep comments style consistent
>  - Refine some error handling codes
>  - Remove unneeded header file including
>  - Merge fu740_pcie_ltssm_enable implementation to fu740_pcie_start_link
> 
> Changes in v4:
>  - Fix Wunused-but-set-variable warning in prci driver
> 
> Changes in v3:
>  - Remove items that has been defined
>  - Refine format of sifive,fu740-pcie.yaml
>  - Replace perstn-gpios with the common one
>  - Change DBI mapping space to 2GB from 4GB
>  - Refine drivers/reset/Kconfig
> 
> Changes in v2:
>  - Refine codes based on reviewers' feedback
>  - Remove define and use the common one
>  - Replace __raw_writel with writel_relaxed
>  - Split fu740_phyregreadwrite to write function
>  - Use readl_poll_timeout in stead of while loop checking
>  - Use dwc common codes
>  - Use gpio descriptors and the gpiod_* api.
>  - Replace devm_ioremap_resource with devm_platform_ioremap_resource_byname
>  - Replace devm_reset_control_get with devm_reset_control_get_exclusive
>  - Add more comments for delay and sleep
>  - Remove "phy ? x : y" expressions
>  - Refine code logic to remove possible infinite loop
>  - Replace magic number with meaningful define
>  - Remove fu740_pcie_pm_ops
>  - Use builtin_platform_driver
> 
> Greentime Hu (5):
>   clk: sifive: Add pcie_aux clock in prci driver for PCIe driver
>   clk: sifive: Use reset-simple in prci driver for PCIe driver
>   MAINTAINERS: Add maintainers for SiFive FU740 PCIe driver
>   dt-bindings: PCI: Add SiFive FU740 PCIe host controller
>   riscv: dts: Add PCIe support for the SiFive FU740-C000 SoC
> 
> Paul Walmsley (1):
>   PCI: fu740: Add SiFive FU740 PCIe host controller driver
> 
>  .../bindings/pci/sifive,fu740-pcie.yaml       | 113 +++++++
>  MAINTAINERS                                   |   8 +
>  arch/riscv/boot/dts/sifive/fu740-c000.dtsi    |  33 ++
>  drivers/clk/sifive/Kconfig                    |   2 +
>  drivers/clk/sifive/fu740-prci.c               |  11 +
>  drivers/clk/sifive/fu740-prci.h               |   2 +-
>  drivers/clk/sifive/sifive-prci.c              |  54 +++
>  drivers/clk/sifive/sifive-prci.h              |  13 +
>  drivers/pci/controller/dwc/Kconfig            |   9 +
>  drivers/pci/controller/dwc/Makefile           |   1 +
>  drivers/pci/controller/dwc/pcie-fu740.c       | 308 ++++++++++++++++++
>  drivers/reset/Kconfig                         |   1 +
>  include/dt-bindings/clock/sifive-fu740-prci.h |   1 +
>  13 files changed, 555 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml
>  create mode 100644 drivers/pci/controller/dwc/pcie-fu740.c
> 
> -- 
> 2.30.2
> 
