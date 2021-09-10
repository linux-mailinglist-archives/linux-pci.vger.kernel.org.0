Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03E124066F6
	for <lists+linux-pci@lfdr.de>; Fri, 10 Sep 2021 07:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbhIJF6n (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Sep 2021 01:58:43 -0400
Received: from mga09.intel.com ([134.134.136.24]:38255 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230417AbhIJF6n (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 10 Sep 2021 01:58:43 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10102"; a="221034093"
X-IronPort-AV: E=Sophos;i="5.85,282,1624345200"; 
   d="scan'208";a="221034093"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2021 22:57:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,282,1624345200"; 
   d="scan'208";a="696960287"
Received: from lkp-server01.sh.intel.com (HELO 730d49888f40) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 09 Sep 2021 22:57:31 -0700
Received: from kbuild by 730d49888f40 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mOZXW-0003uk-CQ; Fri, 10 Sep 2021 05:57:30 +0000
Date:   Fri, 10 Sep 2021 13:57:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:pci/p2pdma] BUILD SUCCESS
 8103e4e39aa4983c5afd28ace0be15f0db84455f
Message-ID: <613af3bd.AQUmuZt3ZgfbA8kx%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/p2pdma
branch HEAD: 8103e4e39aa4983c5afd28ace0be15f0db84455f  PCI/P2PDMA: Apply bus offset correctly in DMA address calculation

elapsed time: 723m

configs tested: 170
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210908
powerpc                 xes_mpc85xx_defconfig
parisc                generic-64bit_defconfig
arm                             ezx_defconfig
powerpc                     mpc83xx_defconfig
mips                     cu1830-neo_defconfig
sh                          kfr2r09_defconfig
sh                        apsh4ad0a_defconfig
arm                       aspeed_g4_defconfig
sh                   sh7724_generic_defconfig
arm                            hisi_defconfig
mips                        nlm_xlr_defconfig
mips                  decstation_64_defconfig
nios2                            alldefconfig
powerpc                      pcm030_defconfig
powerpc                  storcenter_defconfig
arm                          ep93xx_defconfig
sparc                       sparc32_defconfig
arm                         axm55xx_defconfig
mips                     loongson2k_defconfig
mips                      fuloong2e_defconfig
ia64                            zx1_defconfig
openrisc                 simple_smp_defconfig
mips                      pic32mzda_defconfig
powerpc                    mvme5100_defconfig
powerpc                     asp8347_defconfig
powerpc                       ppc64_defconfig
xtensa                           alldefconfig
sh                           se7206_defconfig
um                             i386_defconfig
arm                        oxnas_v6_defconfig
powerpc                 mpc836x_rdk_defconfig
powerpc                    klondike_defconfig
openrisc                            defconfig
mips                          ath79_defconfig
arm                         shannon_defconfig
powerpc64                           defconfig
powerpc                    gamecube_defconfig
mips                       rbtx49xx_defconfig
arc                          axs101_defconfig
parisc                generic-32bit_defconfig
arm                       versatile_defconfig
mips                        jmr3927_defconfig
powerpc                 canyonlands_defconfig
powerpc                     skiroot_defconfig
powerpc                        icon_defconfig
sh                               j2_defconfig
sh                             espt_defconfig
ia64                        generic_defconfig
arm                         vf610m4_defconfig
mips                           ip32_defconfig
powerpc                    sam440ep_defconfig
mips                        workpad_defconfig
h8300                    h8300h-sim_defconfig
arm                         nhk8815_defconfig
arm                  colibri_pxa300_defconfig
m68k                        m5307c3_defconfig
powerpc                      obs600_defconfig
powerpc                     sequoia_defconfig
sh                 kfr2r09-romimage_defconfig
sh                        sh7763rdp_defconfig
x86_64                           alldefconfig
powerpc                      ppc6xx_defconfig
x86_64               randconfig-c001-20210908
x86_64               randconfig-c001-20210910
i386                 randconfig-c001-20210910
arm                  randconfig-c002-20210908
arm                  randconfig-c002-20210910
x86_64                            allnoconfig
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
s390                             allmodconfig
s390                                defconfig
s390                             allyesconfig
parisc                           allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                             allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a004-20210908
x86_64               randconfig-a006-20210908
x86_64               randconfig-a003-20210908
x86_64               randconfig-a001-20210908
x86_64               randconfig-a005-20210908
x86_64               randconfig-a002-20210908
i386                 randconfig-a005-20210908
i386                 randconfig-a004-20210908
i386                 randconfig-a006-20210908
i386                 randconfig-a002-20210908
i386                 randconfig-a001-20210908
i386                 randconfig-a003-20210908
x86_64               randconfig-a013-20210910
x86_64               randconfig-a016-20210910
x86_64               randconfig-a012-20210910
x86_64               randconfig-a011-20210910
x86_64               randconfig-a014-20210910
x86_64               randconfig-a015-20210910
i386                 randconfig-a016-20210910
i386                 randconfig-a011-20210910
i386                 randconfig-a012-20210910
i386                 randconfig-a013-20210910
i386                 randconfig-a014-20210910
arc                  randconfig-r043-20210908
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
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
s390                 randconfig-c005-20210908
x86_64               randconfig-c007-20210908
powerpc              randconfig-c003-20210908
mips                 randconfig-c004-20210908
i386                 randconfig-c001-20210908
arm                  randconfig-c002-20210908
riscv                randconfig-c006-20210908
x86_64               randconfig-a002-20210910
x86_64               randconfig-a003-20210910
x86_64               randconfig-a004-20210910
x86_64               randconfig-a006-20210910
x86_64               randconfig-a005-20210910
x86_64               randconfig-a001-20210910
x86_64               randconfig-a016-20210908
x86_64               randconfig-a011-20210908
x86_64               randconfig-a012-20210908
x86_64               randconfig-a015-20210908
x86_64               randconfig-a014-20210908
x86_64               randconfig-a013-20210908
i386                 randconfig-a012-20210908
i386                 randconfig-a015-20210908
i386                 randconfig-a011-20210908
i386                 randconfig-a013-20210908
i386                 randconfig-a014-20210908
i386                 randconfig-a016-20210908
s390                 randconfig-r044-20210908
riscv                randconfig-r042-20210908
hexagon              randconfig-r045-20210908
hexagon              randconfig-r041-20210908

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
