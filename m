Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4C5E3FAAB7
	for <lists+linux-pci@lfdr.de>; Sun, 29 Aug 2021 12:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235296AbhH2KEt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 29 Aug 2021 06:04:49 -0400
Received: from mga04.intel.com ([192.55.52.120]:60686 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234925AbhH2KEt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 29 Aug 2021 06:04:49 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10090"; a="216301372"
X-IronPort-AV: E=Sophos;i="5.84,361,1620716400"; 
   d="scan'208";a="216301372"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2021 03:03:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,361,1620716400"; 
   d="scan'208";a="458671362"
Received: from lkp-server01.sh.intel.com (HELO 4fbc2b3ce5aa) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 29 Aug 2021 03:03:56 -0700
Received: from kbuild by 4fbc2b3ce5aa with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mKHfP-0004C2-IQ; Sun, 29 Aug 2021 10:03:55 +0000
Date:   Sun, 29 Aug 2021 18:03:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:for-linus] BUILD SUCCESS
 045a9277b5615846c7b662ffaba84e781f08a172
Message-ID: <612b5b73.o3Cyctd0jBcsKY99%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git for-linus
branch HEAD: 045a9277b5615846c7b662ffaba84e781f08a172  PCI/sysfs: Use correct variable for the legacy_mem sysfs object

elapsed time: 14074m

configs tested: 127
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210820
sparc                            allyesconfig
arc                              allyesconfig
nios2                            allyesconfig
alpha                            allyesconfig
arm                         lpc18xx_defconfig
sh                         ap325rxa_defconfig
mips                         db1xxx_defconfig
arm                        vexpress_defconfig
powerpc                     tqm8560_defconfig
powerpc                 mpc836x_mds_defconfig
xtensa                    smp_lx200_defconfig
alpha                               defconfig
mips                         rt305x_defconfig
arm                             pxa_defconfig
powerpc                      chrp32_defconfig
mips                     loongson2k_defconfig
sh                         ecovec24_defconfig
arm                              alldefconfig
arc                     haps_hs_smp_defconfig
powerpc                    klondike_defconfig
powerpc                        fsp2_defconfig
mips                       capcella_defconfig
mips                          ath25_defconfig
arm                           viper_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
nds32                             allnoconfig
nds32                               defconfig
csky                                defconfig
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
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20210818
x86_64               randconfig-a006-20210818
x86_64               randconfig-a003-20210818
x86_64               randconfig-a005-20210818
x86_64               randconfig-a002-20210818
x86_64               randconfig-a001-20210818
x86_64               randconfig-a005-20210820
x86_64               randconfig-a006-20210820
x86_64               randconfig-a001-20210820
x86_64               randconfig-a003-20210820
x86_64               randconfig-a004-20210820
x86_64               randconfig-a002-20210820
i386                 randconfig-a006-20210820
i386                 randconfig-a001-20210820
i386                 randconfig-a002-20210820
i386                 randconfig-a005-20210820
i386                 randconfig-a003-20210820
i386                 randconfig-a004-20210820
arc                  randconfig-r043-20210819
riscv                randconfig-r042-20210819
s390                 randconfig-r044-20210819
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
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
i386                 randconfig-c001-20210820
s390                 randconfig-c005-20210820
arm                  randconfig-c002-20210820
riscv                randconfig-c006-20210820
powerpc              randconfig-c003-20210820
x86_64               randconfig-c007-20210820
mips                 randconfig-c004-20210820
i386                 randconfig-a004-20210819
i386                 randconfig-a006-20210819
i386                 randconfig-a001-20210819
i386                 randconfig-a002-20210819
i386                 randconfig-a003-20210819
i386                 randconfig-a005-20210819
x86_64               randconfig-a014-20210820
x86_64               randconfig-a016-20210820
x86_64               randconfig-a015-20210820
x86_64               randconfig-a013-20210820
x86_64               randconfig-a012-20210820
x86_64               randconfig-a011-20210820
x86_64               randconfig-a004-20210819
x86_64               randconfig-a006-20210819
x86_64               randconfig-a003-20210819
x86_64               randconfig-a002-20210819
x86_64               randconfig-a005-20210819
x86_64               randconfig-a001-20210819
hexagon              randconfig-r041-20210820
hexagon              randconfig-r045-20210820
riscv                randconfig-r042-20210820
s390                 randconfig-r044-20210820
hexagon              randconfig-r041-20210819
hexagon              randconfig-r045-20210819
hexagon              randconfig-r041-20210818
riscv                randconfig-r042-20210818
s390                 randconfig-r044-20210818
hexagon              randconfig-r045-20210818

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
