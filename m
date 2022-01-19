Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 339D8493A33
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jan 2022 13:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354439AbiASMVc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jan 2022 07:21:32 -0500
Received: from mga09.intel.com ([134.134.136.24]:58508 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354432AbiASMVc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Jan 2022 07:21:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642594891; x=1674130891;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=sGGdsOGdKZIR4Rrb8p3aZyezRFz200M/nXK4tTQQsc0=;
  b=CDdcdrnhSiwwUMMbtSzmH2nOjdw+NYiAJ57+2KlWHV4TSyS6RaaHRgqu
   x9zSZ8raANAqYQZv3uTT9KlNleiwg03QzGjPcEJYYAmvOWc6jJt+Hsmtx
   TDyZaCTHzfadx5NH9taBBgAdtSDQFHjGCjfrQeL64CicdaMGEq2GpenoS
   pQpGoQ5/R7SRFaTqB0peRnvboFaZn99Mo1VLs854+QaAm0sxPOpsDw9ky
   fgMLKGYsW7X/OohVRGbyBt6K+DhnAb2vEXZhK5dCqlkExFTkNvtVI9Buh
   wrBSvk2rw05twujU1sQiYcXWOH2t6E4+1g7EHjiwAfsTY2CeLBEKIpu6q
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="244848500"
X-IronPort-AV: E=Sophos;i="5.88,299,1635231600"; 
   d="scan'208";a="244848500"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 04:21:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,299,1635231600"; 
   d="scan'208";a="578801230"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 19 Jan 2022 04:21:27 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nA9xv-000DWV-1S; Wed, 19 Jan 2022 12:21:27 +0000
Date:   Wed, 19 Jan 2022 20:21:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:for-linus] BUILD SUCCESS
 9c494ca4d3a535f9ca11ad6af1813983c1c6cbdd
Message-ID: <61e8023f.zZQHD6HsWsoKeALJ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git for-linus
branch HEAD: 9c494ca4d3a535f9ca11ad6af1813983c1c6cbdd  x86/gpu: Reserve stolen memory for first integrated Intel GPU

elapsed time: 724m

configs tested: 161
configs skipped: 55

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20220117
mips                 randconfig-c004-20220117
powerpc              randconfig-c003-20220118
i386                          randconfig-c001
powerpc              randconfig-c003-20220117
mips                         db1xxx_defconfig
arm64                            alldefconfig
sh                        dreamcast_defconfig
m68k                          atari_defconfig
sh                            shmin_defconfig
mips                  decstation_64_defconfig
sh                          sdk7786_defconfig
arm                      footbridge_defconfig
csky                                defconfig
powerpc                  iss476-smp_defconfig
mips                        bcm47xx_defconfig
h8300                    h8300h-sim_defconfig
sh                          rsk7201_defconfig
arm                       omap2plus_defconfig
arm                         axm55xx_defconfig
arc                        vdk_hs38_defconfig
sh                     sh7710voipgw_defconfig
arm                        multi_v7_defconfig
mips                       bmips_be_defconfig
sh                     magicpanelr2_defconfig
openrisc                            defconfig
sh                   sh7770_generic_defconfig
arc                           tb10x_defconfig
arm                        oxnas_v6_defconfig
m68k                          hp300_defconfig
powerpc                      chrp32_defconfig
xtensa                         virt_defconfig
powerpc                        cell_defconfig
nios2                         3c120_defconfig
powerpc                     rainier_defconfig
powerpc                       ppc64_defconfig
sh                           se7721_defconfig
arm                       imx_v6_v7_defconfig
arm                           tegra_defconfig
s390                                defconfig
xtensa                    smp_lx200_defconfig
powerpc                           allnoconfig
arm                  randconfig-c002-20220116
arm                  randconfig-c002-20220117
arm                  randconfig-c002-20220118
arm                  randconfig-c002-20220119
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
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
x86_64               randconfig-a016-20220117
x86_64               randconfig-a012-20220117
x86_64               randconfig-a013-20220117
x86_64               randconfig-a011-20220117
x86_64               randconfig-a014-20220117
x86_64               randconfig-a015-20220117
i386                 randconfig-a012-20220117
i386                 randconfig-a016-20220117
i386                 randconfig-a014-20220117
i386                 randconfig-a015-20220117
i386                 randconfig-a011-20220117
i386                 randconfig-a013-20220117
riscv                randconfig-r042-20220119
riscv                randconfig-r042-20220117
arc                  randconfig-r043-20220116
arc                  randconfig-r043-20220117
s390                 randconfig-r044-20220119
s390                 randconfig-r044-20220117
arc                  randconfig-r043-20220118
arc                  randconfig-r043-20220119
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
x86_64                           allyesconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
arm                  randconfig-c002-20220116
x86_64                        randconfig-c007
arm                  randconfig-c002-20220118
arm                  randconfig-c002-20220119
riscv                randconfig-c006-20220119
riscv                randconfig-c006-20220118
riscv                randconfig-c006-20220116
powerpc              randconfig-c003-20220116
powerpc              randconfig-c003-20220119
powerpc              randconfig-c003-20220118
i386                          randconfig-c001
s390                 randconfig-c005-20220119
mips                 randconfig-c004-20220119
mips                 randconfig-c004-20220116
arm                                 defconfig
riscv                            alldefconfig
arm                            mmp2_defconfig
arm                       imx_v4_v5_defconfig
powerpc                     kilauea_defconfig
arm                  colibri_pxa300_defconfig
mips                           ip22_defconfig
powerpc                 mpc8315_rdb_defconfig
mips                   sb1250_swarm_defconfig
i386                             allyesconfig
powerpc               mpc834x_itxgp_defconfig
mips                      pic32mzda_defconfig
mips                        omega2p_defconfig
mips                        bcm63xx_defconfig
arm                           sama7_defconfig
powerpc                      ppc64e_defconfig
x86_64               randconfig-a005-20220117
x86_64               randconfig-a004-20220117
x86_64               randconfig-a001-20220117
x86_64               randconfig-a006-20220117
x86_64               randconfig-a002-20220117
x86_64               randconfig-a003-20220117
i386                 randconfig-a005-20220117
i386                 randconfig-a001-20220117
i386                 randconfig-a006-20220117
i386                 randconfig-a004-20220117
i386                 randconfig-a002-20220117
i386                 randconfig-a003-20220117
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
