Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBF83D1E00
	for <lists+linux-pci@lfdr.de>; Thu, 22 Jul 2021 08:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbhGVF0p (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Jul 2021 01:26:45 -0400
Received: from mga11.intel.com ([192.55.52.93]:54193 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230261AbhGVF0p (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Jul 2021 01:26:45 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10052"; a="208459736"
X-IronPort-AV: E=Sophos;i="5.84,260,1620716400"; 
   d="scan'208";a="208459736"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2021 23:07:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,260,1620716400"; 
   d="scan'208";a="662415659"
Received: from lkp-server01.sh.intel.com (HELO b8b92b2878b0) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 21 Jul 2021 23:07:20 -0700
Received: from kbuild by b8b92b2878b0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m6Rrb-0000uK-DW; Thu, 22 Jul 2021 06:07:19 +0000
Date:   Thu, 22 Jul 2021 14:06:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:review/vga] BUILD SUCCESS WITH WARNING
 b6f0a577c4fbcc4f1e7eaf0e9a30bcfd20002b44
Message-ID: <60f90adb.rxbx86YHocAbz6Dy%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git review/vga
branch HEAD: b6f0a577c4fbcc4f1e7eaf0e9a30bcfd20002b44  FIXME PCI/VGA: Rework default VGA device selection

possible Warning in current branch:

drivers/pci/vgaarb.c:1045:8: warning: %d in format string (no. 6) requires 'int' but the argument type is 'unsigned int'. [invalidPrintfArgType_sint]

Warning ids grouped by kconfigs:

gcc_recent_errors
`-- arm-randconfig-p001-20210720
    `-- drivers-pci-vgaarb.c:warning:d-in-format-string-(no.-)-requires-int-but-the-argument-type-is-unsigned-int-.-invalidPrintfArgType_sint

elapsed time: 1884m

configs tested: 163
configs skipped: 3

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                       ebony_defconfig
powerpc                      bamboo_defconfig
arm                      integrator_defconfig
arm                        multi_v7_defconfig
powerpc                      pasemi_defconfig
m68k                        mvme16x_defconfig
sh                          r7785rp_defconfig
sparc64                             defconfig
arc                     nsimosci_hs_defconfig
m68k                             allyesconfig
m68k                       m5208evb_defconfig
arm                           sama5_defconfig
mips                       rbtx49xx_defconfig
mips                          ath25_defconfig
arm                       aspeed_g4_defconfig
arm                          moxart_defconfig
arm                           h3600_defconfig
xtensa                    smp_lx200_defconfig
powerpc                      tqm8xx_defconfig
powerpc                    ge_imp3a_defconfig
csky                             alldefconfig
h8300                               defconfig
sh                  sh7785lcr_32bit_defconfig
powerpc                 mpc8313_rdb_defconfig
sh                               j2_defconfig
powerpc                       ppc64_defconfig
mips                           jazz_defconfig
sh                          sdk7786_defconfig
arm                           stm32_defconfig
arm                           viper_defconfig
mips                        vocore2_defconfig
sh                          rsk7201_defconfig
arm                         bcm2835_defconfig
powerpc                      mgcoge_defconfig
ia64                                defconfig
riscv                            alldefconfig
microblaze                          defconfig
mips                         tb0287_defconfig
sh                            titan_defconfig
arc                        nsim_700_defconfig
riscv                          rv32_defconfig
powerpc                  mpc866_ads_defconfig
mips                     loongson2k_defconfig
sh                ecovec24-romimage_defconfig
arm                          ep93xx_defconfig
powerpc                         wii_defconfig
sh                           se7343_defconfig
mips                  cavium_octeon_defconfig
powerpc                      chrp32_defconfig
powerpc                       holly_defconfig
powerpc                      katmai_defconfig
mips                         mpc30x_defconfig
m68k                        m5407c3_defconfig
arm                        realview_defconfig
arm                            dove_defconfig
arm                  colibri_pxa270_defconfig
openrisc                 simple_smp_defconfig
mips                     cu1830-neo_defconfig
sh                          rsk7203_defconfig
xtensa                    xip_kc705_defconfig
mips                         db1xxx_defconfig
arm                           sunxi_defconfig
mips                           ip28_defconfig
arm64                            alldefconfig
mips                     cu1000-neo_defconfig
riscv                    nommu_virt_defconfig
mips                 decstation_r4k_defconfig
xtensa                  nommu_kc705_defconfig
arm                            pleb_defconfig
arm                           omap1_defconfig
xtensa                       common_defconfig
ia64                             allmodconfig
ia64                             allyesconfig
x86_64                            allnoconfig
m68k                             allmodconfig
m68k                                defconfig
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
x86_64               randconfig-a003-20210720
x86_64               randconfig-a006-20210720
x86_64               randconfig-a001-20210720
x86_64               randconfig-a005-20210720
x86_64               randconfig-a004-20210720
x86_64               randconfig-a002-20210720
i386                 randconfig-a005-20210719
i386                 randconfig-a004-20210719
i386                 randconfig-a006-20210719
i386                 randconfig-a001-20210719
i386                 randconfig-a003-20210719
i386                 randconfig-a002-20210719
i386                 randconfig-a005-20210720
i386                 randconfig-a003-20210720
i386                 randconfig-a004-20210720
i386                 randconfig-a002-20210720
i386                 randconfig-a001-20210720
i386                 randconfig-a006-20210720
i386                 randconfig-a005-20210722
i386                 randconfig-a003-20210722
i386                 randconfig-a004-20210722
i386                 randconfig-a002-20210722
i386                 randconfig-a001-20210722
i386                 randconfig-a006-20210722
i386                 randconfig-a016-20210720
i386                 randconfig-a013-20210720
i386                 randconfig-a012-20210720
i386                 randconfig-a014-20210720
i386                 randconfig-a011-20210720
i386                 randconfig-a015-20210720
i386                 randconfig-a016-20210721
i386                 randconfig-a013-20210721
i386                 randconfig-a012-20210721
i386                 randconfig-a014-20210721
i386                 randconfig-a011-20210721
i386                 randconfig-a015-20210721
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210720
x86_64               randconfig-a003-20210721
x86_64               randconfig-a006-20210721
x86_64               randconfig-a001-20210721
x86_64               randconfig-a005-20210721
x86_64               randconfig-a004-20210721
x86_64               randconfig-a002-20210721

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
