Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3D7D4333B3
	for <lists+linux-pci@lfdr.de>; Tue, 19 Oct 2021 12:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235085AbhJSKmW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Oct 2021 06:42:22 -0400
Received: from mga09.intel.com ([134.134.136.24]:50693 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230117AbhJSKmW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Oct 2021 06:42:22 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10141"; a="228355295"
X-IronPort-AV: E=Sophos;i="5.85,384,1624345200"; 
   d="scan'208";a="228355295"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2021 03:40:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,384,1624345200"; 
   d="scan'208";a="594188133"
Received: from lkp-server02.sh.intel.com (HELO 08b2c502c3de) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 19 Oct 2021 03:40:03 -0700
Received: from kbuild by 08b2c502c3de with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mcmXK-000CJq-Ay; Tue, 19 Oct 2021 10:40:02 +0000
Date:   Tue, 19 Oct 2021 18:39:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/msi] BUILD SUCCESS
 ac8e3cef588c5affc6dfa7b693ec64bbf3cead6a
Message-ID: <616ea056.Jrt6PDUIrGbIX184%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/msi
branch HEAD: ac8e3cef588c5affc6dfa7b693ec64bbf3cead6a  PCI/sysfs: Explicitly show first MSI IRQ for 'irq'

elapsed time: 721m

configs tested: 139
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211019
powerpc                     pseries_defconfig
powerpc                     tqm8548_defconfig
xtensa                       common_defconfig
mips                            gpr_defconfig
powerpc                     powernv_defconfig
openrisc                            defconfig
sh                   secureedge5410_defconfig
powerpc                       ppc64_defconfig
arm                         palmz72_defconfig
arm                         nhk8815_defconfig
mips                  cavium_octeon_defconfig
sh                          rsk7203_defconfig
arm                           stm32_defconfig
um                               alldefconfig
arm                          lpd270_defconfig
mips                      maltaaprp_defconfig
sh                          urquell_defconfig
sh                          sdk7780_defconfig
openrisc                    or1ksim_defconfig
arm                        spear3xx_defconfig
powerpc                 mpc836x_rdk_defconfig
arm                         s5pv210_defconfig
mips                         tb0226_defconfig
powerpc                 mpc85xx_cds_defconfig
arm                            qcom_defconfig
mips                       capcella_defconfig
arm                         assabet_defconfig
powerpc                     kilauea_defconfig
s390                       zfcpdump_defconfig
arc                        vdk_hs38_defconfig
m68k                            q40_defconfig
powerpc                 linkstation_defconfig
arm                        keystone_defconfig
arc                    vdk_hs38_smp_defconfig
arm                        neponset_defconfig
powerpc                           allnoconfig
sh                         ap325rxa_defconfig
sh                          r7780mp_defconfig
m68k                          sun3x_defconfig
arc                        nsim_700_defconfig
m68k                        mvme147_defconfig
m68k                       bvme6000_defconfig
h8300                               defconfig
arm                         orion5x_defconfig
powerpc                      pasemi_defconfig
powerpc               mpc834x_itxgp_defconfig
powerpc                      acadia_defconfig
ia64                            zx1_defconfig
m68k                                defconfig
arm                           corgi_defconfig
arm                        realview_defconfig
powerpc                  storcenter_defconfig
riscv             nommu_k210_sdcard_defconfig
arm                     eseries_pxa_defconfig
powerpc                   currituck_defconfig
powerpc                 mpc834x_mds_defconfig
arm                  randconfig-c002-20211019
x86_64               randconfig-c001-20211019
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
nds32                             allnoconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
arc                              allyesconfig
parisc                              defconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allyesconfig
s390                             allmodconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a015-20211019
x86_64               randconfig-a012-20211019
x86_64               randconfig-a016-20211019
x86_64               randconfig-a014-20211019
x86_64               randconfig-a013-20211019
x86_64               randconfig-a011-20211019
i386                 randconfig-a014-20211019
i386                 randconfig-a016-20211019
i386                 randconfig-a011-20211019
i386                 randconfig-a015-20211019
i386                 randconfig-a012-20211019
i386                 randconfig-a013-20211019
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                           allyesconfig

clang tested configs:
arm                  randconfig-c002-20211019
mips                 randconfig-c004-20211019
i386                 randconfig-c001-20211019
s390                 randconfig-c005-20211019
x86_64               randconfig-c007-20211019
riscv                randconfig-c006-20211019
powerpc              randconfig-c003-20211019
x86_64               randconfig-a004-20211019
x86_64               randconfig-a006-20211019
x86_64               randconfig-a005-20211019
x86_64               randconfig-a001-20211019
x86_64               randconfig-a002-20211019
x86_64               randconfig-a003-20211019
i386                 randconfig-a001-20211019
i386                 randconfig-a003-20211019
i386                 randconfig-a004-20211019
i386                 randconfig-a005-20211019
i386                 randconfig-a002-20211019
i386                 randconfig-a006-20211019
hexagon              randconfig-r041-20211019
hexagon              randconfig-r045-20211019

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
