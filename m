Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 571CB18D799
	for <lists+linux-pci@lfdr.de>; Fri, 20 Mar 2020 19:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgCTSrP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Mar 2020 14:47:15 -0400
Received: from mga11.intel.com ([192.55.52.93]:22472 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgCTSrP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Mar 2020 14:47:15 -0400
IronPort-SDR: Y3DtsNcJmb6W5zyKHa9L4ifO6imI4MbVrE9RsK2GESIJ8GEIJmNa3aYZDTg6+4nRPIOLGuEQpN
 cOR3rsyyIKlA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2020 11:47:14 -0700
IronPort-SDR: IiHoybRbURhXsMne0PsjLwxxpKqqIsmwnQFrkRqDMBLyh3UUCBcflEi/FAO7bh9xLzQpK6hljI
 lb8vUAOKF8/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,285,1580803200"; 
   d="scan'208";a="291991312"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Mar 2020 11:47:13 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jFMfp-000Gi6-1N; Sat, 21 Mar 2020 02:47:13 +0800
Date:   Sat, 21 Mar 2020 02:46:51 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:review/edr] BUILD SUCCESS
 aa898fd0720c1521407eb52a3f954da0954c1ae5
Message-ID: <5e750f9b.ig/tdfmHh6l55iE+%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git  review/edr
branch HEAD: aa898fd0720c1521407eb52a3f954da0954c1ae5  PCI/AER: Rationalize error status register clearing

elapsed time: 1187m

configs tested: 151
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
i386                             alldefconfig
i386                             allyesconfig
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
i386                 randconfig-a002-20200320
x86_64               randconfig-a002-20200320
i386                 randconfig-a001-20200320
x86_64               randconfig-a001-20200320
i386                 randconfig-a003-20200320
x86_64               randconfig-a003-20200320
riscv                randconfig-a001-20200319
m68k                 randconfig-a001-20200319
nds32                randconfig-a001-20200319
alpha                randconfig-a001-20200319
parisc               randconfig-a001-20200319
mips                 randconfig-a001-20200319
h8300                randconfig-a001-20200319
sparc64              randconfig-a001-20200319
c6x                  randconfig-a001-20200319
nios2                randconfig-a001-20200319
microblaze           randconfig-a001-20200319
csky                 randconfig-a001-20200319
openrisc             randconfig-a001-20200319
s390                 randconfig-a001-20200319
sh                   randconfig-a001-20200319
xtensa               randconfig-a001-20200319
i386                 randconfig-b003-20200320
i386                 randconfig-b001-20200320
x86_64               randconfig-b003-20200320
i386                 randconfig-b002-20200320
x86_64               randconfig-b002-20200320
x86_64               randconfig-b001-20200320
x86_64               randconfig-c003-20200320
i386                 randconfig-c002-20200320
x86_64               randconfig-c001-20200320
x86_64               randconfig-c002-20200320
i386                 randconfig-c003-20200320
i386                 randconfig-c001-20200320
i386                 randconfig-d003-20200320
i386                 randconfig-d001-20200320
x86_64               randconfig-d002-20200320
i386                 randconfig-d002-20200320
x86_64               randconfig-d001-20200320
x86_64               randconfig-d003-20200320
i386                 randconfig-f001-20200320
i386                 randconfig-f003-20200320
i386                 randconfig-f002-20200320
x86_64               randconfig-f002-20200320
x86_64               randconfig-f003-20200320
x86_64               randconfig-f001-20200320
i386                 randconfig-g003-20200320
x86_64               randconfig-g002-20200320
i386                 randconfig-g001-20200320
i386                 randconfig-g002-20200320
x86_64               randconfig-g001-20200320
x86_64               randconfig-g003-20200320
arc                  randconfig-a001-20200319
ia64                 randconfig-a001-20200319
arm                  randconfig-a001-20200319
arm64                randconfig-a001-20200319
sparc                randconfig-a001-20200319
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
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                         rhel-7.2-clear
x86_64                               rhel-7.6

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
