Return-Path: <linux-pci+bounces-28380-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0352AC318F
	for <lists+linux-pci@lfdr.de>; Sat, 24 May 2025 23:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93AA216DB17
	for <lists+linux-pci@lfdr.de>; Sat, 24 May 2025 21:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1E327C15B;
	Sat, 24 May 2025 21:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KHBjkDf7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531601E1DE2;
	Sat, 24 May 2025 21:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748123504; cv=none; b=pg+IMCcpfp1oLYWiI+UKtiaRglGLEH6OZPa5lmrdpE0Ckj0JnSYJgoY/UW0VpCGRKFg5iV6WvCkAYYChjNdJx6Xc5swE2ATBgCtzNFUXphuKifrO/w7jCDcYukbBh0nE/WPj498xAuPVUKQYAoQMlpllpz2Gfzq9UTp98gliEe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748123504; c=relaxed/simple;
	bh=g39d9JHRR+ysYFLAUlmlFCphyI2Zuyqr/nbGPJ/VLF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CbEyMIcHPJesrLY4ga52JeyJ8I2ENoAzumBuFERyLYWzE/sNA+VyZkzReXr94lBfREReZKj30gfngOB0Row05yeuD/vrrpKcPT+TAV7zA8pLYbnHQ06nhOEs9rzIZDXpJMls6IsytLmHaIptNp13+bgTbY0t0QEwXYFh2HbVrUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KHBjkDf7; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748123503; x=1779659503;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=g39d9JHRR+ysYFLAUlmlFCphyI2Zuyqr/nbGPJ/VLF8=;
  b=KHBjkDf79Ws9DW211uzG7uGDGDGyivgQSaNC72EGVFRwGQ4IUMoIkLlw
   gftsBBaAdVJdhxyMJ45uZNMxgWyI/GOEX9c+W7rGAj/bSgcqqMQhjGcaU
   fy6PjLApJhOmnUpH7GC1w+kqzzgR/Jfm2W5Vuob5TqlP/4Byxaw3Od55U
   z6pc7rwV5SEntzWHFu++Imbp4K7riQNOB+B1FFa2zXuKxtdhAW9xsu3n9
   KngDSL7qBJQ62xr6/NORJmc4BS2y8esi5QVxocZxjjX4do/x1c04jTbBr
   pqbXIbYPhc5hDe1+qixBbECA4v4D2+6P4iotYGRblSWGiBhDkgnf4MqVQ
   Q==;
X-CSE-ConnectionGUID: tpx4xgFPReKyMHkt5yRKxQ==
X-CSE-MsgGUID: oCaW8bnARAmks9ja5h4HvA==
X-IronPort-AV: E=McAfee;i="6700,10204,11443"; a="61496264"
X-IronPort-AV: E=Sophos;i="6.15,311,1739865600"; 
   d="scan'208";a="61496264"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2025 14:51:42 -0700
X-CSE-ConnectionGUID: fA/mF9yATwi4WsKTQNS57Q==
X-CSE-MsgGUID: m1DNvvEMS/GIG0PRBODSXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,311,1739865600"; 
   d="scan'208";a="178837550"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 24 May 2025 14:51:39 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uIwmG-000RTc-1l;
	Sat, 24 May 2025 21:51:36 +0000
Date: Sun, 25 May 2025 05:51:12 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com
Cc: oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	cassel@kernel.org, wilfred.mallawa@wdc.com,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH 2/2] PCI: Rename host_bridge::reset_slot() to
 host_bridge::reset_root_port()
Message-ID: <202505250525.2csmeURe-lkp@intel.com>
References: <20250524185304.26698-3-manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250524185304.26698-3-manivannan.sadhasivam@linaro.org>

Hi Manivannan,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/next]
[also build test ERROR on next-20250523]
[cannot apply to pci/for-linus linus/master v6.15-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Manivannan-Sadhasivam/PCI-Save-and-restore-root-port-config-space-in-pcibios_reset_secondary_bus/20250525-025535
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20250524185304.26698-3-manivannan.sadhasivam%40linaro.org
patch subject: [PATCH 2/2] PCI: Rename host_bridge::reset_slot() to host_bridge::reset_root_port()
config: csky-randconfig-002-20250525 (https://download.01.org/0day-ci/archive/20250525/202505250525.2csmeURe-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 10.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250525/202505250525.2csmeURe-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505250525.2csmeURe-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/pci/controller/dwc/pcie-dw-rockchip.c: In function 'rockchip_pcie_host_init':
>> drivers/pci/controller/dwc/pcie-dw-rockchip.c:264:32: error: 'rockchip_pcie_rc_reset_slot' undeclared (first use in this function); did you mean 'rockchip_pcie_rc_reset_root_port'?
     264 |  pp->bridge->reset_root_port = rockchip_pcie_rc_reset_slot;
         |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                rockchip_pcie_rc_reset_root_port
   drivers/pci/controller/dwc/pcie-dw-rockchip.c:264:32: note: each undeclared identifier is reported only once for each function it appears in
   At top level:
>> drivers/pci/controller/dwc/pcie-dw-rockchip.c:703:12: warning: 'rockchip_pcie_rc_reset_root_port' defined but not used [-Wunused-function]
     703 | static int rockchip_pcie_rc_reset_root_port(struct pci_host_bridge *bridge,
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +264 drivers/pci/controller/dwc/pcie-dw-rockchip.c

   244	
   245	static int rockchip_pcie_host_init(struct dw_pcie_rp *pp)
   246	{
   247		struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
   248		struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
   249		struct device *dev = rockchip->pci.dev;
   250		int irq, ret;
   251	
   252		irq = of_irq_get_byname(dev->of_node, "legacy");
   253		if (irq < 0)
   254			return irq;
   255	
   256		ret = rockchip_pcie_init_irq_domain(rockchip);
   257		if (ret < 0)
   258			dev_err(dev, "failed to init irq domain\n");
   259	
   260		irq_set_chained_handler_and_data(irq, rockchip_pcie_intx_handler,
   261						 rockchip);
   262	
   263		rockchip_pcie_enable_l0s(pci);
 > 264		pp->bridge->reset_root_port = rockchip_pcie_rc_reset_slot;
   265	
   266		return 0;
   267	}
   268	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

