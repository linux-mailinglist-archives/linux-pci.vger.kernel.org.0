Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54D8A3F6AFB
	for <lists+linux-pci@lfdr.de>; Tue, 24 Aug 2021 23:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233431AbhHXV1E (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Aug 2021 17:27:04 -0400
Received: from mga07.intel.com ([134.134.136.100]:38319 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230523AbhHXV1E (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 24 Aug 2021 17:27:04 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10086"; a="281120913"
X-IronPort-AV: E=Sophos;i="5.84,348,1620716400"; 
   d="scan'208";a="281120913"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2021 14:26:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,348,1620716400"; 
   d="scan'208";a="455764259"
Received: from lkp-server02.sh.intel.com (HELO 181e7be6f509) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 24 Aug 2021 14:26:17 -0700
Received: from kbuild by 181e7be6f509 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mIdw1-0000sW-AP; Tue, 24 Aug 2021 21:26:17 +0000
Date:   Wed, 25 Aug 2021 05:25:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:pci/virtualization] BUILD SUCCESS
 57a4ab1584e6f0a2f8f6075af3986784733909f2
Message-ID: <612563d5.5pBV8unvLEbF6vGx%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/virtualization
branch HEAD: 57a4ab1584e6f0a2f8f6075af3986784733909f2  iommu/of: Fix pci_request_acs() before enumerating PCI devices

elapsed time: 5749m

configs tested: 138
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                         cm_x300_defconfig
alpha                            alldefconfig
m68k                         apollo_defconfig
powerpc                      pmac32_defconfig
sh                          urquell_defconfig
openrisc                         alldefconfig
m68k                            q40_defconfig
powerpc                   lite5200b_defconfig
xtensa                  nommu_kc705_defconfig
arm                        clps711x_defconfig
mips                         tb0219_defconfig
powerpc                 mpc8540_ads_defconfig
arm                         palmz72_defconfig
sh                             shx3_defconfig
powerpc                 mpc85xx_cds_defconfig
riscv                            alldefconfig
powerpc                     asp8347_defconfig
arc                     nsimosci_hs_defconfig
m68k                        mvme16x_defconfig
arm                            xcep_defconfig
sh                           se7780_defconfig
arm                          imote2_defconfig
arm                       imx_v4_v5_defconfig
arm                     eseries_pxa_defconfig
arm                        shmobile_defconfig
sh                        edosk7705_defconfig
powerpc                  iss476-smp_defconfig
powerpc                    amigaone_defconfig
arc                         haps_hs_defconfig
arm                       aspeed_g5_defconfig
arm                         s5pv210_defconfig
arm                             pxa_defconfig
arm                            qcom_defconfig
powerpc                  storcenter_defconfig
arm                        oxnas_v6_defconfig
powerpc                 mpc8315_rdb_defconfig
s390                          debug_defconfig
powerpc                 linkstation_defconfig
mips                  decstation_64_defconfig
microblaze                      mmu_defconfig
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
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
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
i386                 randconfig-a006-20210822
i386                 randconfig-a001-20210822
i386                 randconfig-a002-20210822
i386                 randconfig-a005-20210822
i386                 randconfig-a003-20210822
i386                 randconfig-a004-20210822
x86_64               randconfig-a014-20210821
x86_64               randconfig-a016-20210821
x86_64               randconfig-a015-20210821
x86_64               randconfig-a013-20210821
x86_64               randconfig-a012-20210821
x86_64               randconfig-a011-20210821
i386                 randconfig-a011-20210821
i386                 randconfig-a016-20210821
i386                 randconfig-a012-20210821
i386                 randconfig-a014-20210821
i386                 randconfig-a013-20210821
i386                 randconfig-a015-20210821
arc                  randconfig-r043-20210821
riscv                randconfig-r042-20210821
s390                 randconfig-r044-20210821
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
i386                 randconfig-c001-20210822
s390                 randconfig-c005-20210822
arm                  randconfig-c002-20210822
riscv                randconfig-c006-20210822
powerpc              randconfig-c003-20210822
x86_64               randconfig-c007-20210822
mips                 randconfig-c004-20210822
x86_64               randconfig-a005-20210821
x86_64               randconfig-a001-20210821
x86_64               randconfig-a006-20210821
x86_64               randconfig-a003-20210821
x86_64               randconfig-a004-20210821
x86_64               randconfig-a002-20210821
i386                 randconfig-a006-20210821
i386                 randconfig-a001-20210821
i386                 randconfig-a002-20210821
i386                 randconfig-a005-20210821
i386                 randconfig-a004-20210821
i386                 randconfig-a003-20210821
i386                 randconfig-a011-20210822
i386                 randconfig-a016-20210822
i386                 randconfig-a012-20210822
i386                 randconfig-a014-20210822
i386                 randconfig-a013-20210822
i386                 randconfig-a015-20210822

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
