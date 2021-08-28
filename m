Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 810563FA648
	for <lists+linux-pci@lfdr.de>; Sat, 28 Aug 2021 16:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbhH1OxY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 28 Aug 2021 10:53:24 -0400
Received: from mga12.intel.com ([192.55.52.136]:42417 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229525AbhH1OxY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 28 Aug 2021 10:53:24 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10090"; a="197667901"
X-IronPort-AV: E=Sophos;i="5.84,359,1620716400"; 
   d="scan'208";a="197667901"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2021 07:52:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,359,1620716400"; 
   d="scan'208";a="458304411"
Received: from lkp-server01.sh.intel.com (HELO 4fbc2b3ce5aa) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 28 Aug 2021 07:52:30 -0700
Received: from kbuild by 4fbc2b3ce5aa with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mJzh8-0003VT-4r; Sat, 28 Aug 2021 14:52:30 +0000
Date:   Sat, 28 Aug 2021 22:52:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:wip/amey-reset-v16] BUILD SUCCESS
 1af889f521aa87afab0b7d6e0964cd16b1d1266f
Message-ID: <612a4d9b.1X9++kpIFHsPCDZh%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git wip/amey-reset-v16
branch HEAD: 1af889f521aa87afab0b7d6e0964cd16b1d1266f  PCI: Change the type of probe argument in reset functions

elapsed time: 14170m

configs tested: 120
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210816
i386                 randconfig-c001-20210819
mips                         rt305x_defconfig
powerpc                 linkstation_defconfig
arm                       netwinder_defconfig
powerpc                         ps3_defconfig
arm                         hackkit_defconfig
sh                           se7724_defconfig
parisc                generic-32bit_defconfig
powerpc                      pmac32_defconfig
powerpc                    sam440ep_defconfig
powerpc                     pq2fads_defconfig
m68k                        m5407c3_defconfig
sh                               j2_defconfig
m68k                         amcore_defconfig
arm                           viper_defconfig
sh                          rsk7269_defconfig
arm64                            alldefconfig
sh                        apsh4ad0a_defconfig
mips                       bmips_be_defconfig
powerpc                 mpc837x_rdb_defconfig
x86_64                           allyesconfig
mips                          rm200_defconfig
sh                   sh7770_generic_defconfig
arm                          iop32x_defconfig
powerpc                        icon_defconfig
sh                          rsk7203_defconfig
mips                     cu1000-neo_defconfig
arm                            pleb_defconfig
powerpc                          g5_defconfig
h8300                     edosk2674_defconfig
sh                           se7712_defconfig
sh                        sh7785lcr_defconfig
xtensa                  cadence_csp_defconfig
powerpc                           allnoconfig
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
x86_64               randconfig-a004-20210818
x86_64               randconfig-a006-20210818
x86_64               randconfig-a003-20210818
x86_64               randconfig-a005-20210818
x86_64               randconfig-a002-20210818
x86_64               randconfig-a001-20210818
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
riscv                randconfig-c006-20210818
s390                 randconfig-c005-20210818
powerpc              randconfig-c003-20210818
mips                 randconfig-c004-20210818
x86_64               randconfig-c007-20210818
i386                 randconfig-c001-20210818
arm                  randconfig-c002-20210818
i386                 randconfig-a004-20210819
i386                 randconfig-a006-20210819
i386                 randconfig-a001-20210819
i386                 randconfig-a002-20210819
i386                 randconfig-a003-20210819
i386                 randconfig-a005-20210819
x86_64               randconfig-a013-20210818
x86_64               randconfig-a011-20210818
x86_64               randconfig-a012-20210818
x86_64               randconfig-a016-20210818
x86_64               randconfig-a014-20210818
x86_64               randconfig-a015-20210818
i386                 randconfig-a015-20210818
i386                 randconfig-a011-20210818
i386                 randconfig-a013-20210818
i386                 randconfig-a014-20210818
i386                 randconfig-a016-20210818
i386                 randconfig-a012-20210818
hexagon              randconfig-r041-20210818
riscv                randconfig-r042-20210818
s390                 randconfig-r044-20210818
hexagon              randconfig-r045-20210818

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
