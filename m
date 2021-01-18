Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD47C2FA6B0
	for <lists+linux-pci@lfdr.de>; Mon, 18 Jan 2021 17:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392994AbhARQrS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Jan 2021 11:47:18 -0500
Received: from foss.arm.com ([217.140.110.172]:39358 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406368AbhARQqI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 18 Jan 2021 11:46:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E2F8331B;
        Mon, 18 Jan 2021 08:45:20 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 78DC73F68F;
        Mon, 18 Jan 2021 08:45:19 -0800 (PST)
Date:   Mon, 18 Jan 2021 16:45:17 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     kernel test robot <lkp@intel.com>, daire.mcnamara@microchip.com
Cc:     bhelgaas@google.com, robh@kernel.org, linux-pci@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        kbuild-all@lists.01.org, david.abdurachmanov@gmail.com,
        cyril.jean@microchip.com, ben.dooks@codethink.co.uk
Subject: Re: [PATCH v19 3/4] PCI: microchip: Add host driver for Microchip
 PCIe controller
Message-ID: <20210118164517.GB16417@e121166-lin.cambridge.arm.com>
References: <20201224094500.19149-4-daire.mcnamara@microchip.com>
 <202012291014.UP1fULPL-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202012291014.UP1fULPL-lkp@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 29, 2020 at 10:21:23AM +0800, kernel test robot wrote:
> Hi,
> 
> Thank you for the patch! Perhaps something to improve:

Can you fix it up promptly and resend please ?

Thanks,
Lorenzo

> [auto build test WARNING on 3650b228f83adda7e5ee532e2b90429c03f7b9ec]
> 
> url:    https://github.com/0day-ci/linux/commits/daire-mcnamara-microchip-com/PCI-microchip-Add-host-driver-for-Microchip-PCIe-controller/20201224-174858
> base:    3650b228f83adda7e5ee532e2b90429c03f7b9ec
> config: mips-allyesconfig (attached as .config)
> compiler: mips-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/0day-ci/linux/commit/05ba26bb79a9904585ed68019beec93a5258b0f3
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review daire-mcnamara-microchip-com/PCI-microchip-Add-host-driver-for-Microchip-PCIe-controller/20201224-174858
>         git checkout 05ba26bb79a9904585ed68019beec93a5258b0f3
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=mips 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>    drivers/pci/controller/pcie-microchip-host.c: In function 'mc_msi_bottom_irq_ack':
> >> drivers/pci/controller/pcie-microchip-host.c:436:17: warning: variable 'msi' set but not used [-Wunused-but-set-variable]
>      436 |  struct mc_msi *msi;
>          |                 ^~~
> 
> 
> vim +/msi +436 drivers/pci/controller/pcie-microchip-host.c
> 
>    431	
>    432	static void mc_msi_bottom_irq_ack(struct irq_data *data)
>    433	{
>    434		struct mc_port *port = irq_data_get_irq_chip_data(data);
>    435		void __iomem *bridge_base_addr;
>  > 436		struct mc_msi *msi;
>    437		u32 bitpos = data->hwirq;
>    438		unsigned long status;
>    439	
>    440		bridge_base_addr = port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
>    441		msi = &port->msi;
>    442	
>    443		writel_relaxed(BIT(bitpos), bridge_base_addr + ISTATUS_MSI);
>    444		status = readl_relaxed(bridge_base_addr + ISTATUS_MSI);
>    445		if (!status)
>    446			writel_relaxed(BIT(PM_MSI_INT_MSI_SHIFT), bridge_base_addr + ISTATUS_LOCAL);
>    447	}
>    448	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


