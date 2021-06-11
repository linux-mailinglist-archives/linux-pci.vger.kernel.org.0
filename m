Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C23B3A413F
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jun 2021 13:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbhFKLcO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Jun 2021 07:32:14 -0400
Received: from mga09.intel.com ([134.134.136.24]:42551 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229969AbhFKLcO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 11 Jun 2021 07:32:14 -0400
IronPort-SDR: nrUICmM0z/pX7ENpW24t67+W7GCx3kDAYuIHA68b78vNh2k1UV7HwCOsfVsZdmlx2qXRnZW9ka
 wel0gC7syt/w==
X-IronPort-AV: E=McAfee;i="6200,9189,10011"; a="205466210"
X-IronPort-AV: E=Sophos;i="5.83,265,1616482800"; 
   d="scan'208";a="205466210"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2021 04:30:16 -0700
IronPort-SDR: 9i9lxfQE5uya1polkuinQ1esNkAFsIDecJXF7ZFWTpEEd8M1pqHHN3cFT0M3OQV2geZe3BAOUb
 n/43/bcGX1HA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,265,1616482800"; 
   d="scan'208";a="483235289"
Received: from lkp-server02.sh.intel.com (HELO 3cb98b298c7e) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 11 Jun 2021 04:30:13 -0700
Received: from kbuild by 3cb98b298c7e with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lrfMc-0000Zf-1h; Fri, 11 Jun 2021 11:30:14 +0000
Date:   Fri, 11 Jun 2021 19:30:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:pci/p2pdma] BUILD SUCCESS
 3ec0c3ec2d92c09465534a1ff9c6f9d9506ffef6
Message-ID: <60c3493a.v3wFxugzSHZcGT+b%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/p2pdma
branch HEAD: 3ec0c3ec2d92c09465534a1ff9c6f9d9506ffef6  PCI/P2PDMA: Avoid pci_get_slot(), which may sleep

elapsed time: 722m

configs tested: 168
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                      chrp32_defconfig
mips                          rm200_defconfig
arc                            hsdk_defconfig
mips                      pistachio_defconfig
arc                     nsimosci_hs_defconfig
arm                      jornada720_defconfig
arc                        vdk_hs38_defconfig
powerpc                 mpc832x_mds_defconfig
mips                        vocore2_defconfig
arc                        nsimosci_defconfig
arm                              alldefconfig
ia64                                defconfig
riscv             nommu_k210_sdcard_defconfig
arm                        multi_v5_defconfig
powerpc                     kilauea_defconfig
mips                   sb1250_swarm_defconfig
arm                        spear6xx_defconfig
arm                           stm32_defconfig
sh                   sh7770_generic_defconfig
arm                         s5pv210_defconfig
sh                          rsk7201_defconfig
arm                        shmobile_defconfig
m68k                          sun3x_defconfig
x86_64                              defconfig
alpha                            allyesconfig
arm                          pxa910_defconfig
sh                   rts7751r2dplus_defconfig
arm                         hackkit_defconfig
sh                          kfr2r09_defconfig
mips                        jmr3927_defconfig
arm                     am200epdkit_defconfig
mips                           ip22_defconfig
arm                     eseries_pxa_defconfig
sh                          r7780mp_defconfig
arm                        mini2440_defconfig
arm                       mainstone_defconfig
powerpc                      ep88xc_defconfig
powerpc                       ppc64_defconfig
powerpc                     tqm8540_defconfig
riscv                    nommu_k210_defconfig
nios2                               defconfig
sh                          sdk7780_defconfig
sparc64                             defconfig
sh                            shmin_defconfig
h8300                            alldefconfig
arm                  colibri_pxa300_defconfig
arm                       imx_v4_v5_defconfig
h8300                     edosk2674_defconfig
powerpc64                           defconfig
mips                         rt305x_defconfig
powerpc                      tqm8xx_defconfig
nios2                         3c120_defconfig
microblaze                      mmu_defconfig
xtensa                generic_kc705_defconfig
sh                          rsk7269_defconfig
sh                 kfr2r09-romimage_defconfig
sh                          sdk7786_defconfig
i386                                defconfig
sh                              ul2_defconfig
microblaze                          defconfig
m68k                        stmark2_defconfig
powerpc                    ge_imp3a_defconfig
i386                             alldefconfig
m68k                          atari_defconfig
m68k                         amcore_defconfig
mips                     loongson2k_defconfig
arm                      tct_hammer_defconfig
m68k                        mvme16x_defconfig
mips                       bmips_be_defconfig
arm                            mps2_defconfig
powerpc                     rainier_defconfig
powerpc                      ppc6xx_defconfig
um                               alldefconfig
powerpc                 mpc836x_mds_defconfig
arc                          axs103_defconfig
mips                        omega2p_defconfig
sh                           se7712_defconfig
powerpc                     kmeter1_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
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
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a002-20210611
i386                 randconfig-a006-20210611
i386                 randconfig-a004-20210611
i386                 randconfig-a001-20210611
i386                 randconfig-a005-20210611
i386                 randconfig-a003-20210611
i386                 randconfig-a002-20210610
i386                 randconfig-a006-20210610
i386                 randconfig-a004-20210610
i386                 randconfig-a001-20210610
i386                 randconfig-a005-20210610
i386                 randconfig-a003-20210610
x86_64               randconfig-a002-20210611
x86_64               randconfig-a001-20210611
x86_64               randconfig-a004-20210611
x86_64               randconfig-a003-20210611
x86_64               randconfig-a006-20210611
x86_64               randconfig-a005-20210611
x86_64               randconfig-a015-20210610
x86_64               randconfig-a011-20210610
x86_64               randconfig-a012-20210610
x86_64               randconfig-a014-20210610
x86_64               randconfig-a016-20210610
x86_64               randconfig-a013-20210610
i386                 randconfig-a015-20210611
i386                 randconfig-a013-20210611
i386                 randconfig-a016-20210611
i386                 randconfig-a014-20210611
i386                 randconfig-a012-20210611
i386                 randconfig-a011-20210611
i386                 randconfig-a015-20210610
i386                 randconfig-a013-20210610
i386                 randconfig-a016-20210610
i386                 randconfig-a014-20210610
i386                 randconfig-a012-20210610
i386                 randconfig-a011-20210610
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
um                            kunit_defconfig
x86_64                    rhel-8.3-kselftests
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a015-20210611
x86_64               randconfig-a011-20210611
x86_64               randconfig-a012-20210611
x86_64               randconfig-a014-20210611
x86_64               randconfig-a016-20210611
x86_64               randconfig-a013-20210611

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
