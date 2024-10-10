Return-Path: <linux-pci+bounces-14212-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA62998E11
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 19:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7680D1C245EB
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 17:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF9419C556;
	Thu, 10 Oct 2024 17:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G9+VaxTK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7828519ABC3;
	Thu, 10 Oct 2024 17:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728580234; cv=none; b=H4vte12PWd1YVzT5iWSxAOmppVJHSOc2LmFDtyV6vJcUBcV0cOag2N99QrmTbMmA7esJN6ylTFxJIdsCVts2/qUrtGI4W7jzZqtHTBz1q4m/ifyzGJUR//yqNDDNnRtNiXYNsm+3GAERZgLoB2UV74RH1TV4JrCfiYou/LO3pBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728580234; c=relaxed/simple;
	bh=LKzg2xvYGT+aj/zGDlwFx/Y6GeQriTDfR72/HvFVDpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g0JwiIUvRvdBpH+xNm9s18xIWM/86ojvQbvcQMMUnG0lfKxkQobJzX9ejf4vHuRpNItEfjtdrHPbrXKAlN7yZb307MXAbzZ3UFMNCvmK+m4ihI1ivR2PYnTlXZOhAe33jrudujb0akVVXuqLQV3icRs4/3HMWenR1DijeOR4SUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G9+VaxTK; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728580231; x=1760116231;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LKzg2xvYGT+aj/zGDlwFx/Y6GeQriTDfR72/HvFVDpk=;
  b=G9+VaxTKUvRz4SR0R5umSQrD+nTR1azqccFXJlKT7w3di8NEonMW747z
   yaK/JclbFpxWMgIOlnYkY9Dr8XK7QEEOGn2RF4+jkC9VK/TLLGCQUp7d2
   qYmXt89dLvFla/zZbqPWeghLdTNigflgZtByNXAD9vQnXB1wxA4w2PVME
   0cmi0k8bOicnyzCflWxy64O0YEUZTECegcKqknq7eXnA5rGg320oObdBf
   N0q9gkLzm3Es+d4dZCjUS0OWv9qdCHlYWh84+bfAqMsNrHxTQP5pIcbfA
   0Mz/ig/qTnb1zBHq9hzhfOYvEn7/n4gtFDaYzQldt9ONfBJzv2jdkHIco
   w==;
X-CSE-ConnectionGUID: wRc6fN0QQWy5e3I7z3rM+g==
X-CSE-MsgGUID: 6xDsbrtWQYmmEfEjo/YGUg==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="31750276"
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="31750276"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 10:10:31 -0700
X-CSE-ConnectionGUID: ithkfGpeTg+4UmbNz26Y9g==
X-CSE-MsgGUID: W6eJiQsxQNCIh6d+i0WYow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="76581573"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 10 Oct 2024 10:10:26 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sywgB-000B3z-1r;
	Thu, 10 Oct 2024 17:10:23 +0000
Date: Fri, 11 Oct 2024 01:10:20 +0800
From: kernel test robot <lkp@intel.com>
To: Wei Fang <wei.fang@nxp.com>, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, vladimir.oltean@nxp.com,
	claudiu.manoil@nxp.com, xiaoning.wang@nxp.com, Frank.Li@nxp.com,
	christophe.leroy@csgroup.eu, linux@armlinux.org.uk,
	bhelgaas@google.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	imx@lists.linux.dev, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH net-next 05/11] net: enetc: add enetc-pf-common driver
 support
Message-ID: <202410110019.xUSLtcAC-lkp@intel.com>
References: <20241009095116.147412-6-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009095116.147412-6-wei.fang@nxp.com>

Hi Wei,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Wei-Fang/dt-bindings-net-add-compatible-string-for-i-MX95-EMDIO/20241009-181113
base:   net-next/main
patch link:    https://lore.kernel.org/r/20241009095116.147412-6-wei.fang%40nxp.com
patch subject: [PATCH net-next 05/11] net: enetc: add enetc-pf-common driver support
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20241011/202410110019.xUSLtcAC-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 70e0a7e7e6a8541bcc46908c592eed561850e416)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241011/202410110019.xUSLtcAC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410110019.xUSLtcAC-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/net/ethernet/freescale/enetc/enetc_pf_common.c:3:
   In file included from include/linux/fsl/enetc_mdio.h:7:
   In file included from include/linux/phy.h:16:
   In file included from include/linux/ethtool.h:18:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:10:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from drivers/net/ethernet/freescale/enetc/enetc_pf_common.c:3:
   In file included from include/linux/fsl/enetc_mdio.h:7:
   In file included from include/linux/phy.h:16:
   In file included from include/linux/ethtool.h:18:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     548 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     561 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from drivers/net/ethernet/freescale/enetc/enetc_pf_common.c:3:
   In file included from include/linux/fsl/enetc_mdio.h:7:
   In file included from include/linux/phy.h:16:
   In file included from include/linux/ethtool.h:18:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     574 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from drivers/net/ethernet/freescale/enetc/enetc_pf_common.c:3:
   In file included from include/linux/fsl/enetc_mdio.h:7:
   In file included from include/linux/phy.h:16:
   In file included from include/linux/ethtool.h:18:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     585 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     595 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     605 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   In file included from drivers/net/ethernet/freescale/enetc/enetc_pf_common.c:3:
>> include/linux/fsl/enetc_mdio.h:62:18: warning: no previous prototype for function 'enetc_hw_alloc' [-Wmissing-prototypes]
      62 | struct enetc_hw *enetc_hw_alloc(struct device *dev, void __iomem *port_regs)
         |                  ^
   include/linux/fsl/enetc_mdio.h:62:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
      62 | struct enetc_hw *enetc_hw_alloc(struct device *dev, void __iomem *port_regs)
         | ^
         | static 
   8 warnings generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for MODVERSIONS
   Depends on [n]: MODULES [=y] && !COMPILE_TEST [=y]
   Selected by [y]:
   - RANDSTRUCT_FULL [=y] && (CC_HAS_RANDSTRUCT [=y] || GCC_PLUGINS [=n]) && MODULES [=y]
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [m]:
   - RESOURCE_KUNIT_TEST [=m] && RUNTIME_TESTING_MENU [=y] && KUNIT [=m]


vim +/enetc_hw_alloc +62 include/linux/fsl/enetc_mdio.h

6517798dd3432a Claudiu Manoil 2020-01-06  49  
80e87442e69ba8 Andrew Lunn    2023-01-12  50  static inline int enetc_mdio_read_c22(struct mii_bus *bus, int phy_id,
80e87442e69ba8 Andrew Lunn    2023-01-12  51  				      int regnum)
6517798dd3432a Claudiu Manoil 2020-01-06  52  { return -EINVAL; }
80e87442e69ba8 Andrew Lunn    2023-01-12  53  static inline int enetc_mdio_write_c22(struct mii_bus *bus, int phy_id,
80e87442e69ba8 Andrew Lunn    2023-01-12  54  				       int regnum, u16 value)
80e87442e69ba8 Andrew Lunn    2023-01-12  55  { return -EINVAL; }
80e87442e69ba8 Andrew Lunn    2023-01-12  56  static inline int enetc_mdio_read_c45(struct mii_bus *bus, int phy_id,
80e87442e69ba8 Andrew Lunn    2023-01-12  57  				      int devad, int regnum)
80e87442e69ba8 Andrew Lunn    2023-01-12  58  { return -EINVAL; }
80e87442e69ba8 Andrew Lunn    2023-01-12  59  static inline int enetc_mdio_write_c45(struct mii_bus *bus, int phy_id,
80e87442e69ba8 Andrew Lunn    2023-01-12  60  				       int devad, int regnum, u16 value)
6517798dd3432a Claudiu Manoil 2020-01-06  61  { return -EINVAL; }
6517798dd3432a Claudiu Manoil 2020-01-06 @62  struct enetc_hw *enetc_hw_alloc(struct device *dev, void __iomem *port_regs)
6517798dd3432a Claudiu Manoil 2020-01-06  63  { return ERR_PTR(-EINVAL); }
6517798dd3432a Claudiu Manoil 2020-01-06  64  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

