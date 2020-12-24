Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26F202E24F9
	for <lists+linux-pci@lfdr.de>; Thu, 24 Dec 2020 08:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726064AbgLXHBI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Dec 2020 02:01:08 -0500
Received: from mga09.intel.com ([134.134.136.24]:4691 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725811AbgLXHBI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Dec 2020 02:01:08 -0500
IronPort-SDR: jEp2SP9S4It2DpgoE9Syg7pW2vHsrJRGPZ4VpIpGNpfRw78SYmPC0Cgzt7hIOFPbpvpUJScsre
 Ipw7mkXGfoQQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9844"; a="176264625"
X-IronPort-AV: E=Sophos;i="5.78,444,1599548400"; 
   d="scan'208";a="176264625"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2020 23:00:19 -0800
IronPort-SDR: gSdEOoYYeLMLX7SlTTEGnJSpCIGGBzaIprylMmqeEXAodEt1cqfOKqsYvjg89ZNaJVh7kML5Tp
 mFlrpVgROAxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,444,1599548400"; 
   d="scan'208";a="493179664"
Received: from lkp-server02.sh.intel.com (HELO 4242b19f17ef) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 23 Dec 2020 23:00:18 -0800
Received: from kbuild by 4242b19f17ef with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1ksKbh-0000nv-Po; Thu, 24 Dec 2020 07:00:17 +0000
Date:   Thu, 24 Dec 2020 14:59:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:for-linus] BUILD SUCCESS
 8be4de7ae872c67b749308cea300004c747203cc
Message-ID: <5fe43c4e.ASwKOTJAGxBpRI/S%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git  for-linus
branch HEAD: 8be4de7ae872c67b749308cea300004c747203cc  PCI: dwc: Fix inverted condition of DMA mask setup warning

elapsed time: 722m

configs tested: 134
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
nds32                             allnoconfig
m68k                        m5407c3_defconfig
openrisc                            defconfig
sh                           se7343_defconfig
mips                      maltasmvp_defconfig
arm                  colibri_pxa300_defconfig
arm                         hackkit_defconfig
sh                               alldefconfig
arm                        keystone_defconfig
arc                     nsimosci_hs_defconfig
arm                      jornada720_defconfig
parisc                              defconfig
c6x                                 defconfig
sh                             shx3_defconfig
mips                      loongson3_defconfig
powerpc                 mpc8315_rdb_defconfig
mips                        workpad_defconfig
arm                         bcm2835_defconfig
powerpc                 mpc8560_ads_defconfig
arm                        neponset_defconfig
arc                        vdk_hs38_defconfig
arm                          pcm027_defconfig
arm                         mv78xx0_defconfig
arm                        trizeps4_defconfig
powerpc                      ppc64e_defconfig
m68k                        m5272c3_defconfig
powerpc                     tqm8560_defconfig
sh                     sh7710voipgw_defconfig
mips                malta_kvm_guest_defconfig
s390                          debug_defconfig
sh                          landisk_defconfig
m68k                            q40_defconfig
mips                           mtx1_defconfig
sparc64                          alldefconfig
arm                        clps711x_defconfig
sh                         ap325rxa_defconfig
xtensa                       common_defconfig
arm                       multi_v4t_defconfig
xtensa                           alldefconfig
mips                        nlm_xlp_defconfig
mips                         db1xxx_defconfig
sh                              ul2_defconfig
powerpc                     skiroot_defconfig
powerpc                        icon_defconfig
powerpc                 mpc837x_rdb_defconfig
arm                              zx_defconfig
powerpc                     taishan_defconfig
powerpc                     mpc83xx_defconfig
h8300                            alldefconfig
powerpc                 mpc834x_mds_defconfig
arm                       omap2plus_defconfig
ia64                        generic_defconfig
sparc                       sparc32_defconfig
arm                       spear13xx_defconfig
sh                           se7780_defconfig
arm                             pxa_defconfig
mips                     loongson1b_defconfig
sparc64                             defconfig
alpha                               defconfig
arm                           tegra_defconfig
mips                  decstation_64_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
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
x86_64               randconfig-a001-20201223
x86_64               randconfig-a006-20201223
x86_64               randconfig-a002-20201223
x86_64               randconfig-a004-20201223
x86_64               randconfig-a003-20201223
x86_64               randconfig-a005-20201223
i386                 randconfig-a002-20201223
i386                 randconfig-a005-20201223
i386                 randconfig-a006-20201223
i386                 randconfig-a004-20201223
i386                 randconfig-a003-20201223
i386                 randconfig-a001-20201223
i386                 randconfig-a011-20201223
i386                 randconfig-a016-20201223
i386                 randconfig-a014-20201223
i386                 randconfig-a012-20201223
i386                 randconfig-a015-20201223
i386                 randconfig-a013-20201223
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a015-20201223
x86_64               randconfig-a014-20201223
x86_64               randconfig-a016-20201223
x86_64               randconfig-a012-20201223
x86_64               randconfig-a013-20201223
x86_64               randconfig-a011-20201223

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
