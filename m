Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 193F83B9DA8
	for <lists+linux-pci@lfdr.de>; Fri,  2 Jul 2021 10:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbhGBIrJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Jul 2021 04:47:09 -0400
Received: from mga09.intel.com ([134.134.136.24]:30527 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230166AbhGBIrI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 2 Jul 2021 04:47:08 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10032"; a="208651534"
X-IronPort-AV: E=Sophos;i="5.83,316,1616482800"; 
   d="scan'208";a="208651534"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2021 01:44:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,316,1616482800"; 
   d="scan'208";a="482220140"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Jul 2021 01:44:34 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lzEmo-000B0G-AQ; Fri, 02 Jul 2021 08:44:34 +0000
Date:   Fri, 02 Jul 2021 16:44:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:pci/hotplug] BUILD SUCCESS
 6d71cc4c91d856f05d9f175fba866616dd1a7d1f
Message-ID: <60ded1e3.dxMSINQoI2KqnUTj%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/hotplug
branch HEAD: 6d71cc4c91d856f05d9f175fba866616dd1a7d1f  PCI: cpcihp: Declare cpci_debug in header file

elapsed time: 723m

configs tested: 169
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                       imx_v6_v7_defconfig
arm                   milbeaut_m10v_defconfig
mips                         mpc30x_defconfig
xtensa                           alldefconfig
mips                            e55_defconfig
sh                         ecovec24_defconfig
mips                           ip28_defconfig
mips                             allmodconfig
arm                         assabet_defconfig
arm                          badge4_defconfig
m68k                                defconfig
riscv                             allnoconfig
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
powerpc                    sam440ep_defconfig
powerpc                     powernv_defconfig
powerpc                      acadia_defconfig
um                                  defconfig
arm                           stm32_defconfig
powerpc                         wii_defconfig
powerpc                   currituck_defconfig
mips                 decstation_r4k_defconfig
nds32                               defconfig
arm                           omap1_defconfig
csky                                defconfig
alpha                               defconfig
mips                        nlm_xlr_defconfig
mips                     cu1830-neo_defconfig
powerpc                    socrates_defconfig
arm                            lart_defconfig
ia64                        generic_defconfig
sh                           se7722_defconfig
sh                         ap325rxa_defconfig
sh                           se7724_defconfig
mips                     decstation_defconfig
sh                        edosk7760_defconfig
arm                        magician_defconfig
arm                     eseries_pxa_defconfig
openrisc                            defconfig
arm                        spear3xx_defconfig
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
sh                          rsk7203_defconfig
mips                     loongson2k_defconfig
m68k                        m5272c3_defconfig
arm                        multi_v7_defconfig
mips                         tb0287_defconfig
arm                       imx_v4_v5_defconfig
arm                       mainstone_defconfig
arm                        shmobile_defconfig
mips                           jazz_defconfig
riscv                            alldefconfig
mips                           mtx1_defconfig
powerpc                       ppc64_defconfig
arm                       versatile_defconfig
mips                           ip27_defconfig
mips                         tb0226_defconfig
powerpc                 canyonlands_defconfig
xtensa                              defconfig
sh                          urquell_defconfig
sh                ecovec24-romimage_defconfig
powerpc                 mpc8560_ads_defconfig
powerpc                  storcenter_defconfig
mips                      pistachio_defconfig
sh                     magicpanelr2_defconfig
m68k                        mvme147_defconfig
powerpc                 mpc837x_rdb_defconfig
arc                     haps_hs_smp_defconfig
m68k                         apollo_defconfig
powerpc                     tqm8541_defconfig
mips                         tb0219_defconfig
arm                        spear6xx_defconfig
mips                           xway_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nios2                            allyesconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
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
x86_64               randconfig-b001-20210630
x86_64               randconfig-b001-20210702
x86_64               randconfig-a012-20210630
x86_64               randconfig-a015-20210630
x86_64               randconfig-a016-20210630
x86_64               randconfig-a013-20210630
x86_64               randconfig-a011-20210630
x86_64               randconfig-a014-20210630

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
