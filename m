Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD4C3D4732
	for <lists+linux-pci@lfdr.de>; Sat, 24 Jul 2021 12:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234219AbhGXJ6h (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 24 Jul 2021 05:58:37 -0400
Received: from mga05.intel.com ([192.55.52.43]:45067 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235237AbhGXJ6h (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 24 Jul 2021 05:58:37 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10054"; a="297582953"
X-IronPort-AV: E=Sophos;i="5.84,266,1620716400"; 
   d="scan'208";a="297582953"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2021 03:39:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,266,1620716400"; 
   d="scan'208";a="578617067"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 24 Jul 2021 03:39:07 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m7F3j-0003Em-9V; Sat, 24 Jul 2021 10:39:07 +0000
Date:   Sat, 24 Jul 2021 18:38:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:for-linus] BUILD SUCCESS
 e2f55370b42205bda2f8b02c5933b9df2456bd53
Message-ID: <60fbedb6.A0rQHhUZ0gpDQFiK%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git for-linus
branch HEAD: e2f55370b42205bda2f8b02c5933b9df2456bd53  MAINTAINERS: Add Rahul Tanwar as Intel LGM Gateway PCIe maintainer

elapsed time: 781m

configs tested: 137
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210723
i386                 randconfig-c001-20210724
nios2                               defconfig
arc                              allyesconfig
m68k                          sun3x_defconfig
arm                          collie_defconfig
powerpc                      makalu_defconfig
powerpc                 mpc834x_itx_defconfig
mips                         bigsur_defconfig
sh                ecovec24-romimage_defconfig
powerpc                      bamboo_defconfig
arm                           tegra_defconfig
powerpc                 mpc837x_mds_defconfig
sh                           se7750_defconfig
mips                  maltasmvp_eva_defconfig
arm                       imx_v6_v7_defconfig
mips                           ip22_defconfig
powerpc                     redwood_defconfig
mips                      bmips_stb_defconfig
arc                           tb10x_defconfig
powerpc                   motionpro_defconfig
sh                             sh03_defconfig
sh                           se7712_defconfig
s390                             alldefconfig
powerpc                         ps3_defconfig
m68k                       m5208evb_defconfig
sh                         microdev_defconfig
powerpc                      cm5200_defconfig
arm                          pxa910_defconfig
arc                      axs103_smp_defconfig
arm                         lpc32xx_defconfig
arm                        trizeps4_defconfig
arm                          imote2_defconfig
openrisc                  or1klitex_defconfig
sh                          r7785rp_defconfig
h8300                            alldefconfig
powerpc                 mpc85xx_cds_defconfig
parisc                generic-64bit_defconfig
arc                    vdk_hs38_smp_defconfig
powerpc                     sequoia_defconfig
m68k                       m5275evb_defconfig
h8300                       h8s-sim_defconfig
sh                           se7722_defconfig
powerpc                   bluestone_defconfig
arm                     am200epdkit_defconfig
mips                      maltasmvp_defconfig
powerpc                      walnut_defconfig
sh                           se7619_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
x86_64                            allnoconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
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
i386                 randconfig-a005-20210724
i386                 randconfig-a003-20210724
i386                 randconfig-a004-20210724
i386                 randconfig-a002-20210724
i386                 randconfig-a001-20210724
i386                 randconfig-a006-20210724
i386                 randconfig-a005-20210723
i386                 randconfig-a003-20210723
i386                 randconfig-a004-20210723
i386                 randconfig-a002-20210723
i386                 randconfig-a001-20210723
i386                 randconfig-a006-20210723
x86_64               randconfig-a011-20210723
x86_64               randconfig-a016-20210723
x86_64               randconfig-a013-20210723
x86_64               randconfig-a014-20210723
x86_64               randconfig-a012-20210723
x86_64               randconfig-a015-20210723
i386                 randconfig-a016-20210723
i386                 randconfig-a013-20210723
i386                 randconfig-a012-20210723
i386                 randconfig-a011-20210723
i386                 randconfig-a014-20210723
i386                 randconfig-a015-20210723
x86_64               randconfig-a003-20210724
x86_64               randconfig-a006-20210724
x86_64               randconfig-a001-20210724
x86_64               randconfig-a005-20210724
x86_64               randconfig-a004-20210724
x86_64               randconfig-a002-20210724
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
x86_64               randconfig-c001-20210723
x86_64               randconfig-c001-20210724
x86_64               randconfig-b001-20210723
x86_64               randconfig-a003-20210723
x86_64               randconfig-a006-20210723
x86_64               randconfig-a001-20210723
x86_64               randconfig-a005-20210723
x86_64               randconfig-a004-20210723
x86_64               randconfig-a002-20210723

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
