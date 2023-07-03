Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49977745CCE
	for <lists+linux-pci@lfdr.de>; Mon,  3 Jul 2023 15:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbjGCNEa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Jul 2023 09:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjGCNE3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Jul 2023 09:04:29 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B27C7;
        Mon,  3 Jul 2023 06:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688389468; x=1719925468;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oCgpW04UB0T6adNKQaJvNj1k+izTFprGjrj2QXmMcAQ=;
  b=noFtevKFYo24HIL/2G7u35XpJribeN4ISEM8Ur84bERPYdNQoIAqEeor
   f6ZkpCBkb9hbmm9FTrx4zvIzXwY9eLWdmm0BQXwzrWfRXRea4whe2idOV
   6ZpmNOq7F6JQVEAwO+yI7RSu8WUyxNbHCX0lJ0/bsflOmUU0WMTDLFdtI
   pLBXSbcZVFGJFC/ihfbguLk86OXyRb6Buryleu0rtZFKv7sA5sOALPiVY
   lqGfrYVBFqRRItM6bUhqfe5IRqH7C0c75rOYFOgb/kh1+tqEwvQhFC9QG
   H4ahKPUpSz0dY0iRIKug66qo2WMF0V2oC60jI2SVveXjwIgXocLoDts+O
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="449252038"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="449252038"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 06:04:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="808578079"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="808578079"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Jul 2023 06:04:05 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qGJDo-000HNb-0Q;
        Mon, 03 Jul 2023 13:04:04 +0000
Date:   Mon, 3 Jul 2023 21:03:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        alberto.dassatti@heig-vd.ch
Cc:     oe-kbuild-all@lists.linux.dev, dlemoal@kernel.org,
        Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Dan Carpenter <error27@gmail.com>, stable@vger.kernel.org,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: rockchip: Use 64-bit mask on MSI 64-bit PCI
 address
Message-ID: <202307032003.1fpK28pS-lkp@intel.com>
References: <20230703085845.2052008-1-rick.wertenbroek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230703085845.2052008-1-rick.wertenbroek@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rick,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/next]
[also build test WARNING on linus/master next-20230703]
[cannot apply to pci/for-linus v6.4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Rick-Wertenbroek/PCI-rockchip-Use-64-bit-mask-on-MSI-64-bit-PCI-address/20230703-165959
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20230703085845.2052008-1-rick.wertenbroek%40gmail.com
patch subject: [PATCH v2] PCI: rockchip: Use 64-bit mask on MSI 64-bit PCI address
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20230703/202307032003.1fpK28pS-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230703/202307032003.1fpK28pS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307032003.1fpK28pS-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/bitops.h:6,
                    from include/linux/log2.h:12,
                    from include/asm-generic/div64.h:55,
                    from arch/arm/include/asm/div64.h:107,
                    from include/linux/math.h:6,
                    from include/linux/math64.h:6,
                    from include/linux/time.h:6,
                    from include/linux/stat.h:19,
                    from include/linux/configfs.h:22,
                    from drivers/pci/controller/pcie-rockchip-ep.c:11:
   drivers/pci/controller/pcie-rockchip-ep.c: In function 'rockchip_pcie_prog_ep_ob_atu':
>> include/linux/bits.h:35:18: warning: right shift count is negative [-Wshift-count-negative]
      35 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
         |                  ^~
   include/linux/bits.h:37:38: note: in expansion of macro '__GENMASK'
      37 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/pci/controller/pcie-rockchip.h:163:41: note: in expansion of macro 'GENMASK'
     163 | #define PCIE_ADDR_MASK                  GENMASK(63, MIN_AXI_ADDR_BITS_PASSED)
         |                                         ^~~~~~~
   drivers/pci/controller/pcie-rockchip.h:167:49: note: in expansion of macro 'PCIE_ADDR_MASK'
     167 | #define   PCIE_CORE_OB_REGION_ADDR0_LO_ADDR     PCIE_ADDR_MASK
         |                                                 ^~~~~~~~~~~~~~
   drivers/pci/controller/pcie-rockchip-ep.c:77:44: note: in expansion of macro 'PCIE_CORE_OB_REGION_ADDR0_LO_ADDR'
      77 |                 (lower_32_bits(pci_addr) & PCIE_CORE_OB_REGION_ADDR0_LO_ADDR);
         |                                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/asm-generic/div64.h:27:
   drivers/pci/controller/pcie-rockchip-ep.c: In function 'rockchip_pcie_ep_send_msi_irq':
>> include/linux/bits.h:35:18: warning: right shift count is negative [-Wshift-count-negative]
      35 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
         |                  ^~
   include/linux/compiler.h:78:45: note: in definition of macro 'unlikely'
      78 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   include/linux/bits.h:37:38: note: in expansion of macro '__GENMASK'
      37 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/pci/controller/pcie-rockchip.h:163:41: note: in expansion of macro 'GENMASK'
     163 | #define PCIE_ADDR_MASK                  GENMASK(63, MIN_AXI_ADDR_BITS_PASSED)
         |                                         ^~~~~~~
   drivers/pci/controller/pcie-rockchip-ep.c:394:54: note: in expansion of macro 'PCIE_ADDR_MASK'
     394 |         if (unlikely(ep->irq_pci_addr != (pci_addr & PCIE_ADDR_MASK) ||
         |                                                      ^~~~~~~~~~~~~~
>> include/linux/bits.h:35:18: warning: right shift count is negative [-Wshift-count-negative]
      35 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
         |                  ^~
   include/linux/bits.h:37:38: note: in expansion of macro '__GENMASK'
      37 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/pci/controller/pcie-rockchip.h:163:41: note: in expansion of macro 'GENMASK'
     163 | #define PCIE_ADDR_MASK                  GENMASK(63, MIN_AXI_ADDR_BITS_PASSED)
         |                                         ^~~~~~~
   drivers/pci/controller/pcie-rockchip-ep.c:399:57: note: in expansion of macro 'PCIE_ADDR_MASK'
     399 |                                              pci_addr & PCIE_ADDR_MASK,
         |                                                         ^~~~~~~~~~~~~~
>> include/linux/bits.h:35:18: warning: right shift count is negative [-Wshift-count-negative]
      35 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
         |                  ^~
   include/linux/bits.h:37:38: note: in expansion of macro '__GENMASK'
      37 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/pci/controller/pcie-rockchip.h:163:41: note: in expansion of macro 'GENMASK'
     163 | #define PCIE_ADDR_MASK                  GENMASK(63, MIN_AXI_ADDR_BITS_PASSED)
         |                                         ^~~~~~~
   drivers/pci/controller/pcie-rockchip-ep.c:400:47: note: in expansion of macro 'PCIE_ADDR_MASK'
     400 |                                              ~PCIE_ADDR_MASK + 1);
         |                                               ^~~~~~~~~~~~~~
>> include/linux/bits.h:35:18: warning: right shift count is negative [-Wshift-count-negative]
      35 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
         |                  ^~
   include/linux/bits.h:37:38: note: in expansion of macro '__GENMASK'
      37 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/pci/controller/pcie-rockchip.h:163:41: note: in expansion of macro 'GENMASK'
     163 | #define PCIE_ADDR_MASK                  GENMASK(63, MIN_AXI_ADDR_BITS_PASSED)
         |                                         ^~~~~~~
   drivers/pci/controller/pcie-rockchip-ep.c:401:48: note: in expansion of macro 'PCIE_ADDR_MASK'
     401 |                 ep->irq_pci_addr = (pci_addr & PCIE_ADDR_MASK);
         |                                                ^~~~~~~~~~~~~~
   In file included from include/linux/io.h:13,
                    from include/linux/irq.h:20,
                    from include/asm-generic/hardirq.h:17,
                    from arch/arm/include/asm/hardirq.h:10,
                    from include/linux/hardirq.h:11,
                    from include/linux/interrupt.h:11,
                    from include/linux/pci.h:38,
                    from include/linux/pci-epf.h:15,
                    from include/linux/pci-epc.h:12,
                    from drivers/pci/controller/pcie-rockchip-ep.c:15:
>> include/linux/bits.h:35:18: warning: right shift count is negative [-Wshift-count-negative]
      35 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
         |                  ^~
   arch/arm/include/asm/io.h:281:75: note: in definition of macro 'writew_relaxed'
     281 | #define writew_relaxed(v,c)     __raw_writew((__force u16) cpu_to_le16(v),c)
         |                                                                           ^
   drivers/pci/controller/pcie-rockchip-ep.c:405:9: note: in expansion of macro 'writew'
     405 |         writew(data, ep->irq_cpu_addr + (pci_addr & ~PCIE_ADDR_MASK));
         |         ^~~~~~
   include/linux/bits.h:37:38: note: in expansion of macro '__GENMASK'
      37 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/pci/controller/pcie-rockchip.h:163:41: note: in expansion of macro 'GENMASK'
     163 | #define PCIE_ADDR_MASK                  GENMASK(63, MIN_AXI_ADDR_BITS_PASSED)
         |                                         ^~~~~~~
   drivers/pci/controller/pcie-rockchip-ep.c:405:54: note: in expansion of macro 'PCIE_ADDR_MASK'
     405 |         writew(data, ep->irq_cpu_addr + (pci_addr & ~PCIE_ADDR_MASK));
         |                                                      ^~~~~~~~~~~~~~
--
   In file included from include/linux/bitops.h:6,
                    from include/linux/kernel.h:22,
                    from include/linux/clk.h:13,
                    from drivers/pci/controller/pcie-rockchip-host.c:15:
   drivers/pci/controller/pcie-rockchip-host.c: In function 'rockchip_pcie_prog_ob_atu':
>> include/linux/bits.h:35:18: warning: right shift count is negative [-Wshift-count-negative]
      35 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
         |                  ^~
   include/linux/bits.h:37:38: note: in expansion of macro '__GENMASK'
      37 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/pci/controller/pcie-rockchip.h:163:41: note: in expansion of macro 'GENMASK'
     163 | #define PCIE_ADDR_MASK                  GENMASK(63, MIN_AXI_ADDR_BITS_PASSED)
         |                                         ^~~~~~~
   drivers/pci/controller/pcie-rockchip.h:167:49: note: in expansion of macro 'PCIE_ADDR_MASK'
     167 | #define   PCIE_CORE_OB_REGION_ADDR0_LO_ADDR     PCIE_ADDR_MASK
         |                                                 ^~~~~~~~~~~~~~
   drivers/pci/controller/pcie-rockchip-host.c:733:35: note: in expansion of macro 'PCIE_CORE_OB_REGION_ADDR0_LO_ADDR'
     733 |         ob_addr_0 |= lower_addr & PCIE_CORE_OB_REGION_ADDR0_LO_ADDR;
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pci/controller/pcie-rockchip-host.c: In function 'rockchip_pcie_prog_ib_atu':
>> include/linux/bits.h:35:18: warning: right shift count is negative [-Wshift-count-negative]
      35 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
         |                  ^~
   include/linux/bits.h:37:38: note: in expansion of macro '__GENMASK'
      37 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/pci/controller/pcie-rockchip.h:163:41: note: in expansion of macro 'GENMASK'
     163 | #define PCIE_ADDR_MASK                  GENMASK(63, MIN_AXI_ADDR_BITS_PASSED)
         |                                         ^~~~~~~
   drivers/pci/controller/pcie-rockchip.h:175:49: note: in expansion of macro 'PCIE_ADDR_MASK'
     175 | #define   PCIE_CORE_IB_REGION_ADDR0_LO_ADDR     PCIE_ADDR_MASK
         |                                                 ^~~~~~~~~~~~~~
   drivers/pci/controller/pcie-rockchip-host.c:767:42: note: in expansion of macro 'PCIE_CORE_IB_REGION_ADDR0_LO_ADDR'
     767 |         ib_addr_0 |= (lower_addr << 8) & PCIE_CORE_IB_REGION_ADDR0_LO_ADDR;
         |                                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +35 include/linux/bits.h

295bcca84916cb Rikard Falkeborn 2020-04-06  32  
295bcca84916cb Rikard Falkeborn 2020-04-06  33  #define __GENMASK(h, l) \
95b980d62d52c4 Masahiro Yamada  2019-07-16  34  	(((~UL(0)) - (UL(1) << (l)) + 1) & \
95b980d62d52c4 Masahiro Yamada  2019-07-16 @35  	 (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
295bcca84916cb Rikard Falkeborn 2020-04-06  36  #define GENMASK(h, l) \
295bcca84916cb Rikard Falkeborn 2020-04-06  37  	(GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
8bd9cb51daac89 Will Deacon      2018-06-19  38  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
