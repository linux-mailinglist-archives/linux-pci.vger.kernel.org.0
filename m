Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32640493621
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jan 2022 09:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352302AbiASIU3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jan 2022 03:20:29 -0500
Received: from mga17.intel.com ([192.55.52.151]:35939 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352298AbiASIUZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Jan 2022 03:20:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642580425; x=1674116425;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=/9lV7Jjp9CQ2w2y3s7KwKl9aSR3Wsh6xWFLkQqLdrwU=;
  b=dxufQc57bWBqmziFdOzDYtcc7eV+dTMslFOu0n3+qpTa7Ka6y75LlcSt
   fxQxfek+MTdO+a9qlSzRJMhN1hG4/3TYbV2RaWidpLwyynohqsq3ssGNb
   sJopPs5BR1sk9cThmQLTammuRd0Hyo3XAyr9YNqX9rTcL+z/u25G4QPyx
   KXmRsjEUHu/epI9mwARoW99Rm2AKEmaorbpIq26A8Yb9yC2Ay6qxoDCVe
   a176dE6JyS4pwsvO/GNlNt2/RpO7aNMEmxm6YZwd7ffWVI/diPZ9pibDt
   zHWVdnz6M1VEcMO79FmhQjf8ZnUmVVUnKsGB+jPIimfnoWqcl4pNYeaUH
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="225687882"
X-IronPort-AV: E=Sophos;i="5.88,299,1635231600"; 
   d="scan'208";a="225687882"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 00:20:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,299,1635231600"; 
   d="scan'208";a="475055029"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 19 Jan 2022 00:20:22 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nA6Cb-000DP0-Tt; Wed, 19 Jan 2022 08:20:21 +0000
Date:   Wed, 19 Jan 2022 16:20:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/misc] BUILD SUCCESS
 7329e2608d04e19161ea553ec435470ffea30ba7
Message-ID: <61e7c9be.kQqlhBcMBU+4a8k6%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/misc
branch HEAD: 7329e2608d04e19161ea553ec435470ffea30ba7  x86/gpu: Reserve stolen memory for first integrated Intel GPU

elapsed time: 726m

configs tested: 159
configs skipped: 71

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20220117
mips                 randconfig-c004-20220117
powerpc              randconfig-c003-20220118
i386                          randconfig-c001
sh                                  defconfig
mips                            ar7_defconfig
sh                ecovec24-romimage_defconfig
powerpc                     asp8347_defconfig
powerpc                 mpc834x_mds_defconfig
sh                           se7721_defconfig
mips                         db1xxx_defconfig
arm64                            alldefconfig
sh                        dreamcast_defconfig
sh                          sdk7786_defconfig
arm                      footbridge_defconfig
csky                                defconfig
powerpc                  iss476-smp_defconfig
mips                        bcm47xx_defconfig
sh                            shmin_defconfig
h8300                    h8300h-sim_defconfig
sh                          rsk7201_defconfig
arm                       omap2plus_defconfig
arm                         axm55xx_defconfig
arc                        vdk_hs38_defconfig
sh                     sh7710voipgw_defconfig
arm                        multi_v7_defconfig
arm                            qcom_defconfig
arm                            hisi_defconfig
riscv                               defconfig
mips                       bmips_be_defconfig
sh                     magicpanelr2_defconfig
openrisc                            defconfig
sh                   sh7770_generic_defconfig
arc                           tb10x_defconfig
arm                        oxnas_v6_defconfig
m68k                          hp300_defconfig
powerpc                      chrp32_defconfig
xtensa                         virt_defconfig
powerpc                        cell_defconfig
sh                      rts7751r2d1_defconfig
arm                         vf610m4_defconfig
alpha                            allyesconfig
nios2                         3c120_defconfig
powerpc                     rainier_defconfig
powerpc                       ppc64_defconfig
arm                       imx_v6_v7_defconfig
arm                           tegra_defconfig
xtensa                    smp_lx200_defconfig
powerpc                           allnoconfig
arm                  randconfig-c002-20220116
arm                  randconfig-c002-20220117
arm                  randconfig-c002-20220118
arm                  randconfig-c002-20220119
ia64                             allmodconfig
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
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a016-20220117
x86_64               randconfig-a012-20220117
x86_64               randconfig-a013-20220117
x86_64               randconfig-a011-20220117
x86_64               randconfig-a014-20220117
x86_64               randconfig-a015-20220117
i386                 randconfig-a012-20220117
i386                 randconfig-a016-20220117
i386                 randconfig-a014-20220117
i386                 randconfig-a015-20220117
i386                 randconfig-a011-20220117
i386                 randconfig-a013-20220117
riscv                randconfig-r042-20220119
riscv                randconfig-r042-20220117
arc                  randconfig-r043-20220116
arc                  randconfig-r043-20220117
s390                 randconfig-r044-20220119
s390                 randconfig-r044-20220117
arc                  randconfig-r043-20220118
arc                  randconfig-r043-20220119
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                           allyesconfig

clang tested configs:
arm                  randconfig-c002-20220116
x86_64                        randconfig-c007
arm                  randconfig-c002-20220118
riscv                randconfig-c006-20220118
riscv                randconfig-c006-20220116
powerpc              randconfig-c003-20220116
powerpc              randconfig-c003-20220118
i386                          randconfig-c001
mips                 randconfig-c004-20220116
s390                 randconfig-c005-20220116
arm                  randconfig-c002-20220119
riscv                randconfig-c006-20220119
powerpc              randconfig-c003-20220119
s390                 randconfig-c005-20220119
mips                 randconfig-c004-20220119
arm                                 defconfig
riscv                            alldefconfig
arm                            mmp2_defconfig
arm                       imx_v4_v5_defconfig
powerpc                     kilauea_defconfig
i386                             allyesconfig
powerpc               mpc834x_itxgp_defconfig
powerpc                     mpc5200_defconfig
arm                         lpc32xx_defconfig
arm                           sama7_defconfig
arm                          collie_defconfig
powerpc                      ppc64e_defconfig
x86_64               randconfig-a005-20220117
x86_64               randconfig-a004-20220117
x86_64               randconfig-a001-20220117
x86_64               randconfig-a006-20220117
x86_64               randconfig-a002-20220117
x86_64               randconfig-a003-20220117
i386                 randconfig-a005-20220117
i386                 randconfig-a001-20220117
i386                 randconfig-a006-20220117
i386                 randconfig-a004-20220117
i386                 randconfig-a002-20220117
i386                 randconfig-a003-20220117
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
