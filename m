Return-Path: <linux-pci+bounces-30669-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32987AE93AB
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 03:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 401704E22A6
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 01:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFFF019F420;
	Thu, 26 Jun 2025 01:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fb/tT3kq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E5713C8FF
	for <linux-pci@vger.kernel.org>; Thu, 26 Jun 2025 01:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750900914; cv=none; b=Wa9bLgImykly0LsOb7FF6S8fwyimym7uZ5U5NlwYyCnEIM/vh4cUp9fv5JAfVaR1TQtdyOgsjnZcOcqw6OnHdidg0HMCuQa+dLKX1sZH51xUQffdWrEHq2daSgtWfwLxSVXAJZjqp1kC6mzYvu3PY1Z1ImEngoASQNZinENED7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750900914; c=relaxed/simple;
	bh=3W/+dbioKYYza25TtEa22N8mx4aHaa+CNzY6armpsms=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cd02DTvjTG+GsqOOEoZ7pYNmlPxH1QPD7o4yI69McaE6R9jWP2NUskh0kmbKpHT2VrZTWbEqANRwPm/r9vm2uWd4V82FPRmUyWAtamH1LraAXXVT7Xq/pMZte+fz5NuVGi/M+l0wM6LYWaUb3ChvNE6ItxodsIUohdgy4ao9M+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fb/tT3kq; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750900913; x=1782436913;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3W/+dbioKYYza25TtEa22N8mx4aHaa+CNzY6armpsms=;
  b=fb/tT3kqw266wU9SzsLWZWxshLez+O3cv4CjwMfqdSyB4nGQI2FgxeHe
   zJGVbP+cr5NjUA2mKuvb2o+tAnWt95xqVrMGZ2W6wxIHMlMr63dnFDFT6
   +71qtbsPpZtdpNV1aumRZN6ZiE6ReW11UZfKCruLWv4mKwgEFTQkLm4/n
   sQpMH445xeOPcxbqx4/sYe+/GWN4hzyny652EIWllOZsuxJVOWx8BGyIC
   pD79je3n979mnCdqbAsPuB1mNktYBpaYWo33XtyRol+AvU56l4EF7vka5
   tVsfTU6wC7Um5ekSDMjiyKcS4F02Q5NTaNm4cp/1KHkgGlL3wf/Y2rLc2
   A==;
X-CSE-ConnectionGUID: 0xD26X36Tgy3omp/R0onyQ==
X-CSE-MsgGUID: 1rwD0edNQeeSSC8m+vyUXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="53059347"
X-IronPort-AV: E=Sophos;i="6.16,266,1744095600"; 
   d="scan'208";a="53059347"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 18:21:53 -0700
X-CSE-ConnectionGUID: Bc+g3gAXSYSFmZ1KHsc0fg==
X-CSE-MsgGUID: J3MWMROxT7225Z1N6GQSzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,266,1744095600"; 
   d="scan'208";a="151794145"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 25 Jun 2025 18:21:51 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uUbJF-000Tao-0Y;
	Thu, 26 Jun 2025 01:21:49 +0000
Date: Thu, 26 Jun 2025 09:20:58 +0800
From: kernel test robot <lkp@intel.com>
To: Christian Bruel <christian.bruel@foss.st.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-pci@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>
Subject: [pci:controller/dwc-stm32 2/5]
 drivers/pci/controller/dwc/pcie-stm32.c:96:23: error: incomplete definition
 of type 'struct dev_pin_info'
Message-ID: <202506260920.bmQ9hQ9s-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc-stm32
head:   5a972a01e24b278f7302a834c6eaee5bdac12843
commit: 633f42f48af5a55abbdb92b036f23b428c5fb59b [2/5] PCI: stm32: Add PCIe host support for STM32MP25
config: um-allmodconfig (https://download.01.org/0day-ci/archive/20250626/202506260920.bmQ9hQ9s-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250626/202506260920.bmQ9hQ9s-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506260920.bmQ9hQ9s-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/pci/controller/dwc/pcie-stm32.c:12:
   In file included from include/linux/phy/phy.h:17:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:27:
   In file included from include/linux/kernel_stat.h:8:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:12:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:1175:55: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
    1175 |         return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
         |                                                   ~~~~~~~~~~ ^
>> drivers/pci/controller/dwc/pcie-stm32.c:96:23: error: incomplete definition of type 'struct dev_pin_info'
      96 |         if (!IS_ERR(dev->pins->init_state))
         |                     ~~~~~~~~~^
   include/linux/device.h:46:8: note: forward declaration of 'struct dev_pin_info'
      46 | struct dev_pin_info;
         |        ^
   drivers/pci/controller/dwc/pcie-stm32.c:97:39: error: incomplete definition of type 'struct dev_pin_info'
      97 |                 ret = pinctrl_select_state(dev->pins->p, dev->pins->init_state);
         |                                            ~~~~~~~~~^
   include/linux/device.h:46:8: note: forward declaration of 'struct dev_pin_info'
      46 | struct dev_pin_info;
         |        ^
   drivers/pci/controller/dwc/pcie-stm32.c:97:53: error: incomplete definition of type 'struct dev_pin_info'
      97 |                 ret = pinctrl_select_state(dev->pins->p, dev->pins->init_state);
         |                                                          ~~~~~~~~~^
   include/linux/device.h:46:8: note: forward declaration of 'struct dev_pin_info'
      46 | struct dev_pin_info;
         |        ^
   1 warning and 3 errors generated.


vim +96 drivers/pci/controller/dwc/pcie-stm32.c

    85	
    86	static int stm32_pcie_resume_noirq(struct device *dev)
    87	{
    88		struct stm32_pcie *stm32_pcie = dev_get_drvdata(dev);
    89		int ret;
    90	
    91		/*
    92		 * The core clock is gated with CLKREQ# from the COMBOPHY REFCLK,
    93		 * thus if no device is present, must force it low with an init pinmux
    94		 * to be able to access the DBI registers.
    95		 */
  > 96		if (!IS_ERR(dev->pins->init_state))
    97			ret = pinctrl_select_state(dev->pins->p, dev->pins->init_state);
    98		else
    99			ret = pinctrl_pm_select_default_state(dev);
   100	
   101		if (ret) {
   102			dev_err(dev, "Failed to activate pinctrl pm state: %d\n", ret);
   103			return ret;
   104		}
   105	
   106		if (!device_wakeup_path(dev)) {
   107			ret = phy_init(stm32_pcie->phy);
   108			if (ret) {
   109				pinctrl_pm_select_default_state(dev);
   110				return ret;
   111			}
   112		}
   113	
   114		ret = clk_prepare_enable(stm32_pcie->clk);
   115		if (ret)
   116			goto err_phy_exit;
   117	
   118		stm32_pcie_deassert_perst(stm32_pcie);
   119	
   120		ret = dw_pcie_resume_noirq(&stm32_pcie->pci);
   121		if (ret)
   122			goto err_disable_clk;
   123	
   124		pinctrl_pm_select_default_state(dev);
   125	
   126		return 0;
   127	
   128	err_disable_clk:
   129		stm32_pcie_assert_perst(stm32_pcie);
   130		clk_disable_unprepare(stm32_pcie->clk);
   131	
   132	err_phy_exit:
   133		phy_exit(stm32_pcie->phy);
   134		pinctrl_pm_select_default_state(dev);
   135	
   136		return ret;
   137	}
   138	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

