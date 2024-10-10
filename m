Return-Path: <linux-pci+bounces-14122-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FF3997AA7
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 04:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E96D282CA0
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 02:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3A517B427;
	Thu, 10 Oct 2024 02:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RKGqOsVu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706AC16F0E8;
	Thu, 10 Oct 2024 02:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728528227; cv=none; b=b5YS8IevTTXzmKGknBNwzezkcHfWJ1qL1ELQGzjYEYVegKT++KrXjUezQ6yIcBbSKb5SxGz7tPyFgyHo3b9tvHlZV+CeK/YfvJ15QLbEKN/2qMecOWRhEr6UgVQbzd0kizI80qAR1jw5982Z6jhf9voCJRiiqydDHe7fVLRnzWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728528227; c=relaxed/simple;
	bh=Nq3W6E/fBAbdamPvD166i+gTBRozQvXbP8fpNhuQSn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=thevVik7Cmj55/yooW9ozjZx2CmtKFRz4qVpmJtiji5i1sIFs+KIMw0garcPGhY+VXRzf2xq8jMvVlPhUNDfWmrVk0dy29lw6jyb/OxsAQ1Gz66hU+aNZmS8KB6kX4oTFApPd6IVnCEw0TzjoNincjEIfu1eA0fiupQfPg0jAkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RKGqOsVu; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728528226; x=1760064226;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Nq3W6E/fBAbdamPvD166i+gTBRozQvXbP8fpNhuQSn0=;
  b=RKGqOsVuuYRj/HIlUjsEsiEYjTIPni9L36pPqFIx8FdBM1SYykKhbYDk
   4098OCoRq6B1uUxqJo2TE64H12hSzOWe/J1Q9T0MHhO/5nLmXlpIDtrmF
   e5qXZv10wIWpuTazwx8aLm6bFBkXhhkBpx75YLYbiR36fUPi4+UTgTVJH
   BW4DB0pdbjV8+PwDiU7WTsZtSQLskTf2aLTp4EiJaFrQR6IH4crsA3wDp
   VEcez6n/7hL3UHisVgVpahSz7EEF0tC7oq3iivbc4k/JVGVHLBRw8WHg3
   eDxS5s7lvuE8ywMU+9CZr1+L1i+y5Ux35589alB/wM8wGBEdBx8f5ZK2M
   A==;
X-CSE-ConnectionGUID: PiSYm7YJTPOCLYtEBm2PJg==
X-CSE-MsgGUID: TBdhWp90TkOd9LfCLfKBTw==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="27995954"
X-IronPort-AV: E=Sophos;i="6.11,191,1725346800"; 
   d="scan'208";a="27995954"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 19:43:45 -0700
X-CSE-ConnectionGUID: V2RqSgWmRFukWWGdHiONpg==
X-CSE-MsgGUID: 4gj8LtXVTwKdcJfOFYktLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,191,1725346800"; 
   d="scan'208";a="76380482"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 09 Oct 2024 19:43:40 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1syj9N-000A4k-2w;
	Thu, 10 Oct 2024 02:43:37 +0000
Date: Thu, 10 Oct 2024 10:43:06 +0800
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
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v3 05/12] PCI: rockchip-ep: Implement the .map_align()
 controller operation
Message-ID: <202410101044.3nr7XIR9-lkp@intel.com>
References: <20241007041218.157516-6-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007041218.157516-6-dlemoal@kernel.org>

Hi Damien,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/next]
[also build test ERROR on pci/for-linus mani-mhi/mhi-next linus/master v6.12-rc2 next-20241009]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Damien-Le-Moal/PCI-rockchip-ep-Use-a-macro-to-define-EP-controller-align-feature/20241007-131224
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20241007041218.157516-6-dlemoal%40kernel.org
patch subject: [PATCH v3 05/12] PCI: rockchip-ep: Implement the .map_align() controller operation
config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/20241010/202410101044.3nr7XIR9-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241010/202410101044.3nr7XIR9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410101044.3nr7XIR9-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> drivers/pci/controller/pcie-rockchip-ep.c:239:46: warning: 'struct pci_epc_map' declared inside parameter list will not be visible outside of this definition or declaration
     239 |                                       struct pci_epc_map *map)
         |                                              ^~~~~~~~~~~
   drivers/pci/controller/pcie-rockchip-ep.c: In function 'rockchip_pcie_ep_map_align':
>> drivers/pci/controller/pcie-rockchip-ep.c:245:52: error: invalid use of undefined type 'struct pci_epc_map'
     245 |                                                 map->pci_addr, map->pci_size);
         |                                                    ^~
   drivers/pci/controller/pcie-rockchip-ep.c:245:67: error: invalid use of undefined type 'struct pci_epc_map'
     245 |                                                 map->pci_addr, map->pci_size);
         |                                                                   ^~
   drivers/pci/controller/pcie-rockchip-ep.c:247:12: error: invalid use of undefined type 'struct pci_epc_map'
     247 |         map->map_pci_addr = map->pci_addr & ~((1ULL << num_bits) - 1);
         |            ^~
   drivers/pci/controller/pcie-rockchip-ep.c:247:32: error: invalid use of undefined type 'struct pci_epc_map'
     247 |         map->map_pci_addr = map->pci_addr & ~((1ULL << num_bits) - 1);
         |                                ^~
   drivers/pci/controller/pcie-rockchip-ep.c:248:12: error: invalid use of undefined type 'struct pci_epc_map'
     248 |         map->map_ofst = map->pci_addr - map->map_pci_addr;
         |            ^~
   drivers/pci/controller/pcie-rockchip-ep.c:248:28: error: invalid use of undefined type 'struct pci_epc_map'
     248 |         map->map_ofst = map->pci_addr - map->map_pci_addr;
         |                            ^~
   drivers/pci/controller/pcie-rockchip-ep.c:248:44: error: invalid use of undefined type 'struct pci_epc_map'
     248 |         map->map_ofst = map->pci_addr - map->map_pci_addr;
         |                                            ^~
   drivers/pci/controller/pcie-rockchip-ep.c:250:16: error: invalid use of undefined type 'struct pci_epc_map'
     250 |         if (map->map_ofst + map->pci_size > SZ_1M)
         |                ^~
   drivers/pci/controller/pcie-rockchip-ep.c:250:32: error: invalid use of undefined type 'struct pci_epc_map'
     250 |         if (map->map_ofst + map->pci_size > SZ_1M)
         |                                ^~
   drivers/pci/controller/pcie-rockchip-ep.c:251:20: error: invalid use of undefined type 'struct pci_epc_map'
     251 |                 map->pci_size = SZ_1M - map->map_ofst;
         |                    ^~
   drivers/pci/controller/pcie-rockchip-ep.c:251:44: error: invalid use of undefined type 'struct pci_epc_map'
     251 |                 map->pci_size = SZ_1M - map->map_ofst;
         |                                            ^~
   drivers/pci/controller/pcie-rockchip-ep.c:253:12: error: invalid use of undefined type 'struct pci_epc_map'
     253 |         map->map_size = ALIGN(map->map_ofst + map->pci_size,
         |            ^~
   In file included from include/vdso/const.h:5,
                    from include/linux/const.h:4,
                    from include/uapi/linux/kernel.h:6,
                    from include/linux/cache.h:5,
                    from include/linux/time.h:5,
                    from include/linux/stat.h:19,
                    from include/linux/configfs.h:22,
                    from drivers/pci/controller/pcie-rockchip-ep.c:11:
   drivers/pci/controller/pcie-rockchip-ep.c:253:34: error: invalid use of undefined type 'struct pci_epc_map'
     253 |         map->map_size = ALIGN(map->map_ofst + map->pci_size,
         |                                  ^~
   include/uapi/linux/const.h:49:44: note: in definition of macro '__ALIGN_KERNEL_MASK'
      49 | #define __ALIGN_KERNEL_MASK(x, mask)    (((x) + (mask)) & ~(mask))
         |                                            ^
   include/linux/align.h:8:33: note: in expansion of macro '__ALIGN_KERNEL'
       8 | #define ALIGN(x, a)             __ALIGN_KERNEL((x), (a))
         |                                 ^~~~~~~~~~~~~~
   drivers/pci/controller/pcie-rockchip-ep.c:253:25: note: in expansion of macro 'ALIGN'
     253 |         map->map_size = ALIGN(map->map_ofst + map->pci_size,
         |                         ^~~~~
   drivers/pci/controller/pcie-rockchip-ep.c:253:50: error: invalid use of undefined type 'struct pci_epc_map'
     253 |         map->map_size = ALIGN(map->map_ofst + map->pci_size,
         |                                                  ^~
   include/uapi/linux/const.h:49:44: note: in definition of macro '__ALIGN_KERNEL_MASK'
      49 | #define __ALIGN_KERNEL_MASK(x, mask)    (((x) + (mask)) & ~(mask))
         |                                            ^
   include/linux/align.h:8:33: note: in expansion of macro '__ALIGN_KERNEL'
       8 | #define ALIGN(x, a)             __ALIGN_KERNEL((x), (a))
         |                                 ^~~~~~~~~~~~~~
   drivers/pci/controller/pcie-rockchip-ep.c:253:25: note: in expansion of macro 'ALIGN'
     253 |         map->map_size = ALIGN(map->map_ofst + map->pci_size,
         |                         ^~~~~
   drivers/pci/controller/pcie-rockchip-ep.c:253:34: error: invalid use of undefined type 'struct pci_epc_map'
     253 |         map->map_size = ALIGN(map->map_ofst + map->pci_size,
         |                                  ^~
   include/uapi/linux/const.h:49:50: note: in definition of macro '__ALIGN_KERNEL_MASK'
      49 | #define __ALIGN_KERNEL_MASK(x, mask)    (((x) + (mask)) & ~(mask))
         |                                                  ^~~~
   include/linux/align.h:8:33: note: in expansion of macro '__ALIGN_KERNEL'
       8 | #define ALIGN(x, a)             __ALIGN_KERNEL((x), (a))
         |                                 ^~~~~~~~~~~~~~
   drivers/pci/controller/pcie-rockchip-ep.c:253:25: note: in expansion of macro 'ALIGN'
     253 |         map->map_size = ALIGN(map->map_ofst + map->pci_size,
         |                         ^~~~~
   drivers/pci/controller/pcie-rockchip-ep.c:253:50: error: invalid use of undefined type 'struct pci_epc_map'
     253 |         map->map_size = ALIGN(map->map_ofst + map->pci_size,
         |                                                  ^~
   include/uapi/linux/const.h:49:50: note: in definition of macro '__ALIGN_KERNEL_MASK'
      49 | #define __ALIGN_KERNEL_MASK(x, mask)    (((x) + (mask)) & ~(mask))
         |                                                  ^~~~
   include/linux/align.h:8:33: note: in expansion of macro '__ALIGN_KERNEL'
       8 | #define ALIGN(x, a)             __ALIGN_KERNEL((x), (a))
         |                                 ^~~~~~~~~~~~~~
   drivers/pci/controller/pcie-rockchip-ep.c:253:25: note: in expansion of macro 'ALIGN'
     253 |         map->map_size = ALIGN(map->map_ofst + map->pci_size,
         |                         ^~~~~
   drivers/pci/controller/pcie-rockchip-ep.c:253:34: error: invalid use of undefined type 'struct pci_epc_map'
     253 |         map->map_size = ALIGN(map->map_ofst + map->pci_size,
         |                                  ^~
   include/uapi/linux/const.h:49:61: note: in definition of macro '__ALIGN_KERNEL_MASK'
      49 | #define __ALIGN_KERNEL_MASK(x, mask)    (((x) + (mask)) & ~(mask))
         |                                                             ^~~~
   include/linux/align.h:8:33: note: in expansion of macro '__ALIGN_KERNEL'
       8 | #define ALIGN(x, a)             __ALIGN_KERNEL((x), (a))
         |                                 ^~~~~~~~~~~~~~
   drivers/pci/controller/pcie-rockchip-ep.c:253:25: note: in expansion of macro 'ALIGN'
     253 |         map->map_size = ALIGN(map->map_ofst + map->pci_size,
         |                         ^~~~~
   drivers/pci/controller/pcie-rockchip-ep.c:253:50: error: invalid use of undefined type 'struct pci_epc_map'
     253 |         map->map_size = ALIGN(map->map_ofst + map->pci_size,
         |                                                  ^~
   include/uapi/linux/const.h:49:61: note: in definition of macro '__ALIGN_KERNEL_MASK'
      49 | #define __ALIGN_KERNEL_MASK(x, mask)    (((x) + (mask)) & ~(mask))
         |                                                             ^~~~
   include/linux/align.h:8:33: note: in expansion of macro '__ALIGN_KERNEL'
       8 | #define ALIGN(x, a)             __ALIGN_KERNEL((x), (a))
         |                                 ^~~~~~~~~~~~~~
   drivers/pci/controller/pcie-rockchip-ep.c:253:25: note: in expansion of macro 'ALIGN'
     253 |         map->map_size = ALIGN(map->map_ofst + map->pci_size,
         |                         ^~~~~
   drivers/pci/controller/pcie-rockchip-ep.c: At top level:
>> drivers/pci/controller/pcie-rockchip-ep.c:482:10: error: 'const struct pci_epc_ops' has no member named 'map_align'
     482 |         .map_align      = rockchip_pcie_ep_map_align,
         |          ^~~~~~~~~
>> drivers/pci/controller/pcie-rockchip-ep.c:482:27: error: initialization of 'int (*)(struct pci_epc *, u8,  u8,  phys_addr_t,  u64,  size_t)' {aka 'int (*)(struct pci_epc *, unsigned char,  unsigned char,  long long unsigned int,  long long unsigned int,  long unsigned int)'} from incompatible pointer type 'int (*)(struct pci_epc *, u8,  u8,  struct pci_epc_map *)' {aka 'int (*)(struct pci_epc *, unsigned char,  unsigned char,  struct pci_epc_map *)'} [-Wincompatible-pointer-types]
     482 |         .map_align      = rockchip_pcie_ep_map_align,
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pci/controller/pcie-rockchip-ep.c:482:27: note: (near initialization for 'rockchip_pcie_epc_ops.map_addr')
   drivers/pci/controller/pcie-rockchip-ep.c:483:27: warning: initialized field overwritten [-Woverride-init]
     483 |         .map_addr       = rockchip_pcie_ep_map_addr,
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pci/controller/pcie-rockchip-ep.c:483:27: note: (near initialization for 'rockchip_pcie_epc_ops.map_addr')


vim +245 drivers/pci/controller/pcie-rockchip-ep.c

   237	
   238	static int rockchip_pcie_ep_map_align(struct pci_epc *epc, u8 fn, u8 vfn,
 > 239					      struct pci_epc_map *map)
   240	{
   241		struct rockchip_pcie_ep *ep = epc_get_drvdata(epc);
   242		int num_bits;
   243	
   244		num_bits = rockchip_pcie_ep_ob_atu_num_bits(&ep->rockchip,
 > 245							map->pci_addr, map->pci_size);
   246	
   247		map->map_pci_addr = map->pci_addr & ~((1ULL << num_bits) - 1);
   248		map->map_ofst = map->pci_addr - map->map_pci_addr;
   249	
   250		if (map->map_ofst + map->pci_size > SZ_1M)
   251			map->pci_size = SZ_1M - map->map_ofst;
   252	
   253		map->map_size = ALIGN(map->map_ofst + map->pci_size,
   254				      ROCKCHIP_PCIE_AT_SIZE_ALIGN);
   255	
   256		return 0;
   257	}
   258	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

