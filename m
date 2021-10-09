Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3473427C00
	for <lists+linux-pci@lfdr.de>; Sat,  9 Oct 2021 18:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbhJIQbv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 9 Oct 2021 12:31:51 -0400
Received: from mga02.intel.com ([134.134.136.20]:6134 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229587AbhJIQbv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 9 Oct 2021 12:31:51 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10132"; a="213816106"
X-IronPort-AV: E=Sophos;i="5.85,360,1624345200"; 
   d="scan'208";a="213816106"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2021 09:29:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,360,1624345200"; 
   d="scan'208";a="479319210"
Received: from lkp-server02.sh.intel.com (HELO 08b2c502c3de) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 09 Oct 2021 09:29:52 -0700
Received: from kbuild by 08b2c502c3de with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mZFEN-0000O0-QC; Sat, 09 Oct 2021 16:29:51 +0000
Date:   Sun, 10 Oct 2021 00:29:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/host/rcar] BUILD SUCCESS
 861e133ba268bef4765ea62c9602d4116b9c63ec
Message-ID: <6161c35d.WrlXG+nwAjvop2B/%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/host/rcar
branch HEAD: 861e133ba268bef4765ea62c9602d4116b9c63ec  PCI: rcar-host: Remove unneeded includes

elapsed time: 1494m

configs tested: 220
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allmodconfig
arm                              allyesconfig
i386                 randconfig-c001-20211009
i386                 randconfig-c001-20211008
powerpc              randconfig-c003-20211009
sh                           se7206_defconfig
sh                   sh7724_generic_defconfig
powerpc                      pasemi_defconfig
x86_64                              defconfig
arm                        cerfcube_defconfig
s390                          debug_defconfig
parisc                generic-32bit_defconfig
m68k                       bvme6000_defconfig
arm                            hisi_defconfig
nios2                         10m50_defconfig
mips                       capcella_defconfig
arm                        trizeps4_defconfig
powerpc                 mpc85xx_cds_defconfig
arc                         haps_hs_defconfig
mips                    maltaup_xpa_defconfig
mips                          rb532_defconfig
riscv             nommu_k210_sdcard_defconfig
xtensa                          iss_defconfig
arc                     haps_hs_smp_defconfig
arm                        mvebu_v5_defconfig
powerpc                       holly_defconfig
powerpc                    gamecube_defconfig
mips                       lemote2f_defconfig
sh                        sh7763rdp_defconfig
mips                        jmr3927_defconfig
mips                       rbtx49xx_defconfig
arm                           h5000_defconfig
m68k                        m5272c3_defconfig
arc                              allyesconfig
mips                        omega2p_defconfig
sh                        dreamcast_defconfig
m68k                         amcore_defconfig
arm                      pxa255-idp_defconfig
mips                            gpr_defconfig
mips                           gcw0_defconfig
s390                                defconfig
powerpc                     pq2fads_defconfig
mips                         mpc30x_defconfig
m68k                          multi_defconfig
powerpc                    sam440ep_defconfig
arm                       omap2plus_defconfig
ia64                                defconfig
powerpc                     tqm8548_defconfig
arm                         axm55xx_defconfig
arm                           stm32_defconfig
powerpc                     pseries_defconfig
xtensa                           alldefconfig
powerpc                     mpc83xx_defconfig
powerpc                          allyesconfig
sh                          rsk7264_defconfig
xtensa                    xip_kc705_defconfig
nds32                             allnoconfig
powerpc                 mpc8560_ads_defconfig
m68k                        stmark2_defconfig
sh                      rts7751r2d1_defconfig
m68k                          atari_defconfig
arm                             mxs_defconfig
sh                   sh7770_generic_defconfig
arm                        mvebu_v7_defconfig
powerpc                  mpc885_ads_defconfig
arm                       imx_v4_v5_defconfig
arm                          collie_defconfig
sh                               allmodconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                   currituck_defconfig
sh                            hp6xx_defconfig
ia64                             alldefconfig
arm                         bcm2835_defconfig
powerpc                 mpc832x_mds_defconfig
arm                            xcep_defconfig
mips                           rs90_defconfig
mips                        bcm63xx_defconfig
mips                malta_qemu_32r6_defconfig
powerpc                          g5_defconfig
arm                        keystone_defconfig
riscv                               defconfig
sh                            titan_defconfig
arm                        vexpress_defconfig
powerpc                      ppc40x_defconfig
um                                  defconfig
mips                           ip22_defconfig
mips                   sb1250_swarm_defconfig
mips                         tb0219_defconfig
arc                            hsdk_defconfig
sh                        apsh4ad0a_defconfig
mips                  decstation_64_defconfig
sh                        sh7785lcr_defconfig
m68k                         apollo_defconfig
openrisc                            defconfig
powerpc                      arches_defconfig
sh                   secureedge5410_defconfig
m68k                            mac_defconfig
xtensa                       common_defconfig
arm                          gemini_defconfig
m68k                            q40_defconfig
csky                                defconfig
microblaze                      mmu_defconfig
sh                  sh7785lcr_32bit_defconfig
m68k                             allyesconfig
sh                               j2_defconfig
sh                            shmin_defconfig
sh                           se7619_defconfig
sh                           se7721_defconfig
powerpc                 mpc836x_rdk_defconfig
xtensa                generic_kc705_defconfig
mips                         db1xxx_defconfig
arm                          ep93xx_defconfig
powerpc                   microwatt_defconfig
m68k                        m5307c3_defconfig
arm                   milbeaut_m10v_defconfig
arm                  colibri_pxa270_defconfig
arm                            mps2_defconfig
sh                          lboxre2_defconfig
mips                           xway_defconfig
arm                     eseries_pxa_defconfig
x86_64               randconfig-c001-20211008
arm                  randconfig-c002-20211008
x86_64               randconfig-c001-20211009
arm                  randconfig-c002-20211009
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
nds32                               defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
parisc                              defconfig
parisc                           allyesconfig
s390                             allyesconfig
s390                             allmodconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                             allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20211009
i386                 randconfig-a003-20211009
i386                 randconfig-a005-20211009
i386                 randconfig-a004-20211009
i386                 randconfig-a002-20211009
i386                 randconfig-a006-20211009
x86_64               randconfig-a015-20211008
x86_64               randconfig-a012-20211008
x86_64               randconfig-a016-20211008
x86_64               randconfig-a013-20211008
x86_64               randconfig-a011-20211008
x86_64               randconfig-a014-20211008
i386                 randconfig-a013-20211008
i386                 randconfig-a016-20211008
i386                 randconfig-a014-20211008
i386                 randconfig-a011-20211008
i386                 randconfig-a012-20211008
i386                 randconfig-a015-20211008
x86_64               randconfig-a003-20211009
x86_64               randconfig-a005-20211009
x86_64               randconfig-a001-20211009
x86_64               randconfig-a002-20211009
x86_64               randconfig-a004-20211009
x86_64               randconfig-a006-20211009
arc                  randconfig-r043-20211008
s390                 randconfig-r044-20211008
riscv                randconfig-r042-20211008
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-c007-20211009
i386                 randconfig-c001-20211009
arm                  randconfig-c002-20211009
s390                 randconfig-c005-20211009
powerpc              randconfig-c003-20211009
riscv                randconfig-c006-20211009
mips                 randconfig-c004-20211009
x86_64               randconfig-a003-20211008
x86_64               randconfig-a005-20211008
x86_64               randconfig-a001-20211008
x86_64               randconfig-a002-20211008
x86_64               randconfig-a004-20211008
x86_64               randconfig-a006-20211008
i386                 randconfig-a001-20211008
i386                 randconfig-a003-20211008
i386                 randconfig-a005-20211008
i386                 randconfig-a004-20211008
i386                 randconfig-a002-20211008
i386                 randconfig-a006-20211008
x86_64               randconfig-a015-20211009
x86_64               randconfig-a012-20211009
x86_64               randconfig-a016-20211009
x86_64               randconfig-a013-20211009
x86_64               randconfig-a011-20211009
x86_64               randconfig-a014-20211009
i386                 randconfig-a013-20211009
i386                 randconfig-a016-20211009
i386                 randconfig-a014-20211009
i386                 randconfig-a012-20211009
i386                 randconfig-a011-20211009
i386                 randconfig-a015-20211009
hexagon              randconfig-r045-20211008
hexagon              randconfig-r041-20211008

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
