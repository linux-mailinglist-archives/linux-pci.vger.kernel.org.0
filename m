Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59BC14A5A13
	for <lists+linux-pci@lfdr.de>; Tue,  1 Feb 2022 11:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234907AbiBAKed (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Feb 2022 05:34:33 -0500
Received: from mga03.intel.com ([134.134.136.65]:14979 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236363AbiBAKec (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 1 Feb 2022 05:34:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643711672; x=1675247672;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=9vqgRfsh8IEyFgeyPLRvC1qlUUk77X1VXtmbVwzF3og=;
  b=n04N5ixjbp0ft4kute+icY5hemUZrDIIWCdIA//269w/fssYfMvzVePJ
   iTrXfXiwGdX6r/9Fve8pIR9g96281kAh+BuXIBkxlvPQLh17bB3O4x80s
   uO6C7BR2w0yQNgh8jOtJhQddCbAwtHEg3f6+YQieL92Iat4In/wfSsOIB
   8MSw7FEYxmbxy9vuAbzIVeEKcIKwCdisGMESzjWU3DWsvlt9Ttsm6PUYT
   6WqP30mc2BRB1saYLthtk2dgDo1eZxKWMzm2PST0ACvn42jacURxiLUPV
   w+RWVx9WIZ255Hu5M6t1KmU3K+Z8iOZNmcrkqylqmzgggB2dGu3pnXA+h
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="247616177"
X-IronPort-AV: E=Sophos;i="5.88,333,1635231600"; 
   d="scan'208";a="247616177"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 02:34:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,333,1635231600"; 
   d="scan'208";a="676040467"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 01 Feb 2022 02:34:30 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nEqUY-000T7j-BQ; Tue, 01 Feb 2022 10:34:30 +0000
Date:   Tue, 01 Feb 2022 18:33:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:for-linus] BUILD SUCCESS
 a00908f9feb6a654adbc2b08241a61e491cfddd4
Message-ID: <61f90c7d.gvN6EATp+ABRLlNb%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git for-linus
branch HEAD: a00908f9feb6a654adbc2b08241a61e491cfddd4  PCI: j721e: Initialize pcie->cdns_pcie before using it

Warning reports:

https://lore.kernel.org/linux-pci/202202011117.2J6tELXm-lkp@intel.com

possible Warning in current branch (please contact us if interested):

drivers/pci/controller/cadence/pci-j721e.c:510:30: warning: variable 'rc' is uninitialized when used here [-Wuninitialized]
drivers/pci/controller/cadence/pci-j721e.c:524:28: warning: variable 'ep' is uninitialized when used here [-Wuninitialized]

Warning ids grouped by kconfigs:

clang_recent_errors
|-- arm64-randconfig-r001-20220130
|   `-- drivers-pci-controller-cadence-pci-j721e.c:warning:variable-rc-is-uninitialized-when-used-here
|-- arm64-randconfig-r011-20220131
|   `-- drivers-pci-controller-cadence-pci-j721e.c:warning:variable-rc-is-uninitialized-when-used-here
|-- arm64-randconfig-r025-20220131
|   `-- drivers-pci-controller-cadence-pci-j721e.c:warning:variable-rc-is-uninitialized-when-used-here
|-- i386-randconfig-a011
|   `-- drivers-pci-controller-cadence-pci-j721e.c:warning:variable-ep-is-uninitialized-when-used-here
|-- i386-randconfig-a012-20220131
|   `-- drivers-pci-controller-cadence-pci-j721e.c:warning:variable-ep-is-uninitialized-when-used-here
|-- i386-randconfig-a015
|   `-- drivers-pci-controller-cadence-pci-j721e.c:warning:variable-ep-is-uninitialized-when-used-here
|-- i386-randconfig-a015-20220131
|   `-- drivers-pci-controller-cadence-pci-j721e.c:warning:variable-ep-is-uninitialized-when-used-here
|-- riscv-randconfig-r032-20220130
|   `-- drivers-pci-controller-cadence-pci-j721e.c:warning:variable-ep-is-uninitialized-when-used-here
|-- s390-randconfig-r021-20220131
|   `-- drivers-pci-controller-cadence-pci-j721e.c:warning:variable-ep-is-uninitialized-when-used-here
`-- x86_64-randconfig-a011-20220131
    `-- drivers-pci-controller-cadence-pci-j721e.c:warning:variable-rc-is-uninitialized-when-used-here

elapsed time: 731m

configs tested: 143
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20220131
powerpc              randconfig-c003-20220131
sh                          urquell_defconfig
arm                       imx_v6_v7_defconfig
arc                            hsdk_defconfig
powerpc                     taishan_defconfig
sh                            titan_defconfig
m68k                           sun3_defconfig
sh                          rsk7269_defconfig
powerpc                    klondike_defconfig
powerpc                      ppc40x_defconfig
powerpc                 mpc837x_rdb_defconfig
parisc                           alldefconfig
m68k                       m5208evb_defconfig
xtensa                           allyesconfig
arc                    vdk_hs38_smp_defconfig
powerpc                 mpc837x_mds_defconfig
arm                           stm32_defconfig
sh                  sh7785lcr_32bit_defconfig
powerpc                     asp8347_defconfig
arm                      footbridge_defconfig
sh                          kfr2r09_defconfig
sh                           se7724_defconfig
ia64                        generic_defconfig
sh                           se7343_defconfig
sh                             shx3_defconfig
h8300                            allyesconfig
arm                          gemini_defconfig
xtensa                       common_defconfig
powerpc                 mpc834x_mds_defconfig
powerpc                       eiger_defconfig
powerpc                        cell_defconfig
microblaze                      mmu_defconfig
powerpc                      bamboo_defconfig
mips                        jmr3927_defconfig
openrisc                         alldefconfig
mips                         db1xxx_defconfig
arm                  randconfig-c002-20220130
arm                  randconfig-c002-20220131
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20220131
x86_64               randconfig-a003-20220131
x86_64               randconfig-a001-20220131
x86_64               randconfig-a006-20220131
x86_64               randconfig-a005-20220131
x86_64               randconfig-a002-20220131
i386                 randconfig-a006-20220131
i386                 randconfig-a005-20220131
i386                 randconfig-a003-20220131
i386                 randconfig-a002-20220131
i386                 randconfig-a001-20220131
i386                 randconfig-a004-20220131
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
riscv                randconfig-c006-20220130
x86_64                        randconfig-c007
arm                  randconfig-c002-20220130
powerpc              randconfig-c003-20220130
mips                 randconfig-c004-20220130
i386                          randconfig-c001
powerpc                          allyesconfig
arm                             mxs_defconfig
arm                        spear3xx_defconfig
arm                       versatile_defconfig
arm                         orion5x_defconfig
mips                   sb1250_swarm_defconfig
powerpc                 mpc8560_ads_defconfig
arm                        vexpress_defconfig
mips                       lemote2f_defconfig
mips                          rm200_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64               randconfig-a013-20220131
x86_64               randconfig-a015-20220131
x86_64               randconfig-a014-20220131
x86_64               randconfig-a016-20220131
x86_64               randconfig-a011-20220131
x86_64               randconfig-a012-20220131
i386                 randconfig-a011-20220131
i386                 randconfig-a013-20220131
i386                 randconfig-a014-20220131
i386                 randconfig-a012-20220131
i386                 randconfig-a015-20220131
i386                 randconfig-a016-20220131
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
riscv                randconfig-r042-20220131
hexagon              randconfig-r045-20220130
hexagon              randconfig-r045-20220131
hexagon              randconfig-r041-20220130
hexagon              randconfig-r041-20220131

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
