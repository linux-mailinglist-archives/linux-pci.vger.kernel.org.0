Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90F042D72CD
	for <lists+linux-pci@lfdr.de>; Fri, 11 Dec 2020 10:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405625AbgLKJ3D (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Dec 2020 04:29:03 -0500
Received: from mga18.intel.com ([134.134.136.126]:58925 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404463AbgLKJ2o (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 11 Dec 2020 04:28:44 -0500
IronPort-SDR: ckkx343OcBkmubC+PUPP242JpzAuhSiCmSG0JUl8A9oQkEMNZ5cMGEwI//L6oZGoyvUgkc8Odd
 bIvgf2nWwh5g==
X-IronPort-AV: E=McAfee;i="6000,8403,9831"; a="162161546"
X-IronPort-AV: E=Sophos;i="5.78,411,1599548400"; 
   d="scan'208";a="162161546"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2020 01:28:03 -0800
IronPort-SDR: fbtaKFu/jI6M0jJnyIpMdp/ES9f2a7ES17QznNVxlj7pxaj97EvMdKfJQ/7rayw6t94bK1l+eA
 yoJOtrywc4jA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,410,1599548400"; 
   d="scan'208";a="376434140"
Received: from lkp-server01.sh.intel.com (HELO ecc0cebe68d1) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 11 Dec 2020 01:28:02 -0800
Received: from kbuild by ecc0cebe68d1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kneiX-0000p9-Tp; Fri, 11 Dec 2020 09:28:01 +0000
Date:   Fri, 11 Dec 2020 17:27:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:pci/enumeration] BUILD SUCCESS
 0af6e21eed2778e68139941389460e2a00d6ef8e
Message-ID: <5fd33b74.2JjUk/jRRNqzDwji%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git  pci/enumeration
branch HEAD: 0af6e21eed2778e68139941389460e2a00d6ef8e  PCI: Keep both device and resource name for config space remaps

elapsed time: 721m

configs tested: 159
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                         hackkit_defconfig
arm                          moxart_defconfig
mips                           ip27_defconfig
mips                      bmips_stb_defconfig
sparc                            alldefconfig
mips                        workpad_defconfig
arm                        shmobile_defconfig
powerpc                     ep8248e_defconfig
arm                          pcm027_defconfig
mips                         bigsur_defconfig
powerpc                 canyonlands_defconfig
mips                           ci20_defconfig
xtensa                  nommu_kc705_defconfig
arc                        vdk_hs38_defconfig
riscv                            allyesconfig
sh                           sh2007_defconfig
powerpc                     tqm8560_defconfig
arm                           viper_defconfig
arm                          collie_defconfig
sh                 kfr2r09-romimage_defconfig
um                             i386_defconfig
arc                            hsdk_defconfig
mips                    maltaup_xpa_defconfig
arm                          ep93xx_defconfig
arm                            zeus_defconfig
sh                           se7343_defconfig
sh                            migor_defconfig
mips                        vocore2_defconfig
arm                         orion5x_defconfig
powerpc                 mpc836x_mds_defconfig
xtensa                    xip_kc705_defconfig
sh                          kfr2r09_defconfig
mips                        bcm47xx_defconfig
microblaze                      mmu_defconfig
arc                          axs103_defconfig
arm                     eseries_pxa_defconfig
arm                      tct_hammer_defconfig
powerpc                    mvme5100_defconfig
powerpc                      acadia_defconfig
sh                             shx3_defconfig
arm                          imote2_defconfig
mips                           gcw0_defconfig
powerpc                     asp8347_defconfig
arm                          simpad_defconfig
sparc                            allyesconfig
m68k                                defconfig
alpha                            alldefconfig
sh                         microdev_defconfig
arm                           u8500_defconfig
powerpc                        icon_defconfig
c6x                                 defconfig
mips                             allyesconfig
mips                          rb532_defconfig
sh                          urquell_defconfig
sh                          sdk7786_defconfig
powerpc                      ppc64e_defconfig
arm                         palmz72_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                         shannon_defconfig
sh                               j2_defconfig
m68k                       m5249evb_defconfig
arm                       versatile_defconfig
sh                   rts7751r2dplus_defconfig
arm                       omap2plus_defconfig
powerpc                       ebony_defconfig
arc                         haps_hs_defconfig
arm                         s5pv210_defconfig
powerpc                      makalu_defconfig
mips                          rm200_defconfig
arm                             mxs_defconfig
riscv                            alldefconfig
powerpc                      arches_defconfig
m68k                        m5272c3_defconfig
powerpc                 mpc837x_rdb_defconfig
arm                          gemini_defconfig
arm                      pxa255-idp_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
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
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20201209
i386                 randconfig-a005-20201209
i386                 randconfig-a001-20201209
i386                 randconfig-a002-20201209
i386                 randconfig-a006-20201209
i386                 randconfig-a003-20201209
i386                 randconfig-a001-20201210
i386                 randconfig-a004-20201210
i386                 randconfig-a003-20201210
i386                 randconfig-a002-20201210
i386                 randconfig-a005-20201210
i386                 randconfig-a006-20201210
x86_64               randconfig-a016-20201209
x86_64               randconfig-a012-20201209
x86_64               randconfig-a013-20201209
x86_64               randconfig-a014-20201209
x86_64               randconfig-a015-20201209
x86_64               randconfig-a011-20201209
i386                 randconfig-a013-20201209
i386                 randconfig-a014-20201209
i386                 randconfig-a011-20201209
i386                 randconfig-a015-20201209
i386                 randconfig-a012-20201209
i386                 randconfig-a016-20201209
i386                 randconfig-a014-20201210
i386                 randconfig-a013-20201210
i386                 randconfig-a012-20201210
i386                 randconfig-a011-20201210
i386                 randconfig-a016-20201210
i386                 randconfig-a015-20201210
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                          rv32_defconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20201209
x86_64               randconfig-a006-20201209
x86_64               randconfig-a005-20201209
x86_64               randconfig-a001-20201209
x86_64               randconfig-a002-20201209
x86_64               randconfig-a003-20201209

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
