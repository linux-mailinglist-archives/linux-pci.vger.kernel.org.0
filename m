Return-Path: <linux-pci+bounces-16727-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14AF09C818D
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 04:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB2A41F22E40
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 03:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E71629A1;
	Thu, 14 Nov 2024 03:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dRxmbpe7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B4F46BF
	for <linux-pci@vger.kernel.org>; Thu, 14 Nov 2024 03:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731556186; cv=none; b=Yiw9/gSUFO75+nA4NuFQ0LwFAuG7TNiFs5ub2pdx1OxKoKHa1ZBrTfM+OPzvFJmyWNZVzSKyGWRwEfaczkUvcKZ0m+8SxT7b3Pv54WQe1yCeAZ6EDGQ2RoUNlZOO+DeKQwxYVVr012sUjQuhpfXDpo++Ubr8ao6TrYJOf8WhhEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731556186; c=relaxed/simple;
	bh=KTNjYpg//eZiNk+8gP+YxF6yTXRngavg48KuU1zIUIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tnDUwZG4Rc4sGm/ydD/7Mvva+/qLCa0Jcytt8BYpDFJBAKPRnFDEMXeSi/gsSXtHrM6zWxnk+42chotCjwDkZs37UuBcA8eG8/dOkZnUrSTS2lFMnBK0/qThLO53bpuVwxvj/6Zy/DC9iPJboIjHnby6mY9e3rW0wlZ7Ocri+eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dRxmbpe7; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731556183; x=1763092183;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KTNjYpg//eZiNk+8gP+YxF6yTXRngavg48KuU1zIUIQ=;
  b=dRxmbpe7BJuke9Ql+qybvHxMC7pWi/gmvGpUXzprQXNjMI4RvETv5IU4
   u0JSlHpsg9j8+RCc9MJJ4cByE7670IZXz5o3IRLL2NmbRvsTZ6nAW0R1j
   x1Xnn6+ZmE4pQoharG4uaxTOwxxyRPR0fS5YgfxCB+qn/gJqR/ZvJyxik
   MUh6f7oMu+7PfTcJM7/9r7a6jj8DT5Sb44Jmu3U9amzT4OsjAdXtst36Z
   yX8hNt088AyZGBc+r0LtyFPq54hWPwArZUdy4w1FLKByJf1d0ZLFiAfwD
   z27n43a+TlcCojALfrTsNP+Dycqjy5dlVefKcyOfwAyn0+b+6Peo6r3rX
   w==;
X-CSE-ConnectionGUID: RBneGfvTQCqsF1UTF9/9VQ==
X-CSE-MsgGUID: cwxmUFJvR/qphEUp4IZsDA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="31341525"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="31341525"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 19:49:43 -0800
X-CSE-ConnectionGUID: CcF8feQlRSKmt/YNTcQSnA==
X-CSE-MsgGUID: QlrvY8bNR2Si/HQXRTglsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,152,1728975600"; 
   d="scan'208";a="118894000"
Received: from lkp-server01.sh.intel.com (HELO b014a344d658) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 13 Nov 2024 19:49:41 -0800
Received: from kbuild by b014a344d658 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tBQrS-00005b-10;
	Thu, 14 Nov 2024 03:49:38 +0000
Date: Thu, 14 Nov 2024 11:48:49 +0800
From: kernel test robot <lkp@intel.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>
Subject: [pci:controller/rockchip 5/13]
 drivers/pci/controller/pcie-rockchip-ep.c:486:10: error: 'const struct
 pci_epc_ops' has no member named 'align_addr'
Message-ID: <202411141106.4hI5VqIa-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/rockchip
head:   337657a3c24c92befb3ed11d6f15402faa09f7dd
commit: 75b011d9006e703fe3a0706f9952e8510194cc07 [5/13] PCI: rockchip-ep: Implement the pci_epc_ops::align_addr() operation
config: sparc-allmodconfig (https://download.01.org/0day-ci/archive/20241114/202411141106.4hI5VqIa-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241114/202411141106.4hI5VqIa-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411141106.4hI5VqIa-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/pci/controller/pcie-rockchip-ep.c:486:10: error: 'const struct pci_epc_ops' has no member named 'align_addr'
     486 |         .align_addr     = rockchip_pcie_ep_align_addr,
         |          ^~~~~~~~~~
>> drivers/pci/controller/pcie-rockchip-ep.c:486:27: error: initialization of 'int (*)(struct pci_epc *, u8,  u8,  phys_addr_t,  u64,  size_t)' {aka 'int (*)(struct pci_epc *, unsigned char,  unsigned char,  long long unsigned int,  long long unsigned int,  long unsigned int)'} from incompatible pointer type 'u64 (*)(struct pci_epc *, u64,  size_t *, size_t *)' {aka 'long long unsigned int (*)(struct pci_epc *, long long unsigned int,  long unsigned int *, long unsigned int *)'} [-Wincompatible-pointer-types]
     486 |         .align_addr     = rockchip_pcie_ep_align_addr,
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pci/controller/pcie-rockchip-ep.c:486:27: note: (near initialization for 'rockchip_pcie_epc_ops.map_addr')
   drivers/pci/controller/pcie-rockchip-ep.c:487:27: warning: initialized field overwritten [-Woverride-init]
     487 |         .map_addr       = rockchip_pcie_ep_map_addr,
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pci/controller/pcie-rockchip-ep.c:487:27: note: (near initialization for 'rockchip_pcie_epc_ops.map_addr')


vim +486 drivers/pci/controller/pcie-rockchip-ep.c

   481	
   482	static const struct pci_epc_ops rockchip_pcie_epc_ops = {
   483		.write_header	= rockchip_pcie_ep_write_header,
   484		.set_bar	= rockchip_pcie_ep_set_bar,
   485		.clear_bar	= rockchip_pcie_ep_clear_bar,
 > 486		.align_addr	= rockchip_pcie_ep_align_addr,
   487		.map_addr	= rockchip_pcie_ep_map_addr,
   488		.unmap_addr	= rockchip_pcie_ep_unmap_addr,
   489		.set_msi	= rockchip_pcie_ep_set_msi,
   490		.get_msi	= rockchip_pcie_ep_get_msi,
   491		.raise_irq	= rockchip_pcie_ep_raise_irq,
   492		.start		= rockchip_pcie_ep_start,
   493		.get_features	= rockchip_pcie_ep_get_features,
   494	};
   495	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

