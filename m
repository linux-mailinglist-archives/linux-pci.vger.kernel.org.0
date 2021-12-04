Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD14446834B
	for <lists+linux-pci@lfdr.de>; Sat,  4 Dec 2021 09:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355004AbhLDIGK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 4 Dec 2021 03:06:10 -0500
Received: from mga07.intel.com ([134.134.136.100]:56864 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343993AbhLDIGJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 4 Dec 2021 03:06:09 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10187"; a="300488956"
X-IronPort-AV: E=Sophos;i="5.87,287,1631602800"; 
   d="scan'208";a="300488956"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2021 00:02:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,287,1631602800"; 
   d="scan'208";a="501465513"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 04 Dec 2021 00:02:43 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mtQ0I-000Ihi-CU; Sat, 04 Dec 2021 08:02:42 +0000
Date:   Sat, 04 Dec 2021 16:02:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:next] BUILD SUCCESS
 fcf5ca40c844c084847c4e3ff3968ddec40dfa2a
Message-ID: <61ab2099.jTgStAnSZ4ryCR9L%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
branch HEAD: fcf5ca40c844c084847c4e3ff3968ddec40dfa2a  Merge branch 'pci/errors'

elapsed time: 767m

configs tested: 168
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                               defconfig
mips                 randconfig-c004-20211203
i386                 randconfig-c001-20211203
xtensa                generic_kc705_defconfig
nds32                               defconfig
mips                      pic32mzda_defconfig
arm64                            alldefconfig
powerpc                          g5_defconfig
arm                        clps711x_defconfig
alpha                            alldefconfig
ia64                         bigsur_defconfig
sh                             shx3_defconfig
powerpc                    adder875_defconfig
m68k                       m5208evb_defconfig
powerpc                      arches_defconfig
s390                             allyesconfig
arm                         shannon_defconfig
powerpc                 mpc8540_ads_defconfig
mips                      fuloong2e_defconfig
sh                        edosk7760_defconfig
powerpc                     tqm8555_defconfig
openrisc                    or1ksim_defconfig
arc                          axs101_defconfig
m68k                        m5407c3_defconfig
um                             i386_defconfig
mips                        maltaup_defconfig
sparc                       sparc64_defconfig
mips                        vocore2_defconfig
arm                          pxa3xx_defconfig
sh                               alldefconfig
nios2                         10m50_defconfig
powerpc                     ppa8548_defconfig
powerpc                 mpc834x_itx_defconfig
sh                          rsk7269_defconfig
arc                        nsim_700_defconfig
arm                         s5pv210_defconfig
um                           x86_64_defconfig
mips                           xway_defconfig
arm                            xcep_defconfig
powerpc                       holly_defconfig
powerpc                      ppc40x_defconfig
nios2                               defconfig
riscv                    nommu_k210_defconfig
powerpc                        cell_defconfig
sh                            hp6xx_defconfig
powerpc                 mpc836x_rdk_defconfig
arm                         at91_dt_defconfig
powerpc                     powernv_defconfig
powerpc                      cm5200_defconfig
sh                         microdev_defconfig
powerpc                 canyonlands_defconfig
arm                      jornada720_defconfig
arm                         bcm2835_defconfig
powerpc                 mpc8272_ads_defconfig
arc                      axs103_smp_defconfig
arm                         palmz72_defconfig
xtensa                       common_defconfig
sh                         ap325rxa_defconfig
arm                         socfpga_defconfig
mips                          rm200_defconfig
mips                            gpr_defconfig
h8300                               defconfig
mips                         rt305x_defconfig
sh                           se7712_defconfig
arm                        mvebu_v5_defconfig
mips                       bmips_be_defconfig
sparc                       sparc32_defconfig
sh                           se7751_defconfig
nios2                            allyesconfig
arm                          ep93xx_defconfig
powerpc                       eiger_defconfig
arm                       aspeed_g4_defconfig
sparc                            alldefconfig
mips                          malta_defconfig
powerpc                        warp_defconfig
microblaze                          defconfig
arm                  randconfig-c002-20211203
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
arc                              allyesconfig
nds32                             allnoconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
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
x86_64               randconfig-a006-20211203
x86_64               randconfig-a005-20211203
x86_64               randconfig-a001-20211203
x86_64               randconfig-a002-20211203
x86_64               randconfig-a004-20211203
x86_64               randconfig-a003-20211203
i386                 randconfig-a001-20211203
i386                 randconfig-a005-20211203
i386                 randconfig-a002-20211203
i386                 randconfig-a003-20211203
i386                 randconfig-a006-20211203
i386                 randconfig-a004-20211203
i386                 randconfig-a013-20211204
i386                 randconfig-a016-20211204
i386                 randconfig-a011-20211204
i386                 randconfig-a014-20211204
i386                 randconfig-a012-20211204
i386                 randconfig-a015-20211204
arc                  randconfig-r043-20211203
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
arm                  randconfig-c002-20211203
x86_64               randconfig-c007-20211203
riscv                randconfig-c006-20211203
mips                 randconfig-c004-20211203
i386                 randconfig-c001-20211203
powerpc              randconfig-c003-20211203
s390                 randconfig-c005-20211203
x86_64               randconfig-a016-20211203
x86_64               randconfig-a011-20211203
x86_64               randconfig-a013-20211203
x86_64               randconfig-a014-20211203
x86_64               randconfig-a015-20211203
x86_64               randconfig-a012-20211203
i386                 randconfig-a016-20211203
i386                 randconfig-a013-20211203
i386                 randconfig-a011-20211203
i386                 randconfig-a014-20211203
i386                 randconfig-a012-20211203
i386                 randconfig-a015-20211203
x86_64               randconfig-a006-20211204
x86_64               randconfig-a005-20211204
x86_64               randconfig-a001-20211204
x86_64               randconfig-a002-20211204
x86_64               randconfig-a004-20211204
x86_64               randconfig-a003-20211204
hexagon              randconfig-r045-20211203
s390                 randconfig-r044-20211203
hexagon              randconfig-r041-20211203
riscv                randconfig-r042-20211203

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
