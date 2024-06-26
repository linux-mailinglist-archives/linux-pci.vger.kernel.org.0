Return-Path: <linux-pci+bounces-9341-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7978F9198B8
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 22:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C8E41C21F2E
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 20:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA002190686;
	Wed, 26 Jun 2024 20:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VH+TO8KE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0126A190679;
	Wed, 26 Jun 2024 20:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719432497; cv=none; b=OAgW+CiECtjUEP2ivWhlWUJ4w89iOSiuqdIm1ANoWoIh5jl3OEDxZjLuD8zr6yFlrl0Fbuic9U6Y+66TfesTHC+IBGODIW+fM0K0QFACRtYMk3+JABAmwGtIHKllYrUm1p5a3x3K5WBVB2MfFya5Hh+cCOt7Rze2F1Bo+1XFQpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719432497; c=relaxed/simple;
	bh=34iE4Kd0i79Uf2wd56kMut6u4yfbhKLiopiMlYYMjV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sGKIIeM/+kDlRaGJy7tgyom8kn9tDUTVPKPL2/VC4+lieoOlewvInGrqunMmDj6yZ7Ca2Z5egRpUjPi+BgiTWaV+5ShwZdVRYVVIdP7H7rvjtsY04XuKZ1kUKCUFGBefQkiUq8GiR8LMG2i9XT5dDtw+hi+hKqSftgRI1dd90Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VH+TO8KE; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719432495; x=1750968495;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=34iE4Kd0i79Uf2wd56kMut6u4yfbhKLiopiMlYYMjV4=;
  b=VH+TO8KEiEv+R+vwIwSZux7s2VqSmJ//dFSNP/YWqd207TmYj1HISgGf
   oinDmEjczzYOkS2hS7g6WuQuoQep5y0uQY1f/j9sb5l27UKM6NbayXi+5
   qQFv03262SSw5rRL08UJj72oqvn+3wPetfnj/lhUVyY6Bsk0nirgItD75
   HSQodH+aWy0NeCEiwhR5FjaF2hdWL3COC4leoSYutoXBOh3x38GcNuu7E
   T0P7cBDASC9KYtCn8d24U1FbwDAzMQZC0j+Wwx1G9VGogPSBmRrBRR53i
   rwR16NspL5qyjan/muzG66apvPR1DfB6zIo9MclUVElB/PxPIXJuiPhFx
   g==;
X-CSE-ConnectionGUID: iPeFRtJyTGSaM48nnMloRw==
X-CSE-MsgGUID: 7esaBPKxS7emstR81l09Hw==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="39035196"
X-IronPort-AV: E=Sophos;i="6.08,267,1712646000"; 
   d="scan'208";a="39035196"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 13:08:14 -0700
X-CSE-ConnectionGUID: cJPws76DSayq6aMCeXO0ww==
X-CSE-MsgGUID: MwXZkQTkSXOZLtyzkLmqsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,267,1712646000"; 
   d="scan'208";a="44535212"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 26 Jun 2024 13:08:11 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sMYw4-000FWd-2C;
	Wed, 26 Jun 2024 20:08:08 +0000
Date: Thu, 27 Jun 2024 04:07:03 +0800
From: kernel test robot <lkp@intel.com>
To: Thippeswamy Havalige <thippesw@amd.com>, bhelgaas@google.com,
	kw@linux.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, lpieralisi@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	michal.simek@amd.com, linux-arm-kernel@lists.infradead.org,
	bharat.kumar.gogada@amd.com,
	Thippeswamy Havalige <thippesw@amd.com>
Subject: Re: [PATCH 2/2] PCI: xilinx-xdma: Add Xilinx QDMA Root Port driver
Message-ID: <202406270344.9nOuTH5k-lkp@intel.com>
References: <20240624104239.132159-3-thippesw@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624104239.132159-3-thippesw@amd.com>

Hi Thippeswamy,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/next]
[also build test WARNING on pci/for-linus linus/master v6.10-rc5 next-20240625]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Thippeswamy-Havalige/dt-bindings-PCI-xilinx-xdma-Add-schemas-for-Xilinx-QDMA-PCIe-Root-Port-Bridge/20240626-052852
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20240624104239.132159-3-thippesw%40amd.com
patch subject: [PATCH 2/2] PCI: xilinx-xdma: Add Xilinx QDMA Root Port driver
config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20240627/202406270344.9nOuTH5k-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240627/202406270344.9nOuTH5k-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406270344.9nOuTH5k-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/pci/controller/pcie-xilinx-dma-pl.c:130: warning: Function parameter or struct member 'cfg_base' not described in 'pl_dma_pcie'
>> drivers/pci/controller/pcie-xilinx-dma-pl.c:130: warning: Function parameter or struct member 'variant' not described in 'pl_dma_pcie'


vim +130 drivers/pci/controller/pcie-xilinx-dma-pl.c

8d786149d78c77 Thippeswamy Havalige 2023-10-03  101  
8d786149d78c77 Thippeswamy Havalige 2023-10-03  102  /**
8d786149d78c77 Thippeswamy Havalige 2023-10-03  103   * struct pl_dma_pcie - PCIe port information
8d786149d78c77 Thippeswamy Havalige 2023-10-03  104   * @dev: Device pointer
8d786149d78c77 Thippeswamy Havalige 2023-10-03  105   * @reg_base: IO Mapped Register Base
8d786149d78c77 Thippeswamy Havalige 2023-10-03  106   * @irq: Interrupt number
8d786149d78c77 Thippeswamy Havalige 2023-10-03  107   * @cfg: Holds mappings of config space window
8d786149d78c77 Thippeswamy Havalige 2023-10-03  108   * @phys_reg_base: Physical address of reg base
8d786149d78c77 Thippeswamy Havalige 2023-10-03  109   * @intx_domain: Legacy IRQ domain pointer
8d786149d78c77 Thippeswamy Havalige 2023-10-03  110   * @pldma_domain: PL DMA IRQ domain pointer
8d786149d78c77 Thippeswamy Havalige 2023-10-03  111   * @resources: Bus Resources
8d786149d78c77 Thippeswamy Havalige 2023-10-03  112   * @msi: MSI information
8d786149d78c77 Thippeswamy Havalige 2023-10-03  113   * @intx_irq: INTx error interrupt number
8d786149d78c77 Thippeswamy Havalige 2023-10-03  114   * @lock: Lock protecting shared register access
8d786149d78c77 Thippeswamy Havalige 2023-10-03  115   */
8d786149d78c77 Thippeswamy Havalige 2023-10-03  116  struct pl_dma_pcie {
8d786149d78c77 Thippeswamy Havalige 2023-10-03  117  	struct device			*dev;
8d786149d78c77 Thippeswamy Havalige 2023-10-03  118  	void __iomem			*reg_base;
21ff31dc400101 Thippeswamy Havalige 2024-06-24  119  	void __iomem			*cfg_base;
8d786149d78c77 Thippeswamy Havalige 2023-10-03  120  	int				irq;
8d786149d78c77 Thippeswamy Havalige 2023-10-03  121  	struct pci_config_window	*cfg;
8d786149d78c77 Thippeswamy Havalige 2023-10-03  122  	phys_addr_t			phys_reg_base;
8d786149d78c77 Thippeswamy Havalige 2023-10-03  123  	struct irq_domain		*intx_domain;
8d786149d78c77 Thippeswamy Havalige 2023-10-03  124  	struct irq_domain		*pldma_domain;
8d786149d78c77 Thippeswamy Havalige 2023-10-03  125  	struct list_head		resources;
8d786149d78c77 Thippeswamy Havalige 2023-10-03  126  	struct xilinx_msi		msi;
8d786149d78c77 Thippeswamy Havalige 2023-10-03  127  	int				intx_irq;
8d786149d78c77 Thippeswamy Havalige 2023-10-03  128  	raw_spinlock_t			lock;
21ff31dc400101 Thippeswamy Havalige 2024-06-24  129  	const struct xilinx_pl_dma_variant   *variant;
8d786149d78c77 Thippeswamy Havalige 2023-10-03 @130  };
8d786149d78c77 Thippeswamy Havalige 2023-10-03  131  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

