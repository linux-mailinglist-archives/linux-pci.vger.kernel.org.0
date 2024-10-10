Return-Path: <linux-pci+bounces-14128-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 462FA997B6C
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 05:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67E3E1C23A1A
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 03:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF408194C6A;
	Thu, 10 Oct 2024 03:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aMN5MdLc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F59192D63;
	Thu, 10 Oct 2024 03:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728531889; cv=none; b=AsSCqmeYoj8pxB+dT9li+doSyWx7PqReyvfYVxtgdX4tTrkE0AOA+wxGaln+OkSwctnVAwAu/CbXnCt8yUjdWIO+CE9X4DZeaPuFf+j3alcxW9dJvugr2/Jzy5Zp9AK4S3xDkVQ7F4tLErCEP9QwpekdYjjsRKbdx8gItrtrRtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728531889; c=relaxed/simple;
	bh=yFdYEg5rFGEP5S/sD0FVRqXqdQYwiHvsWbK0EjjO8Ec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fuSfnLxNELzyxTbgG8Nd5Aekad4Nt7IXbn35zmtmUa72tiAQOCDGHCAgVyhPhdStraVUCxsgHUeyPiULBfSJsESpTCmErspeWubKIu7bdcROP6uQAxGQYngZu6xEndu3DpSKcuXrnbIUz13vzNNteqnycUARW/CpF5Bfn1tKGCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aMN5MdLc; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728531888; x=1760067888;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yFdYEg5rFGEP5S/sD0FVRqXqdQYwiHvsWbK0EjjO8Ec=;
  b=aMN5MdLcNkKymXRopyBFTejV/mRuYDE1OwM0XIk1Jz2BcOOipAVvIAfr
   sqIr0lpbxitd2IeyBb+fXn3rL6UjQ92KosOxnspOdv+5mBLPWFTsoiDZt
   +icH/Ng6BObxoBuRv8wFlGsCmM/n6KTOIREdRPE3V+L0/mvCjtnW+mNwI
   F3hxws/w4c/LOyO4ZPG2S6Lmn87jzkYxVaLITH21uy6RizUtj9adwI7DP
   oiPothNAoQYZ9WV2DpOQtgJuC1Zulk/ddCHwTSzTqb383DN+JXoFXsSr6
   PU8Ugdrqr1kE6lirZFEjcMSeot0sskCYryJ9jigm2VnvF3tG5XKx16awy
   g==;
X-CSE-ConnectionGUID: CQ4ttNThREiFwOPu1FyeEA==
X-CSE-MsgGUID: bwLifp4LSKC1yYuaqKd1mQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="38452264"
X-IronPort-AV: E=Sophos;i="6.11,191,1725346800"; 
   d="scan'208";a="38452264"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 20:44:48 -0700
X-CSE-ConnectionGUID: Y8VVCO4AQLO/TJOocVVzsA==
X-CSE-MsgGUID: gLt6/uliQFSDQ80g5w6mmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,191,1725346800"; 
   d="scan'208";a="107298148"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 09 Oct 2024 20:44:43 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1syk6S-000A7n-2g;
	Thu, 10 Oct 2024 03:44:40 +0000
Date: Thu, 10 Oct 2024 11:44:08 +0800
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
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v3 05/12] PCI: rockchip-ep: Implement the .map_align()
 controller operation
Message-ID: <202410101109.J2ej9dSg-lkp@intel.com>
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
config: i386-buildonly-randconfig-003-20241010 (https://download.01.org/0day-ci/archive/20241010/202410101109.J2ej9dSg-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241010/202410101109.J2ej9dSg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410101109.J2ej9dSg-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> drivers/pci/controller/pcie-rockchip-ep.c:239:18: warning: declaration of 'struct pci_epc_map' will not be visible outside of this function [-Wvisibility]
     239 |                                       struct pci_epc_map *map)
         |                                              ^
>> drivers/pci/controller/pcie-rockchip-ep.c:245:10: error: incomplete definition of type 'struct pci_epc_map'
     245 |                                                 map->pci_addr, map->pci_size);
         |                                                 ~~~^
   drivers/pci/controller/pcie-rockchip-ep.c:239:18: note: forward declaration of 'struct pci_epc_map'
     239 |                                       struct pci_epc_map *map)
         |                                              ^
   drivers/pci/controller/pcie-rockchip-ep.c:245:25: error: incomplete definition of type 'struct pci_epc_map'
     245 |                                                 map->pci_addr, map->pci_size);
         |                                                                ~~~^
   drivers/pci/controller/pcie-rockchip-ep.c:239:18: note: forward declaration of 'struct pci_epc_map'
     239 |                                       struct pci_epc_map *map)
         |                                              ^
   drivers/pci/controller/pcie-rockchip-ep.c:247:5: error: incomplete definition of type 'struct pci_epc_map'
     247 |         map->map_pci_addr = map->pci_addr & ~((1ULL << num_bits) - 1);
         |         ~~~^
   drivers/pci/controller/pcie-rockchip-ep.c:239:18: note: forward declaration of 'struct pci_epc_map'
     239 |                                       struct pci_epc_map *map)
         |                                              ^
   drivers/pci/controller/pcie-rockchip-ep.c:247:25: error: incomplete definition of type 'struct pci_epc_map'
     247 |         map->map_pci_addr = map->pci_addr & ~((1ULL << num_bits) - 1);
         |                             ~~~^
   drivers/pci/controller/pcie-rockchip-ep.c:239:18: note: forward declaration of 'struct pci_epc_map'
     239 |                                       struct pci_epc_map *map)
         |                                              ^
   drivers/pci/controller/pcie-rockchip-ep.c:248:5: error: incomplete definition of type 'struct pci_epc_map'
     248 |         map->map_ofst = map->pci_addr - map->map_pci_addr;
         |         ~~~^
   drivers/pci/controller/pcie-rockchip-ep.c:239:18: note: forward declaration of 'struct pci_epc_map'
     239 |                                       struct pci_epc_map *map)
         |                                              ^
   drivers/pci/controller/pcie-rockchip-ep.c:248:21: error: incomplete definition of type 'struct pci_epc_map'
     248 |         map->map_ofst = map->pci_addr - map->map_pci_addr;
         |                         ~~~^
   drivers/pci/controller/pcie-rockchip-ep.c:239:18: note: forward declaration of 'struct pci_epc_map'
     239 |                                       struct pci_epc_map *map)
         |                                              ^
   drivers/pci/controller/pcie-rockchip-ep.c:248:37: error: incomplete definition of type 'struct pci_epc_map'
     248 |         map->map_ofst = map->pci_addr - map->map_pci_addr;
         |                                         ~~~^
   drivers/pci/controller/pcie-rockchip-ep.c:239:18: note: forward declaration of 'struct pci_epc_map'
     239 |                                       struct pci_epc_map *map)
         |                                              ^
   drivers/pci/controller/pcie-rockchip-ep.c:250:9: error: incomplete definition of type 'struct pci_epc_map'
     250 |         if (map->map_ofst + map->pci_size > SZ_1M)
         |             ~~~^
   drivers/pci/controller/pcie-rockchip-ep.c:239:18: note: forward declaration of 'struct pci_epc_map'
     239 |                                       struct pci_epc_map *map)
         |                                              ^
   drivers/pci/controller/pcie-rockchip-ep.c:250:25: error: incomplete definition of type 'struct pci_epc_map'
     250 |         if (map->map_ofst + map->pci_size > SZ_1M)
         |                             ~~~^
   drivers/pci/controller/pcie-rockchip-ep.c:239:18: note: forward declaration of 'struct pci_epc_map'
     239 |                                       struct pci_epc_map *map)
         |                                              ^
   drivers/pci/controller/pcie-rockchip-ep.c:251:6: error: incomplete definition of type 'struct pci_epc_map'
     251 |                 map->pci_size = SZ_1M - map->map_ofst;
         |                 ~~~^
   drivers/pci/controller/pcie-rockchip-ep.c:239:18: note: forward declaration of 'struct pci_epc_map'
     239 |                                       struct pci_epc_map *map)
         |                                              ^
   drivers/pci/controller/pcie-rockchip-ep.c:251:30: error: incomplete definition of type 'struct pci_epc_map'
     251 |                 map->pci_size = SZ_1M - map->map_ofst;
         |                                         ~~~^
   drivers/pci/controller/pcie-rockchip-ep.c:239:18: note: forward declaration of 'struct pci_epc_map'
     239 |                                       struct pci_epc_map *map)
         |                                              ^
   drivers/pci/controller/pcie-rockchip-ep.c:253:5: error: incomplete definition of type 'struct pci_epc_map'
     253 |         map->map_size = ALIGN(map->map_ofst + map->pci_size,
         |         ~~~^
   drivers/pci/controller/pcie-rockchip-ep.c:239:18: note: forward declaration of 'struct pci_epc_map'
     239 |                                       struct pci_epc_map *map)
         |                                              ^
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
   drivers/pci/controller/pcie-rockchip-ep.c:239:18: note: forward declaration of 'struct pci_epc_map'
     239 |                                       struct pci_epc_map *map)
         |                                              ^
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
   drivers/pci/controller/pcie-rockchip-ep.c:239:18: note: forward declaration of 'struct pci_epc_map'
     239 |                                       struct pci_epc_map *map)


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

