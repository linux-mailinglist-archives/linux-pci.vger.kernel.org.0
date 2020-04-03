Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D66D19E1AE
	for <lists+linux-pci@lfdr.de>; Sat,  4 Apr 2020 01:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgDCX6b (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Apr 2020 19:58:31 -0400
Received: from mga06.intel.com ([134.134.136.31]:26026 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbgDCX6b (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 3 Apr 2020 19:58:31 -0400
IronPort-SDR: Z4o5JWBAuPmcwVxzY5fKpAgM3PS8AwLZbF6RDpzMiSCxt6j57Ru3orD+TE5Idx7kUhHDIBtvx6
 ywV5wbD0VUYg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2020 16:58:30 -0700
IronPort-SDR: RgDOpAa6DfVk4XY7bQXW3qPOyZ03F0tEPgPrXibGPn+1goyC+WJv/iz5z+8kgHyQN+KbvIm+7n
 7cafju9UQXGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,341,1580803200"; 
   d="scan'208";a="241257615"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 03 Apr 2020 16:58:29 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jKWCi-0000sR-PU; Sat, 04 Apr 2020 07:58:28 +0800
Date:   Sat, 04 Apr 2020 07:58:13 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS 86ce3c90c910110540ac25cae5d9b90b268542bd
Message-ID: <5e87cd95./h+g68JSbYvh8Kw5%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git  next
branch HEAD: 86ce3c90c910110540ac25cae5d9b90b268542bd  Merge branch 'remotes/lorenzo/pci/vmd'

elapsed time: 1706m

configs tested: 127
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
mips                             allyesconfig
mips                              allnoconfig
mips                           32r2_defconfig
mips                             allmodconfig
parisc                            allnoconfig
x86_64               randconfig-a003-20200403
i386                 randconfig-a002-20200403
x86_64               randconfig-a002-20200403
x86_64               randconfig-a001-20200403
i386                 randconfig-a003-20200403
i386                 randconfig-a001-20200403
nds32                randconfig-a001-20200403
m68k                 randconfig-a001-20200403
alpha                randconfig-a001-20200403
parisc               randconfig-a001-20200403
riscv                randconfig-a001-20200403
sparc64              randconfig-a001-20200403
h8300                randconfig-a001-20200403
nios2                randconfig-a001-20200403
microblaze           randconfig-a001-20200403
c6x                  randconfig-a001-20200403
s390                 randconfig-a001-20200403
xtensa               randconfig-a001-20200403
csky                 randconfig-a001-20200403
openrisc             randconfig-a001-20200403
sh                   randconfig-a001-20200403
i386                 randconfig-b003-20200403
x86_64               randconfig-b001-20200403
i386                 randconfig-b001-20200403
i386                 randconfig-b002-20200403
i386                 randconfig-c001-20200403
i386                 randconfig-c003-20200403
x86_64               randconfig-c002-20200403
i386                 randconfig-c002-20200403
x86_64               randconfig-c001-20200403
x86_64               randconfig-d001-20200403
i386                 randconfig-d003-20200403
i386                 randconfig-d001-20200403
i386                 randconfig-d002-20200403
i386                 randconfig-e001-20200403
x86_64               randconfig-e002-20200403
i386                 randconfig-e003-20200403
x86_64               randconfig-e003-20200403
i386                 randconfig-e002-20200403
x86_64               randconfig-g003-20200403
i386                 randconfig-g003-20200403
x86_64               randconfig-g002-20200403
i386                 randconfig-g001-20200403
i386                 randconfig-g002-20200403
x86_64               randconfig-g001-20200403
x86_64               randconfig-h002-20200404
i386                 randconfig-h002-20200404
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
sh                               allmodconfig
sh                            titan_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
um                                  defconfig
um                             i386_defconfig
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
