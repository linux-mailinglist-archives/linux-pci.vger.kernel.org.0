Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56BFA28E0F7
	for <lists+linux-pci@lfdr.de>; Wed, 14 Oct 2020 15:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbgJNNDf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Oct 2020 09:03:35 -0400
Received: from mga06.intel.com ([134.134.136.31]:42647 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727141AbgJNNDf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 14 Oct 2020 09:03:35 -0400
IronPort-SDR: 0kgRbu9jEyCCmZF+oAw7/uAWY0Yh7nx4tVouNDisJqM4noHyA0QIxVmqJCBaMF9Ka5skOpu9ui
 0dh+UR1OPiPg==
X-IronPort-AV: E=McAfee;i="6000,8403,9773"; a="227737226"
X-IronPort-AV: E=Sophos;i="5.77,374,1596524400"; 
   d="scan'208";a="227737226"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2020 06:03:29 -0700
IronPort-SDR: 4+TAEkZQvxkoSDsuTiniHHVydXy70YqrEjEP+fWfVAZmhsRFEnqR5vW4J3roKyH/XbBslcLpxt
 jWpW/Mryo3Bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,374,1596524400"; 
   d="scan'208";a="351481104"
Received: from lkp-server01.sh.intel.com (HELO 77f7a688d8fd) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 14 Oct 2020 06:03:27 -0700
Received: from kbuild by 77f7a688d8fd with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kSgRD-0000BL-AS; Wed, 14 Oct 2020 13:03:27 +0000
Date:   Wed, 14 Oct 2020 21:03:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:review/aspm] BUILD SUCCESS
 ba1e2d85f84c9532b2b27c41718611ed2cb7e146
Message-ID: <5f86f705.ogmX7d9XTml9y16E%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git  review/aspm
branch HEAD: ba1e2d85f84c9532b2b27c41718611ed2cb7e146  PCI/ASPM: Remove struct pcie_link_state.l1ss

elapsed time: 725m

configs tested: 144
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
riscv                    nommu_k210_defconfig
mips                     loongson1b_defconfig
powerpc                   lite5200b_defconfig
powerpc                     skiroot_defconfig
sh                   rts7751r2dplus_defconfig
sh                        edosk7705_defconfig
s390                             allyesconfig
powerpc                        fsp2_defconfig
parisc                generic-32bit_defconfig
mips                      maltasmvp_defconfig
mips                        omega2p_defconfig
arm                           stm32_defconfig
sh                            migor_defconfig
arm                         orion5x_defconfig
arc                     nsimosci_hs_defconfig
arm                        spear3xx_defconfig
arc                              allyesconfig
arm                        shmobile_defconfig
sh                           se7724_defconfig
mips                      malta_kvm_defconfig
arc                 nsimosci_hs_smp_defconfig
mips                            e55_defconfig
arm                         hackkit_defconfig
sh                          landisk_defconfig
arm                           h3600_defconfig
arc                             nps_defconfig
x86_64                              defconfig
mips                        nlm_xlr_defconfig
arm                        spear6xx_defconfig
sh                        sh7763rdp_defconfig
powerpc                       ppc64_defconfig
powerpc                     stx_gp3_defconfig
m68k                        stmark2_defconfig
sh                          rsk7203_defconfig
powerpc                     powernv_defconfig
sh                        edosk7760_defconfig
arm                        mvebu_v7_defconfig
sh                           se7619_defconfig
powerpc                     tqm5200_defconfig
powerpc64                           defconfig
arm                          prima2_defconfig
arm                        realview_defconfig
powerpc                  iss476-smp_defconfig
nds32                               defconfig
arm                            qcom_defconfig
arm                           corgi_defconfig
sh                           se7721_defconfig
xtensa                    xip_kc705_defconfig
sparc                               defconfig
powerpc                      ppc6xx_defconfig
powerpc                     mpc83xx_defconfig
m68k                        m5272c3_defconfig
arm                          simpad_defconfig
nds32                            alldefconfig
mips                         tb0219_defconfig
sh                          sdk7780_defconfig
arm                         lubbock_defconfig
sh                     magicpanelr2_defconfig
powerpc                      tqm8xx_defconfig
openrisc                         alldefconfig
m68k                        m5307c3_defconfig
sh                              ul2_defconfig
parisc                           alldefconfig
powerpc                     rainier_defconfig
um                             i386_defconfig
powerpc                 mpc836x_rdk_defconfig
arm                         axm55xx_defconfig
arm                       aspeed_g5_defconfig
sh                ecovec24-romimage_defconfig
mips                         mpc30x_defconfig
arm                           u8500_defconfig
mips                         tb0226_defconfig
mips                 decstation_r4k_defconfig
powerpc                           allnoconfig
nds32                             allnoconfig
mips                     decstation_defconfig
arm                          ixp4xx_defconfig
ia64                      gensparse_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
c6x                              allyesconfig
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
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
i386                 randconfig-a005-20201014
i386                 randconfig-a006-20201014
i386                 randconfig-a001-20201014
i386                 randconfig-a003-20201014
i386                 randconfig-a004-20201014
i386                 randconfig-a002-20201014
x86_64               randconfig-a016-20201014
x86_64               randconfig-a012-20201014
x86_64               randconfig-a015-20201014
x86_64               randconfig-a013-20201014
x86_64               randconfig-a014-20201014
x86_64               randconfig-a011-20201014
i386                 randconfig-a016-20201014
i386                 randconfig-a013-20201014
i386                 randconfig-a015-20201014
i386                 randconfig-a011-20201014
i386                 randconfig-a012-20201014
i386                 randconfig-a014-20201014
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                               rhel-8.3
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20201014
x86_64               randconfig-a002-20201014
x86_64               randconfig-a006-20201014
x86_64               randconfig-a001-20201014
x86_64               randconfig-a005-20201014
x86_64               randconfig-a003-20201014

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
