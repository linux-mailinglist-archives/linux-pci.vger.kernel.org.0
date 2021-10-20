Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBB83434BE0
	for <lists+linux-pci@lfdr.de>; Wed, 20 Oct 2021 15:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbhJTNQy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Oct 2021 09:16:54 -0400
Received: from mga01.intel.com ([192.55.52.88]:30307 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229702AbhJTNQy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 20 Oct 2021 09:16:54 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10142"; a="252261745"
X-IronPort-AV: E=Sophos;i="5.87,167,1631602800"; 
   d="scan'208";a="252261745"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2021 06:14:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,167,1631602800"; 
   d="scan'208";a="483719534"
Received: from lkp-server02.sh.intel.com (HELO 08b2c502c3de) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 20 Oct 2021 06:14:38 -0700
Received: from kbuild by 08b2c502c3de with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mdBQU-000DMT-36; Wed, 20 Oct 2021 13:14:38 +0000
Date:   Wed, 20 Oct 2021 21:14:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/aspm] BUILD SUCCESS
 e1b0d0bb2032d18c7718168e670d8d3f31e552d7
Message-ID: <61701630.mo41fJ0Qoc+Tv7TN%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/aspm
branch HEAD: e1b0d0bb2032d18c7718168e670d8d3f31e552d7  PCI: Re-enable Downstream Port LTR after reset or hotplug

elapsed time: 883m

configs tested: 158
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allmodconfig
arm                              allyesconfig
i386                 randconfig-c001-20211019
i386                             alldefconfig
powerpc                      mgcoge_defconfig
sh                          r7780mp_defconfig
arm                         hackkit_defconfig
mips                        omega2p_defconfig
powerpc                      cm5200_defconfig
mips                        qi_lb60_defconfig
xtensa                          iss_defconfig
arm                           viper_defconfig
mips                           gcw0_defconfig
powerpc                 xes_mpc85xx_defconfig
arm                           u8500_defconfig
powerpc                mpc7448_hpc2_defconfig
powerpc                     ksi8560_defconfig
powerpc                       maple_defconfig
m68k                        m5407c3_defconfig
arm                         lubbock_defconfig
mips                         tb0287_defconfig
powerpc                      ppc6xx_defconfig
arm                             ezx_defconfig
s390                             alldefconfig
sh                            shmin_defconfig
sh                          rsk7264_defconfig
powerpc                 mpc832x_mds_defconfig
arm                         orion5x_defconfig
powerpc                     ppa8548_defconfig
arm                       imx_v4_v5_defconfig
um                           x86_64_defconfig
powerpc                     stx_gp3_defconfig
arm                            mps2_defconfig
arm                          collie_defconfig
sh                   sh7724_generic_defconfig
x86_64                           alldefconfig
arc                          axs103_defconfig
parisc                generic-64bit_defconfig
sh                              ul2_defconfig
arc                     nsimosci_hs_defconfig
sh                           se7722_defconfig
powerpc                   bluestone_defconfig
mips                     decstation_defconfig
m68k                       m5275evb_defconfig
arm                          ep93xx_defconfig
sh                          rsk7269_defconfig
sh                            titan_defconfig
powerpc                     skiroot_defconfig
powerpc                        icon_defconfig
arm                     davinci_all_defconfig
sh                          polaris_defconfig
arm                           corgi_defconfig
sh                        edosk7760_defconfig
powerpc                     pq2fads_defconfig
m68k                        m5307c3_defconfig
xtensa                  audio_kc705_defconfig
sh                           se7780_defconfig
arc                      axs103_smp_defconfig
arm                        realview_defconfig
powerpc                     tqm8540_defconfig
mips                           ci20_defconfig
powerpc                     tqm5200_defconfig
powerpc                      walnut_defconfig
powerpc                        fsp2_defconfig
arm                         palmz72_defconfig
arm                         s3c2410_defconfig
mips                      maltasmvp_defconfig
arm                  randconfig-c002-20211019
x86_64               randconfig-c001-20211019
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
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                                defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                             allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
i386                 randconfig-a004-20211020
i386                 randconfig-a003-20211020
i386                 randconfig-a002-20211020
i386                 randconfig-a005-20211020
i386                 randconfig-a006-20211020
i386                 randconfig-a001-20211020
x86_64               randconfig-a015-20211019
x86_64               randconfig-a012-20211019
x86_64               randconfig-a016-20211019
x86_64               randconfig-a014-20211019
x86_64               randconfig-a013-20211019
x86_64               randconfig-a011-20211019
i386                 randconfig-a014-20211019
i386                 randconfig-a016-20211019
i386                 randconfig-a011-20211019
i386                 randconfig-a015-20211019
i386                 randconfig-a012-20211019
i386                 randconfig-a013-20211019
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
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
arm                  randconfig-c002-20211019
mips                 randconfig-c004-20211019
i386                 randconfig-c001-20211019
s390                 randconfig-c005-20211019
x86_64               randconfig-c007-20211019
riscv                randconfig-c006-20211019
powerpc              randconfig-c003-20211019
x86_64               randconfig-a004-20211019
x86_64               randconfig-a006-20211019
x86_64               randconfig-a005-20211019
x86_64               randconfig-a001-20211019
x86_64               randconfig-a002-20211019
x86_64               randconfig-a003-20211019
i386                 randconfig-a001-20211019
i386                 randconfig-a003-20211019
i386                 randconfig-a004-20211019
i386                 randconfig-a005-20211019
i386                 randconfig-a002-20211019
i386                 randconfig-a006-20211019
riscv                randconfig-r042-20211020
s390                 randconfig-r044-20211020
hexagon              randconfig-r045-20211020
hexagon              randconfig-r041-20211020
hexagon              randconfig-r041-20211019
hexagon              randconfig-r045-20211019

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
