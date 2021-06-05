Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6625139C6FF
	for <lists+linux-pci@lfdr.de>; Sat,  5 Jun 2021 11:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbhFEJTm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 5 Jun 2021 05:19:42 -0400
Received: from mga06.intel.com ([134.134.136.31]:42966 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229892AbhFEJTm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 5 Jun 2021 05:19:42 -0400
IronPort-SDR: hmnrm36OJ5gTgFewfKxgFy0s22hNYYczjCZoaE857OS5cD7XRmWJdIqfJOTCiY3Bfdhimy1Hqw
 kp5289EwN1tw==
X-IronPort-AV: E=McAfee;i="6200,9189,10005"; a="265583752"
X-IronPort-AV: E=Sophos;i="5.83,250,1616482800"; 
   d="scan'208";a="265583752"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2021 02:17:54 -0700
IronPort-SDR: oUalgT9pA3d8XMT+ZoSIbq08eBTwsT2WXPUwYT8KNgMxf4qFb2oOudxsUzfAE9C0MiyH00Isc3
 zYV2rdmPttog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,250,1616482800"; 
   d="scan'208";a="636807031"
Received: from lkp-server02.sh.intel.com (HELO 1ec8406c5392) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 05 Jun 2021 02:17:53 -0700
Received: from kbuild by 1ec8406c5392 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lpSRE-0007Lr-J1; Sat, 05 Jun 2021 09:17:52 +0000
Date:   Sat, 05 Jun 2021 17:17:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS b3e91145f897ea07d44753e306bddc6afedfa7a3
Message-ID: <60bb4116.5m+QAOZnyRnkety3%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
branch HEAD: b3e91145f897ea07d44753e306bddc6afedfa7a3  Merge branch 'remotes/lorenzo/pci/xgene'

elapsed time: 726m

configs tested: 197
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
xtensa                generic_kc705_defconfig
powerpc                      mgcoge_defconfig
mips                          rm200_defconfig
powerpc                        fsp2_defconfig
arm                           stm32_defconfig
arm                      integrator_defconfig
powerpc                 mpc8540_ads_defconfig
powerpc                          allyesconfig
arc                            hsdk_defconfig
riscv             nommu_k210_sdcard_defconfig
arm                  colibri_pxa270_defconfig
powerpc                    adder875_defconfig
powerpc                       ebony_defconfig
sh                        apsh4ad0a_defconfig
arm                        keystone_defconfig
powerpc                    gamecube_defconfig
mips                      maltasmvp_defconfig
powerpc                      chrp32_defconfig
arm                           corgi_defconfig
um                               alldefconfig
powerpc                  iss476-smp_defconfig
mips                     loongson2k_defconfig
mips                  maltasmvp_eva_defconfig
m68k                         apollo_defconfig
m68k                        mvme16x_defconfig
mips                      maltaaprp_defconfig
nios2                               defconfig
arc                         haps_hs_defconfig
mips                           xway_defconfig
powerpc                          allmodconfig
arm                             pxa_defconfig
arm                         s3c6400_defconfig
arm                     am200epdkit_defconfig
arc                              alldefconfig
ia64                      gensparse_defconfig
mips                         tb0287_defconfig
arm                            mmp2_defconfig
sparc                            alldefconfig
mips                           rs90_defconfig
i386                                defconfig
sh                        edosk7705_defconfig
arm                         shannon_defconfig
arm                       omap2plus_defconfig
mips                        qi_lb60_defconfig
powerpc                        warp_defconfig
mips                 decstation_r4k_defconfig
sparc64                             defconfig
mips                    maltaup_xpa_defconfig
arm                       versatile_defconfig
arm                        multi_v5_defconfig
m68k                           sun3_defconfig
openrisc                            defconfig
arc                        nsim_700_defconfig
mips                        bcm47xx_defconfig
mips                            gpr_defconfig
mips                           ci20_defconfig
arm                         hackkit_defconfig
ia64                                defconfig
powerpc                     taishan_defconfig
powerpc                    ge_imp3a_defconfig
arm                            xcep_defconfig
arm                         assabet_defconfig
ia64                            zx1_defconfig
mips                     cu1830-neo_defconfig
sh                          urquell_defconfig
sh                           se7724_defconfig
mips                        maltaup_defconfig
arm                         lpc32xx_defconfig
m68k                          multi_defconfig
powerpc                 mpc832x_rdb_defconfig
sh                        dreamcast_defconfig
arm                            mps2_defconfig
arm                          simpad_defconfig
arm                            qcom_defconfig
arc                 nsimosci_hs_smp_defconfig
riscv                            alldefconfig
powerpc                      katmai_defconfig
powerpc                mpc7448_hpc2_defconfig
powerpc                 mpc834x_mds_defconfig
sh                         ap325rxa_defconfig
sh                            titan_defconfig
powerpc                     stx_gp3_defconfig
sh                          rsk7201_defconfig
powerpc                    klondike_defconfig
arm                       imx_v6_v7_defconfig
sh                               allmodconfig
powerpc                     sbc8548_defconfig
arm                   milbeaut_m10v_defconfig
powerpc                      tqm8xx_defconfig
mips                           jazz_defconfig
xtensa                         virt_defconfig
sh                          sdk7780_defconfig
arm                            lart_defconfig
arm                          pxa910_defconfig
arc                        nsimosci_defconfig
mips                           ip28_defconfig
powerpc                       holly_defconfig
xtensa                              defconfig
powerpc                     kmeter1_defconfig
mips                         cobalt_defconfig
powerpc                   motionpro_defconfig
m68k                            q40_defconfig
powerpc                     ppa8548_defconfig
powerpc                     kilauea_defconfig
mips                           ip22_defconfig
sh                           se7750_defconfig
openrisc                  or1klitex_defconfig
mips                        nlm_xlp_defconfig
nios2                         3c120_defconfig
sparc                       sparc32_defconfig
sh                        sh7785lcr_defconfig
arm                        multi_v7_defconfig
m68k                                defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
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
powerpc                           allnoconfig
x86_64               randconfig-a002-20210604
x86_64               randconfig-a004-20210604
x86_64               randconfig-a003-20210604
x86_64               randconfig-a006-20210604
x86_64               randconfig-a005-20210604
x86_64               randconfig-a001-20210604
i386                 randconfig-a003-20210604
i386                 randconfig-a006-20210604
i386                 randconfig-a004-20210604
i386                 randconfig-a001-20210604
i386                 randconfig-a005-20210604
i386                 randconfig-a002-20210604
i386                 randconfig-a003-20210603
i386                 randconfig-a006-20210603
i386                 randconfig-a004-20210603
i386                 randconfig-a001-20210603
i386                 randconfig-a002-20210603
i386                 randconfig-a005-20210603
x86_64               randconfig-a015-20210605
x86_64               randconfig-a011-20210605
x86_64               randconfig-a014-20210605
x86_64               randconfig-a012-20210605
x86_64               randconfig-a016-20210605
x86_64               randconfig-a013-20210605
i386                 randconfig-a015-20210604
i386                 randconfig-a013-20210604
i386                 randconfig-a016-20210604
i386                 randconfig-a011-20210604
i386                 randconfig-a014-20210604
i386                 randconfig-a012-20210604
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
um                            kunit_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210604
x86_64               randconfig-a015-20210604
x86_64               randconfig-a011-20210604
x86_64               randconfig-a014-20210604
x86_64               randconfig-a012-20210604
x86_64               randconfig-a016-20210604
x86_64               randconfig-a013-20210604

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
