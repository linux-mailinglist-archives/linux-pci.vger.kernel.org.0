Return-Path: <linux-pci+bounces-12916-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77CFB97004A
	for <lists+linux-pci@lfdr.de>; Sat,  7 Sep 2024 08:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BE6DB22A80
	for <lists+linux-pci@lfdr.de>; Sat,  7 Sep 2024 06:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3BF7E59A;
	Sat,  7 Sep 2024 06:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iwEff2QT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3971B819;
	Sat,  7 Sep 2024 06:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725689799; cv=none; b=MalQ/ait8Mhp50OwHIWt/ckZLZY8XcmPlG7XzvNmSrpdnp5/ONTbmukR2pFYMaD7+txn6nmueJ1IyxhP1jJIKp9Nu4JEMmLRHj5Mv77kaf8ueMd/o75b0F604fYVyslhy5YE2OFjhVnLVh0GJlbnL44Cz1BtqyTqLvANykQzm5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725689799; c=relaxed/simple;
	bh=4/pmOwkHsvDS28u1eab2x3LlPPbazNatOexhtKCxpt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A1nBjUWyBsIdh/OYLho6hOn8wfi/PxUqWPi1FY9SDL4n+YUVaHjfy9HZbOkNSDd3JMefap7H3ZrSg9gN1NiSotGQsl4DN3Ew4wnkBzH6vjBMRcBWNKIA+AWV915TYtfUBcxX0UTGzZVQH9yBFjAYSNnNoS8DenrtKB24ZCJsKdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iwEff2QT; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725689798; x=1757225798;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4/pmOwkHsvDS28u1eab2x3LlPPbazNatOexhtKCxpt4=;
  b=iwEff2QTNbWhgaXCJN5mfyL8oG4EpszaGryPFGiWKqbpBTRYuXWmXwci
   /B3pKzu/sY+MFkTlHlz8sXh88/Lm9AFVAUzN3HZS0D+zvKB3BUYYL88A5
   3ndCOCABc7BkBQxkTOKItC88sWaRN4lwUSZlv+83FwIrWNr6nsO8PgDbp
   ImZPzlcJFsfeFfo3MKYzWF9+JiWG68CcLluilvF4T8YGMyh5rZITWUngp
   KLAgbTd1q03ASUdUtWa9mXC56NR/vCU9QRIFWL27qNOg0Ctm6+mh/bTio
   r30EwrI4Fa+LZcCBDWmSvmN/FsUI4OrYf8VJngASwMvSTugR9Ch1LFFH9
   A==;
X-CSE-ConnectionGUID: r7htrl3oQrOtgR95f12hvw==
X-CSE-MsgGUID: 5Dyu14RsRoqhNF9G6P9ULQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11187"; a="24249556"
X-IronPort-AV: E=Sophos;i="6.10,210,1719903600"; 
   d="scan'208";a="24249556"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 23:16:37 -0700
X-CSE-ConnectionGUID: SNZuxHtYRPSOvfznDo14vg==
X-CSE-MsgGUID: NS3+0j0WQK+rB7qxA6dzaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,210,1719903600"; 
   d="scan'208";a="70280677"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 06 Sep 2024 23:16:33 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1smokI-000CAh-3C;
	Sat, 07 Sep 2024 06:16:30 +0000
Date: Sat, 7 Sep 2024 14:15:53 +0800
From: kernel test robot <lkp@intel.com>
To: Thippeswamy Havalige <thippesw@amd.com>,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	linux-pci@vger.kernel.org, bhelgaas@google.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, bharat.kumar.gogada@amd.com,
	michal.simek@amd.com, lpieralisi@kernel.org, kw@linux.com,
	Thippeswamy Havalige <thippesw@amd.com>
Subject: Re: [PATCH 2/2] PCI: xilinx-cpm: Add support for Versal CPM5 Root
 Port controller-1
Message-ID: <202409071415.6WivnBm0-lkp@intel.com>
References: <20240906093148.830452-3-thippesw@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906093148.830452-3-thippesw@amd.com>

Hi Thippeswamy,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/next]
[also build test ERROR on pci/for-linus mani-mhi/mhi-next robh/for-next linus/master v6.11-rc6 next-20240906]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Thippeswamy-Havalige/dt-bindings-PCI-xilinx-cpm-Add-compatible-string-for-CPM5-controller-1/20240906-173446
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20240906093148.830452-3-thippesw%40amd.com
patch subject: [PATCH 2/2] PCI: xilinx-cpm: Add support for Versal CPM5 Root Port controller-1
config: alpha-randconfig-r051-20240907 (https://download.01.org/0day-ci/archive/20240907/202409071415.6WivnBm0-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240907/202409071415.6WivnBm0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409071415.6WivnBm0-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/pci/controller/pcie-xilinx-cpm.c: In function 'xilinx_cpm_pcie_event_flow':
>> drivers/pci/controller/pcie-xilinx-cpm.c:292:44: error: 'CPM5_HOST1' undeclared (first use in this function)
     292 |         else if (port->variant->version == CPM5_HOST1) {
         |                                            ^~~~~~~~~~
   drivers/pci/controller/pcie-xilinx-cpm.c:292:44: note: each undeclared identifier is reported only once for each function it appears in
   drivers/pci/controller/pcie-xilinx-cpm.c: In function 'xilinx_cpm_pcie_init_port':
   drivers/pci/controller/pcie-xilinx-cpm.c:504:44: error: 'CPM5_HOST1' undeclared (first use in this function)
     504 |         else if (port->variant->version == CPM5_HOST1) {
         |                                            ^~~~~~~~~~
   drivers/pci/controller/pcie-xilinx-cpm.c: At top level:
>> drivers/pci/controller/pcie-xilinx-cpm.c:635:40: error: redefinition of 'cpm5_host'
     635 | static const struct xilinx_cpm_variant cpm5_host = {
         |                                        ^~~~~~~~~
   drivers/pci/controller/pcie-xilinx-cpm.c:631:40: note: previous definition of 'cpm5_host' with type 'const struct xilinx_cpm_variant'
     631 | static const struct xilinx_cpm_variant cpm5_host = {
         |                                        ^~~~~~~~~
>> drivers/pci/controller/pcie-xilinx-cpm.c:636:20: error: 'CPM5_HOST1' undeclared here (not in a function)
     636 |         .version = CPM5_HOST1,
         |                    ^~~~~~~~~~
>> drivers/pci/controller/pcie-xilinx-cpm.c:650:26: error: 'cpm5_host1' undeclared here (not in a function); did you mean 'cpm5_host'?
     650 |                 .data = &cpm5_host1,
         |                          ^~~~~~~~~~
         |                          cpm5_host


vim +/CPM5_HOST1 +292 drivers/pci/controller/pcie-xilinx-cpm.c

   270	
   271	static void xilinx_cpm_pcie_event_flow(struct irq_desc *desc)
   272	{
   273		struct xilinx_cpm_pcie *port = irq_desc_get_handler_data(desc);
   274		struct irq_chip *chip = irq_desc_get_chip(desc);
   275		unsigned long val;
   276		int i;
   277	
   278		chained_irq_enter(chip, desc);
   279		val =  pcie_read(port, XILINX_CPM_PCIE_REG_IDR);
   280		val &= pcie_read(port, XILINX_CPM_PCIE_REG_IMR);
   281		for_each_set_bit(i, &val, 32)
   282			generic_handle_domain_irq(port->cpm_domain, i);
   283		pcie_write(port, val, XILINX_CPM_PCIE_REG_IDR);
   284	
   285		if (port->variant->version == CPM5) {
   286			val = readl_relaxed(port->cpm_base + XILINX_CPM_PCIE0_IR_STATUS);
   287			if (val)
   288				writel_relaxed(val, port->cpm_base +
   289						    XILINX_CPM_PCIE0_IR_STATUS);
   290		}
   291	
 > 292		else if (port->variant->version == CPM5_HOST1) {
   293			val = readl_relaxed(port->cpm_base + XILINX_CPM_PCIE1_IR_STATUS);
   294			if (val)
   295				writel_relaxed(val, port->cpm_base +
   296						    XILINX_CPM_PCIE1_IR_STATUS);
   297		}
   298	
   299		/*
   300		 * XILINX_CPM_PCIE_MISC_IR_STATUS register is mapped to
   301		 * CPM SLCR block.
   302		 */
   303		val = readl_relaxed(port->cpm_base + XILINX_CPM_PCIE_MISC_IR_STATUS);
   304		if (val)
   305			writel_relaxed(val,
   306				       port->cpm_base + XILINX_CPM_PCIE_MISC_IR_STATUS);
   307	
   308		chained_irq_exit(chip, desc);
   309	}
   310	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

