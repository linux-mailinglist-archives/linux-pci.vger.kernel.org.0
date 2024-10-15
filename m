Return-Path: <linux-pci+bounces-14516-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E5799DEAB
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 08:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1DF4B22B8A
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 06:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA72173332;
	Tue, 15 Oct 2024 06:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O6G1+BOl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EF8173320;
	Tue, 15 Oct 2024 06:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728974860; cv=none; b=uZZqwR3l6PStoenx9pk3E8iBKUZScCltWjPNUG+VPgWEZndzht76uEYKbY0xPuBF4OLCJipk4ipoAuf6xStRFmqd6+ZB0wlVI9LPbp2XHu7hEHQM8jUjUNGS7i9rUpg8OaH1GxSOSCnh0U23l4YVCjiwMHeuUCUPdbABJyMwkEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728974860; c=relaxed/simple;
	bh=QnmdqlUzl5mD6BYj4MP1FHjqNwxAYNNrC194BjJdZcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cz2J2RVYPfk6cDoE/0niBjOu8QnP6oNYn3dwJUgJzU/8VS9TQVRllx+njoHK1m2QTh6h4xBUFQqqDEca9jMxi96M2/DWG5pRhsGzGS7R06s56MfGQldhQTq+ufcNUj4MbfgPAZ9BWxTgL/qddbUnt5irwIz4Ntu/eOz3mMqnf3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O6G1+BOl; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728974858; x=1760510858;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QnmdqlUzl5mD6BYj4MP1FHjqNwxAYNNrC194BjJdZcU=;
  b=O6G1+BOlA3yOveH1peytO9x6nD/73ZMgoRTSEcBOqmTCihmq0RrelIo/
   KFq9TRLkXXyUd1PxC/N3ySvZmc3PX/NxKoA1pSAzvTqb0HZSmkfCCUFh8
   7mVBrAAFRgmjYd/4wF6AvLQws+MYmEh5JxospjJI82WYSgy1wXASTz2Rd
   L19TElpuxHgQdvc/JQiq0q0JrFVWIiLTYb0ydKllWKVkJA87ehzMFUEhJ
   arZ6g1FwIP/ziHCphKM4HTlJ6ZEBMGd6EwmuvIcepEG50KEuVSSthceen
   1fbVCmSZ4EWLbjtsxtaab8bypIrvPJRsK3fB0uC2QKgLwSgA47FkkQ5uD
   g==;
X-CSE-ConnectionGUID: Lgh4rXHrRO+Lhi0d92dQgQ==
X-CSE-MsgGUID: i6BfCY3SS4+8bdVUYWUF/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="45821685"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="45821685"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 23:47:38 -0700
X-CSE-ConnectionGUID: rJhn4m6RR3621sODBiR/WQ==
X-CSE-MsgGUID: 9XIi+BPDSnaO5K1CSGw6XQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,204,1725346800"; 
   d="scan'208";a="82424741"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 14 Oct 2024 23:47:34 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t0bL9-000HiB-2b;
	Tue, 15 Oct 2024 06:47:31 +0000
Date: Tue, 15 Oct 2024 14:46:39 +0800
From: kernel test robot <lkp@intel.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-rockchip@lists.infradead.org,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v4 12/12] PCI: rockchip-ep: Handle PERST# signal in
 endpoint mode
Message-ID: <202410151206.MIdxs469-lkp@intel.com>
References: <20241011121408.89890-13-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011121408.89890-13-dlemoal@kernel.org>

Hi Damien,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/next]
[also build test ERROR on pci/for-linus mani-mhi/mhi-next linus/master v6.12-rc3 next-20241014]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Damien-Le-Moal/PCI-rockchip-ep-Fix-address-translation-unit-programming/20241011-201512
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20241011121408.89890-13-dlemoal%40kernel.org
patch subject: [PATCH v4 12/12] PCI: rockchip-ep: Handle PERST# signal in endpoint mode
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20241015/202410151206.MIdxs469-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241015/202410151206.MIdxs469-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410151206.MIdxs469-lkp@intel.com/

All errors (new ones prefixed by >>):

         |                            ^~
   drivers/pci/controller/pcie-rockchip-ep.c:255:44: error: invalid use of undefined type 'struct pci_epc_map'
     255 |         map->map_ofst = map->pci_addr - map->map_pci_addr;
         |                                            ^~
   drivers/pci/controller/pcie-rockchip-ep.c:257:16: error: invalid use of undefined type 'struct pci_epc_map'
     257 |         if (map->map_ofst + map->pci_size > SZ_1M)
         |                ^~
   drivers/pci/controller/pcie-rockchip-ep.c:257:32: error: invalid use of undefined type 'struct pci_epc_map'
     257 |         if (map->map_ofst + map->pci_size > SZ_1M)
         |                                ^~
   drivers/pci/controller/pcie-rockchip-ep.c:258:20: error: invalid use of undefined type 'struct pci_epc_map'
     258 |                 map->pci_size = SZ_1M - map->map_ofst;
         |                    ^~
   drivers/pci/controller/pcie-rockchip-ep.c:258:44: error: invalid use of undefined type 'struct pci_epc_map'
     258 |                 map->pci_size = SZ_1M - map->map_ofst;
         |                                            ^~
   drivers/pci/controller/pcie-rockchip-ep.c:260:12: error: invalid use of undefined type 'struct pci_epc_map'
     260 |         map->map_size = ALIGN(map->map_ofst + map->pci_size,
         |            ^~
   In file included from include/vdso/const.h:5,
                    from include/linux/const.h:4,
                    from include/uapi/linux/kernel.h:6,
                    from include/linux/cache.h:5,
                    from include/linux/time.h:5,
                    from include/linux/stat.h:19,
                    from include/linux/configfs.h:22,
                    from drivers/pci/controller/pcie-rockchip-ep.c:11:
   drivers/pci/controller/pcie-rockchip-ep.c:260:34: error: invalid use of undefined type 'struct pci_epc_map'
     260 |         map->map_size = ALIGN(map->map_ofst + map->pci_size,
         |                                  ^~
   include/uapi/linux/const.h:49:44: note: in definition of macro '__ALIGN_KERNEL_MASK'
      49 | #define __ALIGN_KERNEL_MASK(x, mask)    (((x) + (mask)) & ~(mask))
         |                                            ^
   include/linux/align.h:8:33: note: in expansion of macro '__ALIGN_KERNEL'
       8 | #define ALIGN(x, a)             __ALIGN_KERNEL((x), (a))
         |                                 ^~~~~~~~~~~~~~
   drivers/pci/controller/pcie-rockchip-ep.c:260:25: note: in expansion of macro 'ALIGN'
     260 |         map->map_size = ALIGN(map->map_ofst + map->pci_size,
         |                         ^~~~~
   drivers/pci/controller/pcie-rockchip-ep.c:260:50: error: invalid use of undefined type 'struct pci_epc_map'
     260 |         map->map_size = ALIGN(map->map_ofst + map->pci_size,
         |                                                  ^~
   include/uapi/linux/const.h:49:44: note: in definition of macro '__ALIGN_KERNEL_MASK'
      49 | #define __ALIGN_KERNEL_MASK(x, mask)    (((x) + (mask)) & ~(mask))
         |                                            ^
   include/linux/align.h:8:33: note: in expansion of macro '__ALIGN_KERNEL'
       8 | #define ALIGN(x, a)             __ALIGN_KERNEL((x), (a))
         |                                 ^~~~~~~~~~~~~~
   drivers/pci/controller/pcie-rockchip-ep.c:260:25: note: in expansion of macro 'ALIGN'
     260 |         map->map_size = ALIGN(map->map_ofst + map->pci_size,
         |                         ^~~~~
   drivers/pci/controller/pcie-rockchip-ep.c:260:34: error: invalid use of undefined type 'struct pci_epc_map'
     260 |         map->map_size = ALIGN(map->map_ofst + map->pci_size,
         |                                  ^~
   include/uapi/linux/const.h:49:50: note: in definition of macro '__ALIGN_KERNEL_MASK'
      49 | #define __ALIGN_KERNEL_MASK(x, mask)    (((x) + (mask)) & ~(mask))
         |                                                  ^~~~
   include/linux/align.h:8:33: note: in expansion of macro '__ALIGN_KERNEL'
       8 | #define ALIGN(x, a)             __ALIGN_KERNEL((x), (a))
         |                                 ^~~~~~~~~~~~~~
   drivers/pci/controller/pcie-rockchip-ep.c:260:25: note: in expansion of macro 'ALIGN'
     260 |         map->map_size = ALIGN(map->map_ofst + map->pci_size,
         |                         ^~~~~
   drivers/pci/controller/pcie-rockchip-ep.c:260:50: error: invalid use of undefined type 'struct pci_epc_map'
     260 |         map->map_size = ALIGN(map->map_ofst + map->pci_size,
         |                                                  ^~
   include/uapi/linux/const.h:49:50: note: in definition of macro '__ALIGN_KERNEL_MASK'
      49 | #define __ALIGN_KERNEL_MASK(x, mask)    (((x) + (mask)) & ~(mask))
         |                                                  ^~~~
   include/linux/align.h:8:33: note: in expansion of macro '__ALIGN_KERNEL'
       8 | #define ALIGN(x, a)             __ALIGN_KERNEL((x), (a))
         |                                 ^~~~~~~~~~~~~~
   drivers/pci/controller/pcie-rockchip-ep.c:260:25: note: in expansion of macro 'ALIGN'
     260 |         map->map_size = ALIGN(map->map_ofst + map->pci_size,
         |                         ^~~~~
   drivers/pci/controller/pcie-rockchip-ep.c:260:34: error: invalid use of undefined type 'struct pci_epc_map'
     260 |         map->map_size = ALIGN(map->map_ofst + map->pci_size,
         |                                  ^~
   include/uapi/linux/const.h:49:61: note: in definition of macro '__ALIGN_KERNEL_MASK'
      49 | #define __ALIGN_KERNEL_MASK(x, mask)    (((x) + (mask)) & ~(mask))
         |                                                             ^~~~
   include/linux/align.h:8:33: note: in expansion of macro '__ALIGN_KERNEL'
       8 | #define ALIGN(x, a)             __ALIGN_KERNEL((x), (a))
         |                                 ^~~~~~~~~~~~~~
   drivers/pci/controller/pcie-rockchip-ep.c:260:25: note: in expansion of macro 'ALIGN'
     260 |         map->map_size = ALIGN(map->map_ofst + map->pci_size,
         |                         ^~~~~
   drivers/pci/controller/pcie-rockchip-ep.c:260:50: error: invalid use of undefined type 'struct pci_epc_map'
     260 |         map->map_size = ALIGN(map->map_ofst + map->pci_size,
         |                                                  ^~
   include/uapi/linux/const.h:49:61: note: in definition of macro '__ALIGN_KERNEL_MASK'
      49 | #define __ALIGN_KERNEL_MASK(x, mask)    (((x) + (mask)) & ~(mask))
         |                                                             ^~~~
   include/linux/align.h:8:33: note: in expansion of macro '__ALIGN_KERNEL'
       8 | #define ALIGN(x, a)             __ALIGN_KERNEL((x), (a))
         |                                 ^~~~~~~~~~~~~~
   drivers/pci/controller/pcie-rockchip-ep.c:260:25: note: in expansion of macro 'ALIGN'
     260 |         map->map_size = ALIGN(map->map_ofst + map->pci_size,
         |                         ^~~~~
   drivers/pci/controller/pcie-rockchip-ep.c: In function 'rockchip_pcie_ep_perst_irq_thread':
>> drivers/pci/controller/pcie-rockchip-ep.c:631:9: error: implicit declaration of function 'irq_set_irq_type'; did you mean 'irq_set_irq_wake'? [-Werror=implicit-function-declaration]
     631 |         irq_set_irq_type(ep->perst_irq,
         |         ^~~~~~~~~~~~~~~~
         |         irq_set_irq_wake
   drivers/pci/controller/pcie-rockchip-ep.c: In function 'rockchip_pcie_ep_setup_irq':
>> drivers/pci/controller/pcie-rockchip-ep.c:660:9: error: implicit declaration of function 'irq_set_status_flags' [-Werror=implicit-function-declaration]
     660 |         irq_set_status_flags(ep->perst_irq, IRQ_NOAUTOEN);
         |         ^~~~~~~~~~~~~~~~~~~~
>> drivers/pci/controller/pcie-rockchip-ep.c:660:45: error: 'IRQ_NOAUTOEN' undeclared (first use in this function); did you mean 'IRQF_NO_AUTOEN'?
     660 |         irq_set_status_flags(ep->perst_irq, IRQ_NOAUTOEN);
         |                                             ^~~~~~~~~~~~
         |                                             IRQF_NO_AUTOEN
   drivers/pci/controller/pcie-rockchip-ep.c:660:45: note: each undeclared identifier is reported only once for each function it appears in
   drivers/pci/controller/pcie-rockchip-ep.c: At top level:
   drivers/pci/controller/pcie-rockchip-ep.c:690:10: error: 'const struct pci_epc_ops' has no member named 'get_mem_map'
     690 |         .get_mem_map    = rockchip_pcie_ep_get_mem_map,
         |          ^~~~~~~~~~~
   drivers/pci/controller/pcie-rockchip-ep.c:690:27: error: initialization of 'int (*)(struct pci_epc *, u8,  u8,  phys_addr_t,  u64,  size_t)' {aka 'int (*)(struct pci_epc *, unsigned char,  unsigned char,  long long unsigned int,  long long unsigned int,  unsigned int)'} from incompatible pointer type 'int (*)(struct pci_epc *, u8,  u8,  struct pci_epc_map *)' {aka 'int (*)(struct pci_epc *, unsigned char,  unsigned char,  struct pci_epc_map *)'} [-Werror=incompatible-pointer-types]
     690 |         .get_mem_map    = rockchip_pcie_ep_get_mem_map,
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pci/controller/pcie-rockchip-ep.c:690:27: note: (near initialization for 'rockchip_pcie_epc_ops.map_addr')
   drivers/pci/controller/pcie-rockchip-ep.c:691:27: warning: initialized field overwritten [-Woverride-init]
     691 |         .map_addr       = rockchip_pcie_ep_map_addr,
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pci/controller/pcie-rockchip-ep.c:691:27: note: (near initialization for 'rockchip_pcie_epc_ops.map_addr')
   cc1: some warnings being treated as errors

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for MODVERSIONS
   Depends on [n]: MODULES [=y] && !COMPILE_TEST [=y]
   Selected by [y]:
   - RANDSTRUCT_FULL [=y] && (CC_HAS_RANDSTRUCT [=n] || GCC_PLUGINS [=y]) && MODULES [=y]
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [m]:
   - RESOURCE_KUNIT_TEST [=m] && RUNTIME_TESTING_MENU [=y] && KUNIT [=m]


vim +631 drivers/pci/controller/pcie-rockchip-ep.c

   618	
   619	static irqreturn_t rockchip_pcie_ep_perst_irq_thread(int irq, void *data)
   620	{
   621		struct pci_epc *epc = data;
   622		struct rockchip_pcie_ep *ep = epc_get_drvdata(epc);
   623		struct rockchip_pcie *rockchip = &ep->rockchip;
   624		u32 perst = gpiod_get_value(rockchip->perst_gpio);
   625	
   626		if (perst)
   627			rockchip_pcie_ep_perst_assert(ep);
   628		else
   629			rockchip_pcie_ep_perst_deassert(ep);
   630	
 > 631		irq_set_irq_type(ep->perst_irq,
   632				 (perst ? IRQF_TRIGGER_HIGH : IRQF_TRIGGER_LOW));
   633	
   634		return IRQ_HANDLED;
   635	}
   636	
   637	static int rockchip_pcie_ep_setup_irq(struct pci_epc *epc)
   638	{
   639		struct rockchip_pcie_ep *ep = epc_get_drvdata(epc);
   640		struct rockchip_pcie *rockchip = &ep->rockchip;
   641		struct device *dev = rockchip->dev;
   642		int ret;
   643	
   644		if (!rockchip->perst_gpio)
   645			return 0;
   646	
   647		/* PCIe reset interrupt */
   648		ep->perst_irq = gpiod_to_irq(rockchip->perst_gpio);
   649		if (ep->perst_irq < 0) {
   650			dev_err(dev, "No corresponding IRQ for PERST GPIO\n");
   651			return ep->perst_irq;
   652		}
   653	
   654		/*
   655		 * The perst_gpio is active low, so when it is inactive on start, it
   656		 * is high and will trigger the perst_irq handler. So treat this initial
   657		 * IRQ as a dummy one by faking the host asserting #PERST.
   658		 */
   659		ep->perst_asserted = true;
 > 660		irq_set_status_flags(ep->perst_irq, IRQ_NOAUTOEN);
   661		ret = devm_request_threaded_irq(dev, ep->perst_irq, NULL,
   662						rockchip_pcie_ep_perst_irq_thread,
   663						IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
   664						"pcie-ep-perst", epc);
   665		if (ret) {
   666			dev_err(dev, "Request PERST GPIO IRQ failed %d\n", ret);
   667			return ret;
   668		}
   669	
   670		return 0;
   671	}
   672	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

