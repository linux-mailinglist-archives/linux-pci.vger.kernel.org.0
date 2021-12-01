Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5810746467B
	for <lists+linux-pci@lfdr.de>; Wed,  1 Dec 2021 06:24:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbhLAF11 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Dec 2021 00:27:27 -0500
Received: from mga11.intel.com ([192.55.52.93]:62676 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230444AbhLAF11 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 1 Dec 2021 00:27:27 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10184"; a="233888762"
X-IronPort-AV: E=Sophos;i="5.87,277,1631602800"; 
   d="scan'208";a="233888762"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 21:24:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,277,1631602800"; 
   d="scan'208";a="609416007"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 30 Nov 2021 21:24:05 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1msI68-000EIz-Rr; Wed, 01 Dec 2021 05:24:04 +0000
Date:   Wed, 01 Dec 2021 13:23:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:next] BUILD SUCCESS
 bef2b1c97d77978924005e0b5c3def392200dafb
Message-ID: <61a706e4.8tIZEQsknjqroeXy%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
branch HEAD: bef2b1c97d77978924005e0b5c3def392200dafb  Merge branch 'pci/errors'

elapsed time: 720m

configs tested: 237
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211128
i386                 randconfig-c001-20211130
sh                          rsk7269_defconfig
arc                 nsimosci_hs_smp_defconfig
sh                   secureedge5410_defconfig
arm                        realview_defconfig
arm                          exynos_defconfig
sh                           se7750_defconfig
powerpc                      pasemi_defconfig
sh                               alldefconfig
arm                       imx_v6_v7_defconfig
powerpc                      acadia_defconfig
m68k                        m5272c3_defconfig
powerpc                    adder875_defconfig
sh                        edosk7760_defconfig
powerpc                       holly_defconfig
arm                      footbridge_defconfig
xtensa                  cadence_csp_defconfig
um                               alldefconfig
mips                           ci20_defconfig
sh                          rsk7201_defconfig
h8300                       h8s-sim_defconfig
arm                      tct_hammer_defconfig
powerpc64                           defconfig
powerpc                    gamecube_defconfig
powerpc                       maple_defconfig
sh                           se7722_defconfig
sh                            titan_defconfig
mips                    maltaup_xpa_defconfig
arm                  colibri_pxa270_defconfig
m68k                            q40_defconfig
sh                ecovec24-romimage_defconfig
ia64                          tiger_defconfig
powerpc                     sequoia_defconfig
arm                     am200epdkit_defconfig
powerpc                 mpc834x_mds_defconfig
sh                          rsk7264_defconfig
arm                            mmp2_defconfig
arm                           tegra_defconfig
sh                           se7206_defconfig
sh                         apsh4a3a_defconfig
parisc                generic-32bit_defconfig
arm                         s3c2410_defconfig
arm                             pxa_defconfig
sh                          polaris_defconfig
powerpc                     redwood_defconfig
sparc                            allyesconfig
powerpc                      arches_defconfig
powerpc                      ep88xc_defconfig
nios2                         10m50_defconfig
arm                           corgi_defconfig
s390                             alldefconfig
arm                       multi_v4t_defconfig
arm                     eseries_pxa_defconfig
sparc64                             defconfig
sh                            shmin_defconfig
powerpc                 mpc837x_mds_defconfig
arm                             mxs_defconfig
riscv                    nommu_virt_defconfig
xtensa                       common_defconfig
arc                        nsimosci_defconfig
powerpc                          g5_defconfig
powerpc64                        alldefconfig
openrisc                    or1ksim_defconfig
powerpc                  iss476-smp_defconfig
powerpc                     akebono_defconfig
arm                          pxa3xx_defconfig
xtensa                          iss_defconfig
powerpc                mpc7448_hpc2_defconfig
arm                          simpad_defconfig
sh                          landisk_defconfig
ia64                         bigsur_defconfig
powerpc                     stx_gp3_defconfig
mips                       lemote2f_defconfig
arm                    vt8500_v6_v7_defconfig
mips                         rt305x_defconfig
m68k                        mvme16x_defconfig
arm                            xcep_defconfig
powerpc                      ppc6xx_defconfig
powerpc                        warp_defconfig
powerpc                 linkstation_defconfig
mips                          malta_defconfig
mips                        workpad_defconfig
nios2                            alldefconfig
arm                         socfpga_defconfig
mips                     decstation_defconfig
arm                         vf610m4_defconfig
arm                       cns3420vb_defconfig
mips                        vocore2_defconfig
sh                           se7721_defconfig
mips                           ip27_defconfig
m68k                        m5407c3_defconfig
arm                       aspeed_g5_defconfig
powerpc                 mpc8560_ads_defconfig
arm                        cerfcube_defconfig
mips                     cu1830-neo_defconfig
riscv                            alldefconfig
mips                        omega2p_defconfig
mips                     loongson1c_defconfig
mips                      loongson3_defconfig
arm                       mainstone_defconfig
powerpc                     pq2fads_defconfig
alpha                            alldefconfig
powerpc                 mpc8313_rdb_defconfig
mips                          rm200_defconfig
arm                  randconfig-c002-20211128
arm                  randconfig-c002-20211129
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
csky                                defconfig
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
s390                                defconfig
i386                             allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20211201
x86_64               randconfig-a005-20211201
x86_64               randconfig-a001-20211201
x86_64               randconfig-a002-20211201
x86_64               randconfig-a004-20211201
x86_64               randconfig-a003-20211201
i386                 randconfig-a005-20211130
i386                 randconfig-a002-20211130
i386                 randconfig-a006-20211130
i386                 randconfig-a004-20211130
i386                 randconfig-a003-20211130
i386                 randconfig-a001-20211130
i386                 randconfig-a001-20211129
i386                 randconfig-a002-20211129
i386                 randconfig-a006-20211129
i386                 randconfig-a005-20211129
i386                 randconfig-a004-20211129
i386                 randconfig-a003-20211129
x86_64               randconfig-a001-20211130
x86_64               randconfig-a006-20211130
x86_64               randconfig-a003-20211130
x86_64               randconfig-a004-20211130
x86_64               randconfig-a005-20211130
x86_64               randconfig-a002-20211130
x86_64               randconfig-a011-20211128
x86_64               randconfig-a014-20211128
x86_64               randconfig-a012-20211128
x86_64               randconfig-a016-20211128
x86_64               randconfig-a013-20211128
x86_64               randconfig-a015-20211128
i386                 randconfig-a015-20211128
i386                 randconfig-a016-20211128
i386                 randconfig-a013-20211128
i386                 randconfig-a012-20211128
i386                 randconfig-a014-20211128
i386                 randconfig-a011-20211128
arc                  randconfig-r043-20211128
s390                 randconfig-r044-20211128
riscv                randconfig-r042-20211128
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
s390                 randconfig-c005-20211128
i386                 randconfig-c001-20211128
riscv                randconfig-c006-20211128
arm                  randconfig-c002-20211128
powerpc              randconfig-c003-20211128
x86_64               randconfig-c007-20211128
mips                 randconfig-c004-20211128
x86_64               randconfig-a001-20211128
x86_64               randconfig-a006-20211128
x86_64               randconfig-a003-20211128
x86_64               randconfig-a005-20211128
x86_64               randconfig-a004-20211128
x86_64               randconfig-a002-20211128
i386                 randconfig-a001-20211128
i386                 randconfig-a002-20211128
i386                 randconfig-a006-20211128
i386                 randconfig-a005-20211128
i386                 randconfig-a004-20211128
i386                 randconfig-a003-20211128
x86_64               randconfig-a014-20211130
x86_64               randconfig-a016-20211130
x86_64               randconfig-a013-20211130
x86_64               randconfig-a012-20211130
x86_64               randconfig-a015-20211130
x86_64               randconfig-a011-20211130
i386                 randconfig-a011-20211130
i386                 randconfig-a015-20211130
i386                 randconfig-a012-20211130
i386                 randconfig-a013-20211130
i386                 randconfig-a014-20211130
i386                 randconfig-a016-20211130
i386                 randconfig-a015-20211129
i386                 randconfig-a016-20211129
i386                 randconfig-a013-20211129
i386                 randconfig-a012-20211129
i386                 randconfig-a014-20211129
i386                 randconfig-a011-20211129
hexagon              randconfig-r045-20211129
hexagon              randconfig-r041-20211129
s390                 randconfig-r044-20211129
riscv                randconfig-r042-20211129

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
