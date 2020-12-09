Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABA0E2D4384
	for <lists+linux-pci@lfdr.de>; Wed,  9 Dec 2020 14:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732435AbgLINnC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Dec 2020 08:43:02 -0500
Received: from mga18.intel.com ([134.134.136.126]:36520 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732492AbgLINnC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 9 Dec 2020 08:43:02 -0500
IronPort-SDR: 6kMXv2dY4UwOZpLgJJCyWxmT6ZvCdUMd0+aGh36WiGsvsrH9fcESjtef7nkMFLCsynTJwwgy1C
 kPyCzFCn1+yQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9829"; a="161836573"
X-IronPort-AV: E=Sophos;i="5.78,405,1599548400"; 
   d="scan'208";a="161836573"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2020 05:42:21 -0800
IronPort-SDR: NDCrWKe2d5EjJ2hhUV39kn/HKYyOsq+TfBlHmQMzdPaVN9f04MQF9q5YuAB1UB1lEtVkvUE10h
 HbDZXQj4m0FA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,405,1599548400"; 
   d="scan'208";a="484007422"
Received: from lkp-server01.sh.intel.com (HELO 2bbb63443648) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 09 Dec 2020 05:42:19 -0800
Received: from kbuild by 2bbb63443648 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kmzjX-0000IQ-4y; Wed, 09 Dec 2020 13:42:19 +0000
Date:   Wed, 09 Dec 2020 21:42:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:pci/misc] BUILD SUCCESS
 0aec75a5963e8d72c59a42055c5b5c524893b910
Message-ID: <5fd0d433.zDe+kF22ghs0g7h6%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git  pci/misc
branch HEAD: 0aec75a5963e8d72c59a42055c5b5c524893b910  PCI: Reduce pci_set_cacheline_size() message to debug level

elapsed time: 724m

configs tested: 188
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
s390                       zfcpdump_defconfig
s390                          debug_defconfig
arm                         mv78xx0_defconfig
m68k                        mvme147_defconfig
sh                        sh7785lcr_defconfig
xtensa                  cadence_csp_defconfig
powerpc                          g5_defconfig
sh                   rts7751r2dplus_defconfig
sh                     magicpanelr2_defconfig
powerpc                       maple_defconfig
arm                             rpc_defconfig
parisc                generic-32bit_defconfig
arm                   milbeaut_m10v_defconfig
powerpc                        warp_defconfig
sh                          lboxre2_defconfig
m68k                       m5475evb_defconfig
powerpc                     tqm5200_defconfig
arm                            lart_defconfig
ia64                        generic_defconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                         ps3_defconfig
arm                            qcom_defconfig
sh                             espt_defconfig
alpha                               defconfig
sh                            shmin_defconfig
arm                         orion5x_defconfig
sh                         apsh4a3a_defconfig
x86_64                           alldefconfig
csky                                defconfig
powerpc                         wii_defconfig
powerpc                     mpc83xx_defconfig
m68k                          hp300_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                 linkstation_defconfig
arm                            hisi_defconfig
sh                          rsk7201_defconfig
mips                     cu1830-neo_defconfig
sh                           se7751_defconfig
powerpc                mpc7448_hpc2_defconfig
sh                           se7721_defconfig
powerpc                     rainier_defconfig
powerpc                     tqm8555_defconfig
ia64                         bigsur_defconfig
mips                      loongson3_defconfig
mips                      bmips_stb_defconfig
arm                          ep93xx_defconfig
riscv                               defconfig
mips                  decstation_64_defconfig
arm                     davinci_all_defconfig
powerpc                      mgcoge_defconfig
mips                         bigsur_defconfig
powerpc                      ppc64e_defconfig
mips                         tb0226_defconfig
mips                        workpad_defconfig
sh                               j2_defconfig
mips                           rs90_defconfig
riscv                             allnoconfig
m68k                        m5272c3_defconfig
h8300                            alldefconfig
m68k                        mvme16x_defconfig
arc                         haps_hs_defconfig
c6x                         dsk6455_defconfig
c6x                        evmc6472_defconfig
mips                       lemote2f_defconfig
ia64                             allmodconfig
arm                       omap2plus_defconfig
arm                             mxs_defconfig
powerpc                   currituck_defconfig
powerpc                     sequoia_defconfig
c6x                              alldefconfig
arm                          ixp4xx_defconfig
arc                          axs101_defconfig
arm                         lpc18xx_defconfig
arc                    vdk_hs38_smp_defconfig
powerpc                     skiroot_defconfig
mips                        nlm_xlp_defconfig
arc                            hsdk_defconfig
xtensa                              defconfig
powerpc                      pmac32_defconfig
powerpc                    socrates_defconfig
powerpc                    klondike_defconfig
arm                       imx_v6_v7_defconfig
arm                           tegra_defconfig
mips                         rt305x_defconfig
powerpc                     tqm8541_defconfig
c6x                        evmc6678_defconfig
powerpc                      acadia_defconfig
arc                        nsimosci_defconfig
sh                           se7724_defconfig
powerpc64                           defconfig
arm                           omap1_defconfig
h8300                               defconfig
powerpc                      ppc40x_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                          prima2_defconfig
arm                            pleb_defconfig
powerpc                     pseries_defconfig
arm                             ezx_defconfig
powerpc                        icon_defconfig
arm                              alldefconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
nios2                            allyesconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20201208
x86_64               randconfig-a006-20201208
x86_64               randconfig-a005-20201208
x86_64               randconfig-a001-20201208
x86_64               randconfig-a002-20201208
x86_64               randconfig-a003-20201208
i386                 randconfig-a004-20201208
i386                 randconfig-a005-20201208
i386                 randconfig-a001-20201208
i386                 randconfig-a002-20201208
i386                 randconfig-a006-20201208
i386                 randconfig-a003-20201208
i386                 randconfig-a004-20201209
i386                 randconfig-a005-20201209
i386                 randconfig-a001-20201209
i386                 randconfig-a002-20201209
i386                 randconfig-a006-20201209
i386                 randconfig-a003-20201209
x86_64               randconfig-a016-20201209
x86_64               randconfig-a012-20201209
x86_64               randconfig-a013-20201209
x86_64               randconfig-a014-20201209
x86_64               randconfig-a015-20201209
x86_64               randconfig-a011-20201209
i386                 randconfig-a013-20201208
i386                 randconfig-a014-20201208
i386                 randconfig-a011-20201208
i386                 randconfig-a015-20201208
i386                 randconfig-a012-20201208
i386                 randconfig-a016-20201208
i386                 randconfig-a013-20201209
i386                 randconfig-a014-20201209
i386                 randconfig-a011-20201209
i386                 randconfig-a015-20201209
i386                 randconfig-a012-20201209
i386                 randconfig-a016-20201209
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20201209
x86_64               randconfig-a006-20201209
x86_64               randconfig-a005-20201209
x86_64               randconfig-a001-20201209
x86_64               randconfig-a002-20201209
x86_64               randconfig-a003-20201209

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
