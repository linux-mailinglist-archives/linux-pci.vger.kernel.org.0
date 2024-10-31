Return-Path: <linux-pci+bounces-15761-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6F79B862C
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 23:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEB641C20E0A
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 22:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2C619F430;
	Thu, 31 Oct 2024 22:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PZmsAdfT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A570A1CB53B;
	Thu, 31 Oct 2024 22:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730414462; cv=none; b=IUIKnknBEim/Rr8tyxfMWKyBzWzuogvVhQU4vJwbzU4XiSu5rhRmiQ5Sr5dE0VttSbO+RprbKKwd8awPF6Ki7yATvYkVwf3ArALMILO5e9sfbOnlSBMV0h4apNcqnzezIrEps2Vn8+quQcwFT/Nk+DFIVYzxhOizIxVRO1gCjkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730414462; c=relaxed/simple;
	bh=TtX246/7V9tXd0BN+YUjyWwj/a3VQ2j7RYCFTjdfKgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vCR2cQlAqwZTcOzhHn/vNMYuSiKGDoAb2kuKnyRUX6HvHwBkOzXvjl6fXbi6BL7RAK3vay/zBa6mrKoDqzxznhWsQegdq8qtwu6KVD8Crcy794Ynbi55IGP2G0oalm8rHn6WUjStihXhdxPhp+wp73d5iuJpW1Qg6BN/d3kGdq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PZmsAdfT; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730414457; x=1761950457;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TtX246/7V9tXd0BN+YUjyWwj/a3VQ2j7RYCFTjdfKgs=;
  b=PZmsAdfT3v2IINtcA2aZWBGiFceBZXQkuvFMmxQvSGFwxoxZc87RNNDK
   MqkbBsA6/tLt8NKRpaOwphm5ykHju2lNCo9IqotjwyjfdYCr+SDdClv0a
   kxoQtUzGV/3IA/wqBjP3q++Kg3Q1iujFVBHc6NEb/HerjkqTwF7xq1tiq
   DqoCWr0fU3ho0t0Iv454dp3UTGCFwsaiGAF2KYjO5o8ZZGQNxvQUzaCS9
   Sy5A35iLrvVaRc0PjWMZK7gzDdnpVfGtLKn+r5BVzGcGxEvjnhgXmxgxd
   ePTkFpS3LVPbeEH+8bK9vXoVXjCTwBbO+2fUCjvW4v31VaCMQlOy4ZByc
   w==;
X-CSE-ConnectionGUID: bT1I4m5UR8Wp2ZFJXRQgIw==
X-CSE-MsgGUID: 212Ceag/SK2OXrpj6ftqFg==
X-IronPort-AV: E=McAfee;i="6700,10204,11242"; a="30294386"
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="30294386"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 15:40:56 -0700
X-CSE-ConnectionGUID: wD6CisJHQ06wuSZ12h/+6A==
X-CSE-MsgGUID: NsMJpRFKSGW57UVHodjKJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="120231292"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 31 Oct 2024 15:40:50 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t6dqR-000gnK-1T;
	Thu, 31 Oct 2024 22:40:47 +0000
Date: Fri, 1 Nov 2024 06:39:55 +0800
From: kernel test robot <lkp@intel.com>
To: Richard Zhu <hongxing.zhu@nxp.com>, l.stach@pengutronix.de,
	bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, shawnguo@kernel.org,
	frank.li@nxp.com, s.hauer@pengutronix.de, festevam@gmail.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	imx@lists.linux.dev, kernel@pengutronix.de,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v5 02/10] PCI: imx6: Add ref clock for i.MX95 PCIe
Message-ID: <202411010605.6YPlxVeu-lkp@intel.com>
References: <20241031080655.3879139-3-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031080655.3879139-3-hongxing.zhu@nxp.com>

Hi Richard,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/next]
[also build test WARNING on pci/for-linus shawnguo/for-next mani-mhi/mhi-next linus/master v6.12-rc5 next-20241031]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Richard-Zhu/dt-bindings-imx6q-pcie-Add-ref-clock-for-i-MX95-PCIe-RC/20241031-160000
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20241031080655.3879139-3-hongxing.zhu%40nxp.com
patch subject: [PATCH v5 02/10] PCI: imx6: Add ref clock for i.MX95 PCIe
config: um-allmodconfig (https://download.01.org/0day-ci/archive/20241101/202411010605.6YPlxVeu-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 639a7ac648f1e50ccd2556e17d401c04f9cce625)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241101/202411010605.6YPlxVeu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411010605.6YPlxVeu-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/pci/controller/dwc/pci-imx6.c:21:
   In file included from include/linux/of_address.h:7:
   In file included from include/linux/io.h:14:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     548 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     561 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from drivers/pci/controller/dwc/pci-imx6.c:21:
   In file included from include/linux/of_address.h:7:
   In file included from include/linux/io.h:14:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     574 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from drivers/pci/controller/dwc/pci-imx6.c:21:
   In file included from include/linux/of_address.h:7:
   In file included from include/linux/io.h:14:
   In file included from arch/um/include/asm/io.h:24:
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
   In file included from drivers/pci/controller/dwc/pci-imx6.c:22:
   In file included from include/linux/pci.h:1645:
   In file included from include/linux/dmapool.h:14:
   In file included from include/linux/scatterlist.h:8:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/pci/controller/dwc/pci-imx6.c:1490:27: warning: unused variable 'imx95_ext_osc_clks' [-Wunused-const-variable]
    1490 | static const char * const imx95_ext_osc_clks[] = {"pcie_bus", "pcie", "pcie_phy", "pcie_aux"};
         |                           ^~~~~~~~~~~~~~~~~~
   14 warnings generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for MODVERSIONS
   Depends on [n]: MODULES [=y] && !COMPILE_TEST [=y]
   Selected by [y]:
   - RANDSTRUCT_FULL [=y] && (CC_HAS_RANDSTRUCT [=y] || GCC_PLUGINS [=n]) && MODULES [=y]
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [m]:
   - RESOURCE_KUNIT_TEST [=m] && RUNTIME_TESTING_MENU [=y] && KUNIT [=m]


vim +/imx95_ext_osc_clks +1490 drivers/pci/controller/dwc/pci-imx6.c

  1483	
  1484	static const char * const imx6q_clks[] = {"pcie_bus", "pcie", "pcie_phy"};
  1485	static const char * const imx8mm_clks[] = {"pcie_bus", "pcie", "pcie_aux"};
  1486	static const char * const imx8mq_clks[] = {"pcie_bus", "pcie", "pcie_phy", "pcie_aux"};
  1487	static const char * const imx6sx_clks[] = {"pcie_bus", "pcie", "pcie_phy", "pcie_inbound_axi"};
  1488	static const char * const imx8q_clks[] = {"mstr", "slv", "dbi"};
  1489	static const char * const imx95_clks[] = {"pcie_bus", "pcie", "pcie_phy", "pcie_aux", "ref"};
> 1490	static const char * const imx95_ext_osc_clks[] = {"pcie_bus", "pcie", "pcie_phy", "pcie_aux"};
  1491	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

