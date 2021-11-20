Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B31A457C18
	for <lists+linux-pci@lfdr.de>; Sat, 20 Nov 2021 08:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236899AbhKTHb5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 20 Nov 2021 02:31:57 -0500
Received: from mga05.intel.com ([192.55.52.43]:11419 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232750AbhKTHb5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 20 Nov 2021 02:31:57 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10173"; a="320758009"
X-IronPort-AV: E=Sophos;i="5.87,250,1631602800"; 
   d="scan'208";a="320758009"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 23:28:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,250,1631602800"; 
   d="scan'208";a="537353803"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 19 Nov 2021 23:28:52 -0800
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1moKnr-0005Vm-NB; Sat, 20 Nov 2021 07:28:51 +0000
Date:   Sat, 20 Nov 2021 15:28:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/hotplug] BUILD SUCCESS
 23584c1ed3e15a6f4bfab8dc5a88d94ab929ee12
Message-ID: <6198a3a9./bVHHfnPa08T9KtC%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/hotplug
branch HEAD: 23584c1ed3e15a6f4bfab8dc5a88d94ab929ee12  PCI: pciehp: Fix infinite loop in IRQ handler upon power fault

elapsed time: 724m

configs tested: 203
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211118
i386                 randconfig-c001-20211119
mips                 randconfig-c004-20211118
arm                        spear6xx_defconfig
powerpc                     tqm8555_defconfig
xtensa                       common_defconfig
sh                        dreamcast_defconfig
powerpc                        cell_defconfig
arm                            pleb_defconfig
xtensa                              defconfig
xtensa                           alldefconfig
mips                       lemote2f_defconfig
powerpc                      walnut_defconfig
mips                             allyesconfig
arm                        mvebu_v5_defconfig
mips                         mpc30x_defconfig
powerpc                      acadia_defconfig
s390                          debug_defconfig
powerpc                 mpc8540_ads_defconfig
mips                malta_qemu_32r6_defconfig
arm                           omap1_defconfig
arm                         palmz72_defconfig
arc                     nsimosci_hs_defconfig
sh                           se7750_defconfig
powerpc                   bluestone_defconfig
mips                     loongson2k_defconfig
arc                         haps_hs_defconfig
arc                 nsimosci_hs_smp_defconfig
mips                           jazz_defconfig
sh                          r7785rp_defconfig
parisc                generic-64bit_defconfig
sparc                       sparc32_defconfig
xtensa                  cadence_csp_defconfig
riscv                            alldefconfig
powerpc                   lite5200b_defconfig
mips                         tb0226_defconfig
arm                       spear13xx_defconfig
powerpc                 mpc834x_mds_defconfig
sh                           se7705_defconfig
mips                        maltaup_defconfig
arm                      footbridge_defconfig
arc                           tb10x_defconfig
x86_64                              defconfig
powerpc                     pseries_defconfig
arc                        nsim_700_defconfig
arm                         s3c2410_defconfig
sh                                  defconfig
m68k                         amcore_defconfig
mips                    maltaup_xpa_defconfig
arm                     am200epdkit_defconfig
sh                           se7343_defconfig
powerpc                  mpc885_ads_defconfig
powerpc                      pasemi_defconfig
powerpc                     rainier_defconfig
sparc64                             defconfig
riscv             nommu_k210_sdcard_defconfig
arm                          collie_defconfig
m68k                             alldefconfig
arc                     haps_hs_smp_defconfig
sh                   sh7770_generic_defconfig
mips                       bmips_be_defconfig
m68k                            mac_defconfig
h8300                     edosk2674_defconfig
arm                             mxs_defconfig
sh                               allmodconfig
arm                           stm32_defconfig
arm                            hisi_defconfig
mips                  cavium_octeon_defconfig
m68k                        m5407c3_defconfig
arm                        vexpress_defconfig
powerpc                 mpc837x_mds_defconfig
parisc                              defconfig
mips                          rm200_defconfig
sh                          sdk7786_defconfig
arm                        oxnas_v6_defconfig
sh                           se7780_defconfig
xtensa                          iss_defconfig
microblaze                          defconfig
arm                           sunxi_defconfig
m68k                          multi_defconfig
parisc                           allyesconfig
s390                       zfcpdump_defconfig
um                           x86_64_defconfig
powerpc                      ppc40x_defconfig
powerpc                        icon_defconfig
powerpc                   motionpro_defconfig
sh                          urquell_defconfig
arm                         s5pv210_defconfig
powerpc                     kmeter1_defconfig
arm                           tegra_defconfig
ia64                            zx1_defconfig
arm                         hackkit_defconfig
arm                     eseries_pxa_defconfig
sh                        sh7763rdp_defconfig
mips                           rs90_defconfig
arm                         mv78xx0_defconfig
ia64                             alldefconfig
sh                        sh7785lcr_defconfig
arm                  randconfig-c002-20211118
arm                  randconfig-c002-20211119
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
s390                             allyesconfig
s390                             allmodconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                              debian-10.3
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a005-20211119
x86_64               randconfig-a003-20211119
x86_64               randconfig-a002-20211119
x86_64               randconfig-a001-20211119
x86_64               randconfig-a006-20211119
x86_64               randconfig-a004-20211119
i386                 randconfig-a006-20211119
i386                 randconfig-a003-20211119
i386                 randconfig-a001-20211119
i386                 randconfig-a005-20211119
i386                 randconfig-a004-20211119
i386                 randconfig-a002-20211119
x86_64               randconfig-a015-20211118
x86_64               randconfig-a012-20211118
x86_64               randconfig-a011-20211118
x86_64               randconfig-a013-20211118
x86_64               randconfig-a016-20211118
x86_64               randconfig-a014-20211118
i386                 randconfig-a016-20211118
i386                 randconfig-a014-20211118
i386                 randconfig-a012-20211118
i386                 randconfig-a011-20211118
i386                 randconfig-a013-20211118
i386                 randconfig-a015-20211118
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
i386                 randconfig-c001-20211118
x86_64               randconfig-c007-20211118
arm                  randconfig-c002-20211118
s390                 randconfig-c005-20211118
powerpc              randconfig-c003-20211118
riscv                randconfig-c006-20211118
mips                 randconfig-c004-20211118
i386                 randconfig-c001-20211119
x86_64               randconfig-c007-20211119
arm                  randconfig-c002-20211119
s390                 randconfig-c005-20211119
powerpc              randconfig-c003-20211119
riscv                randconfig-c006-20211119
x86_64               randconfig-a005-20211118
x86_64               randconfig-a003-20211118
x86_64               randconfig-a001-20211118
x86_64               randconfig-a002-20211118
x86_64               randconfig-a006-20211118
x86_64               randconfig-a004-20211118
i386                 randconfig-a006-20211118
i386                 randconfig-a003-20211118
i386                 randconfig-a001-20211118
i386                 randconfig-a005-20211118
i386                 randconfig-a004-20211118
i386                 randconfig-a002-20211118
x86_64               randconfig-a015-20211119
x86_64               randconfig-a011-20211119
x86_64               randconfig-a012-20211119
x86_64               randconfig-a013-20211119
x86_64               randconfig-a016-20211119
x86_64               randconfig-a014-20211119
hexagon              randconfig-r045-20211119
hexagon              randconfig-r041-20211119
riscv                randconfig-r042-20211119
s390                 randconfig-r044-20211119
hexagon              randconfig-r045-20211118
hexagon              randconfig-r041-20211118

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
