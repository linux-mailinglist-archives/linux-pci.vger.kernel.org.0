Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD2D4544B7
	for <lists+linux-pci@lfdr.de>; Wed, 17 Nov 2021 11:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235992AbhKQKNu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Nov 2021 05:13:50 -0500
Received: from mga14.intel.com ([192.55.52.115]:60731 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236033AbhKQKNs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 17 Nov 2021 05:13:48 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10170"; a="234155131"
X-IronPort-AV: E=Sophos;i="5.87,241,1631602800"; 
   d="scan'208";a="234155131"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2021 02:10:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,241,1631602800"; 
   d="scan'208";a="536231102"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 17 Nov 2021 02:10:47 -0800
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mnHtv-0001WR-7U; Wed, 17 Nov 2021 10:10:47 +0000
Date:   Wed, 17 Nov 2021 18:10:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:next] BUILD SUCCESS
 45e8e14b69560171d72eab29a7dd102533e16265
Message-ID: <6194d509.UCwpL+jxfHYcC3I7%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
branch HEAD: 45e8e14b69560171d72eab29a7dd102533e16265  Merge branch 'pci/enumeration'

elapsed time: 731m

configs tested: 164
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                        mini2440_defconfig
microblaze                          defconfig
s390                       zfcpdump_defconfig
powerpc                    adder875_defconfig
ia64                                defconfig
sh                         apsh4a3a_defconfig
arm                          ep93xx_defconfig
mips                          ath79_defconfig
sh                         ecovec24_defconfig
powerpc                     pq2fads_defconfig
powerpc                      walnut_defconfig
arm                             mxs_defconfig
powerpc                      makalu_defconfig
mips                   sb1250_swarm_defconfig
arm                            hisi_defconfig
ia64                            zx1_defconfig
arc                          axs103_defconfig
powerpc                     powernv_defconfig
sh                            titan_defconfig
sparc64                             defconfig
powerpc                     tqm8555_defconfig
arm                       multi_v4t_defconfig
arm                         axm55xx_defconfig
arm                           sama5_defconfig
arm                           stm32_defconfig
arm                       spear13xx_defconfig
ia64                             alldefconfig
mips                          rm200_defconfig
powerpc                    socrates_defconfig
mips                      malta_kvm_defconfig
m68k                          atari_defconfig
mips                      bmips_stb_defconfig
nios2                         3c120_defconfig
arm                       mainstone_defconfig
powerpc                         wii_defconfig
powerpc                     mpc512x_defconfig
powerpc                 mpc85xx_cds_defconfig
sh                 kfr2r09-romimage_defconfig
x86_64                              defconfig
riscv             nommu_k210_sdcard_defconfig
powerpc                        cell_defconfig
sh                   sh7724_generic_defconfig
sh                          rsk7264_defconfig
m68k                         apollo_defconfig
sh                            shmin_defconfig
h8300                            alldefconfig
arc                         haps_hs_defconfig
arc                     nsimosci_hs_defconfig
sh                        apsh4ad0a_defconfig
arm                         s3c2410_defconfig
nios2                         10m50_defconfig
powerpc                  storcenter_defconfig
xtensa                           alldefconfig
arm                         nhk8815_defconfig
arm                  randconfig-c002-20211117
arm                  randconfig-c002-20211116
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                             allnoconfig
nios2                               defconfig
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
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a005-20211117
x86_64               randconfig-a003-20211117
x86_64               randconfig-a002-20211117
x86_64               randconfig-a001-20211117
x86_64               randconfig-a006-20211117
x86_64               randconfig-a004-20211117
i386                 randconfig-a006-20211117
i386                 randconfig-a003-20211117
i386                 randconfig-a005-20211117
i386                 randconfig-a001-20211117
i386                 randconfig-a004-20211117
i386                 randconfig-a002-20211117
x86_64               randconfig-a015-20211116
x86_64               randconfig-a013-20211116
x86_64               randconfig-a012-20211116
x86_64               randconfig-a011-20211116
x86_64               randconfig-a016-20211116
x86_64               randconfig-a014-20211116
i386                 randconfig-a012-20211116
i386                 randconfig-a013-20211116
i386                 randconfig-a011-20211116
i386                 randconfig-a015-20211116
i386                 randconfig-a014-20211116
i386                 randconfig-a016-20211116
arc                  randconfig-r043-20211116
s390                 randconfig-r044-20211116
riscv                randconfig-r042-20211116
riscv                             allnoconfig
riscv                               defconfig
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a005-20211116
x86_64               randconfig-a003-20211116
x86_64               randconfig-a001-20211116
x86_64               randconfig-a002-20211116
x86_64               randconfig-a006-20211116
x86_64               randconfig-a004-20211116
i386                 randconfig-a006-20211116
i386                 randconfig-a003-20211116
i386                 randconfig-a005-20211116
i386                 randconfig-a001-20211116
i386                 randconfig-a004-20211116
i386                 randconfig-a002-20211116
x86_64               randconfig-a015-20211117
x86_64               randconfig-a013-20211117
x86_64               randconfig-a011-20211117
x86_64               randconfig-a012-20211117
x86_64               randconfig-a016-20211117
x86_64               randconfig-a014-20211117
i386                 randconfig-a014-20211117
i386                 randconfig-a016-20211117
i386                 randconfig-a012-20211117
i386                 randconfig-a013-20211117
i386                 randconfig-a011-20211117
i386                 randconfig-a015-20211117
hexagon              randconfig-r041-20211116
hexagon              randconfig-r045-20211116
hexagon              randconfig-r045-20211117
hexagon              randconfig-r041-20211117
s390                 randconfig-r044-20211117
riscv                randconfig-r042-20211117

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
