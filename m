Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF88A2E2E96
	for <lists+linux-pci@lfdr.de>; Sat, 26 Dec 2020 17:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbgLZQET (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 26 Dec 2020 11:04:19 -0500
Received: from mga05.intel.com ([192.55.52.43]:28750 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725995AbgLZQET (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 26 Dec 2020 11:04:19 -0500
IronPort-SDR: c09o8mtr3U4SwD0iRkRrgH2JETMOofpm9O8zBD3T4Zl5g4cOa+FV7yfO8oNWJUFyZxfliU5LnA
 XCu9Dl1BguAQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9846"; a="261009908"
X-IronPort-AV: E=Sophos;i="5.78,451,1599548400"; 
   d="scan'208";a="261009908"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2020 08:03:38 -0800
IronPort-SDR: IY2xld2jSTm22jyOFauNaw6dmhvA3cRtVV7BT/c5afZ//WxY07MRTXGnhyxrKo8jRLfQJPzvfS
 pB3OS2VXym2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,451,1599548400"; 
   d="scan'208";a="343248220"
Received: from lkp-server02.sh.intel.com (HELO 4242b19f17ef) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 26 Dec 2020 08:03:36 -0800
Received: from kbuild by 4242b19f17ef with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1ktC2a-00024y-2L; Sat, 26 Dec 2020 16:03:36 +0000
Date:   Sun, 27 Dec 2020 00:03:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:for-linus] BUILD SUCCESS
 99e629f14b471d852d28ecf554093c4730ed0927
Message-ID: <5fe75ec5.WoOnMc42vPB4tGEF%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git  for-linus
branch HEAD: 99e629f14b471d852d28ecf554093c4730ed0927  PCI: dwc: Fix inverted condition of DMA mask setup warning

elapsed time: 721m

configs tested: 90
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
m68k                            q40_defconfig
mips                     decstation_defconfig
arm                         vf610m4_defconfig
sh                           se7780_defconfig
nds32                            alldefconfig
m68k                          hp300_defconfig
arm                          gemini_defconfig
powerpc                          g5_defconfig
arm                           h5000_defconfig
arm                       spear13xx_defconfig
arm                          moxart_defconfig
m68k                         apollo_defconfig
sh                         apsh4a3a_defconfig
arc                 nsimosci_hs_smp_defconfig
arm                           efm32_defconfig
sh                          rsk7203_defconfig
sh                             espt_defconfig
h8300                    h8300h-sim_defconfig
xtensa                              defconfig
arm                          collie_defconfig
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
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a005-20201226
i386                 randconfig-a002-20201226
i386                 randconfig-a006-20201226
i386                 randconfig-a004-20201226
i386                 randconfig-a003-20201226
i386                 randconfig-a001-20201226
x86_64               randconfig-a015-20201226
x86_64               randconfig-a014-20201226
x86_64               randconfig-a016-20201226
x86_64               randconfig-a012-20201226
x86_64               randconfig-a013-20201226
x86_64               randconfig-a011-20201226
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a001-20201226
x86_64               randconfig-a006-20201226
x86_64               randconfig-a004-20201226
x86_64               randconfig-a002-20201226
x86_64               randconfig-a003-20201226
x86_64               randconfig-a005-20201226

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
