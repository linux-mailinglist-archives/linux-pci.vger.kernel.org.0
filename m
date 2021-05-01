Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D72DF3706C0
	for <lists+linux-pci@lfdr.de>; Sat,  1 May 2021 12:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbhEAKFq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 1 May 2021 06:05:46 -0400
Received: from mga17.intel.com ([192.55.52.151]:26340 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231252AbhEAKFq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 1 May 2021 06:05:46 -0400
IronPort-SDR: 0yvnjs0273pDgIQYwgc5zVc1d0ecwvC77u7xXaVeritcLSgugZyz4CNzEP3jKKpDO4PklSHYcH
 1piHN88SHAFA==
X-IronPort-AV: E=McAfee;i="6200,9189,9970"; a="177614864"
X-IronPort-AV: E=Sophos;i="5.82,264,1613462400"; 
   d="scan'208";a="177614864"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2021 03:04:56 -0700
IronPort-SDR: ohP+uqSrhVFGvygwCP90MwN7nnYTuU34kpKljFNobk11oZhq3LFUIL/nfZTWHcKPyDZ2aBdvTW
 0Gi5xsXYGnsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,264,1613462400"; 
   d="scan'208";a="431861456"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 01 May 2021 03:04:54 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lcmUY-0008WH-7d; Sat, 01 May 2021 10:04:54 +0000
Date:   Sat, 01 May 2021 18:04:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS 191f214ad36a21cf5e88a90ca849ff29fef27d39
Message-ID: <608d27bf.yd6q7lOfSvupZCBk%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
branch HEAD: 191f214ad36a21cf5e88a90ca849ff29fef27d39  Merge branch 'pci/tegra'

elapsed time: 723m

configs tested: 149
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
x86_64                           allyesconfig
riscv                            allmodconfig
i386                             allyesconfig
riscv                            allyesconfig
arm                          gemini_defconfig
powerpc                 mpc832x_mds_defconfig
arm                         palmz72_defconfig
powerpc                     tqm8560_defconfig
mips                     loongson1b_defconfig
powerpc                     rainier_defconfig
mips                       capcella_defconfig
arm                  colibri_pxa270_defconfig
arm                        shmobile_defconfig
mips                malta_qemu_32r6_defconfig
m68k                          multi_defconfig
sh                           se7780_defconfig
sh                           se7712_defconfig
powerpc                      ppc40x_defconfig
m68k                        m5407c3_defconfig
sh                      rts7751r2d1_defconfig
m68k                       m5208evb_defconfig
powerpc                          g5_defconfig
i386                                defconfig
s390                             alldefconfig
sh                           se7750_defconfig
powerpc                    ge_imp3a_defconfig
ia64                        generic_defconfig
powerpc                      bamboo_defconfig
arm                        oxnas_v6_defconfig
mips                         rt305x_defconfig
powerpc                      katmai_defconfig
powerpc                     pseries_defconfig
mips                      loongson3_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                         ps3_defconfig
powerpc                     tqm8541_defconfig
arm                         axm55xx_defconfig
mips                     decstation_defconfig
arm                        trizeps4_defconfig
arm                         cm_x300_defconfig
m68k                          hp300_defconfig
xtensa                         virt_defconfig
arm                           sunxi_defconfig
xtensa                           allyesconfig
parisc                              defconfig
mips                        jmr3927_defconfig
mips                          ath79_defconfig
m68k                        stmark2_defconfig
nds32                            alldefconfig
arm                       mainstone_defconfig
powerpc                     mpc83xx_defconfig
h8300                               defconfig
sh                           se7619_defconfig
arm                       spear13xx_defconfig
mips                           gcw0_defconfig
powerpc                   lite5200b_defconfig
xtensa                    smp_lx200_defconfig
powerpc                  storcenter_defconfig
sparc                       sparc32_defconfig
arm                          pxa168_defconfig
parisc                           alldefconfig
powerpc                      mgcoge_defconfig
arc                 nsimosci_hs_smp_defconfig
powerpc                        fsp2_defconfig
h8300                    h8300h-sim_defconfig
sh                     magicpanelr2_defconfig
ia64                             allmodconfig
ia64                             allyesconfig
ia64                                defconfig
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
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a003-20210430
x86_64               randconfig-a004-20210430
x86_64               randconfig-a002-20210430
x86_64               randconfig-a006-20210430
x86_64               randconfig-a001-20210430
x86_64               randconfig-a005-20210430
i386                 randconfig-a004-20210430
i386                 randconfig-a001-20210430
i386                 randconfig-a003-20210430
i386                 randconfig-a002-20210430
i386                 randconfig-a005-20210430
i386                 randconfig-a006-20210430
i386                 randconfig-a003-20210501
i386                 randconfig-a006-20210501
i386                 randconfig-a001-20210501
i386                 randconfig-a005-20210501
i386                 randconfig-a004-20210501
i386                 randconfig-a002-20210501
i386                 randconfig-a013-20210430
i386                 randconfig-a011-20210430
i386                 randconfig-a016-20210430
i386                 randconfig-a015-20210430
i386                 randconfig-a012-20210430
i386                 randconfig-a014-20210430
i386                 randconfig-a013-20210501
i386                 randconfig-a015-20210501
i386                 randconfig-a016-20210501
i386                 randconfig-a014-20210501
i386                 randconfig-a011-20210501
i386                 randconfig-a012-20210501
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a011-20210430
x86_64               randconfig-a016-20210430
x86_64               randconfig-a013-20210430
x86_64               randconfig-a014-20210430
x86_64               randconfig-a012-20210430
x86_64               randconfig-a015-20210430

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
