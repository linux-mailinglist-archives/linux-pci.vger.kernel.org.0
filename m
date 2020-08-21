Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0F0C24D188
	for <lists+linux-pci@lfdr.de>; Fri, 21 Aug 2020 11:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbgHUJcL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Aug 2020 05:32:11 -0400
Received: from mga04.intel.com ([192.55.52.120]:57753 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727901AbgHUJcK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 21 Aug 2020 05:32:10 -0400
IronPort-SDR: VqVT45ox0kvkQjn9mce2GlLJ3/tHbf23GlUJhIfdATzxo42JTYxxxjth8lm042N8y5dtW1PQ5+
 jzE2AZ7tE08w==
X-IronPort-AV: E=McAfee;i="6000,8403,9719"; a="152908701"
X-IronPort-AV: E=Sophos;i="5.76,335,1592895600"; 
   d="scan'208";a="152908701"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2020 02:32:07 -0700
IronPort-SDR: 4/asOKBASw05GApqtbThskvUN99D8qhkz7JkdAPHkunvQwP/WmX1JGlLmopI6PZFXmgsEiONbF
 /n1v+NDImyGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,335,1592895600"; 
   d="scan'208";a="327717104"
Received: from lkp-server01.sh.intel.com (HELO 91ed66e1ca04) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 21 Aug 2020 02:32:08 -0700
Received: from kbuild by 91ed66e1ca04 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k93P4-0000rW-BC; Fri, 21 Aug 2020 09:32:06 +0000
Date:   Fri, 21 Aug 2020 17:31:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:pci/misc] BUILD SUCCESS
 c7dcf4a66551bb034094437b10b2ed43524a4a7c
Message-ID: <5f3f9465.9VxmfEfKtS2urrSC%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git  pci/misc
branch HEAD: c7dcf4a66551bb034094437b10b2ed43524a4a7c  PCI: Remove unnecessary header include (asm/setup.h)

elapsed time: 721m

configs tested: 74
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm64                               defconfig
arm64                            allyesconfig
arm                              allyesconfig
arm                              allmodconfig
mips                           ip28_defconfig
arm                            mmp2_defconfig
h8300                    h8300h-sim_defconfig
riscv                               defconfig
x86_64                           allyesconfig
mips                        bcm47xx_defconfig
powerpc                        cell_defconfig
m68k                       m5275evb_defconfig
arm                        keystone_defconfig
s390                             alldefconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
sparc                               defconfig
i386                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
powerpc                             defconfig
i386                 randconfig-a002-20200820
i386                 randconfig-a004-20200820
i386                 randconfig-a005-20200820
i386                 randconfig-a003-20200820
i386                 randconfig-a006-20200820
i386                 randconfig-a001-20200820
x86_64               randconfig-a015-20200820
x86_64               randconfig-a012-20200820
x86_64               randconfig-a016-20200820
x86_64               randconfig-a014-20200820
x86_64               randconfig-a011-20200820
x86_64               randconfig-a013-20200820
i386                 randconfig-a013-20200820
i386                 randconfig-a012-20200820
i386                 randconfig-a011-20200820
i386                 randconfig-a016-20200820
i386                 randconfig-a014-20200820
i386                 randconfig-a015-20200820
riscv                            allyesconfig
riscv                             allnoconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
