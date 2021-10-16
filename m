Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2ED14301BA
	for <lists+linux-pci@lfdr.de>; Sat, 16 Oct 2021 12:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240227AbhJPKMC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 16 Oct 2021 06:12:02 -0400
Received: from mga18.intel.com ([134.134.136.126]:44605 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235573AbhJPKMB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 16 Oct 2021 06:12:01 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10138"; a="214974205"
X-IronPort-AV: E=Sophos;i="5.85,378,1624345200"; 
   d="scan'208";a="214974205"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2021 03:09:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,378,1624345200"; 
   d="scan'208";a="482002550"
Received: from lkp-server02.sh.intel.com (HELO 08b2c502c3de) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 16 Oct 2021 03:09:52 -0700
Received: from kbuild by 08b2c502c3de with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mbgdT-0009BR-SG; Sat, 16 Oct 2021 10:09:51 +0000
Date:   Sat, 16 Oct 2021 18:08:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:next] BUILD SUCCESS
 c27678438abe0ebead4faedb795920223dd2da94
Message-ID: <616aa4b7.+Q4wvM/5RRhhSEN+%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
branch HEAD: c27678438abe0ebead4faedb795920223dd2da94  Merge branch 'remotes/lorenzo/pci/xgene'

elapsed time: 993m

configs tested: 182
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211016
i386                 randconfig-c001-20211015
powerpc                       maple_defconfig
powerpc                      obs600_defconfig
arm                          pcm027_defconfig
powerpc64                        alldefconfig
mips                     cu1000-neo_defconfig
arm                        realview_defconfig
xtensa                          iss_defconfig
sh                  sh7785lcr_32bit_defconfig
riscv                          rv32_defconfig
openrisc                    or1ksim_defconfig
powerpc                     mpc5200_defconfig
h8300                       h8s-sim_defconfig
powerpc                     powernv_defconfig
sh                             sh03_defconfig
sh                         apsh4a3a_defconfig
arm                         s3c2410_defconfig
powerpc                      chrp32_defconfig
m68k                       m5249evb_defconfig
sparc64                             defconfig
arm                          iop32x_defconfig
nds32                            alldefconfig
arm                       mainstone_defconfig
um                             i386_defconfig
mips                      maltasmvp_defconfig
mips                        nlm_xlp_defconfig
arm                       omap2plus_defconfig
mips                       lemote2f_defconfig
sh                        edosk7705_defconfig
arm                    vt8500_v6_v7_defconfig
arm                          pxa3xx_defconfig
arm                        magician_defconfig
arm                  colibri_pxa270_defconfig
arm                       imx_v4_v5_defconfig
arm                         lpc18xx_defconfig
powerpc                    amigaone_defconfig
m68k                        m5407c3_defconfig
powerpc                       holly_defconfig
ia64                            zx1_defconfig
parisc                           alldefconfig
powerpc                    socrates_defconfig
arm                        mvebu_v5_defconfig
ia64                        generic_defconfig
powerpc                      acadia_defconfig
powerpc                     ksi8560_defconfig
arm                      integrator_defconfig
arm                            mps2_defconfig
powerpc                      tqm8xx_defconfig
mips                           gcw0_defconfig
mips                         tb0219_defconfig
m68k                       m5475evb_defconfig
m68k                          atari_defconfig
sh                          rsk7201_defconfig
arm                         socfpga_defconfig
arm                           h3600_defconfig
m68k                           sun3_defconfig
h8300                            alldefconfig
i386                             alldefconfig
mips                      fuloong2e_defconfig
powerpc                      walnut_defconfig
arm                        keystone_defconfig
powerpc                   microwatt_defconfig
sh                        sh7757lcr_defconfig
openrisc                            defconfig
arm                      pxa255-idp_defconfig
arm                       versatile_defconfig
s390                                defconfig
powerpc                    sam440ep_defconfig
mips                     loongson1b_defconfig
sh                          sdk7786_defconfig
powerpc                      bamboo_defconfig
arm                          badge4_defconfig
arm                             rpc_defconfig
arm                           u8500_defconfig
arm                            hisi_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc64                           defconfig
arm                        mvebu_v7_defconfig
sh                            shmin_defconfig
sh                        dreamcast_defconfig
arm                  randconfig-c002-20211016
x86_64               randconfig-c001-20211016
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
nds32                             allnoconfig
arc                              allyesconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                             allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a006-20211016
x86_64               randconfig-a004-20211016
x86_64               randconfig-a001-20211016
x86_64               randconfig-a005-20211016
x86_64               randconfig-a002-20211016
x86_64               randconfig-a003-20211016
i386                 randconfig-a003-20211016
i386                 randconfig-a001-20211016
i386                 randconfig-a005-20211016
i386                 randconfig-a004-20211016
i386                 randconfig-a002-20211016
i386                 randconfig-a006-20211016
x86_64               randconfig-a012-20211015
x86_64               randconfig-a015-20211015
x86_64               randconfig-a016-20211015
x86_64               randconfig-a014-20211015
x86_64               randconfig-a011-20211015
x86_64               randconfig-a013-20211015
i386                 randconfig-a016-20211015
i386                 randconfig-a014-20211015
i386                 randconfig-a011-20211015
i386                 randconfig-a015-20211015
i386                 randconfig-a012-20211015
i386                 randconfig-a013-20211015
arc                  randconfig-r043-20211015
s390                 randconfig-r044-20211015
riscv                randconfig-r042-20211015
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a006-20211015
x86_64               randconfig-a004-20211015
x86_64               randconfig-a001-20211015
x86_64               randconfig-a005-20211015
x86_64               randconfig-a002-20211015
x86_64               randconfig-a003-20211015
x86_64               randconfig-a012-20211016
x86_64               randconfig-a015-20211016
x86_64               randconfig-a016-20211016
x86_64               randconfig-a014-20211016
x86_64               randconfig-a011-20211016
x86_64               randconfig-a013-20211016
i386                 randconfig-a016-20211016
i386                 randconfig-a014-20211016
i386                 randconfig-a011-20211016
i386                 randconfig-a015-20211016
i386                 randconfig-a012-20211016
i386                 randconfig-a013-20211016
hexagon              randconfig-r041-20211016
s390                 randconfig-r044-20211016
riscv                randconfig-r042-20211016
hexagon              randconfig-r045-20211016
hexagon              randconfig-r041-20211015
hexagon              randconfig-r045-20211015

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
