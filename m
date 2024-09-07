Return-Path: <linux-pci+bounces-12919-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FDAA97011A
	for <lists+linux-pci@lfdr.de>; Sat,  7 Sep 2024 11:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EFE2284CE6
	for <lists+linux-pci@lfdr.de>; Sat,  7 Sep 2024 09:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039ED157464;
	Sat,  7 Sep 2024 09:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YsKBdWba"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF871156F54;
	Sat,  7 Sep 2024 09:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725699622; cv=none; b=I/R4I8YrosYHzvxSZ0/Hmn1hSiKXjv87IOjA4m5ejG8z9APhVTFAX2k3vR1+STARdM22he62bug27peoS7XXsEFGVusKTN0Lyn/txTl57a41wiWFd4vlyZUd+bsa5sfUd0ygRfYpzqg37tC53aMjQpfYQjZ3GooVi1yXQXInaSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725699622; c=relaxed/simple;
	bh=6xUVK8UOnr4bE4Bt9eFSpUkiD1n9zqEkoHF7lQKcHtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PqLVz/h5CrcI3tt+hfsWLAvKFC8WB2ZEC2Nr/gnFfdeBxjxFjbRHsjwsRSeGZj5UCaJnBksT1ACo8RQ4kKdFJh7cCtQ8Ty4zhh9Oy4REncrE3nhC6dB7GabtMFKIt/sbGScf/ukPTWyqMoRxbMxKaygSgV9L/y2DpU3vuTOsjlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YsKBdWba; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725699620; x=1757235620;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6xUVK8UOnr4bE4Bt9eFSpUkiD1n9zqEkoHF7lQKcHtU=;
  b=YsKBdWbaFOWnMSK8ro1kr9onu2hi1cBUGHjrPH2cwAqtbTN4uvAUUHLX
   wfnapQZyMctJ5HVEkoJ5+DHYofbjfLwn/jHdsbT2p+2+qb7jbXIjvzy+j
   phvYklioAaSi4+TaKav4NG3Fhs9M+JBYkUqI5ykL3ofVp9/FIvkfRTRAg
   4MPUi6Lzkm2dC2Wgb+oj2CwbaAWDhdWjeBl0b/+bFkE/+P/nkfMgICGdd
   /PSVrIFClG7/N9s2qPx5YxrnIwH04opL9E+mikPDuBLIQ2dfP9TkeU10/
   mwZs+JU3XSvhPgsqaybu30pN2kIdyV8+faZD9EhBpDtOj9vjLsbkJIMS9
   A==;
X-CSE-ConnectionGUID: HPcp9UTJRAO8bXgx+Dac7Q==
X-CSE-MsgGUID: MIp/kCIbTdCaHEzwFwCFAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11187"; a="13419807"
X-IronPort-AV: E=Sophos;i="6.10,210,1719903600"; 
   d="scan'208";a="13419807"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2024 02:00:19 -0700
X-CSE-ConnectionGUID: MzKeS3hURTy73GQ6dJ33Cw==
X-CSE-MsgGUID: rKs/QFGfQF6WRi8qZtkjEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,210,1719903600"; 
   d="scan'208";a="96886535"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 07 Sep 2024 02:00:11 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1smrIc-000CMN-2G;
	Sat, 07 Sep 2024 09:00:06 +0000
Date: Sat, 7 Sep 2024 17:00:04 +0800
From: kernel test robot <lkp@intel.com>
To: Thippeswamy Havalige <thippesw@amd.com>,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	linux-pci@vger.kernel.org, bhelgaas@google.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	bharat.kumar.gogada@amd.com, michal.simek@amd.com,
	lpieralisi@kernel.org, kw@linux.com,
	Thippeswamy Havalige <thippesw@amd.com>
Subject: Re: [PATCH 2/2] PCI: xilinx-cpm: Add support for Versal CPM5 Root
 Port controller-1
Message-ID: <202409071635.vNwvSZtg-lkp@intel.com>
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
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20240907/202409071635.vNwvSZtg-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 05f5a91d00b02f4369f46d076411c700755ae041)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240907/202409071635.vNwvSZtg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409071635.vNwvSZtg-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/pci/controller/pcie-xilinx-cpm.c:10:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/s390/include/asm/io.h:93:
   include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     548 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     561 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
         |                                                           ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
     102 | #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
         |                                                      ^
   In file included from drivers/pci/controller/pcie-xilinx-cpm.c:10:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/s390/include/asm/io.h:93:
   include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     574 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
         |                                                           ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
     115 | #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
         |                                                      ^
   In file included from drivers/pci/controller/pcie-xilinx-cpm.c:10:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/s390/include/asm/io.h:93:
   include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     585 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     595 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     605 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:693:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     693 |         readsb(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:701:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     701 |         readsw(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:709:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     709 |         readsl(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:718:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     718 |         writesb(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:727:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     727 |         writesw(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:736:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     736 |         writesl(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   In file included from drivers/pci/controller/pcie-xilinx-cpm.c:10:
   In file included from include/linux/irq.h:591:
   In file included from arch/s390/include/asm/hw_irq.h:6:
   In file included from include/linux/pci.h:37:
   In file included from include/linux/device.h:32:
   In file included from include/linux/device/driver.h:21:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:181:
   In file included from arch/s390/include/asm/mmu_context.h:11:
   In file included from arch/s390/include/asm/pgalloc.h:18:
   In file included from include/linux/mm.h:2228:
   include/linux/vmstat.h:500:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     500 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     501 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:507:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     507 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     508 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:519:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     519 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     520 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:528:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     528 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     529 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> drivers/pci/controller/pcie-xilinx-cpm.c:292:37: error: use of undeclared identifier 'CPM5_HOST1'
     292 |         else if (port->variant->version == CPM5_HOST1) {
         |                                            ^
   drivers/pci/controller/pcie-xilinx-cpm.c:504:37: error: use of undeclared identifier 'CPM5_HOST1'
     504 |         else if (port->variant->version == CPM5_HOST1) {
         |                                            ^
   drivers/pci/controller/pcie-xilinx-cpm.c:636:13: error: use of undeclared identifier 'CPM5_HOST1'
     636 |         .version = CPM5_HOST1,
         |                    ^
>> drivers/pci/controller/pcie-xilinx-cpm.c:650:12: error: use of undeclared identifier 'cpm5_host1'; did you mean 'cpm5_host'?
     650 |                 .data = &cpm5_host1,
         |                          ^~~~~~~~~~
         |                          cpm5_host
   drivers/pci/controller/pcie-xilinx-cpm.c:635:40: note: 'cpm5_host' declared here
     635 | static const struct xilinx_cpm_variant cpm5_host = {
         |                                        ^
   17 warnings and 4 errors generated.


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

