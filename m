Return-Path: <linux-pci+bounces-14508-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4BD99DC83
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 05:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48B18281F55
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 03:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C252F63A9;
	Tue, 15 Oct 2024 03:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QQK9Kvkl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A9C20EB;
	Tue, 15 Oct 2024 03:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728961291; cv=none; b=JjInjBxFIhbNs6xkIFABraXB/JN4S0rT36yFOyTZ/YLbqq9078QACI04eTuEZLRA/Qe7Ovk4V/H9xxpOTAGDRtz60kMGz601HAyJwzl0I62jMded+AgRpPeb0vUto8rP6GG9JXhRvG4TD/m2HKo0D9aTueHhj6+Hv3QV5Vf4ggs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728961291; c=relaxed/simple;
	bh=ZDSJW6AZlrWrt8SKy6ggSRZZUMjPiGXUINlliwmwrnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HFtAfzAXjKRcKIUWfwApKQLVNg/+NGmyJ/N0oyEd+za00cb9/rqoabEd4oFe3Rg6pEXY9G3BmUB00mKOWe8DRM/zjM/AVPZYVy4zo3JNg2aUvyBehd0QICQ+Wx8Y5YUzpI6REpOsJ//0VaPIO5rCgKaHWHygdbX2qsmrOLv4fPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QQK9Kvkl; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728961288; x=1760497288;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZDSJW6AZlrWrt8SKy6ggSRZZUMjPiGXUINlliwmwrnM=;
  b=QQK9Kvkl/ShhnGJNKK9xF75FiYzYvlPl+6aPzLxOB0TFfF+Ssgqp2nSt
   h/5wJacWM7MOA5geS/eTrWAz4SxzyZ24sD60hqRlqTtX4v/PlW+2B2AyR
   J+4YR5T66PJxWbYZgX2psuQ+1HKNQVwxJSDj1NjRFgN1HRrTBYnjXKJ57
   OpF6Q3BS7L6kSaUdJSUsnXp6Aee0XFfUOgBvCWwu3ZQHADvNN0FMum4K+
   /JaxagETNaQgM/bDn6Kqu5WyyWuDPw6FRXaCImY9XnawAp1ImUhuGXt05
   XhLwI06CM2HgcEYP38iX/3cRLYPTXrwXNie6gP4YfccjF3ajagN3sT4g0
   g==;
X-CSE-ConnectionGUID: mS/ZXqt5QKOQdYZLn/RZ7w==
X-CSE-MsgGUID: WFKHE5TVQS+UxhMXf4cPcw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28121713"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28121713"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 20:01:28 -0700
X-CSE-ConnectionGUID: pEkus2NrS1CjtBqHPyV6kg==
X-CSE-MsgGUID: WaGLgJcASzWmsqvGzF096w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="82531736"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 14 Oct 2024 20:01:23 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t0XoG-000HWL-1B;
	Tue, 15 Oct 2024 03:01:20 +0000
Date: Tue, 15 Oct 2024 11:01:02 +0800
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
Subject: Re: [PATCH v4 12/12] PCI: rockchip-ep: Handle PERST# signal in
 endpoint mode
Message-ID: <202410151041.Hk5w4EL5-lkp@intel.com>
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
config: i386-buildonly-randconfig-004-20241015 (https://download.01.org/0day-ci/archive/20241015/202410151041.Hk5w4EL5-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241015/202410151041.Hk5w4EL5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410151041.Hk5w4EL5-lkp@intel.com/

All errors (new ones prefixed by >>):

         |                                         ~~~^
   drivers/pci/controller/pcie-rockchip-ep.c:246:13: note: forward declaration of 'struct pci_epc_map'
     246 |                                         struct pci_epc_map *map)
         |                                                ^
   drivers/pci/controller/pcie-rockchip-ep.c:260:5: error: incomplete definition of type 'struct pci_epc_map'
     260 |         map->map_size = ALIGN(map->map_ofst + map->pci_size,
         |         ~~~^
   drivers/pci/controller/pcie-rockchip-ep.c:246:13: note: forward declaration of 'struct pci_epc_map'
     246 |                                         struct pci_epc_map *map)
         |                                                ^
   drivers/pci/controller/pcie-rockchip-ep.c:260:27: error: incomplete definition of type 'struct pci_epc_map'
     260 |         map->map_size = ALIGN(map->map_ofst + map->pci_size,
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
   drivers/pci/controller/pcie-rockchip-ep.c:246:13: note: forward declaration of 'struct pci_epc_map'
     246 |                                         struct pci_epc_map *map)
         |                                                ^
   drivers/pci/controller/pcie-rockchip-ep.c:260:43: error: incomplete definition of type 'struct pci_epc_map'
     260 |         map->map_size = ALIGN(map->map_ofst + map->pci_size,
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
   drivers/pci/controller/pcie-rockchip-ep.c:246:13: note: forward declaration of 'struct pci_epc_map'
     246 |                                         struct pci_epc_map *map)
         |                                                ^
   drivers/pci/controller/pcie-rockchip-ep.c:260:27: error: incomplete definition of type 'struct pci_epc_map'
     260 |         map->map_size = ALIGN(map->map_ofst + map->pci_size,
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
   drivers/pci/controller/pcie-rockchip-ep.c:246:13: note: forward declaration of 'struct pci_epc_map'
     246 |                                         struct pci_epc_map *map)
         |                                                ^
   drivers/pci/controller/pcie-rockchip-ep.c:260:43: error: incomplete definition of type 'struct pci_epc_map'
     260 |         map->map_size = ALIGN(map->map_ofst + map->pci_size,
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
   drivers/pci/controller/pcie-rockchip-ep.c:246:13: note: forward declaration of 'struct pci_epc_map'
     246 |                                         struct pci_epc_map *map)
         |                                                ^
   drivers/pci/controller/pcie-rockchip-ep.c:260:27: error: incomplete definition of type 'struct pci_epc_map'
     260 |         map->map_size = ALIGN(map->map_ofst + map->pci_size,
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
   drivers/pci/controller/pcie-rockchip-ep.c:246:13: note: forward declaration of 'struct pci_epc_map'
     246 |                                         struct pci_epc_map *map)
         |                                                ^
   drivers/pci/controller/pcie-rockchip-ep.c:260:43: error: incomplete definition of type 'struct pci_epc_map'
     260 |         map->map_size = ALIGN(map->map_ofst + map->pci_size,
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
   drivers/pci/controller/pcie-rockchip-ep.c:246:13: note: forward declaration of 'struct pci_epc_map'
     246 |                                         struct pci_epc_map *map)
         |                                                ^
>> drivers/pci/controller/pcie-rockchip-ep.c:631:2: error: call to undeclared function 'irq_set_irq_type'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     631 |         irq_set_irq_type(ep->perst_irq,
         |         ^
   drivers/pci/controller/pcie-rockchip-ep.c:631:2: note: did you mean 'irq_set_irq_wake'?
   include/linux/interrupt.h:489:12: note: 'irq_set_irq_wake' declared here
     489 | extern int irq_set_irq_wake(unsigned int irq, unsigned int on);
         |            ^
   fatal error: too many errors emitted, stopping now [-ferror-limit=]
   1 warning and 20 errors generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for MODVERSIONS
   Depends on [n]: MODULES [=y] && !COMPILE_TEST [=y]
   Selected by [y]:
   - RANDSTRUCT_FULL [=y] && (CC_HAS_RANDSTRUCT [=y] || GCC_PLUGINS [=n]) && MODULES [=y]


vim +/irq_set_irq_type +631 drivers/pci/controller/pcie-rockchip-ep.c

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

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

