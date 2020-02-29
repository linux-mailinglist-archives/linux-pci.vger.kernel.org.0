Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB351744B0
	for <lists+linux-pci@lfdr.de>; Sat, 29 Feb 2020 04:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbgB2DWF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Feb 2020 22:22:05 -0500
Received: from mga09.intel.com ([134.134.136.24]:41704 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726764AbgB2DWF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 28 Feb 2020 22:22:05 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Feb 2020 19:22:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,498,1574150400"; 
   d="scan'208";a="411605857"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 28 Feb 2020 19:22:01 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1j7shU-000AAP-Lt; Sat, 29 Feb 2020 11:22:00 +0800
Date:   Sat, 29 Feb 2020 11:21:44 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:pci/interrupts] BUILD SUCCESS
 d81977cb6b841e38a619e15f81f297750e8fb8d3
Message-ID: <5e59d8c8.pYFawYxL1JWkIplU%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git  pci/interrupts
branch HEAD: d81977cb6b841e38a619e15f81f297750e8fb8d3  Documentation: PCI: Add background on Boot Interrupts

elapsed time: 1070m

configs tested: 220
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
mips                      fuloong2e_defconfig
sh                          rsk7269_defconfig
sparc64                          allyesconfig
i386                                defconfig
h8300                     edosk2674_defconfig
s390                              allnoconfig
sparc                               defconfig
openrisc                    or1ksim_defconfig
arc                              allyesconfig
s390                             allyesconfig
s390                       zfcpdump_defconfig
nios2                         3c120_defconfig
sh                  sh7785lcr_32bit_defconfig
sparc64                           allnoconfig
i386                              allnoconfig
nds32                             allnoconfig
i386                             alldefconfig
i386                             allyesconfig
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                                defconfig
c6x                              allyesconfig
c6x                        evmc6678_defconfig
nios2                         10m50_defconfig
openrisc                 simple_smp_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
alpha                               defconfig
csky                                defconfig
nds32                               defconfig
h8300                       h8s-sim_defconfig
m68k                       m5475evb_defconfig
m68k                             allmodconfig
h8300                    h8300h-sim_defconfig
m68k                           sun3_defconfig
m68k                          multi_defconfig
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
mips                      malta_kvm_defconfig
parisc                            allnoconfig
parisc                           allyesconfig
parisc                generic-32bit_defconfig
parisc                generic-64bit_defconfig
x86_64               randconfig-a001-20200228
x86_64               randconfig-a002-20200228
x86_64               randconfig-a003-20200228
i386                 randconfig-a001-20200228
i386                 randconfig-a002-20200228
i386                 randconfig-a003-20200228
alpha                randconfig-a001-20200228
m68k                 randconfig-a001-20200228
mips                 randconfig-a001-20200228
nds32                randconfig-a001-20200228
parisc               randconfig-a001-20200228
riscv                randconfig-a001-20200228
alpha                randconfig-a001-20200229
m68k                 randconfig-a001-20200229
nds32                randconfig-a001-20200229
parisc               randconfig-a001-20200229
riscv                randconfig-a001-20200229
c6x                  randconfig-a001-20200229
h8300                randconfig-a001-20200229
microblaze           randconfig-a001-20200229
nios2                randconfig-a001-20200229
sparc64              randconfig-a001-20200229
c6x                  randconfig-a001-20200228
h8300                randconfig-a001-20200228
microblaze           randconfig-a001-20200228
nios2                randconfig-a001-20200228
sparc64              randconfig-a001-20200228
csky                 randconfig-a001-20200228
openrisc             randconfig-a001-20200228
s390                 randconfig-a001-20200228
sh                   randconfig-a001-20200228
xtensa               randconfig-a001-20200228
csky                 randconfig-a001-20200229
openrisc             randconfig-a001-20200229
s390                 randconfig-a001-20200229
xtensa               randconfig-a001-20200229
x86_64               randconfig-b001-20200228
x86_64               randconfig-b002-20200228
x86_64               randconfig-b003-20200228
i386                 randconfig-b001-20200228
i386                 randconfig-b002-20200228
i386                 randconfig-b003-20200228
x86_64               randconfig-c001-20200228
x86_64               randconfig-c002-20200228
x86_64               randconfig-c003-20200228
i386                 randconfig-c001-20200228
i386                 randconfig-c002-20200228
i386                 randconfig-c003-20200228
x86_64               randconfig-c001-20200229
x86_64               randconfig-c002-20200229
x86_64               randconfig-c003-20200229
i386                 randconfig-c001-20200229
i386                 randconfig-c002-20200229
i386                 randconfig-c003-20200229
x86_64               randconfig-d001-20200228
x86_64               randconfig-d002-20200228
x86_64               randconfig-d003-20200228
i386                 randconfig-d001-20200228
i386                 randconfig-d002-20200228
i386                 randconfig-d003-20200228
x86_64               randconfig-d001-20200229
x86_64               randconfig-d002-20200229
x86_64               randconfig-d003-20200229
i386                 randconfig-d001-20200229
i386                 randconfig-d002-20200229
i386                 randconfig-d003-20200229
x86_64               randconfig-e001-20200228
x86_64               randconfig-e002-20200228
x86_64               randconfig-e003-20200228
i386                 randconfig-e001-20200228
i386                 randconfig-e002-20200228
i386                 randconfig-e003-20200228
x86_64               randconfig-e001-20200229
x86_64               randconfig-e002-20200229
x86_64               randconfig-e003-20200229
i386                 randconfig-e001-20200229
i386                 randconfig-e002-20200229
i386                 randconfig-e003-20200229
x86_64               randconfig-f001-20200228
x86_64               randconfig-f002-20200228
x86_64               randconfig-f003-20200228
i386                 randconfig-f001-20200228
i386                 randconfig-f002-20200228
i386                 randconfig-f003-20200228
x86_64               randconfig-f001-20200229
x86_64               randconfig-f002-20200229
x86_64               randconfig-f003-20200229
i386                 randconfig-f001-20200229
i386                 randconfig-f002-20200229
i386                 randconfig-f003-20200229
x86_64               randconfig-g001-20200228
x86_64               randconfig-g002-20200228
x86_64               randconfig-g003-20200228
i386                 randconfig-g001-20200228
i386                 randconfig-g002-20200228
i386                 randconfig-g003-20200228
x86_64               randconfig-g001-20200229
x86_64               randconfig-g002-20200229
x86_64               randconfig-g003-20200229
i386                 randconfig-g001-20200229
i386                 randconfig-g002-20200229
i386                 randconfig-g003-20200229
i386                 randconfig-h003-20200228
i386                 randconfig-h002-20200228
x86_64               randconfig-h002-20200228
x86_64               randconfig-h003-20200228
x86_64               randconfig-h001-20200228
i386                 randconfig-h001-20200228
x86_64               randconfig-h001-20200229
x86_64               randconfig-h002-20200229
x86_64               randconfig-h003-20200229
i386                 randconfig-h001-20200229
i386                 randconfig-h002-20200229
i386                 randconfig-h003-20200229
arc                  randconfig-a001-20200229
arm                  randconfig-a001-20200229
arm64                randconfig-a001-20200229
ia64                 randconfig-a001-20200229
powerpc              randconfig-a001-20200229
sparc                randconfig-a001-20200229
arc                  randconfig-a001-20200228
arm                  randconfig-a001-20200228
arm64                randconfig-a001-20200228
ia64                 randconfig-a001-20200228
powerpc              randconfig-a001-20200228
sparc                randconfig-a001-20200228
riscv                            allmodconfig
riscv                             allnoconfig
riscv                            allyesconfig
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
s390                             alldefconfig
s390                             allmodconfig
s390                          debug_defconfig
s390                                defconfig
sh                               allmodconfig
sh                                allnoconfig
sh                            titan_defconfig
sparc64                          allmodconfig
sparc64                             defconfig
um                                  defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                         rhel-7.2-clear
x86_64                               rhel-7.6

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
