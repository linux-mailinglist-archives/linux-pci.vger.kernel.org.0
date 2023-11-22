Return-Path: <linux-pci+bounces-130-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E10ED7F494C
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 15:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C55EB20B63
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 14:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4865A208BE;
	Wed, 22 Nov 2023 14:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k/Q0WXBv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20484DD;
	Wed, 22 Nov 2023 06:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700664546; x=1732200546;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xfM2rHlddJWb6LuHvIur/k83wR9tmmt10e5ezN6jTtk=;
  b=k/Q0WXBvKVvjSWJhRBRNtg46X8fh594q0xR4QB2KyzyVUFPSOhK3vW/Q
   4me32ENVyYk7hxAw6VCkRxjK7fCOwQjiau0kVK5jgLtf4DB2JvJXNLOIj
   a2d4qn26ivUTF83Jgo+4nhAsOkb4DKzoZ8UAEjvU3XYS4o80D1PoVpKAd
   I3IZwfL5o889jh3hy20hruSrOl8F1CwCACEtxvc0t5L9ucoCoQPeR8gt4
   erq3S/aE7sOYOJH+VchAj5rzbD+/AfnVrGDVvNxAHUayRgzve8ri1XmyN
   iu3MGlwlnN0T0Trqq2FaIlqByRt/tRyctcl4LAdzeIHjXcwYA4iWszukJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="478269604"
X-IronPort-AV: E=Sophos;i="6.04,219,1695711600"; 
   d="scan'208";a="478269604"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 06:49:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,219,1695711600"; 
   d="scan'208";a="15284525"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 22 Nov 2023 06:49:02 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r5oXD-0000ZL-2T;
	Wed, 22 Nov 2023 14:48:59 +0000
Date: Wed, 22 Nov 2023 22:48:44 +0800
From: kernel test robot <lkp@intel.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	ryder.lee@mediatek.com, jianjun.wang@mediatek.com,
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com, linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2] PCI: mediatek: Fix sparse warning caused to
 virt_to_phys() prototype change
Message-ID: <202311221830.SR5dv3X7-lkp@intel.com>
References: <170052491316.21557.13173111699965824301.stgit@skinsburskii.>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170052491316.21557.13173111699965824301.stgit@skinsburskii.>

Hi Stanislav,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/next]
[also build test ERROR on pci/for-linus linus/master v6.7-rc2 next-20231122]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Stanislav-Kinsburskii/PCI-mediatek-Fix-sparse-warning-caused-to-virt_to_phys-prototype-change/20231121-080253
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/170052491316.21557.13173111699965824301.stgit%40skinsburskii.
patch subject: [PATCH v2] PCI: mediatek: Fix sparse warning caused to virt_to_phys() prototype change
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20231122/202311221830.SR5dv3X7-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231122/202311221830.SR5dv3X7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311221830.SR5dv3X7-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/pci/controller/pcie-mediatek.c:400:22: error: passing 'const void *' to parameter of type 'volatile void *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
           addr = virt_to_phys((__force const void *)port->base + PCIE_MSI_VECTOR);
                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/include/asm/io.h:128:55: note: passing argument to parameter 'address' here
   static inline phys_addr_t virt_to_phys(volatile void *address)
                                                         ^
   drivers/pci/controller/pcie-mediatek.c:523:26: error: passing 'const void *' to parameter of type 'volatile void *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
           msg_addr = virt_to_phys((__force const void *)port->base + PCIE_MSI_VECTOR);
                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/include/asm/io.h:128:55: note: passing argument to parameter 'address' here
   static inline phys_addr_t virt_to_phys(volatile void *address)
                                                         ^
   2 errors generated.


vim +400 drivers/pci/controller/pcie-mediatek.c

   393	
   394	static void mtk_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
   395	{
   396		struct mtk_pcie_port *port = irq_data_get_irq_chip_data(data);
   397		phys_addr_t addr;
   398	
   399		/* MT2712/MT7622 only support 32-bit MSI addresses */
 > 400		addr = virt_to_phys((__force const void *)port->base + PCIE_MSI_VECTOR);
   401		msg->address_hi = 0;
   402		msg->address_lo = lower_32_bits(addr);
   403	
   404		msg->data = data->hwirq;
   405	
   406		dev_dbg(port->pcie->dev, "msi#%d address_hi %#x address_lo %#x\n",
   407			(int)data->hwirq, msg->address_hi, msg->address_lo);
   408	}
   409	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

