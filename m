Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2341D34A369
	for <lists+linux-pci@lfdr.de>; Fri, 26 Mar 2021 09:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbhCZIvF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Mar 2021 04:51:05 -0400
Received: from mga04.intel.com ([192.55.52.120]:26347 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229935AbhCZIuq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 26 Mar 2021 04:50:46 -0400
IronPort-SDR: 9/0C/3EWaoEqwPU0phWZX8Lj1prBnMf3T3PJZlow2KtzLut0gjdkufTqJ9f/Wpsm56N2IRx/so
 p6ABE2owwFxQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9934"; a="188829534"
X-IronPort-AV: E=Sophos;i="5.81,280,1610438400"; 
   d="scan'208";a="188829534"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 01:50:45 -0700
IronPort-SDR: zDvVo1MA4k4Sb/BRRA0k7l89ETnR+sUxULDZ/rudqM+WCJI0HYOy6OHSI/bRkVZUbTcPd7Jg+o
 /FnMDm8Pn82A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,280,1610438400"; 
   d="scan'208";a="453434507"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 26 Mar 2021 01:50:44 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lPiB1-0002d1-Rb; Fri, 26 Mar 2021 08:50:43 +0000
Date:   Fri, 26 Mar 2021 16:50:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:for-linus] BUILD SUCCESS
 cf673bd0cc973b25961d41355990beaed710068f
Message-ID: <605da05c.LkpDWB/rT5NFfAvK%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git for-linus
branch HEAD: cf673bd0cc973b25961d41355990beaed710068f  PCI: switchtec: Fix Spectre v1 vulnerability

elapsed time: 722m

configs tested: 176
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
mips                           ip28_defconfig
powerpc                   lite5200b_defconfig
arm                         s5pv210_defconfig
powerpc                   currituck_defconfig
h8300                            alldefconfig
powerpc                     ksi8560_defconfig
powerpc                       maple_defconfig
powerpc                      obs600_defconfig
sparc64                             defconfig
arm                         assabet_defconfig
xtensa                              defconfig
sh                         ecovec24_defconfig
sh                               alldefconfig
m68k                       m5475evb_defconfig
sh                   secureedge5410_defconfig
arm                        cerfcube_defconfig
powerpc                     mpc5200_defconfig
arm                          pxa3xx_defconfig
sh                          rsk7264_defconfig
csky                                defconfig
sh                     sh7710voipgw_defconfig
m68k                        stmark2_defconfig
powerpc                 xes_mpc85xx_defconfig
mips                          rb532_defconfig
powerpc                 mpc834x_mds_defconfig
arm                       aspeed_g5_defconfig
arm                            pleb_defconfig
arm                            mmp2_defconfig
s390                             alldefconfig
xtensa                  cadence_csp_defconfig
powerpc                         ps3_defconfig
parisc                generic-64bit_defconfig
mips                        qi_lb60_defconfig
sh                   sh7770_generic_defconfig
mips                        vocore2_defconfig
parisc                           alldefconfig
arm                        shmobile_defconfig
powerpc                       ppc64_defconfig
arm                           spitz_defconfig
arm                        keystone_defconfig
arm                          lpd270_defconfig
mips                      maltaaprp_defconfig
arm                        spear3xx_defconfig
arm                       imx_v6_v7_defconfig
mips                     loongson1c_defconfig
powerpc                     sequoia_defconfig
powerpc                      katmai_defconfig
arm                        multi_v7_defconfig
nds32                             allnoconfig
sh                ecovec24-romimage_defconfig
arm                      pxa255-idp_defconfig
arm                            mps2_defconfig
powerpc                      makalu_defconfig
powerpc                   motionpro_defconfig
arm                         lpc18xx_defconfig
mips                     decstation_defconfig
sh                             espt_defconfig
mips                        bcm63xx_defconfig
m68k                                defconfig
mips                  cavium_octeon_defconfig
sh                          sdk7780_defconfig
powerpc                      acadia_defconfig
powerpc                     tqm5200_defconfig
powerpc                 linkstation_defconfig
powerpc64                           defconfig
mips                          malta_defconfig
csky                             alldefconfig
nds32                            alldefconfig
riscv                    nommu_k210_defconfig
powerpc                      ep88xc_defconfig
xtensa                    xip_kc705_defconfig
mips                        omega2p_defconfig
sh                     magicpanelr2_defconfig
arm                          pcm027_defconfig
powerpc                     stx_gp3_defconfig
mips                           ip22_defconfig
sh                           se7712_defconfig
arc                    vdk_hs38_smp_defconfig
arm                        multi_v5_defconfig
mips                         cobalt_defconfig
powerpc                        icon_defconfig
nios2                               defconfig
arm                         axm55xx_defconfig
ia64                        generic_defconfig
m68k                            mac_defconfig
mips                      bmips_stb_defconfig
m68k                         amcore_defconfig
arm                         mv78xx0_defconfig
openrisc                 simple_smp_defconfig
arm                         orion5x_defconfig
powerpc                     tqm8548_defconfig
arm                           u8500_defconfig
arm                       netwinder_defconfig
powerpc                       eiger_defconfig
sh                          polaris_defconfig
mips                       lemote2f_defconfig
powerpc                     tqm8541_defconfig
m68k                            q40_defconfig
xtensa                    smp_lx200_defconfig
arm                  colibri_pxa270_defconfig
powerpc                 mpc837x_mds_defconfig
um                            kunit_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
arc                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
alpha                               defconfig
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
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a002-20210325
x86_64               randconfig-a003-20210325
x86_64               randconfig-a006-20210325
x86_64               randconfig-a001-20210325
x86_64               randconfig-a005-20210325
x86_64               randconfig-a004-20210325
i386                 randconfig-a003-20210325
i386                 randconfig-a004-20210325
i386                 randconfig-a001-20210325
i386                 randconfig-a002-20210325
i386                 randconfig-a006-20210325
i386                 randconfig-a005-20210325
i386                 randconfig-a014-20210325
i386                 randconfig-a011-20210325
i386                 randconfig-a015-20210325
i386                 randconfig-a016-20210325
i386                 randconfig-a013-20210325
i386                 randconfig-a012-20210325
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
x86_64               randconfig-a012-20210325
x86_64               randconfig-a015-20210325
x86_64               randconfig-a014-20210325
x86_64               randconfig-a013-20210325
x86_64               randconfig-a011-20210325
x86_64               randconfig-a016-20210325

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
