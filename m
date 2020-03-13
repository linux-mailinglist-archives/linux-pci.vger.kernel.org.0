Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 329A7183FC7
	for <lists+linux-pci@lfdr.de>; Fri, 13 Mar 2020 04:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbgCMDoi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Mar 2020 23:44:38 -0400
Received: from mga06.intel.com ([134.134.136.31]:37289 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726254AbgCMDoh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 12 Mar 2020 23:44:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2020 20:44:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,546,1574150400"; 
   d="scan'208";a="289913076"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Mar 2020 20:44:33 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jCbFR-000I6I-5q; Fri, 13 Mar 2020 11:44:33 +0800
Date:   Fri, 13 Mar 2020 11:43:50 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS a536a320bfa20f2599fc99ab292bb2b8a14543f1
Message-ID: <5e6b0176.KvksqLoKQ0aY4rXL%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git  next
branch HEAD: a536a320bfa20f2599fc99ab292bb2b8a14543f1  Merge branch 'remotes/lorenzo/pci/vmd'

elapsed time: 482m

configs tested: 164
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
microblaze                    nommu_defconfig
ia64                             allyesconfig
parisc                generic-32bit_defconfig
s390                             alldefconfig
um                                  defconfig
i386                              allnoconfig
i386                             alldefconfig
i386                             allyesconfig
i386                                defconfig
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                                defconfig
c6x                              allyesconfig
c6x                        evmc6678_defconfig
nios2                         10m50_defconfig
nios2                         3c120_defconfig
openrisc                    or1ksim_defconfig
openrisc                 simple_smp_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
alpha                               defconfig
csky                                defconfig
nds32                             allnoconfig
nds32                               defconfig
h8300                       h8s-sim_defconfig
h8300                     edosk2674_defconfig
m68k                       m5475evb_defconfig
m68k                             allmodconfig
h8300                    h8300h-sim_defconfig
m68k                           sun3_defconfig
m68k                          multi_defconfig
arc                              allyesconfig
arc                                 defconfig
microblaze                      mmu_defconfig
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
x86_64               randconfig-a001-20200313
x86_64               randconfig-a002-20200313
x86_64               randconfig-a003-20200313
i386                 randconfig-a001-20200313
i386                 randconfig-a002-20200313
i386                 randconfig-a003-20200313
alpha                randconfig-a001-20200312
m68k                 randconfig-a001-20200312
mips                 randconfig-a001-20200312
nds32                randconfig-a001-20200312
parisc               randconfig-a001-20200312
riscv                randconfig-a001-20200312
c6x                  randconfig-a001-20200312
h8300                randconfig-a001-20200312
microblaze           randconfig-a001-20200312
nios2                randconfig-a001-20200312
sparc64              randconfig-a001-20200312
xtensa               randconfig-a001-20200312
openrisc             randconfig-a001-20200312
csky                 randconfig-a001-20200312
sh                   randconfig-a001-20200312
s390                 randconfig-a001-20200312
x86_64               randconfig-b001-20200311
x86_64               randconfig-b002-20200311
x86_64               randconfig-b003-20200311
i386                 randconfig-b001-20200311
i386                 randconfig-b002-20200311
i386                 randconfig-b003-20200311
x86_64               randconfig-b001-20200312
x86_64               randconfig-b002-20200312
x86_64               randconfig-b003-20200312
i386                 randconfig-b001-20200312
i386                 randconfig-b002-20200312
i386                 randconfig-b003-20200312
x86_64               randconfig-c001-20200313
x86_64               randconfig-c002-20200313
x86_64               randconfig-c003-20200313
i386                 randconfig-c001-20200313
i386                 randconfig-c002-20200313
i386                 randconfig-c003-20200313
x86_64               randconfig-d001-20200312
x86_64               randconfig-d002-20200312
x86_64               randconfig-d003-20200312
i386                 randconfig-d001-20200312
i386                 randconfig-d002-20200312
i386                 randconfig-d003-20200312
x86_64               randconfig-e001-20200313
x86_64               randconfig-e002-20200313
x86_64               randconfig-e003-20200313
i386                 randconfig-e001-20200313
i386                 randconfig-e002-20200313
i386                 randconfig-e003-20200313
x86_64               randconfig-g001-20200313
x86_64               randconfig-g002-20200313
x86_64               randconfig-g003-20200313
i386                 randconfig-g001-20200313
i386                 randconfig-g002-20200313
i386                 randconfig-g003-20200313
x86_64               randconfig-h001-20200312
x86_64               randconfig-h002-20200312
x86_64               randconfig-h003-20200312
i386                 randconfig-h001-20200312
i386                 randconfig-h002-20200312
i386                 randconfig-h003-20200312
arm                  randconfig-a001-20200312
arm64                randconfig-a001-20200312
ia64                 randconfig-a001-20200312
powerpc              randconfig-a001-20200312
arc                  randconfig-a001-20200312
sparc                randconfig-a001-20200312
riscv                            allmodconfig
riscv                             allnoconfig
riscv                            allyesconfig
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
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
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                                   rhel
x86_64                               rhel-7.6
x86_64                         rhel-7.2-clear
x86_64                                    lkp
x86_64                              fedora-25
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
