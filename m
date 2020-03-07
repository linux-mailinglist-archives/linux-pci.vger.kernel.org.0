Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8735B17CCA2
	for <lists+linux-pci@lfdr.de>; Sat,  7 Mar 2020 08:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbgCGHZp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 7 Mar 2020 02:25:45 -0500
Received: from mga05.intel.com ([192.55.52.43]:34223 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbgCGHZp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 7 Mar 2020 02:25:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Mar 2020 23:25:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,525,1574150400"; 
   d="scan'208";a="235068728"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 06 Mar 2020 23:25:43 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jATqA-000BHI-I6; Sat, 07 Mar 2020 15:25:42 +0800
Date:   Sat, 07 Mar 2020 15:24:59 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:review/edr] BUILD SUCCESS
 205c126eb6f62a2971e9c31052ff9e656f9fc044
Message-ID: <5e634c4b.SmzB2XVAcRJOO+BP%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git  review/edr
branch HEAD: 205c126eb6f62a2971e9c31052ff9e656f9fc044  PCI/AER: Rationalize error status register clearing

elapsed time: 484m

configs tested: 149
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

arm64                            allyesconfig
arm                              allyesconfig
arm64                            allmodconfig
arm                              allmodconfig
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
nios2                         3c120_defconfig
nios2                         10m50_defconfig
c6x                        evmc6678_defconfig
xtensa                          iss_defconfig
c6x                              allyesconfig
xtensa                       common_defconfig
openrisc                 simple_smp_defconfig
openrisc                    or1ksim_defconfig
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
arc                                 defconfig
arc                              allyesconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
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
i386                 randconfig-a003-20200307
x86_64               randconfig-a001-20200307
i386                 randconfig-a001-20200307
i386                 randconfig-a002-20200307
x86_64               randconfig-a003-20200307
x86_64               randconfig-a002-20200307
riscv                randconfig-a001-20200307
alpha                randconfig-a001-20200307
m68k                 randconfig-a001-20200307
nds32                randconfig-a001-20200307
mips                 randconfig-a001-20200307
parisc               randconfig-a001-20200307
sparc64              randconfig-a001-20200305
c6x                  randconfig-a001-20200305
nios2                randconfig-a001-20200305
h8300                randconfig-a001-20200305
sparc64              randconfig-a001-20200307
c6x                  randconfig-a001-20200307
nios2                randconfig-a001-20200307
h8300                randconfig-a001-20200307
sh                   randconfig-a001-20200306
openrisc             randconfig-a001-20200306
csky                 randconfig-a001-20200306
s390                 randconfig-a001-20200306
xtensa               randconfig-a001-20200306
x86_64               randconfig-b002-20200307
x86_64               randconfig-b001-20200307
i386                 randconfig-b001-20200307
i386                 randconfig-b003-20200307
i386                 randconfig-b002-20200307
x86_64               randconfig-b003-20200307
i386                 randconfig-c002-20200307
x86_64               randconfig-c003-20200307
i386                 randconfig-c001-20200307
x86_64               randconfig-c002-20200307
i386                 randconfig-c003-20200307
x86_64               randconfig-c001-20200307
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
