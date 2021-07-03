Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2BBF3BA7A0
	for <lists+linux-pci@lfdr.de>; Sat,  3 Jul 2021 09:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbhGCHF4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 3 Jul 2021 03:05:56 -0400
Received: from mga04.intel.com ([192.55.52.120]:44742 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229528AbhGCHF4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 3 Jul 2021 03:05:56 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10033"; a="206984856"
X-IronPort-AV: E=Sophos;i="5.83,320,1616482800"; 
   d="scan'208";a="206984856"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2021 00:03:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,320,1616482800"; 
   d="scan'208";a="626921675"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 03 Jul 2021 00:03:19 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lzZgM-000BQ4-SF; Sat, 03 Jul 2021 07:03:18 +0000
Date:   Sat, 03 Jul 2021 15:02:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS e7e1458ecc1892e408c2626f88255de6595ff33d
Message-ID: <60e00b94.HLZOewjCaj4xkrAU%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
branch HEAD: e7e1458ecc1892e408c2626f88255de6595ff33d  Merge branch 'remotes/lorenzo/pci/xgene'

elapsed time: 720m

configs tested: 138
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                     rainier_defconfig
arm                  colibri_pxa270_defconfig
powerpc                        cell_defconfig
arm                        neponset_defconfig
arm                        oxnas_v6_defconfig
sh                          landisk_defconfig
powerpc                     redwood_defconfig
riscv             nommu_k210_sdcard_defconfig
mips                        nlm_xlr_defconfig
sh                              ul2_defconfig
powerpc                     mpc512x_defconfig
openrisc                         alldefconfig
powerpc                      mgcoge_defconfig
powerpc                    mvme5100_defconfig
arm                          pxa910_defconfig
xtensa                  nommu_kc705_defconfig
arm                    vt8500_v6_v7_defconfig
m68k                            q40_defconfig
ia64                          tiger_defconfig
arm                          ep93xx_defconfig
arm                           tegra_defconfig
i386                             alldefconfig
sh                             espt_defconfig
arm                       cns3420vb_defconfig
arm                          ixp4xx_defconfig
arm                         axm55xx_defconfig
powerpc                      walnut_defconfig
m68k                        mvme16x_defconfig
arm                           omap1_defconfig
powerpc                     stx_gp3_defconfig
sh                           se7750_defconfig
m68k                          atari_defconfig
h8300                               defconfig
powerpc                     kmeter1_defconfig
mips                           ci20_defconfig
sh                        edosk7760_defconfig
mips                           jazz_defconfig
m68k                            mac_defconfig
x86_64                            allnoconfig
arm                       spear13xx_defconfig
mips                 decstation_r4k_defconfig
arm                             pxa_defconfig
arm                         bcm2835_defconfig
arm                        spear6xx_defconfig
powerpc                 mpc834x_mds_defconfig
mips                        vocore2_defconfig
powerpc                     mpc5200_defconfig
sh                           se7206_defconfig
powerpc                     tqm5200_defconfig
arm                            hisi_defconfig
mips                          ath79_defconfig
powerpc                  mpc885_ads_defconfig
powerpc                      pasemi_defconfig
mips                           xway_defconfig
powerpc64                        alldefconfig
m68k                          sun3x_defconfig
arm                        keystone_defconfig
mips                          ath25_defconfig
arm                          lpd270_defconfig
mips                        bcm63xx_defconfig
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
i386                 randconfig-a004-20210702
i386                 randconfig-a006-20210702
i386                 randconfig-a001-20210702
i386                 randconfig-a003-20210702
i386                 randconfig-a005-20210702
i386                 randconfig-a002-20210702
x86_64               randconfig-a015-20210702
x86_64               randconfig-a012-20210702
x86_64               randconfig-a014-20210702
x86_64               randconfig-a011-20210702
x86_64               randconfig-a016-20210702
x86_64               randconfig-a013-20210702
i386                 randconfig-a015-20210702
i386                 randconfig-a016-20210702
i386                 randconfig-a011-20210702
i386                 randconfig-a012-20210702
i386                 randconfig-a013-20210702
i386                 randconfig-a014-20210702
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
um                            kunit_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210702
x86_64               randconfig-a004-20210702
x86_64               randconfig-a005-20210702
x86_64               randconfig-a002-20210702
x86_64               randconfig-a006-20210702
x86_64               randconfig-a003-20210702
x86_64               randconfig-a001-20210702

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
