Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2ABC4045E4
	for <lists+linux-pci@lfdr.de>; Thu,  9 Sep 2021 08:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbhIIHAw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Sep 2021 03:00:52 -0400
Received: from mga05.intel.com ([192.55.52.43]:59419 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230424AbhIIHAv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Sep 2021 03:00:51 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10101"; a="306268587"
X-IronPort-AV: E=Sophos;i="5.85,279,1624345200"; 
   d="scan'208";a="306268587"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2021 23:59:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,279,1624345200"; 
   d="scan'208";a="466278836"
Received: from lkp-server01.sh.intel.com (HELO 730d49888f40) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 08 Sep 2021 23:59:41 -0700
Received: from kbuild by 730d49888f40 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mOE28-00031a-AS; Thu, 09 Sep 2021 06:59:40 +0000
Date:   Thu, 09 Sep 2021 14:59:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:v5.15-merge] BUILD SUCCESS
 1b8f602f77b9c024d66078948992ffeea4eb617c
Message-ID: <6139b0ca.Hq2oHfx7hhNOCzw1%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git v5.15-merge
branch HEAD: 1b8f602f77b9c024d66078948992ffeea4eb617c  Merge branch 'next' into v5.15-merge

elapsed time: 1698m

configs tested: 191
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm64                               defconfig
arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210908
nds32                            alldefconfig
mips                      bmips_stb_defconfig
powerpc                     rainier_defconfig
powerpc                     tqm8548_defconfig
arm                       multi_v4t_defconfig
nds32                             allnoconfig
powerpc                      obs600_defconfig
powerpc                      walnut_defconfig
powerpc                 mpc8313_rdb_defconfig
powerpc                       ppc64_defconfig
sh                        edosk7705_defconfig
h8300                    h8300h-sim_defconfig
sh                           se7750_defconfig
sh                           se7722_defconfig
mips                     loongson1c_defconfig
powerpc                       holly_defconfig
m68k                                defconfig
arm                         nhk8815_defconfig
sh                           se7751_defconfig
mips                         bigsur_defconfig
m68k                          amiga_defconfig
arm                            pleb_defconfig
m68k                            mac_defconfig
s390                          debug_defconfig
powerpc                    socrates_defconfig
sparc                               defconfig
xtensa                  cadence_csp_defconfig
powerpc                     mpc5200_defconfig
powerpc                      pcm030_defconfig
arm                        spear6xx_defconfig
alpha                            allyesconfig
s390                                defconfig
arc                        nsimosci_defconfig
openrisc                  or1klitex_defconfig
nios2                         10m50_defconfig
powerpc                      cm5200_defconfig
powerpc                   microwatt_defconfig
powerpc                      pmac32_defconfig
arm                       aspeed_g4_defconfig
sh                          rsk7264_defconfig
arm                        mvebu_v5_defconfig
m68k                        mvme147_defconfig
xtensa                generic_kc705_defconfig
mips                  maltasmvp_eva_defconfig
powerpc                 mpc832x_mds_defconfig
sh                           sh2007_defconfig
m68k                           sun3_defconfig
powerpc                     kilauea_defconfig
powerpc                      mgcoge_defconfig
powerpc                   lite5200b_defconfig
arm                             rpc_defconfig
arm                     am200epdkit_defconfig
powerpc                     skiroot_defconfig
arm                          moxart_defconfig
mips                malta_qemu_32r6_defconfig
mips                    maltaup_xpa_defconfig
arc                           tb10x_defconfig
powerpc                     ksi8560_defconfig
powerpc                 mpc85xx_cds_defconfig
m68k                       m5208evb_defconfig
m68k                        m5407c3_defconfig
openrisc                            defconfig
arm                       versatile_defconfig
arm                        cerfcube_defconfig
arm                          ixp4xx_defconfig
powerpc                     pq2fads_defconfig
mips                           rs90_defconfig
mips                       bmips_be_defconfig
arm                        oxnas_v6_defconfig
mips                      fuloong2e_defconfig
powerpc                 canyonlands_defconfig
arm                         socfpga_defconfig
mips                           xway_defconfig
mips                          rb532_defconfig
ia64                             allmodconfig
arm                         at91_dt_defconfig
powerpc                      ppc6xx_defconfig
arm                        multi_v5_defconfig
mips                        workpad_defconfig
powerpc                        warp_defconfig
arm                         mv78xx0_defconfig
sh                           se7343_defconfig
sh                           se7724_defconfig
sh                               j2_defconfig
sh                      rts7751r2d1_defconfig
arc                      axs103_smp_defconfig
sh                          sdk7780_defconfig
powerpc                        fsp2_defconfig
arm                       netwinder_defconfig
arm                        keystone_defconfig
mips                     cu1830-neo_defconfig
mips                           ip27_defconfig
powerpc                 mpc837x_mds_defconfig
sh                        sh7785lcr_defconfig
sh                          landisk_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                 linkstation_defconfig
nios2                         3c120_defconfig
powerpc                      ep88xc_defconfig
arm                           sama7_defconfig
arc                          axs103_defconfig
powerpc                    gamecube_defconfig
ia64                            zx1_defconfig
powerpc                     tqm8560_defconfig
arm                        trizeps4_defconfig
arm                    vt8500_v6_v7_defconfig
arm                            qcom_defconfig
sh                        apsh4ad0a_defconfig
arm                        spear3xx_defconfig
arm                      tct_hammer_defconfig
sh                   secureedge5410_defconfig
x86_64               randconfig-c001-20210908
x86_64                            allnoconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
parisc                              defconfig
parisc                           allyesconfig
s390                             allmodconfig
s390                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                             allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a004-20210908
x86_64               randconfig-a006-20210908
x86_64               randconfig-a003-20210908
x86_64               randconfig-a001-20210908
x86_64               randconfig-a005-20210908
x86_64               randconfig-a002-20210908
i386                 randconfig-a005-20210908
i386                 randconfig-a004-20210908
i386                 randconfig-a006-20210908
i386                 randconfig-a002-20210908
i386                 randconfig-a001-20210908
i386                 randconfig-a003-20210908
arc                  randconfig-r043-20210908
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allyesconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                           allyesconfig

clang tested configs:
s390                 randconfig-c005-20210908
powerpc              randconfig-c003-20210908
mips                 randconfig-c004-20210908
i386                 randconfig-c001-20210908
x86_64               randconfig-a016-20210908
x86_64               randconfig-a011-20210908
x86_64               randconfig-a012-20210908
x86_64               randconfig-a015-20210908
x86_64               randconfig-a014-20210908
x86_64               randconfig-a013-20210908
i386                 randconfig-a012-20210908
i386                 randconfig-a015-20210908
i386                 randconfig-a011-20210908
i386                 randconfig-a013-20210908
i386                 randconfig-a014-20210908
i386                 randconfig-a016-20210908
s390                 randconfig-r044-20210908
riscv                randconfig-r042-20210908
hexagon              randconfig-r045-20210908
hexagon              randconfig-r041-20210908

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
