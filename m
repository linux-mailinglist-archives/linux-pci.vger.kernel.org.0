Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E052C3EAFD9
	for <lists+linux-pci@lfdr.de>; Fri, 13 Aug 2021 08:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238766AbhHMGFo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Aug 2021 02:05:44 -0400
Received: from mga01.intel.com ([192.55.52.88]:61887 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238757AbhHMGFo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Aug 2021 02:05:44 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10074"; a="237550753"
X-IronPort-AV: E=Sophos;i="5.84,318,1620716400"; 
   d="scan'208";a="237550753"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2021 23:05:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,318,1620716400"; 
   d="scan'208";a="508033916"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 12 Aug 2021 23:05:16 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mEQJg-000NOc-7E; Fri, 13 Aug 2021 06:05:16 +0000
Date:   Fri, 13 Aug 2021 14:04:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:pci/vpd] BUILD SUCCESS
 fe7568cf2f2dc3a0783f6ffdb3802c1ce2085466
Message-ID: <61160b89.m7x33syACLx4meoM%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/vpd
branch HEAD: fe7568cf2f2dc3a0783f6ffdb3802c1ce2085466  PCI/VPD: Treat invalid VPD like missing VPD capability

elapsed time: 723m

configs tested: 122
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210812
sh                          polaris_defconfig
powerpc                      bamboo_defconfig
powerpc                       holly_defconfig
powerpc                mpc7448_hpc2_defconfig
powerpc                        cell_defconfig
powerpc                 mpc837x_rdb_defconfig
xtensa                generic_kc705_defconfig
arm                           stm32_defconfig
arm                           omap1_defconfig
arc                           tb10x_defconfig
arm                          exynos_defconfig
mips                          ath25_defconfig
mips                        workpad_defconfig
mips                     decstation_defconfig
powerpc                     ppa8548_defconfig
arc                        nsimosci_defconfig
arm                     davinci_all_defconfig
mips                           gcw0_defconfig
arm                            xcep_defconfig
riscv                             allnoconfig
powerpc64                        alldefconfig
powerpc                     ksi8560_defconfig
sh                         ap325rxa_defconfig
arm                          gemini_defconfig
sh                               alldefconfig
sh                         apsh4a3a_defconfig
powerpc                      cm5200_defconfig
powerpc                           allnoconfig
arm                            zeus_defconfig
sh                             sh03_defconfig
arm                       aspeed_g5_defconfig
mips                        maltaup_defconfig
arc                     nsimosci_hs_defconfig
arc                          axs103_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
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
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
i386                 randconfig-a004-20210812
i386                 randconfig-a003-20210812
i386                 randconfig-a002-20210812
i386                 randconfig-a001-20210812
i386                 randconfig-a006-20210812
i386                 randconfig-a005-20210812
x86_64               randconfig-a006-20210812
x86_64               randconfig-a004-20210812
x86_64               randconfig-a003-20210812
x86_64               randconfig-a005-20210812
x86_64               randconfig-a002-20210812
x86_64               randconfig-a001-20210812
i386                 randconfig-a011-20210812
i386                 randconfig-a015-20210812
i386                 randconfig-a013-20210812
i386                 randconfig-a014-20210812
i386                 randconfig-a016-20210812
i386                 randconfig-a012-20210812
i386                 randconfig-a011-20210813
i386                 randconfig-a015-20210813
i386                 randconfig-a014-20210813
i386                 randconfig-a013-20210813
i386                 randconfig-a016-20210813
i386                 randconfig-a012-20210813
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-c001-20210812
x86_64               randconfig-a006-20210813
x86_64               randconfig-a004-20210813
x86_64               randconfig-a003-20210813
x86_64               randconfig-a002-20210813
x86_64               randconfig-a005-20210813
x86_64               randconfig-a001-20210813
x86_64               randconfig-a011-20210812
x86_64               randconfig-a013-20210812
x86_64               randconfig-a012-20210812
x86_64               randconfig-a016-20210812
x86_64               randconfig-a015-20210812
x86_64               randconfig-a014-20210812

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
