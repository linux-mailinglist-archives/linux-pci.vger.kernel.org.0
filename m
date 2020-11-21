Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7AD72BBD6C
	for <lists+linux-pci@lfdr.de>; Sat, 21 Nov 2020 06:32:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726058AbgKUFby (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 21 Nov 2020 00:31:54 -0500
Received: from mga18.intel.com ([134.134.136.126]:21303 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725968AbgKUFby (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 21 Nov 2020 00:31:54 -0500
IronPort-SDR: PTTumCud/892dTAoCMThb509zsxaJzew8U7f1cdxTQLmFhgoxZYbmCF96AOxl4eEK7d090vF1L
 Wu52eS9kAD+A==
X-IronPort-AV: E=McAfee;i="6000,8403,9811"; a="159344856"
X-IronPort-AV: E=Sophos;i="5.78,358,1599548400"; 
   d="scan'208";a="159344856"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2020 21:31:54 -0800
IronPort-SDR: K+kz/ZQYVpdMvvfCo8EfRR5rqSE3hEb/NlG/nT09S/a5BsXuQsk1d1tfIIS0i23zm/rnfO6Kkv
 5C1Rs0SAZhpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,358,1599548400"; 
   d="scan'208";a="545726758"
Received: from lkp-server01.sh.intel.com (HELO 00bc34107a07) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 20 Nov 2020 21:31:52 -0800
Received: from kbuild by 00bc34107a07 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kgLV2-0000DW-7L; Sat, 21 Nov 2020 05:31:52 +0000
Date:   Sat, 21 Nov 2020 13:31:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:for-linus] BUILD SUCCESS
 cce14622a7031ec9a9a62cf09edd67dcbfb0d063
Message-ID: <5fb8a636.fvF3yYgQ/O8stvNS%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git  for-linus
branch HEAD: cce14622a7031ec9a9a62cf09edd67dcbfb0d063  PCI: Add function 1 DMA alias quirk for Marvell 9215 SATA controller

elapsed time: 723m

configs tested: 121
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                 mpc836x_rdk_defconfig
arm                            qcom_defconfig
arm                     eseries_pxa_defconfig
powerpc                      walnut_defconfig
mips                          rm200_defconfig
arm                       netwinder_defconfig
arm                             mxs_defconfig
powerpc                     mpc83xx_defconfig
mips                           ip32_defconfig
arm                          badge4_defconfig
powerpc                     tqm8540_defconfig
sh                           se7721_defconfig
arc                        vdk_hs38_defconfig
sh                   sh7724_generic_defconfig
powerpc                 mpc8540_ads_defconfig
riscv                          rv32_defconfig
openrisc                            defconfig
mips                     loongson1c_defconfig
arm                            hisi_defconfig
arm                         assabet_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                     mpc5200_defconfig
arm                           corgi_defconfig
powerpc                     powernv_defconfig
mips                      pic32mzda_defconfig
arm                         hackkit_defconfig
mips                      fuloong2e_defconfig
arm                          simpad_defconfig
arm                        trizeps4_defconfig
arc                        nsimosci_defconfig
arm                       cns3420vb_defconfig
arm                     am200epdkit_defconfig
powerpc                     ppa8548_defconfig
sh                           se7780_defconfig
arm                      footbridge_defconfig
arm                          tango4_defconfig
powerpc                 mpc834x_mds_defconfig
openrisc                 simple_smp_defconfig
c6x                                 defconfig
alpha                               defconfig
sh                           se7750_defconfig
powerpc                      obs600_defconfig
mips                        maltaup_defconfig
arm                           tegra_defconfig
xtensa                              defconfig
arm                           omap1_defconfig
ia64                      gensparse_defconfig
sh                  sh7785lcr_32bit_defconfig
powerpc                 mpc836x_mds_defconfig
ia64                             allyesconfig
ia64                             allmodconfig
ia64                                defconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                            allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
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
powerpc                           allnoconfig
x86_64               randconfig-a006-20201120
x86_64               randconfig-a003-20201120
x86_64               randconfig-a004-20201120
x86_64               randconfig-a005-20201120
x86_64               randconfig-a001-20201120
x86_64               randconfig-a002-20201120
i386                 randconfig-a004-20201120
i386                 randconfig-a003-20201120
i386                 randconfig-a002-20201120
i386                 randconfig-a005-20201120
i386                 randconfig-a001-20201120
i386                 randconfig-a006-20201120
i386                 randconfig-a012-20201120
i386                 randconfig-a013-20201120
i386                 randconfig-a011-20201120
i386                 randconfig-a016-20201120
i386                 randconfig-a014-20201120
i386                 randconfig-a015-20201120
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a015-20201120
x86_64               randconfig-a011-20201120
x86_64               randconfig-a014-20201120
x86_64               randconfig-a016-20201120
x86_64               randconfig-a012-20201120
x86_64               randconfig-a013-20201120

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
