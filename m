Return-Path: <linux-pci+bounces-23869-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8526CA632FC
	for <lists+linux-pci@lfdr.de>; Sun, 16 Mar 2025 01:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AC18188F963
	for <lists+linux-pci@lfdr.de>; Sun, 16 Mar 2025 00:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2D820E6;
	Sun, 16 Mar 2025 00:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OCpE9AqQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617624689
	for <linux-pci@vger.kernel.org>; Sun, 16 Mar 2025 00:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742085236; cv=none; b=fPu+VW5vM5/CLUVSCLYZu3SGUhNyRExjeWCEB2U6GBUZPsb81lDdQseEkJ9KTl7+J5eiDRMZ82IuyStjB4La505Z//NQpWg9UqiNSLuuCjAIvgzEi7EB9nrqi2SB0IEaW0GPnd9z2T5B4gjwINwU731g6q2y7nMUeA0zF6rnlI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742085236; c=relaxed/simple;
	bh=ictiBmfjhuy9Efecz/e+z07DHqCdQG2BMd23joPbBAI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FiC9gJ73GxTJaaPFVZ1wAYY2yeBhZYTNFnZhXPedKfpdGFo91GB+7QbbbNAZlJ5ZzZOrLFIi6DJilX+DK9te9GfBcGZ+sGT2Y1XdcbR9C5POxtG7FcEDlmKOYjw7i128IWyM2Z97cQFRAC1JdWjFfcV2nWeBASYAYIAx5rcPKDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OCpE9AqQ; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742085234; x=1773621234;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ictiBmfjhuy9Efecz/e+z07DHqCdQG2BMd23joPbBAI=;
  b=OCpE9AqQFJsqQP5Lnje4GyzbFkz+TzESff5dI+2Vtnak9CUTO3np7By5
   Zz/D7RqF8CZAV1yEkBGTklRmvFEv3nxB+2/xbDMo9ZCrpF8pwUA+puJUA
   nDMk1Eusk5NtUB3aXorog+OxKibXIoprftbIYz6ukGYCLbVfUIZC1lAYq
   1q3U8fEgyX4jHdKIqU0qrQgLxq66eZ0P9XjvlTvjGLBUgd15BsPVCN06+
   C/H4wXU+2RRhWM+xVnxKLMc8q8ZGoGDIdiTdTE2OIU0EFt9FlN/df767C
   P36I5GJ9rovmCKIj8l3W2oGO+T9b0ivvEAluncFG3d01Xs829j1aSlruc
   w==;
X-CSE-ConnectionGUID: jHqxB2/ITj+03+72Aw2ykg==
X-CSE-MsgGUID: Y+B81tnJQQWXqs7/26J9ig==
X-IronPort-AV: E=McAfee;i="6700,10204,11374"; a="53842332"
X-IronPort-AV: E=Sophos;i="6.14,251,1736841600"; 
   d="scan'208";a="53842332"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2025 17:33:53 -0700
X-CSE-ConnectionGUID: TkUG5QVFTDKQPNjGyn3IKw==
X-CSE-MsgGUID: KlV0G66oQ+e4ukoe4nwz5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,251,1736841600"; 
   d="scan'208";a="125801417"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 15 Mar 2025 17:33:52 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ttbwr-000Bjh-2e;
	Sun, 16 Mar 2025 00:33:49 +0000
Date: Sun, 16 Mar 2025 08:33:00 +0800
From: kernel test robot <lkp@intel.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Subject: [pci:controller/dwc-cpu-addr-fixup 6/13]
 drivers/pci/controller/dwc/pcie-designware.c:1135:6: warning: format
 specifies type 'unsigned long long' but the argument has type
 'resource_size_t' (aka 'unsigned int')
Message-ID: <202503160804.HTvWiBze-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc-cpu-addr-fixup
head:   40b96cba38232460c691b52bbf9183f9e4d34914
commit: af175b4797cd4e3e8ff22a4e3c6924443986b797 [6/13] PCI: dwc: Add dw_pcie_parent_bus_offset() checking and debug
config: riscv-randconfig-001-20250316 (https://download.01.org/0day-ci/archive/20250316/202503160804.HTvWiBze-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project 87916f8c32ebd8e284091db9b70339df57fd1e90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250316/202503160804.HTvWiBze-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503160804.HTvWiBze-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/pci/controller/dwc/pcie-designware.c:15:
   In file included from include/linux/dma/edma.h:13:
   In file included from include/linux/dmaengine.h:12:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:804:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     804 |         insb(addr, buffer, count);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:104:53: note: expanded from macro 'insb'
     104 | #define insb(addr, buffer, count) __insb(PCI_IOBASE + (addr), buffer, count)
         |                                          ~~~~~~~~~~ ^
   In file included from drivers/pci/controller/dwc/pcie-designware.c:15:
   In file included from include/linux/dma/edma.h:13:
   In file included from include/linux/dmaengine.h:12:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:812:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     812 |         insw(addr, buffer, count);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:105:53: note: expanded from macro 'insw'
     105 | #define insw(addr, buffer, count) __insw(PCI_IOBASE + (addr), buffer, count)
         |                                          ~~~~~~~~~~ ^
   In file included from drivers/pci/controller/dwc/pcie-designware.c:15:
   In file included from include/linux/dma/edma.h:13:
   In file included from include/linux/dmaengine.h:12:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:820:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     820 |         insl(addr, buffer, count);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:106:53: note: expanded from macro 'insl'
     106 | #define insl(addr, buffer, count) __insl(PCI_IOBASE + (addr), buffer, count)
         |                                          ~~~~~~~~~~ ^
   In file included from drivers/pci/controller/dwc/pcie-designware.c:15:
   In file included from include/linux/dma/edma.h:13:
   In file included from include/linux/dmaengine.h:12:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:829:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     829 |         outsb(addr, buffer, count);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:118:55: note: expanded from macro 'outsb'
     118 | #define outsb(addr, buffer, count) __outsb(PCI_IOBASE + (addr), buffer, count)
         |                                            ~~~~~~~~~~ ^
   In file included from drivers/pci/controller/dwc/pcie-designware.c:15:
   In file included from include/linux/dma/edma.h:13:
   In file included from include/linux/dmaengine.h:12:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:838:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     838 |         outsw(addr, buffer, count);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:119:55: note: expanded from macro 'outsw'
     119 | #define outsw(addr, buffer, count) __outsw(PCI_IOBASE + (addr), buffer, count)
         |                                            ~~~~~~~~~~ ^
   In file included from drivers/pci/controller/dwc/pcie-designware.c:15:
   In file included from include/linux/dma/edma.h:13:
   In file included from include/linux/dmaengine.h:12:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:847:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     847 |         outsl(addr, buffer, count);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:120:55: note: expanded from macro 'outsl'
     120 | #define outsl(addr, buffer, count) __outsl(PCI_IOBASE + (addr), buffer, count)
         |                                            ~~~~~~~~~~ ^
   In file included from drivers/pci/controller/dwc/pcie-designware.c:15:
   In file included from include/linux/dma/edma.h:13:
   In file included from include/linux/dmaengine.h:12:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:1175:55: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
    1175 |         return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
         |                                                   ~~~~~~~~~~ ^
>> drivers/pci/controller/dwc/pcie-designware.c:1135:6: warning: format specifies type 'unsigned long long' but the argument has type 'resource_size_t' (aka 'unsigned int') [-Wformat]
    1134 |                         dev_warn(dev, "%#010llx %s reg[%d] == %#010llx; %ps is redundant\n",
         |                                        ~~~~~~~~
         |                                        %#010x
    1135 |                                  cpu_phy_addr, reg_name, index,
         |                                  ^~~~~~~~~~~~
   include/linux/dev_printk.h:156:70: note: expanded from macro 'dev_warn'
     156 |         dev_printk_index_wrap(_dev_warn, KERN_WARNING, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                                     ~~~     ^~~~~~~~~~~
   include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ~~~    ^~~~~~~~~~~
   drivers/pci/controller/dwc/pcie-designware.c:1139:6: warning: format specifies type 'unsigned long long' but the argument has type 'resource_size_t' (aka 'unsigned int') [-Wformat]
    1138 |                         dev_warn(dev, "%#010llx %s reg[%d] != %#010llx fixed up addr; devicetree is broken\n",
         |                                        ~~~~~~~~
         |                                        %#010x
    1139 |                                  cpu_phy_addr, reg_name,
         |                                  ^~~~~~~~~~~~
   include/linux/dev_printk.h:156:70: note: expanded from macro 'dev_warn'
     156 |         dev_printk_index_wrap(_dev_warn, KERN_WARNING, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                                     ~~~     ^~~~~~~~~~~
   include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ~~~    ^~~~~~~~~~~
   drivers/pci/controller/dwc/pcie-designware.c:1146:6: warning: format specifies type 'unsigned long long' but the argument has type 'resource_size_t' (aka 'unsigned int') [-Wformat]
    1145 |                         dev_warn(dev, "devicetree has incorrect translation; please check parent \"ranges\" property. CPU physical addr %#010llx, parent bus addr %#010llx\n",
         |                                                                                                                                         ~~~~~~~~
         |                                                                                                                                         %#010x
    1146 |                                  cpu_phy_addr, reg_addr);
         |                                  ^~~~~~~~~~~~
   include/linux/dev_printk.h:156:70: note: expanded from macro 'dev_warn'
     156 |         dev_printk_index_wrap(_dev_warn, KERN_WARNING, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                                     ~~~     ^~~~~~~~~~~
   include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ~~~    ^~~~~~~~~~~
   10 warnings generated.


vim +1135 drivers/pci/controller/dwc/pcie-designware.c

  1109	
  1110	resource_size_t dw_pcie_parent_bus_offset(struct dw_pcie *pci,
  1111						  const char *reg_name,
  1112						  resource_size_t cpu_phy_addr)
  1113	{
  1114		struct device *dev = pci->dev;
  1115		struct device_node *np = dev->of_node;
  1116		int index;
  1117		u64 reg_addr, fixup_addr;
  1118		u64 (*fixup)(struct dw_pcie *pcie, u64 cpu_addr);
  1119	
  1120		/* Look up reg_name address on parent bus */
  1121		index = of_property_match_string(np, "reg-names", reg_name);
  1122	
  1123		if (index < 0) {
  1124			dev_err(dev, "No %s in devicetree \"reg\" property\n", reg_name);
  1125			return 0;
  1126		}
  1127	
  1128		of_property_read_reg(np, index, &reg_addr, NULL);
  1129	
  1130		fixup = pci->ops->cpu_addr_fixup;
  1131		if (fixup) {
  1132			fixup_addr = fixup(pci, cpu_phy_addr);
  1133			if (reg_addr == fixup_addr) {
  1134				dev_warn(dev, "%#010llx %s reg[%d] == %#010llx; %ps is redundant\n",
> 1135					 cpu_phy_addr, reg_name, index,

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

