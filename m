Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BDCA196C69
	for <lists+linux-pci@lfdr.de>; Sun, 29 Mar 2020 12:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbgC2KZc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 29 Mar 2020 06:25:32 -0400
Received: from mga07.intel.com ([134.134.136.100]:23004 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726087AbgC2KZc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 29 Mar 2020 06:25:32 -0400
IronPort-SDR: Kwd9/nuBPRTmQx6PNneAQIbfXcmbvGyUu/hzbxmdVUe5EgNW4z2dCNtpxP1ABX0yKpSFcRaRvh
 +DEeKPBh9o2g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2020 03:25:31 -0700
IronPort-SDR: zIhFIkJ0H9lLMquQqnAd61FE17bNoypICXGS4OxjjwxFhNFJ1wpTu4A3E3a+W2aFPtz51FyCs6
 wA+kImPEqi5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,319,1580803200"; 
   d="scan'208";a="394827248"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 29 Mar 2020 03:25:30 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jIV8D-000GDm-JJ; Sun, 29 Mar 2020 18:25:29 +0800
Date:   Sun, 29 Mar 2020 18:24:39 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:pci/virtualization] BUILD SUCCESS
 299bd044a6f332b4a6c8f708575c27cad70a35c1
Message-ID: <5e807767.iy7eG+plIIK6t7ed%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git  pci/virtualization
branch HEAD: 299bd044a6f332b4a6c8f708575c27cad70a35c1  PCI: Add ACS quirk for Zhaoxin Root/Downstream Ports

elapsed time: 730m

configs tested: 151
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                              allmodconfig
arm                               allnoconfig
arm                              allyesconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm64                            allyesconfig
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
parisc                generic-64bit_defconfig
s390                              allnoconfig
ia64                                defconfig
s390                             alldefconfig
arc                              allyesconfig
um                             i386_defconfig
mips                      fuloong2e_defconfig
powerpc                           allnoconfig
mips                              allnoconfig
sparc64                             defconfig
i386                                defconfig
m68k                          multi_defconfig
xtensa                          iss_defconfig
s390                          debug_defconfig
nds32                               defconfig
i386                              allnoconfig
m68k                           sun3_defconfig
um                                  defconfig
riscv                    nommu_virt_defconfig
sh                            titan_defconfig
c6x                        evmc6678_defconfig
csky                                defconfig
powerpc                             defconfig
h8300                     edosk2674_defconfig
i386                             alldefconfig
i386                             allyesconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                             alldefconfig
c6x                              allyesconfig
nios2                         10m50_defconfig
nios2                         3c120_defconfig
openrisc                    or1ksim_defconfig
openrisc                 simple_smp_defconfig
xtensa                       common_defconfig
alpha                               defconfig
h8300                    h8300h-sim_defconfig
h8300                       h8s-sim_defconfig
m68k                       m5475evb_defconfig
m68k                             allmodconfig
arc                                 defconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
mips                             allyesconfig
mips                           32r2_defconfig
mips                             allmodconfig
mips                         64r6el_defconfig
mips                      malta_kvm_defconfig
parisc                            allnoconfig
parisc                generic-32bit_defconfig
parisc                           allyesconfig
i386                 randconfig-a002-20200329
x86_64               randconfig-a001-20200329
i386                 randconfig-a001-20200329
i386                 randconfig-a003-20200329
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
x86_64               randconfig-c001-20200329
x86_64               randconfig-c002-20200329
x86_64               randconfig-c003-20200329
i386                 randconfig-c001-20200329
i386                 randconfig-c002-20200329
i386                 randconfig-c003-20200329
i386                 randconfig-d003-20200329
i386                 randconfig-d001-20200329
x86_64               randconfig-d002-20200329
i386                 randconfig-d002-20200329
x86_64               randconfig-d001-20200329
x86_64               randconfig-d003-20200329
x86_64               randconfig-e001-20200329
x86_64               randconfig-e002-20200329
i386                 randconfig-e001-20200329
i386                 randconfig-e002-20200329
i386                 randconfig-e003-20200329
x86_64               randconfig-e003-20200329
i386                 randconfig-f001-20200329
i386                 randconfig-f003-20200329
i386                 randconfig-f002-20200329
x86_64               randconfig-f002-20200329
x86_64               randconfig-f001-20200329
x86_64               randconfig-h001-20200329
x86_64               randconfig-h002-20200329
i386                 randconfig-h001-20200329
i386                 randconfig-h002-20200329
i386                 randconfig-h003-20200329
x86_64               randconfig-h003-20200329
arm                  randconfig-a001-20200329
arm64                randconfig-a001-20200329
ia64                 randconfig-a001-20200329
sparc                randconfig-a001-20200329
arc                  randconfig-a001-20200329
powerpc              randconfig-a001-20200329
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allyesconfig
s390                             allmodconfig
s390                             allyesconfig
s390                                defconfig
s390                       zfcpdump_defconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sparc                               defconfig
sparc64                           allnoconfig
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
