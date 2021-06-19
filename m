Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7170B3AD8A4
	for <lists+linux-pci@lfdr.de>; Sat, 19 Jun 2021 10:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234308AbhFSIjP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 19 Jun 2021 04:39:15 -0400
Received: from mga06.intel.com ([134.134.136.31]:4216 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234304AbhFSIjO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 19 Jun 2021 04:39:14 -0400
IronPort-SDR: JtTdH3fMNoblM8o+3kLeBbM1cS6F4j1vHkeLQj4JZH8i0VvHJTyoqonabSup2/mtZCcwJvRVfw
 cipsJVRQv8Cg==
X-IronPort-AV: E=McAfee;i="6200,9189,10019"; a="267802366"
X-IronPort-AV: E=Sophos;i="5.83,285,1616482800"; 
   d="scan'208";a="267802366"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2021 01:37:03 -0700
IronPort-SDR: Pc8gaqgMkNQu0LOu/6bfuEWETDiKzvxd6nbAUOvAw9sCukeItx9TAuO8EXFaccpbev6mJehzL0
 kg5wzS3RlPJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,285,1616482800"; 
   d="scan'208";a="480027326"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Jun 2021 01:37:02 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1luWTN-0003SI-Gx; Sat, 19 Jun 2021 08:37:01 +0000
Date:   Sat, 19 Jun 2021 16:36:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:for-linus] BUILD SUCCESS
 f18139966d072dab8e4398c95ce955a9742e04f7
Message-ID: <60cdac9e.Ar7sC8w9yYU31NYX%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git for-linus
branch HEAD: f18139966d072dab8e4398c95ce955a9742e04f7  PCI: aardvark: Fix kernel panic during PIO transfer

elapsed time: 720m

configs tested: 145
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                          rsk7269_defconfig
powerpc                     asp8347_defconfig
sh                  sh7785lcr_32bit_defconfig
powerpc                     skiroot_defconfig
arm                         bcm2835_defconfig
powerpc                    klondike_defconfig
mips                          rb532_defconfig
powerpc                     tqm8540_defconfig
powerpc                 mpc834x_itx_defconfig
sh                          polaris_defconfig
x86_64                            allnoconfig
xtensa                       common_defconfig
arm                          pxa168_defconfig
nios2                         3c120_defconfig
nds32                             allnoconfig
powerpc64                           defconfig
arm                      pxa255-idp_defconfig
powerpc                     tqm8555_defconfig
arm                     am200epdkit_defconfig
arm                         orion5x_defconfig
sh                        edosk7705_defconfig
sh                           se7722_defconfig
mips                  maltasmvp_eva_defconfig
m68k                       m5249evb_defconfig
mips                         cobalt_defconfig
m68k                        stmark2_defconfig
powerpc                        fsp2_defconfig
arm                          badge4_defconfig
sh                           se7619_defconfig
powerpc                      pmac32_defconfig
um                           x86_64_defconfig
arm                             pxa_defconfig
sh                                  defconfig
arm                            pleb_defconfig
m68k                        m5272c3_defconfig
mips                      maltaaprp_defconfig
powerpc                 mpc8540_ads_defconfig
powerpc                      obs600_defconfig
arm                           spitz_defconfig
powerpc                     mpc83xx_defconfig
ia64                            zx1_defconfig
powerpc                   motionpro_defconfig
m68k                            q40_defconfig
m68k                        m5307c3_defconfig
ia64                      gensparse_defconfig
arm                     davinci_all_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc               mpc834x_itxgp_defconfig
arm                          iop32x_defconfig
arm                          lpd270_defconfig
arm                          collie_defconfig
mips                malta_qemu_32r6_defconfig
sh                             espt_defconfig
powerpc                  storcenter_defconfig
s390                             alldefconfig
sh                     magicpanelr2_defconfig
s390                          debug_defconfig
powerpc                     tqm5200_defconfig
arm                       netwinder_defconfig
arc                           tb10x_defconfig
arm                             ezx_defconfig
powerpc                     kmeter1_defconfig
arm                        clps711x_defconfig
mips                  decstation_64_defconfig
arm                       mainstone_defconfig
m68k                       m5475evb_defconfig
powerpc                         wii_defconfig
xtensa                              defconfig
sh                            migor_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
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
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
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
