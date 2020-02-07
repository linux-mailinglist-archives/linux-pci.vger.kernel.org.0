Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECACF155FB9
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2020 21:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbgBGUkO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Feb 2020 15:40:14 -0500
Received: from mga14.intel.com ([192.55.52.115]:48746 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727028AbgBGUkO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Feb 2020 15:40:14 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Feb 2020 12:40:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,414,1574150400"; 
   d="scan'208";a="226576979"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 07 Feb 2020 12:40:13 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1j0AQ8-000EtZ-HB; Sat, 08 Feb 2020 04:40:12 +0800
Date:   Sat, 08 Feb 2020 04:39:18 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:for-linus] BUILD SUCCESS
 2e34673be0bd6bb0c6c496a861cbc3f7431e7ce3
Message-ID: <5e3dcaf6.PRpBiJpia6pISyJ0%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git  for-linus
branch HEAD: 2e34673be0bd6bb0c6c496a861cbc3f7431e7ce3  PCI/ATS: Use PF PASID for VFs

elapsed time: 2883m

configs tested: 269
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

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
s390                                defconfig
sh                          rsk7269_defconfig
h8300                       h8s-sim_defconfig
nds32                             allnoconfig
sparc64                          allmodconfig
alpha                               defconfig
powerpc                       ppc64_defconfig
ia64                             allyesconfig
riscv                               defconfig
parisc                              defconfig
riscv                    nommu_virt_defconfig
s390                       zfcpdump_defconfig
m68k                          multi_defconfig
ia64                                defconfig
m68k                             allmodconfig
arc                                 defconfig
sparc64                          allyesconfig
microblaze                      mmu_defconfig
powerpc                           allnoconfig
m68k                       m5475evb_defconfig
parisc                            allnoconfig
um                           x86_64_defconfig
csky                                defconfig
sh                                allnoconfig
m68k                           sun3_defconfig
xtensa                          iss_defconfig
sh                            titan_defconfig
microblaze                    nommu_defconfig
powerpc                             defconfig
i386                             alldefconfig
i386                              allnoconfig
i386                             allyesconfig
i386                                defconfig
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
c6x                              allyesconfig
c6x                        evmc6678_defconfig
nios2                         10m50_defconfig
nios2                         3c120_defconfig
openrisc                    or1ksim_defconfig
openrisc                 simple_smp_defconfig
xtensa                       common_defconfig
nds32                               defconfig
h8300                     edosk2674_defconfig
h8300                    h8300h-sim_defconfig
arc                              allyesconfig
powerpc                          rhel-kconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                             allyesconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                            allyesonfig
x86_64               randconfig-a001-20200207
x86_64               randconfig-a002-20200207
x86_64               randconfig-a003-20200207
i386                 randconfig-a001-20200207
i386                 randconfig-a002-20200207
i386                 randconfig-a003-20200207
x86_64               randconfig-a001-20200206
x86_64               randconfig-a002-20200206
x86_64               randconfig-a003-20200206
i386                 randconfig-a001-20200206
i386                 randconfig-a002-20200206
i386                 randconfig-a003-20200206
alpha                randconfig-a001-20200206
m68k                 randconfig-a001-20200206
mips                 randconfig-a001-20200206
nds32                randconfig-a001-20200206
parisc               randconfig-a001-20200206
riscv                randconfig-a001-20200206
alpha                randconfig-a001-20200207
m68k                 randconfig-a001-20200207
mips                 randconfig-a001-20200207
nds32                randconfig-a001-20200207
parisc               randconfig-a001-20200207
c6x                  randconfig-a001-20200206
h8300                randconfig-a001-20200206
microblaze           randconfig-a001-20200206
nios2                randconfig-a001-20200206
sparc64              randconfig-a001-20200206
c6x                  randconfig-a001-20200207
h8300                randconfig-a001-20200207
microblaze           randconfig-a001-20200207
nios2                randconfig-a001-20200207
sparc64              randconfig-a001-20200207
csky                 randconfig-a001-20200206
openrisc             randconfig-a001-20200206
s390                 randconfig-a001-20200206
sh                   randconfig-a001-20200206
xtensa               randconfig-a001-20200206
csky                 randconfig-a001-20200207
openrisc             randconfig-a001-20200207
s390                 randconfig-a001-20200207
xtensa               randconfig-a001-20200207
x86_64               randconfig-b001-20200207
x86_64               randconfig-b002-20200207
x86_64               randconfig-b003-20200207
i386                 randconfig-b001-20200207
i386                 randconfig-b002-20200207
i386                 randconfig-b003-20200207
x86_64               randconfig-b001-20200206
x86_64               randconfig-b002-20200206
x86_64               randconfig-b003-20200206
i386                 randconfig-b001-20200206
i386                 randconfig-b002-20200206
i386                 randconfig-b003-20200206
x86_64               randconfig-b001-20200205
x86_64               randconfig-b002-20200205
x86_64               randconfig-b003-20200205
i386                 randconfig-b001-20200205
i386                 randconfig-b002-20200205
i386                 randconfig-b003-20200205
x86_64               randconfig-c001-20200206
x86_64               randconfig-c002-20200206
x86_64               randconfig-c003-20200206
i386                 randconfig-c001-20200206
i386                 randconfig-c002-20200206
i386                 randconfig-c003-20200206
x86_64               randconfig-c001-20200207
x86_64               randconfig-c002-20200207
x86_64               randconfig-c003-20200207
i386                 randconfig-c001-20200207
i386                 randconfig-c002-20200207
i386                 randconfig-c003-20200207
x86_64               randconfig-c001-20200204
x86_64               randconfig-c002-20200204
x86_64               randconfig-c003-20200204
i386                 randconfig-c001-20200204
i386                 randconfig-c002-20200204
i386                 randconfig-c003-20200204
x86_64               randconfig-d001-20200206
x86_64               randconfig-d002-20200206
x86_64               randconfig-d003-20200206
i386                 randconfig-d001-20200206
i386                 randconfig-d002-20200206
i386                 randconfig-d003-20200206
x86_64               randconfig-d001-20200205
x86_64               randconfig-d002-20200205
x86_64               randconfig-d003-20200205
i386                 randconfig-d001-20200205
i386                 randconfig-d002-20200205
i386                 randconfig-d003-20200205
x86_64               randconfig-d001-20200207
x86_64               randconfig-d002-20200207
x86_64               randconfig-d003-20200207
i386                 randconfig-d001-20200207
i386                 randconfig-d002-20200207
i386                 randconfig-d003-20200207
x86_64               randconfig-e001-20200206
x86_64               randconfig-e002-20200206
x86_64               randconfig-e003-20200206
i386                 randconfig-e001-20200206
i386                 randconfig-e002-20200206
i386                 randconfig-e003-20200206
x86_64               randconfig-e001-20200207
x86_64               randconfig-e002-20200207
x86_64               randconfig-e003-20200207
i386                 randconfig-e001-20200207
i386                 randconfig-e002-20200207
i386                 randconfig-e003-20200207
x86_64               randconfig-f001-20200205
x86_64               randconfig-f002-20200205
x86_64               randconfig-f003-20200205
i386                 randconfig-f001-20200205
i386                 randconfig-f002-20200205
i386                 randconfig-f003-20200205
x86_64               randconfig-f001-20200207
x86_64               randconfig-f002-20200207
x86_64               randconfig-f003-20200207
i386                 randconfig-f001-20200207
i386                 randconfig-f002-20200207
i386                 randconfig-f003-20200207
x86_64               randconfig-f001-20200204
x86_64               randconfig-f002-20200204
x86_64               randconfig-f003-20200204
i386                 randconfig-f001-20200204
i386                 randconfig-f002-20200204
i386                 randconfig-f003-20200204
x86_64               randconfig-g001-20200206
x86_64               randconfig-g002-20200206
x86_64               randconfig-g003-20200206
i386                 randconfig-g001-20200206
i386                 randconfig-g002-20200206
i386                 randconfig-g003-20200206
x86_64               randconfig-g001-20200207
x86_64               randconfig-g002-20200207
x86_64               randconfig-g003-20200207
i386                 randconfig-g001-20200207
i386                 randconfig-g002-20200207
i386                 randconfig-g003-20200207
x86_64               randconfig-h001-20200206
x86_64               randconfig-h002-20200206
x86_64               randconfig-h003-20200206
i386                 randconfig-h001-20200206
i386                 randconfig-h002-20200206
i386                 randconfig-h003-20200206
x86_64               randconfig-h001-20200205
x86_64               randconfig-h002-20200205
x86_64               randconfig-h003-20200205
i386                 randconfig-h001-20200205
i386                 randconfig-h002-20200205
i386                 randconfig-h003-20200205
x86_64               randconfig-h001-20200207
x86_64               randconfig-h002-20200207
x86_64               randconfig-h003-20200207
i386                 randconfig-h001-20200207
i386                 randconfig-h002-20200207
i386                 randconfig-h003-20200207
x86_64               randconfig-h001-20200204
x86_64               randconfig-h002-20200204
x86_64               randconfig-h003-20200204
i386                 randconfig-h001-20200204
i386                 randconfig-h002-20200204
i386                 randconfig-h003-20200204
arc                  randconfig-a001-20200205
arm                  randconfig-a001-20200205
arm64                randconfig-a001-20200205
ia64                 randconfig-a001-20200205
powerpc              randconfig-a001-20200205
sparc                randconfig-a001-20200205
arc                  randconfig-a001-20200207
arm                  randconfig-a001-20200207
arm64                randconfig-a001-20200207
ia64                 randconfig-a001-20200207
powerpc              randconfig-a001-20200207
sparc                randconfig-a001-20200207
riscv                            allmodconfig
riscv                             allnoconfig
riscv                            allyesconfig
riscv                          rv32_defconfig
s390                             alldefconfig
s390                             allmodconfig
s390                              allnoconfig
s390                             allyesconfig
s390                          debug_defconfig
sh                               allmodconfig
sh                  sh7785lcr_32bit_defconfig
sparc                               defconfig
sparc64                           allnoconfig
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
