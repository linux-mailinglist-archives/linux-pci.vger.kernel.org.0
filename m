Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99C65372606
	for <lists+linux-pci@lfdr.de>; Tue,  4 May 2021 08:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbhEDG7B (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 May 2021 02:59:01 -0400
Received: from mga06.intel.com ([134.134.136.31]:7178 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229721AbhEDG7B (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 4 May 2021 02:59:01 -0400
IronPort-SDR: aIKxmXQcF8MhPIw2bQCMPbK9z4elhmH7p5l77M/uTguwkdYC/wI2bv6FM+oYG2NIeKuRFNyzyE
 oMo0ujfNJYHA==
X-IronPort-AV: E=McAfee;i="6200,9189,9973"; a="259200165"
X-IronPort-AV: E=Sophos;i="5.82,271,1613462400"; 
   d="scan'208";a="259200165"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2021 23:58:06 -0700
IronPort-SDR: 3GtZvw8kPDn2aqW6nfwzEMM/UxJs9QFnggaFwTwDtwSY9ylxc+AvZjML2uXDajPtIQcbc/u8+y
 t/1hiOHcR2DA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,271,1613462400"; 
   d="scan'208";a="433138518"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 03 May 2021 23:58:05 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1ldp0O-0009V3-8u; Tue, 04 May 2021 06:58:04 +0000
Date:   Tue, 04 May 2021 14:57:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS 19e1547b448cc1b693e60336c534977c40829415
Message-ID: <6090f059.8rhBVJx/FfEVQnzs%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
branch HEAD: 19e1547b448cc1b693e60336c534977c40829415  Merge branch 'pci/tegra'

elapsed time: 722m

configs tested: 119
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
x86_64                           allyesconfig
riscv                            allmodconfig
i386                             allyesconfig
riscv                            allyesconfig
powerpc                     akebono_defconfig
powerpc                        warp_defconfig
arm                         vf610m4_defconfig
mips                      pistachio_defconfig
arm                           viper_defconfig
mips                           ip27_defconfig
sh                               alldefconfig
arm                        mvebu_v5_defconfig
powerpc                     sbc8548_defconfig
powerpc                         wii_defconfig
mips                     cu1830-neo_defconfig
sh                             sh03_defconfig
nios2                            allyesconfig
xtensa                    smp_lx200_defconfig
sh                        dreamcast_defconfig
arc                        nsimosci_defconfig
arm                             pxa_defconfig
arm                        clps711x_defconfig
mips                     loongson1c_defconfig
arm                          exynos_defconfig
powerpc                    adder875_defconfig
powerpc                      ppc64e_defconfig
riscv                    nommu_virt_defconfig
arm                          ixp4xx_defconfig
sh                        sh7757lcr_defconfig
xtensa                  cadence_csp_defconfig
arm                    vt8500_v6_v7_defconfig
mips                         tb0219_defconfig
parisc                           alldefconfig
nios2                         10m50_defconfig
arm                        spear3xx_defconfig
powerpc                 linkstation_defconfig
arm                           sama5_defconfig
arc                         haps_hs_defconfig
sparc                       sparc32_defconfig
sh                             shx3_defconfig
m68k                        stmark2_defconfig
m68k                       m5475evb_defconfig
sh                              ul2_defconfig
openrisc                            defconfig
arm                             rpc_defconfig
parisc                generic-32bit_defconfig
sh                          rsk7201_defconfig
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
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a003-20210503
i386                 randconfig-a006-20210503
i386                 randconfig-a001-20210503
i386                 randconfig-a005-20210503
i386                 randconfig-a004-20210503
i386                 randconfig-a002-20210503
x86_64               randconfig-a001-20210503
x86_64               randconfig-a005-20210503
x86_64               randconfig-a003-20210503
x86_64               randconfig-a002-20210503
x86_64               randconfig-a006-20210503
x86_64               randconfig-a004-20210503
i386                 randconfig-a013-20210503
i386                 randconfig-a015-20210503
i386                 randconfig-a016-20210503
i386                 randconfig-a014-20210503
i386                 randconfig-a011-20210503
i386                 randconfig-a012-20210503
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a014-20210503
x86_64               randconfig-a015-20210503
x86_64               randconfig-a012-20210503
x86_64               randconfig-a011-20210503
x86_64               randconfig-a013-20210503
x86_64               randconfig-a016-20210503

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
