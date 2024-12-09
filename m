Return-Path: <linux-pci+bounces-17898-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 492C89E8A60
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 05:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39B48161E0A
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 04:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18671940B2;
	Mon,  9 Dec 2024 04:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fkhoqYdM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429A7189F5C;
	Mon,  9 Dec 2024 04:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733718929; cv=none; b=F3R1b0gRaVjZ0uwjoAWobdxdMFsgrsoCvYLgplRuOeM+ZCQMPYpsm3GDnSKDCeu6r+/ypkfhcB4I5rOKqVXfE1QlDWK6QJS9A8VDdTGgJBmCFmxUhK6ATMD9yWKODhmoDnsDO/Tew9RwXbbdHd6W9b2ym0+Ptl1T8BOnoFSrrNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733718929; c=relaxed/simple;
	bh=/byX0QN7l6evzZM3VWd51MOOZPsopsId3NhdI4oXh+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ESVVcYNliWEnVXUHR6gBrDgAYzN+PI2O9N7btVzUjc8Pu/q7xM10JMfqzV2ciFw41SU7nqcrQKtcqzykWgkexzQNd7xFlsvmYW9XGa27Ap8LChbBYVL1H7Ozw+j8l3qAwrkVgu5LMr9ssAr/62pa58ebbzF/Z4XR4qWRGNU8Y+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fkhoqYdM; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733718927; x=1765254927;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/byX0QN7l6evzZM3VWd51MOOZPsopsId3NhdI4oXh+w=;
  b=fkhoqYdMyJdLs1+n3kSJUn1pGUmPgysJjutToC7cPJRatsYDKfZwvcE2
   DKD+oK66C3JUM9VnmIbXcL6KJHF2/dOZdpUxAE4wtq2/2Lk4ytxzAu2KB
   q3NcnN22dQOVHiDJNruXQAWE3BF8HHkGU1GLtt2XyiaCpXz9K8ApS7tzq
   xxLxBu5uRK15GdxyMKlFZBQvRhGvK+g58HdJnFdhf/YuS09kzGaXwoUIr
   x7CBJ92E5UuhQeZ/tonEbm5J4MR6cMTOdFFAHwvTebVJXdI80cPC3OIwi
   lb4KuFBKgYZSncuS2vJsljqyeI5207oqxBWubpNnbWWWz1eYn+66xVg9t
   w==;
X-CSE-ConnectionGUID: yBUoyfc9ScSVT0ed+0WBQw==
X-CSE-MsgGUID: +hbTP6rxQ1alJ1qcf21Sqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11280"; a="34237103"
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="34237103"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2024 20:35:26 -0800
X-CSE-ConnectionGUID: +CUXQ3szQaSyFv/p6es35w==
X-CSE-MsgGUID: /NYIfnVgRFyE8+IfO0CAqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="125844583"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 08 Dec 2024 20:35:22 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tKVUO-0003sb-08;
	Mon, 09 Dec 2024 04:35:20 +0000
Date: Mon, 9 Dec 2024 12:34:44 +0800
From: kernel test robot <lkp@intel.com>
To: Christian Bruel <christian.bruel@foss.st.com>, lpieralisi@kernel.org,
	kw@linux.com, manivannan.sadhasivam@linaro.org, robh@kernel.org,
	bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	p.zabel@pengutronix.de, cassel@kernel.org,
	quic_schintav@quicinc.com, fabrice.gasnier@foss.st.com
Cc: oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Christian Bruel <christian.bruel@foss.st.com>
Subject: Re: [PATCH v2 2/5] PCI: stm32: Add PCIe host support for STM32MP25
Message-ID: <202412080849.1SXhxzpi-lkp@intel.com>
References: <20241126155119.1574564-3-christian.bruel@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241126155119.1574564-3-christian.bruel@foss.st.com>

Hi Christian,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/next]
[also build test ERROR on pci/for-linus linus/master v6.13-rc1 next-20241206]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Bruel/dt-bindings-PCI-Add-STM32MP25-PCIe-root-complex-bindings/20241128-101958
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20241126155119.1574564-3-christian.bruel%40foss.st.com
patch subject: [PATCH v2 2/5] PCI: stm32: Add PCIe host support for STM32MP25
config: openrisc-randconfig-r072-20241208 (https://download.01.org/0day-ci/archive/20241208/202412080849.1SXhxzpi-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241208/202412080849.1SXhxzpi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412080849.1SXhxzpi-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/pci/controller/dwc/pcie-stm32.c: In function 'stm32_pcie_suspend_noirq':
>> drivers/pci/controller/dwc/pcie-stm32.c:101:16: error: implicit declaration of function 'pinctrl_pm_select_sleep_state' [-Wimplicit-function-declaration]
     101 |         return pinctrl_pm_select_sleep_state(dev);
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pci/controller/dwc/pcie-stm32.c: In function 'stm32_pcie_resume_noirq':
>> drivers/pci/controller/dwc/pcie-stm32.c:114:24: error: 'struct device' has no member named 'pins'
     114 |         if (!IS_ERR(dev->pins->init_state))
         |                        ^~
>> drivers/pci/controller/dwc/pcie-stm32.c:115:23: error: implicit declaration of function 'pinctrl_select_state' [-Wimplicit-function-declaration]
     115 |                 ret = pinctrl_select_state(dev->pins->p, dev->pins->init_state);
         |                       ^~~~~~~~~~~~~~~~~~~~
   drivers/pci/controller/dwc/pcie-stm32.c:115:47: error: 'struct device' has no member named 'pins'
     115 |                 ret = pinctrl_select_state(dev->pins->p, dev->pins->init_state);
         |                                               ^~
   drivers/pci/controller/dwc/pcie-stm32.c:115:61: error: 'struct device' has no member named 'pins'
     115 |                 ret = pinctrl_select_state(dev->pins->p, dev->pins->init_state);
         |                                                             ^~
>> drivers/pci/controller/dwc/pcie-stm32.c:117:23: error: implicit declaration of function 'pinctrl_pm_select_default_state' [-Wimplicit-function-declaration]
     117 |                 ret = pinctrl_pm_select_default_state(dev);
         |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pci/controller/dwc/pcie-stm32.c: In function 'stm32_pcie_probe':
   drivers/pci/controller/dwc/pcie-stm32.c:243:29: warning: unused variable 'np' [-Wunused-variable]
     243 |         struct device_node *np = pdev->dev.of_node;
         |                             ^~


vim +/pinctrl_pm_select_sleep_state +101 drivers/pci/controller/dwc/pcie-stm32.c

    88	
    89	static int stm32_pcie_suspend_noirq(struct device *dev)
    90	{
    91		struct stm32_pcie *stm32_pcie = dev_get_drvdata(dev);
    92	
    93		stm32_pcie->link_is_up = dw_pcie_link_up(stm32_pcie->pci);
    94	
    95		stm32_pcie_stop_link(stm32_pcie->pci);
    96		clk_disable_unprepare(stm32_pcie->clk);
    97	
    98		if (!device_may_wakeup(dev) && !device_wakeup_path(dev))
    99			phy_exit(stm32_pcie->phy);
   100	
 > 101		return pinctrl_pm_select_sleep_state(dev);
   102	}
   103	
   104	static int stm32_pcie_resume_noirq(struct device *dev)
   105	{
   106		struct stm32_pcie *stm32_pcie = dev_get_drvdata(dev);
   107		struct dw_pcie *pci = stm32_pcie->pci;
   108		struct dw_pcie_rp *pp = &pci->pp;
   109		int ret;
   110	
   111		/* init_state must be called first to force clk_req# gpio when no
   112		 * device is plugged.
   113		 */
 > 114		if (!IS_ERR(dev->pins->init_state))
 > 115			ret = pinctrl_select_state(dev->pins->p, dev->pins->init_state);
   116		else
 > 117			ret = pinctrl_pm_select_default_state(dev);
   118	
   119		if (ret) {
   120			dev_err(dev, "Failed to activate pinctrl pm state: %d\n", ret);
   121			return ret;
   122		}
   123	
   124		if (!device_may_wakeup(dev) && !device_wakeup_path(dev)) {
   125			ret = phy_init(stm32_pcie->phy);
   126			if (ret) {
   127				pinctrl_pm_select_default_state(dev);
   128				return ret;
   129			}
   130		}
   131	
   132		ret = clk_prepare_enable(stm32_pcie->clk);
   133		if (ret)
   134			goto clk_err;
   135	
   136		ret = dw_pcie_setup_rc(pp);
   137		if (ret)
   138			goto pcie_err;
   139	
   140		if (stm32_pcie->link_is_up) {
   141			ret = stm32_pcie_start_link(stm32_pcie->pci);
   142			if (ret)
   143				goto pcie_err;
   144	
   145			/* Ignore errors, the link may come up later */
   146			dw_pcie_wait_for_link(stm32_pcie->pci);
   147		}
   148	
   149		pinctrl_pm_select_default_state(dev);
   150	
   151		return 0;
   152	
   153	pcie_err:
   154		dw_pcie_host_deinit(pp);
   155		clk_disable_unprepare(stm32_pcie->clk);
   156	clk_err:
   157		phy_exit(stm32_pcie->phy);
   158		pinctrl_pm_select_default_state(dev);
   159	
   160		return ret;
   161	}
   162	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

