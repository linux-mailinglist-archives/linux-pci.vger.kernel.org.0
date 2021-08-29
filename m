Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51E083FAE9F
	for <lists+linux-pci@lfdr.de>; Sun, 29 Aug 2021 23:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233841AbhH2VHD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 29 Aug 2021 17:07:03 -0400
Received: from mga06.intel.com ([134.134.136.31]:34658 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232450AbhH2VG7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 29 Aug 2021 17:06:59 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10091"; a="279191767"
X-IronPort-AV: E=Sophos;i="5.84,362,1620716400"; 
   d="scan'208";a="279191767"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2021 14:06:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,362,1620716400"; 
   d="scan'208";a="518521357"
Received: from lkp-server01.sh.intel.com (HELO 4fbc2b3ce5aa) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 29 Aug 2021 14:06:05 -0700
Received: from kbuild by 4fbc2b3ce5aa with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mKS0D-0004aD-8W; Sun, 29 Aug 2021 21:06:05 +0000
Date:   Mon, 30 Aug 2021 05:05:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:pci/reset] BUILD SUCCESS
 9bdc81ce440ec6ea899b236879aee470ec388020
Message-ID: <612bf6af.jSFFMyQJWhMXoHBs%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/reset
branch HEAD: 9bdc81ce440ec6ea899b236879aee470ec388020  PCI: Change the type of probe argument in reset functions

elapsed time: 13230m

configs tested: 172
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210826
powerpc              randconfig-c003-20210826
arm                         cm_x300_defconfig
alpha                            alldefconfig
m68k                         apollo_defconfig
powerpc                      pmac32_defconfig
powerpc                   bluestone_defconfig
arm                         lpc18xx_defconfig
arm                       multi_v4t_defconfig
s390                                defconfig
mips                        bcm63xx_defconfig
arc                                 defconfig
arm                        clps711x_defconfig
mips                         tb0219_defconfig
powerpc                 mpc8540_ads_defconfig
arm                         palmz72_defconfig
sh                             shx3_defconfig
powerpc                 mpc85xx_cds_defconfig
powerpc                      chrp32_defconfig
arm                          moxart_defconfig
ia64                         bigsur_defconfig
mips                      maltasmvp_defconfig
xtensa                  nommu_kc705_defconfig
riscv                            alldefconfig
powerpc                     asp8347_defconfig
arc                     nsimosci_hs_defconfig
m68k                        mvme16x_defconfig
arm                            xcep_defconfig
sh                           se7780_defconfig
arm                          imote2_defconfig
powerpc                     tqm8541_defconfig
arm                           h3600_defconfig
parisc                generic-64bit_defconfig
riscv                    nommu_virt_defconfig
arm                       imx_v4_v5_defconfig
mips                         bigsur_defconfig
x86_64                           alldefconfig
arm                          exynos_defconfig
powerpc                      pasemi_defconfig
mips                           ip32_defconfig
arm                           tegra_defconfig
openrisc                 simple_smp_defconfig
powerpc                        icon_defconfig
m68k                          multi_defconfig
arc                        vdk_hs38_defconfig
powerpc                 mpc8313_rdb_defconfig
mips                          rb532_defconfig
ia64                      gensparse_defconfig
mips                         cobalt_defconfig
powerpc                    amigaone_defconfig
arc                         haps_hs_defconfig
arm                       aspeed_g5_defconfig
arm                         s5pv210_defconfig
powerpc                  mpc866_ads_defconfig
powerpc                 mpc8272_ads_defconfig
arc                      axs103_smp_defconfig
sh                ecovec24-romimage_defconfig
arm                          badge4_defconfig
sh                     sh7710voipgw_defconfig
powerpc                     akebono_defconfig
sh                          rsk7203_defconfig
sh                               alldefconfig
sh                               j2_defconfig
s390                          debug_defconfig
powerpc                 linkstation_defconfig
mips                  decstation_64_defconfig
microblaze                      mmu_defconfig
x86_64                            allnoconfig
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
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a006-20210822
i386                 randconfig-a001-20210822
i386                 randconfig-a002-20210822
i386                 randconfig-a005-20210822
i386                 randconfig-a003-20210822
i386                 randconfig-a004-20210822
x86_64               randconfig-a014-20210821
x86_64               randconfig-a016-20210821
x86_64               randconfig-a015-20210821
x86_64               randconfig-a013-20210821
x86_64               randconfig-a012-20210821
x86_64               randconfig-a011-20210821
i386                 randconfig-a011-20210821
i386                 randconfig-a016-20210821
i386                 randconfig-a012-20210821
i386                 randconfig-a014-20210821
i386                 randconfig-a013-20210821
i386                 randconfig-a015-20210821
arc                  randconfig-r043-20210821
riscv                randconfig-r042-20210821
s390                 randconfig-r044-20210821
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
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
x86_64                                  kexec

clang tested configs:
i386                 randconfig-c001-20210822
s390                 randconfig-c005-20210822
arm                  randconfig-c002-20210822
riscv                randconfig-c006-20210822
powerpc              randconfig-c003-20210822
x86_64               randconfig-c007-20210822
mips                 randconfig-c004-20210822
s390                 randconfig-c005-20210821
i386                 randconfig-c001-20210821
arm                  randconfig-c002-20210821
riscv                randconfig-c006-20210821
powerpc              randconfig-c003-20210821
x86_64               randconfig-c007-20210821
x86_64               randconfig-a005-20210821
x86_64               randconfig-a001-20210821
x86_64               randconfig-a006-20210821
x86_64               randconfig-a003-20210821
x86_64               randconfig-a004-20210821
x86_64               randconfig-a002-20210821
i386                 randconfig-a006-20210821
i386                 randconfig-a001-20210821
i386                 randconfig-a002-20210821
i386                 randconfig-a005-20210821
i386                 randconfig-a004-20210821
i386                 randconfig-a003-20210821
i386                 randconfig-a011-20210822
i386                 randconfig-a016-20210822
i386                 randconfig-a012-20210822
i386                 randconfig-a014-20210822
i386                 randconfig-a013-20210822
i386                 randconfig-a015-20210822
hexagon              randconfig-r041-20210822
hexagon              randconfig-r045-20210822
riscv                randconfig-r042-20210822
s390                 randconfig-r044-20210822

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
