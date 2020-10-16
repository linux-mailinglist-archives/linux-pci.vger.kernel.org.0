Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 449EB28FE6D
	for <lists+linux-pci@lfdr.de>; Fri, 16 Oct 2020 08:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394352AbgJPGmD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Oct 2020 02:42:03 -0400
Received: from mga09.intel.com ([134.134.136.24]:12560 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394351AbgJPGmD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 16 Oct 2020 02:42:03 -0400
IronPort-SDR: cwBichy1QZA3FWS6QN11ZsmNWmBEYG2Gza7aqm1eFhRPvLByFZaVL+wsli22WvzMDnDNJ0CwW9
 DClzTvk1yQ7g==
X-IronPort-AV: E=McAfee;i="6000,8403,9775"; a="166647606"
X-IronPort-AV: E=Sophos;i="5.77,381,1596524400"; 
   d="scan'208";a="166647606"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2020 23:42:02 -0700
IronPort-SDR: RvoU7yoYC7BC10RHqdGIiRFMS7k1RnHFvnsKKwOZs1slG7t4Y1xQUm6iXv2SwWwKcvrYStx1XL
 wGlOZuQ7lahQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,381,1596524400"; 
   d="scan'208";a="521071843"
Received: from lkp-server01.sh.intel.com (HELO c8bc26b08a34) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 15 Oct 2020 23:42:00 -0700
Received: from kbuild by c8bc26b08a34 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kTJR9-00000t-Ea; Fri, 16 Oct 2020 06:41:59 +0000
Date:   Fri, 16 Oct 2020 14:41:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:review/aspm4] BUILD SUCCESS
 3afb14c5d9504d687a66cbafa3c885fb4ffc9cf9
Message-ID: <5f8940af.2F2lxmq6pGISBe95%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git  review/aspm4
branch HEAD: 3afb14c5d9504d687a66cbafa3c885fb4ffc9cf9  PCI/ASPM: Remove struct pcie_link_state.l1ss

elapsed time: 724m

configs tested: 181
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                   bluestone_defconfig
arm                       mainstone_defconfig
powerpc                      acadia_defconfig
xtensa                       common_defconfig
sh                        dreamcast_defconfig
powerpc                     mpc512x_defconfig
xtensa                  audio_kc705_defconfig
m68k                        mvme147_defconfig
powerpc                        cell_defconfig
arm                          collie_defconfig
mips                      maltaaprp_defconfig
powerpc                         ps3_defconfig
xtensa                generic_kc705_defconfig
arc                        vdk_hs38_defconfig
powerpc                      katmai_defconfig
sparc                       sparc32_defconfig
sh                           se7780_defconfig
xtensa                         virt_defconfig
arm                         lpc18xx_defconfig
arm                            u300_defconfig
arm                          moxart_defconfig
sh                               alldefconfig
powerpc                     tqm5200_defconfig
mips                      pic32mzda_defconfig
m68k                          multi_defconfig
powerpc                     taishan_defconfig
microblaze                          defconfig
sh                           se7721_defconfig
sh                          lboxre2_defconfig
sh                   sh7724_generic_defconfig
powerpc                 linkstation_defconfig
arm                        vexpress_defconfig
arm                         at91_dt_defconfig
arm                            lart_defconfig
parisc                generic-64bit_defconfig
x86_64                           alldefconfig
riscv                               defconfig
powerpc                 mpc8272_ads_defconfig
xtensa                              defconfig
arm                        neponset_defconfig
microblaze                      mmu_defconfig
sh                         ecovec24_defconfig
powerpc                   motionpro_defconfig
arm                      tct_hammer_defconfig
powerpc                     kilauea_defconfig
mips                        nlm_xlp_defconfig
mips                     decstation_defconfig
sh                          r7785rp_defconfig
arm                         lubbock_defconfig
arm                        mini2440_defconfig
sh                   rts7751r2dplus_defconfig
sh                         ap325rxa_defconfig
powerpc                      ppc64e_defconfig
arm                          ep93xx_defconfig
mips                          ath79_defconfig
arm                      jornada720_defconfig
arm                     davinci_all_defconfig
mips                  cavium_octeon_defconfig
riscv                            alldefconfig
sh                     sh7710voipgw_defconfig
arm                        oxnas_v6_defconfig
sh                           se7206_defconfig
sh                          r7780mp_defconfig
ia64                                defconfig
ia64                         bigsur_defconfig
powerpc                      ppc44x_defconfig
nios2                            allyesconfig
arm                       aspeed_g5_defconfig
arm                        mvebu_v5_defconfig
ia64                             allyesconfig
powerpc                     stx_gp3_defconfig
powerpc                           allnoconfig
h8300                       h8s-sim_defconfig
arm                           stm32_defconfig
arm                           spitz_defconfig
sh                  sh7785lcr_32bit_defconfig
arc                        nsimosci_defconfig
arm                       omap2plus_defconfig
arm                            xcep_defconfig
powerpc                     mpc5200_defconfig
arm                             pxa_defconfig
m68k                          sun3x_defconfig
sh                            shmin_defconfig
arm                           sama5_defconfig
powerpc                 mpc8560_ads_defconfig
arm                        magician_defconfig
sh                            migor_defconfig
arm                           viper_defconfig
ia64                             allmodconfig
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
x86_64               randconfig-a004-20201015
x86_64               randconfig-a002-20201015
x86_64               randconfig-a006-20201015
x86_64               randconfig-a001-20201015
x86_64               randconfig-a005-20201015
x86_64               randconfig-a003-20201015
i386                 randconfig-a005-20201015
i386                 randconfig-a006-20201015
i386                 randconfig-a001-20201015
i386                 randconfig-a003-20201015
i386                 randconfig-a004-20201015
i386                 randconfig-a002-20201015
i386                 randconfig-a005-20201014
i386                 randconfig-a006-20201014
i386                 randconfig-a001-20201014
i386                 randconfig-a003-20201014
i386                 randconfig-a004-20201014
i386                 randconfig-a002-20201014
x86_64               randconfig-a016-20201014
x86_64               randconfig-a012-20201014
x86_64               randconfig-a015-20201014
x86_64               randconfig-a013-20201014
x86_64               randconfig-a014-20201014
x86_64               randconfig-a011-20201014
i386                 randconfig-a016-20201014
i386                 randconfig-a013-20201014
i386                 randconfig-a015-20201014
i386                 randconfig-a011-20201014
i386                 randconfig-a012-20201014
i386                 randconfig-a014-20201014
i386                 randconfig-a016-20201016
i386                 randconfig-a013-20201016
i386                 randconfig-a015-20201016
i386                 randconfig-a011-20201016
i386                 randconfig-a012-20201016
i386                 randconfig-a014-20201016
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20201014
x86_64               randconfig-a002-20201014
x86_64               randconfig-a006-20201014
x86_64               randconfig-a001-20201014
x86_64               randconfig-a005-20201014
x86_64               randconfig-a003-20201014
x86_64               randconfig-a016-20201015
x86_64               randconfig-a012-20201015
x86_64               randconfig-a015-20201015
x86_64               randconfig-a013-20201015
x86_64               randconfig-a014-20201015
x86_64               randconfig-a011-20201015

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
