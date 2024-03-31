Return-Path: <linux-pci+bounces-5458-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3628B892E3C
	for <lists+linux-pci@lfdr.de>; Sun, 31 Mar 2024 04:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C96C01C20AEE
	for <lists+linux-pci@lfdr.de>; Sun, 31 Mar 2024 02:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542B2818;
	Sun, 31 Mar 2024 02:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V6i1dIzx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EAEEC3
	for <linux-pci@vger.kernel.org>; Sun, 31 Mar 2024 02:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711850656; cv=none; b=PimaaLqr8tPJvchgi+6UHx1PWp/5AC7uWGpb7WCqhOxCXiE8hnMoiS1rfx6SdRjasaS2ZaV/058GJZVsjMYdyJlxX5x2GKWUPZp7h444WZJFBu3DlCkGBPADg5h0LiQFNejT1/lNiarGtszgh09XEpkGpYvpKbbS9W6UMb/6uJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711850656; c=relaxed/simple;
	bh=ergoIzABEDu8FXfkEAx5CdBSJwLyQ4n+t+7HDDIjwLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X9E8fkKyWLnhgl0qQpveMZtWjVFy8a+GiVrj223Sp9efa1o6t8CyYePMcHBaqb74uONqWSF3otzUZCTmYiAgXW3pL0qUAJFVRxOodFAvx+os6Gr2dk05joZfNqpFzsaiugIRIO7L7p+PQhMdaSrT/+H8EUiDdjhR1NpAWp6wxHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V6i1dIzx; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711850653; x=1743386653;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ergoIzABEDu8FXfkEAx5CdBSJwLyQ4n+t+7HDDIjwLc=;
  b=V6i1dIzxNSUzw/ldFaGQiMXVb0+05FYqN+GcZw0ssTndrgHk/lddoZTM
   QUa+Iks1SOP8RziDNpJs/ciEREsYILM0F0D7UYst7wNHWOj3KReylRiVN
   vFtSOYbdd/YL/SgNad+qiqFLNopD/dF9Z8j5QG6+u5sTwZ366y54bo/x6
   8IA6GSnVFRZ3JoYIlOCd94+6d7gKh28CiPx46a76izcW55hFNdUHZcuyr
   DEv/qrM7mDA2EdzpRuwhcJ9L4m+ZAIm8nS0SQxz8KdsttCzj4ksihorT5
   XSsLDM7ncchR5QC1PljQfPLm5Briq3gKh1oz6kUksh58wT/tV9KhuDSPf
   g==;
X-CSE-ConnectionGUID: OXpr27b0S02Teq9JrCUoog==
X-CSE-MsgGUID: /oWrXQfgSZaqvlOrnBh0ug==
X-IronPort-AV: E=McAfee;i="6600,9927,11029"; a="10818209"
X-IronPort-AV: E=Sophos;i="6.07,169,1708416000"; 
   d="scan'208";a="10818209"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2024 19:04:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,169,1708416000"; 
   d="scan'208";a="40492090"
Received: from lkp-server01.sh.intel.com (HELO 3d808bfd2502) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 30 Mar 2024 19:04:10 -0700
Received: from kbuild by 3d808bfd2502 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rqkYK-0000ge-12;
	Sun, 31 Mar 2024 02:04:08 +0000
Date: Sun, 31 Mar 2024 10:03:08 +0800
From: kernel test robot <lkp@intel.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 17/19] PCI: rockchip-ep: Improve link training
Message-ID: <202403310925.C7WNNuAl-lkp@intel.com>
References: <20240329090945.1097609-18-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329090945.1097609-18-dlemoal@kernel.org>

Hi Damien,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/next]
[also build test WARNING on pci/for-linus mani-mhi/mhi-next linus/master v6.9-rc1 next-20240328]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Damien-Le-Moal/PCI-endpoint-Introduce-pci_epc_check_func/20240329-171158
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20240329090945.1097609-18-dlemoal%40kernel.org
patch subject: [PATCH 17/19] PCI: rockchip-ep: Improve link training
config: arc-randconfig-001-20240330 (https://download.01.org/0day-ci/archive/20240331/202403310925.C7WNNuAl-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240331/202403310925.C7WNNuAl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403310925.C7WNNuAl-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/pci/controller/pcie-rockchip-ep.c:54: warning: Function parameter or struct member 'link_training' not described in 'rockchip_pcie_ep'


vim +54 drivers/pci/controller/pcie-rockchip-ep.c

cf590b07839133 drivers/pci/host/pcie-rockchip-ep.c       Shawn Lin           2018-05-09  23  
cf590b07839133 drivers/pci/host/pcie-rockchip-ep.c       Shawn Lin           2018-05-09  24  /**
cf590b07839133 drivers/pci/host/pcie-rockchip-ep.c       Shawn Lin           2018-05-09  25   * struct rockchip_pcie_ep - private data for PCIe endpoint controller driver
cf590b07839133 drivers/pci/host/pcie-rockchip-ep.c       Shawn Lin           2018-05-09  26   * @rockchip: Rockchip PCIe controller
9b41d19aff4090 drivers/pci/controller/pcie-rockchip-ep.c Krzysztof Kozlowski 2020-07-29  27   * @epc: PCI EPC device
cf590b07839133 drivers/pci/host/pcie-rockchip-ep.c       Shawn Lin           2018-05-09  28   * @max_regions: maximum number of regions supported by hardware
cf590b07839133 drivers/pci/host/pcie-rockchip-ep.c       Shawn Lin           2018-05-09  29   * @ob_region_map: bitmask of mapped outbound regions
cf590b07839133 drivers/pci/host/pcie-rockchip-ep.c       Shawn Lin           2018-05-09  30   * @ob_addr: base addresses in the AXI bus where the outbound regions start
5815c2d17a7492 drivers/pci/controller/pcie-rockchip-ep.c Damien Le Moal      2023-11-22  31   * @irq_phys_addr: base address on the AXI bus where the MSI/INTX IRQ
cf590b07839133 drivers/pci/host/pcie-rockchip-ep.c       Shawn Lin           2018-05-09  32   *		   dedicated outbound regions is mapped.
cf590b07839133 drivers/pci/host/pcie-rockchip-ep.c       Shawn Lin           2018-05-09  33   * @irq_cpu_addr: base address in the CPU space where a write access triggers
5815c2d17a7492 drivers/pci/controller/pcie-rockchip-ep.c Damien Le Moal      2023-11-22  34   *		  the sending of a memory write (MSI) / normal message (INTX
cf590b07839133 drivers/pci/host/pcie-rockchip-ep.c       Shawn Lin           2018-05-09  35   *		  IRQ) TLP through the PCIe bus.
5815c2d17a7492 drivers/pci/controller/pcie-rockchip-ep.c Damien Le Moal      2023-11-22  36   * @irq_pci_addr: used to save the current mapping of the MSI/INTX IRQ
cf590b07839133 drivers/pci/host/pcie-rockchip-ep.c       Shawn Lin           2018-05-09  37   *		  dedicated outbound region.
cf590b07839133 drivers/pci/host/pcie-rockchip-ep.c       Shawn Lin           2018-05-09  38   * @irq_pci_fn: the latest PCI function that has updated the mapping of
5815c2d17a7492 drivers/pci/controller/pcie-rockchip-ep.c Damien Le Moal      2023-11-22  39   *		the MSI/INTX IRQ dedicated outbound region.
5815c2d17a7492 drivers/pci/controller/pcie-rockchip-ep.c Damien Le Moal      2023-11-22  40   * @irq_pending: bitmask of asserted INTX IRQs.
cf590b07839133 drivers/pci/host/pcie-rockchip-ep.c       Shawn Lin           2018-05-09  41   */
cf590b07839133 drivers/pci/host/pcie-rockchip-ep.c       Shawn Lin           2018-05-09  42  struct rockchip_pcie_ep {
cf590b07839133 drivers/pci/host/pcie-rockchip-ep.c       Shawn Lin           2018-05-09  43  	struct rockchip_pcie	rockchip;
cf590b07839133 drivers/pci/host/pcie-rockchip-ep.c       Shawn Lin           2018-05-09  44  	struct pci_epc		*epc;
cf590b07839133 drivers/pci/host/pcie-rockchip-ep.c       Shawn Lin           2018-05-09  45  	u32			max_regions;
cf590b07839133 drivers/pci/host/pcie-rockchip-ep.c       Shawn Lin           2018-05-09  46  	unsigned long		ob_region_map;
cf590b07839133 drivers/pci/host/pcie-rockchip-ep.c       Shawn Lin           2018-05-09  47  	phys_addr_t		*ob_addr;
cf590b07839133 drivers/pci/host/pcie-rockchip-ep.c       Shawn Lin           2018-05-09  48  	phys_addr_t		irq_phys_addr;
cf590b07839133 drivers/pci/host/pcie-rockchip-ep.c       Shawn Lin           2018-05-09  49  	void __iomem		*irq_cpu_addr;
cf590b07839133 drivers/pci/host/pcie-rockchip-ep.c       Shawn Lin           2018-05-09  50  	u64			irq_pci_addr;
cf590b07839133 drivers/pci/host/pcie-rockchip-ep.c       Shawn Lin           2018-05-09  51  	u8			irq_pci_fn;
cf590b07839133 drivers/pci/host/pcie-rockchip-ep.c       Shawn Lin           2018-05-09  52  	u8			irq_pending;
9bd13985625aa9 drivers/pci/controller/pcie-rockchip-ep.c Damien Le Moal      2024-03-29  53  	struct delayed_work	link_training;
cf590b07839133 drivers/pci/host/pcie-rockchip-ep.c       Shawn Lin           2018-05-09 @54  };
cf590b07839133 drivers/pci/host/pcie-rockchip-ep.c       Shawn Lin           2018-05-09  55  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

