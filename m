Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D01032188B8
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jul 2020 15:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729383AbgGHNPi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jul 2020 09:15:38 -0400
Received: from mga04.intel.com ([192.55.52.120]:35213 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729390AbgGHNPh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 8 Jul 2020 09:15:37 -0400
IronPort-SDR: PoZoncMj5czhTNzZS7aBr93vK66RjZW73fA3ujRSMAx4bQBIhvkls3W+bPEGG7gUZR93BExlCi
 16GTRoSCkofw==
X-IronPort-AV: E=McAfee;i="6000,8403,9675"; a="145291864"
X-IronPort-AV: E=Sophos;i="5.75,327,1589266800"; 
   d="scan'208";a="145291864"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2020 06:15:32 -0700
IronPort-SDR: RQTCDoy3FVSToSblRsL2E8qgwYTgI0RvTIB0rHnTHfcsDkRzODJcQh/N50mRobweGopYkt1iiO
 pT4Ftm3fAuxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,327,1589266800"; 
   d="scan'208";a="297714158"
Received: from lkp-server01.sh.intel.com (HELO 6136dd46483e) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 08 Jul 2020 06:15:31 -0700
Received: from kbuild by 6136dd46483e with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jt9v8-000088-Ge; Wed, 08 Jul 2020 13:15:30 +0000
Date:   Wed, 08 Jul 2020 21:14:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:pci/enumeration] BUILD SUCCESS
 2194bc7c39610be7cabe7456c5f63a570604f015
Message-ID: <5f05c6b5.kAPxmvzqAOYWZSOF%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git  pci/enumeration
branch HEAD: 2194bc7c39610be7cabe7456c5f63a570604f015  PCI: Add device even if driver attach failed

elapsed time: 730m

configs tested: 100
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm                               allnoconfig
arm                              allmodconfig
arm                              allyesconfig
arm64                            allyesconfig
arm64                               defconfig
arm64                            allmodconfig
arm64                             allnoconfig
nios2                               defconfig
powerpc                     pq2fads_defconfig
mips                     decstation_defconfig
powerpc                      ppc40x_defconfig
sh                                allnoconfig
arm                         nhk8815_defconfig
s390                       zfcpdump_defconfig
nios2                            alldefconfig
sh                          r7785rp_defconfig
arm                        trizeps4_defconfig
powerpc                      pasemi_defconfig
arm                        cerfcube_defconfig
xtensa                          iss_defconfig
sh                           se7343_defconfig
arm                          ixp4xx_defconfig
sh                           se7780_defconfig
i386                              allnoconfig
i386                             allyesconfig
i386                                defconfig
i386                              debian-10.3
ia64                             allmodconfig
ia64                                defconfig
ia64                              allnoconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                              allnoconfig
m68k                           sun3_defconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                            allyesconfig
openrisc                            defconfig
c6x                              allyesconfig
c6x                               allnoconfig
openrisc                         allyesconfig
nds32                               defconfig
nds32                             allnoconfig
csky                             allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
h8300                            allmodconfig
xtensa                              defconfig
arc                                 defconfig
arc                              allyesconfig
sh                               allmodconfig
microblaze                        allnoconfig
mips                             allyesconfig
mips                              allnoconfig
mips                             allmodconfig
parisc                            allnoconfig
parisc                              defconfig
parisc                           allyesconfig
parisc                           allmodconfig
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20200707
i386                 randconfig-a002-20200707
i386                 randconfig-a006-20200707
i386                 randconfig-a004-20200707
i386                 randconfig-a005-20200707
i386                 randconfig-a003-20200707
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
um                                allnoconfig
um                                  defconfig
um                               allmodconfig
um                               allyesconfig
x86_64                               rhel-7.6
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                                   rhel
x86_64                         rhel-7.2-clear
x86_64                                    lkp
x86_64                              fedora-25

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
