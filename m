Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C681E3B8F0A
	for <lists+linux-pci@lfdr.de>; Thu,  1 Jul 2021 10:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235357AbhGAIrE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Jul 2021 04:47:04 -0400
Received: from mga09.intel.com ([134.134.136.24]:13765 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235088AbhGAIrE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Jul 2021 04:47:04 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10031"; a="208449899"
X-IronPort-AV: E=Sophos;i="5.83,313,1616482800"; 
   d="scan'208";a="208449899"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2021 01:44:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,313,1616482800"; 
   d="scan'208";a="626294208"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 01 Jul 2021 01:44:32 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lysJD-000AQV-Dq; Thu, 01 Jul 2021 08:44:31 +0000
Date:   Thu, 01 Jul 2021 16:44:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:pci/rockchip] BUILD SUCCESS
 450bc737daf066e83fb50cdbdb5c8918231aeedc
Message-ID: <60dd805c.VbsENxTKeTZH/s6u%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/rockchip
branch HEAD: 450bc737daf066e83fb50cdbdb5c8918231aeedc  PCI: rockchip: Register IRQ handlers after device and data are ready

elapsed time: 728m

configs tested: 159
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                          urquell_defconfig
arm                          pcm027_defconfig
arc                    vdk_hs38_smp_defconfig
arc                        nsimosci_defconfig
arm                    vt8500_v6_v7_defconfig
powerpc                      tqm8xx_defconfig
powerpc                     tqm8548_defconfig
sh                           se7619_defconfig
mips                        workpad_defconfig
arm                         at91_dt_defconfig
sh                           se7712_defconfig
ia64                         bigsur_defconfig
mips                      maltasmvp_defconfig
arm                       aspeed_g4_defconfig
sh                           se7724_defconfig
arm                         s5pv210_defconfig
m68k                        m5272c3_defconfig
ia64                             alldefconfig
powerpc                  mpc866_ads_defconfig
arm                       omap2plus_defconfig
arm                         axm55xx_defconfig
m68k                        mvme16x_defconfig
powerpc                     ep8248e_defconfig
arm                            xcep_defconfig
sh                          sdk7786_defconfig
sh                        dreamcast_defconfig
sh                        edosk7705_defconfig
arm                            zeus_defconfig
powerpc                       maple_defconfig
powerpc                 mpc834x_mds_defconfig
arm                          collie_defconfig
sh                           se7721_defconfig
arm                          gemini_defconfig
openrisc                            defconfig
mips                        maltaup_defconfig
sh                             shx3_defconfig
powerpc                 mpc8540_ads_defconfig
parisc                           alldefconfig
mips                         db1xxx_defconfig
sh                          r7785rp_defconfig
mips                           xway_defconfig
powerpc                     sbc8548_defconfig
arc                          axs103_defconfig
sh                          rsk7203_defconfig
s390                             allyesconfig
mips                        qi_lb60_defconfig
powerpc                        warp_defconfig
arm                           h5000_defconfig
mips                   sb1250_swarm_defconfig
mips                      bmips_stb_defconfig
powerpc                     sequoia_defconfig
xtensa                       common_defconfig
arm                       spear13xx_defconfig
arm                         hackkit_defconfig
powerpc                   bluestone_defconfig
mips                       capcella_defconfig
arm                      pxa255-idp_defconfig
mips                         rt305x_defconfig
sh                           se7705_defconfig
powerpc                        fsp2_defconfig
ia64                          tiger_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                 mpc836x_mds_defconfig
sh                          landisk_defconfig
um                               alldefconfig
sh                              ul2_defconfig
arm                             pxa_defconfig
sh                           se7206_defconfig
mips                         mpc30x_defconfig
arc                     nsimosci_hs_defconfig
ia64                             allmodconfig
m68k                        m5307c3_defconfig
arm                        magician_defconfig
mips                          ath25_defconfig
sh                          sdk7780_defconfig
mips                          rm200_defconfig
mips                        omega2p_defconfig
mips                  decstation_64_defconfig
powerpc                  mpc885_ads_defconfig
nios2                            alldefconfig
mips                     loongson1c_defconfig
sh                           se7343_defconfig
x86_64                            allnoconfig
ia64                                defconfig
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
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allmodconfig
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
x86_64               randconfig-a002-20210630
x86_64               randconfig-a001-20210630
x86_64               randconfig-a004-20210630
x86_64               randconfig-a005-20210630
x86_64               randconfig-a006-20210630
x86_64               randconfig-a003-20210630
i386                 randconfig-a004-20210630
i386                 randconfig-a001-20210630
i386                 randconfig-a003-20210630
i386                 randconfig-a002-20210630
i386                 randconfig-a005-20210630
i386                 randconfig-a006-20210630
i386                 randconfig-a014-20210630
i386                 randconfig-a011-20210630
i386                 randconfig-a016-20210630
i386                 randconfig-a012-20210630
i386                 randconfig-a013-20210630
i386                 randconfig-a015-20210630
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
um                            kunit_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210630
x86_64               randconfig-a012-20210630
x86_64               randconfig-a015-20210630
x86_64               randconfig-a016-20210630
x86_64               randconfig-a013-20210630
x86_64               randconfig-a011-20210630
x86_64               randconfig-a014-20210630

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
