Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F369636E766
	for <lists+linux-pci@lfdr.de>; Thu, 29 Apr 2021 10:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240082AbhD2Iw4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Apr 2021 04:52:56 -0400
Received: from mga07.intel.com ([134.134.136.100]:41863 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239885AbhD2Iw4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 29 Apr 2021 04:52:56 -0400
IronPort-SDR: H+UHhwYV2gd9P8oEMYhkc4G08TmKEjU4vYQoUW6i7NVaedyWddiGkm2fklbmF/EZFxkPbi8nKg
 SeWEJz0LYpIQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9968"; a="260910010"
X-IronPort-AV: E=Sophos;i="5.82,258,1613462400"; 
   d="scan'208";a="260910010"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2021 01:52:09 -0700
IronPort-SDR: gmnBqbZv0haBy4PvAyC7rA0Ok4yxqWuIS0wlHVwe4wx9nZnLN3XxQqI0ieTA+3m2PTJ4hkskEp
 FGXvpD9rTI6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,258,1613462400"; 
   d="scan'208";a="466275007"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 29 Apr 2021 01:52:08 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lc2P1-0007Yy-Iq; Thu, 29 Apr 2021 08:52:07 +0000
Date:   Thu, 29 Apr 2021 16:51:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS 26622d60c18f97c92e3bc2c6a7b96c49744ea544
Message-ID: <608a7391.4wWZaoy3ayFrYR5g%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
branch HEAD: 26622d60c18f97c92e3bc2c6a7b96c49744ea544  Merge branch 'pci/tegra'

elapsed time: 720m

configs tested: 159
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
arm                         hackkit_defconfig
arm                        shmobile_defconfig
mips                           mtx1_defconfig
arm                       netwinder_defconfig
arm                          ep93xx_defconfig
powerpc                         wii_defconfig
sh                           se7206_defconfig
arm                        magician_defconfig
arm                         assabet_defconfig
h8300                    h8300h-sim_defconfig
powerpc                    adder875_defconfig
sh                        dreamcast_defconfig
mips                      loongson3_defconfig
xtensa                  cadence_csp_defconfig
s390                          debug_defconfig
sh                         ap325rxa_defconfig
alpha                               defconfig
mips                         rt305x_defconfig
xtensa                generic_kc705_defconfig
arm                        cerfcube_defconfig
sh                        edosk7705_defconfig
arm                         shannon_defconfig
arc                          axs101_defconfig
sh                           se7750_defconfig
mips                        bcm47xx_defconfig
powerpc                     ksi8560_defconfig
openrisc                  or1klitex_defconfig
um                           x86_64_defconfig
powerpc                     tqm8540_defconfig
arm                       cns3420vb_defconfig
powerpc                      bamboo_defconfig
arm                       multi_v4t_defconfig
mips                   sb1250_swarm_defconfig
arm                         nhk8815_defconfig
arm                            qcom_defconfig
sh                               j2_defconfig
xtensa                          iss_defconfig
mips                          ath25_defconfig
mips                         tb0287_defconfig
mips                     cu1830-neo_defconfig
powerpc                   bluestone_defconfig
arm                        clps711x_defconfig
arm                             rpc_defconfig
mips                           ip27_defconfig
arc                      axs103_smp_defconfig
mips                malta_qemu_32r6_defconfig
powerpc                      arches_defconfig
powerpc                     taishan_defconfig
arm                          imote2_defconfig
powerpc                      obs600_defconfig
arc                         haps_hs_defconfig
mips                        qi_lb60_defconfig
m68k                          sun3x_defconfig
powerpc                mpc7448_hpc2_defconfig
mips                           ip22_defconfig
sh                 kfr2r09-romimage_defconfig
powerpc                     redwood_defconfig
mips                        omega2p_defconfig
s390                             alldefconfig
openrisc                 simple_smp_defconfig
arm                    vt8500_v6_v7_defconfig
m68k                             alldefconfig
ia64                                defconfig
sh                         microdev_defconfig
riscv             nommu_k210_sdcard_defconfig
ia64                          tiger_defconfig
arm                           omap1_defconfig
arm                        spear3xx_defconfig
mips                      malta_kvm_defconfig
powerpc                  storcenter_defconfig
powerpc                     tqm8555_defconfig
mips                           ip32_defconfig
sparc                            allyesconfig
arm                       mainstone_defconfig
mips                      pic32mzda_defconfig
arc                    vdk_hs38_smp_defconfig
mips                  decstation_64_defconfig
arm                        multi_v7_defconfig
ia64                             allmodconfig
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
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a005-20210429
i386                 randconfig-a002-20210429
i386                 randconfig-a001-20210429
i386                 randconfig-a006-20210429
i386                 randconfig-a003-20210429
i386                 randconfig-a004-20210429
i386                 randconfig-a005-20210428
i386                 randconfig-a002-20210428
i386                 randconfig-a001-20210428
i386                 randconfig-a006-20210428
i386                 randconfig-a003-20210428
i386                 randconfig-a004-20210428
x86_64               randconfig-a015-20210428
x86_64               randconfig-a016-20210428
x86_64               randconfig-a011-20210428
x86_64               randconfig-a014-20210428
x86_64               randconfig-a013-20210428
x86_64               randconfig-a012-20210428
i386                 randconfig-a012-20210428
i386                 randconfig-a014-20210428
i386                 randconfig-a013-20210428
i386                 randconfig-a011-20210428
i386                 randconfig-a015-20210428
i386                 randconfig-a016-20210428
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
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
x86_64               randconfig-a004-20210428
x86_64               randconfig-a002-20210428
x86_64               randconfig-a005-20210428
x86_64               randconfig-a006-20210428
x86_64               randconfig-a001-20210428
x86_64               randconfig-a003-20210428

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
