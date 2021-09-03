Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 938F03FF9F5
	for <lists+linux-pci@lfdr.de>; Fri,  3 Sep 2021 07:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232553AbhICFVG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Sep 2021 01:21:06 -0400
Received: from mga01.intel.com ([192.55.52.88]:44071 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232270AbhICFVG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 3 Sep 2021 01:21:06 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10095"; a="241613544"
X-IronPort-AV: E=Sophos;i="5.85,264,1624345200"; 
   d="scan'208";a="241613544"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2021 22:20:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,264,1624345200"; 
   d="scan'208";a="691837642"
Received: from lkp-server01.sh.intel.com (HELO 2115029a3e5c) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 02 Sep 2021 22:20:05 -0700
Received: from kbuild by 2115029a3e5c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mM1cT-00006i-5P; Fri, 03 Sep 2021 05:20:05 +0000
Date:   Fri, 03 Sep 2021 13:19:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:pci/hotplug] BUILD SUCCESS
 faa2e05ad0dccf37f995bcfbb8d1980d66c02c11
Message-ID: <6131b061.x/ZSUl4vvCQtS5cL%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/hotplug
branch HEAD: faa2e05ad0dccf37f995bcfbb8d1980d66c02c11  PCI: ibmphp: Fix double unmap of io_mem

elapsed time: 728m

configs tested: 171
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                                 defconfig
i386                 randconfig-c001-20210903
i386                 randconfig-c001-20210902
arm                         shannon_defconfig
powerpc                    mvme5100_defconfig
powerpc                       ppc64_defconfig
m68k                        m5272c3_defconfig
xtensa                              defconfig
um                                  defconfig
arc                          axs101_defconfig
powerpc                   motionpro_defconfig
mips                          malta_defconfig
mips                          ath25_defconfig
mips                      fuloong2e_defconfig
s390                             alldefconfig
powerpc                       eiger_defconfig
sh                        dreamcast_defconfig
arm                           viper_defconfig
powerpc                  mpc885_ads_defconfig
sh                      rts7751r2d1_defconfig
ia64                        generic_defconfig
mips                         mpc30x_defconfig
sh                           se7343_defconfig
arm                          ixp4xx_defconfig
mips                        maltaup_defconfig
powerpc                     pseries_defconfig
arm                        multi_v5_defconfig
arm                            xcep_defconfig
powerpc                   microwatt_defconfig
arm                       multi_v4t_defconfig
sh                            hp6xx_defconfig
powerpc                         ps3_defconfig
powerpc                      pcm030_defconfig
sh                           se7751_defconfig
mips                        jmr3927_defconfig
powerpc                      pasemi_defconfig
powerpc                      obs600_defconfig
arm                           sama7_defconfig
h8300                            alldefconfig
nios2                            alldefconfig
arm                           corgi_defconfig
arm                         assabet_defconfig
arm                           tegra_defconfig
arm                        trizeps4_defconfig
m68k                        m5307c3_defconfig
arm                            lart_defconfig
sh                   secureedge5410_defconfig
powerpc                     mpc83xx_defconfig
xtensa                       common_defconfig
m68k                        stmark2_defconfig
sh                   sh7770_generic_defconfig
arm                         lpc32xx_defconfig
arm                     davinci_all_defconfig
mips                           gcw0_defconfig
sh                           se7724_defconfig
arm                          pcm027_defconfig
nds32                               defconfig
arm                          collie_defconfig
arm                         socfpga_defconfig
m68k                       m5475evb_defconfig
riscv                            alldefconfig
i386                             alldefconfig
arm                       aspeed_g5_defconfig
m68k                       m5275evb_defconfig
mips                        bcm63xx_defconfig
arm                         s3c6400_defconfig
sh                             sh03_defconfig
mips                           jazz_defconfig
m68k                          multi_defconfig
arm                     eseries_pxa_defconfig
powerpc                     redwood_defconfig
nios2                            allyesconfig
arm                         s3c2410_defconfig
sh                           se7619_defconfig
sh                        edosk7705_defconfig
nios2                         10m50_defconfig
powerpc                        cell_defconfig
arm                              alldefconfig
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
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20210902
x86_64               randconfig-a006-20210902
x86_64               randconfig-a003-20210902
x86_64               randconfig-a005-20210902
x86_64               randconfig-a001-20210902
x86_64               randconfig-a002-20210902
x86_64               randconfig-a016-20210903
x86_64               randconfig-a011-20210903
x86_64               randconfig-a012-20210903
x86_64               randconfig-a015-20210903
x86_64               randconfig-a014-20210903
x86_64               randconfig-a013-20210903
i386                 randconfig-a012-20210903
i386                 randconfig-a015-20210903
i386                 randconfig-a011-20210903
i386                 randconfig-a013-20210903
i386                 randconfig-a014-20210903
i386                 randconfig-a016-20210903
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
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
x86_64                                  kexec

clang tested configs:
s390                 randconfig-c005-20210903
mips                 randconfig-c004-20210903
x86_64               randconfig-c007-20210903
powerpc              randconfig-c003-20210903
i386                 randconfig-c001-20210903
arm                  randconfig-c002-20210903
riscv                randconfig-c006-20210903
x86_64               randconfig-a004-20210903
x86_64               randconfig-a006-20210903
x86_64               randconfig-a003-20210903
x86_64               randconfig-a005-20210903
x86_64               randconfig-a001-20210903
x86_64               randconfig-a002-20210903
i386                 randconfig-a005-20210903
i386                 randconfig-a004-20210903
i386                 randconfig-a006-20210903
i386                 randconfig-a002-20210903
i386                 randconfig-a001-20210903
i386                 randconfig-a003-20210903
i386                 randconfig-a012-20210902
i386                 randconfig-a015-20210902
i386                 randconfig-a011-20210902
i386                 randconfig-a013-20210902
i386                 randconfig-a014-20210902
i386                 randconfig-a016-20210902
hexagon              randconfig-r045-20210903
hexagon              randconfig-r041-20210903

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
