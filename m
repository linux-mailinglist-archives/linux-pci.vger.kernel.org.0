Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69A9519A486
	for <lists+linux-pci@lfdr.de>; Wed,  1 Apr 2020 07:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbgDAFNK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Apr 2020 01:13:10 -0400
Received: from mga02.intel.com ([134.134.136.20]:53569 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726811AbgDAFNK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 1 Apr 2020 01:13:10 -0400
IronPort-SDR: BWQFi+BUyUOSRdkG180hrd55gGnO+6nZBQmePyZYYxhDM6Kp1PKUHvevB3IcPst+XV78sZ1peU
 Pe+KXxpUwWew==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2020 22:13:09 -0700
IronPort-SDR: 6DX7uPXUd5Fxs5UnAUjxDU4PlOX8T7BoBTmtTZ50vdYblHXb26yq8SmHdD4o98Wxom44lv0QQt
 QtsVKoQOspjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,330,1580803200"; 
   d="scan'208";a="284260384"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 31 Mar 2020 22:13:08 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jJVgZ-000IGS-MZ; Wed, 01 Apr 2020 13:13:07 +0800
Date:   Wed, 01 Apr 2020 13:12:40 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS 505d60df262305d1318a8a30cd67752d18462c17
Message-ID: <5e8422c8.h6K++MHFNrutyl6r%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git  next
branch HEAD: 505d60df262305d1318a8a30cd67752d18462c17  Merge branch 'remotes/lorenzo/pci/vmd'

elapsed time: 825m

configs tested: 142
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

arm64                            allyesconfig
arm                              allyesconfig
arm64                            allmodconfig
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
i386                                defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                             alldefconfig
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
mips                             allyesconfig
mips                              allnoconfig
mips                           32r2_defconfig
mips                             allmodconfig
parisc                            allnoconfig
parisc                generic-64bit_defconfig
parisc                generic-32bit_defconfig
parisc                           allyesconfig
x86_64               randconfig-a003-20200331
x86_64               randconfig-a002-20200331
i386                 randconfig-a001-20200331
i386                 randconfig-a002-20200331
i386                 randconfig-a003-20200331
x86_64               randconfig-a001-20200331
microblaze           randconfig-a001-20200331
h8300                randconfig-a001-20200331
nios2                randconfig-a001-20200331
c6x                  randconfig-a001-20200331
sparc64              randconfig-a001-20200331
csky                 randconfig-a001-20200331
s390                 randconfig-a001-20200331
xtensa               randconfig-a001-20200331
openrisc             randconfig-a001-20200331
sh                   randconfig-a001-20200331
x86_64               randconfig-b003-20200331
i386                 randconfig-b003-20200331
i386                 randconfig-b002-20200331
i386                 randconfig-b001-20200331
x86_64               randconfig-b002-20200331
x86_64               randconfig-b001-20200331
i386                 randconfig-d003-20200331
i386                 randconfig-d001-20200331
i386                 randconfig-d002-20200331
x86_64               randconfig-d001-20200331
x86_64               randconfig-d002-20200331
x86_64               randconfig-e001-20200331
i386                 randconfig-e002-20200331
x86_64               randconfig-e003-20200331
i386                 randconfig-e003-20200331
x86_64               randconfig-e002-20200331
i386                 randconfig-e001-20200331
i386                 randconfig-f001-20200401
i386                 randconfig-f003-20200401
x86_64               randconfig-f003-20200401
x86_64               randconfig-f001-20200401
i386                 randconfig-f002-20200401
x86_64               randconfig-f002-20200401
x86_64               randconfig-g002-20200331
x86_64               randconfig-g003-20200331
i386                 randconfig-g001-20200331
i386                 randconfig-g002-20200331
x86_64               randconfig-g001-20200331
i386                 randconfig-g003-20200331
x86_64               randconfig-h003-20200331
x86_64               randconfig-h002-20200331
x86_64               randconfig-h001-20200331
i386                 randconfig-h003-20200331
i386                 randconfig-h002-20200331
i386                 randconfig-h001-20200331
sparc                randconfig-a001-20200331
arm64                randconfig-a001-20200331
powerpc              randconfig-a001-20200331
ia64                 randconfig-a001-20200331
arc                  randconfig-a001-20200331
arm                  randconfig-a001-20200331
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
i386                             alldefconfig
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
