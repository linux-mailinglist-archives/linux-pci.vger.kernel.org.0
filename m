Return-Path: <linux-pci+bounces-14506-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B0C99DB39
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 03:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 023E01F25568
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 01:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4357A15688C;
	Tue, 15 Oct 2024 01:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n/jpeiOM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEEF42AAB;
	Tue, 15 Oct 2024 01:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728954926; cv=none; b=gqFT34NfFCPCEWsQVzwLGdEboVxYmL12GtWJqqDX3GlDYO0X3ml374gViED1ZXNbRG4nAhre86F6r6I7NHLDZzRauNuCf/yWVKyLXjbgBAHXeAwrsm1YST9FEzjj2WmYdrxRklTccWgVU6g3EXoSrUxW3VTgEYJt7jno1/Al70E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728954926; c=relaxed/simple;
	bh=tFFxkvJ0G3O9R7IGRFe5DD3b6MrHUakutTB8YIqz40k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W5dyJK7g899mHWH1nOCC/hQTagxal1lXmS7RzEEqZZZV1FJ+N0K/vjIKEKBfnst45pN+G5ifn1EwwHXpdrYPOtuBZrymz6bT/Ioh7e7EeHEVWP7WQowF0of2yAlzb5/ft7rRdgt3rDjhA62ooFbufjkm4/1RajaOlm/Boi1wHlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n/jpeiOM; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728954922; x=1760490922;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tFFxkvJ0G3O9R7IGRFe5DD3b6MrHUakutTB8YIqz40k=;
  b=n/jpeiOMKZTUkjxxnGgMUW6mqerL++wW8s8KWFkNbF6ffrMZhQz3h9XP
   TPEm3amNPFJh9lAtO4mFe29PswGXR+LHPTcl+VLOaEN7Rs3SBYqd8pxMt
   mVFt6WHfGyOhIbZnspceZ16NI91XoV2bGohFQVkEkKVpNUCsMmtSNsa/0
   a0Uy+Cpk5qJNZHEYlV+PmKzd2rJ3sMq/FzTxeAHrH+/8bg01am/9y649v
   Ae2AoasVC3YfZSy0gdKLLTAW6BkTbHHMnYni9FGV22Qn/e5ysryMHFsdX
   pPzw/hmd9Ucf4FIe+Hq2PTZOyxPI2rxRTma0OAPA9gEz4zuvcvv6ZNJ/9
   A==;
X-CSE-ConnectionGUID: O5Z1kAhzRCCPBGmIuzx9kQ==
X-CSE-MsgGUID: lUEMQRUeRzqCSv8yjypy+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28414163"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28414163"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 18:15:22 -0700
X-CSE-ConnectionGUID: 43tRWbA8TbGV15YSeWVcUw==
X-CSE-MsgGUID: LQpjPfJLRDGAERZYGjE8kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,204,1725346800"; 
   d="scan'208";a="77406950"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 14 Oct 2024 18:15:18 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t0W9b-000HQ7-2g;
	Tue, 15 Oct 2024 01:15:15 +0000
Date: Tue, 15 Oct 2024 09:15:02 +0800
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
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-rockchip@lists.infradead.org,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v4 05/12] PCI: rockchip-ep: Implement the
 pci_epc_ops::get_mem_map() operation
Message-ID: <202410150801.vWDev1xr-lkp@intel.com>
References: <20241011121408.89890-6-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011121408.89890-6-dlemoal@kernel.org>

Hi Damien,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/next]
[also build test ERROR on pci/for-linus mani-mhi/mhi-next linus/master v6.12-rc3 next-20241014]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Damien-Le-Moal/PCI-rockchip-ep-Fix-address-translation-unit-programming/20241011-201512
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20241011121408.89890-6-dlemoal%40kernel.org
patch subject: [PATCH v4 05/12] PCI: rockchip-ep: Implement the pci_epc_ops::get_mem_map() operation
config: i386-buildonly-randconfig-004-20241015 (https://download.01.org/0day-ci/archive/20241015/202410150801.vWDev1xr-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241015/202410150801.vWDev1xr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410150801.vWDev1xr-lkp@intel.com/

All errors (new ones prefixed by >>):

         |                                         ~~~^
   drivers/pci/controller/pcie-rockchip-ep.c:239:13: note: forward declaration of 'struct pci_epc_map'
     239 |                                         struct pci_epc_map *map)
         |                                                ^
   drivers/pci/controller/pcie-rockchip-ep.c:253:5: error: incomplete definition of type 'struct pci_epc_map'
     253 |         map->map_size = ALIGN(map->map_ofst + map->pci_size,
         |         ~~~^
   drivers/pci/controller/pcie-rockchip-ep.c:239:13: note: forward declaration of 'struct pci_epc_map'
     239 |                                         struct pci_epc_map *map)
         |                                                ^
   drivers/pci/controller/pcie-rockchip-ep.c:253:27: error: incomplete definition of type 'struct pci_epc_map'
     253 |         map->map_size = ALIGN(map->map_ofst + map->pci_size,
         |                               ~~~^
   include/linux/align.h:8:38: note: expanded from macro 'ALIGN'
       8 | #define ALIGN(x, a)             __ALIGN_KERNEL((x), (a))
         |                                                 ^
   include/uapi/linux/const.h:48:51: note: expanded from macro '__ALIGN_KERNEL'
      48 | #define __ALIGN_KERNEL(x, a)            __ALIGN_KERNEL_MASK(x, (__typeof__(x))(a) - 1)
         |                                                             ^
   include/uapi/linux/const.h:49:41: note: expanded from macro '__ALIGN_KERNEL_MASK'
      49 | #define __ALIGN_KERNEL_MASK(x, mask)    (((x) + (mask)) & ~(mask))
         |                                            ^
   drivers/pci/controller/pcie-rockchip-ep.c:239:13: note: forward declaration of 'struct pci_epc_map'
     239 |                                         struct pci_epc_map *map)
         |                                                ^
   drivers/pci/controller/pcie-rockchip-ep.c:253:43: error: incomplete definition of type 'struct pci_epc_map'
     253 |         map->map_size = ALIGN(map->map_ofst + map->pci_size,
         |                                               ~~~^
   include/linux/align.h:8:38: note: expanded from macro 'ALIGN'
       8 | #define ALIGN(x, a)             __ALIGN_KERNEL((x), (a))
         |                                                 ^
   include/uapi/linux/const.h:48:51: note: expanded from macro '__ALIGN_KERNEL'
      48 | #define __ALIGN_KERNEL(x, a)            __ALIGN_KERNEL_MASK(x, (__typeof__(x))(a) - 1)
         |                                                             ^
   include/uapi/linux/const.h:49:41: note: expanded from macro '__ALIGN_KERNEL_MASK'
      49 | #define __ALIGN_KERNEL_MASK(x, mask)    (((x) + (mask)) & ~(mask))
         |                                            ^
   drivers/pci/controller/pcie-rockchip-ep.c:239:13: note: forward declaration of 'struct pci_epc_map'
     239 |                                         struct pci_epc_map *map)
         |                                                ^
   drivers/pci/controller/pcie-rockchip-ep.c:253:27: error: incomplete definition of type 'struct pci_epc_map'
     253 |         map->map_size = ALIGN(map->map_ofst + map->pci_size,
         |                               ~~~^
   include/linux/align.h:8:38: note: expanded from macro 'ALIGN'
       8 | #define ALIGN(x, a)             __ALIGN_KERNEL((x), (a))
         |                                                 ^
   include/uapi/linux/const.h:48:66: note: expanded from macro '__ALIGN_KERNEL'
      48 | #define __ALIGN_KERNEL(x, a)            __ALIGN_KERNEL_MASK(x, (__typeof__(x))(a) - 1)
         |                                                                            ^
   include/uapi/linux/const.h:49:47: note: expanded from macro '__ALIGN_KERNEL_MASK'
      49 | #define __ALIGN_KERNEL_MASK(x, mask)    (((x) + (mask)) & ~(mask))
         |                                                  ^~~~
   drivers/pci/controller/pcie-rockchip-ep.c:239:13: note: forward declaration of 'struct pci_epc_map'
     239 |                                         struct pci_epc_map *map)
         |                                                ^
   drivers/pci/controller/pcie-rockchip-ep.c:253:43: error: incomplete definition of type 'struct pci_epc_map'
     253 |         map->map_size = ALIGN(map->map_ofst + map->pci_size,
         |                                               ~~~^
   include/linux/align.h:8:38: note: expanded from macro 'ALIGN'
       8 | #define ALIGN(x, a)             __ALIGN_KERNEL((x), (a))
         |                                                 ^
   include/uapi/linux/const.h:48:66: note: expanded from macro '__ALIGN_KERNEL'
      48 | #define __ALIGN_KERNEL(x, a)            __ALIGN_KERNEL_MASK(x, (__typeof__(x))(a) - 1)
         |                                                                            ^
   include/uapi/linux/const.h:49:47: note: expanded from macro '__ALIGN_KERNEL_MASK'
      49 | #define __ALIGN_KERNEL_MASK(x, mask)    (((x) + (mask)) & ~(mask))
         |                                                  ^~~~
   drivers/pci/controller/pcie-rockchip-ep.c:239:13: note: forward declaration of 'struct pci_epc_map'
     239 |                                         struct pci_epc_map *map)
         |                                                ^
   drivers/pci/controller/pcie-rockchip-ep.c:253:27: error: incomplete definition of type 'struct pci_epc_map'
     253 |         map->map_size = ALIGN(map->map_ofst + map->pci_size,
         |                               ~~~^
   include/linux/align.h:8:38: note: expanded from macro 'ALIGN'
       8 | #define ALIGN(x, a)             __ALIGN_KERNEL((x), (a))
         |                                                 ^
   include/uapi/linux/const.h:48:66: note: expanded from macro '__ALIGN_KERNEL'
      48 | #define __ALIGN_KERNEL(x, a)            __ALIGN_KERNEL_MASK(x, (__typeof__(x))(a) - 1)
         |                                                                            ^
   include/uapi/linux/const.h:49:58: note: expanded from macro '__ALIGN_KERNEL_MASK'
      49 | #define __ALIGN_KERNEL_MASK(x, mask)    (((x) + (mask)) & ~(mask))
         |                                                             ^~~~
   drivers/pci/controller/pcie-rockchip-ep.c:239:13: note: forward declaration of 'struct pci_epc_map'
     239 |                                         struct pci_epc_map *map)
         |                                                ^
   drivers/pci/controller/pcie-rockchip-ep.c:253:43: error: incomplete definition of type 'struct pci_epc_map'
     253 |         map->map_size = ALIGN(map->map_ofst + map->pci_size,
         |                                               ~~~^
   include/linux/align.h:8:38: note: expanded from macro 'ALIGN'
       8 | #define ALIGN(x, a)             __ALIGN_KERNEL((x), (a))
         |                                                 ^
   include/uapi/linux/const.h:48:66: note: expanded from macro '__ALIGN_KERNEL'
      48 | #define __ALIGN_KERNEL(x, a)            __ALIGN_KERNEL_MASK(x, (__typeof__(x))(a) - 1)
         |                                                                            ^
   include/uapi/linux/const.h:49:58: note: expanded from macro '__ALIGN_KERNEL_MASK'
      49 | #define __ALIGN_KERNEL_MASK(x, mask)    (((x) + (mask)) & ~(mask))
         |                                                             ^~~~
   drivers/pci/controller/pcie-rockchip-ep.c:239:13: note: forward declaration of 'struct pci_epc_map'
     239 |                                         struct pci_epc_map *map)
         |                                                ^
>> drivers/pci/controller/pcie-rockchip-ep.c:482:3: error: field designator 'get_mem_map' does not refer to any field in type 'const struct pci_epc_ops'
     482 |         .get_mem_map    = rockchip_pcie_ep_get_mem_map,
         |         ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning and 19 errors generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for MODVERSIONS
   Depends on [n]: MODULES [=y] && !COMPILE_TEST [=y]
   Selected by [y]:
   - RANDSTRUCT_FULL [=y] && (CC_HAS_RANDSTRUCT [=y] || GCC_PLUGINS [=n]) && MODULES [=y]


vim +482 drivers/pci/controller/pcie-rockchip-ep.c

   477	
   478	static const struct pci_epc_ops rockchip_pcie_epc_ops = {
   479		.write_header	= rockchip_pcie_ep_write_header,
   480		.set_bar	= rockchip_pcie_ep_set_bar,
   481		.clear_bar	= rockchip_pcie_ep_clear_bar,
 > 482		.get_mem_map	= rockchip_pcie_ep_get_mem_map,
   483		.map_addr	= rockchip_pcie_ep_map_addr,
   484		.unmap_addr	= rockchip_pcie_ep_unmap_addr,
   485		.set_msi	= rockchip_pcie_ep_set_msi,
   486		.get_msi	= rockchip_pcie_ep_get_msi,
   487		.raise_irq	= rockchip_pcie_ep_raise_irq,
   488		.start		= rockchip_pcie_ep_start,
   489		.get_features	= rockchip_pcie_ep_get_features,
   490	};
   491	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

