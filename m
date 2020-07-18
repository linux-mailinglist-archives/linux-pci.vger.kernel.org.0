Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57DC7224B44
	for <lists+linux-pci@lfdr.de>; Sat, 18 Jul 2020 15:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbgGRNBH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 18 Jul 2020 09:01:07 -0400
Received: from mga07.intel.com ([134.134.136.100]:59794 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726569AbgGRNBG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 18 Jul 2020 09:01:06 -0400
IronPort-SDR: BTX3i52iHQp+WbwTt0uXtycjt90h9kC0SQlnTW6WAYVrWCiRc01O5t5BPUYVYdZNlQFxsEniaB
 QqWogrEZ76Tg==
X-IronPort-AV: E=McAfee;i="6000,8403,9685"; a="214438408"
X-IronPort-AV: E=Sophos;i="5.75,367,1589266800"; 
   d="scan'208";a="214438408"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2020 06:01:06 -0700
IronPort-SDR: 6L1ixWrkycbT84OYt82J8g0tVXTMocxUtbM3cVQXd2DOGGR/Oz4KeFIoAgQadtjIZET1JJ5sOU
 AS9HrVQ1OTTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,367,1589266800"; 
   d="scan'208";a="486742215"
Received: from lkp-server02.sh.intel.com (HELO 50058c6ee6fc) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 18 Jul 2020 06:01:04 -0700
Received: from kbuild by 50058c6ee6fc with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jwmSe-0000mw-2I; Sat, 18 Jul 2020 13:01:04 +0000
Date:   Sat, 18 Jul 2020 20:59:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:pci/error] BUILD SUCCESS
 0cf95f6f68b954433f9182bd5278defc89b14dce
Message-ID: <5f12f236.AqES0sDBHr0BDaXG%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git  pci/error
branch HEAD: 0cf95f6f68b954433f9182bd5278defc89b14dce  PCI/ERR: Clear PCIe Device Status errors only if OS owns AER

elapsed time: 937m

configs tested: 83
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
nds32                             allnoconfig
powerpc                      ppc64e_defconfig
arm                           viper_defconfig
ia64                             alldefconfig
sh                           se7721_defconfig
h8300                            allyesconfig
powerpc                 linkstation_defconfig
sparc                       sparc32_defconfig
arm                          badge4_defconfig
powerpc                      pmac32_defconfig
riscv                          rv32_defconfig
i386                             allyesconfig
i386                                defconfig
i386                              debian-10.3
i386                              allnoconfig
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
csky                             allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
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
powerpc                          allyesconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
powerpc                             defconfig
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
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                                   rhel
x86_64                                    lkp
x86_64                              fedora-25

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
