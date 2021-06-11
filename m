Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6311C3A4188
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jun 2021 13:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbhFKL7P (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Jun 2021 07:59:15 -0400
Received: from mga02.intel.com ([134.134.136.20]:23333 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230370AbhFKL7O (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 11 Jun 2021 07:59:14 -0400
IronPort-SDR: y1PhHGhJE4p7IGEjXTjbHXj+rczgBk1/sm/aOI8S5q0dHtLgAS7Biz06nHHFzXqCKl22OXOp1G
 LGmjplO+FSow==
X-IronPort-AV: E=McAfee;i="6200,9189,10011"; a="192622172"
X-IronPort-AV: E=Sophos;i="5.83,265,1616482800"; 
   d="scan'208";a="192622172"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2021 04:57:16 -0700
IronPort-SDR: CJvT2sudj4tPPnqKWQ5nGlpgFwnfTGS+HTsHsEfMl9RGu6idCHcc3c9XLnT7L+sCmiLg4KC4Iy
 cfzTrf5s+kHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,265,1616482800"; 
   d="scan'208";a="483241517"
Received: from lkp-server02.sh.intel.com (HELO 3cb98b298c7e) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 11 Jun 2021 04:57:14 -0700
Received: from kbuild by 3cb98b298c7e with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lrfmk-0000a0-Ee; Fri, 11 Jun 2021 11:57:14 +0000
Date:   Fri, 11 Jun 2021 19:56:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:for-linus] BUILD SUCCESS
 7bf3c2ae58ac07070c57dc67ee3334a4da8e0679
Message-ID: <60c34f84.Atqw8i/jwyvOS1Zv%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git for-linus
branch HEAD: 7bf3c2ae58ac07070c57dc67ee3334a4da8e0679  PCI: Add ACS quirk for Broadcom BCM57414 NIC

elapsed time: 722m

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
powerpc                 mpc836x_rdk_defconfig
arm                         cm_x300_defconfig
arm                         s3c6400_defconfig
mips                           jazz_defconfig
powerpc                      chrp32_defconfig
mips                          rm200_defconfig
arc                            hsdk_defconfig
mips                      pistachio_defconfig
arc                     nsimosci_hs_defconfig
arm                      jornada720_defconfig
arm                         axm55xx_defconfig
powerpc                    socrates_defconfig
alpha                            allyesconfig
ia64                         bigsur_defconfig
ia64                                defconfig
riscv             nommu_k210_sdcard_defconfig
arm                        multi_v5_defconfig
powerpc                     kilauea_defconfig
mips                   sb1250_swarm_defconfig
arm                        spear6xx_defconfig
arm                           stm32_defconfig
sh                   sh7770_generic_defconfig
arm                         s5pv210_defconfig
sh                          rsk7201_defconfig
arm                        shmobile_defconfig
m68k                          sun3x_defconfig
x86_64                              defconfig
arm                          pxa910_defconfig
sh                   rts7751r2dplus_defconfig
sh                         ap325rxa_defconfig
powerpc                      ep88xc_defconfig
m68k                       m5475evb_defconfig
powerpc                       ppc64_defconfig
sh                         ecovec24_defconfig
mips                      maltasmvp_defconfig
arm                         hackkit_defconfig
sh                          kfr2r09_defconfig
mips                        jmr3927_defconfig
arm                     am200epdkit_defconfig
mips                           ip22_defconfig
m68k                        m5407c3_defconfig
arm                             mxs_defconfig
arm                            pleb_defconfig
arm                         palmz72_defconfig
arm                     eseries_pxa_defconfig
sh                          r7780mp_defconfig
arm                        mini2440_defconfig
arm                       omap2plus_defconfig
h8300                     edosk2674_defconfig
arm                      tct_hammer_defconfig
arm                         lpc32xx_defconfig
sh                                  defconfig
openrisc                  or1klitex_defconfig
arm                           spitz_defconfig
mips                  decstation_64_defconfig
mips                        workpad_defconfig
sparc                            alldefconfig
sh                           se7721_defconfig
arm                  colibri_pxa300_defconfig
arm                       imx_v4_v5_defconfig
powerpc64                           defconfig
mips                         rt305x_defconfig
powerpc                      tqm8xx_defconfig
nios2                         3c120_defconfig
microblaze                      mmu_defconfig
xtensa                generic_kc705_defconfig
sh                          rsk7269_defconfig
powerpc                    ge_imp3a_defconfig
i386                             alldefconfig
m68k                          atari_defconfig
m68k                         amcore_defconfig
sh                     sh7710voipgw_defconfig
arm                        trizeps4_defconfig
powerpc                     rainier_defconfig
powerpc                      ppc6xx_defconfig
um                               alldefconfig
powerpc                 mpc836x_mds_defconfig
arc                          axs103_defconfig
x86_64                            allnoconfig
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
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
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
i386                 randconfig-a002-20210610
i386                 randconfig-a006-20210610
i386                 randconfig-a004-20210610
i386                 randconfig-a001-20210610
i386                 randconfig-a005-20210610
i386                 randconfig-a003-20210610
i386                 randconfig-a002-20210611
i386                 randconfig-a006-20210611
i386                 randconfig-a004-20210611
i386                 randconfig-a001-20210611
i386                 randconfig-a005-20210611
i386                 randconfig-a003-20210611
x86_64               randconfig-a002-20210611
x86_64               randconfig-a001-20210611
x86_64               randconfig-a004-20210611
x86_64               randconfig-a003-20210611
x86_64               randconfig-a006-20210611
x86_64               randconfig-a005-20210611
x86_64               randconfig-a015-20210610
x86_64               randconfig-a011-20210610
x86_64               randconfig-a012-20210610
x86_64               randconfig-a014-20210610
x86_64               randconfig-a016-20210610
x86_64               randconfig-a013-20210610
i386                 randconfig-a015-20210610
i386                 randconfig-a013-20210610
i386                 randconfig-a016-20210610
i386                 randconfig-a014-20210610
i386                 randconfig-a012-20210610
i386                 randconfig-a011-20210610
i386                 randconfig-a015-20210611
i386                 randconfig-a013-20210611
i386                 randconfig-a016-20210611
i386                 randconfig-a014-20210611
i386                 randconfig-a012-20210611
i386                 randconfig-a011-20210611
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
um                            kunit_defconfig
x86_64                    rhel-8.3-kselftests
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a015-20210611
x86_64               randconfig-a011-20210611
x86_64               randconfig-a012-20210611
x86_64               randconfig-a014-20210611
x86_64               randconfig-a016-20210611
x86_64               randconfig-a013-20210611
x86_64               randconfig-a002-20210607
x86_64               randconfig-a004-20210607
x86_64               randconfig-a003-20210607
x86_64               randconfig-a006-20210607
x86_64               randconfig-a005-20210607
x86_64               randconfig-a001-20210607

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
