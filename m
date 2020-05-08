Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 793341CA1F1
	for <lists+linux-pci@lfdr.de>; Fri,  8 May 2020 06:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725681AbgEHEQ5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 May 2020 00:16:57 -0400
Received: from mga02.intel.com ([134.134.136.20]:3336 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725550AbgEHEQ5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 May 2020 00:16:57 -0400
IronPort-SDR: QBaWw4XGr9S8zB9NLQBPzZ3/s7cNIxWv6x5Dc1oiLAhOac3OsUmFXYMynTd8gZH6bDr+Sfqlt3
 8wmkFAs67VWQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2020 21:16:56 -0700
IronPort-SDR: idjzT/XPJk8Ex/Eikferyni6x+Sdu6NxZNaTY0KPhsrNzPxPX3IyJw11fcetiaJMR9FTxlpmmt
 L5ksYO+IKm2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,366,1583222400"; 
   d="scan'208";a="251715942"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 07 May 2020 21:16:55 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jWuRS-000I7c-DL; Fri, 08 May 2020 12:16:54 +0800
Date:   Fri, 08 May 2020 12:16:46 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:pci/misc] BUILD SUCCESS
 a88f8c176147d9778330082fcc34b7107da756aa
Message-ID: <5eb4dd2e.Bp9dtEeh55n8nlrF%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git  pci/misc
branch HEAD: a88f8c176147d9778330082fcc34b7107da756aa  PCI: Replace zero-length array with flexible-array

Warning in current branch:

drivers/pci/controller/dwc/pcie-tegra194.c:2194:2-9: line 2194 is redundant because platform_get_irq() already prints an error

Warning ids grouped by kconfigs:

recent_errors
`-- x86_64-allyesconfig
    `-- drivers-pci-controller-dwc-pcie-tegra194.c:line-is-redundant-because-platform_get_irq()-already-prints-an-error

elapsed time: 484m

configs tested: 101
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
sparc                            allyesconfig
m68k                             allyesconfig
mips                             allmodconfig
sh                                allnoconfig
sparc64                             defconfig
c6x                              allyesconfig
sparc                               defconfig
riscv                            allyesconfig
m68k                                defconfig
sh                               allmodconfig
openrisc                            defconfig
parisc                           allyesconfig
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
nios2                               defconfig
nios2                            allyesconfig
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
microblaze                       allyesconfig
microblaze                        allnoconfig
mips                             allyesconfig
mips                              allnoconfig
parisc                            allnoconfig
parisc                              defconfig
parisc                           allmodconfig
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20200507
x86_64               randconfig-a006-20200507
x86_64               randconfig-a002-20200507
i386                 randconfig-a005-20200507
i386                 randconfig-a004-20200507
i386                 randconfig-a001-20200507
i386                 randconfig-a002-20200507
i386                 randconfig-a003-20200507
i386                 randconfig-a006-20200507
x86_64               randconfig-a015-20200507
x86_64               randconfig-a014-20200507
x86_64               randconfig-a012-20200507
x86_64               randconfig-a013-20200507
x86_64               randconfig-a011-20200507
x86_64               randconfig-a016-20200507
i386                 randconfig-a012-20200507
i386                 randconfig-a016-20200507
i386                 randconfig-a014-20200507
i386                 randconfig-a011-20200507
i386                 randconfig-a015-20200507
i386                 randconfig-a013-20200507
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
s390                                defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
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
