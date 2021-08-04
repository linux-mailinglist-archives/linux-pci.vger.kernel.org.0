Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0023E00BF
	for <lists+linux-pci@lfdr.de>; Wed,  4 Aug 2021 14:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237962AbhHDMBw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Aug 2021 08:01:52 -0400
Received: from mga09.intel.com ([134.134.136.24]:29909 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234815AbhHDMBv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 4 Aug 2021 08:01:51 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10065"; a="213888162"
X-IronPort-AV: E=Sophos;i="5.84,294,1620716400"; 
   d="scan'208";a="213888162"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2021 05:01:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,294,1620716400"; 
   d="scan'208";a="521815384"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 04 Aug 2021 05:01:37 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mBFab-000EsZ-5S; Wed, 04 Aug 2021 12:01:37 +0000
Date:   Wed, 04 Aug 2021 20:00:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:pci/virtualization] BUILD SUCCESS
 f8bd7c48ecb0e94d2b2cf1b21385ba27f0cd15d9
Message-ID: <610a817b.shHlmXspRGnvbv0N%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/virtualization
branch HEAD: f8bd7c48ecb0e94d2b2cf1b21385ba27f0cd15d9  PCI/ACS: Enforce pci=noats with Transaction Blocking

elapsed time: 729m

configs tested: 139
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210803
i386                 randconfig-c001-20210804
nios2                               defconfig
mips                           ip28_defconfig
mips                             allyesconfig
arm                        cerfcube_defconfig
arm                        neponset_defconfig
arc                        nsimosci_defconfig
arm                         socfpga_defconfig
sh                           se7724_defconfig
powerpc                    mvme5100_defconfig
mips                      bmips_stb_defconfig
arm                         hackkit_defconfig
powerpc                      obs600_defconfig
m68k                          atari_defconfig
mips                           rs90_defconfig
mips                        jmr3927_defconfig
mips                           ip32_defconfig
sh                         microdev_defconfig
m68k                           sun3_defconfig
mips                          ath79_defconfig
openrisc                 simple_smp_defconfig
arm                        spear3xx_defconfig
powerpc                     tqm8541_defconfig
nios2                         3c120_defconfig
arm                            pleb_defconfig
powerpc                     pseries_defconfig
arm                        trizeps4_defconfig
arm                          imote2_defconfig
ia64                             allmodconfig
arm                          gemini_defconfig
sh                   sh7770_generic_defconfig
sh                           se7343_defconfig
um                             i386_defconfig
x86_64                           alldefconfig
sparc                       sparc32_defconfig
powerpc                     mpc512x_defconfig
powerpc                     ppa8548_defconfig
arm                        vexpress_defconfig
arm                       multi_v4t_defconfig
arm                      integrator_defconfig
powerpc                 mpc8540_ads_defconfig
powerpc                       ebony_defconfig
powerpc                      bamboo_defconfig
powerpc                     kilauea_defconfig
mips                        bcm63xx_defconfig
powerpc                 mpc8315_rdb_defconfig
ia64                                defconfig
ia64                             allyesconfig
x86_64                            allnoconfig
m68k                             allmodconfig
m68k                                defconfig
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
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a002-20210803
x86_64               randconfig-a004-20210803
x86_64               randconfig-a006-20210803
x86_64               randconfig-a003-20210803
x86_64               randconfig-a001-20210803
x86_64               randconfig-a005-20210803
i386                 randconfig-a004-20210803
i386                 randconfig-a005-20210803
i386                 randconfig-a002-20210803
i386                 randconfig-a006-20210803
i386                 randconfig-a001-20210803
i386                 randconfig-a003-20210803
i386                 randconfig-a004-20210804
i386                 randconfig-a002-20210804
i386                 randconfig-a003-20210804
i386                 randconfig-a001-20210804
i386                 randconfig-a005-20210804
i386                 randconfig-a006-20210804
x86_64               randconfig-a012-20210804
x86_64               randconfig-a016-20210804
x86_64               randconfig-a011-20210804
x86_64               randconfig-a013-20210804
x86_64               randconfig-a014-20210804
x86_64               randconfig-a015-20210804
i386                 randconfig-a012-20210804
i386                 randconfig-a011-20210804
i386                 randconfig-a015-20210804
i386                 randconfig-a013-20210804
i386                 randconfig-a014-20210804
i386                 randconfig-a016-20210804
i386                 randconfig-a012-20210803
i386                 randconfig-a011-20210803
i386                 randconfig-a015-20210803
i386                 randconfig-a013-20210803
i386                 randconfig-a014-20210803
i386                 randconfig-a016-20210803
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-c001-20210804
x86_64               randconfig-c001-20210803
x86_64               randconfig-a012-20210803
x86_64               randconfig-a016-20210803
x86_64               randconfig-a013-20210803
x86_64               randconfig-a011-20210803
x86_64               randconfig-a014-20210803
x86_64               randconfig-a015-20210803

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
