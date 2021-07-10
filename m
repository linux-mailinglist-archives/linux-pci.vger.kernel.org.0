Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAF663C346C
	for <lists+linux-pci@lfdr.de>; Sat, 10 Jul 2021 14:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbhGJMEY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 10 Jul 2021 08:04:24 -0400
Received: from mga01.intel.com ([192.55.52.88]:19211 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230377AbhGJMEY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 10 Jul 2021 08:04:24 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10040"; a="231598835"
X-IronPort-AV: E=Sophos;i="5.84,229,1620716400"; 
   d="scan'208";a="231598835"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2021 05:01:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,229,1620716400"; 
   d="scan'208";a="650161971"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 10 Jul 2021 05:01:36 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m2Bfr-000Fha-MT; Sat, 10 Jul 2021 12:01:35 +0000
Date:   Sat, 10 Jul 2021 20:00:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:for-linus] BUILD SUCCESS
 62efe3eebc8bfc351961eee769a5c2fc30221451
Message-ID: <60e98be2.uK6Z/uu+w5JhbBue%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git for-linus
branch HEAD: 62efe3eebc8bfc351961eee769a5c2fc30221451  Revert "PCI: Coalesce host bridge contiguous apertures"

elapsed time: 721m

configs tested: 127
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sparc                            allyesconfig
h8300                     edosk2674_defconfig
arm                        spear6xx_defconfig
sh                        edosk7760_defconfig
m68k                       m5249evb_defconfig
sh                            migor_defconfig
arm                          imote2_defconfig
mips                      malta_kvm_defconfig
arm                          pcm027_defconfig
mips                       lemote2f_defconfig
arm                         orion5x_defconfig
mips                   sb1250_swarm_defconfig
arm                        clps711x_defconfig
powerpc                      ep88xc_defconfig
arm                        mvebu_v7_defconfig
powerpc                       maple_defconfig
m68k                        m5307c3_defconfig
powerpc                    gamecube_defconfig
arm                            dove_defconfig
mips                          ath79_defconfig
xtensa                generic_kc705_defconfig
riscv                    nommu_virt_defconfig
sh                              ul2_defconfig
arm                         nhk8815_defconfig
sh                           se7724_defconfig
m68k                       m5208evb_defconfig
arm                       aspeed_g5_defconfig
arm                          ep93xx_defconfig
arc                            hsdk_defconfig
arc                         haps_hs_defconfig
sh                               allmodconfig
riscv                             allnoconfig
arm                         shannon_defconfig
alpha                            alldefconfig
mips                malta_qemu_32r6_defconfig
powerpc                     taishan_defconfig
sh                            hp6xx_defconfig
sh                             sh03_defconfig
powerpc                      cm5200_defconfig
arm                         s5pv210_defconfig
sh                           sh2007_defconfig
m68k                         apollo_defconfig
mips                     loongson1c_defconfig
arm                           viper_defconfig
s390                             allyesconfig
arm                        mvebu_v5_defconfig
mips                       capcella_defconfig
mips                      pistachio_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                             allyesconfig
ia64                                defconfig
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
parisc                              defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a005-20210710
x86_64               randconfig-a004-20210710
x86_64               randconfig-a002-20210710
x86_64               randconfig-a003-20210710
x86_64               randconfig-a006-20210710
x86_64               randconfig-a001-20210710
x86_64               randconfig-a004-20210709
x86_64               randconfig-a005-20210709
x86_64               randconfig-a002-20210709
x86_64               randconfig-a006-20210709
x86_64               randconfig-a003-20210709
x86_64               randconfig-a001-20210709
i386                 randconfig-a006-20210709
i386                 randconfig-a004-20210709
i386                 randconfig-a001-20210709
i386                 randconfig-a003-20210709
i386                 randconfig-a005-20210709
i386                 randconfig-a002-20210709
i386                 randconfig-a015-20210709
i386                 randconfig-a016-20210709
i386                 randconfig-a011-20210709
i386                 randconfig-a012-20210709
i386                 randconfig-a013-20210709
i386                 randconfig-a014-20210709
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210709
x86_64               randconfig-a015-20210709
x86_64               randconfig-a011-20210709
x86_64               randconfig-a012-20210709
x86_64               randconfig-a014-20210709
x86_64               randconfig-a016-20210709
x86_64               randconfig-a013-20210709

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
