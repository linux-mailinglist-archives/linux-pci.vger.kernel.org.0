Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0E353F6150
	for <lists+linux-pci@lfdr.de>; Tue, 24 Aug 2021 17:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238093AbhHXPLD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Aug 2021 11:11:03 -0400
Received: from mga11.intel.com ([192.55.52.93]:56999 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238059AbhHXPLD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 24 Aug 2021 11:11:03 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10086"; a="214204536"
X-IronPort-AV: E=Sophos;i="5.84,347,1620716400"; 
   d="scan'208";a="214204536"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2021 08:03:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,347,1620716400"; 
   d="scan'208";a="685393568"
Received: from lkp-server02.sh.intel.com (HELO 181e7be6f509) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 24 Aug 2021 08:03:51 -0700
Received: from kbuild by 181e7be6f509 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mIXxv-0000cl-0e; Tue, 24 Aug 2021 15:03:51 +0000
Date:   Tue, 24 Aug 2021 23:03:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:pci/vpd] BUILD SUCCESS
 466a79f417be2f2b0d875a9766a3cff10c3bedf1
Message-ID: <61250a30.V7ULrxjY2ef0NKMU%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/vpd
branch HEAD: 466a79f417be2f2b0d875a9766a3cff10c3bedf1  tg3: Search VPD with pci_vpd_find_ro_info_keyword()

elapsed time: 5391m

configs tested: 125
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
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

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
