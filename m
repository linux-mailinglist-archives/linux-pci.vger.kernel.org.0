Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1FB4468C5
	for <lists+linux-pci@lfdr.de>; Fri,  5 Nov 2021 20:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233176AbhKETGv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Nov 2021 15:06:51 -0400
Received: from mga09.intel.com ([134.134.136.24]:58874 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230318AbhKETGu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 5 Nov 2021 15:06:50 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10159"; a="231808494"
X-IronPort-AV: E=Sophos;i="5.87,212,1631602800"; 
   d="scan'208";a="231808494"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2021 12:04:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,212,1631602800"; 
   d="scan'208";a="490426813"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 05 Nov 2021 12:04:09 -0700
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mj4VU-00087b-EU; Fri, 05 Nov 2021 19:04:08 +0000
Date:   Sat, 06 Nov 2021 03:03:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/host/kirin] BUILD SUCCESS
 e4c72797fd1609c630ead5bd86d5df16bb0ed5e9
Message-ID: <61857ff3.G0dshehPMXLDBb8I%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/host/kirin
branch HEAD: e4c72797fd1609c630ead5bd86d5df16bb0ed5e9  PCI: kirin: Allow removing the driver

elapsed time: 1351m

configs tested: 122
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allmodconfig
arm                              allyesconfig
i386                 randconfig-c001-20211105
arm                         at91_dt_defconfig
m68k                          atari_defconfig
m68k                            mac_defconfig
arm                       aspeed_g4_defconfig
arm                       imx_v4_v5_defconfig
nios2                         3c120_defconfig
arm                             mxs_defconfig
arm                            mps2_defconfig
openrisc                         alldefconfig
powerpc                     mpc83xx_defconfig
arm                         orion5x_defconfig
powerpc                 mpc836x_rdk_defconfig
arc                                 defconfig
powerpc                     powernv_defconfig
arm                        keystone_defconfig
arm                        oxnas_v6_defconfig
powerpc                      walnut_defconfig
sh                           se7712_defconfig
powerpc                     asp8347_defconfig
powerpc                   lite5200b_defconfig
mips                     loongson1c_defconfig
powerpc                      acadia_defconfig
arm                           tegra_defconfig
arm                           sunxi_defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                     pq2fads_defconfig
sh                               alldefconfig
sh                             sh03_defconfig
mips                      bmips_stb_defconfig
riscv                             allnoconfig
powerpc                     redwood_defconfig
powerpc                     pseries_defconfig
sh                        sh7785lcr_defconfig
sh                        sh7757lcr_defconfig
arm                    vt8500_v6_v7_defconfig
arm                            qcom_defconfig
sh                          r7785rp_defconfig
arm                        cerfcube_defconfig
mips                      maltasmvp_defconfig
powerpc                  mpc885_ads_defconfig
m68k                        mvme16x_defconfig
openrisc                 simple_smp_defconfig
mips                        vocore2_defconfig
arm                  randconfig-c002-20211105
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
nios2                               defconfig
nds32                             allnoconfig
arc                              allyesconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
sh                               allmodconfig
parisc                              defconfig
s390                                defconfig
parisc                           allyesconfig
s390                             allyesconfig
s390                             allmodconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
powerpc                          allyesconfig
x86_64               randconfig-a012-20211105
x86_64               randconfig-a016-20211105
x86_64               randconfig-a015-20211105
x86_64               randconfig-a013-20211105
x86_64               randconfig-a011-20211105
x86_64               randconfig-a014-20211105
i386                 randconfig-a016-20211105
i386                 randconfig-a014-20211105
i386                 randconfig-a015-20211105
i386                 randconfig-a013-20211105
i386                 randconfig-a011-20211105
i386                 randconfig-a012-20211105
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allyesconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                           allyesconfig

clang tested configs:
i386                 randconfig-a005-20211105
i386                 randconfig-a001-20211105
i386                 randconfig-a003-20211105
i386                 randconfig-a004-20211105
i386                 randconfig-a006-20211105
i386                 randconfig-a002-20211105
x86_64               randconfig-a004-20211105
x86_64               randconfig-a006-20211105
x86_64               randconfig-a001-20211105
x86_64               randconfig-a002-20211105
x86_64               randconfig-a003-20211105
x86_64               randconfig-a005-20211105
hexagon              randconfig-r041-20211105
hexagon              randconfig-r045-20211105

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
