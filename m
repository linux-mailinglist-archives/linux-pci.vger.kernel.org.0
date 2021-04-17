Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6528F362ED8
	for <lists+linux-pci@lfdr.de>; Sat, 17 Apr 2021 11:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235685AbhDQJ0E (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 17 Apr 2021 05:26:04 -0400
Received: from mga05.intel.com ([192.55.52.43]:16440 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235774AbhDQJ0D (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 17 Apr 2021 05:26:03 -0400
IronPort-SDR: 9nlsO/O/pvII1PVfjqpEUMgtQaIWF6OzVEh1/xOBvlSzDNaMOJh/OcjODgYzpuy7lv+unVo0wK
 uCGQKeqGCZYQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9956"; a="280475387"
X-IronPort-AV: E=Sophos;i="5.82,228,1613462400"; 
   d="scan'208";a="280475387"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2021 02:25:37 -0700
IronPort-SDR: eqaJbQVrR3BKvqH8pH3IoxeWJ+9O6HY/FJ2Lo6fNLqCuv0tH6v1D0r25WZJALPhHlncytSKwmV
 3s1nRxnZRRaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,228,1613462400"; 
   d="scan'208";a="425880343"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 17 Apr 2021 02:25:35 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lXhCo-0000nP-Q0; Sat, 17 Apr 2021 09:25:34 +0000
Date:   Sat, 17 Apr 2021 17:25:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:pci/vpd] BUILD SUCCESS
 a37013bef128e02cc1a65f90d5972299254e5a32
Message-ID: <607aa96f.1WrvqlHzxe+3q7R0%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/vpd
branch HEAD: a37013bef128e02cc1a65f90d5972299254e5a32  PCI: Allow VPD access for QLogic ISP2722

elapsed time: 720m

configs tested: 158
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
x86_64                           allyesconfig
riscv                            allmodconfig
i386                             allyesconfig
riscv                            allyesconfig
mips                         tb0219_defconfig
arm                             mxs_defconfig
parisc                generic-64bit_defconfig
arm                        mvebu_v5_defconfig
arm                         vf610m4_defconfig
powerpc                 mpc837x_mds_defconfig
powerpc                       ebony_defconfig
powerpc                     ksi8560_defconfig
arm                    vt8500_v6_v7_defconfig
arm                        clps711x_defconfig
arm                         at91_dt_defconfig
arc                      axs103_smp_defconfig
mips                      maltaaprp_defconfig
arm                          imote2_defconfig
powerpc                      pcm030_defconfig
powerpc                      pasemi_defconfig
m68k                          amiga_defconfig
ia64                          tiger_defconfig
mips                  decstation_64_defconfig
powerpc                        icon_defconfig
mips                           ip28_defconfig
powerpc                    adder875_defconfig
mips                      pistachio_defconfig
ia64                             allmodconfig
powerpc                         ps3_defconfig
arm                          pcm027_defconfig
sparc64                             defconfig
arm                            xcep_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                 mpc837x_rdb_defconfig
arm                     davinci_all_defconfig
sh                           se7750_defconfig
arm                       aspeed_g5_defconfig
powerpc                       eiger_defconfig
powerpc                 mpc834x_mds_defconfig
sh                          sdk7780_defconfig
m68k                        mvme147_defconfig
powerpc                   motionpro_defconfig
powerpc                     powernv_defconfig
sh                             espt_defconfig
sh                           se7780_defconfig
sh                          lboxre2_defconfig
arm                           sama5_defconfig
ia64                        generic_defconfig
csky                                defconfig
mips                           ip32_defconfig
sh                             shx3_defconfig
powerpc                     mpc512x_defconfig
powerpc                       holly_defconfig
arm                        magician_defconfig
um                               alldefconfig
arm                            mps2_defconfig
arc                     nsimosci_hs_defconfig
arm                        multi_v7_defconfig
arm                       imx_v4_v5_defconfig
arm                         socfpga_defconfig
sh                ecovec24-romimage_defconfig
powerpc                          allmodconfig
m68k                            q40_defconfig
arc                         haps_hs_defconfig
mips                malta_qemu_32r6_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                 mpc8540_ads_defconfig
mips                            ar7_defconfig
mips                     cu1000-neo_defconfig
powerpc                     sequoia_defconfig
powerpc                     mpc83xx_defconfig
s390                       zfcpdump_defconfig
sh                           se7724_defconfig
sh                   sh7770_generic_defconfig
xtensa                              defconfig
i386                             alldefconfig
arm                        shmobile_defconfig
mips                      pic32mzda_defconfig
m68k                          atari_defconfig
openrisc                            defconfig
arm                         s3c2410_defconfig
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
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
i386                 randconfig-a003-20210416
i386                 randconfig-a006-20210416
i386                 randconfig-a001-20210416
i386                 randconfig-a005-20210416
i386                 randconfig-a004-20210416
i386                 randconfig-a002-20210416
x86_64               randconfig-a014-20210416
x86_64               randconfig-a015-20210416
x86_64               randconfig-a011-20210416
x86_64               randconfig-a013-20210416
x86_64               randconfig-a012-20210416
x86_64               randconfig-a016-20210416
i386                 randconfig-a015-20210416
i386                 randconfig-a014-20210416
i386                 randconfig-a013-20210416
i386                 randconfig-a012-20210416
i386                 randconfig-a016-20210416
i386                 randconfig-a011-20210416
x86_64               randconfig-a003-20210417
x86_64               randconfig-a002-20210417
x86_64               randconfig-a005-20210417
x86_64               randconfig-a001-20210417
x86_64               randconfig-a006-20210417
x86_64               randconfig-a004-20210417
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a003-20210416
x86_64               randconfig-a002-20210416
x86_64               randconfig-a005-20210416
x86_64               randconfig-a001-20210416
x86_64               randconfig-a006-20210416
x86_64               randconfig-a004-20210416

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
