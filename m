Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 497E517BC3F
	for <lists+linux-pci@lfdr.de>; Fri,  6 Mar 2020 13:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbgCFMBr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Mar 2020 07:01:47 -0500
Received: from mga01.intel.com ([192.55.52.88]:38721 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbgCFMBr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 6 Mar 2020 07:01:47 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Mar 2020 04:01:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,522,1574150400"; 
   d="scan'208";a="241151112"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 06 Mar 2020 04:01:44 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jABfj-000Ehd-A1; Fri, 06 Mar 2020 20:01:43 +0800
Date:   Fri, 06 Mar 2020 20:01:41 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:review/edr] BUILD REGRESSION
 a727dd2ed5e6e97a2bb4496336574bad365414cf
Message-ID: <5e623ba5.uxYW8Jc8iiAoUr6P%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git  review/edr
branch HEAD: a727dd2ed5e6e97a2bb4496336574bad365414cf  PCI/AER: Rationalize error status register clearing

Regressions in current branch:

(.text+0x17b0): multiple definition of `pci_aer_raw_clear_status'
(.text+0x1a28): multiple definition of `pci_aer_raw_clear_status'
bus.c:(.text+0x250): multiple definition of `pci_aer_raw_clear_status'
bus.c:(.text+0x338): multiple definition of `pci_aer_raw_clear_status'
bus.c:(.text+0x340): multiple definition of `pci_aer_raw_clear_status'
bus.c:(.text+0x354): multiple definition of `pci_aer_raw_clear_status'
bus.c:(.text+0x420): multiple definition of `pci_aer_raw_clear_status'
bus.c:(.text+0x44): multiple definition of `pci_aer_raw_clear_status'
bus.c:(.text+0x4a0): multiple definition of `pci_aer_raw_clear_status'
bus.c:(.text+0x4ec): multiple definition of `pci_aer_raw_clear_status'
bus.c:(.text+0xa60): multiple definition of `pci_aer_raw_clear_status'
drivers/pci/pci.h:664: multiple definition of `pci_aer_raw_clear_status'
drivers/pci/pci.h:664: multiple definition of `pci_aer_raw_clear_status'; drivers/pci/access.o:drivers/pci/pci.h:664: first defined here
drivers/pci/pci.h:667: multiple definition of `pci_aer_raw_clear_status'
drivers/pci/pci.h:667: multiple definition of `pci_aer_raw_clear_status'; drivers/pci/access.o:drivers/pci/pci.h:667: first defined here

Error ids grouped by kconfigs:

recent_errors
|-- alpha-randconfig-a001-20200306
|   `-- multiple-definition-of-pci_aer_raw_clear_status
|-- arm-ixp4xx_defconfig
|   `-- multiple-definition-of-pci_aer_raw_clear_status
|-- arm-mvebu_v7_defconfig
|   `-- multiple-definition-of-pci_aer_raw_clear_status
|-- i386-randconfig-a001-20200305
|   `-- multiple-definition-of-pci_aer_raw_clear_status-drivers-pci-access.o:drivers-pci-pci.h:first-defined-here
|-- i386-randconfig-a002-20200305
|   `-- multiple-definition-of-pci_aer_raw_clear_status-drivers-pci-access.o:drivers-pci-pci.h:first-defined-here
|-- i386-randconfig-a003-20200305
|   `-- multiple-definition-of-pci_aer_raw_clear_status-drivers-pci-access.o:drivers-pci-pci.h:first-defined-here
|-- i386-randconfig-b001-20200306
|   `-- multiple-definition-of-pci_aer_raw_clear_status-drivers-pci-access.o:drivers-pci-pci.h:first-defined-here
|-- i386-randconfig-b002-20200306
|   `-- multiple-definition-of-pci_aer_raw_clear_status-drivers-pci-access.o:drivers-pci-pci.h:first-defined-here
|-- i386-randconfig-b003-20200306
|   `-- multiple-definition-of-pci_aer_raw_clear_status-drivers-pci-access.o:drivers-pci-pci.h:first-defined-here
|-- i386-randconfig-e001-20200305
|   `-- multiple-definition-of-pci_aer_raw_clear_status-drivers-pci-access.o:drivers-pci-pci.h:first-defined-here
|-- ia64-alldefconfig
|   `-- multiple-definition-of-pci_aer_raw_clear_status
|-- ia64-allnoconfig
|   `-- multiple-definition-of-pci_aer_raw_clear_status
|-- ia64-defconfig
|   `-- multiple-definition-of-pci_aer_raw_clear_status
|-- microblaze-randconfig-a001-20200306
|   `-- multiple-definition-of-pci_aer_raw_clear_status
|-- mips-32r2_defconfig
|   `-- multiple-definition-of-pci_aer_raw_clear_status
|-- mips-64r6el_defconfig
|   `-- multiple-definition-of-pci_aer_raw_clear_status
|-- mips-malta_kvm_defconfig
|   `-- multiple-definition-of-pci_aer_raw_clear_status
|-- s390-debug_defconfig
|   `-- multiple-definition-of-pci_aer_raw_clear_status
|-- s390-defconfig
|   `-- multiple-definition-of-pci_aer_raw_clear_status
|-- sparc-defconfig
|   `-- multiple-definition-of-pci_aer_raw_clear_status
|-- sparc64-defconfig
|   `-- multiple-definition-of-pci_aer_raw_clear_status
|-- sparc64-randconfig-a001-20200305
|   `-- multiple-definition-of-pci_aer_raw_clear_status
|-- sparc64-randconfig-a001-20200306
|   `-- multiple-definition-of-pci_aer_raw_clear_status
|-- x86_64-randconfig-a001-20200305
|   `-- multiple-definition-of-pci_aer_raw_clear_status-drivers-pci-access.o:drivers-pci-pci.h:first-defined-here
|-- x86_64-randconfig-a002-20200305
|   `-- multiple-definition-of-pci_aer_raw_clear_status-drivers-pci-access.o:drivers-pci-pci.h:first-defined-here
|-- x86_64-randconfig-a003-20200305
|   `-- multiple-definition-of-pci_aer_raw_clear_status-drivers-pci-access.o:drivers-pci-pci.h:first-defined-here
|-- x86_64-randconfig-b001-20200306
|   `-- multiple-definition-of-pci_aer_raw_clear_status-drivers-pci-access.o:drivers-pci-pci.h:first-defined-here
|-- x86_64-randconfig-b002-20200306
|   `-- multiple-definition-of-pci_aer_raw_clear_status-drivers-pci-access.o:drivers-pci-pci.h:first-defined-here
`-- x86_64-randconfig-b003-20200306
    `-- multiple-definition-of-pci_aer_raw_clear_status-drivers-pci-access.o:drivers-pci-pci.h:first-defined-here

elapsed time: 484m

configs tested: 149
configs skipped: 0

arm64                            allyesconfig
arm                              allyesconfig
arm64                             allnoconfig
arm                               allnoconfig
arm                           efm32_defconfig
arm                         at91_dt_defconfig
arm                        shmobile_defconfig
arm64                               defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                           sunxi_defconfig
arm                        multi_v7_defconfig
sparc                            allyesconfig
i386                              allnoconfig
i386                             allyesconfig
i386                             alldefconfig
i386                                defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                             alldefconfig
arm64                            allmodconfig
arm                              allmodconfig
c6x                              allyesconfig
c6x                        evmc6678_defconfig
nios2                         10m50_defconfig
nios2                         3c120_defconfig
openrisc                    or1ksim_defconfig
openrisc                 simple_smp_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
nds32                               defconfig
nds32                             allnoconfig
csky                                defconfig
alpha                               defconfig
h8300                       h8s-sim_defconfig
h8300                     edosk2674_defconfig
m68k                       m5475evb_defconfig
m68k                             allmodconfig
h8300                    h8300h-sim_defconfig
m68k                           sun3_defconfig
m68k                          multi_defconfig
powerpc                             defconfig
powerpc                          rhel-kconfig
arc                                 defconfig
arc                              allyesconfig
powerpc                       ppc64_defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
mips                             allyesconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                           32r2_defconfig
mips                             allmodconfig
parisc                            allnoconfig
parisc                generic-64bit_defconfig
parisc                generic-32bit_defconfig
parisc                           allyesconfig
i386                 randconfig-a003-20200305
i386                 randconfig-a001-20200305
x86_64               randconfig-a001-20200305
i386                 randconfig-a002-20200305
x86_64               randconfig-a003-20200305
x86_64               randconfig-a002-20200305
riscv                randconfig-a001-20200306
alpha                randconfig-a001-20200306
m68k                 randconfig-a001-20200306
nds32                randconfig-a001-20200306
mips                 randconfig-a001-20200306
parisc               randconfig-a001-20200306
sparc64              randconfig-a001-20200305
c6x                  randconfig-a001-20200305
nios2                randconfig-a001-20200305
h8300                randconfig-a001-20200305
microblaze           randconfig-a001-20200306
sparc64              randconfig-a001-20200306
c6x                  randconfig-a001-20200306
nios2                randconfig-a001-20200306
h8300                randconfig-a001-20200306
sh                   randconfig-a001-20200305
openrisc             randconfig-a001-20200305
csky                 randconfig-a001-20200305
s390                 randconfig-a001-20200305
xtensa               randconfig-a001-20200305
x86_64               randconfig-b002-20200306
x86_64               randconfig-b001-20200306
i386                 randconfig-b001-20200306
i386                 randconfig-b003-20200306
i386                 randconfig-b002-20200306
x86_64               randconfig-b003-20200306
x86_64               randconfig-d003-20200306
i386                 randconfig-d001-20200306
x86_64               randconfig-d001-20200306
i386                 randconfig-d003-20200306
i386                 randconfig-d002-20200306
x86_64               randconfig-d002-20200306
i386                 randconfig-e001-20200305
i386                 randconfig-e003-20200305
x86_64               randconfig-e002-20200305
x86_64               randconfig-e001-20200305
x86_64               randconfig-e003-20200305
i386                 randconfig-e002-20200305
i386                 randconfig-f003-20200306
x86_64               randconfig-f001-20200306
i386                 randconfig-f001-20200306
i386                 randconfig-f002-20200306
x86_64               randconfig-f002-20200306
x86_64               randconfig-f003-20200306
arc                  randconfig-a001-20200306
ia64                 randconfig-a001-20200306
sparc                randconfig-a001-20200306
arm                  randconfig-a001-20200306
arm64                randconfig-a001-20200306
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
s390                       zfcpdump_defconfig
s390                          debug_defconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
s390                             alldefconfig
s390                                defconfig
sh                          rsk7269_defconfig
sh                               allmodconfig
sh                            titan_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
um                                  defconfig
x86_64                                   rhel
x86_64                               rhel-7.6
x86_64                         rhel-7.2-clear
x86_64                                    lkp
x86_64                              fedora-25
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
