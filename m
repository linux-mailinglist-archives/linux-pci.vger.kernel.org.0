Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77A01291091
	for <lists+linux-pci@lfdr.de>; Sat, 17 Oct 2020 09:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437502AbgJQHe6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 17 Oct 2020 03:34:58 -0400
Received: from mga18.intel.com ([134.134.136.126]:44078 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437499AbgJQHe5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 17 Oct 2020 03:34:57 -0400
IronPort-SDR: KUB4y2JDqcQDvNaLTcJWusgT48pdM7XlQ3zNsrWW0eqjr7iCfRKxuMKwe5UaZc7jxw9bL/UXYy
 XlX2lgn+A5MQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9776"; a="154558358"
X-IronPort-AV: E=Sophos;i="5.77,386,1596524400"; 
   d="scan'208";a="154558358"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2020 00:34:54 -0700
IronPort-SDR: wj1VnnXZP1XCLklJcR+4CXDO+5Tx7pFOwa9aK8jEia9XYkVtgDV7eWRMOYiPLMS9nLhm3Ch4L8
 409VMdbq/k0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,386,1596524400"; 
   d="scan'208";a="352413568"
Received: from lkp-server02.sh.intel.com (HELO 262a2cdd3070) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 17 Oct 2020 00:34:50 -0700
Received: from kbuild by 262a2cdd3070 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kTgjp-0000Ib-Lb; Sat, 17 Oct 2020 07:34:49 +0000
Date:   Sat, 17 Oct 2020 15:33:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:pci/aspm] BUILD SUCCESS
 1b2c933cca51fb091246f52c4f7211ec1ec398ed
Message-ID: <5f8a9e61.HTkUWL0SU/PmQr5P%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git  pci/aspm
branch HEAD: 1b2c933cca51fb091246f52c4f7211ec1ec398ed  PCI/ASPM: Remove struct pcie_link_state.l1ss

elapsed time: 724m

configs tested: 177
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                        workpad_defconfig
powerpc                     redwood_defconfig
sh                           se7751_defconfig
arm                           omap1_defconfig
h8300                               defconfig
arm                         socfpga_defconfig
powerpc                      ppc40x_defconfig
powerpc                     mpc512x_defconfig
arm                        multi_v7_defconfig
sh                        edosk7705_defconfig
sh                          lboxre2_defconfig
mips                      fuloong2e_defconfig
arm                        mini2440_defconfig
arm                        neponset_defconfig
arm                      integrator_defconfig
alpha                               defconfig
m68k                                defconfig
powerpc                   motionpro_defconfig
m68k                        m5407c3_defconfig
mips                         mpc30x_defconfig
mips                   sb1250_swarm_defconfig
arm                  colibri_pxa270_defconfig
mips                           xway_defconfig
mips                      pistachio_defconfig
powerpc                     tqm8560_defconfig
arm                          pxa168_defconfig
arm                         ebsa110_defconfig
mips                       rbtx49xx_defconfig
arm                           viper_defconfig
mips                 pnx8335_stb225_defconfig
ia64                          tiger_defconfig
powerpc                     pseries_defconfig
xtensa                       common_defconfig
um                            kunit_defconfig
sh                        sh7757lcr_defconfig
arc                        vdk_hs38_defconfig
arm                      tct_hammer_defconfig
arc                        nsim_700_defconfig
arm                        cerfcube_defconfig
s390                             allyesconfig
mips                         tb0287_defconfig
powerpc                     pq2fads_defconfig
powerpc                          allyesconfig
sh                   sh7770_generic_defconfig
mips                          ath79_defconfig
h8300                       h8s-sim_defconfig
arm                         s3c6400_defconfig
powerpc                     asp8347_defconfig
mips                     loongson1c_defconfig
mips                           ci20_defconfig
nios2                         10m50_defconfig
m68k                        mvme16x_defconfig
c6x                         dsk6455_defconfig
xtensa                          iss_defconfig
arm                         s3c2410_defconfig
mips                      loongson3_defconfig
arm                         at91_dt_defconfig
openrisc                            defconfig
arm                        magician_defconfig
arc                          axs103_defconfig
arm                       imx_v4_v5_defconfig
sh                 kfr2r09-romimage_defconfig
parisc                           alldefconfig
mips                      malta_kvm_defconfig
powerpc                   currituck_defconfig
arm                            lart_defconfig
mips                        omega2p_defconfig
arm                         vf610m4_defconfig
sh                             shx3_defconfig
arm                         cm_x300_defconfig
mips                      bmips_stb_defconfig
arm                        keystone_defconfig
powerpc                       eiger_defconfig
arm                         lpc18xx_defconfig
sh                            titan_defconfig
arm                           u8500_defconfig
powerpc                      ppc6xx_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc                     sbc8548_defconfig
m68k                        m5272c3_defconfig
powerpc                     ksi8560_defconfig
i386                             alldefconfig
arm                          gemini_defconfig
um                           x86_64_defconfig
arm                           spitz_defconfig
sh                      rts7751r2d1_defconfig
m68k                             alldefconfig
powerpc                     tqm8548_defconfig
powerpc                 mpc834x_mds_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
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
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a005-20201016
i386                 randconfig-a006-20201016
i386                 randconfig-a001-20201016
i386                 randconfig-a003-20201016
i386                 randconfig-a004-20201016
i386                 randconfig-a002-20201016
x86_64               randconfig-a016-20201016
x86_64               randconfig-a012-20201016
x86_64               randconfig-a015-20201016
x86_64               randconfig-a013-20201016
x86_64               randconfig-a014-20201016
x86_64               randconfig-a011-20201016
i386                 randconfig-a016-20201017
i386                 randconfig-a013-20201017
i386                 randconfig-a015-20201017
i386                 randconfig-a011-20201017
i386                 randconfig-a012-20201017
i386                 randconfig-a014-20201017
i386                 randconfig-a016-20201016
i386                 randconfig-a013-20201016
i386                 randconfig-a015-20201016
i386                 randconfig-a011-20201016
i386                 randconfig-a012-20201016
i386                 randconfig-a014-20201016
x86_64               randconfig-a004-20201017
x86_64               randconfig-a002-20201017
x86_64               randconfig-a006-20201017
x86_64               randconfig-a001-20201017
x86_64               randconfig-a005-20201017
x86_64               randconfig-a003-20201017
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
x86_64               randconfig-a004-20201016
x86_64               randconfig-a002-20201016
x86_64               randconfig-a006-20201016
x86_64               randconfig-a001-20201016
x86_64               randconfig-a005-20201016
x86_64               randconfig-a003-20201016
x86_64               randconfig-a016-20201017
x86_64               randconfig-a012-20201017
x86_64               randconfig-a015-20201017
x86_64               randconfig-a013-20201017
x86_64               randconfig-a014-20201017
x86_64               randconfig-a011-20201017

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
