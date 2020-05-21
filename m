Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B042C1DC6FE
	for <lists+linux-pci@lfdr.de>; Thu, 21 May 2020 08:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbgEUGXT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 May 2020 02:23:19 -0400
Received: from mga02.intel.com ([134.134.136.20]:46384 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726506AbgEUGXS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 May 2020 02:23:18 -0400
IronPort-SDR: kzeXO1DoqxVAoW7VnzdT1K92n0nAX2Tds1sblzCOIVj/ty6rPJnlJerYmeIe7IMemFuA3vpyZ6
 PUHVuQSjfang==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2020 23:23:17 -0700
IronPort-SDR: DQKEH6E/UWsdh4a3c02cjC7wPSXf2wsbivSGn56TzXK3Oc4J13nzqw4HQi4I/8YnbD9Igx5Qji
 grrJ466o7KHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,416,1583222400"; 
   d="scan'208";a="466792396"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 20 May 2020 23:23:16 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jbebr-0006yt-RY; Thu, 21 May 2020 14:23:15 +0800
Date:   Thu, 21 May 2020 14:22:37 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:pci/enumeration] BUILD SUCCESS
 5a2f8874084ce3df029c0c50202191c88449474e
Message-ID: <5ec61e2d.oWDQPZz7izKGtu5F%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git  pci/enumeration
branch HEAD: 5a2f8874084ce3df029c0c50202191c88449474e  pcmcia: Use CardBus window names (PCI_CB_BRIDGE_IO_0_WINDOW etc) when freeing

elapsed time: 480m

configs tested: 101
configs skipped: 2

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
sparc                            allyesconfig
mips                             allyesconfig
m68k                             allyesconfig
arm                         shannon_defconfig
arm                            zeus_defconfig
riscv                            alldefconfig
arm                        multi_v5_defconfig
microblaze                      mmu_defconfig
arm                     eseries_pxa_defconfig
riscv                    nommu_virt_defconfig
powerpc                     mpc83xx_defconfig
arm                          imote2_defconfig
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
i386                 randconfig-a001-20200520
i386                 randconfig-a004-20200520
i386                 randconfig-a006-20200520
i386                 randconfig-a003-20200520
i386                 randconfig-a002-20200520
i386                 randconfig-a005-20200520
i386                 randconfig-a013-20200520
i386                 randconfig-a012-20200520
i386                 randconfig-a015-20200520
i386                 randconfig-a011-20200520
i386                 randconfig-a016-20200520
i386                 randconfig-a014-20200520
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
s390                                defconfig
x86_64                              defconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
um                               allmodconfig
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
