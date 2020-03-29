Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAD2F196AF8
	for <lists+linux-pci@lfdr.de>; Sun, 29 Mar 2020 06:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725834AbgC2EQT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 29 Mar 2020 00:16:19 -0400
Received: from mga04.intel.com ([192.55.52.120]:3936 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725379AbgC2EQT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 29 Mar 2020 00:16:19 -0400
IronPort-SDR: UxejP+B0ckjJTzb7GB0kkLX8T83o2x4KvL3obqMQRoFNWz7EBsNXSKgYASvEe2XPiP/WMEiD4h
 tueX/45z8aOw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2020 21:16:19 -0700
IronPort-SDR: q5mS3oOdHdfFzDEBK7C171TNTFS1KIxzTDZd2dk3KoHjZjy0ErMNJ7T5m1Fv59u239wZO3Swjt
 pg6+4YyxJGag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,318,1580803200"; 
   d="scan'208";a="358861632"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 28 Mar 2020 21:16:18 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jIPMv-0007ok-BX; Sun, 29 Mar 2020 12:16:17 +0800
Date:   Sun, 29 Mar 2020 12:15:54 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:pci/misc] BUILD SUCCESS
 bce34ce1806edf4e1f42f2429657418e81db4917
Message-ID: <5e8020fa.HhQVX3PlxEcr7EBk%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git  pci/misc
branch HEAD: bce34ce1806edf4e1f42f2429657418e81db4917  PCI: sysfs: Revert "rescan" file renames

elapsed time: 485m

configs tested: 151
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

arm64                            allyesconfig
arm                              allyesconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm                               allnoconfig
arm                              allmodconfig
arm                           efm32_defconfig
arm                         at91_dt_defconfig
arm                        shmobile_defconfig
arm64                               defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                           sunxi_defconfig
arm                        multi_v7_defconfig
sparc                            allyesconfig
um                             i386_defconfig
mips                              allnoconfig
nds32                             allnoconfig
parisc                generic-64bit_defconfig
ia64                                defconfig
s390                             alldefconfig
i386                              allnoconfig
m68k                           sun3_defconfig
i386                                defconfig
s390                              allnoconfig
m68k                          multi_defconfig
nios2                         3c120_defconfig
c6x                        evmc6678_defconfig
sparc64                           allnoconfig
sh                            titan_defconfig
riscv                            allmodconfig
i386                             alldefconfig
i386                             allyesconfig
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
c6x                              allyesconfig
nios2                         10m50_defconfig
openrisc                    or1ksim_defconfig
openrisc                 simple_smp_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
h8300                     edosk2674_defconfig
h8300                    h8300h-sim_defconfig
h8300                       h8s-sim_defconfig
m68k                       m5475evb_defconfig
m68k                             allmodconfig
arc                                 defconfig
arc                              allyesconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
mips                             allyesconfig
mips                             allmodconfig
parisc                            allnoconfig
parisc                generic-32bit_defconfig
parisc                           allyesconfig
alpha                randconfig-a001-20200329
m68k                 randconfig-a001-20200329
mips                 randconfig-a001-20200329
nds32                randconfig-a001-20200329
parisc               randconfig-a001-20200329
riscv                randconfig-a001-20200329
c6x                  randconfig-a001-20200329
h8300                randconfig-a001-20200329
microblaze           randconfig-a001-20200329
nios2                randconfig-a001-20200329
sparc64              randconfig-a001-20200329
h8300                randconfig-a001-20200327
microblaze           randconfig-a001-20200327
nios2                randconfig-a001-20200327
c6x                  randconfig-a001-20200327
sparc64              randconfig-a001-20200327
s390                 randconfig-a001-20200329
xtensa               randconfig-a001-20200329
csky                 randconfig-a001-20200329
openrisc             randconfig-a001-20200329
sh                   randconfig-a001-20200329
x86_64               randconfig-b001-20200329
x86_64               randconfig-b002-20200329
x86_64               randconfig-b003-20200329
i386                 randconfig-b001-20200329
i386                 randconfig-b002-20200329
i386                 randconfig-b003-20200329
x86_64               randconfig-c003-20200329
i386                 randconfig-c002-20200329
x86_64               randconfig-c001-20200329
x86_64               randconfig-c002-20200329
i386                 randconfig-c003-20200329
i386                 randconfig-c001-20200329
x86_64               randconfig-d001-20200329
x86_64               randconfig-d002-20200329
x86_64               randconfig-d003-20200329
i386                 randconfig-d001-20200329
i386                 randconfig-d002-20200329
i386                 randconfig-d003-20200329
x86_64               randconfig-e001-20200329
x86_64               randconfig-e002-20200329
i386                 randconfig-e001-20200329
i386                 randconfig-e002-20200329
i386                 randconfig-e003-20200329
x86_64               randconfig-e003-20200329
x86_64               randconfig-h001-20200329
x86_64               randconfig-h002-20200329
x86_64               randconfig-h003-20200329
i386                 randconfig-h001-20200329
i386                 randconfig-h002-20200329
i386                 randconfig-h003-20200329
arc                  randconfig-a001-20200329
arm                  randconfig-a001-20200329
arm64                randconfig-a001-20200329
ia64                 randconfig-a001-20200329
powerpc              randconfig-a001-20200329
sparc                randconfig-a001-20200329
riscv                             allnoconfig
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                            allyesconfig
s390                       zfcpdump_defconfig
s390                          debug_defconfig
s390                             allyesconfig
s390                             allmodconfig
s390                                defconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                               allmodconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
um                           x86_64_defconfig
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
