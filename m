Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07AFA3F5761
	for <lists+linux-pci@lfdr.de>; Tue, 24 Aug 2021 06:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbhHXEmf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Aug 2021 00:42:35 -0400
Received: from mga06.intel.com ([134.134.136.31]:53420 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229568AbhHXEmf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 24 Aug 2021 00:42:35 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10085"; a="278245840"
X-IronPort-AV: E=Sophos;i="5.84,346,1620716400"; 
   d="scan'208";a="278245840"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2021 21:41:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,346,1620716400"; 
   d="scan'208";a="455265274"
Received: from lkp-server02.sh.intel.com (HELO 181e7be6f509) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 23 Aug 2021 21:41:50 -0700
Received: from kbuild by 181e7be6f509 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mIOFx-0000JC-Ag; Tue, 24 Aug 2021 04:41:49 +0000
Date:   Tue, 24 Aug 2021 12:41:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS eda0e92fdd5e3f33bbbd54c77e349f6d7408b9e6
Message-ID: <61247866.jfYQWAvFoCwDcQtj%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
branch HEAD: eda0e92fdd5e3f33bbbd54c77e349f6d7408b9e6  Merge branch 'remotes/lorenzo/pci/tools'

elapsed time: 5015m

configs tested: 160
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210821
mips                           ip28_defconfig
arm                            qcom_defconfig
mips                            ar7_defconfig
powerpc                     rainier_defconfig
powerpc                   bluestone_defconfig
arm                         lpc18xx_defconfig
arm                       multi_v4t_defconfig
s390                                defconfig
mips                        bcm63xx_defconfig
sh                      rts7751r2d1_defconfig
m68k                             allmodconfig
mips                          rb532_defconfig
arm                         lpc32xx_defconfig
arm                           tegra_defconfig
arm                        multi_v7_defconfig
arm                        clps711x_defconfig
mips                         tb0219_defconfig
powerpc                 mpc8540_ads_defconfig
arm                         palmz72_defconfig
sh                             shx3_defconfig
powerpc                 mpc85xx_cds_defconfig
arm                       imx_v4_v5_defconfig
mips                         bigsur_defconfig
x86_64                           alldefconfig
arm                          exynos_defconfig
arm                         socfpga_defconfig
powerpc64                           defconfig
mips                         db1xxx_defconfig
mips                    maltaup_xpa_defconfig
sh                        dreamcast_defconfig
m68k                          multi_defconfig
powerpc                      pasemi_defconfig
mips                           ip32_defconfig
openrisc                 simple_smp_defconfig
powerpc                        icon_defconfig
nios2                            alldefconfig
sh                        sh7763rdp_defconfig
arm                           u8500_defconfig
xtensa                              defconfig
sh                        edosk7705_defconfig
powerpc                    amigaone_defconfig
arc                         haps_hs_defconfig
arm                       aspeed_g5_defconfig
arm                         s5pv210_defconfig
powerpc                     pq2fads_defconfig
arm                            pleb_defconfig
riscv                    nommu_virt_defconfig
arm                          badge4_defconfig
arc                     nsimosci_hs_defconfig
powerpc                      ppc44x_defconfig
powerpc                  mpc866_ads_defconfig
powerpc                 mpc8272_ads_defconfig
arc                      axs103_smp_defconfig
sh                ecovec24-romimage_defconfig
sh                     sh7710voipgw_defconfig
sh                             sh03_defconfig
arm                            xcep_defconfig
sh                            migor_defconfig
arm                         orion5x_defconfig
powerpc                     akebono_defconfig
arc                        vdk_hs38_defconfig
sh                          rsk7203_defconfig
sh                               alldefconfig
sh                               j2_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
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
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a006-20210820
i386                 randconfig-a001-20210820
i386                 randconfig-a002-20210820
i386                 randconfig-a005-20210820
i386                 randconfig-a003-20210820
i386                 randconfig-a004-20210820
x86_64               randconfig-a005-20210820
x86_64               randconfig-a006-20210820
x86_64               randconfig-a001-20210820
x86_64               randconfig-a003-20210820
x86_64               randconfig-a004-20210820
x86_64               randconfig-a002-20210820
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
