Return-Path: <linux-pci+bounces-14129-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A00A997BDB
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 06:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB370B21C75
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 04:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD1919ADAA;
	Thu, 10 Oct 2024 04:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hOq5DNrw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465623D66;
	Thu, 10 Oct 2024 04:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728534955; cv=none; b=GPxgI/0fNNP4N6h0Ob9lHpwipRsi29vDgqbVokY7aS9e+b965ywzhg7vGqB6H6ZR5gkWHwsoBP9Wlyj9IvdCWWx8c0mRTtBQWoPvcjOapu0ffHfunfS8IUmFtYpaAtID7JZqMRXt74xMY6k7B/R0AXM3Phyh/gt06KhbU0RlHac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728534955; c=relaxed/simple;
	bh=P85mdDr+6ogvc7JrH7HIaL8upROhQg5PhLxmzsIJZTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NLDOV1G8NMAXdT5WjGNU004VNMnqYqdEGGyNpa6I8eQRVkac7ICd0Ydiw6anembUykwwWd3yCUGFWm2gSDfI0kpeePg4CjRIC6yvowI9bLZ2xmel8Z9jY4RGR7G+jNFFOeLjLLUZGyxpmWYJcEll046Pc/oDqSrqR+4eZEWv0PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hOq5DNrw; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728534952; x=1760070952;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=P85mdDr+6ogvc7JrH7HIaL8upROhQg5PhLxmzsIJZTo=;
  b=hOq5DNrw99pdH9yt7/TBzT1pYO8uZd9jiSE8wgoDvKlshrykPqHMcwDU
   KNrJYDSfbsEgOCQZYHssjjV/xWUyA74vmYDOWak4KP30HT5i7KUO6hqcE
   IC8X868T91m5ImtCaO8G+ElSa7NQWl9lK4U2XFh/qnL0lyoB6qzpPlZ3J
   E474IEML+OT8VGHvr64VLzkc9OWDNwS7wg3T5Mg0oOP+SL8DS5xFsigAz
   zqi9MIcRrbMAEDE7WTWmuR7Yd976EmTX8LKLQch4Y2nCFhZh4GkfCjlaI
   0/dXoj2gb7mPFQXj107slFVOILimuDm0St2zqrhx3z7Fy+z6G4A4qWYRe
   g==;
X-CSE-ConnectionGUID: 88StVbBRQVelT36264LeYg==
X-CSE-MsgGUID: 3AAJSy7ETiu1lD2Dv0Vv4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="53274698"
X-IronPort-AV: E=Sophos;i="6.11,191,1725346800"; 
   d="scan'208";a="53274698"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 21:35:51 -0700
X-CSE-ConnectionGUID: Kvf6ziAXT1Kw8s+mZR5MtA==
X-CSE-MsgGUID: pH6/SfkPTI6TJOnBgJXu/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,191,1725346800"; 
   d="scan'208";a="76403777"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 09 Oct 2024 21:35:48 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1syktt-000ABR-0T;
	Thu, 10 Oct 2024 04:35:45 +0000
Date: Thu, 10 Oct 2024 12:35:35 +0800
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
Subject: Re: [PATCH v3 12/12] PCI: rockchip-ep: Handle PERST# signal in
 endpoint mode
Message-ID: <202410101236.xqI8ZWNd-lkp@intel.com>
References: <20241007041218.157516-13-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007041218.157516-13-dlemoal@kernel.org>

Hi Damien,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/next]
[also build test ERROR on pci/for-linus mani-mhi/mhi-next linus/master v6.12-rc2 next-20241009]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Damien-Le-Moal/PCI-rockchip-ep-Use-a-macro-to-define-EP-controller-align-feature/20241007-131224
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20241007041218.157516-13-dlemoal%40kernel.org
patch subject: [PATCH v3 12/12] PCI: rockchip-ep: Handle PERST# signal in endpoint mode
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20241010/202410101236.xqI8ZWNd-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241010/202410101236.xqI8ZWNd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410101236.xqI8ZWNd-lkp@intel.com/

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
>> drivers/pci/controller/pcie-rockchip-ep.c:631:9: error: implicit declaration of function 'irq_set_irq_type'; did you mean 'irq_set_irq_wake'? [-Wimplicit-function-declaration]
     631 |         irq_set_irq_type(ep->perst_irq,
         |         ^~~~~~~~~~~~~~~~
         |         irq_set_irq_wake
   drivers/pci/controller/pcie-rockchip-ep.c: In function 'rockchip_pcie_ep_setup_irq':
>> drivers/pci/controller/pcie-rockchip-ep.c:655:9: error: implicit declaration of function 'irq_set_status_flags' [-Wimplicit-function-declaration]
     655 |         irq_set_status_flags(ep->perst_irq, IRQ_NOAUTOEN);
         |         ^~~~~~~~~~~~~~~~~~~~
>> drivers/pci/controller/pcie-rockchip-ep.c:655:45: error: 'IRQ_NOAUTOEN' undeclared (first use in this function); did you mean 'IRQF_NO_AUTOEN'?
     655 |         irq_set_status_flags(ep->perst_irq, IRQ_NOAUTOEN);
         |                                             ^~~~~~~~~~~~
         |                                             IRQF_NO_AUTOEN
   drivers/pci/controller/pcie-rockchip-ep.c:655:45: note: each undeclared identifier is reported only once for each function it appears in
   drivers/pci/controller/pcie-rockchip-ep.c: At top level:
   drivers/pci/controller/pcie-rockchip-ep.c:685:10: error: 'const struct pci_epc_ops' has no member named 'map_align'
     685 |         .map_align      = rockchip_pcie_ep_map_align,
         |          ^~~~~~~~~
   drivers/pci/controller/pcie-rockchip-ep.c:685:27: error: initialization of 'int (*)(struct pci_epc *, u8,  u8,  phys_addr_t,  u64,  size_t)' {aka 'int (*)(struct pci_epc *, unsigned char,  unsigned char,  long long unsigned int,  long long unsigned int,  long unsigned int)'} from incompatible pointer type 'int (*)(struct pci_epc *, u8,  u8,  struct pci_epc_map *)' {aka 'int (*)(struct pci_epc *, unsigned char,  unsigned char,  struct pci_epc_map *)'} [-Wincompatible-pointer-types]
     685 |         .map_align      = rockchip_pcie_ep_map_align,
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pci/controller/pcie-rockchip-ep.c:685:27: note: (near initialization for 'rockchip_pcie_epc_ops.map_addr')
   drivers/pci/controller/pcie-rockchip-ep.c:686:27: warning: initialized field overwritten [-Woverride-init]
     686 |         .map_addr       = rockchip_pcie_ep_map_addr,
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pci/controller/pcie-rockchip-ep.c:686:27: note: (near initialization for 'rockchip_pcie_epc_ops.map_addr')


vim +631 drivers/pci/controller/pcie-rockchip-ep.c

   618	
   619	static irqreturn_t rockchip_pcie_ep_perst_irq_thread(int irq, void *data)
   620	{
   621		struct pci_epc *epc = data;
   622		struct rockchip_pcie_ep *ep = epc_get_drvdata(epc);
   623		struct rockchip_pcie *rockchip = &ep->rockchip;
   624		u32 perst = gpiod_get_value(rockchip->ep_gpio);
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
   644		if (!rockchip->ep_gpio)
   645			return 0;
   646	
   647		/* PCIe reset interrupt */
   648		ep->perst_irq = gpiod_to_irq(rockchip->ep_gpio);
   649		if (ep->perst_irq < 0) {
   650			dev_err(dev, "No corresponding IRQ for PERST GPIO\n");
   651			return ep->perst_irq;
   652		}
   653	
   654		ep->perst_asserted = true;
 > 655		irq_set_status_flags(ep->perst_irq, IRQ_NOAUTOEN);
   656		ret = devm_request_threaded_irq(dev, ep->perst_irq, NULL,
   657						rockchip_pcie_ep_perst_irq_thread,
   658						IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
   659						"pcie-ep-perst", epc);
   660		if (ret) {
   661			dev_err(dev, "Request PERST GPIO IRQ failed %d\n", ret);
   662			return ret;
   663		}
   664	
   665		return 0;
   666	}
   667	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

