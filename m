Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56500427DC9
	for <lists+linux-pci@lfdr.de>; Sun, 10 Oct 2021 00:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbhJIWB4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 9 Oct 2021 18:01:56 -0400
Received: from mga04.intel.com ([192.55.52.120]:50485 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231201AbhJIWB4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 9 Oct 2021 18:01:56 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10132"; a="225464523"
X-IronPort-AV: E=Sophos;i="5.85,361,1624345200"; 
   d="scan'208";a="225464523"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2021 14:59:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,361,1624345200"; 
   d="scan'208";a="440294974"
Received: from lkp-server02.sh.intel.com (HELO 08b2c502c3de) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 09 Oct 2021 14:59:57 -0700
Received: from kbuild by 08b2c502c3de with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mZKNo-0000cM-QK; Sat, 09 Oct 2021 21:59:56 +0000
Date:   Sun, 10 Oct 2021 05:59:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/misc] BUILD SUCCESS
 b2105b9f39b57ac80fb909b7ae4da3d343af9f7d
Message-ID: <616210b5.zN5n+fN8OuKmuGuc%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/misc
branch HEAD: b2105b9f39b57ac80fb909b7ae4da3d343af9f7d  PCI: Correct misspelled and remove duplicated words

elapsed time: 1377m

configs tested: 236
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                              allmodconfig
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
i386                 randconfig-c001-20211009
i386                 randconfig-c001-20211008
powerpc              randconfig-c003-20211009
sh                          sdk7786_defconfig
arm                           stm32_defconfig
arm                             ezx_defconfig
arm                          exynos_defconfig
s390                          debug_defconfig
parisc                generic-32bit_defconfig
m68k                       bvme6000_defconfig
arm                            hisi_defconfig
nios2                         10m50_defconfig
mips                       capcella_defconfig
arm                        trizeps4_defconfig
powerpc                 mpc85xx_cds_defconfig
powerpc                    sam440ep_defconfig
powerpc                      tqm8xx_defconfig
sh                          rsk7269_defconfig
arm                             mxs_defconfig
m68k                        mvme147_defconfig
sh                            shmin_defconfig
powerpc                      pcm030_defconfig
um                             i386_defconfig
arm                            xcep_defconfig
arm                         lpc32xx_defconfig
mips                      maltaaprp_defconfig
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
mips                           gcw0_defconfig
powerpc                     pq2fads_defconfig
mips                         mpc30x_defconfig
m68k                          multi_defconfig
arm                       omap2plus_defconfig
ia64                                defconfig
powerpc                     tqm8548_defconfig
powerpc                  mpc885_ads_defconfig
arm                         at91_dt_defconfig
arm                       cns3420vb_defconfig
mips                          ath25_defconfig
xtensa                  cadence_csp_defconfig
arm                         axm55xx_defconfig
powerpc                     pseries_defconfig
xtensa                           alldefconfig
powerpc                     mpc83xx_defconfig
powerpc                          allyesconfig
sh                      rts7751r2d1_defconfig
m68k                          atari_defconfig
sh                   sh7770_generic_defconfig
arm                        mvebu_v7_defconfig
arm                       imx_v4_v5_defconfig
arm                          collie_defconfig
sh                           se7206_defconfig
sh                               allmodconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                      pasemi_defconfig
powerpc                   currituck_defconfig
sh                            hp6xx_defconfig
ia64                             alldefconfig
arm                         bcm2835_defconfig
powerpc                 mpc832x_mds_defconfig
mips                           rs90_defconfig
mips                        bcm63xx_defconfig
mips                     loongson1b_defconfig
arm64                            alldefconfig
sh                             espt_defconfig
riscv                             allnoconfig
arm                          ixp4xx_defconfig
powerpc                      mgcoge_defconfig
mips                           mtx1_defconfig
sh                           se7712_defconfig
sh                   secureedge5410_defconfig
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
arm                          gemini_defconfig
m68k                            q40_defconfig
csky                                defconfig
microblaze                      mmu_defconfig
sh                  sh7785lcr_32bit_defconfig
m68k                             allyesconfig
sh                               j2_defconfig
sh                           se7619_defconfig
sh                           se7721_defconfig
powerpc                 mpc836x_rdk_defconfig
xtensa                generic_kc705_defconfig
mips                         db1xxx_defconfig
arm                          ep93xx_defconfig
powerpc                   microwatt_defconfig
powerpc                      obs600_defconfig
arm                           sama7_defconfig
powerpc                     tqm8555_defconfig
arm                         s5pv210_defconfig
m68k                        m5307c3_defconfig
arm                   milbeaut_m10v_defconfig
arm                  colibri_pxa270_defconfig
arm                            mps2_defconfig
sh                          lboxre2_defconfig
mips                           xway_defconfig
arm                     eseries_pxa_defconfig
x86_64               randconfig-c001-20211009
arm                  randconfig-c002-20211009
x86_64               randconfig-c001-20211008
arm                  randconfig-c002-20211008
ia64                             allmodconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
nios2                               defconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
parisc                              defconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allyesconfig
s390                             allmodconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a003-20211009
x86_64               randconfig-a005-20211009
x86_64               randconfig-a001-20211009
x86_64               randconfig-a002-20211009
x86_64               randconfig-a004-20211009
x86_64               randconfig-a006-20211009
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
arc                  randconfig-r043-20211008
s390                 randconfig-r044-20211008
riscv                randconfig-r042-20211008
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allyesconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                           allyesconfig

clang tested configs:
x86_64               randconfig-c007-20211009
i386                 randconfig-c001-20211009
arm                  randconfig-c002-20211009
s390                 randconfig-c005-20211009
powerpc              randconfig-c003-20211009
riscv                randconfig-c006-20211009
mips                 randconfig-c004-20211009
arm                  randconfig-c002-20211010
mips                 randconfig-c004-20211010
i386                 randconfig-c001-20211010
s390                 randconfig-c005-20211010
x86_64               randconfig-c007-20211010
powerpc              randconfig-c003-20211010
riscv                randconfig-c006-20211010
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
x86_64               randconfig-a003-20211008
x86_64               randconfig-a005-20211008
x86_64               randconfig-a001-20211008
x86_64               randconfig-a002-20211008
x86_64               randconfig-a004-20211008
x86_64               randconfig-a006-20211008
hexagon              randconfig-r045-20211009
hexagon              randconfig-r041-20211009
s390                 randconfig-r044-20211009
riscv                randconfig-r042-20211009

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
