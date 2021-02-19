Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6378331FF05
	for <lists+linux-pci@lfdr.de>; Fri, 19 Feb 2021 19:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbhBSS4j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Feb 2021 13:56:39 -0500
Received: from mga18.intel.com ([134.134.136.126]:30525 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229612AbhBSS4j (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Feb 2021 13:56:39 -0500
IronPort-SDR: AjQhpb5PQEHAkLbF2RqqHuMU6SrAMvwiLG8uAMemJKYjvIBd+L90YCdVVxaarUuqlsQyx2L87K
 ipw5f79A6Zpg==
X-IronPort-AV: E=McAfee;i="6000,8403,9900"; a="171598070"
X-IronPort-AV: E=Sophos;i="5.81,189,1610438400"; 
   d="scan'208";a="171598070"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2021 10:55:57 -0800
IronPort-SDR: eiH9x4G9hraJjQ8aywD0naUMtp4f+bEJONeVLjAkXvx8D4TPXP2ZpSjBUQ9EgEdMtr9QSbRjlI
 B3PPJVG66WGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,189,1610438400"; 
   d="scan'208";a="581782856"
Received: from lkp-server02.sh.intel.com (HELO cd560a204411) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 19 Feb 2021 10:55:56 -0800
Received: from kbuild by cd560a204411 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lDAwV-000AZp-Kq; Fri, 19 Feb 2021 18:55:55 +0000
Date:   Sat, 20 Feb 2021 02:55:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:pci/enumeration] BUILD SUCCESS
 f6bda644fa3a7070621c3bf12cd657f69a42f170
Message-ID: <603009a6.x1irm36hPAM1YXJu%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/enumeration
branch HEAD: f6bda644fa3a7070621c3bf12cd657f69a42f170  PCI: Fix pci_register_io_range() memory leak

elapsed time: 722m

configs tested: 149
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                      cm5200_defconfig
mips                       rbtx49xx_defconfig
powerpc                     stx_gp3_defconfig
sh                           se7780_defconfig
arc                        vdk_hs38_defconfig
nios2                            allyesconfig
mips                            ar7_defconfig
sh                          sdk7786_defconfig
powerpc                       eiger_defconfig
arc                        nsimosci_defconfig
arm                        mvebu_v5_defconfig
powerpc                     sequoia_defconfig
ia64                             alldefconfig
sh                             espt_defconfig
arm                          pcm027_defconfig
mips                      pistachio_defconfig
arm                  colibri_pxa270_defconfig
sh                            migor_defconfig
arm                          pxa910_defconfig
arc                    vdk_hs38_smp_defconfig
powerpc                  storcenter_defconfig
mips                       bmips_be_defconfig
arm                            u300_defconfig
powerpc                  iss476-smp_defconfig
arm                        spear3xx_defconfig
powerpc                 mpc836x_rdk_defconfig
sh                          rsk7201_defconfig
powerpc                   motionpro_defconfig
arm                             pxa_defconfig
sh                          polaris_defconfig
arm                         at91_dt_defconfig
sh                        edosk7760_defconfig
powerpc                 mpc834x_mds_defconfig
arm                         bcm2835_defconfig
arm                         s5pv210_defconfig
powerpc                 canyonlands_defconfig
sh                     sh7710voipgw_defconfig
powerpc                      ppc44x_defconfig
riscv                    nommu_k210_defconfig
x86_64                           alldefconfig
arm                        mini2440_defconfig
riscv                               defconfig
sh                           se7721_defconfig
m68k                       bvme6000_defconfig
arm                           viper_defconfig
mips                         rt305x_defconfig
arm                       omap2plus_defconfig
powerpc                    amigaone_defconfig
sparc64                          alldefconfig
mips                          rb532_defconfig
mips                           jazz_defconfig
powerpc                 mpc832x_mds_defconfig
powerpc                     sbc8548_defconfig
arm                         hackkit_defconfig
powerpc                    adder875_defconfig
sh                           se7724_defconfig
arm                           stm32_defconfig
arm                          imote2_defconfig
s390                       zfcpdump_defconfig
sh                          rsk7264_defconfig
powerpc                 mpc8540_ads_defconfig
mips                          rm200_defconfig
xtensa                         virt_defconfig
arm                           corgi_defconfig
m68k                        mvme16x_defconfig
sh                   sh7770_generic_defconfig
arm                            hisi_defconfig
ia64                            zx1_defconfig
powerpc                     redwood_defconfig
powerpc                          allyesconfig
powerpc                       holly_defconfig
riscv                    nommu_virt_defconfig
arm                        multi_v7_defconfig
powerpc                  mpc866_ads_defconfig
arm                            qcom_defconfig
sh                               j2_defconfig
powerpc                mpc7448_hpc2_defconfig
xtensa                  nommu_kc705_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
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
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a005-20210219
i386                 randconfig-a003-20210219
i386                 randconfig-a002-20210219
i386                 randconfig-a004-20210219
i386                 randconfig-a001-20210219
i386                 randconfig-a006-20210219
x86_64               randconfig-a012-20210219
x86_64               randconfig-a016-20210219
x86_64               randconfig-a013-20210219
x86_64               randconfig-a015-20210219
x86_64               randconfig-a011-20210219
x86_64               randconfig-a014-20210219
i386                 randconfig-a016-20210219
i386                 randconfig-a012-20210219
i386                 randconfig-a014-20210219
i386                 randconfig-a013-20210219
i386                 randconfig-a011-20210219
i386                 randconfig-a015-20210219
riscv                            allyesconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a003-20210219
x86_64               randconfig-a001-20210219
x86_64               randconfig-a004-20210219
x86_64               randconfig-a002-20210219
x86_64               randconfig-a005-20210219
x86_64               randconfig-a006-20210219

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
