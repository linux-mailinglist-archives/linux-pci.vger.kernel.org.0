Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B436438D0F
	for <lists+linux-pci@lfdr.de>; Mon, 25 Oct 2021 03:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbhJYBp4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 24 Oct 2021 21:45:56 -0400
Received: from mga07.intel.com ([134.134.136.100]:37758 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231928AbhJYBpz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 24 Oct 2021 21:45:55 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10147"; a="293014322"
X-IronPort-AV: E=Sophos;i="5.87,179,1631602800"; 
   d="scan'208";a="293014322"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2021 18:43:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,179,1631602800"; 
   d="scan'208";a="496564676"
Received: from lkp-server02.sh.intel.com (HELO 74392981b700) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 24 Oct 2021 18:43:33 -0700
Received: from kbuild by 74392981b700 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mep1Q-0001F8-De; Mon, 25 Oct 2021 01:43:32 +0000
Date:   Mon, 25 Oct 2021 09:42:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:next] BUILD SUCCESS
 1b6c2cdb635d3c966b7b6e113844f33cacb1b2c9
Message-ID: <61760b9e.InPcNdRWwk1MYdCU%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
branch HEAD: 1b6c2cdb635d3c966b7b6e113844f33cacb1b2c9  Merge branch 'remotes/lorenzo/pci/xgene'

elapsed time: 4833m

configs tested: 128
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211022
powerpc                        warp_defconfig
powerpc                 mpc834x_mds_defconfig
sh                        sh7757lcr_defconfig
arm                      jornada720_defconfig
mips                           ip28_defconfig
arm                         axm55xx_defconfig
mips                         db1xxx_defconfig
mips                        omega2p_defconfig
mips                        maltaup_defconfig
arm                            hisi_defconfig
openrisc                            defconfig
mips                           ip32_defconfig
arm                        neponset_defconfig
sh                        edosk7705_defconfig
arm                     davinci_all_defconfig
arm                        spear6xx_defconfig
m68k                          atari_defconfig
mips                           xway_defconfig
arm                            mps2_defconfig
arm                  randconfig-c002-20211025
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
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
s390                             allmodconfig
parisc                              defconfig
s390                                defconfig
s390                             allyesconfig
parisc                           allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20211022
i386                 randconfig-a003-20211022
i386                 randconfig-a002-20211022
i386                 randconfig-a005-20211022
i386                 randconfig-a006-20211022
i386                 randconfig-a001-20211022
x86_64               randconfig-a013-20211021
x86_64               randconfig-a015-20211021
x86_64               randconfig-a011-20211021
x86_64               randconfig-a014-20211021
x86_64               randconfig-a016-20211021
x86_64               randconfig-a012-20211021
x86_64               randconfig-a002-20211024
x86_64               randconfig-a004-20211024
x86_64               randconfig-a005-20211024
x86_64               randconfig-a006-20211024
x86_64               randconfig-a001-20211024
x86_64               randconfig-a003-20211024
i386                 randconfig-a012-20211025
i386                 randconfig-a013-20211025
i386                 randconfig-a011-20211025
i386                 randconfig-a016-20211025
i386                 randconfig-a015-20211025
i386                 randconfig-a014-20211025
i386                 randconfig-a012-20211021
i386                 randconfig-a013-20211021
i386                 randconfig-a011-20211021
i386                 randconfig-a016-20211021
i386                 randconfig-a015-20211021
i386                 randconfig-a014-20211021
arc                  randconfig-r043-20211021
riscv                randconfig-r042-20211021
s390                 randconfig-r044-20211021
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
riscv                            allyesconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                           allyesconfig

clang tested configs:
i386                 randconfig-a004-20211021
i386                 randconfig-a003-20211021
i386                 randconfig-a002-20211021
i386                 randconfig-a005-20211021
i386                 randconfig-a001-20211021
i386                 randconfig-a006-20211021
x86_64               randconfig-a013-20211022
x86_64               randconfig-a015-20211022
x86_64               randconfig-a011-20211022
x86_64               randconfig-a014-20211022
x86_64               randconfig-a016-20211022
x86_64               randconfig-a012-20211022
x86_64               randconfig-a002-20211021
x86_64               randconfig-a004-20211021
x86_64               randconfig-a005-20211021
x86_64               randconfig-a001-20211021
x86_64               randconfig-a006-20211021
x86_64               randconfig-a003-20211021
hexagon              randconfig-r045-20211021
hexagon              randconfig-r041-20211021
hexagon              randconfig-r045-20211025
hexagon              randconfig-r041-20211025

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
