Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87FC747115C
	for <lists+linux-pci@lfdr.de>; Sat, 11 Dec 2021 05:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345835AbhLKESG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Dec 2021 23:18:06 -0500
Received: from mga18.intel.com ([134.134.136.126]:23343 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345829AbhLKESG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 10 Dec 2021 23:18:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639196070; x=1670732070;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=+ivGaTQQ38SDL0ZHWCxXuW01i1124NoITgfE/bnIjmg=;
  b=JdUuTmrzvkL7s5OA4o7rg4NQSpY0tR46itlntbLryZmG04KWV7GHMEkw
   dUoq0GhK7tffzUiCJ4EuLk3lUEaxtjEK+p2L0iP88/Ddw2rQF+R4xbXuY
   WD21AMpEvzcsRVl1rHNErF2x6hiCmu/sWtieA5bMRImVgjKchGM+6vakp
   4ICUd57epWDcDL8czaBeJL0z7XzLwYDhHaiAUfS2QCDsBrKXsWj6yMnMe
   87Nkd+7YC2XqxCXozvfps72OzZylrpWN6mZS7ti/7Rj/qgXPyxu4MCd9+
   3GBaExRdbcExA2dcnWBv41CpHnjLLx74Oz+sGdQFA509Qm7A0TEKlLx/o
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10194"; a="225369364"
X-IronPort-AV: E=Sophos;i="5.88,197,1635231600"; 
   d="scan'208";a="225369364"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 20:14:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,197,1635231600"; 
   d="scan'208";a="504207725"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 10 Dec 2021 20:14:28 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mvtmG-00046S-3X; Sat, 11 Dec 2021 04:14:28 +0000
Date:   Sat, 11 Dec 2021 12:13:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/driver-cleanup] BUILD REGRESSION
 24d25dd0ddf8c2b924a1fafc51dd0e578d304c3a
Message-ID: <61b42568.bQHDlXooxFE/SUs8%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/driver-cleanup
branch HEAD: 24d25dd0ddf8c2b924a1fafc51dd0e578d304c3a  PCI: rcar: Replace device * with platform_device *

Error/Warning reports:

https://lore.kernel.org/linux-pci/202112110238.rZl7p5gE-lkp@intel.com
https://lore.kernel.org/linux-pci/202112110258.s3iNhcmi-lkp@intel.com

Error/Warning in current branch:

drivers/pci/controller/cadence/pci-j721e.c:370:7: error: assigning to 'struct j721e_pcie_data *' from 'const void *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]

possible Error/Warning in current branch (please contact us if interested):

drivers/pci/controller/cadence/pci-j721e.c:370:14: warning: assignment discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
drivers/pci/controller/cadence/pci-j721e.c:370:7: warning: assignment discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allmodconfig
|   `-- drivers-pci-controller-cadence-pci-j721e.c:warning:assignment-discards-const-qualifier-from-pointer-target-type
|-- alpha-allyesconfig
|   `-- drivers-pci-controller-cadence-pci-j721e.c:warning:assignment-discards-const-qualifier-from-pointer-target-type
|-- arc-allyesconfig
|   `-- drivers-pci-controller-cadence-pci-j721e.c:warning:assignment-discards-const-qualifier-from-pointer-target-type
|-- arc-buildonly-randconfig-r006-20211210
|   `-- drivers-pci-controller-cadence-pci-j721e.c:warning:assignment-discards-const-qualifier-from-pointer-target-type
|-- arc-randconfig-r043-20211210
|   `-- drivers-pci-controller-cadence-pci-j721e.c:warning:assignment-discards-const-qualifier-from-pointer-target-type
|-- arm-allmodconfig
|   `-- drivers-pci-controller-cadence-pci-j721e.c:warning:assignment-discards-const-qualifier-from-pointer-target-type
|-- arm-allyesconfig
|   `-- drivers-pci-controller-cadence-pci-j721e.c:warning:assignment-discards-const-qualifier-from-pointer-target-type
|-- arm64-allyesconfig
|   `-- drivers-pci-controller-cadence-pci-j721e.c:warning:assignment-discards-const-qualifier-from-pointer-target-type
|-- i386-allyesconfig
|   `-- drivers-pci-controller-cadence-pci-j721e.c:warning:assignment-discards-const-qualifier-from-pointer-target-type
|-- i386-randconfig-a001-20211210
|   `-- drivers-pci-controller-cadence-pci-j721e.c:warning:assignment-discards-const-qualifier-from-pointer-target-type
|-- i386-randconfig-a003-20211210
|   `-- drivers-pci-controller-cadence-pci-j721e.c:warning:assignment-discards-const-qualifier-from-pointer-target-type
|-- i386-randconfig-a004-20211210
|   `-- drivers-pci-controller-cadence-pci-j721e.c:warning:assignment-discards-const-qualifier-from-pointer-target-type
|-- i386-randconfig-m021-20211210
|   `-- drivers-pci-controller-cadence-pci-j721e.c:warning:assignment-discards-const-qualifier-from-pointer-target-type
|-- ia64-allmodconfig
|   `-- drivers-pci-controller-cadence-pci-j721e.c:warning:assignment-discards-const-qualifier-from-pointer-target-type
|-- ia64-allyesconfig
|   `-- drivers-pci-controller-cadence-pci-j721e.c:warning:assignment-discards-const-qualifier-from-pointer-target-type
|-- ia64-randconfig-r016-20211210
|   `-- drivers-pci-controller-cadence-pci-j721e.c:warning:assignment-discards-const-qualifier-from-pointer-target-type
|-- mips-allmodconfig
|   `-- drivers-pci-controller-cadence-pci-j721e.c:warning:assignment-discards-const-qualifier-from-pointer-target-type
|-- mips-allyesconfig
|   `-- drivers-pci-controller-cadence-pci-j721e.c:warning:assignment-discards-const-qualifier-from-pointer-target-type
|-- parisc-allyesconfig
|   `-- drivers-pci-controller-cadence-pci-j721e.c:warning:assignment-discards-const-qualifier-from-pointer-target-type
|-- parisc-buildonly-randconfig-r006-20211210
|   `-- drivers-pci-controller-cadence-pci-j721e.c:warning:assignment-discards-const-qualifier-from-pointer-target-type
|-- parisc-randconfig-r004-20211210
|   `-- drivers-pci-controller-cadence-pci-j721e.c:warning:assignment-discards-const-qualifier-from-pointer-target-type
|-- parisc-randconfig-r014-20211210
|   `-- drivers-pci-controller-cadence-pci-j721e.c:warning:assignment-discards-const-qualifier-from-pointer-target-type
|-- parisc-randconfig-r021-20211210
|   `-- drivers-pci-controller-cadence-pci-j721e.c:warning:assignment-discards-const-qualifier-from-pointer-target-type
|-- powerpc-allmodconfig
|   `-- drivers-pci-controller-cadence-pci-j721e.c:warning:assignment-discards-const-qualifier-from-pointer-target-type
|-- powerpc-allyesconfig
|   `-- drivers-pci-controller-cadence-pci-j721e.c:warning:assignment-discards-const-qualifier-from-pointer-target-type
|-- powerpc64-randconfig-r003-20211210
|   `-- drivers-pci-controller-cadence-pci-j721e.c:warning:assignment-discards-const-qualifier-from-pointer-target-type
|-- riscv-allmodconfig
|   `-- drivers-pci-controller-cadence-pci-j721e.c:warning:assignment-discards-const-qualifier-from-pointer-target-type
|-- riscv-allyesconfig
|   `-- drivers-pci-controller-cadence-pci-j721e.c:warning:assignment-discards-const-qualifier-from-pointer-target-type
|-- riscv-randconfig-r031-20211210
|   `-- drivers-pci-controller-cadence-pci-j721e.c:warning:assignment-discards-const-qualifier-from-pointer-target-type
|-- s390-allyesconfig
|   `-- drivers-pci-controller-cadence-pci-j721e.c:warning:assignment-discards-const-qualifier-from-pointer-target-type
|-- sparc-allyesconfig
|   `-- drivers-pci-controller-cadence-pci-j721e.c:warning:assignment-discards-const-qualifier-from-pointer-target-type
|-- sparc-randconfig-r024-20211210
|   `-- drivers-pci-controller-cadence-pci-j721e.c:warning:assignment-discards-const-qualifier-from-pointer-target-type
|-- sparc-randconfig-r033-20211210
|   `-- drivers-pci-controller-cadence-pci-j721e.c:warning:assignment-discards-const-qualifier-from-pointer-target-type
|-- sparc64-allmodconfig
|   `-- drivers-pci-controller-cadence-pci-j721e.c:warning:assignment-discards-const-qualifier-from-pointer-target-type
|-- sparc64-randconfig-p002-20211210
|   `-- drivers-pci-controller-cadence-pci-j721e.c:warning:assignment-discards-const-qualifier-from-pointer-target-type
|-- x86_64-allyesconfig
|   `-- drivers-pci-controller-cadence-pci-j721e.c:warning:assignment-discards-const-qualifier-from-pointer-target-type
|-- x86_64-randconfig-a005-20211210
|   `-- drivers-pci-controller-cadence-pci-j721e.c:warning:assignment-discards-const-qualifier-from-pointer-target-type
|-- xtensa-allyesconfig
|   `-- drivers-pci-controller-cadence-pci-j721e.c:warning:assignment-discards-const-qualifier-from-pointer-target-type
`-- xtensa-randconfig-r005-20211210
    `-- drivers-pci-controller-cadence-pci-j721e.c:warning:assignment-discards-const-qualifier-from-pointer-target-type

clang_recent_errors
`-- arm64-randconfig-r014-20211210
    `-- drivers-pci-controller-cadence-pci-j721e.c:error:assigning-to-struct-j721e_pcie_data-from-const-void-discards-qualifiers-Werror-Wincompatible-pointer-types-discards-qualifiers

elapsed time: 721m

configs tested: 140
configs skipped: 3

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211210
sh                      rts7751r2d1_defconfig
arm                       aspeed_g5_defconfig
sparc64                             defconfig
arm                          ixp4xx_defconfig
sh                           se7780_defconfig
h8300                       h8s-sim_defconfig
i386                             alldefconfig
arc                    vdk_hs38_smp_defconfig
mips                    maltaup_xpa_defconfig
mips                         cobalt_defconfig
mips                        bcm63xx_defconfig
m68k                            q40_defconfig
arc                           tb10x_defconfig
arc                     nsimosci_hs_defconfig
nios2                         3c120_defconfig
arm                       multi_v4t_defconfig
sh                           se7619_defconfig
arm                      integrator_defconfig
mips                     loongson2k_defconfig
powerpc                     sequoia_defconfig
arm                         lpc32xx_defconfig
microblaze                      mmu_defconfig
sh                        edosk7705_defconfig
powerpc                   motionpro_defconfig
m68k                         amcore_defconfig
parisc                generic-32bit_defconfig
powerpc                     kmeter1_defconfig
arm                        trizeps4_defconfig
xtensa                generic_kc705_defconfig
sh                          rsk7203_defconfig
sh                          polaris_defconfig
arm                             mxs_defconfig
arm                            hisi_defconfig
arm                       imx_v4_v5_defconfig
powerpc                  mpc866_ads_defconfig
m68k                          amiga_defconfig
m68k                          sun3x_defconfig
arm                           h5000_defconfig
arm                  colibri_pxa300_defconfig
arm                         socfpga_defconfig
x86_64                           allyesconfig
sparc                       sparc64_defconfig
mips                  cavium_octeon_defconfig
powerpc                      chrp32_defconfig
powerpc                 mpc8540_ads_defconfig
m68k                        m5407c3_defconfig
arc                            hsdk_defconfig
openrisc                  or1klitex_defconfig
powerpc                     pq2fads_defconfig
alpha                            alldefconfig
arm                       netwinder_defconfig
x86_64                              defconfig
powerpc                     tqm8541_defconfig
arm                          pxa3xx_defconfig
powerpc                    mvme5100_defconfig
riscv                            alldefconfig
m68k                       m5275evb_defconfig
xtensa                          iss_defconfig
arm                  randconfig-c002-20211210
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
xtensa                           allyesconfig
h8300                            allyesconfig
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
x86_64               randconfig-a006-20211210
x86_64               randconfig-a005-20211210
x86_64               randconfig-a001-20211210
x86_64               randconfig-a002-20211210
x86_64               randconfig-a003-20211210
x86_64               randconfig-a004-20211210
i386                 randconfig-a001-20211210
i386                 randconfig-a002-20211210
i386                 randconfig-a005-20211210
i386                 randconfig-a003-20211210
i386                 randconfig-a006-20211210
i386                 randconfig-a004-20211210
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
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a012-20211210
x86_64               randconfig-a014-20211210
x86_64               randconfig-a013-20211210
x86_64               randconfig-a016-20211210
x86_64               randconfig-a015-20211210
x86_64               randconfig-a011-20211210
i386                 randconfig-a013-20211210
i386                 randconfig-a011-20211210
i386                 randconfig-a016-20211210
i386                 randconfig-a014-20211210
i386                 randconfig-a015-20211210
i386                 randconfig-a012-20211210
hexagon              randconfig-r045-20211210
riscv                randconfig-r042-20211210
s390                 randconfig-r044-20211210
hexagon              randconfig-r041-20211210

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
