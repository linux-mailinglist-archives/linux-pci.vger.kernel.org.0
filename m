Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87ECD49C988
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jan 2022 13:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241214AbiAZMW4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Jan 2022 07:22:56 -0500
Received: from mga04.intel.com ([192.55.52.120]:5419 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241287AbiAZMWz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 Jan 2022 07:22:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643199775; x=1674735775;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=vzw5BowU4VGev8ZyHV97rcYvgfUTcpziNuV9o+sLKQM=;
  b=HB07rv8JsCBaVWPXFBCw4wRxesqcJaAXxhnhXD1RBnyi2xOW+noULhLU
   Us8zYYxzgdghyecphkIvjdgBRK7a51xB/j2L0vnJBsT/2LbE8JYLZ/Ppj
   js8MBnpTixf2BBwl6BgPSKs4WMj3mE2TwmYuhxENg5qLEzHcy0gEcPy8v
   Ht4aFFJ6ve2DYCFh8/7/eKJwmm8huyyONv0b2dfmyEqb9GO4NDiQfLOFb
   C56DwC3xkHHlUYCcXV1q4ooboIlC/Li7LziuY8DJ1Pzn4+HrpGyoAq+mR
   k6iymLE3X19IvM8OjXQp+RO/+MRVmgbiXAAE9wVwocTUIh9cIifsSMhel
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="245371420"
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="245371420"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 04:22:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="477466521"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 26 Jan 2022 04:22:53 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nChK8-000LB7-P5; Wed, 26 Jan 2022 12:22:52 +0000
Date:   Wed, 26 Jan 2022 20:22:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:for-linus] BUILD SUCCESS
 c035366d9c9fe48d947ee6c43465ab43d42e20f2
Message-ID: <61f13d15.3ulHB20FZiQQGkBX%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git for-linus
branch HEAD: c035366d9c9fe48d947ee6c43465ab43d42e20f2  PCI: mt7621: Remove unused function pcie_rmw()

elapsed time: 725m

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
i386                          randconfig-c001
i386                 randconfig-c001-20220124
m68k                             allmodconfig
powerpc                          allmodconfig
m68k                             allyesconfig
powerpc                          allyesconfig
s390                             allmodconfig
s390                             allyesconfig
powerpc              randconfig-c003-20220124
arm                            hisi_defconfig
sh                            hp6xx_defconfig
sh                           se7206_defconfig
powerpc                     redwood_defconfig
arm                        spear6xx_defconfig
powerpc                mpc7448_hpc2_defconfig
powerpc                    sam440ep_defconfig
h8300                       h8s-sim_defconfig
sh                         ap325rxa_defconfig
powerpc                         ps3_defconfig
nios2                            alldefconfig
sh                 kfr2r09-romimage_defconfig
sh                          urquell_defconfig
mips                         cobalt_defconfig
mips                            ar7_defconfig
mips                        vocore2_defconfig
arm                      jornada720_defconfig
mips                         db1xxx_defconfig
xtensa                  audio_kc705_defconfig
sh                           se7780_defconfig
mips                         rt305x_defconfig
arm                        mini2440_defconfig
ia64                             alldefconfig
arc                        nsimosci_defconfig
sh                           se7724_defconfig
arm                       aspeed_g5_defconfig
mips                           xway_defconfig
arc                          axs101_defconfig
arm                          gemini_defconfig
arm                     eseries_pxa_defconfig
arc                        nsim_700_defconfig
sh                         apsh4a3a_defconfig
um                               alldefconfig
sh                           se7721_defconfig
powerpc                     tqm8541_defconfig
openrisc                            defconfig
i386                                defconfig
arm                            zeus_defconfig
nios2                         10m50_defconfig
powerpc                 mpc834x_mds_defconfig
sh                          sdk7780_defconfig
arc                            hsdk_defconfig
mips                  decstation_64_defconfig
xtensa                           alldefconfig
arc                                 defconfig
powerpc                       ppc64_defconfig
mips                            gpr_defconfig
mips                      fuloong2e_defconfig
sh                          landisk_defconfig
arm                           stm32_defconfig
arm                  randconfig-c002-20220124
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
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
sh                               allmodconfig
parisc                              defconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a002-20220124
x86_64               randconfig-a003-20220124
x86_64               randconfig-a001-20220124
x86_64               randconfig-a004-20220124
x86_64               randconfig-a005-20220124
x86_64               randconfig-a006-20220124
i386                 randconfig-a002-20220124
i386                 randconfig-a005-20220124
i386                 randconfig-a003-20220124
i386                 randconfig-a004-20220124
i386                 randconfig-a001-20220124
i386                 randconfig-a006-20220124
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
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
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
arm                  randconfig-c002-20220124
riscv                randconfig-c006-20220124
i386                 randconfig-c001-20220124
powerpc              randconfig-c003-20220124
mips                 randconfig-c004-20220124
x86_64               randconfig-c007-20220124
powerpc                      katmai_defconfig
powerpc                   lite5200b_defconfig
arm                           omap1_defconfig
powerpc                    socrates_defconfig
arm                         orion5x_defconfig
powerpc                        fsp2_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64               randconfig-a011-20220124
x86_64               randconfig-a013-20220124
x86_64               randconfig-a015-20220124
x86_64               randconfig-a016-20220124
x86_64               randconfig-a014-20220124
x86_64               randconfig-a012-20220124
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                 randconfig-a011-20220124
i386                 randconfig-a016-20220124
i386                 randconfig-a013-20220124
i386                 randconfig-a014-20220124
i386                 randconfig-a015-20220124
i386                 randconfig-a012-20220124
riscv                randconfig-r042-20220124
hexagon              randconfig-r045-20220124
hexagon              randconfig-r041-20220124
hexagon              randconfig-r045-20220125
hexagon              randconfig-r041-20220125
riscv                randconfig-r042-20220126
hexagon              randconfig-r045-20220126
hexagon              randconfig-r041-20220126

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
