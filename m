Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC47D2B34CE
	for <lists+linux-pci@lfdr.de>; Sun, 15 Nov 2020 13:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbgKOMLP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 15 Nov 2020 07:11:15 -0500
Received: from mga09.intel.com ([134.134.136.24]:54721 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726871AbgKOMLO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 15 Nov 2020 07:11:14 -0500
IronPort-SDR: rwRNhMV9nsa4I3AzDviqgPbIQI+K0Rcb+vmRD/mhlDaN4UjFNm32pYwyibE9p40x76Zd6T1Xel
 m92k97FTuT3w==
X-IronPort-AV: E=McAfee;i="6000,8403,9805"; a="170813708"
X-IronPort-AV: E=Sophos;i="5.77,480,1596524400"; 
   d="scan'208";a="170813708"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2020 04:11:13 -0800
IronPort-SDR: 9D8qtxulzgOjcKoeldERj+kqk4NwQ6UfWKIMiEuQ5xZkF7V0H5yqkV7WM1UV/RxGJWGIsTvUVR
 iIoVJdtb4jsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,480,1596524400"; 
   d="scan'208";a="543238529"
Received: from lkp-server01.sh.intel.com (HELO 2e68b9ba5db3) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 15 Nov 2020 04:11:12 -0800
Received: from kbuild by 2e68b9ba5db3 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1keGsB-0000CS-Qr; Sun, 15 Nov 2020 12:11:11 +0000
Date:   Sun, 15 Nov 2020 20:10:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:pci/misc] BUILD SUCCESS
 69afb29538421eb08c034a52df6fb3e8dc423fc9
Message-ID: <5fb11ab4.M/Bx4rSJj2zWPRqe%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git  pci/misc
branch HEAD: 69afb29538421eb08c034a52df6fb3e8dc423fc9  PCI: Fix overflow in command-line resource alignment requests

elapsed time: 720m

configs tested: 120
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
riscv                    nommu_k210_defconfig
ia64                                defconfig
arm                          tango4_defconfig
powerpc                      ppc40x_defconfig
mips                            gpr_defconfig
c6x                              alldefconfig
arm                       omap2plus_defconfig
sh                           se7722_defconfig
mips                             allyesconfig
m68k                       m5249evb_defconfig
m68k                         amcore_defconfig
powerpc                     tqm8560_defconfig
sh                          r7785rp_defconfig
powerpc                         wii_defconfig
arm                           h5000_defconfig
mips                      loongson3_defconfig
mips                            ar7_defconfig
arc                            hsdk_defconfig
sh                        apsh4ad0a_defconfig
powerpc                     ksi8560_defconfig
powerpc                     ep8248e_defconfig
sparc64                          alldefconfig
powerpc                 mpc837x_mds_defconfig
arm                        spear3xx_defconfig
powerpc                 mpc8540_ads_defconfig
mips                         db1xxx_defconfig
sh                             espt_defconfig
mips                        jmr3927_defconfig
mips                        bcm47xx_defconfig
arm                         orion5x_defconfig
mips                  cavium_octeon_defconfig
sparc                       sparc64_defconfig
alpha                            allyesconfig
mips                       rbtx49xx_defconfig
sh                           se7750_defconfig
csky                             alldefconfig
sparc64                             defconfig
powerpc                  storcenter_defconfig
powerpc                     stx_gp3_defconfig
c6x                        evmc6474_defconfig
arm                         axm55xx_defconfig
sh                          landisk_defconfig
m68k                         apollo_defconfig
sh                           se7712_defconfig
mips                        nlm_xlr_defconfig
sh                      rts7751r2d1_defconfig
sh                          polaris_defconfig
mips                           ip27_defconfig
mips                          rm200_defconfig
arm                       spear13xx_defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a006-20201115
i386                 randconfig-a005-20201115
i386                 randconfig-a001-20201115
i386                 randconfig-a002-20201115
i386                 randconfig-a004-20201115
i386                 randconfig-a003-20201115
x86_64               randconfig-a015-20201115
x86_64               randconfig-a011-20201115
x86_64               randconfig-a014-20201115
x86_64               randconfig-a013-20201115
x86_64               randconfig-a016-20201115
x86_64               randconfig-a012-20201115
i386                 randconfig-a012-20201115
i386                 randconfig-a014-20201115
i386                 randconfig-a016-20201115
i386                 randconfig-a011-20201115
i386                 randconfig-a015-20201115
i386                 randconfig-a013-20201115
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a003-20201115
x86_64               randconfig-a005-20201115
x86_64               randconfig-a004-20201115
x86_64               randconfig-a002-20201115
x86_64               randconfig-a001-20201115
x86_64               randconfig-a006-20201115

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
