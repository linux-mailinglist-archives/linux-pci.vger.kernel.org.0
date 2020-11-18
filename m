Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65E9C2B7E8B
	for <lists+linux-pci@lfdr.de>; Wed, 18 Nov 2020 14:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgKRNsj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Nov 2020 08:48:39 -0500
Received: from mga07.intel.com ([134.134.136.100]:7959 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726308AbgKRNsj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 18 Nov 2020 08:48:39 -0500
IronPort-SDR: txhqDZFojfRAyQKet4JatX/fSVtl1kB5UwEXQ+kcxaVZZtTPeIJ8lw7H0p25aCLsImbNEUPcbr
 qqQx8z2hrshw==
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="235264296"
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="235264296"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2020 05:48:35 -0800
IronPort-SDR: 0fYxhJaP2NS9Dd2HSE4XtWToeJeY6Xa6j49D9k8/CkDp/fPlYh6+H108h9VYCTpkamEgaxiHC/
 5ylfHf+o9cGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="330505262"
Received: from lkp-server02.sh.intel.com (HELO 67996b229c47) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 18 Nov 2020 05:48:33 -0800
Received: from kbuild by 67996b229c47 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kfNp3-000072-5e; Wed, 18 Nov 2020 13:48:33 +0000
Date:   Wed, 18 Nov 2020 21:48:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:pci/err] BUILD SUCCESS
 113d1dab7f25896cc4e7a1b034314d0609100ed6
Message-ID: <5fb5261c.H7J3PydfLoMgT6Sd%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git  pci/err
branch HEAD: 113d1dab7f25896cc4e7a1b034314d0609100ed6  PCI/AER: Add RCEC AER error injection support

elapsed time: 724m

configs tested: 161
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
nios2                            alldefconfig
arc                           tb10x_defconfig
sh                              ul2_defconfig
arm                          lpd270_defconfig
powerpc                     mpc5200_defconfig
m68k                            mac_defconfig
arm                          tango4_defconfig
arm                        spear3xx_defconfig
arm                            hisi_defconfig
arm                         assabet_defconfig
powerpc                     kmeter1_defconfig
sh                     sh7710voipgw_defconfig
sh                         ecovec24_defconfig
powerpc                 mpc8315_rdb_defconfig
sh                          landisk_defconfig
powerpc                        warp_defconfig
arm                            u300_defconfig
mips                           ci20_defconfig
arm                          exynos_defconfig
mips                 decstation_r4k_defconfig
mips                      maltasmvp_defconfig
arc                         haps_hs_defconfig
sh                   sh7770_generic_defconfig
mips                      loongson3_defconfig
arm                            mps2_defconfig
arc                     nsimosci_hs_defconfig
mips                            ar7_defconfig
powerpc                      cm5200_defconfig
mips                          malta_defconfig
openrisc                    or1ksim_defconfig
arm                         hackkit_defconfig
m68k                         apollo_defconfig
mips                          rm200_defconfig
mips                  decstation_64_defconfig
sh                            hp6xx_defconfig
arm                         shannon_defconfig
h8300                       h8s-sim_defconfig
sh                   sh7724_generic_defconfig
powerpc                    klondike_defconfig
powerpc                 mpc832x_mds_defconfig
powerpc                    gamecube_defconfig
sh                          rsk7203_defconfig
powerpc                      pcm030_defconfig
openrisc                         alldefconfig
sparc                               defconfig
powerpc                     kilauea_defconfig
powerpc                    adder875_defconfig
mips                     cu1000-neo_defconfig
m68k                         amcore_defconfig
mips                            e55_defconfig
sh                            migor_defconfig
arm                         socfpga_defconfig
powerpc                 mpc8313_rdb_defconfig
sh                        edosk7760_defconfig
sh                               j2_defconfig
xtensa                  cadence_csp_defconfig
sh                          polaris_defconfig
arm                            lart_defconfig
arm                          prima2_defconfig
h8300                            alldefconfig
mips                      bmips_stb_defconfig
arm                           h5000_defconfig
arm                        neponset_defconfig
s390                             alldefconfig
ia64                             allmodconfig
ia64                                defconfig
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
parisc                           allyesconfig
s390                             allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a006-20201117
i386                 randconfig-a005-20201117
i386                 randconfig-a001-20201117
i386                 randconfig-a002-20201117
i386                 randconfig-a004-20201117
i386                 randconfig-a003-20201117
x86_64               randconfig-a005-20201118
x86_64               randconfig-a003-20201118
x86_64               randconfig-a004-20201118
x86_64               randconfig-a002-20201118
x86_64               randconfig-a006-20201118
x86_64               randconfig-a001-20201118
x86_64               randconfig-a015-20201115
x86_64               randconfig-a011-20201115
x86_64               randconfig-a014-20201115
x86_64               randconfig-a013-20201115
x86_64               randconfig-a016-20201115
x86_64               randconfig-a012-20201115
i386                 randconfig-a012-20201118
i386                 randconfig-a014-20201118
i386                 randconfig-a016-20201118
i386                 randconfig-a011-20201118
i386                 randconfig-a013-20201118
i386                 randconfig-a015-20201118
i386                 randconfig-a012-20201117
i386                 randconfig-a014-20201117
i386                 randconfig-a016-20201117
i386                 randconfig-a011-20201117
i386                 randconfig-a015-20201117
i386                 randconfig-a013-20201117
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
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a003-20201117
x86_64               randconfig-a005-20201117
x86_64               randconfig-a004-20201117
x86_64               randconfig-a002-20201117
x86_64               randconfig-a001-20201117
x86_64               randconfig-a006-20201117
x86_64               randconfig-a015-20201118
x86_64               randconfig-a014-20201118
x86_64               randconfig-a011-20201118
x86_64               randconfig-a013-20201118
x86_64               randconfig-a016-20201118
x86_64               randconfig-a012-20201118
x86_64               randconfig-a015-20201116
x86_64               randconfig-a011-20201116
x86_64               randconfig-a014-20201116
x86_64               randconfig-a013-20201116
x86_64               randconfig-a016-20201116
x86_64               randconfig-a012-20201116

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
