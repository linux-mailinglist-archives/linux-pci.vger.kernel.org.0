Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A872234DD1
	for <lists+linux-pci@lfdr.de>; Sat,  1 Aug 2020 00:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbgGaWus (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 31 Jul 2020 18:50:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:55866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbgGaWus (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 31 Jul 2020 18:50:48 -0400
Received: from localhost (mobile-166-175-186-42.mycingular.net [166.175.186.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B95A2072A;
        Fri, 31 Jul 2020 22:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596235847;
        bh=wCNG2zlKUehXnKLH/FLwztoJppMUKooHRjx7RwZ/Oqw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=xwAq5wpiO5dYRbxrXR1Ssqnm0RHN2Burpaaw5pZ4qpwTPgmx0nNKux25FOrFYHPLP
         weN5H3X/4pU9Q7nqU3fY8fSU43wjHM3WlLb5uiRsjyoq4XX2gBtoNeXQVY53ErtEF4
         usytm0WAM6EPkbjYeMMlG2POHvg69ddOk1wznfdg=
Date:   Fri, 31 Jul 2020 17:50:43 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        kbuild-all@lists.01.org, linux-pci@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [pci:next 20/21] drivers/pci/controller/pci-aardvark.c:650:25:
 error: 'struct advk_pcie' has no member named 'root_bus_nr'
Message-ID: <20200731225043.GA65001@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202008010603.bXLIn3eT%lkp@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Rob]

70e380250c36 ("PCI: aardvark: Don't touch PCIe registers if no card
connected") from remotes/lorenzo/pci/aardvark added another use of
pcie->root_bus_nr and I didn't catch it when merging Rob's
11e97973607f ("PCI: aardvark: Use pci_is_root_bus() to check if bus is
root bus") from remotes/lorenzo/pci/misc.

But I think I fixed it now.

On Sat, Aug 01, 2020 at 06:25:05AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
> head:   1270e4a51ac22204d1071129caa119d137a0d107
> commit: 62e12ec8a4b2e4d5b8e850741d586cb320a17a96 [20/21] Merge branch 'remotes/lorenzo/pci/misc'
> config: xtensa-allyesconfig (attached as .config)
> compiler: xtensa-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 62e12ec8a4b2e4d5b8e850741d586cb320a17a96
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=xtensa 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from include/linux/kernel.h:11,
>                     from include/linux/delay.h:22,
>                     from drivers/pci/controller/pci-aardvark.c:11:
>    include/linux/scatterlist.h: In function 'sg_set_buf':
>    arch/xtensa/include/asm/page.h:193:9: warning: comparison of unsigned expression >= 0 is always true [-Wtype-limits]
>      193 |  ((pfn) >= ARCH_PFN_OFFSET && ((pfn) - ARCH_PFN_OFFSET) < max_mapnr)
>          |         ^~
>    include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
>       78 | # define unlikely(x) __builtin_expect(!!(x), 0)
>          |                                          ^
>    include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
>      143 |  BUG_ON(!virt_addr_valid(buf));
>          |  ^~~~~~
>    arch/xtensa/include/asm/page.h:201:32: note: in expansion of macro 'pfn_valid'
>      201 | #define virt_addr_valid(kaddr) pfn_valid(__pa(kaddr) >> PAGE_SHIFT)
>          |                                ^~~~~~~~~
>    include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
>      143 |  BUG_ON(!virt_addr_valid(buf));
>          |          ^~~~~~~~~~~~~~~
>    In file included from ./arch/xtensa/include/generated/asm/bug.h:1,
>                     from include/linux/bug.h:5,
>                     from include/linux/thread_info.h:12,
>                     from arch/xtensa/include/asm/current.h:18,
>                     from include/linux/sched.h:12,
>                     from include/linux/ratelimit.h:6,
>                     from include/linux/dev_printk.h:16,
>                     from include/linux/device.h:15,
>                     from include/linux/gpio/driver.h:5,
>                     from include/asm-generic/gpio.h:11,
>                     from include/linux/gpio.h:62,
>                     from drivers/pci/controller/pci-aardvark.c:12:
>    include/linux/dma-mapping.h: In function 'dma_map_resource':
>    arch/xtensa/include/asm/page.h:193:9: warning: comparison of unsigned expression >= 0 is always true [-Wtype-limits]
>      193 |  ((pfn) >= ARCH_PFN_OFFSET && ((pfn) - ARCH_PFN_OFFSET) < max_mapnr)
>          |         ^~
>    include/asm-generic/bug.h:144:27: note: in definition of macro 'WARN_ON_ONCE'
>      144 |  int __ret_warn_once = !!(condition);   \
>          |                           ^~~~~~~~~
>    include/linux/dma-mapping.h:352:19: note: in expansion of macro 'pfn_valid'
>      352 |  if (WARN_ON_ONCE(pfn_valid(PHYS_PFN(phys_addr))))
>          |                   ^~~~~~~~~
>    drivers/pci/controller/pci-aardvark.c: In function 'advk_pcie_valid_device':
> >> drivers/pci/controller/pci-aardvark.c:650:25: error: 'struct advk_pcie' has no member named 'root_bus_nr'
>      650 |  if (bus->number != pcie->root_bus_nr && !advk_pcie_link_up(pcie))
>          |                         ^~
> --
>    In file included from include/linux/build_bug.h:5,
>                     from include/linux/bitfield.h:10,
>                     from drivers/pci/controller/pcie-xilinx-cpm.c:8:
>    include/linux/scatterlist.h: In function 'sg_set_buf':
>    arch/xtensa/include/asm/page.h:193:9: warning: comparison of unsigned expression >= 0 is always true [-Wtype-limits]
>      193 |  ((pfn) >= ARCH_PFN_OFFSET && ((pfn) - ARCH_PFN_OFFSET) < max_mapnr)
>          |         ^~
>    include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
>       78 | # define unlikely(x) __builtin_expect(!!(x), 0)
>          |                                          ^
>    include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
>      143 |  BUG_ON(!virt_addr_valid(buf));
>          |  ^~~~~~
>    arch/xtensa/include/asm/page.h:201:32: note: in expansion of macro 'pfn_valid'
>      201 | #define virt_addr_valid(kaddr) pfn_valid(__pa(kaddr) >> PAGE_SHIFT)
>          |                                ^~~~~~~~~
>    include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
>      143 |  BUG_ON(!virt_addr_valid(buf));
>          |          ^~~~~~~~~~~~~~~
>    In file included from ./arch/xtensa/include/generated/asm/bug.h:1,
>                     from include/linux/bug.h:5,
>                     from include/linux/cpumask.h:14,
>                     from include/linux/interrupt.h:8,
>                     from drivers/pci/controller/pcie-xilinx-cpm.c:9:
>    include/linux/dma-mapping.h: In function 'dma_map_resource':
>    arch/xtensa/include/asm/page.h:193:9: warning: comparison of unsigned expression >= 0 is always true [-Wtype-limits]
>      193 |  ((pfn) >= ARCH_PFN_OFFSET && ((pfn) - ARCH_PFN_OFFSET) < max_mapnr)
>          |         ^~
>    include/asm-generic/bug.h:144:27: note: in definition of macro 'WARN_ON_ONCE'
>      144 |  int __ret_warn_once = !!(condition);   \
>          |                           ^~~~~~~~~
>    include/linux/dma-mapping.h:352:19: note: in expansion of macro 'pfn_valid'
>      352 |  if (WARN_ON_ONCE(pfn_valid(PHYS_PFN(phys_addr))))
>          |                   ^~~~~~~~~
>    drivers/pci/controller/pcie-xilinx-cpm.c: In function 'xilinx_cpm_pcie_probe':
> >> drivers/pci/controller/pcie-xilinx-cpm.c:552:8: error: implicit declaration of function 'pci_parse_request_of_pci_ranges' [-Werror=implicit-function-declaration]
>      552 |  err = pci_parse_request_of_pci_ranges(dev, &bridge->windows,
>          |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    cc1: some warnings being treated as errors
> 
> vim +650 drivers/pci/controller/pci-aardvark.c
> 
> 8a3ebd8de328301 Zachary Zhang    2018-10-18  639  
> 248d4e59616c632 Thomas Petazzoni 2018-04-06  640  static bool advk_pcie_valid_device(struct advk_pcie *pcie, struct pci_bus *bus,
> 248d4e59616c632 Thomas Petazzoni 2018-04-06  641  				  int devfn)
> 248d4e59616c632 Thomas Petazzoni 2018-04-06  642  {
> 11e97973607fab2 Rob Herring      2020-07-21  643  	if (pci_is_root_bus(bus) && PCI_SLOT(devfn) != 0)
> 248d4e59616c632 Thomas Petazzoni 2018-04-06  644  		return false;
> 248d4e59616c632 Thomas Petazzoni 2018-04-06  645  
> 70e380250c3621c Pali Rohár       2020-07-02  646  	/*
> 70e380250c3621c Pali Rohár       2020-07-02  647  	 * If the link goes down after we check for link-up, nothing bad
> 70e380250c3621c Pali Rohár       2020-07-02  648  	 * happens but the config access times out.
> 70e380250c3621c Pali Rohár       2020-07-02  649  	 */
> 70e380250c3621c Pali Rohár       2020-07-02 @650  	if (bus->number != pcie->root_bus_nr && !advk_pcie_link_up(pcie))
> 70e380250c3621c Pali Rohár       2020-07-02  651  		return false;
> 70e380250c3621c Pali Rohár       2020-07-02  652  
> 248d4e59616c632 Thomas Petazzoni 2018-04-06  653  	return true;
> 248d4e59616c632 Thomas Petazzoni 2018-04-06  654  }
> 248d4e59616c632 Thomas Petazzoni 2018-04-06  655  
> 
> :::::: The code at line 650 was first introduced by commit
> :::::: 70e380250c3621c55ff218cbaf2272830d9dbb1d PCI: aardvark: Don't touch PCIe registers if no card connected
> 
> :::::: TO: Pali Rohár <pali@kernel.org>
> :::::: CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


