Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD447434FF8
	for <lists+linux-pci@lfdr.de>; Wed, 20 Oct 2021 18:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbhJTQTd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Oct 2021 12:19:33 -0400
Received: from mga07.intel.com ([134.134.136.100]:59808 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231248AbhJTQTb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 20 Oct 2021 12:19:31 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10143"; a="292285870"
X-IronPort-AV: E=Sophos;i="5.87,167,1631602800"; 
   d="scan'208";a="292285870"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2021 09:14:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,167,1631602800"; 
   d="scan'208";a="662300493"
Received: from lkp-server02.sh.intel.com (HELO 08b2c502c3de) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 20 Oct 2021 09:14:51 -0700
Received: from kbuild by 08b2c502c3de with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mdEEs-000DUf-F3; Wed, 20 Oct 2021 16:14:50 +0000
Date:   Thu, 21 Oct 2021 00:14:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [helgaas-pci:for-linus] BUILD REGRESSION
 f10507a66e36dde76d71bef8ce6e1c873f441616
Message-ID: <6170404f.Q0waqc1ZszRArrtv%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git for-linus
branch HEAD: f10507a66e36dde76d71bef8ce6e1c873f441616  x86/PCI: Ignore E820 reservations for bridge windows on newer systems

Error/Warning reports:

https://lore.kernel.org/llvm/202110201321.kUDqiXb2-lkp@intel.com
https://lore.kernel.org/llvm/202110201327.fsAja7hq-lkp@intel.com

Error/Warning in current branch:

arch/x86/include/asm/pci_x86.h:135:19: error: expected ';' after top level declarator
arch/x86/include/asm/pci_x86.h:140:12: error: redeclaration of '__init' with a different type: 'int' vs 'void'
arch/x86/include/asm/pci_x86.h:142:8: warning: '__gnu_inline__' attribute only applies to functions [-Wignored-attributes]
arch/x86/include/asm/pci_x86.h:142:8: warning: '__no_instrument_function__' attribute only applies to functions and Objective-C methods [-Wignored-attributes]
arch/x86/include/asm/pci_x86.h:176:33: error: redeclaration of '__init' with a different type: 'struct pci_mmcfg_region *' vs 'void'
arch/x86/include/asm/pci_x86.h:99:8: error: unknown type name 'raw_spinlock_t'

possible Error/Warning in current branch (please contact us if interested):

arch/x86/include/asm/pci_x86.h:142:20: error: redefinition of '__init' with a different type: 'int' vs 'void'
arch/x86/include/asm/pci_x86.h:142:8: error: 'inline' can only appear on functions
arch/x86/include/asm/pci_x86.h:148:12: error: redeclaration of '__init' with a different type: 'int' vs 'void'
arch/x86/include/asm/pci_x86.h:163:33: error: redeclaration of '__init' with a different type: 'struct pci_mmcfg_region *' vs 'void'

Error/Warning ids grouped by kconfigs:

clang_recent_errors
|-- i386-buildonly-randconfig-r004-20211019
|   |-- arch-x86-include-asm-pci_x86.h:error:expected-after-top-level-declarator
|   |-- arch-x86-include-asm-pci_x86.h:error:inline-can-only-appear-on-functions
|   |-- arch-x86-include-asm-pci_x86.h:error:redeclaration-of-__init-with-a-different-type:int-vs-void
|   |-- arch-x86-include-asm-pci_x86.h:error:redeclaration-of-__init-with-a-different-type:struct-pci_mmcfg_region-vs-void
|   |-- arch-x86-include-asm-pci_x86.h:error:redefinition-of-__init-with-a-different-type:int-vs-void
|   |-- arch-x86-include-asm-pci_x86.h:error:unknown-type-name-raw_spinlock_t
|   |-- arch-x86-include-asm-pci_x86.h:warning:__gnu_inline__-attribute-only-applies-to-functions
|   `-- arch-x86-include-asm-pci_x86.h:warning:__no_instrument_function__-attribute-only-applies-to-functions-and-Objective-C-methods
|-- i386-buildonly-randconfig-r006-20211019
|   |-- arch-x86-include-asm-pci_x86.h:error:expected-after-top-level-declarator
|   |-- arch-x86-include-asm-pci_x86.h:error:redeclaration-of-__init-with-a-different-type:int-vs-void
|   |-- arch-x86-include-asm-pci_x86.h:error:redeclaration-of-__init-with-a-different-type:struct-pci_mmcfg_region-vs-void
|   `-- arch-x86-include-asm-pci_x86.h:error:unknown-type-name-raw_spinlock_t
|-- i386-randconfig-a001-20211019
|   |-- arch-x86-include-asm-pci_x86.h:error:expected-after-top-level-declarator
|   |-- arch-x86-include-asm-pci_x86.h:error:redeclaration-of-__init-with-a-different-type:int-vs-void
|   |-- arch-x86-include-asm-pci_x86.h:error:redeclaration-of-__init-with-a-different-type:struct-pci_mmcfg_region-vs-void
|   `-- arch-x86-include-asm-pci_x86.h:error:unknown-type-name-raw_spinlock_t
|-- i386-randconfig-a002-20211019
|   |-- arch-x86-include-asm-pci_x86.h:error:expected-after-top-level-declarator
|   |-- arch-x86-include-asm-pci_x86.h:error:redeclaration-of-__init-with-a-different-type:int-vs-void
|   |-- arch-x86-include-asm-pci_x86.h:error:redeclaration-of-__init-with-a-different-type:struct-pci_mmcfg_region-vs-void
|   `-- arch-x86-include-asm-pci_x86.h:error:unknown-type-name-raw_spinlock_t
|-- i386-randconfig-a003-20211019
|   |-- arch-x86-include-asm-pci_x86.h:error:expected-after-top-level-declarator
|   |-- arch-x86-include-asm-pci_x86.h:error:redeclaration-of-__init-with-a-different-type:int-vs-void
|   |-- arch-x86-include-asm-pci_x86.h:error:redeclaration-of-__init-with-a-different-type:struct-pci_mmcfg_region-vs-void
|   `-- arch-x86-include-asm-pci_x86.h:error:unknown-type-name-raw_spinlock_t
|-- i386-randconfig-a004-20211019
|   |-- arch-x86-include-asm-pci_x86.h:error:expected-after-top-level-declarator
|   |-- arch-x86-include-asm-pci_x86.h:error:redeclaration-of-__init-with-a-different-type:int-vs-void
|   |-- arch-x86-include-asm-pci_x86.h:error:redeclaration-of-__init-with-a-different-type:struct-pci_mmcfg_region-vs-void
|   `-- arch-x86-include-asm-pci_x86.h:error:unknown-type-name-raw_spinlock_t
|-- i386-randconfig-a005-20211019
|   |-- arch-x86-include-asm-pci_x86.h:error:expected-after-top-level-declarator
|   |-- arch-x86-include-asm-pci_x86.h:error:redeclaration-of-__init-with-a-different-type:int-vs-void
|   |-- arch-x86-include-asm-pci_x86.h:error:redeclaration-of-__init-with-a-different-type:struct-pci_mmcfg_region-vs-void
|   `-- arch-x86-include-asm-pci_x86.h:error:unknown-type-name-raw_spinlock_t
|-- i386-randconfig-a006-20211019
|   |-- arch-x86-include-asm-pci_x86.h:error:expected-after-top-level-declarator
|   |-- arch-x86-include-asm-pci_x86.h:error:redeclaration-of-__init-with-a-different-type:int-vs-void
|   |-- arch-x86-include-asm-pci_x86.h:error:redeclaration-of-__init-with-a-different-type:struct-pci_mmcfg_region-vs-void
|   `-- arch-x86-include-asm-pci_x86.h:error:unknown-type-name-raw_spinlock_t
|-- i386-randconfig-c001-20211019
|   |-- arch-x86-include-asm-pci_x86.h:error:expected-after-top-level-declarator
|   |-- arch-x86-include-asm-pci_x86.h:error:redeclaration-of-__init-with-a-different-type:int-vs-void
|   |-- arch-x86-include-asm-pci_x86.h:error:redeclaration-of-__init-with-a-different-type:struct-pci_mmcfg_region-vs-void
|   `-- arch-x86-include-asm-pci_x86.h:error:unknown-type-name-raw_spinlock_t
|-- i386-randconfig-r003-20211019
|   |-- arch-x86-include-asm-pci_x86.h:error:expected-after-top-level-declarator
|   |-- arch-x86-include-asm-pci_x86.h:error:redeclaration-of-__init-with-a-different-type:int-vs-void
|   |-- arch-x86-include-asm-pci_x86.h:error:redeclaration-of-__init-with-a-different-type:struct-pci_mmcfg_region-vs-void
|   `-- arch-x86-include-asm-pci_x86.h:error:unknown-type-name-raw_spinlock_t
|-- i386-randconfig-r005-20211019
|   |-- arch-x86-include-asm-pci_x86.h:error:expected-after-top-level-declarator
|   |-- arch-x86-include-asm-pci_x86.h:error:redeclaration-of-__init-with-a-different-type:int-vs-void
|   |-- arch-x86-include-asm-pci_x86.h:error:redeclaration-of-__init-with-a-different-type:struct-pci_mmcfg_region-vs-void
|   `-- arch-x86-include-asm-pci_x86.h:error:unknown-type-name-raw_spinlock_t
|-- i386-randconfig-r006-20211019
|   |-- arch-x86-include-asm-pci_x86.h:error:expected-after-top-level-declarator
|   |-- arch-x86-include-asm-pci_x86.h:error:redeclaration-of-__init-with-a-different-type:int-vs-void
|   |-- arch-x86-include-asm-pci_x86.h:error:redeclaration-of-__init-with-a-different-type:struct-pci_mmcfg_region-vs-void
|   `-- arch-x86-include-asm-pci_x86.h:error:unknown-type-name-raw_spinlock_t
|-- i386-randconfig-r032-20211019
|   |-- arch-x86-include-asm-pci_x86.h:error:expected-after-top-level-declarator
|   |-- arch-x86-include-asm-pci_x86.h:error:redeclaration-of-__init-with-a-different-type:int-vs-void
|   |-- arch-x86-include-asm-pci_x86.h:error:redeclaration-of-__init-with-a-different-type:struct-pci_mmcfg_region-vs-void
|   `-- arch-x86-include-asm-pci_x86.h:error:unknown-type-name-raw_spinlock_t
|-- x86_64-buildonly-randconfig-r001-20211019
|   |-- arch-x86-include-asm-pci_x86.h:error:expected-after-top-level-declarator
|   |-- arch-x86-include-asm-pci_x86.h:error:inline-can-only-appear-on-functions
|   |-- arch-x86-include-asm-pci_x86.h:error:redeclaration-of-__init-with-a-different-type:int-vs-void
|   |-- arch-x86-include-asm-pci_x86.h:error:redeclaration-of-__init-with-a-different-type:struct-pci_mmcfg_region-vs-void
|   |-- arch-x86-include-asm-pci_x86.h:error:redefinition-of-__init-with-a-different-type:int-vs-void
|   |-- arch-x86-include-asm-pci_x86.h:error:unknown-type-name-raw_spinlock_t
|   |-- arch-x86-include-asm-pci_x86.h:warning:__gnu_inline__-attribute-only-applies-to-functions
|   `-- arch-x86-include-asm-pci_x86.h:warning:__no_instrument_function__-attribute-only-applies-to-functions-and-Objective-C-methods
|-- x86_64-randconfig-a002-20211019
|   |-- arch-x86-include-asm-pci_x86.h:error:expected-after-top-level-declarator
|   |-- arch-x86-include-asm-pci_x86.h:error:redeclaration-of-__init-with-a-different-type:int-vs-void
|   |-- arch-x86-include-asm-pci_x86.h:error:redeclaration-of-__init-with-a-different-type:struct-pci_mmcfg_region-vs-void
|   `-- arch-x86-include-asm-pci_x86.h:error:unknown-type-name-raw_spinlock_t
|-- x86_64-randconfig-a003-20211019
|   |-- arch-x86-include-asm-pci_x86.h:error:expected-after-top-level-declarator
|   |-- arch-x86-include-asm-pci_x86.h:error:redeclaration-of-__init-with-a-different-type:int-vs-void
|   |-- arch-x86-include-asm-pci_x86.h:error:redeclaration-of-__init-with-a-different-type:struct-pci_mmcfg_region-vs-void
|   `-- arch-x86-include-asm-pci_x86.h:error:unknown-type-name-raw_spinlock_t
|-- x86_64-randconfig-a005-20211019
|   |-- arch-x86-include-asm-pci_x86.h:error:expected-after-top-level-declarator
|   |-- arch-x86-include-asm-pci_x86.h:error:redeclaration-of-__init-with-a-different-type:int-vs-void
|   |-- arch-x86-include-asm-pci_x86.h:error:redeclaration-of-__init-with-a-different-type:struct-pci_mmcfg_region-vs-void
|   `-- arch-x86-include-asm-pci_x86.h:error:unknown-type-name-raw_spinlock_t
|-- x86_64-randconfig-a006-20211019
|   |-- arch-x86-include-asm-pci_x86.h:error:expected-after-top-level-declarator
|   |-- arch-x86-include-asm-pci_x86.h:error:redeclaration-of-__init-with-a-different-type:int-vs-void
|   |-- arch-x86-include-asm-pci_x86.h:error:redeclaration-of-__init-with-a-different-type:struct-pci_mmcfg_region-vs-void
|   `-- arch-x86-include-asm-pci_x86.h:error:unknown-type-name-raw_spinlock_t
|-- x86_64-randconfig-c007-20211019
|   |-- arch-x86-include-asm-pci_x86.h:error:expected-after-top-level-declarator
|   |-- arch-x86-include-asm-pci_x86.h:error:redeclaration-of-__init-with-a-different-type:int-vs-void
|   |-- arch-x86-include-asm-pci_x86.h:error:redeclaration-of-__init-with-a-different-type:struct-pci_mmcfg_region-vs-void
|   `-- arch-x86-include-asm-pci_x86.h:error:unknown-type-name-raw_spinlock_t
`-- x86_64-randconfig-r003-20211019
    |-- arch-x86-include-asm-pci_x86.h:error:expected-after-top-level-declarator
    |-- arch-x86-include-asm-pci_x86.h:error:redeclaration-of-__init-with-a-different-type:int-vs-void
    |-- arch-x86-include-asm-pci_x86.h:error:redeclaration-of-__init-with-a-different-type:struct-pci_mmcfg_region-vs-void
    `-- arch-x86-include-asm-pci_x86.h:error:unknown-type-name-raw_spinlock_t

elapsed time: 1063m

configs tested: 126
configs skipped: 3

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allmodconfig
arm                              allyesconfig
i386                 randconfig-c001-20211019
sparc                            allyesconfig
powerpc                       maple_defconfig
m68k                        m5407c3_defconfig
arm                         lubbock_defconfig
mips                         tb0287_defconfig
powerpc                      ppc6xx_defconfig
arm                             ezx_defconfig
s390                             alldefconfig
sh                            shmin_defconfig
arm                       imx_v4_v5_defconfig
um                           x86_64_defconfig
powerpc                      mgcoge_defconfig
mips                        omega2p_defconfig
powerpc                     stx_gp3_defconfig
arm                            mps2_defconfig
arm                          collie_defconfig
parisc                generic-64bit_defconfig
sh                              ul2_defconfig
arc                     nsimosci_hs_defconfig
sh                          rsk7269_defconfig
sh                            titan_defconfig
powerpc                     skiroot_defconfig
powerpc                        icon_defconfig
powerpc                     pq2fads_defconfig
m68k                        m5307c3_defconfig
xtensa                  audio_kc705_defconfig
sh                           se7780_defconfig
powerpc                     tqm5200_defconfig
powerpc                      walnut_defconfig
powerpc                        fsp2_defconfig
arm                         palmz72_defconfig
arm                         s3c2410_defconfig
mips                      maltasmvp_defconfig
arm                  randconfig-c002-20211019
x86_64               randconfig-c001-20211019
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
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
sparc                               defconfig
i386                                defconfig
i386                             allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20211020
i386                 randconfig-a003-20211020
i386                 randconfig-a002-20211020
i386                 randconfig-a005-20211020
i386                 randconfig-a006-20211020
i386                 randconfig-a001-20211020
x86_64               randconfig-a015-20211019
x86_64               randconfig-a012-20211019
x86_64               randconfig-a016-20211019
x86_64               randconfig-a014-20211019
x86_64               randconfig-a013-20211019
x86_64               randconfig-a011-20211019
i386                 randconfig-a014-20211019
i386                 randconfig-a016-20211019
i386                 randconfig-a011-20211019
i386                 randconfig-a015-20211019
i386                 randconfig-a012-20211019
i386                 randconfig-a013-20211019
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
arm                  randconfig-c002-20211019
mips                 randconfig-c004-20211019
i386                 randconfig-c001-20211019
s390                 randconfig-c005-20211019
x86_64               randconfig-c007-20211019
riscv                randconfig-c006-20211019
powerpc              randconfig-c003-20211019
x86_64               randconfig-a004-20211019
x86_64               randconfig-a006-20211019
x86_64               randconfig-a005-20211019
x86_64               randconfig-a001-20211019
x86_64               randconfig-a002-20211019
x86_64               randconfig-a003-20211019
i386                 randconfig-a001-20211019
i386                 randconfig-a003-20211019
i386                 randconfig-a004-20211019
i386                 randconfig-a005-20211019
i386                 randconfig-a002-20211019
i386                 randconfig-a006-20211019
riscv                randconfig-r042-20211020
s390                 randconfig-r044-20211020
hexagon              randconfig-r045-20211020
hexagon              randconfig-r041-20211020
hexagon              randconfig-r041-20211019
hexagon              randconfig-r045-20211019

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
