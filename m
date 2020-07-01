Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07CB9210BD9
	for <lists+linux-pci@lfdr.de>; Wed,  1 Jul 2020 15:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729326AbgGANLl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Jul 2020 09:11:41 -0400
Received: from mga17.intel.com ([192.55.52.151]:40733 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728159AbgGANLl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 1 Jul 2020 09:11:41 -0400
IronPort-SDR: w69TA5H6Z6568DEYe0gTeYAhBGrD+ZySfU5+V2upIZ9Ep2VudSwcM4Xo1bOM7oJ/+iag4yB2p9
 5eTZluPe5NsQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9668"; a="126656594"
X-IronPort-AV: E=Sophos;i="5.75,300,1589266800"; 
   d="scan'208";a="126656594"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2020 06:11:40 -0700
IronPort-SDR: yHpQb4Yuv56uBk24g7xkUfdQ3GjAA8lmrOe6Yo7UHQJcNXKguoinXCkhWijSovaJdUiKv+ooWX
 NpbL4kpYPSkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,300,1589266800"; 
   d="scan'208";a="387002543"
Received: from lkp-server01.sh.intel.com (HELO 28879958b202) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 01 Jul 2020 06:11:39 -0700
Received: from kbuild by 28879958b202 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jqcWY-00035R-VK; Wed, 01 Jul 2020 13:11:38 +0000
Date:   Wed, 01 Jul 2020 21:10:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:pci/msi] BUILD SUCCESS
 30ff3e8c287455e9f7f85162df10d62819ba42a9
Message-ID: <5efc8b55.tKCsvnFq3wxD0a/N%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git  pci/msi
branch HEAD: 30ff3e8c287455e9f7f85162df10d62819ba42a9  PCI/MSI: Forward MSI-X error code in pci_alloc_irq_vectors_affinity()

elapsed time: 726m

configs tested: 109
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                               allnoconfig
arm64                            allyesconfig
arm64                               defconfig
arm64                            allmodconfig
arm64                             allnoconfig
sh                          sdk7780_defconfig
m68k                          amiga_defconfig
arm                         lpc32xx_defconfig
m68k                            mac_defconfig
arm                            dove_defconfig
mips                          ath79_defconfig
alpha                            alldefconfig
arc                         haps_hs_defconfig
powerpc                    gamecube_defconfig
arm                           tegra_defconfig
arm                         orion5x_defconfig
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
nios2                               defconfig
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
sh                                allnoconfig
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
i386                 randconfig-a002-20200701
i386                 randconfig-a001-20200701
i386                 randconfig-a006-20200701
i386                 randconfig-a005-20200701
i386                 randconfig-a004-20200701
i386                 randconfig-a003-20200701
x86_64               randconfig-a012-20200701
x86_64               randconfig-a016-20200701
x86_64               randconfig-a014-20200701
x86_64               randconfig-a011-20200701
x86_64               randconfig-a015-20200701
x86_64               randconfig-a013-20200701
i386                 randconfig-a011-20200701
i386                 randconfig-a015-20200701
i386                 randconfig-a016-20200701
i386                 randconfig-a012-20200701
i386                 randconfig-a013-20200701
i386                 randconfig-a014-20200701
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
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
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
