Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 056A3191F78
	for <lists+linux-pci@lfdr.de>; Wed, 25 Mar 2020 03:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbgCYCxs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Mar 2020 22:53:48 -0400
Received: from mga07.intel.com ([134.134.136.100]:62043 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727253AbgCYCxr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 24 Mar 2020 22:53:47 -0400
IronPort-SDR: 3T+mGSAyIglPtzLV3/Ycoj5ZS4SOb0yXLlbTwSR2YwyQuZCs5Eon4aL2CSXWHAlo5JLnNRgtYs
 B3+OzIoEPObQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2020 19:53:46 -0700
IronPort-SDR: RkzUGGoPvYJKsWrPRbYFxxis3FoNAl2CbM0wIaL6z8/ZGZ6UhvnfgTcUoCfK/Q/Y8KERMXiBC3
 QldzQwI04AAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,302,1580803200"; 
   d="scan'208";a="265389833"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 24 Mar 2020 19:53:45 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jGwAq-00059I-Ls; Wed, 25 Mar 2020 10:53:44 +0800
Date:   Wed, 25 Mar 2020 10:53:18 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS 8121b38f0955db3839ce639607b6afcfafe2ec15
Message-ID: <5e7ac79e.3CmILfA0wuiBn89N%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git  next
branch HEAD: 8121b38f0955db3839ce639607b6afcfafe2ec15  Merge branch 'remotes/lorenzo/pci/vmd'

elapsed time: 634m

configs tested: 149
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

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
i386                             allyesconfig
i386                             alldefconfig
i386                                defconfig
i386                              allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                             alldefconfig
arm64                            allmodconfig
arm                              allmodconfig
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
i386                 randconfig-a002-20200324
x86_64               randconfig-a002-20200324
i386                 randconfig-a001-20200324
x86_64               randconfig-a001-20200324
i386                 randconfig-a003-20200324
x86_64               randconfig-a003-20200324
mips                 randconfig-a001-20200324
nds32                randconfig-a001-20200324
m68k                 randconfig-a001-20200324
parisc               randconfig-a001-20200324
alpha                randconfig-a001-20200324
riscv                randconfig-a001-20200324
h8300                randconfig-a001-20200324
microblaze           randconfig-a001-20200324
nios2                randconfig-a001-20200324
c6x                  randconfig-a001-20200324
sparc64              randconfig-a001-20200324
s390                 randconfig-a001-20200324
csky                 randconfig-a001-20200324
xtensa               randconfig-a001-20200324
openrisc             randconfig-a001-20200324
sh                   randconfig-a001-20200324
i386                 randconfig-b003-20200324
i386                 randconfig-b001-20200324
i386                 randconfig-b002-20200324
x86_64               randconfig-b001-20200324
x86_64               randconfig-c003-20200324
i386                 randconfig-c002-20200324
x86_64               randconfig-c001-20200324
x86_64               randconfig-c002-20200324
i386                 randconfig-c003-20200324
i386                 randconfig-c001-20200324
i386                 randconfig-d003-20200324
i386                 randconfig-d001-20200324
x86_64               randconfig-d002-20200324
x86_64               randconfig-d001-20200324
i386                 randconfig-d002-20200324
x86_64               randconfig-d003-20200324
x86_64               randconfig-e001-20200324
i386                 randconfig-e002-20200324
i386                 randconfig-e003-20200324
x86_64               randconfig-e002-20200324
i386                 randconfig-e001-20200324
i386                 randconfig-g003-20200324
x86_64               randconfig-g002-20200324
i386                 randconfig-g001-20200324
i386                 randconfig-g002-20200324
x86_64               randconfig-g001-20200324
x86_64               randconfig-g003-20200324
x86_64               randconfig-h002-20200324
x86_64               randconfig-h003-20200324
i386                 randconfig-h003-20200324
i386                 randconfig-h001-20200324
x86_64               randconfig-h001-20200324
i386                 randconfig-h002-20200324
arm                  randconfig-a001-20200324
arm64                randconfig-a001-20200324
ia64                 randconfig-a001-20200324
arc                  randconfig-a001-20200324
sparc                randconfig-a001-20200324
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
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
