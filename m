Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CDE2390056
	for <lists+linux-pci@lfdr.de>; Tue, 25 May 2021 13:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbhEYLxd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 May 2021 07:53:33 -0400
Received: from mga18.intel.com ([134.134.136.126]:27135 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229896AbhEYLxc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 May 2021 07:53:32 -0400
IronPort-SDR: kwLS3mWfEZ5eKf6aeamz/fGd/144PyOs4jzIVvL42qmJnX01cp4Fyo2hKIwkvv0LftAlqqUbkd
 ZQ1LxSTgS40g==
X-IronPort-AV: E=McAfee;i="6200,9189,9994"; a="189551911"
X-IronPort-AV: E=Sophos;i="5.82,328,1613462400"; 
   d="scan'208";a="189551911"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2021 04:51:57 -0700
IronPort-SDR: 99IWLuxZ2nd4F9ESTVCFHB7aLHNxhil+T3SrxCO8zbalHsRqpIzskoorTR6FZ52zZchDF5fTiP
 vEGOl3Bp1JVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,328,1613462400"; 
   d="scan'208";a="396809231"
Received: from lkp-server02.sh.intel.com (HELO 1ec8406c5392) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 25 May 2021 04:51:55 -0700
Received: from kbuild by 1ec8406c5392 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1llVbH-0001dL-5f; Tue, 25 May 2021 11:51:55 +0000
Date:   Tue, 25 May 2021 19:51:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:pci/reset] BUILD SUCCESS
 411e2a43d210e98730713acf6d01dcf823ee35e3
Message-ID: <60ace4d8.mSnkv2hjPY8AptLh%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/reset
branch HEAD: 411e2a43d210e98730713acf6d01dcf823ee35e3  PCI: Work around Huawei Intelligent NIC VF FLR erratum

elapsed time: 724m

configs tested: 206
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
h8300                       h8s-sim_defconfig
mips                     loongson2k_defconfig
m68k                       m5249evb_defconfig
arc                    vdk_hs38_smp_defconfig
arm                          collie_defconfig
mips                        qi_lb60_defconfig
arm                            hisi_defconfig
x86_64                              defconfig
powerpc                         wii_defconfig
arm                       spear13xx_defconfig
s390                                defconfig
arm                         at91_dt_defconfig
arm                            lart_defconfig
sh                         apsh4a3a_defconfig
arm                           spitz_defconfig
powerpc                      makalu_defconfig
sh                           se7206_defconfig
sh                            titan_defconfig
powerpc                 mpc834x_mds_defconfig
openrisc                    or1ksim_defconfig
powerpc                      tqm8xx_defconfig
sh                                  defconfig
arm                          gemini_defconfig
powerpc                 linkstation_defconfig
mips                         tb0226_defconfig
powerpc                          allmodconfig
m68k                        mvme16x_defconfig
x86_64                           alldefconfig
riscv                    nommu_virt_defconfig
arm                  colibri_pxa270_defconfig
mips                         cobalt_defconfig
mips                           rs90_defconfig
powerpc                      ppc6xx_defconfig
mips                       bmips_be_defconfig
arm                           tegra_defconfig
arm                         axm55xx_defconfig
powerpc                 mpc8540_ads_defconfig
powerpc                    mvme5100_defconfig
sh                          sdk7786_defconfig
mips                       rbtx49xx_defconfig
powerpc                  mpc866_ads_defconfig
powerpc                     sequoia_defconfig
powerpc                     skiroot_defconfig
powerpc                 mpc85xx_cds_defconfig
powerpc                 mpc837x_rdb_defconfig
sh                               j2_defconfig
powerpc                      katmai_defconfig
arm                        spear3xx_defconfig
mips                      fuloong2e_defconfig
sparc                            alldefconfig
arm                          iop32x_defconfig
powerpc                         ps3_defconfig
powerpc                     tqm8555_defconfig
sh                           se7705_defconfig
arm                        vexpress_defconfig
arm                         assabet_defconfig
sh                         ap325rxa_defconfig
mips                  cavium_octeon_defconfig
sparc                               defconfig
csky                             alldefconfig
h8300                    h8300h-sim_defconfig
openrisc                 simple_smp_defconfig
sh                        edosk7705_defconfig
sh                   sh7724_generic_defconfig
powerpc                    adder875_defconfig
sh                        edosk7760_defconfig
arm                             mxs_defconfig
riscv                            alldefconfig
um                            kunit_defconfig
powerpc                   motionpro_defconfig
arc                     haps_hs_smp_defconfig
arm                           stm32_defconfig
arm                    vt8500_v6_v7_defconfig
arm                       aspeed_g5_defconfig
powerpc                      arches_defconfig
sh                              ul2_defconfig
arm                              alldefconfig
nios2                         10m50_defconfig
powerpc               mpc834x_itxgp_defconfig
sh                            shmin_defconfig
mips                            gpr_defconfig
powerpc64                           defconfig
powerpc                 mpc8560_ads_defconfig
mips                        maltaup_defconfig
arm                        realview_defconfig
arc                           tb10x_defconfig
xtensa                  nommu_kc705_defconfig
powerpc                  mpc885_ads_defconfig
m68k                             alldefconfig
sh                        sh7763rdp_defconfig
sh                   rts7751r2dplus_defconfig
arm                            qcom_defconfig
xtensa                       common_defconfig
mips                        workpad_defconfig
arm                           sama5_defconfig
arm                           h5000_defconfig
arc                              alldefconfig
sh                          rsk7201_defconfig
xtensa                generic_kc705_defconfig
m68k                       m5208evb_defconfig
arm                            xcep_defconfig
arm                         lpc32xx_defconfig
xtensa                         virt_defconfig
alpha                            alldefconfig
arc                 nsimosci_hs_smp_defconfig
arm                          badge4_defconfig
x86_64                            allnoconfig
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
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
x86_64               randconfig-a005-20210524
x86_64               randconfig-a001-20210524
x86_64               randconfig-a006-20210524
x86_64               randconfig-a003-20210524
x86_64               randconfig-a004-20210524
x86_64               randconfig-a002-20210524
i386                 randconfig-a001-20210525
i386                 randconfig-a002-20210525
i386                 randconfig-a005-20210525
i386                 randconfig-a006-20210525
i386                 randconfig-a003-20210525
i386                 randconfig-a004-20210525
i386                 randconfig-a001-20210524
i386                 randconfig-a002-20210524
i386                 randconfig-a005-20210524
i386                 randconfig-a006-20210524
i386                 randconfig-a004-20210524
i386                 randconfig-a003-20210524
x86_64               randconfig-a013-20210525
x86_64               randconfig-a012-20210525
x86_64               randconfig-a014-20210525
x86_64               randconfig-a016-20210525
x86_64               randconfig-a015-20210525
x86_64               randconfig-a011-20210525
i386                 randconfig-a011-20210524
i386                 randconfig-a016-20210524
i386                 randconfig-a015-20210524
i386                 randconfig-a012-20210524
i386                 randconfig-a014-20210524
i386                 randconfig-a013-20210524
i386                 randconfig-a011-20210525
i386                 randconfig-a016-20210525
i386                 randconfig-a015-20210525
i386                 randconfig-a012-20210525
i386                 randconfig-a014-20210525
i386                 randconfig-a013-20210525
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210524
x86_64               randconfig-b001-20210525
x86_64               randconfig-a005-20210525
x86_64               randconfig-a006-20210525
x86_64               randconfig-a001-20210525
x86_64               randconfig-a003-20210525
x86_64               randconfig-a004-20210525
x86_64               randconfig-a002-20210525
x86_64               randconfig-a013-20210524
x86_64               randconfig-a012-20210524
x86_64               randconfig-a014-20210524
x86_64               randconfig-a016-20210524
x86_64               randconfig-a015-20210524
x86_64               randconfig-a011-20210524

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
