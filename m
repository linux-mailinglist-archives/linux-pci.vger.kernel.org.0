Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD3662B2CCE
	for <lists+linux-pci@lfdr.de>; Sat, 14 Nov 2020 12:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbgKNLHp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 14 Nov 2020 06:07:45 -0500
Received: from mga02.intel.com ([134.134.136.20]:56478 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726513AbgKNLHp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 14 Nov 2020 06:07:45 -0500
IronPort-SDR: eZJwjN6SlEWZ7MxxnbVBSGigtJDLbxralK981qPHX9ddFIeMaqBoQxff43JZ391N2xzHcW55rw
 b3Cvcfoszv5Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9804"; a="157594167"
X-IronPort-AV: E=Sophos;i="5.77,478,1596524400"; 
   d="scan'208";a="157594167"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2020 03:07:44 -0800
IronPort-SDR: m75LUduFG0xL5dOMEVN4ReLWFtUb8SIXn7PCwXhx/tZ/SyhYYIxjlUgk56Och8YCvetIQAmCa5
 mTRtVT9HA9fA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,478,1596524400"; 
   d="scan'208";a="340024816"
Received: from lkp-server02.sh.intel.com (HELO 697932c29306) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 14 Nov 2020 03:07:43 -0800
Received: from kbuild by 697932c29306 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kdtPD-0000ny-1e; Sat, 14 Nov 2020 11:07:43 +0000
Date:   Sat, 14 Nov 2020 19:06:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:for-linus] BUILD SUCCESS
 51e2e24504adcfa9945e274b87d1c506096ebe41
Message-ID: <5fafba53.jwgAWg825pyCiLsU%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git  for-linus
branch HEAD: 51e2e24504adcfa9945e274b87d1c506096ebe41  PCI: Add function 1 DMA alias quirk for Marvell 9215 SATA controller

elapsed time: 723m

configs tested: 137
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                         hackkit_defconfig
mips                          rm200_defconfig
sh                          r7785rp_defconfig
ia64                             alldefconfig
arm                          collie_defconfig
m68k                        m5307c3_defconfig
powerpc                      mgcoge_defconfig
sh                          sdk7780_defconfig
arm                         lubbock_defconfig
mips                            e55_defconfig
xtensa                  cadence_csp_defconfig
nios2                            alldefconfig
sh                          rsk7203_defconfig
m68k                            q40_defconfig
sh                             shx3_defconfig
openrisc                    or1ksim_defconfig
arm                          gemini_defconfig
m68k                       m5249evb_defconfig
arm                          iop32x_defconfig
arm                          simpad_defconfig
arm                           sunxi_defconfig
mips                         rt305x_defconfig
powerpc                   bluestone_defconfig
powerpc               mpc834x_itxgp_defconfig
arm                      pxa255-idp_defconfig
powerpc                     tqm8560_defconfig
ia64                                defconfig
powerpc                 mpc832x_rdb_defconfig
mips                        omega2p_defconfig
powerpc                      cm5200_defconfig
powerpc                      bamboo_defconfig
mips                        bcm47xx_defconfig
powerpc64                        alldefconfig
sh                   sh7724_generic_defconfig
alpha                            alldefconfig
arm                         s3c6400_defconfig
arm                         vf610m4_defconfig
arm                      integrator_defconfig
sh                         ecovec24_defconfig
nds32                            alldefconfig
arm                       aspeed_g4_defconfig
arm                         assabet_defconfig
um                            kunit_defconfig
powerpc                      chrp32_defconfig
sh                               j2_defconfig
powerpc                     rainier_defconfig
m68k                            mac_defconfig
mips                        vocore2_defconfig
xtensa                         virt_defconfig
arm                        shmobile_defconfig
powerpc64                           defconfig
arm                           sama5_defconfig
mips                           ip32_defconfig
riscv                               defconfig
arm                       imx_v4_v5_defconfig
powerpc                     pq2fads_defconfig
powerpc                    mvme5100_defconfig
ia64                        generic_defconfig
arm                           stm32_defconfig
mips                        bcm63xx_defconfig
arc                     haps_hs_smp_defconfig
powerpc                 mpc8540_ads_defconfig
powerpc                          g5_defconfig
sparc                       sparc64_defconfig
mips                      pistachio_defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
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
i386                 randconfig-a006-20201113
i386                 randconfig-a005-20201113
i386                 randconfig-a002-20201113
i386                 randconfig-a001-20201113
i386                 randconfig-a003-20201113
i386                 randconfig-a004-20201113
x86_64               randconfig-a015-20201113
x86_64               randconfig-a011-20201113
x86_64               randconfig-a014-20201113
x86_64               randconfig-a013-20201113
x86_64               randconfig-a016-20201113
x86_64               randconfig-a012-20201113
i386                 randconfig-a012-20201113
i386                 randconfig-a014-20201113
i386                 randconfig-a016-20201113
i386                 randconfig-a011-20201113
i386                 randconfig-a015-20201113
i386                 randconfig-a013-20201113
riscv                            allyesconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a003-20201113
x86_64               randconfig-a005-20201113
x86_64               randconfig-a004-20201113
x86_64               randconfig-a002-20201113
x86_64               randconfig-a006-20201113
x86_64               randconfig-a001-20201113

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
