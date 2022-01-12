Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 255B548BE9A
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jan 2022 07:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237230AbiALGb3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jan 2022 01:31:29 -0500
Received: from mga17.intel.com ([192.55.52.151]:49542 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237017AbiALGb3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Jan 2022 01:31:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641969089; x=1673505089;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=vK44CJ7c6IjwP6Q4baZ72DWY+8GJRdIXKGnUVsKFv/4=;
  b=euEcc192wuMdjiqXiSdcsC0BjG3iUrC9oYhA76f0L9Kjjf+vzOFWIJYK
   AOdirZgLGvCkSILyDWTvsMJVEjbG6URllgeWxB/3m2vjkc7+0V0XnDecD
   LaTBS+ZF4T/JOnZg+JTz/XxtoFGvl2Hlue90DCGx62N4DINIUSgRoitGY
   UqhRHBN2VcYgpPYjuh2aUZTIyKK8kSREyPwbsr2l591T0NojoaEiA4uJF
   B3FJ0cCsJhBqVQQLkdRjTjo2Rc8PKQQ7H+hLGuPICSjzwdMrhCNIvHM+s
   arO6LnVs5fLN7pdK1iry2+mLDK25qFCjfeAeTaaaaVpGRk1UINNyr9CaT
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10224"; a="224365582"
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="224365582"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 22:31:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="472726858"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 11 Jan 2022 22:31:26 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n7XAM-0005ZF-4V; Wed, 12 Jan 2022 06:31:26 +0000
Date:   Wed, 12 Jan 2022 14:31:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/enumeration] BUILD SUCCESS
 346865f0745357f9f4704614ce1d9a8e6f27dbc4
Message-ID: <61de75aa.088kSXSvJKI5EBpf%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/enumeration
branch HEAD: 346865f0745357f9f4704614ce1d9a8e6f27dbc4  x86/PCI: Remove initialization of static variables to false

elapsed time: 785m

configs tested: 145
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
arc                                 defconfig
s390                             allmodconfig
sh                          sdk7780_defconfig
m68k                        mvme16x_defconfig
arm                        cerfcube_defconfig
arm                            pleb_defconfig
sh                          r7785rp_defconfig
arc                    vdk_hs38_smp_defconfig
h8300                               defconfig
s390                          debug_defconfig
arc                              allyesconfig
arm                       multi_v4t_defconfig
arm                           viper_defconfig
nios2                         3c120_defconfig
powerpc                      bamboo_defconfig
arm                      footbridge_defconfig
ia64                         bigsur_defconfig
arm                        multi_v7_defconfig
sh                          rsk7203_defconfig
sparc                            alldefconfig
m68k                       m5275evb_defconfig
sh                        edosk7705_defconfig
powerpc                     rainier_defconfig
sh                            shmin_defconfig
sh                            hp6xx_defconfig
h8300                       h8s-sim_defconfig
sh                           se7751_defconfig
arm                         assabet_defconfig
microblaze                          defconfig
sh                           se7722_defconfig
sh                 kfr2r09-romimage_defconfig
sh                          landisk_defconfig
sh                           se7712_defconfig
powerpc                  storcenter_defconfig
xtensa                generic_kc705_defconfig
powerpc                     tqm8548_defconfig
ia64                             allyesconfig
s390                                defconfig
sh                     magicpanelr2_defconfig
powerpc                     pq2fads_defconfig
parisc                              defconfig
mips                           xway_defconfig
m68k                         amcore_defconfig
arm                            mps2_defconfig
mips                      maltasmvp_defconfig
powerpc                    adder875_defconfig
sh                             shx3_defconfig
m68k                        stmark2_defconfig
arm                        trizeps4_defconfig
sh                ecovec24-romimage_defconfig
arm                      integrator_defconfig
arm                           u8500_defconfig
um                                  defconfig
arm                       omap2plus_defconfig
powerpc                 mpc8272_ads_defconfig
powerpc                 mpc836x_mds_defconfig
m68k                            q40_defconfig
sh                        edosk7760_defconfig
mips                        jmr3927_defconfig
xtensa                           alldefconfig
arm                  randconfig-c002-20220111
ia64                             allmodconfig
ia64                                defconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
sh                               allmodconfig
s390                             allyesconfig
parisc                           allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
riscv                randconfig-r042-20220111
arc                  randconfig-r043-20220111
s390                 randconfig-r044-20220111
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
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                                  kexec
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func

clang tested configs:
arm                  randconfig-c002-20220111
x86_64                        randconfig-c007
riscv                randconfig-c006-20220111
powerpc              randconfig-c003-20220111
i386                          randconfig-c001
mips                 randconfig-c004-20220111
s390                 randconfig-c005-20220111
arm                      tct_hammer_defconfig
mips                        workpad_defconfig
mips                          ath79_defconfig
arm                    vt8500_v6_v7_defconfig
mips                           ip27_defconfig
powerpc                          allmodconfig
powerpc                     kmeter1_defconfig
x86_64                           allyesconfig
powerpc                 mpc8272_ads_defconfig
powerpc                 mpc836x_mds_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
