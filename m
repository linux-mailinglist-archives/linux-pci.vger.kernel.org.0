Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B83A0430643
	for <lists+linux-pci@lfdr.de>; Sun, 17 Oct 2021 04:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244833AbhJQCnk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 16 Oct 2021 22:43:40 -0400
Received: from mga07.intel.com ([134.134.136.100]:33712 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231351AbhJQCnk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 16 Oct 2021 22:43:40 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10139"; a="291561713"
X-IronPort-AV: E=Sophos;i="5.85,379,1624345200"; 
   d="scan'208";a="291561713"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2021 19:41:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,379,1624345200"; 
   d="scan'208";a="482248879"
Received: from lkp-server02.sh.intel.com (HELO 08b2c502c3de) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 16 Oct 2021 19:41:29 -0700
Received: from kbuild by 08b2c502c3de with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mbw76-0009t1-Vg; Sun, 17 Oct 2021 02:41:28 +0000
Date:   Sun, 17 Oct 2021 10:41:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:next] BUILD SUCCESS
 8f0e5f43f76463351ded84c7c4da1f1fe82af13a
Message-ID: <616b8d54.qGOLfIEvgimhozA4%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
branch HEAD: 8f0e5f43f76463351ded84c7c4da1f1fe82af13a  Merge branch 'remotes/lorenzo/pci/xgene'

elapsed time: 723m

configs tested: 194
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                               defconfig
i386                 randconfig-c001-20211016
h8300                       h8s-sim_defconfig
arc                     haps_hs_smp_defconfig
powerpc                     tqm5200_defconfig
sh                             sh03_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                  defconfig
riscv                            alldefconfig
mips                        maltaup_defconfig
arm                           tegra_defconfig
arm                          collie_defconfig
powerpc                   bluestone_defconfig
arm                       netwinder_defconfig
sh                          rsk7201_defconfig
powerpc                       ebony_defconfig
s390                             alldefconfig
sh                        dreamcast_defconfig
openrisc                 simple_smp_defconfig
sh                          landisk_defconfig
mips                     loongson1b_defconfig
mips                           xway_defconfig
ia64                        generic_defconfig
arm                           h5000_defconfig
powerpc                      chrp32_defconfig
sparc                            allyesconfig
m68k                       m5249evb_defconfig
sparc64                             defconfig
arm                          iop32x_defconfig
nds32                            alldefconfig
arm                       mainstone_defconfig
mips                      maltasmvp_defconfig
mips                        nlm_xlp_defconfig
arc                         haps_hs_defconfig
arm                        keystone_defconfig
arm                  colibri_pxa270_defconfig
sh                        edosk7705_defconfig
sh                         ap325rxa_defconfig
sh                           se7751_defconfig
m68k                        m5272c3_defconfig
arm                           viper_defconfig
riscv                             allnoconfig
mips                            e55_defconfig
powerpc                     kmeter1_defconfig
parisc                generic-64bit_defconfig
csky                             alldefconfig
m68k                       m5275evb_defconfig
powerpc                        icon_defconfig
sh                          kfr2r09_defconfig
sh                         apsh4a3a_defconfig
arm                       versatile_defconfig
arm                            zeus_defconfig
arm                         s5pv210_defconfig
mips                             allmodconfig
m68k                                defconfig
m68k                          hp300_defconfig
arm                         axm55xx_defconfig
powerpc                     ep8248e_defconfig
powerpc                     sequoia_defconfig
sh                     magicpanelr2_defconfig
powerpc                 xes_mpc85xx_defconfig
riscv                               defconfig
microblaze                      mmu_defconfig
xtensa                    xip_kc705_defconfig
mips                     cu1000-neo_defconfig
powerpc                     mpc5200_defconfig
powerpc                      arches_defconfig
powerpc                  storcenter_defconfig
arm                        cerfcube_defconfig
arm                         assabet_defconfig
sh                 kfr2r09-romimage_defconfig
powerpc                     asp8347_defconfig
sparc                       sparc64_defconfig
mips                     decstation_defconfig
m68k                       bvme6000_defconfig
powerpc                    gamecube_defconfig
mips                           ip32_defconfig
mips                            gpr_defconfig
h8300                            allyesconfig
mips                           gcw0_defconfig
powerpc                  iss476-smp_defconfig
powerpc                  mpc866_ads_defconfig
arc                 nsimosci_hs_smp_defconfig
sh                          sdk7786_defconfig
ia64                          tiger_defconfig
powerpc                 mpc837x_rdb_defconfig
arm                  randconfig-c002-20211017
i386                 randconfig-c001-20211017
x86_64               randconfig-c001-20211017
arm                  randconfig-c002-20211016
x86_64               randconfig-c001-20211016
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
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
xtensa                           allyesconfig
parisc                              defconfig
s390                                defconfig
parisc                           allyesconfig
s390                             allyesconfig
s390                             allmodconfig
sparc                               defconfig
i386                                defconfig
i386                             allyesconfig
mips                             allyesconfig
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
x86_64               randconfig-a012-20211017
x86_64               randconfig-a015-20211017
x86_64               randconfig-a016-20211017
x86_64               randconfig-a014-20211017
x86_64               randconfig-a011-20211017
x86_64               randconfig-a013-20211017
i386                 randconfig-a016-20211017
i386                 randconfig-a014-20211017
i386                 randconfig-a011-20211017
i386                 randconfig-a015-20211017
i386                 randconfig-a012-20211017
i386                 randconfig-a013-20211017
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                            allyesconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                           allyesconfig

clang tested configs:
mips                 randconfig-c004-20211017
arm                  randconfig-c002-20211017
i386                 randconfig-c001-20211017
s390                 randconfig-c005-20211017
x86_64               randconfig-c007-20211017
powerpc              randconfig-c003-20211017
riscv                randconfig-c006-20211017
i386                 randconfig-a003-20211017
i386                 randconfig-a001-20211017
i386                 randconfig-a005-20211017
i386                 randconfig-a004-20211017
i386                 randconfig-a002-20211017
i386                 randconfig-a006-20211017
x86_64               randconfig-a006-20211017
x86_64               randconfig-a004-20211017
x86_64               randconfig-a001-20211017
x86_64               randconfig-a005-20211017
x86_64               randconfig-a002-20211017
x86_64               randconfig-a003-20211017
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
hexagon              randconfig-r041-20211017
hexagon              randconfig-r045-20211017
hexagon              randconfig-r041-20211016
s390                 randconfig-r044-20211016
riscv                randconfig-r042-20211016
hexagon              randconfig-r045-20211016

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
