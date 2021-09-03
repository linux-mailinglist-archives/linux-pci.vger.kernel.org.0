Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B488400862
	for <lists+linux-pci@lfdr.de>; Sat,  4 Sep 2021 01:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237411AbhICXrn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Sep 2021 19:47:43 -0400
Received: from mga18.intel.com ([134.134.136.126]:13645 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236816AbhICXrn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 3 Sep 2021 19:47:43 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10096"; a="206659654"
X-IronPort-AV: E=Sophos;i="5.85,266,1624345200"; 
   d="scan'208";a="206659654"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2021 16:46:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,266,1624345200"; 
   d="scan'208";a="690082576"
Received: from lkp-server01.sh.intel.com (HELO 2115029a3e5c) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 03 Sep 2021 16:46:41 -0700
Received: from kbuild by 2115029a3e5c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mMItM-0000xD-PP; Fri, 03 Sep 2021 23:46:40 +0000
Date:   Sat, 04 Sep 2021 07:46:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS 742a4c49a82a8fe1369e4ec2af4a9bf69123cb88
Message-ID: <6132b3cd.gM554i/vRlAItxOt%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
branch HEAD: 742a4c49a82a8fe1369e4ec2af4a9bf69123cb88  Merge branch 'remotes/lorenzo/pci/tools'

elapsed time: 1655m

configs tested: 110
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm64                               defconfig
arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                        workpad_defconfig
powerpc                      pasemi_defconfig
sh                   sh7770_generic_defconfig
arm                         s5pv210_defconfig
powerpc                mpc7448_hpc2_defconfig
mips                  maltasmvp_eva_defconfig
mips                         cobalt_defconfig
openrisc                    or1ksim_defconfig
arm                        multi_v7_defconfig
arm                          ep93xx_defconfig
mips                         mpc30x_defconfig
powerpc                         wii_defconfig
powerpc                     stx_gp3_defconfig
arm                     davinci_all_defconfig
mips                           gcw0_defconfig
sh                           se7724_defconfig
arm                          pcm027_defconfig
mips                       capcella_defconfig
powerpc                     sequoia_defconfig
mips                       rbtx49xx_defconfig
m68k                            mac_defconfig
arm                           tegra_defconfig
sh                          rsk7201_defconfig
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
i386                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
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
riscv                randconfig-r042-20210903
s390                 randconfig-r044-20210903
arc                  randconfig-r043-20210903
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
i386                 randconfig-a012-20210904
i386                 randconfig-a015-20210904
i386                 randconfig-a011-20210904
i386                 randconfig-a013-20210904
i386                 randconfig-a014-20210904
i386                 randconfig-a016-20210904
hexagon              randconfig-r045-20210903
hexagon              randconfig-r041-20210903

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
