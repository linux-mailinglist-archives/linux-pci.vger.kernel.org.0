Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6E43AC8EC
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jun 2021 12:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232903AbhFRKhN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Jun 2021 06:37:13 -0400
Received: from mga18.intel.com ([134.134.136.126]:43310 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232316AbhFRKhL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 18 Jun 2021 06:37:11 -0400
IronPort-SDR: RJIrt/lnfZA+sKN+lJ0pvOhcoEO2sMQbNa6OlVmxt+ocGmFlmX6RXnZDP8Gmi0s3GpKNEhBbuF
 UXBoyey4hzcg==
X-IronPort-AV: E=McAfee;i="6200,9189,10018"; a="193844763"
X-IronPort-AV: E=Sophos;i="5.83,283,1616482800"; 
   d="scan'208";a="193844763"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 03:34:52 -0700
IronPort-SDR: EgzaPdp+7h5RIrZWP+F3s16M0rxYATTdp7gO7KT8iYAFuFQwnnvMDByCpXGXbdjznF5dvT8FjL
 br+3oXqwLOhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,283,1616482800"; 
   d="scan'208";a="554696661"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 18 Jun 2021 03:34:51 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1luBpq-0002og-Ak; Fri, 18 Jun 2021 10:34:50 +0000
Date:   Fri, 18 Jun 2021 18:34:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:for-linus] BUILD SUCCESS WITH WARNING
 15ac366c3d20ce1e08173f1de393a8ce95a1facf
Message-ID: <60cc76ac.4/mGW5mezrK/kfBE%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git for-linus
branch HEAD: 15ac366c3d20ce1e08173f1de393a8ce95a1facf  PCI: aardvark: Fix kernel panic during PIO transfer

possible Warning in current branch:

drivers/pci/controller/dwc/pcie-tegra194.c:1829:23: warning: Shifting signed 32-bit value by 31 bits is undefined behaviour. See condition at line 1826. [shiftTooManyBitsSigned]

Warning ids grouped by kconfigs:

gcc_recent_errors
`-- m68k-randconfig-p001-20210617
    `-- drivers-pci-controller-dwc-pcie-tegra194.c:warning:Shifting-signed-bit-value-by-bits-is-undefined-behaviour.-See-condition-at-line-.-shiftTooManyBitsSigned

elapsed time: 723m

configs tested: 127
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                     davinci_all_defconfig
sh                           se7750_defconfig
mips                     loongson1c_defconfig
arm                         lpc32xx_defconfig
mips                          ath79_defconfig
arm                          lpd270_defconfig
arm64                            alldefconfig
arm                        keystone_defconfig
riscv                          rv32_defconfig
arm                        trizeps4_defconfig
sh                      rts7751r2d1_defconfig
arm                       omap2plus_defconfig
s390                          debug_defconfig
mips                         mpc30x_defconfig
powerpc                   bluestone_defconfig
nios2                            alldefconfig
powerpc                    adder875_defconfig
powerpc               mpc834x_itxgp_defconfig
arm                          ep93xx_defconfig
mips                     loongson1b_defconfig
sh                             sh03_defconfig
powerpc                     pseries_defconfig
riscv             nommu_k210_sdcard_defconfig
arm                          pxa910_defconfig
sh                          lboxre2_defconfig
arm                         at91_dt_defconfig
arm                      tct_hammer_defconfig
arm                      pxa255-idp_defconfig
arm                        multi_v5_defconfig
sh                           se7722_defconfig
powerpc                    klondike_defconfig
powerpc                       eiger_defconfig
ia64                            zx1_defconfig
sh                 kfr2r09-romimage_defconfig
powerpc                      pcm030_defconfig
sh                          r7785rp_defconfig
xtensa                    smp_lx200_defconfig
m68k                          sun3x_defconfig
arm                        cerfcube_defconfig
powerpc                      tqm8xx_defconfig
m68k                            q40_defconfig
powerpc                 mpc834x_mds_defconfig
powerpc                      ppc44x_defconfig
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
i386                 randconfig-a002-20210618
i386                 randconfig-a006-20210618
i386                 randconfig-a004-20210618
i386                 randconfig-a001-20210618
i386                 randconfig-a005-20210618
i386                 randconfig-a003-20210618
x86_64               randconfig-a015-20210618
x86_64               randconfig-a011-20210618
x86_64               randconfig-a012-20210618
x86_64               randconfig-a014-20210618
x86_64               randconfig-a016-20210618
x86_64               randconfig-a013-20210618
i386                 randconfig-a015-20210618
i386                 randconfig-a016-20210618
i386                 randconfig-a013-20210618
i386                 randconfig-a014-20210618
i386                 randconfig-a012-20210618
i386                 randconfig-a011-20210618
i386                 randconfig-a015-20210617
i386                 randconfig-a013-20210617
i386                 randconfig-a016-20210617
i386                 randconfig-a012-20210617
i386                 randconfig-a014-20210617
i386                 randconfig-a011-20210617
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
um                            kunit_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210618
x86_64               randconfig-a002-20210618
x86_64               randconfig-a001-20210618
x86_64               randconfig-a004-20210618
x86_64               randconfig-a003-20210618
x86_64               randconfig-a006-20210618
x86_64               randconfig-a005-20210618

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
