Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91A7540F34E
	for <lists+linux-pci@lfdr.de>; Fri, 17 Sep 2021 09:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240623AbhIQHdE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Sep 2021 03:33:04 -0400
Received: from mga12.intel.com ([192.55.52.136]:63509 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230393AbhIQHdE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 17 Sep 2021 03:33:04 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10109"; a="202239338"
X-IronPort-AV: E=Sophos;i="5.85,300,1624345200"; 
   d="scan'208";a="202239338"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2021 00:31:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,300,1624345200"; 
   d="scan'208";a="554498196"
Received: from lkp-server01.sh.intel.com (HELO 285e7b116627) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 17 Sep 2021 00:31:40 -0700
Received: from kbuild by 285e7b116627 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mR8LT-0002Q0-KD; Fri, 17 Sep 2021 07:31:39 +0000
Date:   Fri, 17 Sep 2021 15:31:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:for-linus] BUILD SUCCESS
 e042a4533fc346a655de7f1b8ac1fa01a2ed96e5
Message-ID: <6144443d.jXQavCBTwl6eetUl%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git for-linus
branch HEAD: e042a4533fc346a655de7f1b8ac1fa01a2ed96e5  MAINTAINERS: Add Nirmal Patel as VMD maintainer

elapsed time: 2019m

configs tested: 187
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210916
ia64                             allmodconfig
i386                             allyesconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
ia64                             allyesconfig
um                           x86_64_defconfig
riscv                            allyesconfig
mips                             allyesconfig
um                             i386_defconfig
mips                             allmodconfig
riscv                            allmodconfig
powerpc                          allyesconfig
s390                             allyesconfig
m68k                             allmodconfig
s390                             allmodconfig
powerpc                          allmodconfig
m68k                             allyesconfig
sparc                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
sh                               allmodconfig
parisc                           allyesconfig
arc                              allyesconfig
nios2                            allyesconfig
alpha                            allyesconfig
arm                        clps711x_defconfig
powerpc                 mpc8313_rdb_defconfig
arc                 nsimosci_hs_smp_defconfig
powerpc                      cm5200_defconfig
sh                        edosk7705_defconfig
powerpc               mpc834x_itxgp_defconfig
powerpc                    mvme5100_defconfig
arm                             rpc_defconfig
riscv                               defconfig
um                               alldefconfig
powerpc                      chrp32_defconfig
arm                         bcm2835_defconfig
arm                         at91_dt_defconfig
sh                           se7780_defconfig
sh                          polaris_defconfig
powerpc                 mpc8560_ads_defconfig
arm                         lubbock_defconfig
arm                          ep93xx_defconfig
arc                              alldefconfig
powerpc                      ppc44x_defconfig
sh                          landisk_defconfig
powerpc                     ep8248e_defconfig
arm                        mvebu_v7_defconfig
arc                        nsimosci_defconfig
arm                          moxart_defconfig
powerpc                        fsp2_defconfig
mips                  decstation_64_defconfig
mips                          ath79_defconfig
s390                          debug_defconfig
powerpc                 mpc8272_ads_defconfig
mips                         db1xxx_defconfig
sh                           se7712_defconfig
powerpc                     tqm8555_defconfig
arm                          pxa910_defconfig
powerpc                     tqm8541_defconfig
powerpc                     tqm8548_defconfig
powerpc                     kmeter1_defconfig
riscv                          rv32_defconfig
s390                       zfcpdump_defconfig
sh                           se7724_defconfig
powerpc                     tqm5200_defconfig
sh                   sh7770_generic_defconfig
powerpc                      acadia_defconfig
sh                          lboxre2_defconfig
powerpc                  mpc885_ads_defconfig
arm                         cm_x300_defconfig
sh                               alldefconfig
m68k                         amcore_defconfig
arm                        oxnas_v6_defconfig
sh                           se7206_defconfig
arm                         lpc18xx_defconfig
powerpc                    socrates_defconfig
arm                       netwinder_defconfig
powerpc                      tqm8xx_defconfig
sh                         ap325rxa_defconfig
arm                         nhk8815_defconfig
powerpc                     powernv_defconfig
arm                           stm32_defconfig
arc                     nsimosci_hs_defconfig
riscv                            alldefconfig
sparc                       sparc32_defconfig
m68k                           sun3_defconfig
ia64                      gensparse_defconfig
mips                     loongson2k_defconfig
mips                        vocore2_defconfig
mips                        nlm_xlp_defconfig
xtensa                  nommu_kc705_defconfig
mips                        workpad_defconfig
arm                     eseries_pxa_defconfig
powerpc                    klondike_defconfig
sh                           se7343_defconfig
powerpc                 mpc837x_mds_defconfig
ia64                          tiger_defconfig
powerpc                      katmai_defconfig
arm                        mini2440_defconfig
arm                        trizeps4_defconfig
xtensa                  cadence_csp_defconfig
arm                              alldefconfig
mips                      bmips_stb_defconfig
arm                      pxa255-idp_defconfig
sh                            hp6xx_defconfig
mips                  cavium_octeon_defconfig
nios2                         3c120_defconfig
arm                        realview_defconfig
arm                            hisi_defconfig
sh                          sdk7780_defconfig
arm                           u8500_defconfig
powerpc                       holly_defconfig
powerpc                   microwatt_defconfig
h8300                               defconfig
openrisc                         alldefconfig
m68k                       m5475evb_defconfig
powerpc                     pseries_defconfig
mips                           ip27_defconfig
arm                       imx_v6_v7_defconfig
arm                     am200epdkit_defconfig
m68k                            mac_defconfig
mips                        nlm_xlr_defconfig
powerpc                     tqm8560_defconfig
arm                        spear3xx_defconfig
m68k                             alldefconfig
sh                            shmin_defconfig
sh                        dreamcast_defconfig
x86_64               randconfig-c001-20210916
arm                  randconfig-c002-20210916
ia64                                defconfig
m68k                                defconfig
nios2                               defconfig
nds32                             allnoconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
arc                                 defconfig
parisc                              defconfig
s390                                defconfig
sparc                               defconfig
i386                                defconfig
powerpc                           allnoconfig
x86_64               randconfig-a016-20210916
x86_64               randconfig-a013-20210916
x86_64               randconfig-a012-20210916
x86_64               randconfig-a011-20210916
x86_64               randconfig-a014-20210916
x86_64               randconfig-a015-20210916
i386                 randconfig-a016-20210916
i386                 randconfig-a015-20210916
i386                 randconfig-a011-20210916
i386                 randconfig-a012-20210916
i386                 randconfig-a013-20210916
i386                 randconfig-a014-20210916
riscv                randconfig-r042-20210916
s390                 randconfig-r044-20210916
arc                  randconfig-r043-20210916
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
riscv                randconfig-c006-20210916
x86_64               randconfig-c007-20210916
mips                 randconfig-c004-20210916
powerpc              randconfig-c003-20210916
arm                  randconfig-c002-20210916
i386                 randconfig-c001-20210916
s390                 randconfig-c005-20210916
x86_64               randconfig-a002-20210916
x86_64               randconfig-a003-20210916
x86_64               randconfig-a006-20210916
x86_64               randconfig-a004-20210916
x86_64               randconfig-a005-20210916
x86_64               randconfig-a001-20210916
i386                 randconfig-a004-20210916
i386                 randconfig-a005-20210916
i386                 randconfig-a006-20210916
i386                 randconfig-a002-20210916
i386                 randconfig-a003-20210916
i386                 randconfig-a001-20210916

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
