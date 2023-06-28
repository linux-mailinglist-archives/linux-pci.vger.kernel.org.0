Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3439740780
	for <lists+linux-pci@lfdr.de>; Wed, 28 Jun 2023 03:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjF1BOd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Jun 2023 21:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjF1BOc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Jun 2023 21:14:32 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8441BD4
        for <linux-pci@vger.kernel.org>; Tue, 27 Jun 2023 18:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687914871; x=1719450871;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YvoQAaetZDM39zDr8T11wLYnS0mAFecgh6AohsFD7Rg=;
  b=boyYhdxFVpMYHihTB2+Zq5i6iYVn0K/Z/cLWdAZJHGMHUhm8zsfYdecg
   PSOhjKHGLk5ZsffYCMMPU5kvzQpKlgGbzWCsbyq1/+ERAVVlz5zuvagcj
   PzgqxcZLXJzRv/YL5YMfncrrlf3o1/fTDlB9XkfuDjVSS7kyM62fuIOVi
   8EWpp/TtIC8O8oExAf2z2qSy4ncfZlVAlh8t4bnqaWCHyI87BzT/zXtQN
   HxJXwXFq228C2n2hGs4yCXU/Acsj/43C14IOUDBT2198liukA/I+q1Saa
   yYBELjPNMKUUlorbVHI+VsPh1a7ccMXnibxfx+SHSPii0b2xKPYr3KApU
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="351504097"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="scan'208";a="351504097"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2023 18:14:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="840886143"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="scan'208";a="840886143"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 27 Jun 2023 18:14:30 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qEJlN-000CQj-15;
        Wed, 28 Jun 2023 01:14:29 +0000
Date:   Wed, 28 Jun 2023 09:14:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Krzysztof =?utf-8?Q?Wilczy=C5=84ski" ?= <kwilczynski@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:controller/tegra194] BUILD SUCCESS
 5d0844362f42b15fe0889050be174e88ff8c6a4a
Message-ID: <202306280917.yrtolctP-lkp@intel.com>
User-Agent: s-nail v14.9.24
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/tegra194
branch HEAD: 5d0844362f42b15fe0889050be174e88ff8c6a4a  Revert "PCI: tegra194: Enable support for 256 Byte payload"

elapsed time: 809m

configs tested: 123
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r026-20230627   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230627   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                         bcm2835_defconfig   clang
arm                                 defconfig   gcc  
arm                       imx_v6_v7_defconfig   gcc  
arm                      jornada720_defconfig   gcc  
arm                         lpc32xx_defconfig   clang
arm                  randconfig-r031-20230627   clang
arm                  randconfig-r035-20230627   clang
arm                  randconfig-r046-20230627   gcc  
arm                           sama7_defconfig   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r012-20230627   clang
arm64                randconfig-r022-20230627   clang
arm64                randconfig-r023-20230627   clang
csky                                defconfig   gcc  
csky                 randconfig-r006-20230627   gcc  
hexagon              randconfig-r003-20230627   clang
hexagon              randconfig-r004-20230627   clang
hexagon              randconfig-r041-20230627   clang
hexagon              randconfig-r045-20230627   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230627   gcc  
i386         buildonly-randconfig-r005-20230627   gcc  
i386         buildonly-randconfig-r006-20230627   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230627   gcc  
i386                 randconfig-i002-20230627   gcc  
i386                 randconfig-i003-20230627   gcc  
i386                 randconfig-i004-20230627   gcc  
i386                 randconfig-i005-20230627   gcc  
i386                 randconfig-i006-20230627   gcc  
i386                 randconfig-i011-20230627   clang
i386                 randconfig-i012-20230627   clang
i386                 randconfig-i013-20230627   clang
i386                 randconfig-i014-20230627   clang
i386                 randconfig-i015-20230627   clang
i386                 randconfig-i016-20230627   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r032-20230627   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5208evb_defconfig   gcc  
m68k                            mac_defconfig   gcc  
m68k                 randconfig-r002-20230627   gcc  
microblaze           randconfig-r015-20230627   gcc  
microblaze           randconfig-r025-20230627   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                     cu1830-neo_defconfig   clang
mips                 randconfig-r011-20230627   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r021-20230627   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-32bit_defconfig   gcc  
parisc               randconfig-r005-20230627   gcc  
parisc64                            defconfig   gcc  
powerpc                     akebono_defconfig   clang
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                       holly_defconfig   gcc  
powerpc                     kilauea_defconfig   clang
powerpc                      pcm030_defconfig   gcc  
powerpc                     ppa8548_defconfig   clang
powerpc                    sam440ep_defconfig   gcc  
powerpc                      walnut_defconfig   clang
powerpc                 xes_mpc85xx_defconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r013-20230627   clang
riscv                randconfig-r042-20230627   clang
riscv                          rv32_defconfig   gcc  
s390                             alldefconfig   clang
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230627   clang
sh                               allmodconfig   gcc  
sh                        edosk7705_defconfig   gcc  
sh                   randconfig-r024-20230627   gcc  
sh                        sh7757lcr_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230627   gcc  
x86_64       buildonly-randconfig-r002-20230627   gcc  
x86_64       buildonly-randconfig-r003-20230627   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-x001-20230627   clang
x86_64               randconfig-x002-20230627   clang
x86_64               randconfig-x003-20230627   clang
x86_64               randconfig-x004-20230627   clang
x86_64               randconfig-x005-20230627   clang
x86_64               randconfig-x006-20230627   clang
x86_64               randconfig-x011-20230627   gcc  
x86_64               randconfig-x012-20230627   gcc  
x86_64               randconfig-x013-20230627   gcc  
x86_64               randconfig-x014-20230627   gcc  
x86_64               randconfig-x015-20230627   gcc  
x86_64               randconfig-x016-20230627   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
