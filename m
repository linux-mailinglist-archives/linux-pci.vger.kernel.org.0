Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E009E479A90
	for <lists+linux-pci@lfdr.de>; Sat, 18 Dec 2021 12:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbhLRLYo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 18 Dec 2021 06:24:44 -0500
Received: from mga04.intel.com ([192.55.52.120]:64817 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230098AbhLRLYo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 18 Dec 2021 06:24:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639826684; x=1671362684;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=/hYu0X0u9iOduWJ5YLJBtZBEciy94tFnyN+yGoj6DoU=;
  b=A94BsNIG9K7LPN/GZz5F6Ev2XwxzKPYW6QauFA6qRXT7hNaRhTgdUNjX
   S6lST2puxwtGxTRi0OeKuOoUhF0tn2cbD2XzQllpnroXLAGL2NYx7HNdB
   DB0kGeepDaNvg1n//ifA3FRx+RRz7he2z0UFV8ikSVVBHmlXdCuCwNUzX
   0oEviIbIp9nsQcrjGQftn/uZrPywRNfCRaVDf+Iyuz7l0SUJXil9uJ8wL
   oYCw5YDd7yk4MjkMWssaxCeQ+72kq1m7uOFH7un+2YR07TYFdBWOY1NYg
   /ZJUhR8kPbwOgWFxUdARJLIl1pgm4BfRShn3nO9wqdH9MFT2gRKznIa1x
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10201"; a="238657982"
X-IronPort-AV: E=Sophos;i="5.88,216,1635231600"; 
   d="scan'208";a="238657982"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2021 03:24:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,216,1635231600"; 
   d="scan'208";a="683691965"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 18 Dec 2021 03:24:42 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1myXpR-0005ui-IH; Sat, 18 Dec 2021 11:24:41 +0000
Date:   Sat, 18 Dec 2021 19:24:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:next] BUILD SUCCESS
 770851f91de8a987478a916627e43e452937c9a7
Message-ID: <61bdc4db.QYMcKAf7HHabDxNB%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
branch HEAD: 770851f91de8a987478a916627e43e452937c9a7  Merge branch 'pci/errors'

elapsed time: 2134m

configs tested: 206
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                               defconfig
arm                              allmodconfig
arm64                            allyesconfig
arm                              allyesconfig
i386                 randconfig-c001-20211216
m68k                       m5475evb_defconfig
sh                           se7712_defconfig
arm                         lubbock_defconfig
arm                        magician_defconfig
arm                         s3c2410_defconfig
ia64                            zx1_defconfig
mips                         rt305x_defconfig
sh                      rts7751r2d1_defconfig
powerpc                    ge_imp3a_defconfig
powerpc                      bamboo_defconfig
powerpc                     ppa8548_defconfig
sh                           se7780_defconfig
arm                            lart_defconfig
arc                         haps_hs_defconfig
sh                            titan_defconfig
powerpc                    amigaone_defconfig
sh                          rsk7203_defconfig
xtensa                         virt_defconfig
powerpc                       ppc64_defconfig
powerpc                      ppc6xx_defconfig
microblaze                      mmu_defconfig
arc                        nsimosci_defconfig
mips                            ar7_defconfig
powerpc                 mpc8560_ads_defconfig
m68k                       bvme6000_defconfig
powerpc                mpc7448_hpc2_defconfig
arm                              alldefconfig
arm                           sama5_defconfig
sh                   secureedge5410_defconfig
h8300                    h8300h-sim_defconfig
arm                          collie_defconfig
x86_64                           allyesconfig
m68k                          atari_defconfig
sh                        dreamcast_defconfig
arm                           sunxi_defconfig
arc                                 defconfig
sparc                               defconfig
arm                       imx_v6_v7_defconfig
powerpc                      cm5200_defconfig
arm                   milbeaut_m10v_defconfig
arm                        multi_v7_defconfig
i386                             alldefconfig
powerpc                     powernv_defconfig
m68k                         apollo_defconfig
m68k                        m5407c3_defconfig
mips                       capcella_defconfig
mips                  cavium_octeon_defconfig
powerpc                 mpc832x_mds_defconfig
mips                    maltaup_xpa_defconfig
m68k                        stmark2_defconfig
powerpc                      makalu_defconfig
riscv                          rv32_defconfig
arm                           corgi_defconfig
mips                        bcm47xx_defconfig
powerpc                      pasemi_defconfig
arc                        vdk_hs38_defconfig
arm                           stm32_defconfig
arm                        neponset_defconfig
powerpc                     tqm8540_defconfig
mips                        bcm63xx_defconfig
h8300                            allyesconfig
ia64                      gensparse_defconfig
powerpc               mpc834x_itxgp_defconfig
powerpc                      walnut_defconfig
mips                        omega2p_defconfig
sh                           se7721_defconfig
m68k                             alldefconfig
mips                         bigsur_defconfig
arc                    vdk_hs38_smp_defconfig
mips                          ath25_defconfig
arm                          lpd270_defconfig
arc                     haps_hs_smp_defconfig
sh                           se7724_defconfig
powerpc                 linkstation_defconfig
powerpc                        cell_defconfig
arm                         axm55xx_defconfig
parisc                           alldefconfig
m68k                          amiga_defconfig
m68k                        mvme147_defconfig
sh                        sh7757lcr_defconfig
sparc                            allyesconfig
ia64                        generic_defconfig
mips                          malta_defconfig
sh                     magicpanelr2_defconfig
arm                       omap2plus_defconfig
powerpc                    adder875_defconfig
parisc                generic-32bit_defconfig
arm                         s3c6400_defconfig
mips                      pic32mzda_defconfig
powerpc                    mvme5100_defconfig
arm                          iop32x_defconfig
arm                         vf610m4_defconfig
arm                         assabet_defconfig
sparc                       sparc64_defconfig
sparc64                          alldefconfig
powerpc                     skiroot_defconfig
arm                  randconfig-c002-20211216
arm                  randconfig-c002-20211218
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
nios2                            allyesconfig
alpha                            allyesconfig
xtensa                           allyesconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20211216
x86_64               randconfig-a005-20211216
x86_64               randconfig-a001-20211216
x86_64               randconfig-a002-20211216
x86_64               randconfig-a003-20211216
x86_64               randconfig-a004-20211216
i386                 randconfig-a001-20211216
i386                 randconfig-a002-20211216
i386                 randconfig-a005-20211216
i386                 randconfig-a003-20211216
i386                 randconfig-a006-20211216
i386                 randconfig-a004-20211216
i386                 randconfig-a002-20211218
i386                 randconfig-a005-20211218
i386                 randconfig-a003-20211218
i386                 randconfig-a006-20211218
i386                 randconfig-a004-20211218
x86_64               randconfig-a011-20211217
x86_64               randconfig-a014-20211217
x86_64               randconfig-a012-20211217
x86_64               randconfig-a013-20211217
x86_64               randconfig-a016-20211217
x86_64               randconfig-a015-20211217
i386                 randconfig-a013-20211217
i386                 randconfig-a011-20211217
i386                 randconfig-a016-20211217
i386                 randconfig-a014-20211217
i386                 randconfig-a015-20211217
i386                 randconfig-a012-20211217
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a006-20211217
x86_64               randconfig-a005-20211217
x86_64               randconfig-a001-20211217
x86_64               randconfig-a002-20211217
x86_64               randconfig-a003-20211217
x86_64               randconfig-a004-20211217
x86_64               randconfig-a011-20211216
x86_64               randconfig-a014-20211216
x86_64               randconfig-a012-20211216
x86_64               randconfig-a013-20211216
x86_64               randconfig-a016-20211216
x86_64               randconfig-a015-20211216
x86_64               randconfig-a011-20211214
x86_64               randconfig-a014-20211214
x86_64               randconfig-a012-20211214
x86_64               randconfig-a013-20211214
x86_64               randconfig-a016-20211214
x86_64               randconfig-a015-20211214
i386                 randconfig-a013-20211216
i386                 randconfig-a011-20211216
i386                 randconfig-a016-20211216
i386                 randconfig-a014-20211216
i386                 randconfig-a015-20211216
i386                 randconfig-a012-20211216
hexagon              randconfig-r045-20211216
s390                 randconfig-r044-20211216
riscv                randconfig-r042-20211216
hexagon              randconfig-r041-20211216
hexagon              randconfig-r045-20211217
hexagon              randconfig-r041-20211217

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
