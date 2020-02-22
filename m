Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B174168D22
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2020 08:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbgBVHLm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 22 Feb 2020 02:11:42 -0500
Received: from mga14.intel.com ([192.55.52.115]:57801 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727265AbgBVHLm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 22 Feb 2020 02:11:42 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Feb 2020 23:11:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,471,1574150400"; 
   d="scan'208";a="230643620"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 21 Feb 2020 23:11:40 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1j5Owt-00015Z-Va; Sat, 22 Feb 2020 15:11:39 +0800
Date:   Sat, 22 Feb 2020 15:11:03 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS daf98fffe4dc61b86edee09cbc49ed0a12734198
Message-ID: <5e50d407.Z9Ydsl3pdJi+Z6G3%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git  next
branch HEAD: daf98fffe4dc61b86edee09cbc49ed0a12734198  Merge branch 'pci/misc'

elapsed time: 1367m

configs tested: 223
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                              allmodconfig
arm                               allnoconfig
arm                              allyesconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm64                            allyesconfig
arm                         at91_dt_defconfig
arm                           efm32_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm                           sunxi_defconfig
arm64                               defconfig
sparc                            allyesconfig
nios2                         10m50_defconfig
nds32                             allnoconfig
arc                              allyesconfig
ia64                              allnoconfig
i386                                defconfig
arc                                 defconfig
c6x                              allyesconfig
parisc                generic-32bit_defconfig
i386                              allnoconfig
m68k                           sun3_defconfig
i386                             alldefconfig
i386                             allyesconfig
ia64                             alldefconfig
ia64                             allmodconfig
ia64                             allyesconfig
ia64                                defconfig
c6x                        evmc6678_defconfig
nios2                         3c120_defconfig
openrisc                    or1ksim_defconfig
openrisc                 simple_smp_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
alpha                               defconfig
csky                                defconfig
nds32                               defconfig
h8300                     edosk2674_defconfig
h8300                    h8300h-sim_defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
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
parisc                generic-64bit_defconfig
parisc                           allyesconfig
x86_64               randconfig-a001-20200221
x86_64               randconfig-a002-20200221
x86_64               randconfig-a003-20200221
i386                 randconfig-a001-20200221
i386                 randconfig-a002-20200221
i386                 randconfig-a003-20200221
x86_64               randconfig-a001-20200222
x86_64               randconfig-a002-20200222
x86_64               randconfig-a003-20200222
i386                 randconfig-a001-20200222
i386                 randconfig-a002-20200222
i386                 randconfig-a003-20200222
alpha                randconfig-a001-20200221
m68k                 randconfig-a001-20200221
mips                 randconfig-a001-20200221
nds32                randconfig-a001-20200221
parisc               randconfig-a001-20200221
riscv                randconfig-a001-20200221
alpha                randconfig-a001-20200222
m68k                 randconfig-a001-20200222
mips                 randconfig-a001-20200222
nds32                randconfig-a001-20200222
parisc               randconfig-a001-20200222
riscv                randconfig-a001-20200222
c6x                  randconfig-a001-20200221
h8300                randconfig-a001-20200221
microblaze           randconfig-a001-20200221
nios2                randconfig-a001-20200221
sparc64              randconfig-a001-20200221
csky                 randconfig-a001-20200221
openrisc             randconfig-a001-20200221
s390                 randconfig-a001-20200221
sh                   randconfig-a001-20200221
xtensa               randconfig-a001-20200221
csky                 randconfig-a001-20200222
openrisc             randconfig-a001-20200222
s390                 randconfig-a001-20200222
sh                   randconfig-a001-20200222
xtensa               randconfig-a001-20200222
x86_64               randconfig-b001-20200222
x86_64               randconfig-b002-20200222
x86_64               randconfig-b003-20200222
i386                 randconfig-b001-20200222
i386                 randconfig-b002-20200222
i386                 randconfig-b003-20200222
x86_64               randconfig-b001-20200221
i386                 randconfig-b002-20200221
x86_64               randconfig-b003-20200221
i386                 randconfig-b003-20200221
x86_64               randconfig-b002-20200221
i386                 randconfig-b001-20200221
x86_64               randconfig-c001-20200221
x86_64               randconfig-c002-20200221
x86_64               randconfig-c003-20200221
i386                 randconfig-c001-20200221
i386                 randconfig-c002-20200221
i386                 randconfig-c003-20200221
x86_64               randconfig-c001-20200222
x86_64               randconfig-c002-20200222
x86_64               randconfig-c003-20200222
i386                 randconfig-c001-20200222
i386                 randconfig-c002-20200222
i386                 randconfig-c003-20200222
x86_64               randconfig-d001-20200221
x86_64               randconfig-d002-20200221
x86_64               randconfig-d003-20200221
i386                 randconfig-d001-20200221
i386                 randconfig-d002-20200221
i386                 randconfig-d003-20200221
x86_64               randconfig-d001-20200222
x86_64               randconfig-d002-20200222
x86_64               randconfig-d003-20200222
i386                 randconfig-d001-20200222
i386                 randconfig-d002-20200222
i386                 randconfig-d003-20200222
x86_64               randconfig-e001-20200221
x86_64               randconfig-e002-20200221
x86_64               randconfig-e003-20200221
i386                 randconfig-e001-20200221
i386                 randconfig-e002-20200221
i386                 randconfig-e003-20200221
x86_64               randconfig-e001-20200222
x86_64               randconfig-e002-20200222
x86_64               randconfig-e003-20200222
i386                 randconfig-e001-20200222
i386                 randconfig-e002-20200222
i386                 randconfig-e003-20200222
x86_64               randconfig-f003-20200221
x86_64               randconfig-f002-20200221
x86_64               randconfig-f001-20200221
i386                 randconfig-f001-20200221
i386                 randconfig-f003-20200221
i386                 randconfig-f002-20200221
x86_64               randconfig-f001-20200222
x86_64               randconfig-f002-20200222
x86_64               randconfig-f003-20200222
i386                 randconfig-f001-20200222
i386                 randconfig-f002-20200222
i386                 randconfig-f003-20200222
x86_64               randconfig-g001-20200222
x86_64               randconfig-g002-20200222
x86_64               randconfig-g003-20200222
i386                 randconfig-g001-20200222
i386                 randconfig-g002-20200222
i386                 randconfig-g003-20200222
x86_64               randconfig-g001-20200221
x86_64               randconfig-g002-20200221
x86_64               randconfig-g003-20200221
i386                 randconfig-g001-20200221
i386                 randconfig-g002-20200221
i386                 randconfig-g003-20200221
x86_64               randconfig-h001-20200221
x86_64               randconfig-h002-20200221
x86_64               randconfig-h003-20200221
i386                 randconfig-h001-20200221
i386                 randconfig-h002-20200221
i386                 randconfig-h003-20200221
x86_64               randconfig-h001-20200222
x86_64               randconfig-h002-20200222
x86_64               randconfig-h003-20200222
i386                 randconfig-h001-20200222
i386                 randconfig-h002-20200222
i386                 randconfig-h003-20200222
arc                  randconfig-a001-20200221
arm                  randconfig-a001-20200221
arm64                randconfig-a001-20200221
ia64                 randconfig-a001-20200221
powerpc              randconfig-a001-20200221
sparc                randconfig-a001-20200221
riscv                            allmodconfig
riscv                             allnoconfig
riscv                            allyesconfig
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
s390                             alldefconfig
s390                             allmodconfig
s390                              allnoconfig
s390                             allyesconfig
s390                          debug_defconfig
s390                                defconfig
s390                       zfcpdump_defconfig
sh                               allmodconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
sparc                               defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
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
