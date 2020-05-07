Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 722411C80D4
	for <lists+linux-pci@lfdr.de>; Thu,  7 May 2020 06:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbgEGEXk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 May 2020 00:23:40 -0400
Received: from mga11.intel.com ([192.55.52.93]:38800 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbgEGEXk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 May 2020 00:23:40 -0400
IronPort-SDR: T3WZV/YROzSe2aLAtPI+J4MurzPulK0dWON1Vq2sXDdZ+lgajmMhZuUayqpud1j/Zw5GR3hvjx
 kg6I5YsoK//w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2020 21:23:39 -0700
IronPort-SDR: t0Ge35B9v84KvZBAmt5jr/ZtSc+em6/sCVQM4ZlRt5E+E5CMwsZ+PfCM3rMFsMaTADEEGXYmnY
 wtzPxt33iHxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,362,1583222400"; 
   d="scan'208";a="284858266"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 06 May 2020 21:23:38 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jWY4P-000Gws-Jy; Thu, 07 May 2020 12:23:37 +0800
Date:   Thu, 07 May 2020 12:23:16 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS caf76ec7adb06c46ec89f7a381d3694acf5d0156
Message-ID: <5eb38d34.FKe2LcadQPty55tY%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git  next
branch HEAD: caf76ec7adb06c46ec89f7a381d3694acf5d0156  Merge branch 'remotes/lorenzo/pci/v3-semi'

elapsed time: 480m

configs tested: 190
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

arm64                            allyesconfig
arm64                            allmodconfig
arm                              allmodconfig
arm                               allnoconfig
arm                              allyesconfig
arm64                             allnoconfig
sparc                            allyesconfig
m68k                             allyesconfig
ia64                             allyesconfig
i386                              allnoconfig
s390                             allmodconfig
csky                             allyesconfig
mips                             allyesconfig
riscv                               defconfig
sparc                               defconfig
powerpc                             defconfig
s390                             alldefconfig
h8300                            allmodconfig
m68k                             allmodconfig
ia64                             alldefconfig
sparc64                          allmodconfig
um                                  defconfig
um                               allmodconfig
nds32                               defconfig
i386                             allyesconfig
i386                             alldefconfig
i386                                defconfig
i386                              debian-10.3
ia64                             allmodconfig
ia64                                defconfig
ia64                              allnoconfig
m68k                           sun3_defconfig
m68k                          multi_defconfig
m68k                                defconfig
nios2                               defconfig
nios2                            allyesconfig
openrisc                            defconfig
c6x                              allyesconfig
c6x                               allnoconfig
openrisc                         allyesconfig
nds32                             allnoconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
xtensa                              defconfig
arc                                 defconfig
arc                              allyesconfig
microblaze                       allyesconfig
sh                               allmodconfig
sh                                allnoconfig
microblaze                        allnoconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                           32r2_defconfig
mips                             allmodconfig
parisc                            allnoconfig
parisc                           allyesconfig
parisc                           allmodconfig
powerpc                          allyesconfig
powerpc                          alldefconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
m68k                 randconfig-a001-20200506
mips                 randconfig-a001-20200506
nds32                randconfig-a001-20200506
parisc               randconfig-a001-20200506
alpha                randconfig-a001-20200506
riscv                randconfig-a001-20200506
m68k                 randconfig-a001-20200507
mips                 randconfig-a001-20200507
nds32                randconfig-a001-20200507
parisc               randconfig-a001-20200507
alpha                randconfig-a001-20200507
riscv                randconfig-a001-20200507
h8300                randconfig-a001-20200506
nios2                randconfig-a001-20200506
microblaze           randconfig-a001-20200506
c6x                  randconfig-a001-20200506
sparc64              randconfig-a001-20200506
h8300                randconfig-a001-20200507
nios2                randconfig-a001-20200507
microblaze           randconfig-a001-20200507
c6x                  randconfig-a001-20200507
sparc64              randconfig-a001-20200507
s390                 randconfig-a001-20200506
xtensa               randconfig-a001-20200506
sh                   randconfig-a001-20200506
openrisc             randconfig-a001-20200506
csky                 randconfig-a001-20200506
xtensa               randconfig-a001-20200507
sh                   randconfig-a001-20200507
openrisc             randconfig-a001-20200507
csky                 randconfig-a001-20200507
i386                 randconfig-b003-20200506
i386                 randconfig-b001-20200506
x86_64               randconfig-b001-20200506
x86_64               randconfig-b003-20200506
i386                 randconfig-b002-20200506
i386                 randconfig-b003-20200507
x86_64               randconfig-b002-20200507
i386                 randconfig-b001-20200507
x86_64               randconfig-b001-20200507
x86_64               randconfig-b003-20200507
i386                 randconfig-b002-20200507
x86_64               randconfig-a003-20200506
x86_64               randconfig-a001-20200506
x86_64               randconfig-a002-20200506
i386                 randconfig-a001-20200506
i386                 randconfig-a002-20200506
i386                 randconfig-a003-20200506
x86_64               randconfig-c002-20200507
x86_64               randconfig-c001-20200507
i386                 randconfig-c002-20200507
i386                 randconfig-c003-20200507
x86_64               randconfig-c003-20200507
i386                 randconfig-c001-20200507
i386                 randconfig-d003-20200506
i386                 randconfig-d001-20200506
x86_64               randconfig-d002-20200506
i386                 randconfig-d002-20200506
x86_64               randconfig-d001-20200507
i386                 randconfig-d003-20200507
i386                 randconfig-d001-20200507
x86_64               randconfig-d003-20200507
x86_64               randconfig-d002-20200507
i386                 randconfig-d002-20200507
i386                 randconfig-e003-20200506
x86_64               randconfig-e003-20200506
x86_64               randconfig-e001-20200506
i386                 randconfig-e002-20200506
i386                 randconfig-e001-20200506
i386                 randconfig-e003-20200507
x86_64               randconfig-e003-20200507
x86_64               randconfig-e002-20200507
x86_64               randconfig-e001-20200507
i386                 randconfig-e002-20200507
i386                 randconfig-e001-20200507
i386                 randconfig-f003-20200507
x86_64               randconfig-f002-20200507
i386                 randconfig-f001-20200507
i386                 randconfig-f002-20200507
x86_64               randconfig-g003-20200506
i386                 randconfig-g003-20200506
i386                 randconfig-g002-20200506
x86_64               randconfig-g001-20200506
i386                 randconfig-g001-20200506
x86_64               randconfig-g002-20200506
i386                 randconfig-h002-20200506
i386                 randconfig-h001-20200506
i386                 randconfig-h003-20200506
x86_64               randconfig-h002-20200506
x86_64               randconfig-h003-20200506
x86_64               randconfig-h001-20200506
x86_64               randconfig-a002-20200507
i386                 randconfig-a001-20200507
i386                 randconfig-a002-20200507
i386                 randconfig-a003-20200507
ia64                 randconfig-a001-20200506
arm64                randconfig-a001-20200506
arc                  randconfig-a001-20200506
powerpc              randconfig-a001-20200506
arm                  randconfig-a001-20200506
sparc                randconfig-a001-20200506
ia64                 randconfig-a001-20200507
arm64                randconfig-a001-20200507
arc                  randconfig-a001-20200507
arm                  randconfig-a001-20200507
sparc                randconfig-a001-20200507
riscv                            allyesconfig
riscv                             allnoconfig
riscv                            allmodconfig
s390                             allyesconfig
s390                              allnoconfig
s390                                defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
um                           x86_64_defconfig
um                             i386_defconfig
um                               allyesconfig
x86_64                                   rhel
x86_64                               rhel-7.6
x86_64                    rhel-7.6-kselftests
x86_64                         rhel-7.2-clear
x86_64                                    lkp
x86_64                              fedora-25
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
