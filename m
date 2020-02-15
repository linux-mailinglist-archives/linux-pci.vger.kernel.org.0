Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A576160121
	for <lists+linux-pci@lfdr.de>; Sun, 16 Feb 2020 00:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbgBOXai (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 15 Feb 2020 18:30:38 -0500
Received: from mga06.intel.com ([134.134.136.31]:59401 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbgBOXai (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 15 Feb 2020 18:30:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Feb 2020 15:30:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,446,1574150400"; 
   d="scan'208";a="253021174"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 15 Feb 2020 15:30:35 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1j36tO-000BQW-OX; Sun, 16 Feb 2020 07:30:34 +0800
Date:   Sun, 16 Feb 2020 07:29:43 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:review/02-13-yicong-speed-v3] BUILD REGRESSION
 9c8d73d64b759ca8e0702b038d479bf49e87b73c
Message-ID: <5e487ee7.lOkk8mDzWylEn16z%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git  review/02-13-yicong-speed-v3
branch HEAD: 9c8d73d64b759ca8e0702b038d479bf49e87b73c  PCI: Reduce redundancy in current_link_speed_show()

Regressions in current branch:

drivers/pci/controller/pcie-brcmstb.c:826:16: warning: format '%s' expects argument of type 'char *', but argument 3 has type 'int' [-Wformat=]
drivers/pci/controller/pcie-brcmstb.c:826:2: note: in expansion of macro 'dev_info'
drivers/pci/controller/pcie-brcmstb.c:827:4: error: implicit declaration of function 'PCIE_SPEED2STR'; did you mean 'PCI_SPEED2STR'? [-Werror=implicit-function-declaration]

Error ids grouped by kconfigs:

recent_errors
|-- alpha-allmodconfig
|   |-- drivers-pci-controller-pcie-brcmstb.c:error:implicit-declaration-of-function-PCIE_SPEED2STR-did-you-mean-PCI_SPEED2STR
|   |-- drivers-pci-controller-pcie-brcmstb.c:note:in-expansion-of-macro-dev_info
|   `-- drivers-pci-controller-pcie-brcmstb.c:warning:format-s-expects-argument-of-type-char-but-argument-has-type-int
|-- arm-allmodconfig
|   |-- drivers-pci-controller-pcie-brcmstb.c:error:implicit-declaration-of-function-PCIE_SPEED2STR-did-you-mean-PCI_SPEED2STR
|   |-- drivers-pci-controller-pcie-brcmstb.c:note:in-expansion-of-macro-dev_info
|   `-- drivers-pci-controller-pcie-brcmstb.c:warning:format-s-expects-argument-of-type-char-but-argument-has-type-int
|-- arm-allyesconfig
|   |-- drivers-pci-controller-pcie-brcmstb.c:error:implicit-declaration-of-function-PCIE_SPEED2STR-did-you-mean-PCI_SPEED2STR
|   |-- drivers-pci-controller-pcie-brcmstb.c:note:in-expansion-of-macro-dev_info
|   `-- drivers-pci-controller-pcie-brcmstb.c:warning:format-s-expects-argument-of-type-char-but-argument-has-type-int
|-- arm64-allmodconfig
|   |-- drivers-pci-controller-pcie-brcmstb.c:error:implicit-declaration-of-function-PCIE_SPEED2STR-did-you-mean-PCI_SPEED2STR
|   |-- drivers-pci-controller-pcie-brcmstb.c:note:in-expansion-of-macro-dev_info
|   `-- drivers-pci-controller-pcie-brcmstb.c:warning:format-s-expects-argument-of-type-char-but-argument-has-type-int
|-- arm64-allyesconfig
|   |-- drivers-pci-controller-pcie-brcmstb.c:error:implicit-declaration-of-function-PCIE_SPEED2STR-did-you-mean-PCI_SPEED2STR
|   |-- drivers-pci-controller-pcie-brcmstb.c:note:in-expansion-of-macro-dev_info
|   `-- drivers-pci-controller-pcie-brcmstb.c:warning:format-s-expects-argument-of-type-char-but-argument-has-type-int
|-- arm64-defconfig
|   |-- drivers-pci-controller-pcie-brcmstb.c:error:implicit-declaration-of-function-PCIE_SPEED2STR-did-you-mean-PCI_SPEED2STR
|   |-- drivers-pci-controller-pcie-brcmstb.c:note:in-expansion-of-macro-dev_info
|   `-- drivers-pci-controller-pcie-brcmstb.c:warning:format-s-expects-argument-of-type-char-but-argument-has-type-int
|-- arm64-randconfig-a001-20200213
|   |-- drivers-pci-controller-pcie-brcmstb.c:error:implicit-declaration-of-function-PCIE_SPEED2STR-did-you-mean-PCI_SPEED2STR
|   |-- drivers-pci-controller-pcie-brcmstb.c:note:in-expansion-of-macro-dev_info
|   `-- drivers-pci-controller-pcie-brcmstb.c:warning:format-s-expects-argument-of-type-char-but-argument-has-type-int
|-- i386-allmodconfig
|   |-- drivers-pci-controller-pcie-brcmstb.c:error:implicit-declaration-of-function-PCIE_SPEED2STR-did-you-mean-PCI_SPEED2STR
|   |-- drivers-pci-controller-pcie-brcmstb.c:note:in-expansion-of-macro-dev_info
|   `-- drivers-pci-controller-pcie-brcmstb.c:warning:format-s-expects-argument-of-type-char-but-argument-has-type-int
|-- i386-allyesconfig
|   |-- drivers-pci-controller-pcie-brcmstb.c:error:implicit-declaration-of-function-PCIE_SPEED2STR-did-you-mean-PCI_SPEED2STR
|   |-- drivers-pci-controller-pcie-brcmstb.c:note:in-expansion-of-macro-dev_info
|   `-- drivers-pci-controller-pcie-brcmstb.c:warning:format-s-expects-argument-of-type-char-but-argument-has-type-int
|-- ia64-allmodconfig
|   |-- drivers-pci-controller-pcie-brcmstb.c:error:implicit-declaration-of-function-PCIE_SPEED2STR-did-you-mean-PCI_SPEED2STR
|   |-- drivers-pci-controller-pcie-brcmstb.c:note:in-expansion-of-macro-dev_info
|   `-- drivers-pci-controller-pcie-brcmstb.c:warning:format-s-expects-argument-of-type-char-but-argument-has-type-int
|-- ia64-allyesconfig
|   |-- drivers-pci-controller-pcie-brcmstb.c:error:implicit-declaration-of-function-PCIE_SPEED2STR-did-you-mean-PCI_SPEED2STR
|   |-- drivers-pci-controller-pcie-brcmstb.c:note:in-expansion-of-macro-dev_info
|   `-- drivers-pci-controller-pcie-brcmstb.c:warning:format-s-expects-argument-of-type-char-but-argument-has-type-int
|-- mips-allmodconfig
|   |-- drivers-pci-controller-pcie-brcmstb.c:error:implicit-declaration-of-function-PCIE_SPEED2STR-did-you-mean-PCI_SPEED2STR
|   |-- drivers-pci-controller-pcie-brcmstb.c:note:in-expansion-of-macro-dev_info
|   `-- drivers-pci-controller-pcie-brcmstb.c:warning:format-s-expects-argument-of-type-char-but-argument-has-type-int
|-- mips-allyesconfig
|   |-- drivers-pci-controller-pcie-brcmstb.c:error:implicit-declaration-of-function-PCIE_SPEED2STR-did-you-mean-PCI_SPEED2STR
|   |-- drivers-pci-controller-pcie-brcmstb.c:note:in-expansion-of-macro-dev_info
|   `-- drivers-pci-controller-pcie-brcmstb.c:warning:format-s-expects-argument-of-type-char-but-argument-has-type-int
|-- parisc-allmodconfig
|   |-- drivers-pci-controller-pcie-brcmstb.c:error:implicit-declaration-of-function-PCIE_SPEED2STR-did-you-mean-PCI_SPEED2STR
|   |-- drivers-pci-controller-pcie-brcmstb.c:note:in-expansion-of-macro-dev_info
|   `-- drivers-pci-controller-pcie-brcmstb.c:warning:format-s-expects-argument-of-type-char-but-argument-has-type-int
|-- parisc-allyesconfig
|   |-- drivers-pci-controller-pcie-brcmstb.c:error:implicit-declaration-of-function-PCIE_SPEED2STR-did-you-mean-PCI_SPEED2STR
|   |-- drivers-pci-controller-pcie-brcmstb.c:note:in-expansion-of-macro-dev_info
|   `-- drivers-pci-controller-pcie-brcmstb.c:warning:format-s-expects-argument-of-type-char-but-argument-has-type-int
|-- riscv-allmodconfig
|   |-- drivers-pci-controller-pcie-brcmstb.c:error:implicit-declaration-of-function-PCIE_SPEED2STR-did-you-mean-PCI_SPEED2STR
|   |-- drivers-pci-controller-pcie-brcmstb.c:note:in-expansion-of-macro-dev_info
|   `-- drivers-pci-controller-pcie-brcmstb.c:warning:format-s-expects-argument-of-type-char-but-argument-has-type-int
|-- riscv-allyesconfig
|   |-- drivers-pci-controller-pcie-brcmstb.c:error:implicit-declaration-of-function-PCIE_SPEED2STR-did-you-mean-PCI_SPEED2STR
|   |-- drivers-pci-controller-pcie-brcmstb.c:note:in-expansion-of-macro-dev_info
|   `-- drivers-pci-controller-pcie-brcmstb.c:warning:format-s-expects-argument-of-type-char-but-argument-has-type-int
|-- s390-allmodconfig
|   |-- drivers-pci-controller-pcie-brcmstb.c:error:implicit-declaration-of-function-PCIE_SPEED2STR-did-you-mean-PCI_SPEED2STR
|   |-- drivers-pci-controller-pcie-brcmstb.c:note:in-expansion-of-macro-dev_info
|   `-- drivers-pci-controller-pcie-brcmstb.c:warning:format-s-expects-argument-of-type-char-but-argument-has-type-int
|-- s390-allyesconfig
|   |-- drivers-pci-controller-pcie-brcmstb.c:error:implicit-declaration-of-function-PCIE_SPEED2STR-did-you-mean-PCI_SPEED2STR
|   |-- drivers-pci-controller-pcie-brcmstb.c:note:in-expansion-of-macro-dev_info
|   `-- drivers-pci-controller-pcie-brcmstb.c:warning:format-s-expects-argument-of-type-char-but-argument-has-type-int
|-- sparc-allyesconfig
|   |-- drivers-pci-controller-pcie-brcmstb.c:error:implicit-declaration-of-function-PCIE_SPEED2STR-did-you-mean-PCI_SPEED2STR
|   |-- drivers-pci-controller-pcie-brcmstb.c:note:in-expansion-of-macro-dev_info
|   `-- drivers-pci-controller-pcie-brcmstb.c:warning:format-s-expects-argument-of-type-char-but-argument-has-type-int
|-- sparc64-allmodconfig
|   |-- drivers-pci-controller-pcie-brcmstb.c:error:implicit-declaration-of-function-PCIE_SPEED2STR-did-you-mean-PCI_SPEED2STR
|   |-- drivers-pci-controller-pcie-brcmstb.c:note:in-expansion-of-macro-dev_info
|   `-- drivers-pci-controller-pcie-brcmstb.c:warning:format-s-expects-argument-of-type-char-but-argument-has-type-int
|-- sparc64-allyesconfig
|   |-- drivers-pci-controller-pcie-brcmstb.c:error:implicit-declaration-of-function-PCIE_SPEED2STR-did-you-mean-PCI_SPEED2STR
|   |-- drivers-pci-controller-pcie-brcmstb.c:note:in-expansion-of-macro-dev_info
|   `-- drivers-pci-controller-pcie-brcmstb.c:warning:format-s-expects-argument-of-type-char-but-argument-has-type-int
|-- x86_64-allmodconfig
|   |-- drivers-pci-controller-pcie-brcmstb.c:error:implicit-declaration-of-function-PCIE_SPEED2STR-did-you-mean-PCI_SPEED2STR
|   |-- drivers-pci-controller-pcie-brcmstb.c:note:in-expansion-of-macro-dev_info
|   `-- drivers-pci-controller-pcie-brcmstb.c:warning:format-s-expects-argument-of-type-char-but-argument-has-type-int
|-- x86_64-allyesconfig
|   |-- drivers-pci-controller-pcie-brcmstb.c:error:implicit-declaration-of-function-PCIE_SPEED2STR-did-you-mean-PCI_SPEED2STR
|   |-- drivers-pci-controller-pcie-brcmstb.c:note:in-expansion-of-macro-dev_info
|   `-- drivers-pci-controller-pcie-brcmstb.c:warning:format-s-expects-argument-of-type-char-but-argument-has-type-int
|-- x86_64-randconfig-f002-20200214
|   |-- drivers-pci-controller-pcie-brcmstb.c:error:implicit-declaration-of-function-PCIE_SPEED2STR-did-you-mean-PCI_SPEED2STR
|   |-- drivers-pci-controller-pcie-brcmstb.c:note:in-expansion-of-macro-dev_info
|   `-- drivers-pci-controller-pcie-brcmstb.c:warning:format-s-expects-argument-of-type-char-but-argument-has-type-int
`-- xtensa-allyesconfig
    |-- drivers-pci-controller-pcie-brcmstb.c:error:implicit-declaration-of-function-PCIE_SPEED2STR-did-you-mean-PCI_SPEED2STR
    |-- drivers-pci-controller-pcie-brcmstb.c:note:in-expansion-of-macro-dev_info
    `-- drivers-pci-controller-pcie-brcmstb.c:warning:format-s-expects-argument-of-type-char-but-argument-has-type-int

elapsed time: 2885m

configs tested: 244
configs skipped: 0

arm                              allmodconfig
arm                               allnoconfig
arm                              allyesconfig
arm                         at91_dt_defconfig
arm                           efm32_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm                           sunxi_defconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm64                            allyesconfig
arm64                               defconfig
sparc                            allyesconfig
powerpc                             defconfig
i386                                defconfig
nds32                               defconfig
powerpc                           allnoconfig
arc                              allyesconfig
m68k                           sun3_defconfig
s390                                defconfig
arc                                 defconfig
m68k                       m5475evb_defconfig
microblaze                      mmu_defconfig
ia64                                defconfig
um                           x86_64_defconfig
parisc                           allyesconfig
mips                              allnoconfig
nds32                             allnoconfig
s390                             alldefconfig
alpha                               defconfig
mips                             allmodconfig
mips                             allyesconfig
sh                  sh7785lcr_32bit_defconfig
ia64                             alldefconfig
openrisc                    or1ksim_defconfig
m68k                          multi_defconfig
riscv                            allyesconfig
riscv                               defconfig
s390                             allmodconfig
s390                              allnoconfig
i386                             alldefconfig
i386                              allnoconfig
i386                             allyesconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
c6x                              allyesconfig
c6x                        evmc6678_defconfig
nios2                         10m50_defconfig
nios2                         3c120_defconfig
openrisc                 simple_smp_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
csky                                defconfig
h8300                     edosk2674_defconfig
h8300                    h8300h-sim_defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
microblaze                    nommu_defconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
parisc                            allnoconfig
parisc                generic-32bit_defconfig
parisc                generic-64bit_defconfig
x86_64               randconfig-a001-20200214
x86_64               randconfig-a002-20200214
x86_64               randconfig-a003-20200214
i386                 randconfig-a001-20200214
i386                 randconfig-a002-20200214
i386                 randconfig-a003-20200214
x86_64               randconfig-a001-20200215
x86_64               randconfig-a002-20200215
x86_64               randconfig-a003-20200215
i386                 randconfig-a001-20200215
i386                 randconfig-a002-20200215
i386                 randconfig-a003-20200215
alpha                randconfig-a001-20200214
m68k                 randconfig-a001-20200214
mips                 randconfig-a001-20200214
nds32                randconfig-a001-20200214
parisc               randconfig-a001-20200214
riscv                randconfig-a001-20200214
c6x                  randconfig-a001-20200213
h8300                randconfig-a001-20200213
microblaze           randconfig-a001-20200213
nios2                randconfig-a001-20200213
sparc64              randconfig-a001-20200213
c6x                  randconfig-a001-20200214
h8300                randconfig-a001-20200214
microblaze           randconfig-a001-20200214
nios2                randconfig-a001-20200214
sparc64              randconfig-a001-20200214
c6x                  randconfig-a001-20200215
h8300                randconfig-a001-20200215
microblaze           randconfig-a001-20200215
nios2                randconfig-a001-20200215
sparc64              randconfig-a001-20200215
csky                 randconfig-a001-20200214
openrisc             randconfig-a001-20200214
s390                 randconfig-a001-20200214
sh                   randconfig-a001-20200214
xtensa               randconfig-a001-20200214
csky                 randconfig-a001-20200215
openrisc             randconfig-a001-20200215
s390                 randconfig-a001-20200215
sh                   randconfig-a001-20200215
xtensa               randconfig-a001-20200215
csky                 randconfig-a001-20200213
openrisc             randconfig-a001-20200213
s390                 randconfig-a001-20200213
sh                   randconfig-a001-20200213
xtensa               randconfig-a001-20200213
x86_64               randconfig-b001-20200214
x86_64               randconfig-b002-20200214
x86_64               randconfig-b003-20200214
i386                 randconfig-b001-20200214
i386                 randconfig-b002-20200214
i386                 randconfig-b003-20200214
x86_64               randconfig-b002-20200213
i386                 randconfig-b002-20200213
x86_64               randconfig-b001-20200213
i386                 randconfig-b001-20200213
i386                 randconfig-b003-20200213
x86_64               randconfig-b003-20200213
i386                 randconfig-c002-20200213
x86_64               randconfig-c003-20200213
i386                 randconfig-c001-20200213
x86_64               randconfig-c002-20200213
x86_64               randconfig-c001-20200213
i386                 randconfig-c003-20200213
x86_64               randconfig-c001-20200214
x86_64               randconfig-c002-20200214
x86_64               randconfig-c003-20200214
i386                 randconfig-c001-20200214
i386                 randconfig-c002-20200214
i386                 randconfig-c003-20200214
x86_64               randconfig-d001-20200213
x86_64               randconfig-d002-20200213
x86_64               randconfig-d003-20200213
i386                 randconfig-d001-20200213
i386                 randconfig-d002-20200213
i386                 randconfig-d003-20200213
x86_64               randconfig-d001-20200214
x86_64               randconfig-d002-20200214
x86_64               randconfig-d003-20200214
i386                 randconfig-d001-20200214
i386                 randconfig-d002-20200214
i386                 randconfig-d003-20200214
i386                 randconfig-e001-20200214
i386                 randconfig-e003-20200214
x86_64               randconfig-e001-20200214
x86_64               randconfig-e002-20200214
x86_64               randconfig-e003-20200214
i386                 randconfig-e002-20200214
x86_64               randconfig-f001-20200214
x86_64               randconfig-f002-20200214
x86_64               randconfig-f003-20200214
i386                 randconfig-f001-20200214
i386                 randconfig-f002-20200214
i386                 randconfig-f003-20200214
x86_64               randconfig-f001-20200213
x86_64               randconfig-f002-20200213
x86_64               randconfig-f003-20200213
i386                 randconfig-f001-20200213
i386                 randconfig-f002-20200213
i386                 randconfig-f003-20200213
x86_64               randconfig-g001-20200214
x86_64               randconfig-g002-20200214
x86_64               randconfig-g003-20200214
i386                 randconfig-g001-20200214
i386                 randconfig-g002-20200214
i386                 randconfig-g003-20200214
x86_64               randconfig-g001-20200213
x86_64               randconfig-g002-20200213
x86_64               randconfig-g003-20200213
i386                 randconfig-g001-20200213
i386                 randconfig-g002-20200213
i386                 randconfig-g003-20200213
x86_64               randconfig-g001-20200215
x86_64               randconfig-g002-20200215
x86_64               randconfig-g003-20200215
i386                 randconfig-g001-20200215
i386                 randconfig-g002-20200215
i386                 randconfig-g003-20200215
x86_64               randconfig-h001-20200214
x86_64               randconfig-h002-20200214
x86_64               randconfig-h003-20200214
i386                 randconfig-h001-20200214
i386                 randconfig-h002-20200214
i386                 randconfig-h003-20200214
x86_64               randconfig-h001-20200213
x86_64               randconfig-h002-20200213
x86_64               randconfig-h003-20200213
i386                 randconfig-h001-20200213
i386                 randconfig-h002-20200213
i386                 randconfig-h003-20200213
arc                  randconfig-a001-20200214
sparc                randconfig-a001-20200214
ia64                 randconfig-a001-20200214
arm                  randconfig-a001-20200214
arm64                randconfig-a001-20200214
arc                  randconfig-a001-20200215
arm                  randconfig-a001-20200215
arm64                randconfig-a001-20200215
ia64                 randconfig-a001-20200215
powerpc              randconfig-a001-20200215
sparc                randconfig-a001-20200215
powerpc              randconfig-a001-20200214
arc                  randconfig-a001-20200213
arm                  randconfig-a001-20200213
arm64                randconfig-a001-20200213
ia64                 randconfig-a001-20200213
powerpc              randconfig-a001-20200213
sparc                randconfig-a001-20200213
riscv                            allmodconfig
riscv                             allnoconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
s390                             allyesconfig
s390                          debug_defconfig
s390                       zfcpdump_defconfig
sh                               allmodconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                            titan_defconfig
sparc                               defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                             defconfig
um                                  defconfig
um                             i386_defconfig
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                         rhel-7.2-clear
x86_64                               rhel-7.6

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
