Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C48531FF07
	for <lists+linux-pci@lfdr.de>; Fri, 19 Feb 2021 19:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbhBSS4k (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Feb 2021 13:56:40 -0500
Received: from mga03.intel.com ([134.134.136.65]:3494 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229726AbhBSS4j (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Feb 2021 13:56:39 -0500
IronPort-SDR: m/Bl0uQosDU0B+MCno1e7j6BlTGqPa5uwNIbjNsQOVv2EJskH6V8J0lssAF1S4xcWKiQHf1ZTT
 tj6moyJgJXGA==
X-IronPort-AV: E=McAfee;i="6000,8403,9900"; a="183989588"
X-IronPort-AV: E=Sophos;i="5.81,189,1610438400"; 
   d="scan'208";a="183989588"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2021 10:55:58 -0800
IronPort-SDR: hxLzmWgeU1QWOVbkAHTgPDEjxbVZV2V0a79NC2Rz3EDwYucqzXr3M0QFFP3oYneUssG+8Jpjoe
 ubwdoMFxU0lA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,189,1610438400"; 
   d="scan'208";a="368196271"
Received: from lkp-server02.sh.intel.com (HELO cd560a204411) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 19 Feb 2021 10:55:56 -0800
Received: from kbuild by cd560a204411 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lDAwW-000AZs-0H; Fri, 19 Feb 2021 18:55:56 +0000
Date:   Sat, 20 Feb 2021 02:55:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:pci/aspm] BUILD REGRESSION
 c79aafccbc64ed34ec6dce84cfa111e839044058
Message-ID: <603009ac.JDaVYZTrrUN4of8p%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/aspm
branch HEAD: c79aafccbc64ed34ec6dce84cfa111e839044058  PCI/ASPM: Move LTR, ASPM L1SS restore closer to use

Error/Warning reports:

https://lore.kernel.org/linux-pci/202102191629.oaDdZsBF-lkp@intel.com

Error/Warning in current branch:

drivers/pci/pci.c:1523:13: warning: conflicting types for 'pci_restore_ltr_state'

possible Error/Warning in current branch:

drivers/pci/pci.c:1450:2: error: implicit declaration of function 'pci_restore_ltr_state' [-Werror,-Wimplicit-function-declaration]
drivers/pci/pci.c:1450:2: error: implicit declaration of function 'pci_restore_ltr_state'; did you mean 'pci_restore_ptm_state'? [-Werror=implicit-function-declaration]
drivers/pci/pci.c:1523:13: error: static declaration of 'pci_restore_ltr_state' follows non-static declaration

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allmodconfig
|   `-- drivers-pci-pci.c:warning:conflicting-types-for-pci_restore_ltr_state
|-- alpha-allyesconfig
|   `-- drivers-pci-pci.c:warning:conflicting-types-for-pci_restore_ltr_state
|-- alpha-defconfig
|   `-- drivers-pci-pci.c:warning:conflicting-types-for-pci_restore_ltr_state
|-- alpha-randconfig-r023-20210219
|   `-- drivers-pci-pci.c:warning:conflicting-types-for-pci_restore_ltr_state
|-- arc-allyesconfig
|   `-- drivers-pci-pci.c:warning:conflicting-types-for-pci_restore_ltr_state
|-- arm-allmodconfig
|   `-- drivers-pci-pci.c:warning:conflicting-types-for-pci_restore_ltr_state
|-- arm-allyesconfig
|   `-- drivers-pci-pci.c:warning:conflicting-types-for-pci_restore_ltr_state
|-- arm-defconfig
|   `-- drivers-pci-pci.c:warning:conflicting-types-for-pci_restore_ltr_state
|-- arm64-allyesconfig
|   `-- drivers-pci-pci.c:warning:conflicting-types-for-pci_restore_ltr_state
|-- arm64-defconfig
|   `-- drivers-pci-pci.c:warning:conflicting-types-for-pci_restore_ltr_state
|-- i386-allyesconfig
|   `-- drivers-pci-pci.c:warning:conflicting-types-for-pci_restore_ltr_state
|-- i386-defconfig
|   `-- drivers-pci-pci.c:warning:conflicting-types-for-pci_restore_ltr_state
|-- i386-randconfig-a001-20210219
|   `-- drivers-pci-pci.c:warning:conflicting-types-for-pci_restore_ltr_state
|-- i386-randconfig-a002-20210219
|   `-- drivers-pci-pci.c:warning:conflicting-types-for-pci_restore_ltr_state
|-- i386-randconfig-a003-20210219
|   `-- drivers-pci-pci.c:warning:conflicting-types-for-pci_restore_ltr_state
|-- i386-randconfig-a004-20210219
|   `-- drivers-pci-pci.c:warning:conflicting-types-for-pci_restore_ltr_state
|-- i386-randconfig-a005-20210219
|   `-- drivers-pci-pci.c:warning:conflicting-types-for-pci_restore_ltr_state
|-- i386-randconfig-a006-20210219
|   `-- drivers-pci-pci.c:warning:conflicting-types-for-pci_restore_ltr_state
|-- i386-randconfig-a011-20210219
|   `-- drivers-pci-pci.c:warning:conflicting-types-for-pci_restore_ltr_state
|-- i386-randconfig-a012-20210219
|   `-- drivers-pci-pci.c:warning:conflicting-types-for-pci_restore_ltr_state
|-- i386-randconfig-a013-20210219
|   `-- drivers-pci-pci.c:warning:conflicting-types-for-pci_restore_ltr_state
|-- i386-randconfig-a014-20210219
|   `-- drivers-pci-pci.c:warning:conflicting-types-for-pci_restore_ltr_state
|-- i386-randconfig-a015-20210219
|   `-- drivers-pci-pci.c:warning:conflicting-types-for-pci_restore_ltr_state
|-- i386-randconfig-a016-20210219
|   `-- drivers-pci-pci.c:warning:conflicting-types-for-pci_restore_ltr_state
|-- i386-randconfig-c001-20210219
|   `-- drivers-pci-pci.c:warning:conflicting-types-for-pci_restore_ltr_state
|-- i386-randconfig-m021-20210219
|   `-- drivers-pci-pci.c:warning:conflicting-types-for-pci_restore_ltr_state
|-- i386-randconfig-s001-20210219
|   `-- drivers-pci-pci.c:warning:conflicting-types-for-pci_restore_ltr_state
|-- i386-randconfig-s002-20210219
|   `-- drivers-pci-pci.c:warning:conflicting-types-for-pci_restore_ltr_state
|-- ia64-allmodconfig
|   |-- drivers-pci-pci.c:error:implicit-declaration-of-function-pci_restore_ltr_state
|   |-- drivers-pci-pci.c:error:static-declaration-of-pci_restore_ltr_state-follows-non-static-declaration
|   `-- drivers-pci-pci.c:warning:conflicting-types-for-pci_restore_ltr_state
|-- ia64-allyesconfig
|   |-- drivers-pci-pci.c:error:implicit-declaration-of-function-pci_restore_ltr_state
|   |-- drivers-pci-pci.c:error:static-declaration-of-pci_restore_ltr_state-follows-non-static-declaration
|   `-- drivers-pci-pci.c:warning:conflicting-types-for-pci_restore_ltr_state
|-- ia64-defconfig
|   |-- drivers-pci-pci.c:error:implicit-declaration-of-function-pci_restore_ltr_state
|   |-- drivers-pci-pci.c:error:static-declaration-of-pci_restore_ltr_state-follows-non-static-declaration
|   `-- drivers-pci-pci.c:warning:conflicting-types-for-pci_restore_ltr_state
|-- ia64-randconfig-r021-20210219
|   `-- drivers-pci-pci.c:warning:conflicting-types-for-pci_restore_ltr_state
|-- ia64-randconfig-r026-20210219
|   `-- drivers-pci-pci.c:warning:conflicting-types-for-pci_restore_ltr_state
|-- ia64-randconfig-s031-20210219
|   `-- drivers-pci-pci.c:warning:conflicting-types-for-pci_restore_ltr_state
|-- mips-allmodconfig
|   `-- drivers-pci-pci.c:warning:conflicting-types-for-pci_restore_ltr_state
|-- mips-allyesconfig
|   `-- drivers-pci-pci.c:warning:conflicting-types-for-pci_restore_ltr_state
|-- parisc-allyesconfig
|   `-- drivers-pci-pci.c:warning:conflicting-types-for-pci_restore_ltr_state
|-- parisc-defconfig
|   `-- drivers-pci-pci.c:warning:conflicting-types-for-pci_restore_ltr_state
|-- parisc-randconfig-r001-20210219
|   |-- drivers-pci-pci.c:error:implicit-declaration-of-function-pci_restore_ltr_state
|   |-- drivers-pci-pci.c:error:static-declaration-of-pci_restore_ltr_state-follows-non-static-declaration
|   `-- drivers-pci-pci.c:warning:conflicting-types-for-pci_restore_ltr_state
|-- powerpc-allmodconfig
|   |-- drivers-pci-pci.c:error:implicit-declaration-of-function-pci_restore_ltr_state
|   |-- drivers-pci-pci.c:error:static-declaration-of-pci_restore_ltr_state-follows-non-static-declaration
|   `-- drivers-pci-pci.c:warning:conflicting-types-for-pci_restore_ltr_state
|-- powerpc-allyesconfig
|   |-- drivers-pci-pci.c:error:implicit-declaration-of-function-pci_restore_ltr_state
|   |-- drivers-pci-pci.c:error:static-declaration-of-pci_restore_ltr_state-follows-non-static-declaration
|   `-- drivers-pci-pci.c:warning:conflicting-types-for-pci_restore_ltr_state
|-- powerpc-randconfig-r014-20210219
|   `-- drivers-pci-pci.c:warning:conflicting-types-for-pci_restore_ltr_state
|-- riscv-allmodconfig
|   `-- drivers-pci-pci.c:warning:conflicting-types-for-pci_restore_ltr_state
|-- riscv-allyesconfig
|   `-- drivers-pci-pci.c:warning:conflicting-types-for-pci_restore_ltr_state
|-- riscv-defconfig
|   `-- drivers-pci-pci.c:warning:conflicting-types-for-pci_restore_ltr_state
|-- riscv-rv32_defconfig
|   `-- drivers-pci-pci.c:warning:conflicting-types-for-pci_restore_ltr_state
|-- s390-allyesconfig
|   `-- drivers-pci-pci.c:warning:conflicting-types-for-pci_restore_ltr_state
|-- s390-defconfig
|   `-- drivers-pci-pci.c:warning:conflicting-types-for-pci_restore_ltr_state
|-- sparc-allyesconfig
|   `-- drivers-pci-pci.c:warning:conflicting-types-for-pci_restore_ltr_state
|-- sparc-defconfig
|   `-- drivers-pci-pci.c:warning:conflicting-types-for-pci_restore_ltr_state
|-- sparc64-randconfig-r022-20210219
|   `-- drivers-pci-pci.c:warning:conflicting-types-for-pci_restore_ltr_state
|-- x86_64-randconfig-a011-20210219
|   `-- drivers-pci-pci.c:warning:conflicting-types-for-pci_restore_ltr_state
|-- x86_64-randconfig-a012-20210219
|   `-- drivers-pci-pci.c:warning:conflicting-types-for-pci_restore_ltr_state
|-- x86_64-randconfig-a013-20210219
|   `-- drivers-pci-pci.c:warning:conflicting-types-for-pci_restore_ltr_state
|-- x86_64-randconfig-a014-20210219
|   `-- drivers-pci-pci.c:warning:conflicting-types-for-pci_restore_ltr_state
|-- x86_64-randconfig-a015-20210219
|   `-- drivers-pci-pci.c:warning:conflicting-types-for-pci_restore_ltr_state
|-- x86_64-randconfig-a016-20210219
|   `-- drivers-pci-pci.c:warning:conflicting-types-for-pci_restore_ltr_state
|-- x86_64-randconfig-c002-20210219
|   `-- drivers-pci-pci.c:warning:conflicting-types-for-pci_restore_ltr_state
|-- x86_64-randconfig-m001-20210219
|   `-- drivers-pci-pci.c:warning:conflicting-types-for-pci_restore_ltr_state
|-- x86_64-randconfig-r011-20210219
|   `-- drivers-pci-pci.c:warning:conflicting-types-for-pci_restore_ltr_state
|-- x86_64-randconfig-s021-20210219
|   `-- drivers-pci-pci.c:warning:conflicting-types-for-pci_restore_ltr_state
|-- x86_64-randconfig-s022-20210219
|   `-- drivers-pci-pci.c:warning:conflicting-types-for-pci_restore_ltr_state
|-- xtensa-allyesconfig
|   `-- drivers-pci-pci.c:warning:conflicting-types-for-pci_restore_ltr_state
|-- xtensa-randconfig-s032-20210219
|   `-- drivers-pci-pci.c:warning:conflicting-types-for-pci_restore_ltr_state
`-- xtensa-virt_defconfig
    `-- drivers-pci-pci.c:warning:conflicting-types-for-pci_restore_ltr_state

clang_recent_errors
|-- powerpc64-randconfig-r003-20210219
|   `-- drivers-pci-pci.c:error:implicit-declaration-of-function-pci_restore_ltr_state-Werror-Wimplicit-function-declaration
|-- x86_64-randconfig-a001-20210219
|   `-- drivers-pci-pci.c:error:implicit-declaration-of-function-pci_restore_ltr_state-Werror-Wimplicit-function-declaration
|-- x86_64-randconfig-a002-20210219
|   `-- drivers-pci-pci.c:error:implicit-declaration-of-function-pci_restore_ltr_state-Werror-Wimplicit-function-declaration
|-- x86_64-randconfig-a003-20210219
|   `-- drivers-pci-pci.c:error:implicit-declaration-of-function-pci_restore_ltr_state-Werror-Wimplicit-function-declaration
|-- x86_64-randconfig-a004-20210219
|   `-- drivers-pci-pci.c:error:implicit-declaration-of-function-pci_restore_ltr_state-Werror-Wimplicit-function-declaration
|-- x86_64-randconfig-a005-20210219
|   `-- drivers-pci-pci.c:error:implicit-declaration-of-function-pci_restore_ltr_state-Werror-Wimplicit-function-declaration
|-- x86_64-randconfig-a006-20210219
|   `-- drivers-pci-pci.c:error:implicit-declaration-of-function-pci_restore_ltr_state-Werror-Wimplicit-function-declaration
`-- x86_64-randconfig-r032-20210219
    `-- drivers-pci-pci.c:error:implicit-declaration-of-function-pci_restore_ltr_state-Werror-Wimplicit-function-declaration

elapsed time: 722m

configs tested: 96
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                             espt_defconfig
arm                          pcm027_defconfig
mips                      pistachio_defconfig
arm                  colibri_pxa270_defconfig
sh                            migor_defconfig
arm                          pxa910_defconfig
powerpc                 mpc836x_rdk_defconfig
mips                       bmips_be_defconfig
sh                          rsk7201_defconfig
mips                         rt305x_defconfig
arm                       omap2plus_defconfig
powerpc                    amigaone_defconfig
sparc64                          alldefconfig
mips                          rb532_defconfig
xtensa                         virt_defconfig
arm                           corgi_defconfig
m68k                        mvme16x_defconfig
sh                   sh7770_generic_defconfig
arm                            hisi_defconfig
ia64                            zx1_defconfig
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
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a005-20210219
i386                 randconfig-a003-20210219
i386                 randconfig-a002-20210219
i386                 randconfig-a004-20210219
i386                 randconfig-a001-20210219
i386                 randconfig-a006-20210219
x86_64               randconfig-a012-20210219
x86_64               randconfig-a016-20210219
x86_64               randconfig-a013-20210219
x86_64               randconfig-a015-20210219
x86_64               randconfig-a011-20210219
x86_64               randconfig-a014-20210219
i386                 randconfig-a016-20210219
i386                 randconfig-a012-20210219
i386                 randconfig-a014-20210219
i386                 randconfig-a013-20210219
i386                 randconfig-a011-20210219
i386                 randconfig-a015-20210219
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a003-20210219
x86_64               randconfig-a001-20210219
x86_64               randconfig-a004-20210219
x86_64               randconfig-a002-20210219
x86_64               randconfig-a005-20210219
x86_64               randconfig-a006-20210219

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
