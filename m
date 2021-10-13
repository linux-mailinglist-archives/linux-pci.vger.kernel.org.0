Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5D5B42CC69
	for <lists+linux-pci@lfdr.de>; Wed, 13 Oct 2021 22:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbhJMVA2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Oct 2021 17:00:28 -0400
Received: from mga02.intel.com ([134.134.136.20]:29934 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229496AbhJMVA2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Oct 2021 17:00:28 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10136"; a="214691757"
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; 
   d="scan'208";a="214691757"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2021 13:53:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; 
   d="scan'208";a="491641555"
Received: from lkp-server02.sh.intel.com (HELO 08b2c502c3de) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 13 Oct 2021 13:53:38 -0700
Received: from kbuild by 08b2c502c3de with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1malFq-00058Z-B1; Wed, 13 Oct 2021 20:53:38 +0000
Date:   Thu, 14 Oct 2021 04:53:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/misc] BUILD SUCCESS
 e98754233c58bfe7cad67ed4b7f3980d7e0d731d
Message-ID: <61674740.qiOQNZwJFQL3DKT3%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/misc
branch HEAD: e98754233c58bfe7cad67ed4b7f3980d7e0d731d  PCI: cpqphp: Format if-statement code block correctly

elapsed time: 1107m

configs tested: 189
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allmodconfig
arm                              allyesconfig
i386                 randconfig-c001-20211013
powerpc                         ps3_defconfig
mips                     cu1000-neo_defconfig
arm                       spear13xx_defconfig
arm                          pxa168_defconfig
arc                     nsimosci_hs_defconfig
arm                        shmobile_defconfig
sh                          r7780mp_defconfig
powerpc                 linkstation_defconfig
mips                      malta_kvm_defconfig
arm                           sama7_defconfig
powerpc                 mpc834x_itx_defconfig
m68k                       m5249evb_defconfig
csky                             alldefconfig
mips                            e55_defconfig
arm                  colibri_pxa300_defconfig
powerpc                       maple_defconfig
sh                 kfr2r09-romimage_defconfig
powerpc                 mpc8313_rdb_defconfig
sh                              ul2_defconfig
powerpc                    sam440ep_defconfig
h8300                     edosk2674_defconfig
arc                 nsimosci_hs_smp_defconfig
arm                             ezx_defconfig
powerpc                      tqm8xx_defconfig
arm                        clps711x_defconfig
powerpc                        cell_defconfig
mips                 decstation_r4k_defconfig
arm                        multi_v7_defconfig
powerpc                  mpc866_ads_defconfig
powerpc                      mgcoge_defconfig
sh                           se7724_defconfig
powerpc                 mpc832x_mds_defconfig
mips                  decstation_64_defconfig
h8300                            allyesconfig
sh                             sh03_defconfig
powerpc                     asp8347_defconfig
riscv                    nommu_virt_defconfig
powerpc                      ppc6xx_defconfig
xtensa                  audio_kc705_defconfig
powerpc               mpc834x_itxgp_defconfig
m68k                          amiga_defconfig
mips                           xway_defconfig
m68k                         amcore_defconfig
arm                        mini2440_defconfig
arm                     eseries_pxa_defconfig
sh                           se7751_defconfig
arm                        spear6xx_defconfig
parisc                generic-32bit_defconfig
arm                          iop32x_defconfig
mips                        bcm47xx_defconfig
ia64                          tiger_defconfig
mips                        jmr3927_defconfig
powerpc                 mpc837x_mds_defconfig
mips                           ip28_defconfig
sparc                       sparc64_defconfig
mips                          ath25_defconfig
sh                   sh7724_generic_defconfig
arc                    vdk_hs38_smp_defconfig
arc                              alldefconfig
arm                           tegra_defconfig
mips                   sb1250_swarm_defconfig
arm                         s3c6400_defconfig
powerpc                    klondike_defconfig
arm                        magician_defconfig
mips                           ip32_defconfig
arm                         lpc18xx_defconfig
arc                        vdk_hs38_defconfig
mips                     loongson2k_defconfig
arm                           u8500_defconfig
powerpc                       holly_defconfig
um                                  defconfig
powerpc                   bluestone_defconfig
sh                          polaris_defconfig
powerpc                      ppc64e_defconfig
arm                       netwinder_defconfig
arc                          axs101_defconfig
arm                         at91_dt_defconfig
sh                        edosk7705_defconfig
s390                          debug_defconfig
sh                        apsh4ad0a_defconfig
arm                  randconfig-c002-20211013
x86_64               randconfig-c001-20211013
arm                  randconfig-c002-20211012
i386                 randconfig-c001-20211012
x86_64               randconfig-c001-20211012
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
nds32                             allnoconfig
arc                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
parisc                              defconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allyesconfig
s390                             allmodconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                             allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20211012
x86_64               randconfig-a006-20211012
x86_64               randconfig-a001-20211012
x86_64               randconfig-a005-20211012
x86_64               randconfig-a002-20211012
x86_64               randconfig-a003-20211012
i386                 randconfig-a001-20211012
i386                 randconfig-a003-20211012
i386                 randconfig-a004-20211012
i386                 randconfig-a005-20211012
i386                 randconfig-a002-20211012
i386                 randconfig-a006-20211012
x86_64               randconfig-a015-20211013
x86_64               randconfig-a012-20211013
x86_64               randconfig-a016-20211013
x86_64               randconfig-a014-20211013
x86_64               randconfig-a013-20211013
x86_64               randconfig-a011-20211013
i386                 randconfig-a016-20211013
i386                 randconfig-a014-20211013
i386                 randconfig-a011-20211013
i386                 randconfig-a015-20211013
i386                 randconfig-a012-20211013
i386                 randconfig-a013-20211013
arc                  randconfig-r043-20211012
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allyesconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                           allyesconfig

clang tested configs:
arm                  randconfig-c002-20211013
mips                 randconfig-c004-20211013
i386                 randconfig-c001-20211013
s390                 randconfig-c005-20211013
x86_64               randconfig-c007-20211013
powerpc              randconfig-c003-20211013
riscv                randconfig-c006-20211013
x86_64               randconfig-a004-20211013
x86_64               randconfig-a006-20211013
x86_64               randconfig-a001-20211013
x86_64               randconfig-a005-20211013
x86_64               randconfig-a002-20211013
x86_64               randconfig-a003-20211013
i386                 randconfig-a001-20211013
i386                 randconfig-a003-20211013
i386                 randconfig-a004-20211013
i386                 randconfig-a005-20211013
i386                 randconfig-a002-20211013
i386                 randconfig-a006-20211013
x86_64               randconfig-a015-20211012
x86_64               randconfig-a012-20211012
x86_64               randconfig-a016-20211012
x86_64               randconfig-a014-20211012
x86_64               randconfig-a013-20211012
x86_64               randconfig-a011-20211012
hexagon              randconfig-r041-20211012
s390                 randconfig-r044-20211012
riscv                randconfig-r042-20211012
hexagon              randconfig-r045-20211012
hexagon              randconfig-r041-20211013
hexagon              randconfig-r045-20211013

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
