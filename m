Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA99318B24C
	for <lists+linux-pci@lfdr.de>; Thu, 19 Mar 2020 12:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbgCSL1x (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Mar 2020 07:27:53 -0400
Received: from mga02.intel.com ([134.134.136.20]:58535 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbgCSL1x (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 19 Mar 2020 07:27:53 -0400
IronPort-SDR: SD/0CWGUBVKU5+Tde0ithGn+UynAx8tIhCQhDRQI/flfMyeJVaPv4/iXPa2EmjFdUed5fVzHpr
 P/4annlCNlig==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2020 04:27:51 -0700
IronPort-SDR: xuBNfkUO3HfomqBrrNnGZrbV8Vqmr0xxBf8z4pD5BU3PyruB8zsJxe/OQoRGqG1cgOWIjk5E0V
 5gTpt6ifQi4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,571,1574150400"; 
   d="scan'208";a="391769107"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 19 Mar 2020 04:27:49 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jEtL3-0003pN-5J; Thu, 19 Mar 2020 19:27:49 +0800
Date:   Thu, 19 Mar 2020 19:26:59 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:pci/p2pdma] BUILD SUCCESS
 7b94b53db34f78bb5e09f44e8827d45a8a88bf47
Message-ID: <5e735703.bmzXU4o1wIysMyG+%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git  pci/p2pdma
branch HEAD: 7b94b53db34f78bb5e09f44e8827d45a8a88bf47  PCI/P2PDMA: Add Intel Sky Lake-E Root Ports B, C, D to the whitelist

elapsed time: 735m

configs tested: 210
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                              allmodconfig
arm                               allnoconfig
arm                              allyesconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm64                            allyesconfig
arm                           efm32_defconfig
arm                         at91_dt_defconfig
arm                        shmobile_defconfig
arm64                               defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                           sunxi_defconfig
arm                        multi_v7_defconfig
sparc                            allyesconfig
s390                          debug_defconfig
xtensa                          iss_defconfig
riscv                            allyesconfig
m68k                           sun3_defconfig
sparc                               defconfig
um                           x86_64_defconfig
riscv                    nommu_virt_defconfig
i386                              allnoconfig
riscv                          rv32_defconfig
i386                             alldefconfig
i386                             allyesconfig
i386                                defconfig
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                                defconfig
c6x                              allyesconfig
c6x                        evmc6678_defconfig
nios2                         10m50_defconfig
nios2                         3c120_defconfig
openrisc                    or1ksim_defconfig
openrisc                 simple_smp_defconfig
xtensa                       common_defconfig
nds32                               defconfig
nds32                             allnoconfig
csky                                defconfig
alpha                               defconfig
h8300                     edosk2674_defconfig
h8300                    h8300h-sim_defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
arc                              allyesconfig
arc                                 defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                             allyesconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
parisc                            allnoconfig
parisc                           allyesconfig
parisc                generic-32bit_defconfig
parisc                generic-64bit_defconfig
x86_64               randconfig-a001-20200318
x86_64               randconfig-a002-20200318
x86_64               randconfig-a003-20200318
i386                 randconfig-a001-20200318
i386                 randconfig-a002-20200318
i386                 randconfig-a003-20200318
x86_64               randconfig-a001-20200319
x86_64               randconfig-a002-20200319
x86_64               randconfig-a003-20200319
i386                 randconfig-a001-20200319
i386                 randconfig-a002-20200319
i386                 randconfig-a003-20200319
alpha                randconfig-a001-20200319
m68k                 randconfig-a001-20200319
mips                 randconfig-a001-20200319
nds32                randconfig-a001-20200319
parisc               randconfig-a001-20200319
riscv                randconfig-a001-20200319
c6x                  randconfig-a001-20200319
h8300                randconfig-a001-20200319
microblaze           randconfig-a001-20200319
nios2                randconfig-a001-20200319
sparc64              randconfig-a001-20200319
h8300                randconfig-a001-20200318
sparc64              randconfig-a001-20200318
c6x                  randconfig-a001-20200318
nios2                randconfig-a001-20200318
microblaze           randconfig-a001-20200318
csky                 randconfig-a001-20200318
openrisc             randconfig-a001-20200318
s390                 randconfig-a001-20200318
sh                   randconfig-a001-20200318
xtensa               randconfig-a001-20200318
xtensa               randconfig-a001-20200319
csky                 randconfig-a001-20200319
openrisc             randconfig-a001-20200319
sh                   randconfig-a001-20200319
s390                 randconfig-a001-20200319
x86_64               randconfig-b001-20200318
x86_64               randconfig-b002-20200318
x86_64               randconfig-b003-20200318
i386                 randconfig-b001-20200318
i386                 randconfig-b002-20200318
i386                 randconfig-b003-20200318
x86_64               randconfig-b001-20200319
x86_64               randconfig-b002-20200319
x86_64               randconfig-b003-20200319
i386                 randconfig-b001-20200319
i386                 randconfig-b002-20200319
i386                 randconfig-b003-20200319
x86_64               randconfig-c001-20200319
x86_64               randconfig-c002-20200319
x86_64               randconfig-c003-20200319
i386                 randconfig-c001-20200319
i386                 randconfig-c002-20200319
i386                 randconfig-c003-20200319
x86_64               randconfig-d001-20200319
x86_64               randconfig-d002-20200319
x86_64               randconfig-d003-20200319
i386                 randconfig-d001-20200319
i386                 randconfig-d002-20200319
i386                 randconfig-d003-20200319
x86_64               randconfig-d001-20200318
x86_64               randconfig-d002-20200318
x86_64               randconfig-d003-20200318
i386                 randconfig-d001-20200318
i386                 randconfig-d002-20200318
i386                 randconfig-d003-20200318
x86_64               randconfig-e001-20200319
x86_64               randconfig-e002-20200319
x86_64               randconfig-e003-20200319
i386                 randconfig-e001-20200319
i386                 randconfig-e002-20200319
i386                 randconfig-e003-20200319
x86_64               randconfig-e001-20200318
x86_64               randconfig-e002-20200318
x86_64               randconfig-e003-20200318
i386                 randconfig-e001-20200318
i386                 randconfig-e002-20200318
i386                 randconfig-e003-20200318
x86_64               randconfig-f001-20200319
x86_64               randconfig-f002-20200319
x86_64               randconfig-f003-20200319
i386                 randconfig-f001-20200319
i386                 randconfig-f002-20200319
i386                 randconfig-f003-20200319
x86_64               randconfig-f001-20200318
x86_64               randconfig-f002-20200318
x86_64               randconfig-f003-20200318
i386                 randconfig-f001-20200318
i386                 randconfig-f002-20200318
i386                 randconfig-f003-20200318
x86_64               randconfig-g001-20200319
x86_64               randconfig-g002-20200319
x86_64               randconfig-g003-20200319
i386                 randconfig-g001-20200319
i386                 randconfig-g002-20200319
i386                 randconfig-g003-20200319
x86_64               randconfig-h001-20200318
x86_64               randconfig-h002-20200318
x86_64               randconfig-h003-20200318
i386                 randconfig-h001-20200318
i386                 randconfig-h002-20200318
i386                 randconfig-h003-20200318
x86_64               randconfig-h001-20200319
x86_64               randconfig-h002-20200319
x86_64               randconfig-h003-20200319
i386                 randconfig-h001-20200319
i386                 randconfig-h002-20200319
i386                 randconfig-h003-20200319
arc                  randconfig-a001-20200319
arm                  randconfig-a001-20200319
arm64                randconfig-a001-20200319
ia64                 randconfig-a001-20200319
powerpc              randconfig-a001-20200319
sparc                randconfig-a001-20200319
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
s390                             alldefconfig
s390                             allmodconfig
s390                              allnoconfig
s390                             allyesconfig
s390                                defconfig
s390                       zfcpdump_defconfig
sh                               allmodconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                             defconfig
um                             i386_defconfig
um                                  defconfig
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                         rhel-7.2-clear
x86_64                               rhel-7.6

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
