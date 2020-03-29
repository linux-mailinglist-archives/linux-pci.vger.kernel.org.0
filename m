Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4EB5196AF7
	for <lists+linux-pci@lfdr.de>; Sun, 29 Mar 2020 06:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725813AbgC2EQT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 29 Mar 2020 00:16:19 -0400
Received: from mga14.intel.com ([192.55.52.115]:5334 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725379AbgC2EQT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 29 Mar 2020 00:16:19 -0400
IronPort-SDR: pmFtZUBywvTJ5fPzw0nBVwifOojqh2qRY9nQlIcrp4d9TCeyN9/zUQHB1JpeCpuU0Jog18JyK9
 bbxA7e05M8lA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2020 21:16:18 -0700
IronPort-SDR: iAFSpWHKi/C7rKxvVEP3Z7jwmutL6/CVRmQ3yoDjTYkWZuSH3vF/TO/Y9PgpVT2wSihlCIk4Ur
 6ojJH8ly+ZSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,318,1580803200"; 
   d="scan'208";a="241312612"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 28 Mar 2020 21:16:17 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jIPMu-0007iz-H1; Sun, 29 Mar 2020 12:16:16 +0800
Date:   Sun, 29 Mar 2020 12:15:58 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:pci/aspm] BUILD SUCCESS
 3b364c659bd38fa07b4f035eeb3c15469a39b0d6
Message-ID: <5e8020fe.+1rmNp+CED3SF7oX%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git  pci/aspm
branch HEAD: 3b364c659bd38fa07b4f035eeb3c15469a39b0d6  PCI/ASPM: Reduce severity of common clock config message

elapsed time: 483m

configs tested: 148
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

arm64                             allnoconfig
arm                               allnoconfig
arm                              allmodconfig
arm64                            allmodconfig
arm                           efm32_defconfig
arm                         at91_dt_defconfig
arm                        shmobile_defconfig
arm64                               defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                           sunxi_defconfig
arm                        multi_v7_defconfig
sparc                            allyesconfig
ia64                             allmodconfig
nds32                             allnoconfig
um                             i386_defconfig
mips                              allnoconfig
parisc                generic-64bit_defconfig
ia64                                defconfig
m68k                          multi_defconfig
xtensa                          iss_defconfig
s390                             alldefconfig
i386                              allnoconfig
m68k                           sun3_defconfig
i386                                defconfig
um                                  defconfig
s390                              allnoconfig
nios2                         3c120_defconfig
c6x                        evmc6678_defconfig
sparc64                           allnoconfig
riscv                    nommu_virt_defconfig
sh                            titan_defconfig
csky                                defconfig
powerpc                             defconfig
i386                             alldefconfig
i386                             allyesconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                             alldefconfig
c6x                              allyesconfig
nios2                         10m50_defconfig
openrisc                    or1ksim_defconfig
openrisc                 simple_smp_defconfig
xtensa                       common_defconfig
nds32                               defconfig
alpha                               defconfig
h8300                     edosk2674_defconfig
h8300                    h8300h-sim_defconfig
h8300                       h8s-sim_defconfig
m68k                       m5475evb_defconfig
m68k                             allmodconfig
arc                                 defconfig
arc                              allyesconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
mips                             allyesconfig
mips                         64r6el_defconfig
mips                           32r2_defconfig
mips                             allmodconfig
parisc                            allnoconfig
parisc                generic-32bit_defconfig
parisc                           allyesconfig
i386                 randconfig-a002-20200329
x86_64               randconfig-a001-20200329
i386                 randconfig-a001-20200329
i386                 randconfig-a003-20200329
nds32                randconfig-a001-20200329
mips                 randconfig-a001-20200329
parisc               randconfig-a001-20200329
m68k                 randconfig-a001-20200329
alpha                randconfig-a001-20200329
riscv                randconfig-a001-20200329
h8300                randconfig-a001-20200329
nios2                randconfig-a001-20200329
sparc64              randconfig-a001-20200329
c6x                  randconfig-a001-20200329
microblaze           randconfig-a001-20200329
s390                 randconfig-a001-20200329
xtensa               randconfig-a001-20200329
csky                 randconfig-a001-20200329
openrisc             randconfig-a001-20200329
sh                   randconfig-a001-20200329
i386                 randconfig-b003-20200329
x86_64               randconfig-b003-20200329
i386                 randconfig-b001-20200329
i386                 randconfig-b002-20200329
x86_64               randconfig-b002-20200329
x86_64               randconfig-b001-20200329
x86_64               randconfig-c001-20200329
x86_64               randconfig-c002-20200329
x86_64               randconfig-c003-20200329
i386                 randconfig-c001-20200329
i386                 randconfig-c002-20200329
i386                 randconfig-c003-20200329
x86_64               randconfig-d001-20200329
x86_64               randconfig-d002-20200329
x86_64               randconfig-d003-20200329
i386                 randconfig-d001-20200329
i386                 randconfig-d002-20200329
i386                 randconfig-d003-20200329
x86_64               randconfig-e001-20200329
i386                 randconfig-e002-20200329
x86_64               randconfig-e003-20200329
i386                 randconfig-e003-20200329
x86_64               randconfig-e002-20200329
i386                 randconfig-e001-20200329
x86_64               randconfig-h002-20200329
x86_64               randconfig-h003-20200329
i386                 randconfig-h003-20200329
x86_64               randconfig-h001-20200329
i386                 randconfig-h001-20200329
i386                 randconfig-h002-20200329
arc                  randconfig-a001-20200329
arm                  randconfig-a001-20200329
arm64                randconfig-a001-20200329
ia64                 randconfig-a001-20200329
powerpc              randconfig-a001-20200329
sparc                randconfig-a001-20200329
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allyesconfig
riscv                            allmodconfig
s390                             allmodconfig
s390                             allyesconfig
s390                          debug_defconfig
s390                                defconfig
s390                       zfcpdump_defconfig
sh                          rsk7269_defconfig
sh                               allmodconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
um                           x86_64_defconfig
x86_64                                   rhel
x86_64                               rhel-7.6
x86_64                         rhel-7.2-clear
x86_64                                    lkp
x86_64                              fedora-25
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
