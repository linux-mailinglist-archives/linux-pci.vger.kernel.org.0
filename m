Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF21F42FA6F
	for <lists+linux-pci@lfdr.de>; Fri, 15 Oct 2021 19:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238173AbhJORoM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Oct 2021 13:44:12 -0400
Received: from mga05.intel.com ([192.55.52.43]:54986 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235095AbhJORoM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 15 Oct 2021 13:44:12 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10138"; a="314154769"
X-IronPort-AV: E=Sophos;i="5.85,376,1624345200"; 
   d="scan'208";a="314154769"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 10:42:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,376,1624345200"; 
   d="scan'208";a="481780658"
Received: from lkp-server02.sh.intel.com (HELO 08b2c502c3de) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 15 Oct 2021 10:42:03 -0700
Received: from kbuild by 08b2c502c3de with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mbRDW-0008EP-CD; Fri, 15 Oct 2021 17:42:02 +0000
Date:   Sat, 16 Oct 2021 01:41:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/host/qcom] BUILD SUCCESS
 aa9c0df98c2920f7176b001737546c6595f594a4
Message-ID: <6169bd31.SQPqIcgfwwoAenC3%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/host/qcom
branch HEAD: aa9c0df98c2920f7176b001737546c6595f594a4  PCI: qcom: Switch pcie_1_pipe_clk_src after PHY init in SC7280

elapsed time: 1115m

configs tested: 157
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                 randconfig-c004-20211015
i386                 randconfig-c001-20211015
i386                 randconfig-c001-20211014
mips                     loongson1b_defconfig
arm                            mmp2_defconfig
mips                          rb532_defconfig
arm                          exynos_defconfig
sh                        edosk7705_defconfig
h8300                       h8s-sim_defconfig
arm                           h3600_defconfig
powerpc                       ppc64_defconfig
mips                  decstation_64_defconfig
ia64                            zx1_defconfig
mips                           ci20_defconfig
sh                         ap325rxa_defconfig
powerpc                 mpc8560_ads_defconfig
mips                        nlm_xlr_defconfig
s390                       zfcpdump_defconfig
mips                        qi_lb60_defconfig
arm                  colibri_pxa270_defconfig
powerpc                     tqm8560_defconfig
sh                        edosk7760_defconfig
mips                malta_qemu_32r6_defconfig
powerpc                   lite5200b_defconfig
arm                         orion5x_defconfig
sh                          rsk7203_defconfig
ia64                                defconfig
mips                     loongson1c_defconfig
arm                         lpc32xx_defconfig
powerpc                      tqm8xx_defconfig
powerpc                    adder875_defconfig
arc                        nsim_700_defconfig
powerpc                     redwood_defconfig
powerpc                    klondike_defconfig
sh                          r7785rp_defconfig
powerpc                      katmai_defconfig
arm                         nhk8815_defconfig
mips                      malta_kvm_defconfig
powerpc                      arches_defconfig
mips                        bcm47xx_defconfig
xtensa                              defconfig
riscv                            allmodconfig
arm                         socfpga_defconfig
m68k                            q40_defconfig
m68k                       m5208evb_defconfig
powerpc                     tqm5200_defconfig
sh                        dreamcast_defconfig
powerpc                     tqm8541_defconfig
nios2                         3c120_defconfig
mips                      fuloong2e_defconfig
powerpc                        warp_defconfig
openrisc                    or1ksim_defconfig
mips                     cu1830-neo_defconfig
m68k                       m5275evb_defconfig
sh                           se7619_defconfig
ia64                      gensparse_defconfig
sh                  sh7785lcr_32bit_defconfig
m68k                          multi_defconfig
arm                        vexpress_defconfig
powerpc                      pmac32_defconfig
powerpc                 mpc8315_rdb_defconfig
arm                  randconfig-c002-20211015
x86_64               randconfig-c001-20211015
arm                  randconfig-c002-20211014
x86_64               randconfig-c001-20211014
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
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
parisc                              defconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                             allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64               randconfig-a006-20211014
x86_64               randconfig-a004-20211014
x86_64               randconfig-a001-20211014
x86_64               randconfig-a005-20211014
x86_64               randconfig-a002-20211014
x86_64               randconfig-a003-20211014
i386                 randconfig-a003-20211014
i386                 randconfig-a001-20211014
i386                 randconfig-a005-20211014
i386                 randconfig-a004-20211014
i386                 randconfig-a002-20211014
i386                 randconfig-a006-20211014
i386                 randconfig-a016-20211015
i386                 randconfig-a014-20211015
i386                 randconfig-a011-20211015
i386                 randconfig-a015-20211015
i386                 randconfig-a012-20211015
i386                 randconfig-a013-20211015
arc                  randconfig-r043-20211014
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                           allyesconfig

clang tested configs:
mips                 randconfig-c004-20211015
arm                  randconfig-c002-20211015
i386                 randconfig-c001-20211015
s390                 randconfig-c005-20211015
x86_64               randconfig-c007-20211015
powerpc              randconfig-c003-20211015
riscv                randconfig-c006-20211015
arm                  randconfig-c002-20211014
i386                 randconfig-c001-20211014
s390                 randconfig-c005-20211014
x86_64               randconfig-c007-20211014
powerpc              randconfig-c003-20211014
riscv                randconfig-c006-20211014
x86_64               randconfig-a012-20211014
x86_64               randconfig-a015-20211014
x86_64               randconfig-a016-20211014
x86_64               randconfig-a014-20211014
x86_64               randconfig-a011-20211014
x86_64               randconfig-a013-20211014
i386                 randconfig-a016-20211014
i386                 randconfig-a014-20211014
i386                 randconfig-a011-20211014
i386                 randconfig-a015-20211014
i386                 randconfig-a012-20211014
i386                 randconfig-a013-20211014
hexagon              randconfig-r041-20211014
s390                 randconfig-r044-20211014
riscv                randconfig-r042-20211014
hexagon              randconfig-r045-20211014

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
