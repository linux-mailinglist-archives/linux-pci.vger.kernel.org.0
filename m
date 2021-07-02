Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48ED53B9EE5
	for <lists+linux-pci@lfdr.de>; Fri,  2 Jul 2021 12:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbhGBKQM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Jul 2021 06:16:12 -0400
Received: from mga17.intel.com ([192.55.52.151]:24127 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230496AbhGBKQM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 2 Jul 2021 06:16:12 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10032"; a="189092309"
X-IronPort-AV: E=Sophos;i="5.83,317,1616482800"; 
   d="scan'208";a="189092309"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2021 03:13:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,317,1616482800"; 
   d="scan'208";a="409258867"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 02 Jul 2021 03:13:39 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lzGB0-000B2T-TJ; Fri, 02 Jul 2021 10:13:38 +0000
Date:   Fri, 02 Jul 2021 18:12:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:pci/p2pdma] BUILD SUCCESS
 651b0ba3f8302e183277e4fa317fff2f9685bca2
Message-ID: <60dee69f.sNCvYekmFZpM+YwG%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/p2pdma
branch HEAD: 651b0ba3f8302e183277e4fa317fff2f9685bca2  PCI/P2PDMA: Finish RCU conversion of pdev->p2pdma

elapsed time: 722m

configs tested: 137
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                           ip28_defconfig
arm                         assabet_defconfig
riscv                             allnoconfig
arm                          badge4_defconfig
mips                      fuloong2e_defconfig
arm                         vf610m4_defconfig
sh                           se7619_defconfig
powerpc                 mpc85xx_cds_defconfig
sh                           se7780_defconfig
powerpc                  mpc866_ads_defconfig
xtensa                generic_kc705_defconfig
sh                          sdk7780_defconfig
sh                         microdev_defconfig
arm                        cerfcube_defconfig
arm                  colibri_pxa270_defconfig
arm                           stm32_defconfig
powerpc                         wii_defconfig
powerpc                   currituck_defconfig
mips                 decstation_r4k_defconfig
arm                       omap2plus_defconfig
powerpc                 linkstation_defconfig
sh                        sh7763rdp_defconfig
sh                             espt_defconfig
arm                           u8500_defconfig
arm                          iop32x_defconfig
mips                     cu1830-neo_defconfig
arc                                 defconfig
powerpc                    socrates_defconfig
arm                            lart_defconfig
ia64                        generic_defconfig
sh                          kfr2r09_defconfig
mips                      bmips_stb_defconfig
powerpc                          g5_defconfig
mips                       bmips_be_defconfig
arm                          ixp4xx_defconfig
arm                        oxnas_v6_defconfig
mips                         bigsur_defconfig
s390                             allyesconfig
arc                     nsimosci_hs_defconfig
xtensa                  nommu_kc705_defconfig
mips                         tb0287_defconfig
arm                       imx_v4_v5_defconfig
arm                       mainstone_defconfig
arm                        shmobile_defconfig
mips                           jazz_defconfig
riscv                            alldefconfig
mips                           ip27_defconfig
mips                         tb0226_defconfig
powerpc                 canyonlands_defconfig
xtensa                              defconfig
sh                          rsk7203_defconfig
sh                           se7724_defconfig
powerpc               mpc834x_itxgp_defconfig
sh                        sh7785lcr_defconfig
arm                              alldefconfig
sh                          urquell_defconfig
sh                ecovec24-romimage_defconfig
powerpc                 mpc8560_ads_defconfig
powerpc                  storcenter_defconfig
mips                      pistachio_defconfig
sh                     magicpanelr2_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
x86_64                            allnoconfig
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
sh                               allmodconfig
parisc                              defconfig
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
x86_64               randconfig-a002-20210630
x86_64               randconfig-a001-20210630
x86_64               randconfig-a004-20210630
x86_64               randconfig-a005-20210630
x86_64               randconfig-a006-20210630
x86_64               randconfig-a003-20210630
i386                 randconfig-a004-20210630
i386                 randconfig-a001-20210630
i386                 randconfig-a003-20210630
i386                 randconfig-a002-20210630
i386                 randconfig-a005-20210630
i386                 randconfig-a006-20210630
i386                 randconfig-a014-20210630
i386                 randconfig-a011-20210630
i386                 randconfig-a016-20210630
i386                 randconfig-a012-20210630
i386                 randconfig-a013-20210630
i386                 randconfig-a015-20210630
i386                 randconfig-a015-20210701
i386                 randconfig-a016-20210701
i386                 randconfig-a011-20210701
i386                 randconfig-a012-20210701
i386                 randconfig-a013-20210701
i386                 randconfig-a014-20210701
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
um                            kunit_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210630

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
